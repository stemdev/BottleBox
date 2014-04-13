from bottle import Bottle, response, request, route, get, post, run, template, static_file, BaseRequest
import models

@get('/home')
def index():
    return '<b>Homepage</b>'

@get('/signup')
def register():
    return static_file('signup.html', root='./views/')

@post('/signup')
def store_user():
    reg = {}
    for x in ['email', 'username', 'password']:
        reg[x] = request.forms.get(x)
    models.user.new(reg)

@get('/login')
def login():
    return static_file('login.html', root='./views/')

@post('/login')
def do_login():
    username = request.forms.get('username')
    password = request.forms.get('password')


run(host='0.0.0.0', port=8080)

