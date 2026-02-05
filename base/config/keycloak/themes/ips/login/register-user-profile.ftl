<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section = "header">
        ${msg("registerTitle")}
    <#elseif section = "form">
        <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">
        
            <@userProfileCommons.userProfileFormFields; callback, attribute>
                <#if callback = "afterField">
                  <#-- render password fields just under the username or email (if used as username) -->
                <#if passwordRequired?? && (attribute.name == 'username' || (attribute.name == 'email' && realm.registrationEmailAsUsername))>
                    <div class="${properties.kcFormGroupClass!}">
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label> *
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                            <input type="password" id="password" class="${properties.kcInputClass!}" name="password"
                                   autocomplete="new-password"
                                   aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                            />
    
                            <#if messagesPerField.existsError('password')>
                                <span id="input-error-password" class="${properties.kcInputErrorMessageClass!} error-text" aria-live="polite">
                                    ${kcSanitize(messagesPerField.get('password'))?no_esc}
                                </span>
                            </#if>
                        </div>
                    </div>
    
                    <div class="${properties.kcFormGroupClass!}">
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="password-confirm"
                                   class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label> *
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                            <input type="password" id="password-confirm" class="${properties.kcInputClass!}"
                                   name="password-confirm"
                                   autocomplete="new-password"
                                   aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                            />
    
                            <#if messagesPerField.existsError('password-confirm')>
                                <span id="input-error-password-confirm" class="${properties.kcInputErrorMessageClass!} error-text" aria-live="polite">
                                    ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                                </span>
                            </#if>
                        </div>
                    </div>
                </#if>
                </#if>  
            </@userProfileCommons.userProfileFormFields>
            
            <#if recaptchaRequired??>
                <div class="form-group">
                    <div class="${properties.kcInputWrapperClass!}">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </div>
            </#if>

            <#if termsAcceptanceRequired??>
                <div class="form-group">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label class="${properties.kcLabelClass!}">${msg("termsTitle")}</label>
                    </div>
                    <div class="${properties.kcLabelWrapperClass!} subtitle">
                        Please read and accept the terms below to continue.
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <div id="kc-terms-text">
                            ${kcSanitize(msg("termsText"))?no_esc}
                            <div class="${properties.kcFormButtonsClass!} p-0">
                                <label class="btn-checkbox ${properties.kcButtonClass!}" style="width: 100%">
                                    <input type="checkbox" id="terms-conditions" name="terms-conditions" value='${msg("acceptTerms")}' class="${properties.kcCheckboxInputClass!}"
                                        aria-invalid="<#if messagesPerField.existsError('terms-conditions')>true</#if>"
                                    />
                                    <i class="bi-square"></i>
                                    <i class="bi-check-square-fill"></i>
                                    <span class="btn-checkbox-text">
                                        ${msg("acceptTerms")}
                                    </span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div style="display: none" class="${properties.kcLabelWrapperClass!}">
                        <input type="text" id="terms_and_conditions" name="terms_and_conditions" class="${properties.kcTextInputClass!}"
                            aria-invalid="<#if messagesPerField.existsError('terms_and_conditions')>true</#if>"
                        />
                        <label for="terms_and_conditions" class="${properties.kcLabelClass!}">${msg("acceptTerms")}</label>
                    </div>
                    <script>
                        let submitButton;
                        let defaultSubmitButtonTitle;
                        function updateRegisterButton(termsAccepted) {
                            if (!submitButton) return;
                            submitButton.disabled = !termsAccepted;
                            submitButton.title = termsAccepted ? defaultSubmitButtonTitle : 'Please accept the terms and conditions.'
                        }
                        
                        document.addEventListener('DOMContentLoaded', () => {
                            submitButton = document.querySelector('#kc-form-buttons input[type="submit"]');
                            if (submitButton) {
                                defaultSubmitButtonTitle = submitButton.title;
                                updateRegisterButton(false);
                            }
                            document.getElementById('terms-conditions').addEventListener('change', updateTerms);
                        });
                        
                        function updateTerms() {
                            const termsCheckbox = document.getElementById('terms-conditions');
                            const termsTextInput = document.getElementById('terms_and_conditions');
                            termsTextInput.value = termsCheckbox.checked ? Math.floor(Date.now() / 1000).toString() : '';
                            updateRegisterButton(termsCheckbox.checked);
                        };
                    </script>
                </div>
            </#if>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                        <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                    </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" title="${msg("doRegister")}" value="${msg("doRegister")}"/>
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>