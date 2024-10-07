@tool
extends MeshInstance3D
class_name PlanetMeshFace

@export var localup: Vector3

func generate_mesh(data: PlanetDataCollector) -> void:
	var vertexs := PackedVector3Array()
	
	var st := SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	var axisA := Vector3(localup.y, localup.z, localup.x)
	var axisB := localup.cross(axisA)
	for x in range(data.resolution):
		for y in range(data.resolution):
			var percetage := Vector2(x,y) / (data.resolution -1)
			var pointOnUnitCube = localup + (percetage.x - .5) * 2 * axisA + (percetage.y -.5) * axisB * 2
			var pointOnUnitSphere = pointOnUnitCube.normalized()
			var pointOnPlanet = data.point_on_planet(pointOnUnitSphere)
			
			var l = pointOnPlanet.length()
			if l < data.min_h:
				data.min_h = (l)
			if l > data.max_h:
				data.max_h = (l) 
			vertexs.push_back(pointOnPlanet)
	
	for i in range(data.resolution -1):
		for j in range(data.resolution -1):
			var baseIndex = i + j * data.resolution
			st.add_vertex(vertexs[baseIndex])
			st.add_vertex(vertexs[baseIndex + data.resolution + 1])
			st.add_vertex(vertexs[baseIndex + data.resolution])
			
			st.add_vertex(vertexs[baseIndex])
			st.add_vertex(vertexs[baseIndex + 1])
			st.add_vertex(vertexs[baseIndex + data.resolution + 1])
	
	st.generate_normals()
	self.mesh = st.commit()
	
	material_override.set("shader_param/min_height", data.min_h-.1)
	material_override.set("shader_param/max_height", data.max_h)
	material_override.set("shader_param/usample", data.texture)

func generate(data: PlanetDataCollector) -> void:
	call_deferred("generate_mesh", data)
