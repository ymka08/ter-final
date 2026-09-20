from flask import Flask, request
import mysql.connector
import os

app = Flask(__name__)


@app.route("/")
def index():
    ip = request.remote_addr

    connection = mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME")
    )

    cursor = connection.cursor()

    cursor.execute(
        "INSERT INTO requests (ip) VALUES (%s)",
        (ip,)
    )

    connection.commit()

    cursor.close()
    connection.close()

    return "запрос получен"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
