# Keycloak OpenId Connect Auth Flow Sample

This code has been cloned an adapted from [onelogin-oidc-node](https://github.com/onelogin/onelogin-oidc-node).

The sample is an [Express.js](https://expressjs.com/) app that uses
[Passport.js](http://www.passportjs.org/) and the [Passport-OpenIdConnect](https://github.com/jaredhanson/passport-openidconnect)
module for managing user authentication.

The sample tries to keep everything as simple as possible so only
implements
* Login - redirecting users to Keycloak for authentication
* Logout - destroying the local session and revoking the token at Keycloak
* User Info - fetching profile information from Keycloak

## Run
First update the .env file with the informations from your Keycloak client.

You can then build and run this app with Docker by running
```
docker build -t oidc-expressjs .
docker run -p 3000:3000 -d oidc-expressjs
```

### Local testing
By default these samples will run on `http://localhost:3000`.

You will need to add your callback url to the list of approved **Redirect URIs** for your Keycloak OIDC app via the Admin portal. e.g. `http://localhost:3000/oauth/callback`

You can take a look at the container logs to see all the attributes passed as token claims from Keycloak to this application.
