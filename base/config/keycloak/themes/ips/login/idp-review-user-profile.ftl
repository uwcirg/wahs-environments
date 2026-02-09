<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section = "header">
        ${msg("loginIdpReviewProfileTitle")}
    <#elseif section = "form">
        <form id="kc-idp-review-profile-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">

            <@userProfileCommons.userProfileFormFields/>

            <script>
              document.addEventListener("DOMContentLoaded", () => {
                  // Hide email form group
                  const emailInput = document.getElementById("email");
                  const emailFormGroup = emailInput?.closest("div.form-group");
                  if (emailFormGroup) emailFormGroup.style.display = "none";
              
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

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                      <span><a href="${url.loginRestartFlowUrl}">${kcSanitize(msg("cancelRegistration"))?no_esc}</a></span>
                    </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <input style="margin-bottom: 1em" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" title="${msg("doRegister")}" value="${msg("doRegister")}" />
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>