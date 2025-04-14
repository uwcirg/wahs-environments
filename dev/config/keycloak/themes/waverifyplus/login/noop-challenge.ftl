<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
	    <i class="fa-solid fa-virus-covid"></i>
        ${msg("loginAccountTitle")}
    <#elseif section = "show-username">
    <#elseif section = "form">
	    <div id="kc-form" class="container-sm">
		    <div id="kc-form-wrapper">
			    <p> Thank you. </p>
			    <p> Your request has been received. If the information provided matches the information in
				    our system, you will receive a link to access your WA Verify+ account.</p>
			    <p> If you do not receive a link within 24 hours, please try again and make sure your name,
				    date of birth, phone or email are entered correctly.</p>
		    </div>
	    </div>
    </#if>
</@layout.registrationLayout>
