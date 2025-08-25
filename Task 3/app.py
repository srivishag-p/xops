from flask import Flask, jsonify, render_template

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/api/health")
def health_check():
    return jsonify(status="ok", message="App is running fine")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
