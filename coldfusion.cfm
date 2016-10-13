/*------------------------------------------------------------------ 

	createVendorVars(FORM_NAME, PROFILE[, SIGN_DATA])
	
	Creates variables needed by CyberSource to process transactions. 
	
--------------------------------------------------------------------*/
	
	function createVendorVars(form_name, profile){
			var access_key = '';
			var profile_id = '';
			var n = 6;
			var key_value_list = '';
			var cs_accepted_var_list = "access_key,amount,bill_to_forename,bill_to_surname,bill_to_address_line1,bill_to_address_line2,bill_to_address_city,bill_to_address_state,bill_to_address_postal_code,bill_to_address_country,bill_to_email,bill_to_phone,card_number,card_cvn,card_expiry_date,card_type,currency,locale,payment_method,profile_id,recurring_amount,recurring_frequency,recurring_number_of_installments,recurring_start_date,reference_number,ship_to_forename,ship_to_surname,ship_to_address_line1,ship_to_address_line2,ship_to_address_city,ship_to_address_state,ship_to_address_postal_code,ship_to_address_country,ship_to_phone,signed_date_time,signed_field_names,unsigned_field_names,signature,transaction_type,transaction_uuid";	
			var ignore_list = "card_expiry_month,card_expiry_year,fieldnames,validate,submit";		
			var form_list = ListSort(StructKeyList(form), 'textnocase', 'asc');
			var form_array = ListToArray(form_list, ',');
			var form_length = ArrayLen(form_array);	
			var sign_data = 'true';
			if(ArrayLen(ARGUMENTS) > 2) sign_data = ARGUMENTS[3];
			for(i=1; i<=form_length; i++){
				if(ListFind(cs_accepted_var_list, LCase(form_array[i])) != 0){
					cs_var[LCase(form_array[i])] = form[form_array[i]];				
				}else if(ListFind(ignore_list, LCase(form_array[i])) == 0){
					if(Len(form[form_array[i]]) > 100){
						text = REReplace(form[form_array[i]], '[#chr(10)##chr(13)#]', '`', 'all');	
						repeat_var = n;				
						s = n&'='&LCase(form_array[i]);		
						key_value_list = ListAppend(key_value_list, s, ',');
						while(Len(text)){				
							cut_text = mid(text, 1, 100);	
							cs_var['merchant_defined_data'&n] = cut_text; 
							text = replace(text, cut_text, ''); 								
							if(repeat_var != n){
								s = n&'='&LCase(repeat_var);		
								key_value_list = ListAppend(key_value_list, s, ',');				
							}
							n++;
						}
					} else {
						if(Replace(form[form_array[i]], ' ', '', 'all') == ""){
							cs_var['merchant_defined_data'&n] = "_blank_";						
						} else {
							cs_var['merchant_defined_data'&n] = form[form_array[i]];
						}
						s = n&'='&LCase(form_array[i]);
						key_value_list = ListAppend(key_value_list, s, ',');				
						n++;
					}					
				}
			}
			cs_var.merchant_secure_data4 = key_value_list;
			cs_var.merchant_defined_data5 = form_name;
			switch(LCase(profile)){
				case 'test':
          // PROFILES WITHHELD
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
		var cs_returned_var_list = "req_amount,req_bill_to_forename,req_bill_to_surname,req_bill_to_address_line1,req_bill_to_address_line2,req_bill_to_address_city,req_bill_to_address_state,req_bill_to_address_postal_code,req_bill_to_address_country,req_bill_to_email,req_bill_to_phone,card_number,card_cvn,card_expiry_date,card_type,req_ship_to_forename,req_ship_to_surname,req_ship_to_address_line1,req_ship_to_address_line2,req_ship_to_address_city,req_ship_to_address_state,req_ship_to_address_postal_code,req_ship_to_address_country,req_ship_to_email,req_ship_to_phone,amount,access_key,profile_id,transaction_uuid,signed_date_time,locale,payment_method,transaction_type,signed_field_names,unsigned_field_names,signature,req_reference_number";
		var cs_returned_var_array = ListToArray(cs_returned_var_list, ',');	
		var key_value = '';
		var key_list = 'merchant_secure_data4';
		var merchant_data = 'merchant_defined_data';		
		if(StructKeyExists(form, 'req_merchant_secure_data4')){
			key_list = 'req_' & key_list;
			merchant_data = 'req_' & merchant_data;
		}
		key_value_array = ListToArray(form[key_list], ',');		
		kv_length = ArrayLen(key_value_array);
		rv_length = ListLen(cs_returned_var_list, ',');
		if(StructKeyExists(form, 'req_merchant_secure_data4')){
			for(i=1; i<=rv_length; i++){
				if(StructKeyExists(form, cs_returned_var_array[i])){
					form[ReplaceNoCase(cs_returned_var_array[i], 'req_', '')] = form[cs_returned_var_array[i]];
				}
			}
		}		
		old_value = 'returned_vendor_vars_error_var';
		for(i=1; i<=kv_length; i++){
			key_value = ListToArray(key_value_array[i], '=');
			key = key_value[1]; 
			value = key_value[2];
			if(!isValid('integer', value)){
				old_value = value;
			}
			if(StructKeyExists(form, merchant_data&key)){
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
	}
