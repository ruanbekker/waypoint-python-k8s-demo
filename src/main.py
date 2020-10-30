# https://fastapi.tiangolo.com
from flask import Flask

app = Flask(__name__)

@app.route("/")
def read_root():
    return {"message": "hello, world!"}

@app.route("/health")
def read_health():
    return {"message": "ok"}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
