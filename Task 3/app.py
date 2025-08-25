from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return "🚀 Flask CI/CD from GitHub Actions to Amazon Linux 2!"

@app.route("/api/health")
def health_check():
    return jsonify(status="ok", message="App is running fine ✅")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)
