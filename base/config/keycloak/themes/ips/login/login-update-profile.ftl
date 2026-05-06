<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section = "header">
        ${msg("loginProfileTitle")}
    <#elseif section = "form">
        <form id="kc-update-profile-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">

            <@userProfileCommons.userProfileFormFields displayRequiredFields=true/>

            <script>
                document.addEventListener("DOMContentLoaded", () => {
                    const termsTimestampTextInput = document.getElementById("terms_and_conditions");
                    const checkbox = document.getElementById("termsAccepted");
                    if (!checkbox || !termsTimestampTextInput) {
                        console.warn("Terms and conditions input not found");
                        return;
                    }

                    const termsTextBox = document.getElementById("kc-terms-text");

                    // Move the terms content next to the terms timestamp field and hide the timestamp
                    if (termsTimestampTextInput) termsTimestampTextInput.style.display = "none";
                    termsTimestampTextInput?.parentNode?.append(termsTextBox);

                    const registerButton = document.querySelector('#kc-form-buttons input[type="submit"]');
                    const buttonTitle = registerButton?.title;
                    const updateRegisterButton = () => {
                        if (!registerButton || !checkbox) return;
                        registerButton.disabled = !checkbox.checked;
                        registerButton.title = checkbox.checked ? buttonTitle : 'Please accept the terms and conditions.';
                    };
                    updateRegisterButton();

                    checkbox.addEventListener("change", () => {
                        termsTimestampTextInput.value = checkbox.checked
                        ? Math.floor(Date.now() / 1000).toString()
                        : "";
                        updateRegisterButton();
                    });
                });
            </script>
            
            <div id="kc-terms-text">
                <#assign termsFileName = properties.termsFileName!"terms-text-default.html">
                <#include termsFileName>
                <div class="${properties.kcFormButtonsClass!}">
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

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                    </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <#if isAppInitiatedAction??>
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" title="${msg("doContinue")}" value="${msg("doContinue")}" />
                        <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel-aia" value="true" formnovalidate>${msg("doCancel")}</button>
                    <#else>
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" title="${msg("doContinue")}" value="${msg("doContinue")}" />
                    </#if>
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>