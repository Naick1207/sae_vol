from flask_restx import Resource, Namespace
# creation du namespace, racine de tous les endpoints
ns = Namespace("api")

# definition d’une route
@ns.route("/hello")
class Hello(Resource):
    def get(self):
        return {"hello": "restx"}