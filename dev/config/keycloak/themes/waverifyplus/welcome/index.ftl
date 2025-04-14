<!DOCTYPE html>
<html class="${properties.kcHtmlClass!}">

<head>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
		<meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>

	<title>${properties.productName!'waverifyplus'}</title>
	<link rel="icon" href="${resourcesPath}/img/favicon.ico"/>

    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
		<link href="${resourcesPath}/${style}" rel="stylesheet"/>
        </#list>
    </#if>

    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
		<link href="${resourcesPath}/${style}" rel="stylesheet"/>
        </#list>
    </#if>

    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
		<script src="${resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>

    <#if scripts??>
        <#list scripts as script>
		<script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
</head>

<body class="${properties.kcBodyClass!} cherry-page">
<header id="header" class="container-fluid text-center py-2 m-0">
	<img src="${resourcesPath}/${properties.headerLogo}"
	     alt="Clinical Informatics Research Group" class="img-fluid mx-auto d-block"
	     style="max-height: 80px;">
</header>

<main class="container-fluid">
	<div class="row">
            <#if adminConsoleEnabled>
		    <div>
                        <#if successMessage?has_content>
				<p class="alert success">${successMessage}</p>
                        <#elseif errorMessage?has_content>
				<p class="alert error">${errorMessage}</p>
				<h3><img src="welcome-content/user.png">Administration Console
				</h3>
                        <#elseif bootstrap>
                            <#if localUser>
				    <h3><img src="welcome-content/user.png">Administration
					    Console</h3>
				    <p>Please create an initial admin user to get started.</p>
                            <#else>
				    <p class="welcome-message">
					    <img src="welcome-content/alert.png">You need local
					    access to create the initial admin user. <br><br>Open
					    <a href="${localAdminUrl}">${localAdminUrl}</a>
					    <br>${adminUserCreationMessage}.
				    </p>
                            </#if>
                        </#if>

                        <#if bootstrap && localUser>
				<form method="post" class="welcome-form">
					<p>
						<label for="username">Username</label>
						<input id="username" name="username"/>
					</p>

					<p>
						<label for="password">Password</label>
						<input id="password" name="password"
						       type="password"/>
					</p>

					<p>
						<label for="passwordConfirmation">Password
							confirmation</label>
						<input id="passwordConfirmation"
						       name="passwordConfirmation"
						       type="password"/>
					</p>

					<input id="stateChecker" name="stateChecker"
					       type="hidden" value="${stateChecker}"/>

					<button id="create-button" type="submit"
					        class="btn btn-primary">Create
					</button>
				</form>
                        </#if>
		    </div>
            </#if>

            <#if adminConsoleEnabled>
		    <div class="col-xs-12 col-sm-12 col-md-4">
			    <div class="card">
				    <div class="card-header">
					    <img class="card-img-top" src="welcome-content/user.png">
				    </div>
				    <div class="card-body">
					    <h5 class="card-title">Administration Console</h5>
					    <p class="card-text">
						    Access the Administration Console to manage, configure, and monitor
						    your authentication server.
					    </p>
					    <a class="btn btn-primary" href="${adminUrl}">Enter Administration
						    Console</a>
				    </div>
			    </div>
		    </div>
            </#if>

		<div class="col-xs-12 col-sm-6 col-md-4">
			<div class="card">
				<div class="card-header">
					<img class="card-img-top" src="welcome-content/admin-console.png">
				</div>
				<div class="card-body">
					<h5 class="card-title">Documentation</h5>
					<p class="card-text">
						For detailed guidance on using the server, be sure to check our
						documentation, which includes the User Guide, Admin REST API, and
						Javadocs.
					</p>
					<a class="btn btn-primary" href="${properties.documentationUrl}">View
						Documentation</a>
				</div>
			</div>
		</div>

            <#if properties.displayCommunityLinks = "true">
		    <div class="col-xs-12 col-sm-6 col-md-4">
			    <div class="card">
				    <div class="card-header">
					    <img class="card-img-top" src="welcome-content/mail.png">
				    </div>
				    <div class="card-body">
					    <h5 class="card-title">Contact</h5>
					    <p class="card-text">
						    If you're experiencing any issues with the authentication process or
						    have found a bug, please reach out to our administration team for
						    support.
					    </p>
					    <a class="btn btn-primary" href="mailto:${properties.contactEmail}">Report
						    an Issue</a>
				    </div>
			    </div>
		    </div>
            </#if>
	</div>
</main>
</body>
</html>
