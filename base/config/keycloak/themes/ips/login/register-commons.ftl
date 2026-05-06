<#macro termsAcceptance>
  <#if termsAcceptanceRequired??>
      <div class="form-group">
          <div class="${properties.kcInputWrapperClass!}">
              <div id="kc-terms-text">
                  <#assign termsFileName = properties.termsFileName!"terms-text-default.html">
                  <#include termsFileName>
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
          <#-- <div style="display: none" class="${properties.kcLabelWrapperClass!}">
              <input type="text" id="terms_and_conditions" name="terms_and_conditions" class="${properties.kcTextInputClass!}"
                  aria-invalid="<#if messagesPerField.existsError('terms_and_conditions')>true</#if>"
              />
              <label for="terms_and_conditions" class="${properties.kcLabelClass!}">${msg("acceptTerms")}</label>
          </div> -->
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
  </#if>
</#macro>