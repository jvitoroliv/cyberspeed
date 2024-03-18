from flask import Flask, render_template, request, redirect, url_for, session
import requests

app = Flask(__name__, static_folder='static', template_folder='templates')
app.secret_key = 'your_secret_key'  # Change this to a random secret key

API_BASE_URL = "http://localhost:5000"  # URL of your backend API

@app.route('/')
def home():
    if 'user_id' in session:
        # Fetch user details from the backend to display
        user_id = session['user_id']
        response = requests.get(f"{API_BASE_URL}/user/{user_id}")
        if response.status_code == 200:
            user_details = response.json()
            return render_template('profile.html', user=user_details)
        else:
            return "Error fetching user details", 500
    return render_template('index.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        user_data = {
            "full_name": request.form['full_name'],
            "age": request.form['age'],
            "phone_number": request.form['phone_number'],
            "profession": request.form['profession'],
            "driver_license": request.form['driver_license'],
            "user": request.form['username'],
            "password": request.form['password'],
            "confirm_password": request.form['confirm_password']
        }
        response = requests.post(f"{API_BASE_URL}/register", json=user_data)
        if response.status_code == 201:
            return redirect(url_for('login'))
        else:
            return f"Error: {response.content}", 400
    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        # Assuming backend provides a login API
        response = requests.post(f"{API_BASE_URL}/login", json={"user": username, "password": password})
        if response.status_code == 200:
            session['user_id'] = response.json()['id']
            return redirect(url_for('home'))
        else:
            return "Login failed", 401
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    return redirect(url_for('home'))

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=8000)
