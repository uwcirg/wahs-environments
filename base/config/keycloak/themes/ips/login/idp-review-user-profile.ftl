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
              
                  // Hide terms and conditions timestamp form group
                  const termsTimestampTextInput = document.getElementById("terms_and_conditions");
                  const termsTimestampTextInputFormGroup = termsTimestampTextInput?.closest("div.form-group");
                  if (termsTimestampTextInputFormGroup) termsTimestampTextInputFormGroup.style.display = "none";
              
                  //
                  const checkbox = document.getElementsByName("terms-conditions")[0];
              
                  const registerButton = document.querySelector('#kc-form-buttons input[type="submit"]');
                  const buttonTitle = registerButton.title;
                  const updateRegisterButton = () => {
                      if (!registerButton) return;
                      registerButton.disabled = !checkbox.checked;
                      registerButton.title = checkbox.checked ? buttonTitle : 'Please accept the terms and conditions.';
                  };
                  updateRegisterButton();
                  
                  if (!checkbox || !termsTimestampTextInput) return;
                  checkbox.addEventListener("change", () => {
                      termsTimestampTextInput.value = checkbox.checked
                      ? Math.floor(Date.now() / 1000).toString()
                      : "";
                      updateRegisterButton();
                  });
                  
                  const checkboxField = checkbox.closest("div.pf-c-check");
                  const checkboxFieldInput = checkboxField.querySelector("input[type='checkbox']");
                  const checkboxFieldParent = checkboxField.parentNode;
                  const termsTextBox = document.getElementById("kc-terms-text");
                  const termsButtonCheckbox = termsTextBox?.querySelector(".btn-checkbox");
              
                  // Insert the terms and conditions text next to the checkbox field
                  checkboxFieldParent.append(termsTextBox);
                  // Move the checkbox into the terms and conditions text's button checkbox input, where it's hidden
                  termsButtonCheckbox.append(checkboxFieldInput);
                  // Finally, remove the checkbox field
                  checkboxField.remove();
              });
            </script>

            <div id="kc-terms-text">
                ${kcSanitize(msg("termsText"))?no_esc}
                <div class="${properties.kcFormButtonsClass!}">
                    <label class="btn-checkbox ${properties.kcButtonClass!}" style="width: 100%">
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
                      <span><a href="${url.loginRestartFlowUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                    </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <input style="margin-bottom: 1em" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" title="${msg("doRegister")}" value="${msg("doRegister")}" />
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>