<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
        <#if section = "header">
                ${msg("loginAccountTitle")}
        <#elseif section = "form">
                <div id="kc-form">
                        <div id="kc-form-wrapper">
                                <#if realm.password>
                                        <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                                                <#if !usernameHidden??>
                                                        <div class="${properties.kcFormGroupClass!}">
                                                                <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                                                                <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off"
                                                                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                                                />

                                                                <#if messagesPerField.existsError('username','password')>
                                                                        <span id="input-error" class="${properties.kcInputErrorMessageClass!} error-text" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                                                                </#if>

                                                        </div>
                                                </#if>

                                                <div class="${properties.kcFormGroupClass!}">
                                                        <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>

                                                        <input tabindex="2" id="password" class="${properties.kcInputClass!}" name="password" type="password" autocomplete="off"
                                                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                                        />

                                                        <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                                                                <span id="input-error" class="${properties.kcInputErrorMessageClass!} error-text" aria-live="polite">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                        </span>
                                                        </#if>

                                                </div>

                                                <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                                                        <div id="kc-form-options">
                                                                <#if realm.rememberMe && !usernameHidden??>
                                                                        <div class="checkbox">
                                                                                <label>
                                                                                        <#if login.rememberMe??>
                                                                                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                                                                        <#else>
                                                                                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                                                                        </#if>
                                                                                </label>
                                                                        </div>
                                                                </#if>
                                                        </div>
                                                        <div class="${properties.kcFormOptionsWrapperClass!}">
                                                                <#if realm.resetPasswordAllowed>
                                                                        <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                                                                </#if>
                                                        </div>

                                                </div>

                                                <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                                                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                                                        <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                                                </div>
                                        </form>
                                </#if>
                        </div>

                </div>
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
                                                                                <span class="gsi-material-button-contents">Sign in with Google</span>
                                                                                <span style="display: none;">Sign in with Google</span>
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
                                        <span class="divider-text">or sign in using email</span>
                                        <div class="divider-line"></div>
                                </div>
                        </div>
                </#if>
        <#elseif section = "info" >
                <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                        <div id="kc-registration-container">
                                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="${url.registrationUrl}">${msg("registerTitle")}</a></span>
                                </div>
                        </div>
                </#if>
        </#if>

</@layout.registrationLayout>
