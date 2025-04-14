<#macro emailLayout>
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<style>
			body {
				margin: 0;
				padding: 0;
				min-width: 100%;
				font-family: Arial, sans-serif;
				line-height: 1.5;
			}

			.container {
				width: 100%;
				max-width: 600px;
				margin: 0 auto;
				background: #ffffff;
				border-radius: 8px;
				box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
			}

			.header {
				padding: 20px;
				text-align: center;
			}

			.header img {
				height: 50px;
				display: block;
				margin: 0 auto 15px;
			}

			.header-title {
				font-size: 20px;
				font-weight: bold;
				color: #c84c0e;
				margin: 15px 0;
			}

			.body {
				padding: 20px;
			}

			.separator {
				height: 1px;
				background: #ddd;
				margin: 20px 0;
			}

			.footer {
				padding: 20px;
				text-align: center;
			}

			.footer img {
				width: 100px;
				display: block;
				margin: 0 auto;
			}

			@media screen and (max-width: 600px) {
				.container {
					width: 100% !important;
				}
			}
		</style>
	</head>
	<body>
	<div class="container">
		<div class="header">
			<img src="${url.resourcesUrl}/${properties.headerLogo}"
			     alt="${properties.headerLogoAlt}">
			<div class="header-title">${properties.title}</div>
		</div>

		<div class="body">
                    <#nested>
		</div>

		<div class="separator"></div>

		<div class="footer">
			<img src="${url.resourcesUrl}/${properties.footerLogo}"
			     alt="${properties.footerLogoAlt}">
		</div>
	</div>
	</body>
	</html>
</#macro>
