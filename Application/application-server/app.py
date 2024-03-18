from flask import Flask, request, jsonify
from flask_bcrypt import Bcrypt
import mysql.connector
from mysql.connector import Error
import os

app = Flask(__name__)
bcrypt = Bcrypt(app)

def get_db_connection():
    try:
        conn = mysql.connector.connect(
            host=os.getenv('DB_HOST', 'localhost'),
            user=os.getenv('DB_USER', 'root'),
            passwd=os.getenv('DB_PASSWORD', ''),
            database=os.getenv('DB_NAME', 'job_db')
        )
        return conn
    except Error as e:
        print(f"Error connecting to MySQL Database: {e}")
        return None

@app.route('/register', methods=['POST'])
def register_user():
    data = request.json
    if not data.get('password') or data['password'] != data.get('confirm_password'):
        return jsonify({'error': 'Passwords do not match'}), 400

    encrypted_password = bcrypt.generate_password_hash(data['password']).decode('utf-8')
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        try:
            cursor.execute('''INSERT INTO registrations (full_name, age, phone_number, profession, driver_license, username, password)
                              VALUES (%s, %s, %s, %s, %s, %s, %s)''',
                           (data['full_name'], data['age'], data['phone_number'], data['profession'], 
                            data['driver_license'], data['user'], encrypted_password))
            conn.commit()
        except Error as e:
            cursor.close()
            conn.close()
            return jsonify({'error': str(e)}), 500
        cursor.close()
        conn.close()
        return jsonify({'message': 'User registered successfully'}), 201
    else:
        return jsonify({'error': 'Database connection failed'}), 500

@app.route('/users', methods=['GET'])
def get_users():
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor(dictionary=True)
        try:
            cursor.execute("SELECT id, full_name, age, phone_number, profession, driver_license, username FROM registrations")
            users = cursor.fetchall()
        except Error as e:
            cursor.close()
            conn.close()
            return jsonify({'error': str(e)}), 500
        cursor.close()
        conn.close()
        return jsonify(users)
    else:
        return jsonify({'error': 'Database connection failed'}), 500

@app.route('/user/<int:id>', methods=['GET'])
def get_user(id):
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor(dictionary=True)
        try:
            cursor.execute("SELECT id, full_name, age, phone_number, profession, driver_license, username FROM registrations WHERE id = %s", (id,))
            user = cursor.fetchone()
        except Error as e:
            cursor.close()
            conn.close()
            return jsonify({'error': str(e)}), 500
        cursor.close()
        conn.close()
        return jsonify(user) if user else ('', 404)
    else:
        return jsonify({'error': 'Database connection failed'}), 500

@app.route('/user/<int:id>', methods=['PUT'])
def update_user(id):
    data = request.json
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        try:
            cursor.execute('''UPDATE registrations SET full_name=%s, age=%s, phone_number=%s, profession=%s, driver_license=%s, username=%s WHERE id=%s''',
                           (data['full_name'], data['age'], data['phone_number'], data['profession'], 
                            data['driver_license'], data['user'], id))
            conn.commit()
        except Error as e:
            cursor.close()
            conn.close()
            return jsonify({'error': str(e)}), 500
        cursor.close()
        conn.close()
        return jsonify({'message': 'User updated successfully'}), 200
    else:
        return jsonify({'error': 'Database connection failed'}), 500

@app.route('/user/<int:id>', methods=['DELETE'])
def delete_user(id):
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        try:
            cursor.execute("DELETE FROM registrations WHERE id = %s", (id,))
            conn.commit()
        except Error as e:
            cursor.close()
            conn.close()
            return jsonify({'error': str(e)}), 500
        cursor.close()
        conn.close()
        return jsonify({'message': 'User deleted successfully'}), 200
    else:
        return jsonify({'error': 'Database connection failed'}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
