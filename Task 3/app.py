from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return "🚀 Flask CI/CD from GitHub Actions to Amazon Linux 2!"

@app.route("/api/health")
def health_check():
    return jsonify(status="ok", message="App is running fine ✅")

if __name__ == "__main__":
    # Run on port 5000 instead of 80
    app.run(host="0.0.0.0", port=5000, debug=True)
