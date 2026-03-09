from flask import Flask
from dotenv import load_dotenv
import os
from .extensions import api, db
from .views import ns

# Charge les variables d'environnement
load_dotenv()

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv("DATABASE_URL")
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

# initialisation
api.init_app(app)
db.init_app(app)
api.add_namespace(ns)
