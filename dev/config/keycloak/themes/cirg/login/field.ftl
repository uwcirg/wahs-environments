<#macro group name label error="" required=false>

	<div class="${properties.kcFormGroupClass}">
		<div class="${properties.kcLabelWrapperClass}">
			<label for="${name}" class="${properties.kcFormGroupLabelClass}">
                        <span class="${properties.kcFormGroupLabelTextClass}">
                            ${label}
                        </span>
                            <#if required>
				    <span class="${properties.kcInputRequiredClass}" aria-hidden="true">&#42;</span>
                            </#if>
			</label>
		</div>

            <#nested>

		<div id="input-error-container-${name}">
                    <#if error?has_content>
			    <div class="${properties.kcFormHelperTextClass}" aria-live="polite">
				    <div class="${properties.kcInputHelperTextClass}">
					    <div class="${properties.kcInputHelperTextItemClass} ${properties.kcError}"
					         id="input-error-${name}">
                                                <span class="${properties.kcInputErrorMessageClass}">
                                                    ${error}
                                                </span>
					    </div>
				    </div>
			    </div>
                    </#if>
		</div>
	</div>

</#macro>

<#macro errorIcon error="">
    <#if error?has_content>
	    <span class="${properties.kcFormControlUtilClass}">
        <span class="${properties.kcInputErrorIconStatusClass}">
          <i class="${properties.kcInputErrorIconClass}" aria-hidden="true"></i>
        </span>
    </span>
    </#if>
</#macro>

<#macro input name label value="" required=false autocomplete="off" type="text" fieldName=name autofocus=false>
    <#assign error=kcSanitize(messagesPerField.get(fieldName))?no_esc>
    <@group name=name label=label error=error required=required>
	    <span class="${properties.kcInputWrapperClass!} <#if error?has_content>${properties.kcError}</#if>">
	        <input id="${name}" name="${name}" value="${value}" type="${type}" class="${properties.kcInputClass!}"
	               autocomplete="${autocomplete}"
                       <#if autofocus>autofocus</#if>
	                aria-invalid="<#if error?has_content>true</#if>"/>
	        <@errorIcon error=error/>
	    </span>
    </@group>
</#macro>

<#macro password name label value="" required=false forgotPassword=false fieldName=name autocomplete="off" autofocus=false>
    <#assign error=kcSanitize(messagesPerField.get(fieldName))?no_esc>
    <@group name=name label=label error=error required=required>

	    <span class="${properties.kcInputWrapperClass!} <#if error?has_content>${properties.kcError}</#if>">
		<input id="${name}" name="${name}" value="${value}" type="password" class="${properties.kcInputClass!}"
		       autocomplete="${autocomplete}"
                       <#if autofocus>autofocus</#if> aria-invalid="<#if error?has_content>true</#if>"/>
		<@errorIcon error=error/>
	</span>

        <#if forgotPassword>
		<div class="${properties.kcFormHelperTextClass}" aria-live="polite">
			<div class="${properties.kcInputHelperTextClass}">
				<div class="${properties.kcInputHelperTextItemClass}">
		                    <span class="${properties.kcInputHelperTextItemTextClass}">
		                        <a href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
		                    </span>
				</div>
			</div>
		</div>
        </#if>
    </@group>
</#macro>

<#macro checkbox name label value=false required=false>
	<div class="${properties.kcCheckboxClass}">
		<label for="${name}" class="${properties.kcCheckboxClass}">
			<input
				class="${properties.kcCheckboxInputClass}"
				type="checkbox"
				id="${name}"
				name="${name}"
                                <#if value>checked</#if>
			/>
			<span class="${properties.kcCheckboxLabelClass}">${label}</span>
                    <#if required>
			    <span class="${properties.kcCheckboxLabelRequiredClass}" aria-hidden="true">&#42;</span>
                    </#if>
		</label>
            <#nested>
	</div>
</#macro>
