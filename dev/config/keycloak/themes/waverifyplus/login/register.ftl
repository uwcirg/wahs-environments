<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<#import "user-profile-commons.ftl" as userProfileCommons>
<#import "register-commons.ftl" as registerCommons>
<#import "password-validation.ftl" as validator>
<#if demographicRequired??>
    <#import "demographic-registration.ftl" as demographic>
</#if>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=false; section>
	<!-- template: register.ftl -->

    <#if section = "header">
	    <i class="fa-solid fa-virus-covid"></i>
        <#if messageHeader??>
            ${kcSanitize(msg("${messageHeader}"))?no_esc}
        <#else>
            ${msg("registerTitle")}
        </#if>
    <#elseif section = "form">
        <#include "intro.ftl">
	    <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}"
	          method="post" novalidate="novalidate">
                <@userProfileCommons.userProfileFormFields; callback, attribute>
                    <#if callback = "afterField">
                    <#-- render password fields just under the username or email (if used as username) -->
                        <#if passwordRequired?? && (attribute.name == 'username' || (attribute.name == 'email' && realm.registrationEmailAsUsername))>
                            <@field.password name="password" required=true label=msg("password") autocomplete="new-password" />
                            <@field.password name="password-confirm" required=true label=msg("passwordConfirm") autocomplete="new-password" />
                        </#if>
                    </#if>
                </@userProfileCommons.userProfileFormFields>

                <#if demographicRequired??>
                    <@demographic.demographicRegistration />
                </#if>

                <@registerCommons.termsAcceptance/>

                <@field.checkbox name="authorization" label=msg("authorization") required=true>
                    <#include "authorization.ftl">
                </@field.checkbox>

                <#if recaptchaRequired?? && (recaptchaVisible!false)>
			<div class="form-group">
				<div class="${properties.kcInputWrapperClass!}">
					<div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"
					     data-action="${recaptchaAction}"></div>
				</div>
			</div>
                </#if>

                <#if recaptchaRequired?? && !(recaptchaVisible!false)>
			<script>
                            function onSubmitRecaptcha(token) {
                                document.getElementById("kc-register-form").requestSubmit();
                            }
			</script>
			<div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
				<button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} g-recaptcha"
				        data-sitekey="${recaptchaSiteKey}" data-callback="onSubmitRecaptcha"
				        data-action="${recaptchaAction}" type="submit">
                                    ${msg("doRegister")}
				</button>
			</div>
                <#else>
			<div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
				<button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
				        type="submit">
                                    ${msg("doRegister")}
				</button>
			</div>
                </#if>

		    <div class="${properties.kcFormGroupClass!} pf-v5-c-login__main-footer-band">
			    <div id="kc-form-options"
			         class="${properties.kcFormOptionsClass!} pf-v5-c-login__main-footer-band-item">
				    <div class="${properties.kcFormOptionsWrapperClass!}">
					    <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
				    </div>
			    </div>
		    </div>

	    </form>

        <@validator.templates/>
        <@validator.script field="password"/>
    </#if>
</@layout.registrationLayout>
