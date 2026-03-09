from flask_restx import Resource, Namespace, abort
from .models import *
from .api_models import *

ns = Namespace("api")

@ns.route("/Vols")
class VolCollection(Resource):
    @ns.marshal_list_with(vol_model)
    def get(self):
        return get_all_vols()

    @ns.expect(vol_model_input)
    @ns.marshal_with(vol_model)
    def post(self):
        vol = create_vol(**ns.payload)
        return vol, 201

@ns.route("/Vol/<int:numero>/<string:compagnie>/<string:tempsD>")
@ns.response(404, "Vol not found")
class VolItem(Resource):
    @ns.marshal_with(vol_model)
    def get(self, numero, compagnie, tempsD):
        vol = get_vol(numero, compagnie, tempsD)
        if vol is None:
            abort(404, "Vol not found")
        return vol

    @ns.expect(vol_update_model_input)
    @ns.marshal_with(vol_model)
    def put(self, numero, compagnie, tempsD):
        vol = update_vol(numero, compagnie, tempsD, **ns.payload)
        if vol is None:
            abort(404, "Vol not found")
        return vol, 200
    
    def delete(self, numero, compagnie, tempsD):
        vol = get_vol(numero, compagnie, tempsD)
        if vol is None:
            abort(404, "Vol not found")
        db.session.delete(vol)
        db.session.commit()
        return '', 204

@ns.route("/Aeroports")
class AeroportCollection(Resource):
    @ns.marshal_list_with(aeroport_model)
    def get(self):
        return get_all_aeroports()
    
    @ns.expect(aeroport_model_input)
    @ns.marshal_with(aeroport_model)
    def post(self):
        aeroport = create_aeroport(**ns.payload)
        return aeroport, 201

@ns.route("/Aeroports/<int:code>")
@ns.response(404, "Aeroport not found")
class AeroportItem(Resource):
    @ns.marshal_with(aeroport_model)
    def get(self, code):
        aeroport = get_aeroport(code)
        if aeroport is None:
            abort(404, "Aeroport not found")
        return aeroport

    @ns.expect(aeroport_update_model_input)
    @ns.marshal_with(aeroport_model)
    def put(self, code):
        aeroport = update_aeroport(code, **ns.payload)
        if aeroport is None:
            abort(404, "Aeroport not found")
        return aeroport, 200
    
    def delete(self, code):
        aeroport = get_aeroport(code)
        if aeroport is None:
            abort(404, "Aeroport not found")
        db.session.delete(aeroport)
        db.session.commit()
        return '', 204