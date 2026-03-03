from flask_restx import Resource, Namespace
from .models import *
from .api_models import *

# creation du namespace, racine de tous les endpoints
ns = Namespace("api")
    
@ns.route("/Vols")
class VolCollection(Resource):
    @ns.marshal_list_with(vol_model)
    def get(self):
        return get_all_vols()
    
    @ns.expect(vol_model_input)
    @ns.marshal_with(vol_model)
    def post(self):
        vol = create_vol(compagnie=ns.payload["compagnie"],tempsD=ns.payload["tempsD"],terminalD=ns.payload["terminalD"],
                   codeAeroportD=ns.payload["codeAeroportD"],tempsA=ns.payload["tempsA"],terminalA=ns.payload["terminalA"],
                   codeAeroportA=ns.payload["codeAeroportA"])
        return vol,201
    
@ns.route("/Aeroports")
class AeroportCollection(Resource):
    @ns.marshal_list_with(aeroport_model)
    def get(self):
        return get_all_aeroports()
    

    