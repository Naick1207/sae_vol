from flask_restx import fields
from .extensions import api

vol_model = api.model("Vol", {
    "numero": fields.Integer,
    "compagnie": fields.String,
    "tempsD": fields.String,
    "terminalD": fields.String,
    "codeAeroportD": fields.Integer,
    "tempsA": fields.String,
    "terminalA": fields.String,
    "codeAeroportA": fields.Integer
})

# api_models.py
vol_model = api.model("Vol", {
    "numero": fields.Integer,
    "compagnie": fields.String,
    "tempsD": fields.String,
    "terminalD": fields.String,
    "aeroportD": fields.String,
    "tempsA": fields.String,
    "terminalA": fields.String,
    "aeroportA": fields.String,
    "codeAeroportD": fields.Integer, 
    "codeAeroportA": fields.Integer
})
vol_update_model_input = api.model("VolUpdateInput", {
    "terminalD": fields.String,
    "codeAeroportD": fields.Integer,
    "tempsA": fields.String,
    "terminalA": fields.String,
    "codeAeroportA": fields.Integer
})

aeroport_model = api.model("Aeroport", {
    "code": fields.Integer,
    "nom": fields.String,
    "pays": fields.String,
    "ville": fields.String
})

aeroport_model_input = api.model("AeroportInput", {
    "nom": fields.String(required=True),
    "pays": fields.String(required=True),
    "ville": fields.String(required=True)
})

aeroport_update_model_input = api.model("AeroportUpdateInput", {
    "nom": fields.String,
    "pays": fields.String,
    "ville": fields.String
})
