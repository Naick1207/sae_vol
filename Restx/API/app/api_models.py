from flask_restx import fields
from .extensions import api

vol_model = api.model("Vol",{
    "numero": fields.Integer,
    "compagnie": fields.String,
    "tempsD": fields.DateTime,
    "terminalD": fields.String,
    "codeAeroportD": fields.Integer,
    "tempsA": fields.DateTime,
    "terminalA": fields.String,
    "codeAeroportA": fields.Integer
})  

aeroport_model = api.model("Aeroport",{
    "code": fields.Integer,
    "nom": fields.String,
    "pays": fields.String,
    "ville": fields.String
}) 

vol_model_input = api.model("VolInput",{
    "compagnie": fields.String(required=True),
    "tempsD": fields.DateTime(required=True),
    "terminalD": fields.String(required=True),
    "codeAeroportD": fields.Integer(required=True),
    "tempsA": fields.DateTime(required=True),
    "terminalA": fields.String(required=True),
    "codeAeroportA": fields.Integer(required=True)
})

aeroport_model_input = api.model("AeroportInput",{
    "nom": fields.String(required=True),
    "pays": fields.String(required=True),
    "ville": fields.String(required=True)
})