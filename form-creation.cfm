<cfscript>
<!---
	The following functions were created to streamline form creation.
	Rather than changing all form pages, changes can be made globably 
	from here. 
--->	 

/*------------------------------------------------------------------
 
	capitalize(WORDS[, SCOPE])
	
	Capitalizes first letter of WORDS (string). If multiple words in 
	string, optional SCOPE (string) can be set to "all" to change the
	first letter of each word.

--------------------------------------------------------------------*/

	function capitalize(words){
		var scope = 'one';
		if(ArrayLen(ARGUMENTS) > 1) scope = ARGUMENTS[2];
		return ReReplace(words, "\b(\w)", "\u\1", scope);
	}
	
/*------------------------------------------------------------------ 

	createInputField(LABEL, ID, TYPE, REQUIRED[, CLASS, VALUE, OTHER])
	
	Creates a label and input field for a form surrounded by a div. 
	Input types include text, email, tel, and other text-based inputs
	as well as checkbox. OTHER is for any other misc. attributes.
	
--------------------------------------------------------------------*/
	
	function createInputField(label, id, type, required){
		var field = '';
		var	class = '';
		var value = '';
		var other = '';
		var argLen = ArrayLen(ARGUMENTS);
		if(argLen > 4) class=ARGUMENTS[5];
		if(argLen > 5) value=ARGUMENTS[6];
		if(argLen > 6) other=ARGUMENTS[7];
		if(LCase(required) == 'true' || LCase(required) == 'required'){ 
			required = 'required="required"';
			class &= " required";
		} else {
			required = '';
			if(LCase(type) != 'hidden'){
				if(!Find('no_star', LCase(class))){
					class &= " optional";
				}
			}
		}
		if(LCase(type) == 'checkbox' && value == ''){
			value=label;
		}
		if(LCase(class) == 'full'){
			field = "<div class='"&class&"'><input id='"&id&"' name='"&id&"' type='"&type&"' value='"&value&"' "&required&" "&other&" /><label for='"&id&"'>"&label&"</label></div>";
		} else if(LCase(type) == 'checkbox' && !Find('standard', class)){
			if(Find('ck_right', class)){
				field = "<div class='"&class&"'><label>"&label&"<input id='"&id&"' name='"&id&"' type='"&type&"' value='"&value&"' "&required&" "&other&" /></label></div>";
			} else {
				field = "<div class='"&class&"'><label><input id='"&id&"' name='"&id&"' type='"&type&"' value='"&value&"' "&required&" "&other&" />"&label&"</label></div>";
			}
		} else {
			field = "<div class='"&class&"'><label for='"&id&"'>"&label&"</label><input id='"&id&"' name='"&id&"' type='"&type&"' value='"&value&"' "&required&" "&other&" /></div>";			
		}
		return field;
	}
	
/*------------------------------------------------------------------ 

	createRadioField(VALUE, ID[, CHECKED, CLASS])
	
	Creates a label and radio input field for a form surrounded by a 
	span. Create a surrounding div manually in the HTML when using this
	function.
	
--------------------------------------------------------------------*/
	
	function createRadioField(value, id){
		var field = '';
		var	checked = '';
		var class = '';
		var label = value;
		if(ArrayLen(ARGUMENTS) > 2 && ARGUMENTS[3] != '') checked='checked';
		if(ArrayLen(ARGUMENTS) > 3) class=ARGUMENTS[4];
		if(ArrayLen(ARGUMENTS) > 4) label=ARGUMENTS[5];
		field='<span class="radio '&class&'"><label><input type="radio" name="'&id&'" value="'&value&'" '&checked&'/><span></span>'&label&'</label></span>';
		return field;
	} 

/*------------------------------------------------------------------ 

	createTextArea(LABEL, ID, REQUIRED[, CLASS, VALUE])
	
	Creates a label and textarea input surrounded by a div.
	
--------------------------------------------------------------------*/
		
	function createTextArea(label, id, required){
		var field = '';
		var class = '';
		var value = '';
		var argLen = ArrayLen(ARGUMENTS);
		if(argLen > 3) class=ARGUMENTS[4];
		if(argLen > 4) value=ARGUMENTS[5];
		if(required == 'true' || required == 'required'){ 
			required = 'required="required"';
			class &= " required";
		} else {
			required = '';
			class &= " optional";
		}
		field = '<div class="'&class&'"><label for="'&id&'">'&label&'</label><textarea name="'&id&'" id="'&id&'" '&required&'>'&value&'</textarea></div>';
		return field;
	} 
	
/*------------------------------------------------------------------ 

	createDropDownState(ID[, STATE, REQUIRED, CLASS])
	
	Creates a dropdown input for states. Used in billing. Create
	default STATE by passing two-letter code (e.g. 'MD').
	
--------------------------------------------------------------------*/
	
	function createDropDownState(id){
		var field = '';
		var state = '';				
		var required = '';
		var class = '';
		var argLen = ArrayLen(ARGUMENTS);
		if(argLen > 1) state = UCase(ARGUMENTS[2]);
		if(argLen > 2) required = ARGUMENTS[3];
		if(argLen > 3) class = ARGUMENTS[4];		
		if(LCase(required) == 'true' || LCase(required) == 'required'){ 
			required = 'required="required"';
			class &= " required";
		} else {
			required = '';
			class &= " optional";
		}
		field = '
		<div class="'&class&'">
			<label for="'&id&'">State</label>
			<select name="'&id&'" id="'&id&'" '&required&'>
				<option value="">-- Select --</option>
				<option value="AL">Alabama</option>
				<option value="AK">Alaska</option>
				<option value="AB">Alberta</option>
				<option value="AS">American Samoa</option>
				<option value="AZ">Arizona</option>
				<option value="AR">Arkansas</option>
				<option value="BC">British Columbia</option>
				<option value="CA">California</option>
				<option value="CO">Colorado</option>
				<option value="CT">Connecticut</option>
				<option value="DE">Delaware</option>
				<option value="DC">District of Columbia</option>
				<option value="FM">Fed St of Micronesia</option>
				<option value="FL">Florida</option>
				<option value="GA">Georgia</option>
				<option value="GU">Guam</option>
				<option value="HI">Hawaii</option>
				<option value="ID">Idaho</option>
				<option value="IL">Illinois</option>
				<option value="IN">Indiana</option>
				<option value="IA">Iowa</option>
				<option value="KS">Kansas</option>
				<option value="KY">Kentucky</option>
				<option value="LA">Louisiana</option>
				<option value="ME">Maine</option>
				<option value="MB">Manitoba</option>
				<option value="MH">Marshall Islands</option>
				<option value="MD">Maryland</option>
				<option value="MA">Massachusetts</option>
				<option value="MI">Michigan</option>
				<option value="AA">Military in Americas</option>
				<option value="AE">Military in Europe</option>
				<option value="AP">Military in Pacific</option>
				<option value="MN">Minnesota</option>
				<option value="MS">Mississippi</option>
				<option value="MO">Missouri</option>
				<option value="MT">Montana</option>
				<option value="NE">Nebraska</option>
				<option value="NV">Nevada</option>
				<option value="NB">New Brunswick</option>
				<option value="NH">New Hampshire</option>
				<option value="NJ">New Jersey</option>
				<option value="NM">New Mexico</option>
				<option value="NY">New York</option>
				<option value="NF">Newfoundland</option>
				<option value="NC">North Carolina</option>
				<option value="ND">North Dakota</option>
				<option value="MP">Northern Mariana Is.</option>
				<option value="NT">Northwest Territory</option>
				<option value="NS">Nova Scotia</option>
				<option value="OH">Ohio</option>
				<option value="OK">Oklahoma</option>
				<option value="ON">Ontario</option>
				<option value="OR">Oregon</option>
				<option value="PW">Palau Island</option>
				<option value="PS">Palestine</option>
				<option value="PA">Pennsylvania</option>
				<option value="PE">Prince Edward Island</option>
				<option value="PR">Puerto Rico</option>
				<option value="QC">Quebec</option>
				<option value="RI">Rhode Island</option>
				<option value="SK">Saskatchewan</option>
				<option value="SC">South Carolina</option>
				<option value="SD">South Dakota</option>
				<option value="TN">Tennessee</option>
				<option value="TX">Texas</option>
				<option value="UT">Utah</option>
				<option value="VT">Vermont</option>
				<option value="VI">Virgin Islands</option>
				<option value="VA">Virginia</option>
				<option value="WA">Washington</option>
				<option value="WV">West Virginia</option>
				<option value="WI">Wisconsin</option>
				<option value="WY">Wyoming</option>
				<option value="YT">Yukon</option>
			</select>
		</div>';		
		if(argLen > 1){
			field = Replace(field, 'value="'&state&'"', 'value="'&state&'" selected');
		}
		return field;
	}
	
/*------------------------------------------------------------------ 

	createDropDownCountry(ID[, COUNTRY, REQUIRED, CLASS])
	
	Creates a dropdown input for countries. Used in billing. Create
	default COUNTRY by passing two-letter country code (e.g. 'US').
	
--------------------------------------------------------------------*/

	function createDropDownCountry(id){
		var field = '';
		var country = '';				
		var required = '';
		var class = '';
		var argLen = ArrayLen(ARGUMENTS);
		if(argLen > 1) country = UCase(ARGUMENTS[2]);
		if(argLen > 2) required = ARGUMENTS[3];
		if(argLen > 3) class = ARGUMENTS[4];		
		if(LCase(required) == 'true' || LCase(required) == 'required'){ 
			required = 'required="required"';
			class &= " required";
		} else {
			required = '';
			class &= " optional";
		}
		field = "
		<div class='"&class&"'>
			<label for='"&id&"'>Country</label>
			<select name='"&id&"' id='"&id&"' "&required&">
				<option value=''>-- Select -- </option>
				<option value='US'>USA</option>
				<option value='AF'>Afghanistan</option>
				<option value='AL'>Albania</option>
				<option value='DZ'>Algeria</option>
				<option value='AD'>Andorra</option>
				<option value='AO'>Angola</option>
				<option value='AI'>Anguilla</option>
				<option value='AG'>Antigua and Barbuda</option>
				<option value='AR'>Argentina</option>
				<option value='AW'>Aruba</option>
				<option value='AU'>Australia</option>
				<option value='AT'>Austria</option>
				<option value='AX'>Azores</option>
				<option value='BS'>Bahamas</option>
				<option value='BH'>Bahrain</option>
				<option value='BD'>Bangladesh</option>
				<option value='BB'>Barbados</option>
				<option value='BE'>Belgium</option>
				<option value='BZ'>Belize</option>
				<option value='BM'>Bermuda</option>
				<option value='BT'>Bhutan</option>
				<option value='BO'>Bolivia</option>
				<option value='BA'>Bosnia and Herzegovina</option>
				<option value='BW'>Botswana</option>
				<option value='BR'>Brazil</option>
				<option value='BK'>British Solomon Islands</option>
				<option value='VG'>British Virgin Islands</option>
				<option value='BN'>Brunei Darussalam</option>
				<option value='BG'>Bulgaria</option>
				<option value='BF'>Burkina Faso</option>
				<option value='BI'>Burundi</option>
				<option value='KH'>Cambodia</option>
				<option value='CM'>Cameroon</option>
				<option value='CA'>Canada</option>
				<option value='CB'>Canary Islands</option>
				<option value='CV'>Cape Verde Islands</option>
				<option value='KY'>Cayman Islands</option>
				<option value='CF'>Central African Republic</option>
				<option value='TD'>Chad</option>
				<option value='CE'>Channel Islands</option>
				<option value='CL'>Chile</option>
				<option value='CO'>Colombia</option>
				<option value='KM'>Comoro Islands</option>
				<option value='CK'>Cook Islands</option>
				<option value='CR'>Costa Rica</option>
				<option value='CI'>Cote D'ivoire</option>
				<option value='HR'>Croatia</option>
				<option value='CU'>Cuba</option>
				<option value='CY'>Cyprus</option>
				<option value='CZ'>Czech Republic</option>
				<option value='CD'>Democratic Republic of the Congo</option>
				<option value='DK'>Denmark</option>
				<option value='DM'>Dominica</option>
				<option value='DO'>Dominican Republic</option>
				<option value='EI'>East Timor</option>
				<option value='EC'>Ecuador</option>
				<option value='EG'>Egypt</option>
				<option value='SV'>El Salvador</option>
				<option value='EN'>England</option>
				<option value='GQ'>Equatorial Guinea</option>
				<option value='ER'>Eritrea</option>
				<option value='EE'>Estonia</option>
				<option value='ET'>Ethiopia</option>
				<option value='FK'>Falkland Islands</option>
				<option value='FJ'>Fiji</option>
				<option value='FI'>Finland</option>
				<option value='ZZ'>Foreign Phone Only</option>
				<option value='FR'>France</option>
				<option value='GF'>French Guiana</option>
				<option value='PF'>French Polynesia</option>
				<option value='GA'>Gabon</option>
				<option value='DE'>Germany</option>
				<option value='GH'>Ghana</option>
				<option value='GI'>Gibraltar</option>
				<option value='GX'>Gilbert Islands</option>
				<option value='GR'>Greece</option>
				<option value='GL'>Greenland</option>
				<option value='GD'>Grenada</option>
				<option value='GP'>Guadeloupe</option>
				<option value='GT'>Guatemala</option>
				<option value='GN'>Guinea</option>
				<option value='GW'>Guinea-Bissau</option>
				<option value='GY'>Guyana</option>
				<option value='HT'>Haiti</option>
				<option value='VA'>Holy See (Vatican City State)</option>
				<option value='HN'>Honduras</option>
				<option value='HK'>Hong Kong</option>
				<option value='HU'>Hungary</option>
				<option value='IS'>Iceland</option>
				<option value='IN'>India</option>
				<option value='ID'>Indonesia</option>
				<option value='IR'>Iran</option>
				<option value='IQ'>Iraq</option>
				<option value='IE'>Ireland</option>
				<option value='IM'>Isle of Man</option>
				<option value='IL'>Israel</option>
				<option value='IT'>Italy</option>
				<option value='JM'>Jamaica</option>
				<option value='JP'>Japan</option>
				<option value='JO'>Jordan</option>
				<option value='KE'>Kenya</option>
				<option value='KI'>Kiribati</option>
				<option value='KS'>Kosovo</option>
				<option value='KG'>Kyrgyzstan</option>
				<option value='KW'>Kuwait</option>
				<option value='LA'>Laos</option>
				<option value='LV'>Latvia</option>
				<option value='LB'>Lebanon</option>
				<option value='LS'>Lesotho</option>
				<option value='LR'>Liberia</option>
				<option value='LY'>Libya</option>
				<option value='LI'>Liechtenstein</option>
				<option value='LT'>Lithuania</option>
				<option value='LU'>Luxembourg</option>
				<option value='MK'>Macedonia</option>
				<option value='MG'>Madagascar</option>
				<option value='MW'>Malawi</option>
				<option value='MY'>Malaysia</option>
				<option value='MV'>Maldives</option>
				<option value='ML'>Mali</option>
				<option value='MT'>Malta</option>
				<option value='MI'>Marshall Islands</option>
				<option value='MQ'>Martinique</option>
				<option value='MR'>Mauritania</option>
				<option value='MU'>Mauritius</option>
				<option value='MX'>Mexico</option>
				<option value='FM'>Micronesia, Federated States of</option>
				<option value='MC'>Monaco</option>
				<option value='MN'>Mongolia</option>
				<option value='ME'>Republic of Montenegro</option>
				<option value='MS'>Montserrat</option>
				<option value='MA'>Morocco</option>
				<option value='MZ'>Mozambique</option>
				<option value='MM'>Myanmar</option>
				<option value='NA'>Namibia</option>
				<option value='NR'>Nauru</option>
				<option value='NP'>Nepal</option>
				<option value='AN'>NetherlandsAntilles</option>
				<option value='NC'>New Caledonia</option>
				<option value='NZ'>New Zealand</option>
				<option value='NI'>Nicaragua</option>
				<option value='NE'>Niger</option>
				<option value='NG'>Nigeria</option>
				<option value='NU'>Niue</option>
				<option value='ND'>Northern Ireland</option>
				<option value='NO'>Norway</option>
				<option value='OM'>Oman</option>
				<option value='PK'>Pakistan</option>
				<option value='PU'>Palau</option>
				<option value='PR'>Palestinian National Authority</option>
				<option value='PA'>Panama</option>
				<option value='PG'>Papua New Guinea</option>
				<option value='PY'>Paraguay</option>
				<option value='BJ'>People's Republic of Benin</option>
				<option value='CN'>People's Republic of China</option>
				<option value='KP'>People's Republic of Korea</option>
				<option value='PE'>Peru</option>
				<option value='PH'>Philippines</option>
				<option value='PN'>Pitcairn Island</option>
				<option value='PL'>Poland</option>
				<option value='PT'>Portugal</option>
				<option value='QA'>Qatar</option>
				<option value='AM'>Republic of Armenia</option>
				<option value='AZ'>Republic of Azerbaijan</option>
				<option value='BY'>Republic of Belarus</option>
				<option value='CG'>Republic of Congo</option>
				<option value='DJ'>Republic of Djibouti</option>
				<option value='GE'>Republic of Georgia</option>
				<option value='KZ'>Republic of Kazakhstan</option>
				<option value='KR'>Republic of Korea</option>
				<option value='MD'>Republic of Moldova</option>
				<option value='TJ'>Republic of Tajikistan</option>
				<option value='UZ'>Republic of Uzbekistan</option>
				<option value='YE'>Republic of Yemen</option>
				<option value='RE'>Reunion</option>
				<option value='RO'>Romania</option>
				<option value='RU'>Russia</option>
				<option value='RW'>Rwanda</option>
				<option value='RY'>Ryukyu Islands</option>
				<option value='KN'>Saint Kitts and Nevis</option>
				<option value='LC'>Saint Lucia</option>
				<option value='VC'>Saint Vincent and The Grenadines</option>
				<option value='SM'>San Marino</option>
				<option value='ST'>Sao Tome And Principe</option>
				<option value='SA'>Saudi Arabia</option>
				<option value='SF'>Scotland</option>
				<option value='SN'>Senegal</option>
				<option value='CS'>Serbia and Montenegro</option>
				<option value='RS'>Republic of Serbia</option>
				<option value='SC'>Seychelles</option>
				<option value='SL'>Sierra Leone</option>
				<option value='SG'>Singapore</option>
				<option value='SK'>Slovakia</option>
				<option value='SI'>Slovenia</option>
				<option value='SB'>Solomon Islands</option>
				<option value='SO'>Somalia</option>
				<option value='ZA'>South Africa</option>
				<option value='ES'>Spain</option>
				<option value='LK'>Sri Lanka</option>
				<option value='SD'>Sudan</option>
				<option value='SR'>Surinam</option>
				<option value='SZ'>Swaziland</option>
				<option value='SE'>Sweden</option>
				<option value='CH'>Switzerland</option>
				<option value='SY'>Syria</option>
				<option value='TW'>Taiwan</option>
				<option value='TZ'>Tanzania</option>
				<option value='TH'>Thailand</option>
				<option value='GM'>The Gambia</option>
				<option value='NL'>The Netherlands</option>
				<option value='TG'>Togo</option>
				<option value='TO'>Tonga</option>
				<option value='TL'>Tortola</option>
				<option value='TT'>Trinidad and Tobago</option>
				<option value='TN'>Tunisia</option>
				<option value='TR'>Turkey</option>
				<option value='TM'>Turkmenistan</option>
				<option value='TC'>Turks and Caicos Islands</option>
				<option value='TV'>Tuvalu</option>
				<option value='UG'>Uganda</option>
				<option value='UA'>Ukraine</option>
				<option value='AE'>United Arab Emirates</option>
				<option value='GB'>United Kingdom</option>
				<option value='UY'>Uruguay</option>
				<option value='VU'>Vanuatu</option>
				<option value='VE'>Venezuela</option>
				<option value='VN'>Vietnam</option>
				<option value='WA'>Wales</option>
				<option value='WS'>Western Samoa</option>
				<option value='ZR'>Zaire</option>
				<option value='ZM'>Zambia</option>
				<option value='ZW'>Zimbabwe</option>
			</select>
		</div>";
		if(argLen > 1){
			field = Replace(field, "value='"&country&"'", "value='"&country&"' selected");
		}
		return field;
	}
	
/*------------------------------------------------------------------ 

	createDropDownPrograms(ID[, LABEL, REQUIRED, CLASS, SELECTED_MAJOR, 
		REMOVE_MAJOR])
	
	Creates a dropdown input of programs with default label of "Major." 
	Remove one or more majors by sending a comma-separated list.
	
--------------------------------------------------------------------*/
	
	function createDropDownPrograms(id){
		var field = '';
		var label = 'Major';				
		var required = '';
		var class = '';
		var selected_major = '';
		var remove_major = '';
		var argLen = ArrayLen(ARGUMENTS);
		if(argLen > 1) label = ARGUMENTS[2];
		if(argLen > 2) required = ARGUMENTS[3];
		if(argLen > 3) class = ARGUMENTS[4];
		if(argLen > 4) selected_major = ARGUMENTS[5];
		if(argLen > 5) remove_major = ARGUMENTS[6];
		if(LCase(required) == 'true' || LCase(required) == 'required'){ 
			required = 'required="required"';
			class &= " required";
		} else {
			required = '';
			class &= " optional";
		}
		field = '
			<div class="'&class&'">
				<label for="'&id&'">'&label&'</label>
				<select name="'&id&'" id="'&id&'" '&required&'>
					<option value="">-- Select --</option>	
					<optgroup label="Undergraduate Programs">
					<option value="Accounting">Accounting</option>				
					<option value="Applied Mathematics">Applied Mathematics</option>				
					<option value="Biochemistry">Biochemistry</option>				
					<option value="Biology">Biology</option>							
					<option value="Business Administration">Business Administration</option>				
					<option value="Business Communication">Business Communication</option>				
					<option value="Business Information Systems">Business Information Systems</option>				
					<option value="Chemistry">Chemistry</option>				
					<option value="Computer Information Systems">Computer Information Systems</option>				
					<option value="Criminal Justice">Criminal Justice</option>				
					<option value="Digital Marketing">Digital Marketing</option>				
					<option value="Early Childhood Education">Early Childhood Education</option>				
					<option value="Elementary Education">Elementary Education</option>
					<option value="English Language & Literature">English Language & Literature</option>				
					<option value="Environmental Science">Environmental Science</option>
					<option value="Fashion Design">Fashion Design</option>				
					<option value="Fashion Merchandising">Fashion Merchandising</option>				
					<option value="Film and Moving Image">Film and Moving Image</option>				
					<option value="Human Services">Human Services</option>	
					<option value="Interdisciplinary Studies">Interdisciplinary Studies</option>	
					<option value="Legal Studies">Legal Studies</option>				
					<option value="Medical Laboratory Science">Medical Laboratory Science</option>				
					<option value="Middle School Education">Middle School Education</option>				
					<option value="Nursing">Nursing</option>							
					<option value="Psychology">Psychology</option>				
					<option value="Public History">Public History</option>				
					<option value="Theatre & Media Performance">Theatre & Media Performance</option>
					<option value="Visual Communication Design">Visual Communication Design</option>
					<option value="Undecided">Undecided</option>
					</optgroup>
					<optgroup label="Pre-Professional Programs">
					<option value="Pre-Dentistry">Pre-Dentistry</option>
					<option value="Pre-Law">Pre-Law</option>
					<option value="Pre-Medicine">Pre-Medicine</option>
					<option value="Pre-Pharmacy">Pre-Pharmacy</option>
					<option value="Pre-Physical Therapy">Pre-Physical Therapy</option>
					<option value="Pre-Veterinary Medicine">Pre-Veterinary Medicine</option>
					</optgroup>
				</select>
			</div>';
		if(remove_major != ''){
			remove_major_length = ListLen(remove_major);
			for(i=1; i<=remove_major_length; i++){
				major = ListGetAt(remove_major, i);
				field = Replace(field, '<option value="'&major&'">'&major&'</option>', '');
			}
		}
		if(selected_major != ''){
			field = Replace(field, 'value="'&selected_major&'"', 'value="'&selected_major&'" selected');
		}
		return field;
	}
	
/*------------------------------------------------------------------ 

	createDropDownPrograms(ID[, LABEL, REQUIRED, CLASS, SELECTED_MAJOR, 
		REMOVE_MAJOR])
	
	Creates a dropdown input of programs with default label of "Major." 
	Remove one or more majors by sending a comma-separated list.
	
--------------------------------------------------------------------*/
	
	function createDropDownProgramsGPS(id){
		var field = '';
		var label = 'Major';				
		var required = '';
		var class = '';
		var selected_major = '';
		var remove_major = '';
		var argLen = ArrayLen(ARGUMENTS);
		if(argLen > 1) label = ARGUMENTS[2];
		if(argLen > 2) required = ARGUMENTS[3];
		if(argLen > 3) class = ARGUMENTS[4];
		if(argLen > 4) selected_major = ARGUMENTS[5];
		if(argLen > 5) remove_major = ARGUMENTS[6];
		if(LCase(required) == 'true' || LCase(required) == 'required'){ 
			required = 'required="required"';
			class &= " required";
		} else {
			required = '';
			class &= " optional";
		}
		field = '
			<div class="'&class&'">
				<label for="'&id&'">'&label&'</label>
				<select name="'&id&'" id="'&id&'" '&required&'>
					<option value="">-- Select --</option>	
					<optgroup label="Graduate Programs">
					<option value="Master of Arts in Teaching">Master of Arts in Teaching</option>
					<option value="Business & Technology Management">Business & Technology Management</option>
					<option value="Communication Studies">Communication Studies</option>
					<option value="Cyber Forensics">Cyber Forensics</option>
					<option value="Forensic Science">Forensic Science</option>
					<option value="Forensic Studies">Forensic Studies</option>
					<option value="Healthcare Management">Healthcare Management</option>
					<option value="Nursing">Nursing</option>
					</optgroup>
					<optgroup label="Adult Undergraduate Programs">
					<option value="Business Administration">Business Administration</option>
					<option value="Business Communication">Business Communication</option>
					<option value="Business Information Systems">Business Information Systems</option>
					<option value="Computer Information Systems">Computer Information Systems</option>
					<option value="Criminal Justice">Criminal Justice</option>
					<option value="Interdisciplinary Studies">Interdisciplinary Studies</option>
					<option value="Paralegal Studies">Paralegal Studies</option>
					<option value="RN to BS in Nursing">RN to BS in Nursing</option>
					<option value="RN to MS in Nursing">RN to MS in Nursing</option>
					</optgroup>
				</select>
			</div>';
		if(remove_major != ''){
			remove_major_length = ListLen(remove_major);
			for(i=1; i<=remove_major_length; i++){
				major = ListGetAt(remove_major, i);
				field = Replace(field, '<option value="'&major&'">'&major&'</option>', '');
			}
		}
		if(selected_major != ''){
			field = Replace(field, 'value="'&selected_major&'"', 'value="'&selected_major&'" selected');
		}
		return field;
	}
 
/*------------------------------------------------------------------ 

	createDropDownTime(LABEL, ID[, REQUIRED, CLASS, SELECTED_TIME])
	
	Creates a dropdown input of time [hh:mm AM|PM]. 
	SELECTED_TIME is a list in the following format: "hh,mm,AM"
	
--------------------------------------------------------------------*/
	
	function createDropDownTime(label, id){		
		var field = '';			
		var required = '';
		var class = '';
		var selected_time = '';
		var argLen = ArrayLen(ARGUMENTS);
		if(argLen > 2) required = ARGUMENTS[3];
		if(argLen > 3) class = ARGUMENTS[4];	
		if(argLen > 4) selected_time = ARGUMENTS[5];
		if(LCase(required) == 'true' || LCase(required) == 'required'){ 
			required = 'required="required"';
			class &= " required";
		} else {
			required = '';
			class &= " optional";
		}
		field = "
		<div class='"&class&"'>
			<label for='"&id&"'>"&label&"</label>
			<select name='"&id&"_hour' id='"&id&"_hour' "&required&">
				<option value=''>hh</option>";
		field &= createSelectOptionNumber(12, '', '', 'data-time-part="hour"');
		field &= '
			</select>&nbsp;
			<select name="'&id&'_minute" id="'&id&'_minute" '&required&'>
				<option value="">mm</option>
				<option data-time-part="minute" value="00">00</option>
				<option data-time-part="minute" value="15">15</option>
				<option data-time-part="minute" value="30">30</option>
				<option data-time-part="minute" value="45">45</option>
			</select>&nbsp;
			<select name="'&id&'_am_pm" id="'&id&'_am_pm" '&required&'>
				<option data-time-part="am_pm" value="AM">AM</option>
				<option data-time-part="am_pm" value="PM" selected>PM</option>
			</select>
		</div>
		';
		if(selected_time != ''){
			if(ListLen(selected_time) == 3){
				selected_time_array = ListToArray(selected_time);
				selected_time_hour = selected_time_array[1];
				selected_time_minute = selected_time_array[2];
				selected_time_am_pm = selected_time_array[3];
				field = Replace(field, 'data-time-part="hour" value="'&selected_time_hour&'"', 'data-time-part="hour" value="'&selected_time_hour&'" selected');
				field = Replace(field, 'data-time-part="minute" value="'&selected_time_minute&'"', 'data-time-part="minute" value="'&selected_time_minute&'" selected');
				field = Replace(field, 'data-time-part="am_pm" value="'&selected_time_am_pm&'"', 'data-time-part="am_pm" value="'&selected_time_am_pm&'" selected');
			}
		}
		return field;
	}
	
/*------------------------------------------------------------------ 

	createDropDownNumber(LABEL, ID, STOP_NUMBER[, CLASS, START_NUMBER, 
		LEADING_ZERO])
	
	Creates a dropdown input of numbers.
	
--------------------------------------------------------------------*/
	
	function createDropDownNumber(label, id, stop_number){
		var field = '';
		var class = '';
		var start_number = 0;
		var leading_zero = '';
		if(ArrayLen(ARGUMENTS) > 3) class=ARGUMENTS[4];
		if(ArrayLen(ARGUMENTS) > 4) start_number=ARGUMENTS[5];
		if(ArrayLen(ARGUMENTS) > 5) leading_zero=ARGUMENTS[6];
		field &= '<div class="'&class&'"><label for="'&id&'">'&label&'</label><select name="'&id&'" id="'&id&'">';
		field &= createSelectOptionNumber(stop_number, leading_zero, start_number);
		field &= '</select></div>';
		return field;
	}
	
/*------------------------------------------------------------------ 

	createDropDownDate(LABEL, ID[, REQUIRED, CLASS, NUMBER_YEARS, 
		SELECTED_DATE, THIS_YEAR])
	
	Creates a dropdown input of dates. 
	
--------------------------------------------------------------------*/
	
	function createDropDownDate(label, id){
		var field = '';			
		var required = '';
		var class = '';
		var this_year = Year(Now());
		var number_years = 1;
		var selected_date = '';
		var argLen = ArrayLen(ARGUMENTS);
		if(argLen > 2) required = ARGUMENTS[3];
		if(argLen > 3) class = ARGUMENTS[4];	
		if(argLen > 4 && isValid('integer', ARGUMENTS[5])) number_years = ARGUMENTS[5];	
		if(argLen > 5) selected_date = ARGUMENTS[6];
		if(argLen > 6 && isValid('integer', ARGUMENTS[7])) this_year = this_year - ARGUMENTS[7];
		if(LCase(required) == 'true' || LCase(required) == 'required'){ 
			required = 'required="required"';
			class &= " required";
		} else {
			required = '';
			class &= " optional";
		}
		field = "
		<div class='"&class&"'>
			<label for='"&id&"'>"&label&"</label>
			<select name='"&id&"_month' id='"&id&"_month' "&required&">
				<option value=''>mm</option>";
		field &= createSelectOptionNumber(12, true, '', 'data-date-part="month"');
		field &= "
			</select>&nbsp;
			<select name='"&id&"_day' id='"&id&"_day' "&required&">
				<option value=''>dd</option>";
		field &= createSelectOptionNumber(31, true, '', 'data-date-part="day"');
		field &= "
			</select>&nbsp;
			<select name='"&id&"_year' id='"&id&"_year' "&required&">
				<option value=''>yyyy</option>";
		field &= createSelectOptionNumber(this_year+number_years, '', this_year, 'data-date-part="year"');
		field &= "
			</select>
		</div>
		";
		if(selected_date != ''){
			if(ListLen(selected_date) == 3){
				selected_date_array = ListToArray(selected_date);
				selected_date_year = selected_date_array[1];
				selected_date_month = selected_date_array[2];
				selected_date_day = selected_date_array[3];
				field = Replace(field, 'data-date-part="year" value="'&selected_date_year&'"', 'data-date-part="year" value="'&selected_date_year&'" selected');
				field = Replace(field, 'data-date-part="month" value="'&selected_date_month&'"', 'data-date-part="month" value="'&selected_date_month&'" selected');
				field = Replace(field, 'data-date-part="day" value="'&selected_date_day&'"', 'data-date-part="day" value="'&selected_date_day&'" selected');
			}
		}
		return field;
	}
	
/*------------------------------------------------------------------ 

	createSelectOptionNumber(STOPNUMBER[, LEADINGZERO, STARTNUMBER, 
		DATANAME])
	
	Creates a set of numbered option elements for a select element.
	
--------------------------------------------------------------------*/
	
	function createSelectOptionNumber(stopNumber){
		var field = '';
		var leadingZero = '';
		var startNumber = 1;
		var dataName = '';
		var argLen = ArrayLen(ARGUMENTS);
		if(argLen > 1) leadingZero = ARGUMENTS[2];
		if(argLen > 2 && isValid('integer', ARGUMENTS[3])) startNumber = ARGUMENTS[3];
		if(argLen > 3) dataName = ARGUMENTS[4];
		if(stopNumber - startNumber > 50){
			field &= '<option value="">NUMBERS TOO BIG: stopNumber - startNumber > 50</option>';
		} else {
			for(i=startNumber; i<=stopNumber; i++){
				if(leadingZero neq '' && i < 10){
					field &= '<option '&dataName&' value="0'&i&'">0'&i&'</option>';
				} else {
					field &= '<option '&dataName&' value="'&i&'">'&i&'</option>';
				}
			}
		}
		return field;		
	}
	
/*------------------------------------------------------------------ 

	getBillingInfo([FIRSTNAME, LASTNAME, ADDRESS, CITY, STATE, ZIP,
		COUNTRY, EMAIL])
	
	Creates all billing info inputs necessary for processing 
	CyberSource transactions .
	
--------------------------------------------------------------------*/

	function getBillingInfo(){
		var field = '';		
		var firstName = '';
		var lastName = '';
		var address = '';
		var city = '';
		var state = '';
		var zip = '';
		var country = '';
		var argLen = ArrayLen(ARGUMENTS);
		if(argLen > 0) { firstName = ARGUMENTS[1]; } else { firstName = ''; }
		if(argLen > 1) { lastName = ARGUMENTS[2]; } else { lastName = ''; }
		if(argLen > 2) { address = ARGUMENTS[3]; } else { address = ''; }
		if(argLen > 3) { city = ARGUMENTS[4]; } else { city = ''; }
		if(argLen > 4) { state = ARGUMENTS[5]; } else { state = ''; }
		if(argLen > 5) { zip = ARGUMENTS[6]; } else { zip = ''; }
		if(argLen > 6) { country = ARGUMENTS[7]; } else { country = ''; }
		if(argLen > 7) { email = ARGUMENTS[8]; } else { email = ''; }
		field &= createInputField('First Name', 'bill_to_forename', 'text', 'required', '', firstName);
		field &= createInputField('Last Name', 'bill_to_surname', 'text', 'required', '', lastName);
		field &= createInputField('Address', 'bill_to_address_line1', 'text', 'required', '', address);
		field &= createInputField('City', 'bill_to_address_city', 'text', 'required', '', city);
		field &= createDropDownState('bill_to_address_state', state, 'required');
		field &= createInputField('Zip Code', 'bill_to_address_postal_code', 'text', 'required', 'zip', zip);
		field &= createDropDownCountry('bill_to_address_country', country, 'required');
		field &= createInputField('Email', 'bill_to_email', 'email', 'required', '', email);
		return field;
	}
	
/*------------------------------------------------------------------ 

	getCardInfo([CARDNUMBER, CVN])
	
	Creates all credit card inputs necessary for processing 
	CyberSource transactions.
	
--------------------------------------------------------------------*/

	function getCardInfo(){
		var field = '';
		var cardType = ''; 
		var cardNumber = '';
		var cardCVN = '';
		var cardMonth = '';
		var cardYear = '';
		var this_year = Year(Now());
		var argLen = ArrayLen(ARGUMENTS);		
		if(argLen > 1) cardNumber = ARGUMENTS[2];
		if(argLen > 2) cardCVN = ARGUMENTS[3];
		field &= '<div class="required"><label for="card_type">Card Type</label><select name="card_type" id="card_type" required="required"><br><option value="">-- Select --</option><option value="001">Visa</option><option value="002">MasterCard</option><option value="004">Discover</option><option value="003">American Express</option></select></div>';
		field &= createInputField('Card Number', 'card_number', 'text', 'required', 'card_number', cardNumber);
		field &= createInputField('Card Verification Number', 'card_cvn', 'text', 'required', 'cvn', cardCVN);
		field &= '<div class="explanatory next_line">(This is the 3 digit number on the back of your card. AmEx users can find this 4 digit number on the front of the card.)</div>
		<div class="required">
			<label>Expiration Date</label>
			<select name="card_expiry_month" id="card_expiry_month" required="required">
				<option value="">-- Month --</option>
				<option value="01">01</option>
				<option value="02">02</option>
				<option value="03">03</option>
				<option value="04">04</option>
				<option value="05">05</option>
				<option value="06">06</option>
				<option value="07">07</option>
				<option value="08">08</option>
				<option value="09">09</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
			</select>&nbsp;
			<select name="card_expiry_year" id="card_expiry_year" required="required">
				<option value="">-- Year --</option>
				<option value="'&this_year&'">'&this_year&'</option>
				<option value="'&this_year+1&'">'&this_year+1&'</option>
				<option value="'&this_year+2&'">'&this_year+2&'</option>
				<option value="'&this_year+3&'">'&this_year+3&'</option>
				<option value="'&this_year+4&'">'&this_year+4&'</option>
				<option value="'&this_year+5&'">'&this_year+5&'</option>
				<option value="'&this_year+6&'">'&this_year+6&'</option>
				<option value="'&this_year+7&'">'&this_year+7&'</option>
				<option value="'&this_year+8&'">'&this_year+8&'</option>
				<option value="'&this_year+9&'">'&this_year+9&'</option>
				<option value="'&this_year+10&'">'&this_year+10&'</option>
			</select>
		</div>';		
		
		if(argLen > 0){
			 cardType = ARGUMENTS[1];
			 field = Replace(field, 'value="'&cardType&'"', 'value="'&cardType&'" selected');
		}
		if(argLen > 3){
			 cardMonth = ARGUMENTS[4];
			 field = Replace(field, 'value="'&cardMonth&'"', 'value="'&cardMonth&'" selected');
		}
		if(argLen > 4){
			 cardYear = ARGUMENTS[5];
			 field = Replace(field, 'value="'&cardYear&'"', 'value="'&cardYear&'" selected');
		}
		return field;
	}
</cfscript>
