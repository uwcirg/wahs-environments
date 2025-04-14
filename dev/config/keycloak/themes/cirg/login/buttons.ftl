<#macro actionGroup>
	<div class="${properties.kcFormGroupClass}">
		<div class="${properties.kcFormActionGroupClass}">
                    <#nested>
		</div>
	</div>
</#macro>

<#macro button label id="" name="" class=["kcButtonPrimaryClass"]>
	<button class="<#list class as c>${properties[c]} </#list>" name="${name}" id="${id}"
	        type="submit">${msg(label)}</button>
</#macro>

<#macro buttonLink href label id="" class=["kcButtonSecondaryClass"]>
	<a id="${id}" href="${href}"
	   class="<#list class as c>${properties[c]} </#list>">${kcSanitize(msg(label))?no_esc}</a>
</#macro>

<#macro loginButton>
    <@buttons.actionGroup>
        <@buttons.button id="kc-login" name="login" label="doLogIn" class=["kcButtonClass","kcButtonPrimaryClass", "kcButtonBlockClass"] />
    </@buttons.actionGroup>
</#macro>

<#macro tryAnotherWay class=["kcButtonClass","kcButtonPrimaryClass", "kcButtonBlockClass"]>
    <@buttons.actionGroup>
	    <input type="hidden" name="tryAnotherWay"
	           value="on"/>
	    <button href="#" id="try-another-way" class="<#list class as c>${properties[c]} </#list>"
	            onclick="document.forms['kc-select-try-another-way-form'].submit();return
		    false;">${msg("doTryAnotherWay")}</button>
    </@buttons.actionGroup>
</#macro>

<#macro registration class=["kcButtonClass","kcButtonPrimaryClass","kcButtonLinkClass"]>
    <@buttons.actionGroup>
	    <button onclick="window.location.href='${url.registrationUrl}'"
	            class="<#list class as c>${properties[c]} </#list>">
                ${msg("doRegister")}
	    </button>
    </@buttons.actionGroup>
</#macro>
