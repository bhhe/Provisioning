from flask import Flask

def create_app():
    app = Flask(__name__)
    from .backend import backend_bp

    @app.route("/")
    def index():
        return"This is the main page for the backend service. You should use /backend[/display] to access it."

    app.register_blueprint(backend_bp, url_prefix="/backend")

    return app