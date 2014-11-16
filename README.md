# Oksana' API

## Requests

Requests are directed to `/users` resource. E. g.:

* `GET /users` - list all users
* `POST /users/sign_up` - create a new user

Sample `sign_up` request (in Ruby using `rest-client` gem):

    RestClient.post 'localhost:9292/users/sign_up', { name: "moo", email: "moo@foo.bar", password: "abc", password_confirmation: "abc" }

For now, implemented methods are:

* `GET /users`
* `POST /users/sign_up`

## Responses

Responses are just JSON objects. Each response contains either `{ "success": true }` or `{ "success": false, "error": "..." }` part.

### Available responses

`GET /users`

    { "success": true, "users": ["#<User:0x00000002e925d0>"] }

`POST /users/sign_up`

    { "success": true, "id": 5, "api_key": "abcdef0123456789" }