<?php 
include_once('confirmation-message.php');

function returnErrorWithMessage($message){
	$a = array('result' => 1, 'errorMessage' => $message);
	echo json_encode($a);
}

function stripData($data){
	$data = trim($data);
	$data = stripslashes($data);
	$data = htmlspecialchars($data);
	return $data;
}

function createInput($label, $id, $type='text', $required='', $class='', $value='', $maxlength=''){
	if($required == 'required') {
		$class .= ' required';
	} else {
		$class .= ' optional';
	}
	$field = '<div class="'.$class.'">'
			.'<label for="'.$id.'">'.$label.'</label>'
			.'<input type="'.$type.'" name="'.$id.'" id="'.$id.'" data-stripe="'.$id.'" value="'.$value.'" '.$required.' maxlength='.$maxlength.' />'
			.'</div>';
	return $field;
}

function createOptionNumber($start, $stop, $zero=false){
	$field = '';
	for($i=$start; $i<=$stop; $i++){
		$num = $i;
		if($zero && $i<10){
			$num='0'.$num;
		}
		echo '<option value="'.$num.'">'.$num.'</option>';
	}
	return $field;
}

function createDropDownState($label, $id, $required='', $class=''){
	if($required == 'required') {
		$class .= ' required';
	} else {
		$class .= ' optional';
	}
	$field = '<div class="'.$class.'">'
			.'<label for="'.$id.'">'.$label.'</label>'
			.'<select name="'.$id.'" id="'.$id.'" data-stripe="'.$id.'" '.$required.' >'
			.'<option value="">-- Select --</option>'
			.'<option value="AL">Alabama</option>'
			.'<option value="AK">Alaska</option>'
			.'<option value="AB">Alberta</option>'
			.'<option value="AS">American Samoa</option>'
			.'<option value="AZ">Arizona</option>'
			.'<option value="AR">Arkansas</option>'
			.'<option value="BC">British Columbia</option>'
			.'<option value="CA">California</option>'
			.'<option value="CO">Colorado</option>'
			.'<option value="CT">Connecticut</option>'
			.'<option value="DE">Delaware</option>'
			.'<option value="DC">District of Columbia</option>'
			.'<option value="FM">Fed St of Micronesia</option>'
			.'<option value="FL">Florida</option>'
			.'<option value="GA">Georgia</option>'
			.'<option value="GU">Guam</option>'
			.'<option value="HI">Hawaii</option>'
			.'<option value="ID">Idaho</option>'
			.'<option value="IL">Illinois</option>'
			.'<option value="IN">Indiana</option>'
			.'<option value="IA">Iowa</option>'
			.'<option value="KS">Kansas</option>'
			.'<option value="KY">Kentucky</option>'
			.'<option value="LA">Louisiana</option>'
			.'<option value="ME">Maine</option>'
			.'<option value="MB">Manitoba</option>'
			.'<option value="MH">Marshall Islands</option>'
			.'<option value="MD">Maryland</option>'
			.'<option value="MA">Massachusetts</option>'
			.'<option value="MI">Michigan</option>'
			.'<option value="AA">Military in Americas</option>'
			.'<option value="AE">Military in Europe</option>'
			.'<option value="AP">Military in Pacific</option>'
			.'<option value="MN">Minnesota</option>'
			.'<option value="MS">Mississippi</option>'
			.'<option value="MO">Missouri</option>'
			.'<option value="MT">Montana</option>'
			.'<option value="NE">Nebraska</option>'
			.'<option value="NV">Nevada</option>'
			.'<option value="NB">New Brunswick</option>'
			.'<option value="NH">New Hampshire</option>'
			.'<option value="NJ">New Jersey</option>'
			.'<option value="NM">New Mexico</option>'
			.'<option value="NY">New York</option>'
			.'<option value="NF">Newfoundland</option>'
			.'<option value="NC">North Carolina</option>'
			.'<option value="ND">North Dakota</option>'
			.'<option value="MP">Northern Mariana Is.</option>'
			.'<option value="NT">Northwest Territory</option>'
			.'<option value="NS">Nova Scotia</option>'
			.'<option value="OH">Ohio</option>'
			.'<option value="OK">Oklahoma</option>'
			.'<option value="ON">Ontario</option>'
			.'<option value="OR">Oregon</option>'
			.'<option value="PW">Palau Island</option>'
			.'<option value="PS">Palestine</option>'
			.'<option value="PA">Pennsylvania</option>'
			.'<option value="PE">Prince Edward Island</option>'
			.'<option value="PR">Puerto Rico</option>'
			.'<option value="QC">Quebec</option>'
			.'<option value="RI">Rhode Island</option>'
			.'<option value="SK">Saskatchewan</option>'
			.'<option value="SC">South Carolina</option>'
			.'<option value="SD">South Dakota</option>'
			.'<option value="TN">Tennessee</option>'
			.'<option value="TX">Texas</option>'
			.'<option value="UT">Utah</option>'
			.'<option value="VT">Vermont</option>'
			.'<option value="VI">Virgin Islands</option>'
			.'<option value="VA">Virginia</option>'
			.'<option value="WA">Washington</option>'
			.'<option value="WV">West Virginia</option>'
			.'<option value="WI">Wisconsin</option>'
			.'<option value="WY">Wyoming</option>'
			.'<option value="YT">Yukon</option>'
			.'</select>'
			.'</div>';
	return $field;
}

function createDropDownCountry($label, $id, $required='', $class=''){
	if($required == 'required') {
		$class .= ' required';
	} else {
		$class .= ' optional';
	}
	$field = '<div class="'.$class.'">'
			.'<label for="'.$id.'">'.$label.'</label>'
			.'<select name="'.$id.'" id="'.$id.'" data-stripe="'.$id.'" '.$required.' >'
			.'<option value="">-- Select -- </option>'
			.'<option value="US" selected>USA</option>'
			.'<option value="AF">Afghanistan</option>'
			.'<option value="AL">Albania</option>'
			.'<option value="DZ">Algeria</option>'
			.'<option value="AD">Andorra</option>'
			.'<option value="AO">Angola</option>'
			.'<option value="AI">Anguilla</option>'
			.'<option value="AG">Antigua and Barbuda</option>'
			.'<option value="AR">Argentina</option>'
			.'<option value="AW">Aruba</option>'
			.'<option value="AU">Australia</option>'
			.'<option value="AT">Austria</option>'
			.'<option value="AX">Azores</option>'
			.'<option value="BS">Bahamas</option>'
			.'<option value="BH">Bahrain</option>'
			.'<option value="BD">Bangladesh</option>'
			.'<option value="BB">Barbados</option>'
			.'<option value="BE">Belgium</option>'
			.'<option value="BZ">Belize</option>'
			.'<option value="BM">Bermuda</option>'
			.'<option value="BT">Bhutan</option>'
			.'<option value="BO">Bolivia</option>'
			.'<option value="BA">Bosnia and Herzegovina</option>'
			.'<option value="BW">Botswana</option>'
			.'<option value="BR">Brazil</option>'
			.'<option value="BK">British Solomon Islands</option>'
			.'<option value="VG">British Virgin Islands</option>'
			.'<option value="BN">Brunei Darussalam</option>'
			.'<option value="BG">Bulgaria</option>'
			.'<option value="BF">Burkina Faso</option>'
			.'<option value="BI">Burundi</option>'
			.'<option value="KH">Cambodia</option>'
			.'<option value="CM">Cameroon</option>'
			.'<option value="CA">Canada</option>'
			.'<option value="CB">Canary Islands</option>'
			.'<option value="CV">Cape Verde Islands</option>'
			.'<option value="KY">Cayman Islands</option>'
			.'<option value="CF">Central African Republic</option>'
			.'<option value="TD">Chad</option>'
			.'<option value="CE">Channel Islands</option>'
			.'<option value="CL">Chile</option>'
			.'<option value="CO">Colombia</option>'
			.'<option value="KM">Comoro Islands</option>'
			.'<option value="CK">Cook Islands</option>'
			.'<option value="CR">Costa Rica</option>'
			.'<option value="CI">Cote D\'ivoire</option>'
			.'<option value="HR">Croatia</option>'
			.'<option value="CU">Cuba</option>'
			.'<option value="CY">Cyprus</option>'
			.'<option value="CZ">Czech Republic</option>'
			.'<option value="CD">Democratic Republic of the Congo</option>'
			.'<option value="DK">Denmark</option>'
			.'<option value="DM">Dominica</option>'
			.'<option value="DO">Dominican Republic</option>'
			.'<option value="EI">East Timor</option>'
			.'<option value="EC">Ecuador</option>'
			.'<option value="EG">Egypt</option>'
			.'<option value="SV">El Salvador</option>'
			.'<option value="EN">England</option>'
			.'<option value="GQ">Equatorial Guinea</option>'
			.'<option value="ER">Eritrea</option>'
			.'<option value="EE">Estonia</option>'
			.'<option value="ET">Ethiopia</option>'
			.'<option value="FK">Falkland Islands</option>'
			.'<option value="FJ">Fiji</option>'
			.'<option value="FI">Finland</option>'
			.'<option value="ZZ">Foreign Phone Only</option>'
			.'<option value="FR">France</option>'
			.'<option value="GF">French Guiana</option>'
			.'<option value="PF">French Polynesia</option>'
			.'<option value="GA">Gabon</option>'
			.'<option value="DE">Germany</option>'
			.'<option value="GH">Ghana</option>'
			.'<option value="GI">Gibraltar</option>'
			.'<option value="GX">Gilbert Islands</option>'
			.'<option value="GR">Greece</option>'
			.'<option value="GL">Greenland</option>'
			.'<option value="GD">Grenada</option>'
			.'<option value="GP">Guadeloupe</option>'
			.'<option value="GT">Guatemala</option>'
			.'<option value="GN">Guinea</option>'
			.'<option value="GW">Guinea-Bissau</option>'
			.'<option value="GY">Guyana</option>'
			.'<option value="HT">Haiti</option>'
			.'<option value="VA">Holy See (Vatican City State)</option>'
			.'<option value="HN">Honduras</option>'
			.'<option value="HK">Hong Kong</option>'
			.'<option value="HU">Hungary</option>'
			.'<option value="IS">Iceland</option>'
			.'<option value="IN">India</option>'
			.'<option value="ID">Indonesia</option>'
			.'<option value="IR">Iran</option>'
			.'<option value="IQ">Iraq</option>'
			.'<option value="IE">Ireland</option>'
			.'<option value="IM">Isle of Man</option>'
			.'<option value="IL">Israel</option>'
			.'<option value="IT">Italy</option>'
			.'<option value="JM">Jamaica</option>'
			.'<option value="JP">Japan</option>'
			.'<option value="JO">Jordan</option>'
			.'<option value="KE">Kenya</option>'
			.'<option value="KI">Kiribati</option>'
			.'<option value="KS">Kosovo</option>'
			.'<option value="KG">Kyrgyzstan</option>'
			.'<option value="KW">Kuwait</option>'
			.'<option value="LA">Laos</option>'
			.'<option value="LV">Latvia</option>'
			.'<option value="LB">Lebanon</option>'
			.'<option value="LS">Lesotho</option>'
			.'<option value="LR">Liberia</option>'
			.'<option value="LY">Libya</option>'
			.'<option value="LI">Liechtenstein</option>'
			.'<option value="LT">Lithuania</option>'
			.'<option value="LU">Luxembourg</option>'
			.'<option value="MK">Macedonia</option>'
			.'<option value="MG">Madagascar</option>'
			.'<option value="MW">Malawi</option>'
			.'<option value="MY">Malaysia</option>'
			.'<option value="MV">Maldives</option>'
			.'<option value="ML">Mali</option>'
			.'<option value="MT">Malta</option>'
			.'<option value="MI">Marshall Islands</option>'
			.'<option value="MQ">Martinique</option>'
			.'<option value="MR">Mauritania</option>'
			.'<option value="MU">Mauritius</option>'
			.'<option value="MX">Mexico</option>'
			.'<option value="FM">Micronesia, Federated States of</option>'
			.'<option value="MC">Monaco</option>'
			.'<option value="MN">Mongolia</option>'
			.'<option value="ME">Republic of Montenegro</option>'
			.'<option value="MS">Montserrat</option>'
			.'<option value="MA">Morocco</option>'
			.'<option value="MZ">Mozambique</option>'
			.'<option value="MM">Myanmar</option>'
			.'<option value="NA">Namibia</option>'
			.'<option value="NR">Nauru</option>'
			.'<option value="NP">Nepal</option>'
			.'<option value="AN">NetherlandsAntilles</option>'
			.'<option value="NC">New Caledonia</option>'
			.'<option value="NZ">New Zealand</option>'
			.'<option value="NI">Nicaragua</option>'
			.'<option value="NE">Niger</option>'
			.'<option value="NG">Nigeria</option>'
			.'<option value="NU">Niue</option>'
			.'<option value="ND">Northern Ireland</option>'
			.'<option value="NO">Norway</option>'
			.'<option value="OM">Oman</option>'
			.'<option value="PK">Pakistan</option>'
			.'<option value="PU">Palau</option>'
			.'<option value="PR">Palestinian National Authority</option>'
			.'<option value="PA">Panama</option>'
			.'<option value="PG">Papua New Guinea</option>'
			.'<option value="PY">Paraguay</option>'
			.'<option value="BJ">People\'s Republic of Benin</option>'
			.'<option value="CN">People\'s Republic of China</option>'
			.'<option value="KP">People\'s Republic of Korea</option>'
			.'<option value="PE">Peru</option>'
			.'<option value="PH">Philippines</option>'
			.'<option value="PN">Pitcairn Island</option>'
			.'<option value="PL">Poland</option>'
			.'<option value="PT">Portugal</option>'
			.'<option value="QA">Qatar</option>'
			.'<option value="AM">Republic of Armenia</option>'
			.'<option value="AZ">Republic of Azerbaijan</option>'
			.'<option value="BY">Republic of Belarus</option>'
			.'<option value="CG">Republic of Congo</option>'
			.'<option value="DJ">Republic of Djibouti</option>'
			.'<option value="GE">Republic of Georgia</option>'
			.'<option value="KZ">Republic of Kazakhstan</option>'
			.'<option value="KR">Republic of Korea</option>'
			.'<option value="MD">Republic of Moldova</option>'
			.'<option value="TJ">Republic of Tajikistan</option>'
			.'<option value="UZ">Republic of Uzbekistan</option>'
			.'<option value="YE">Republic of Yemen</option>'
			.'<option value="RE">Reunion</option>'
			.'<option value="RO">Romania</option>'
			.'<option value="RU">Russia</option>'
			.'<option value="RW">Rwanda</option>'
			.'<option value="RY">Ryukyu Islands</option>'
			.'<option value="KN">Saint Kitts and Nevis</option>'
			.'<option value="LC">Saint Lucia</option>'
			.'<option value="VC">Saint Vincent and The Grenadines</option>'
			.'<option value="SM">San Marino</option>'
			.'<option value="ST">Sao Tome And Principe</option>'
			.'<option value="SA">Saudi Arabia</option>'
			.'<option value="SF">Scotland</option>'
			.'<option value="SN">Senegal</option>'
			.'<option value="CS">Serbia and Montenegro</option>'
			.'<option value="RS">Republic of Serbia</option>'
			.'<option value="SC">Seychelles</option>'
			.'<option value="SL">Sierra Leone</option>'
			.'<option value="SG">Singapore</option>'
			.'<option value="SK">Slovakia</option>'
			.'<option value="SI">Slovenia</option>'
			.'<option value="SB">Solomon Islands</option>'
			.'<option value="SO">Somalia</option>'
			.'<option value="ZA">South Africa</option>'
			.'<option value="ES">Spain</option>'
			.'<option value="LK">Sri Lanka</option>'
			.'<option value="SD">Sudan</option>'
			.'<option value="SR">Surinam</option>'
			.'<option value="SZ">Swaziland</option>'
			.'<option value="SE">Sweden</option>'
			.'<option value="CH">Switzerland</option>'
			.'<option value="SY">Syria</option>'
			.'<option value="TW">Taiwan</option>'
			.'<option value="TZ">Tanzania</option>'
			.'<option value="TH">Thailand</option>'
			.'<option value="GM">The Gambia</option>'
			.'<option value="NL">The Netherlands</option>'
			.'<option value="TG">Togo</option>'
			.'<option value="TO">Tonga</option>'
			.'<option value="TL">Tortola</option>'
			.'<option value="TT">Trinidad and Tobago</option>'
			.'<option value="TN">Tunisia</option>'
			.'<option value="TR">Turkey</option>'
			.'<option value="TM">Turkmenistan</option>'
			.'<option value="TC">Turks and Caicos Islands</option>'
			.'<option value="TV">Tuvalu</option>'
			.'<option value="UG">Uganda</option>'
			.'<option value="UA">Ukraine</option>'
			.'<option value="AE">United Arab Emirates</option>'
			.'<option value="GB">United Kingdom</option>'
			.'<option value="UY">Uruguay</option>'
			.'<option value="VU">Vanuatu</option>'
			.'<option value="VE">Venezuela</option>'
			.'<option value="VN">Vietnam</option>'
			.'<option value="WA">Wales</option>'
			.'<option value="WS">Western Samoa</option>'
			.'<option value="ZR">Zaire</option>'
			.'<option value="ZM">Zambia</option>'
			.'<option value="ZW">Zimbabwe</option>'
			.'</select>'
			.'</div>';
	return $field;
}

function getShippingAmount($var){
	$shipping_total = 0;
	$shipping = 'international_shipping';
	$intOrder = internationalOrder($var);
	if($intOrder == 'US'){
		$shipping = 'shipping';
	} else if($intOrder == 'CA'){
		$shipping = 'canada_shipping';
	}
	foreach($var as $key => $value){
		$shipping_price = $_SESSION[$key][$shipping];
		if($value > 0 && isset($shipping_price) && $key !== 'amount'){
			$shipping_total += (float)$shipping_price * (int)$value;
		}
	}		
	return $shipping_total;	
}

function getDiscountAmount($var){
	if($_SESSION[$var['coupon']]){
		$coupon = $_SESSION[$_POST['coupon']];
		if($coupon['type'] === 'percent'){
			$discount = $coupon['percent'] * .01 * getSubtotalAmount($var);
		} else if($coupon['type'] === 'amount'){
			$discount = $coupon['amount'];
		}
	}
	return number_format((float)$discount, 2);
}

function getSubtotalAmount($var){
	$subtotal = 0;
	foreach($var as $key => $value){
		if($value > 0 && isset($_SESSION[$key]['price']) && $key !== 'amount'){
			$subtotal += (float)$_SESSION[$key]['price'] * (int)$value;
		}
	}		
	return $subtotal;	
}

function getTotalAmount($var){
	$subtotal = getSubtotalAmount($var);
	$shipping = getShippingAmount($var);
	$discount = getDiscountAmount($var);
	$total = $subtotal + $shipping - $discount;
	return $total;
}

function internationalOrder($var){ 
	if(isset($var['billing_shipping'])){
		return $var['address_country'];
	} else if(empty($var['billing_shipping'])){
		return $var['shipping_address_country'];
	}
}

function getBillingShippingInfo($var, $style_tr='', $style_td='', $style_h4=''){
	$msg = '';
	$prefix = array('');
	$shipping = array('Billing');
	if(!isset($var['billing_shipping'])){
		$prefix[] = 'shipping_';
		$shipping[] = 'Shipping';
	} else {
		$shipping[0] = 'Billing/Shipping';
	}
	$repeat = sizeof($shipping);
	for($i=0; $i<$repeat; $i++){                        
		$msg .='<tr style="'.$style_tr.'"><td colspan="4" style="'.$style_td.'"><h4 style="'.$style_h4.'">'.$shipping[$i].' Information</h4></td></tr>'
			.'<tr style="'.$style_tr.'"><td style="'.$style_td.'">Name</td><td colspan="3" style="'.$style_td.'">'.$var[$prefix[$i].'name'].'</td></tr>'
			.'<tr style="'.$style_tr.'"><td style="'.$style_td.'">Address</td><td colspan="3" style="'.$style_td.'">'.$var[$prefix[$i].'address_line1'];
		if($var[$prefix[$i].'address_line2'] != ''){
			$msg .='<br />'.$var[$prefix[$i].'address_line2'];
		}
		$msg .='<br />'
			.$var[$prefix[$i].'address_city'].', '
			.$var[$prefix[$i].'address_state'].' '
			.$var[$prefix[$i].'address_zip'].'<br />'
			.$var[$prefix[$i].'address_country'];
		if($shipping[$i]!=='Shipping'){
			$msg .='</td></tr>'
				.'<tr style="'.$style_tr.'"><td style="'.$style_td.'">Email</td><td colspan="3" style="'.$style_td.'">'.$var[$prefix[$i].'email'].'</td></tr>'
				.'<tr style="'.$style_tr.'"><td style="'.$style_td.'">Phone</td><td colspan="3" style="'.$style_td.'">'.$var[$prefix[$i].'phone'].'</td></tr>';
		}	   
	}
	return $msg;
}

function getProductInfo($var, $short=false, $style_tr='', $style_td='', $style_currency='', $style_quantity=''){
	$msg = '';
	if($short){
		$msg .= '<tr><td style="'.$style_td.'" class="title cart-heading" colspan="2">Product</td>';
	} else {
		$msg .= '<tr><td style="'.$style_td.'" class="title cart-heading">Product</td>'
				 .'<td style="'.$style_td.'" class="quantity cart-heading">Qty</td>';
	}
	$msg .= '<td style="'.$style_td.'" class="price cart-heading">Price</td>'
		.'<td style="'.$style_td.'" class="subtotal cart-heading">Subtotal</td></tr>';
	foreach($var as $key => $value){
		if($value > 0 && $_SESSION[$key]['title'] !='' && is_array($_SESSION[$key])){
			$subtotal = (float)$_SESSION[$key]['price'] * (int)$value; 
			$msg .= '<tr style="'.$style_tr.'">';
			if($short){
				$msg .= '<td style="'.$style_td.'" colspan="2">'.$_SESSION[$key]['title'].' ('.$value.')</td>';
			} else {
				$msg .= '<td style="'.$style_td.'">'.$_SESSION[$key]['title'].'</td><td class="quantity" style="'.$style_td.$style_quantity.'">'.$value.'</td>';
			}
			$msg .= '<td class="currency" style="'.$style_td.$style_currency.'">$'.$_SESSION[$key]['price'].'</td>'
				.'<td class="currency" style="'.$style_td.$style_currency.'">$'.number_format((float)$subtotal, 2).'</td>'
				.'</tr>';
		}
	}
	return $msg;
}

function getDiscountInfo($var, $style_tr='', $style_td='', $style_currency=''){
	$amount = number_format((float)getDiscountAmount($var), 2);
	$msg = '';
	if(getDiscountAmount($var) > 0){
		$msg .='<tr class="discount" style="'.$style_tr.'">'
			.'<td colspan="3" class="currency" style="'.$style_td.$style_currency.'">Discount</td>'
			.'<td class="currency" style="'.$style_td.$style_currency.'">-$'.$amount.'</td>'
			.'</tr>';		
	}
	return $msg;	
}

function getShippingInfo($var, $style_tr='', $style_td='', $style_currency=''){
	$amount = number_format((float)getShippingAmount($var), 2);
	if($amount==0){ 
		$amount = 'FREE'; 
	} else {
		$amount = '$' . $amount;
	}
	$msg .='<tr class="shipping" style="'.$style_tr.'">'
			.'<td colspan="3" class="currency" style="'.$style_td.$style_currency.'">';
	if(internationalOrder($var) != 'US'){
		$msg .= 'International ';		
	}
	$msg .=	'Shipping</td>'
			.'<td class="currency" style="'.$style_td.$style_currency.'">'.$amount.'</td>'
			.'</tr>';
	return $msg;
}

function getSubtotalInfo($var, $short=false, $style_tr='', $style_td='', $style_currency=''){
	$amount = number_format((float)getSubtotalAmount($var), 2);
	$msg = '<tr style="'.$style_tr.'">'
		.'<td colspan="3" class="';
	if($short){ 
		$msg .= 'total-amount ';
	}
	$msg .= 'subtotal-amount currency" style="'.$style_td.$style_currency.'">Subtotal</td>'
		.'<td class="';
	if($short){ 
		$msg .= 'total-amount ';
	}
	$msg .= 'subtotal-amount currency" style="'.$style_td.$style_currency.$style_total.'">$'.$amount.'</td>'
		.'</tr>';
	return $msg;
}

function getSubtotalMinusDiscountInfo($var, $short=false, $style_tr='', $style_td='', $style_currency=''){
	$discount = number_format((float)getDiscountAmount($var), 2);
	$amount = number_format((float)getSubtotalAmount($var)-$discount, 2); 
	$msg = '<tr style="'.$style_tr.'">'
		.'<td colspan="3" class="';
	if($short){ 
		$msg .= 'total-amount ';
	}
	$msg .= 'subtotal-amount currency" style="'.$style_td.$style_currency.'">Subtotal</td>'
		.'<td class="';
	if($short){ 
		$msg .= 'total-amount ';
	}
	$msg .= 'subtotal-amount currency" style="'.$style_td.$style_currency.$style_total.'">$'.$amount.'</td>'
		.'</tr>';
	return $msg;
}

function getTotalInfo($var, $style_tr='', $style_td='', $style_currency=''){
	$amount = number_format((float)getTotalAmount($var), 2);
	$msg = '<tr style="'.$style_tr.'">'
		.'<td colspan="3" class="total-amount currency" style="'.$style_td.$style_currency.'">Total</td>'
		.'<td class="total-amount currency" style="'.$style_td.$style_currency.$style_total.'">$'.$amount.'</td>'
		.'</tr>';
	return $msg;
}

function getConfirmationMessage($email=false){
	$style_table = '';
	$style_th = '';
	$style_td = '';
	$style_tr = '';
	$style_h4 = '';
	$style_hr = '';
	$style_total = '';
	$style_currency = '';
	$style_quantity = '';
	$style_cart_heading = '';
	if($email){
		$style_table = getStyleTable();
		$style_th = getStyleTH();
		$style_td = getStyleTD();
		$style_tr = getStyleTR();
		$style_h4 = getStyleH4();
		$style_hr = getStyleHR();
		$style_total = getStyleTotal();
		$style_currency = getStyleCurrency();
		$style_quantity = getStyleQuantity();
		$style_cart_heading = getStyleCartHeading();
	}
	$confirmationMessage = '<table class="results" style="'.$style_table.'"><tbody>'
		.'<tr style="'.$style_tr.'"><th colspan="4" style="'.$style_th.'">SumBlox Order Confirmed!</th></tr> '
		.'<tr style="'.$style_tr.'"><td colspan="4" style="'.$style_td.'"><p><strong>Order Number:</strong> '.$_POST['transaction_id'].'</p>';
	$confirmationMessage .= getThankYouMessage($email);
	$confirmationMessage .= '</td></tr>';
	$confirmationMessage .= getBillingShippingInfo($_POST, $style_tr, $style_td, $style_h4);
	$confirmationMessage .='<tr style="'.$style_tr.'"><td colspan="4" style="'.$style_td.'"><h4 style="'.$style_h4.'">Order Information</h4></td></tr>';
		
	$confirmationMessage .= getProductInfo($_POST, false, $style_tr, $style_td, $style_currency, $style_quantity);
	$confirmationMessage .= getDiscountInfo($_POST, $style_tr, $style_td, $style_currency);	
	$confirmationMessage .= "<tr><td colspan='2'></td><td colspan='2'><hr style='$style_hr'/></td></tr>";
	$confirmationMessage .= getSubtotalMinusDiscountInfo($_POST, false, $style_tr, $style_td, $style_currency);	
	$confirmationMessage .= getShippingInfo($_POST, $style_tr, $style_td, $style_currency);
	$confirmationMessage .= getTotalInfo($_POST, $style_tr, $style_td, $style_currency);
	$confirmationMessage .= '</tbody></table>';
	return $confirmationMessage;
}

function getQuoteMessage($email=false){
	$quote_table = '';
	$style_table = '';
	$style_th = '';
	$style_td = '';
	$style_tr = '';
	$style_h4 = '';
	$style_hr = '';
	$style_total = '';
	$style_currency = '';
	if($email){
		$quote_table = getQuoteTable();
		$style_table = getStyleTable();
		$style_th = getStyleTH();
		$style_td = getStyleTD();
		$style_tr = getStyleTR();
		$style_h4 = getStyleH4();
		$style_hr = getStyleHR();
		$style_total = getStyleTotal();
		$style_currency = getStyleCurrency();
	}
	$quoteMessage = "<div class='quote-table-wrapper'><table class='quote-table' style='$style_table $quote_table'><tbody style='$style_tbody'>"
		."<tr style='$style_tr'><td style='$style_td'><a href='/update2/index.php'><img class='logo' src='http://www.sumblox.com/update2/images/LogoThick4.gif' alt='SumBlox Logo'></a></td><td style='$style_td'><h4 style='$style_h4'>Pricing Quote</h4></td></tr>"
		."<tr style='$style_tr'><td style='$style_td'><strong>Sumblox Group</strong><br><a href='http://www.sumblox.com'>www.sumblox.com</a></td>"
		."<td style='$style_td'><table style='float:right;border:1px solid #333;'><tbody><tr><td style='background-color:#999;border-right:1px solid #333;'>Quote Date</td><td>";
	$mydate=getdate(date("U"));
	$quoteMessage .= "$mydate[month] $mydate[mday], $mydate[year]"
		."</td></tr></tbody></table></td></tr>"
		."<tr style='$style_tr'><td style='$style_td'>"
		."<strong>David Skaggs</strong>, Founder<br>"
		."<a href='mailto:dskaggs@sumblox.com'>dskaggs@sumblox.com</a><br>"
		."P: 1-888-368-1211<br>"
		."F: 1-888-238-7690"
		."</td><td style='$style_td'></td></tr>"
		."<tr style='$style_tr'><td style='$style_td'><strong>ATTN:</strong><br>";
	$quoteMessage .= $_POST['shipping_name']."<br>";
	$quoteMessage .= $_POST['title']."<br>";
	$quoteMessage .= $_POST['school']."<br>";
	$quoteMessage .= $_POST['district']."<br>";
	$quoteMessage .= $_POST['shipping_phone']."<br>"; 
	$quoteMessage .= "</td><td style='$style_td'></td></tr>"
		."<tr style='$style_tr'><td style='$style_td'><strong>Make Checks To:</strong><br>"
		."SumBlox Group</td><td style='$style_td'></td></tr>"
		."<tr style='$style_tr'><td style='$style_td'><strong>Send Payment To:</strong>"
		."<br>P.O. Box 445<br>Paradise, UT 84328<br></td><td style='$style_td'></td></tr>"
		."<tr style='$style_tr'><td style='$style_td' col='2'>";
		
	$quoteMessage .="<tr style='$style_tr'><td colspan='2' style='$style_td'><strong>Order Information</strong></td></tr>"
		."<tr><td colspan='2'><table style='width:95%;float:right;'><tbody>";	
	$quoteMessage .= getProductInfo($_POST, false, $style_tr, $style_td, $style_currency);
	$quoteMessage .= getDiscountInfo($_POST, $style_tr, $style_td, $style_currency);	
	$quoteMessage .= "<tr><td colspan='2'></td><td colspan='2'><hr style='$style_hr'/></td></tr>";
	$quoteMessage .= getSubtotalMinusDiscountInfo($_POST, false, $style_tr, $style_td, $style_currency);	
	$quoteMessage .= getShippingInfo($_POST, $style_tr, $style_td, $style_currency);
	$quoteMessage .= getTotalInfo($_POST, $style_tr, $style_td, $style_currency);
	
	$quoteMessage .= "</tbody></table></td></tr><tr style='$style_tr'><td style='$style_td' colspan='3'><strong>Notes</strong></td></tr>"
		."<tr style='$style_tr'><td style='$style_td;' colspan='3'>".$_POST['notes']."</td></tr></tbody></table></div>"; 
	return $quoteMessage;
}
?>
