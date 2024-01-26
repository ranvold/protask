# README

- Make sure you have installed ruby version 3.3.0, postgresql and postman or similar

To setup project:
1. git clone git@github.com:ranvold/protask.git
2. Move to the directory project

Install dependencies:
```
bundle install
```
Then db setup:
```
bin/rails db:setup
```
Start the server and check localhost:3000:
```
bin/rails server
```

Endpoints:\
[POST] Sign up with params email, password, password_confirmation(You can skip this step):
```
localhost:3000/api/v1/sign_up
```
[POST/DELETE] Just sign in, since test user already created by seeds:
```
{
 "user": {
  "email":"test@protask.io",
  "password":"password"
 }
}

```
```
localhost:3000/api/v1/sign_in
```
[CRUD] Project resources, with param with_tasks=true, we get projects that include tasks: 
```
localhost:3000/api/v1/projects
```
[CRUD] Nested task resources, with param status=ready_to_go|in_progress|done select one, we get filtered tasks
```
localhost:3000/api/v1/projects/:id/tasks
```
NOTE: Sign in first, then access resources.
