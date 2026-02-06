<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("registerTitle")}
    <#elseif section = "form">
        <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">
        
            <div class="${messagesPerField.printIfExists('firstName',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="firstName" class="${properties.kcLabelClass!}">${msg("firstName")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="firstName" class="${properties.kcInputClass!}" name="firstName" value="${(register.formData.firstName!'')}" />
                </div>
            </div>

            <div class="${messagesPerField.printIfExists('lastName',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="lastName" class="${properties.kcLabelClass!}">${msg("lastName")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="lastName" class="${properties.kcInputClass!}" name="lastName" value="${(register.formData.lastName!'')}" />
                </div>
            </div>

            <div class="${messagesPerField.printIfExists('email',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="email" class="${properties.kcLabelClass!}">${msg("email")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="email" id="email" class="${properties.kcInputClass!}" name="email" value="${(register.formData.email!'')}" autocomplete="email"/>
                </div>
            </div>

          <#if !realm.registrationEmailAsUsername>
            <div class="${messagesPerField.printIfExists('username',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="username" class="${properties.kcLabelClass!}">${msg("username")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="username" class="${properties.kcInputClass!}" name="username" value="${(register.formData.username!'')}" autocomplete="username" />
                </div>
            </div>
          </#if>

            <#if passwordRequired??>
            <div class="${messagesPerField.printIfExists('password',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password" class="${properties.kcInputClass!}" name="password" autocomplete="new-password"/>
                </div>
            </div>

            <div class="${messagesPerField.printIfExists('password-confirm',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password-confirm" class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password-confirm" class="${properties.kcInputClass!}" name="password-confirm" autocomplete="new-password"/>
                </div>
            </div>
            </#if>

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
                                    <input type="checkbox" id="termsAccepted" name="termsAccepted" value='${msg("acceptTerms")}' class="${properties.kcCheckboxInputClass!}"
                                        aria-invalid="<#if messagesPerField.existsError('termsAccepted')>true</#if>"
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
                            document.getElementById('termsAccepted').addEventListener('change', updateTerms);
                        });
                        
                        function updateTerms() {
                            const termsCheckbox = document.getElementById('termsAccepted');
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
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers??>
                <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                        <!-- <h4>${msg("identity-provider-login-label")}</h4> -->
                        <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                                <#list social.providers as p>
                                        <li style="width: 100%" class="${properties.kcFormGroupClass!}">
                                                <#if p.alias = "google">
                                                        <button class="gsi-material-button" style="width:100%" onclick="location.href='${p.loginUrl}'">
                                                                <div class="gsi-material-button-state"></div>
                                                                <div class="gsi-material-button-content-wrapper">
                                                                        <div class="gsi-material-button-icon">
                                                                                <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" xmlns:xlink="http://www.w3.org/1999/xlink" style="display: block;">
                                                                                        <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"></path>
                                                                                        <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"></path>
                                                                                        <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"></path>
                                                                                        <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"></path>
                                                                                        <path fill="none" d="M0 0h48v48H0z"></path>
                                                                                </svg>
                                                                        </div>
                                                                        <span class="gsi-material-button-contents">Sign up with Google</span>
                                                                        <span style="display: none;">Sign up with Google</span>
                                                                </div>
                                                        </button>
                                                <#else>
                                                        <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                                        type="button" href="${p.loginUrl}">
                                                                <#if p.iconClasses?has_content>
                                                                        <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                                                        <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                                                                <#else>
                                                                        <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                                                                </#if>
                                                        </a>
                                                </#if>
                                        </li>
                                </#list>
                        </ul>

                        <div class="divider-center-text">
                                <div class="divider-line"></div>
                                <span class="divider-text">or sign up using email</span>
                                <div class="divider-line"></div>
                        </div>
                </div>
        </#if>
    </#if>
</@layout.registrationLayout>
