# RackApp

The objective of this project is the implementation of some endpoints to manage products. With this development I want to show some of my skills as a software engineer. For the implementation I used Ruby (without Rails).

The API consists of the following endpoints:
- POST /login
- GET /products
- POST /products

### Prerequisites

- Ruby 3.3
- Bundler

### Check out the repository

```bash
git clone https://github.com/anmacagno/rack-app.git
```

### Install the dependencies

```bash
bundle install
```

### Run the test suite

```bash
ruby test/rack_app_test.rb
```

### Run the server

```bash
bundle exec puma
```

### Test an endpoint

If you are testing in the local environment the base url for the endpoints is http://localhost:9292.

I created the following users for testing (username:password):
- amacagno:1111
- jcuello:2222
- lbierwerth:3333

### Example requests

1. POST /login

This endpoint returns the token needed for private endpoints.

```bash
curl --location 'http://localhost:9292/login' \
--header 'Content-Type: application/json' \
--data '{
    "username": "amacagno",
    "password": "1111"
}'
```

2. GET /products

Without filter:

```bash
curl --location 'http://localhost:9292/products' \
--header 'Authorization: REPLACE_WITH_YOUR_TOKEN'
```

With filter:

```bash
curl --location 'http://localhost:9292/products?name=MacBook' \
--header 'Authorization: REPLACE_WITH_YOUR_TOKEN'
```

3. POST /products

```bash
curl --location 'http://localhost:9292/products' \
--header 'Content-Type: application/json' \
--header 'Authorization: REPLACE_WITH_YOUR_TOKEN' \
--data '{
    "name": "MacBook"
}'
```

### Docs

To specify the API I used the OpenAPI standard. Look at the file **openapi.yaml**.

These are some links with documentation used during development:
- https://docs.ruby-lang.org/en/3.3/index.html
- https://github.com/rack/rack
- https://github.com/jwt/ruby-jwt
- https://spec.openapis.org/oas/latest.html
- https://developer.mozilla.org/en-US/docs/Web/HTTP
