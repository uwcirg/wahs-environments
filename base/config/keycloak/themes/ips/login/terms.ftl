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
      ${kcSanitize(msg("termsText"))?no_esc}
      <br>
      <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="accept" id="kc-accept" type="submit" value="${msg("doAccept")}"/>
    </div>
    <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
      <input class="cancel-button ${properties.kcButtonClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="cancel" id="kc-decline" type="submit" value="${msg("doDecline")}"/>
    </div>
  </form>
  <div class="clearfix"></div>
  </#if>
</@layout.registrationLayout>