import urllib.request
import urllib.parse
import datetime
from io import BytesIO
from flask import Blueprint, jsonify, send_file

backend_bp = Blueprint("backend", __name__)

@backend_bp.route("/")
def info():
    return jsonify({"message": "Welcome to the backend. Use /backend/display to see the API output."})

def get_data():
    try:
        fp = open("settings.txt", "r")
        lines = fp.readlines()
        fp.close()
    except FileNotFoundError:
        return "settings.txt was not found."
    except IsADirectoryError:
        return "settings.txt is a directory and should be a file."

    if len(lines) < 2:
        return "The contents of settings.txt are incorrect."
    
    name = lines[0].strip()
    student_id = lines[1].strip()

    if not name or not student_id:
        return "The contents of settings.txt are incorrect."

    return name, student_id

@backend_bp.route("/json")
def display():
    values = get_data()
    if type(values) is not tuple:
        if type(values) is str:
            return jsonify({"message": values}), 500
        else:
            return jsonify({"message": "Unknown error!"}), 500

    name, student_id = values
    return jsonify({"name": name, "student_id": student_id})

@backend_bp.route("/image")
def qrcode():
    values = get_data()
    if type(values) is not tuple:
        if type(values) is str:
            return jsonify({"message": values}), 500
        else:
            return jsonify({"message": "Unknown error!"}), 500

    name, student_id = values
    cur_date = datetime.datetime.now().strftime("%d-%m-%Y %H:%M")
    url = "https://api.qrserver.com/v1/create-qr-code/?"
    params = {
        "size": "200x200",
        "data": "\n".join([name, student_id, cur_date]),
        "format": "png",
    }

    url += urllib.parse.urlencode(params)

    with urllib.request.urlopen(url) as response:
        image = response.read()

    return send_file(BytesIO(image), mimetype="image/png")
