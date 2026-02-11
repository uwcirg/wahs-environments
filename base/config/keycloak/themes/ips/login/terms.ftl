<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
  <#if section = "header">
    ${msg("termsTitle")}
  <#elseif section = "form">
  <div id="kc-terms-updated-text">
    ${kcSanitize(msg("termsUpdatedText"))?no_esc}
  </div>
  <br>
  <form class="form-actions" action="${url.loginAction}" method="POST">
    <div id="kc-terms-text">
      <#assign termsFile = realm.attributes.termsFile!"terms-text-default.html">
      <#include termsFile>
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
    <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} row">
      <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
        <button class="cancel-button ${properties.kcButtonClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="cancel" id="kc-decline" type="submit">${msg("doDecline")}</button>
      </div>
      <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="accept" id="kc-accept" type="submit" value="${msg("doConfirm")}"/>
      </div>
    </div>
  </form>
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
      updateRegisterButton(termsCheckbox.checked);
    };
  </script>
  <div class="clearfix"></div>
  </#if>
</@layout.registrationLayout>