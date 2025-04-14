<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<#import "buttons.ftl" as buttons>
<#import "social-providers.ftl" as identityProviders>
<#if demographicRequired??>
    <#import "demographic-field.ftl" as demographicFiled>
    <#import "demographic-registration.ftl" as demographic>
</#if>
<#if pinRequired??>
    <#import "demographic-field.ftl" as demographicFiled>
    <#import "pin.ftl" as pinForm>
</#if>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
	<!-- template: login.ftl -->

    <#if section = "header">
	    <i class="fa-solid fa-virus-covid"></i>
        ${msg("loginAccountTitle")}
    <#elseif section = "show-username">
    <#elseif section = "form">
        <#include "intro.ftl">
	    <div id="kc-form" class="container-sm">
		    <div id="kc-form-wrapper">
                        <#if realm.password>
				<form id="kc-form-login" class="${properties.kcFormClass!}"
				      onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
				      method="post" novalidate="novalidate">
                                    <#if demographicRequired?? && demographicRequired>
					    <h2 class="form-prompt">${msg("demographicFormPrompt")}</h2>
					    <p>Required fields marked with *</p>
                                    </#if>
                                    <#if !usernameHidden?? >
                                        <#assign label>
                                            <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
                                        </#assign>
                                        <#if !realm.loginWithEmailAllowed>
                                            <@field.input name="username" label=label autofocus=true autocomplete="username" value=login.username!'' required=true/>
                                        <#elseif !realm.registrationEmailAsUsername>
                                            ${msg("usernameOrEmail")}
                                            <@field.input name="username" label=label autofocus=true autocomplete="username" value=login.username!'' required=true/>
                                        <#else>
                                            <@field.input name="email" label=label autofocus=true autocomplete="email" value='' required=true/>
                                        </#if>
                                    </#if>

                                    <#if demographicRequired?? && demographicRequired>
                                        <@demographic.demographicRegistration />
                                    <#elseif pinRequired?? && pinRequired>
                                        <@pinForm.pin />
                                    <#else>
                                        <@field.password name="password" label=msg("password") forgotPassword=realm.resetPasswordAllowed autofocus=usernameHidden?? autocomplete="current-password" />

					    <div class="${properties.kcFormGroupClass!}">
                                                <#if realm.rememberMe && !usernameHidden??>
                                                    <@field.checkbox name="rememberMe" label=msg("rememberMe") value=login.rememberMe?? />
                                                </#if>
					    </div>

					    <input type="hidden" id="id-hidden-input" name="credentialId"
                                                   <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                                    </#if>

                                    <@field.checkbox name="authorization" label=msg("authorization") required=true>
                                        <#include "authorization.ftl">
                                    </@field.checkbox>

                                    <@buttons.loginButton />

                                    <#if demographicRequired?? && demographicRequired>
					    <div class="form-note">
						    <span>Note:</span>
						    <p>${msg("submitNote")}</p>
					    </div>
					    <div class="form-note">
						    <span>Note regarding immunizations:</span>
						    <p>The system will provide a digital
							    copy of state vaccine records. If you received your
							    vaccinations from a federal agency (Department of Defense,
							    Indian Health Services, or Veterans Affairs), you will need
							    to contact those agencies for assistance.</p>
					    </div>
                                    </#if>
				</form>
                        </#if>
		    </div>
	    </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
		<div id="kc-registration-container" class="${properties.kcLoginFooterBand!}">
			<div id="kc-registration" class="${properties.kcLoginFooterBandItem!}">
                            <@buttons.registration />
			</div>
		</div>
        </#if>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers?? && social.providers?has_content>
            <@identityProviders.show social=social/>
        </#if>
    </#if>

</@layout.registrationLayout>
