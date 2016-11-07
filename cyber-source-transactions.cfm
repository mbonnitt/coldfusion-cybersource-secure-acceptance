<cfscript>	
<!---
	The following functions are for credit card transactions.
--->

/*------------------------------------------------------------------ 

	sign(PARAMS, PROFILE)
	
	Returns the signed data.
	
--------------------------------------------------------------------*/
	function sign(params, profile) {
		return signData(buildDataToSign(params), getSecretKey(profile));
	}
	
/*------------------------------------------------------------------ 

	signData(DATA, SECRETKEY)
	
	Encrypts the data.
	
--------------------------------------------------------------------*/
	
	function signData(data, secretKey) {
		algorithm = "HmacSHA256";
		encoding  = "utf-8";
		secret = createObject('java',"javax.crypto.spec.SecretKeySpec").init(charsetDecode(secretKey,encoding), algorithm);
		mac = createObject('java',"javax.crypto.Mac").getInstance(algorithm);
		mac.init(secret);
		digest = mac.doFinal( charsetDecode(data,encoding) );
		return binaryEncode(digest, 'base64');	
	}
	
/*------------------------------------------------------------------ 

	buildDataToSign(PARAMS)
	
	Returns the signed data in a comma-separated list/string.
	
--------------------------------------------------------------------*/
	
	function buildDataToSign(params) {
		dataToSign = [];
		signedFieldNames = ListToArray(params["signed_field_names"], ",");
		for(i=1; i <= ArrayLen(signedFieldNames); i++){
			data = signedFieldNames[i]&"="&params[signedFieldNames[i]];
			ArrayAppend(dataToSign, data);
		}
		return ArrayToList(dataToSign, ",");
	}
	
/*------------------------------------------------------------------ 

	createVendorVars(FORM_NAME, PROFILE[, SIGN_DATA])
	
	Creates variables needed by CyberSource to process transactions. 
	
--------------------------------------------------------------------*/
	
	function createVendorVars(form_name, profile){
			var access_key = '';
			var profile_id = '';
			var cs_var_number = 6;
			var key_value_list = '';
			// non-generic variables accepted by CS
			var cs_accepted_var_list = "access_key,amount,bill_to_forename,bill_to_surname,bill_to_address_line1,bill_to_address_line2,bill_to_address_city,bill_to_address_state,bill_to_address_postal_code,bill_to_address_country,bill_to_email,bill_to_phone,card_number,card_cvn,card_expiry_date,card_type,currency,locale,payment_method,profile_id,recurring_amount,recurring_frequency,recurring_number_of_installments,recurring_start_date,reference_number,ship_to_forename,ship_to_surname,ship_to_address_line1,ship_to_address_line2,ship_to_address_city,ship_to_address_state,ship_to_address_postal_code,ship_to_address_country,ship_to_phone,signed_date_time,signed_field_names,unsigned_field_names,signature,transaction_type,transaction_uuid";	
			var ignore_list = "card_expiry_month,card_expiry_year,fieldnames,validate,submit";		
			var form_list = ListSort(StructKeyList(form), 'textnocase', 'asc');
			var form_array = ListToArray(form_list, ',');
			var form_length = ArrayLen(form_array);	
			var sign_data = 'true';
			if(ArrayLen(ARGUMENTS) > 2) sign_data = ARGUMENTS[3];
			for(i=1; i<=form_length; i++){
				// keep variable name accepted by CS
				if(ListFind(cs_accepted_var_list, LCase(form_array[i])) != 0){
					cs_var[LCase(form_array[i])] = form[form_array[i]];				
				// change variable name unaccepted by CS
				}else if(ListFind(ignore_list, LCase(form_array[i])) == 0){
					// for variables with too many characters (100+)
					if(Len(form[form_array[i]]) > 100){
						text = REReplace(form[form_array[i]], '[#chr(10)##chr(13)#]', '`', 'all');	
						repeat_var = cs_var_number;				
						key_value = cs_var_number&'='&LCase(form_array[i]);		
						// save key and value to a list, so we can access it later
						key_value_list = ListAppend(key_value_list, key_value, ',');
						// truncate text to 100 characters and place generic variables
						while(Len(text)){				
							cut_text = mid(text, 1, 100);	
							cs_var['merchant_defined_data'&cs_var_number] = cut_text; 
							text = replace(text, cut_text, ''); 
							// for future text, save key as previous cs_var_number to show 
							// text is a continuation and save space								
							if(repeat_var != cs_var_number){
								key_value = cs_var_number&'='&LCase(repeat_var);	 
								key_value_list = ListAppend(key_value_list, key_value, ',');				
							}
							cs_var_number++;
						}
					// for variables smaller than 100 characters
					} else {
						// CS doesn't accept "" so, add blank identifer
						if(form[form_array[i]] == ""){
							cs_var['merchant_defined_data'&cs_var_number] = "__";	
						// otherwise, just save the value					
						} else {
							cs_var['merchant_defined_data'&cs_var_number] = form[form_array[i]];
						}
						key_value = cs_var_number&'='&LCase(form_array[i]);
						key_value_list = ListAppend(key_value_list, key_value, ',');				
						cs_var_number++;
					}					
				}
			}
			cs_var.merchant_secure_data4 = key_value_list;
			cs_var.merchant_defined_data5 = form_name;
			switch(LCase(profile)){
				// data removed for security purposes
				case 'PROFILE':
					access_key = 'ACCESS KEY';
					profile_id = 'PROFILE ID';
					break;
			}
			if(!StructKeyExists(form, 'bill_to_email') && StructKeyExists(form, 'ship_to_email')){
				cs_var.bill_to_email = form.ship_to_email;
			}
			if(!StructKeyExists(form, 'bill_to_phone') && StructKeyExists(form, 'ship_to_phone')){
				cs_var.bill_to_phone = form.ship_to_phone;
			}
			cs_var.access_key = access_key;
			cs_var.currency = 'USD';
			cs_var.locale = 'en';
			cs_var.profile_id = profile_id;			
			cs_var.payment_method = 'card';
			cs_var.signed_date_time = getIsoTimeString();
			cs_var.signed_field_names = '';
			cs_var.transaction_type = 'sale';
			if(StructKeyExists(form, 'recurring_amount') && StructKeyExists(form, 'recurring_frequency')){
				cs_var.transaction_type = 'create_payment_token';
			}
			cs_var.transaction_uuid = CreateUUID();
			cs_var.unsigned_field_names = 'card_type,card_number,card_expiry_date';
			if(StructKeyExists(form, 'card_expiry_month') && StructKeyExists(form, 'card_expiry_year')){
				cs_var.card_expiry_date = form.card_expiry_month &'-'& form.card_expiry_year;
			}			
			cs_var_array = StructKeyArray(cs_var);				
			ArraySort(cs_var_array, 'textnocase', 'asc');	
			cs_var_array_length = ArrayLen(cs_var_array);					
			for(i=1; i<=cs_var_array_length; i++){
				if(cs_var_array[i] != 'card_number' && cs_var_array[i] != 'card_expiry_date' && cs_var_array[i] != 'card_type'){
					cs_var.signed_field_names = listAppend(cs_var.signed_field_names, LCase(cs_var_array[i]), ',');
				}
			}
			if(sign_data == 'true') cs_var.signature = sign(cs_var, LCase(profile));
		}

/*------------------------------------------------------------------ 

	sendVars(DATA)
	
	Creates the hidden inputs for transmitting variables from
	createVendorVars() to CyberSource.
	
--------------------------------------------------------------------*/
		
	function sendVars(data){
		var field = '';
		var the_list = StructKeyList(data);
		var the_array = ListToArray(ListSort(the_list, 'textnocase', 'asc'));
		var length =  ListLen(the_list);				
		for(i=1; i<=length; i++){
			field &= '<input type="hidden" name="'&LCase(the_array[i])&'" value="'&data[the_array[i]]&'">'& chr(10);
		}
		WriteOutput(field);
	}
	
/*------------------------------------------------------------------ 

	createReturnedVendorVars(DATA)
	
	Recreates form variables from CyberSource-returned variables,
	so you can use regular variable names with confirmation page.
	
--------------------------------------------------------------------*/
	
	function createReturnedVendorVars(){
		// CS returned variables have req_ appended 
		var cs_returned_var_list = "req_amount,req_bill_to_forename,req_bill_to_surname,req_bill_to_address_line1,req_bill_to_address_line2,req_bill_to_address_city,req_bill_to_address_state,req_bill_to_address_postal_code,req_bill_to_address_country,req_bill_to_email,req_bill_to_phone,card_number,card_cvn,card_expiry_date,card_type,req_ship_to_forename,req_ship_to_surname,req_ship_to_address_line1,req_ship_to_address_line2,req_ship_to_address_city,req_ship_to_address_state,req_ship_to_address_postal_code,req_ship_to_address_country,req_ship_to_email,req_ship_to_phone,amount,access_key,profile_id,transaction_uuid,signed_date_time,locale,payment_method,transaction_type,signed_field_names,unsigned_field_names,signature,req_reference_number";
		var cs_returned_var_array = ListToArray(cs_returned_var_list, ',');	
		var key_value = '';
		var key_list = 'merchant_secure_data4';
		var merchant_data = 'merchant_defined_data';
		// check if the results are from CS transaction		
		if(StructKeyExists(form, 'req_merchant_secure_data4')){
			key_list = 'req_' & key_list;
			merchant_data = 'req_' & merchant_data;
		}
		key_value_array = ListToArray(form[key_list], ',');		
		kv_length = ArrayLen(key_value_array);
		rv_length = ListLen(cs_returned_var_list, ',');
		// remove req_ from the variables returned by CS
		if(StructKeyExists(form, 'req_merchant_secure_data4')){
			for(i=1; i<=rv_length; i++){
				if(StructKeyExists(form, cs_returned_var_array[i])){
					form[ReplaceNoCase(cs_returned_var_array[i], 'req_', '')] = form[cs_returned_var_array[i]];
				}
			}
		}		
		old_value = 'returned_vendor_vars_error_var';
		// reconstruct old form variable names
		for(i=1; i<=kv_length; i++){
			key_value = ListToArray(key_value_array[i], '=');
			key = key_value[1]; 
			value = key_value[2];
			// for long values that were split among CS variables
			if(!isValid('integer', value)){
				old_value = value;
			}
			if(form[merchant_data&key] == "_blank_"){
				form[value] = '';
			}else{				
				if(isValid('integer', value)){
					form[old_value] &= Replace(form[merchant_data&key], '`', '<br />', 'all');
				} else {
					form[value] = form[merchant_data&key];
				}							
			}	
		}
	}
	
/*------------------------------------------------------------------ 

	getIsoTimeString()
	
	Creates iso time string for CyberSource transactions. 
	
--------------------------------------------------------------------*/
	
	function getIsoTimeString(){
		datetime = dateConvert( "local2utc", now() );
		return(dateFormat(datetime, "yyyy-mm-dd") & "T" & timeFormat(datetime, "HH:mm:ss") & "Z");
	}
	
/*------------------------------------------------------------------ 

	validateDollarAmount(AMOUNT[, CC])
	
	Returns an error message if amount isn't a valid dollar amount.
	
--------------------------------------------------------------------*/
	
	function validateDollarAmount(amount){
		var error = '';
		var cc = form;
		if(ArrayLen(ARGUMENTS) > 1) cc = ARGUMENTS[2];
		cc[amount] = Replace(cc[amount], ',', '', 'all');
		cc[amount] = Replace(cc[amount], '$', '', 'all');
		if(!isValid('regex', cc[amount], '^[0-9]+(\.[0-9][0-9])?$')){
			error &= ' The gift amount is invalid.';
		}
		return error;
	}
	
/*------------------------------------------------------------------ 

	validateRequiredFields(FIELDS[, THESTRUCT])
	
	Returns error list if fields are blank.
	
--------------------------------------------------------------------*/
	
	function validateRequiredFields(fields){
		var errors = ArrayNew(1);
		var errorLen = '';
		var fieldsLen = '';
		var theStruct = form;
		fields = ListToArray(fields);
		fieldsLen = ArrayLen(fields);
		if(ArrayLen(ARGUMENTS) > 1 && ARGUMENTS[2] != '') theStruct = ARGUMENTS[2];
		for(i=1; i<=fieldsLen; i++){
			if(!StructKeyExists(theStruct, fields[i]) || Replace(theStruct[fields[i]], ' ', '', 'all') == ''){
				ArrayAppend(errors, fields[i]&' is blank.');
			}
		}
		return ArrayToList(errors, '`');
	}
	
/*------------------------------------------------------------------ 

	validateFileUpload(FILENAME[, ACCEPTEDFILETYPES, ACCEPTEDFILESIZE])
	
	Returns error list if uploaded file is wrong type or size.
	
--------------------------------------------------------------------*/
	
	function validateFileUpload(filename){
		var errors = ArrayNew(1);
		var errorLen = '';
		var field = '';
		var acceptedFileTypes = 'png,jpg,gif';
		var acceptedFileSize = 5 * 1024 * 1024;
		if(ArrayLen(ARGUMENTS) > 1 && ARGUMENTS[2] != '') acceptedFileTypes = ARGUMENTS[2];
		if(ArrayLen(ARGUMENTS) > 2 && ARGUMENTS[3] != '') acceptedFileSize = ARGUMENTS[3];
		if(StructKeyExists(form, filename)){
			if(!ListFindNoCase(acceptedFileTypes, cffile.ServerFileExt)){
				ArrayAppend(errors, 'file type '&UCase(cffile.ServerFileExt)&' is not an acceptable format. Please use '&UCase(Replace(acceptedFileTypes,',',', ','all'))&'.');
			}
			if(cffile.FileSize > acceptedFileSize){
				ArrayAppend(errors, cffile.ServerFile&' exceeds the max file size of '&acceptedFileSize/1024/1024&' MB.');
			}
		} else {
			ArrayAppend(errors, 'no file');
		}
		errorLen = ArrayLen(errors);
		if(errorLen){
			try { FileDelete(cffile.ServerDirectory&'\'&cffile.ServerFile); }
			catch(any e){;}
		}
		return ArrayToList(errors, '`');
	}
	
/*------------------------------------------------------------------ 

	validateCreditCardFields([CC, CC_CHECK])
	
	Returns error messages for billing information. 
	
--------------------------------------------------------------------*/
	
	function validateCreditCardFields(){
		var errors = ArrayNew(1);
		var errorLen = '';
		var nowDate = Now();
		var cc = form;
		var cc_check = true;
		if(ArrayLen(ARGUMENTS) > 0) cc=ARGUMENTS[1];
		if(ArrayLen(ARGUMENTS) > 1) cc_check=ARGUMENTS[2];

		if(cc.bill_to_forename == '') ArrayAppend(errors, 'first name');
		if(cc.bill_to_surname == '') ArrayAppend(errors, 'last name');
		if(cc.bill_to_address_line1 == '') ArrayAppend(errors, 'address');
		if(cc.bill_to_address_city == '') ArrayAppend(errors, 'city');
		if(cc.bill_to_address_state == '') ArrayAppend(errors, 'state');
		if(!isValid('zipcode', cc.bill_to_address_postal_code)) ArrayAppend(errors, 'zip code');
		if(cc.bill_to_address_country == '') ArrayAppend(errors, 'country');
		if(!isValid('email', cc.bill_to_email)) ArrayAppend(errors, 'email');
		if(cc_check){
			if(cc.card_type == '') ArrayAppend(errors, 'credit card type');
			if(cc.card_type == '' && cc.card_cvn == '') ArrayAppend(errors, 'card verification number');
			if( (cc.card_type == '001') ||
				(cc.card_type == '002') ||
				(cc.card_type == '004') ){
					if(!isValid('regex', cc.card_cvn, '[0-9]{3}')) 
						ArrayAppend(errors, 'card verification number (CVN) &mdash; three digits for Visa, Mastercard and Discover cards.');
			}
			if(cc.card_type == '003'){
				if(!isValid('regex', cc.card_cvn, '[0-9]{4}'))  
					ArrayAppend(errors, 'card verification number (CVN) &mdash; four digits for American Express cards');
			}
			if(!isValid('creditcard', cc.card_number)) ArrayAppend(errors, 'credit card number');
			if(cc.card_expiry_month == '') ArrayAppend(errors, 'month of expiration');
			if(cc.card_expiry_year == '') ArrayAppend(errors, 'year of expiration');
			if(cc.card_expiry_year == Year(nowDate) && cc.card_expiry_month < Month(nowDate)) 
				ArrayAppend(errors, 'card is expired');
		}		
		return ArrayToList(errors, '`');
	}
	
/*------------------------------------------------------------------ 

	getErrorMessage(ERRORS)
	
	Returns list of errors. 
	
--------------------------------------------------------------------*/
	
	function getErrorMessage(errors){
		var field = '';
		var errorLen = '';
		errors = ListToArray(errors, '`');
		errorLen = ArrayLen(errors);
		field &= '<p>Please <a href="javascript:history.back(-1)">go back</a> and make a valid selection for the following field(s):</p><ul>';
		for(i=1; i<=errorLen; i++){
			formattedError = errors[i];
			formattedError = REReplace(formattedError, '[_-]', ' ', 'all');
			formattedError = REReplace(formattedError, '\(?[A-Z]+\)?', ' \0', 'all');
			formattedError = REReplace(formattedError, '[a-z]\s[A-Z]', '\L\0', 'all');			
			formattedError = REReplace(formattedError, '\b(\w)', '\u\1', 'one');
			formattedError = REReplace(formattedError, '\.\s*[a-z]', '\U\0', 'one');	
			field &= '<li>'&formattedError&'</li>';
		}
		field &= '</ul>';
		return field;
	}		

/*------------------------------------------------------------------ 

	getDeclinedInfo()
	
	Returns list of reasons why credit card was declined.
	Never put into production; may need more testing.
	
--------------------------------------------------------------------*/
	
	function getDeclinedInfo(){
		var reason = '';
		var field = '';
		switch(form.reason_code){
			case '100':
				reason = 'Successful transaction.';
				break;
			case '102':
				reason = 'One or more fields in the request contain invalid data.';
				break;
			case '104':
				reason = 'The unique transaction ID for this authorization request matches the unique transaction ID of another authorization request that you sent within the past 15 minutes. Please either wait 15 minutes and resubmit your form from the <a href="javascript:history.go(-2)">verification page</a>, or recomplete the form in full.';
				break;
			case '110':
				reason = 'Only a partial amount was approved.';
				break;
			case '200':
				reason = 'The authorization request was approved by the issuing bank but declined by CyberSource because it did not pass the Address Verification System (AVS) check.';
				break;
			case '201':
				reason = 'The issuing bank has questions about the request. You do not receive an authorization code programmatically, but you might receive one verbally by calling the processor.';
				break;
			case '202':
				reason = 'Expired card. You might also receive this value if the expiration date you provided does not match the date the issuing bank has on file.';
				break;
			case '203':
				reason = 'General decline of the card. No other information was provided by the issuing bank.';
				break;
			case '204':
				reason = 'Insufficient funds in the account.';
				break;
			case '205':
				reason = 'Stolen or lost card.';
				break;
			case '207':
				reason = 'Issuing bank unavailable.';
				break;
			case '208':
				reason = 'Inactive card or card not authorized for card-not-present transactions.';
				break;
			case '210':
				reason = 'The card has reached the credit limit.';
				break;
			case '211':
				reason = 'Invalid CVN.';
				break;
			case '221':
				reason = 'The customer matched an entry on the processor’s negative file.';
				break;
			case '222':
				reason = 'Account frozen.';
				break;
			case '230':
				reason = 'The authorization request was approved by the issuing bank but declined by CyberSource because it did not pass the CVN check.';
				break;
			case '231':
				reason = 'Invalid account number.';
				break;
			case '232':
				reason = 'The card type is not accepted by the payment processor.';
				break;
			case '233':
				reason = 'General decline by the processor.';
				break;
			case '234':
				reason = 'There is a problem with the information in your CyberSource account.';
				break;
			case '236':
				reason = 'Processor failure.';
				break;
			case '240':
				reason = 'The card type sent is invalid or does not correlate with the credit card number.';
				break;
			case '475':
				reason = 'The cardholder is enrolled for payer authentication.';
				break;
			case '476':
				reason = 'Payer authentication could not be authenticated.';
				break;
			case '520':
				reason = 'The authorization request was approved by the issuing bank but declined by CyberSource based on your Decision Manager settings.';
				break;
			default:
				reason = 'There was a problem submitting your credit card information. Please <a href="javascript: history.go(-3)">go back</a> and try again.';
		}
		field = '<h2>Declined</h2>';
		field &= '<p>'&reason&'</p>';
		if(StructKeyExists(form, 'message')) field &= '<p>'&form.message&'</p>';
		if(StructKeyExists(form, 'invalid_fields')) field &= '<p>'&form.invalid_fields&'</p>';
	}
	
			
/*------------------------------------------------------------------ 

	randomNumber(NUMBCHARS, USELOWER, USEUPPER, USESYMBOLS, USENUMBERS)
	
	Creates a random string. Used for creating tracking IDs. 
	
--------------------------------------------------------------------*/
	
	function randomNumber(numbChars,useLower,useUpper,useSymbols,useNumbers){
		var Symbols = "33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,58,59,60,61,62,63,64,91,92,93,94,95,96,123,124,125,126";
		var Numbers = "48,49,50,51,52,53,54,55,56,57";
		var lowerCase = "97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122";
		var upperCase = "65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90";
		var randomPassword = "";
		var charList = "";
		if (useLower EQ "Y") charList = listAppend ( charList, lowerCase, "," );		
		if (useUpper EQ "Y") charList = listAppend ( charList, upperCase, "," );			
		if (useSymbols EQ "Y") charList = listAppend ( charList, Symbols, "," );					
		if (useNumbers EQ "Y") charList = listAppend ( charList, Numbers, "," );			
		listLength = listLen ( charList );			
		if (listLength GT 0){
			for (i = 1; i LTE numbChars; i = i + 1){
				getPosition = randRange ( 1, listLength );	
				Character = listGetAt ( charList, getPosition, "," );
				randomPassword = randomPassword & CHR ( Character );
			}
			randomPassword = randomPassword;
		} else {
			randomPassword = "failed";
		}			
		return randomPassword;
	}
</cfscript> 
