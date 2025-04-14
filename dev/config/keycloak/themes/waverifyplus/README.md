# waverifyplus Parent Theme for Keycloak

The `waverifyplus` theme is a base parent theme for Keycloak designed to provide a foundational structure for creating
customized experiences. It serves as a reusable and extendable template that includes common styles, templates, scripts,
and frontend libraries (e.g., Bootstrap and FontAwesome). Future projects can extend this theme to implement custom
branding, layout, and functionality while maintaining a consistent core experience.

## Goals

- **Reusability**: Provide a common base theme that can be extended for multiple projects.
- **Customization**: Allow child themes to override and extend specific templates, styles, and resources.
- **Consistency**: Ensure a consistent user experience across all extended themes by using shared resources.

## Directory Structure

The `waverifyplus` theme is organized with a clear directory structure that follows Keycloak's theme conventions:

```plaintext
waverifyplus/                      # Parent theme directory
├── login/                 # Login theme folder for waverifyplus
│   ├── theme.properties   # Theme properties file
│   ├── messages/          # Folder for message bundles (i18n)
│   │   └── messages_en.properties  # Example message bundle
│   ├── resources/         # Static resources (CSS, JS, images)
│   │   ├── css/           # Custom CSS for the login theme
│   │   ├── js/            # Custom JS for the login theme
│   │   ├── img/           # Images used in the login theme
│   │   └── lib/           # Frontend libraries (Bootstrap, FontAwesome, etc.)
│   │       ├── bootstrap/ # Bootstrap library files
│   │       └── fontawesome/ # FontAwesome library files
│   └── templates/         # HTML templates for the login theme
│       ├── login.ftl      # Example FreeMarker template for login
│       └── other_template.ftl  # Another template
└── other_subthemes/       # Placeholder for potential other subthemes under waverifyplus
```

## Extending the waverifyplus Theme for Future Projects

To extend the `waverifyplus` theme for new projects, there are two approaches: overriding the existing files or adding
custom files to complement the original theme.

### Approach 1: Simple Overriding of Files

The first and most straightforward method to extend the `waverifyplus` theme is by overriding existing files. This is
the standard approach in Keycloak theme customization.

1. **Create a New Theme Directory**:
    - Create a new folder under the `themes` directory (e.g., `my-new-theme`).

2. **Set Up the `theme.properties` File**:
    - In the `my-new-theme/login` directory, create a `theme.properties` file that specifies `waverifyplus` as the
      parent theme:
      ```properties
      parent=waverifyplus
      internationalizationEnabled=true
      ```

3. **Override Files as Needed**:
    - Place any custom templates, styles, or scripts in the appropriate subdirectories (e.g., `resources/css`,
      `resources/js`, `templates`). For instance:
        - To override the login page, create a new `login.ftl` file in `my-new-theme/login/templates/`.
        - To override the CSS, create a new `style.css` file in `my-new-theme/login/resources/css/`.

4. **Deploy and Test**:
    - Deploy the new theme to the Keycloak `themes` directory and configure the realm to use it. Only the overridden
      files will replace those from the `waverifyplus` theme.

### Approach 2: Adding Custom Code Without Overriding

The second approach involves adding a `custom` folder inside the `resources` directory. This approach allows you to add
new custom code that complements the original `waverifyplus` theme without overriding existing files.

1. **Create a Custom Folder**:
    - Inside the `resources` directory of your child theme (e.g., `my-new-theme/login/resources`), create a `custom`
      folder.

2. **Add Custom Files**:
    - For custom CSS files, create a `css` folder inside the `custom` directory and add your CSS files (e.g.,
      `styles.css`):
      ```
      my-new-theme/
      └── login/
          └── resources/
              └── custom/
                  └── css/
                      └── styles.css
      ```

3. **Update `theme.properties` to Include Custom Files**:
    - Edit the `theme.properties` file to include a reference to the custom CSS file and any other resources you want to
      add. For example:
      ```properties
      parent=waverifyplus
      internationalizationEnabled=true
      customStyles=custom/css/styles.css
      headerLogo=img/logo.svg
      ```
    - The `customStyles` property specifies the path to the custom CSS file within the `custom` directory. Similarly,
      you can add other properties for additional customizations (e.g., `headerLogo` for a custom logo).

4. **Deploy and Test**:
    - Deploy the new theme to the Keycloak `themes` directory and configure the realm to use it. The custom files will
      complement the original `waverifyplus` theme without replacing any existing files.

By choosing either of these approaches, you can effectively extend the `waverifyplus` theme to create a unique and
customized user experience in Keycloak, depending on whether you want to override existing functionality or simply add
to it.
