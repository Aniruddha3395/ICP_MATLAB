function [model_ptcloud,model_ptcloud_normals] = generate_model_ptcloud_from_STL(STL_file)

[v, f, n, ~] = stlRead(STL_file);

use_face_centroid = true;

%make code where get combination of mesh and centroid and where i can
%assign normals to the mesh pts as well...that will be the avg of
%respective triangles

if use_face_centroid
    
    % storing centroid of each triangle as model ptcloud
    face_centroid = zeros(size(f,1),3);
    for i = 1:size(f,1)
        face_centroid(i,1) = (v(f(i,1),1)+v(f(i,2),1)+v(f(i,3),1))/3;
        face_centroid(i,2) = (v(f(i,1),2)+v(f(i,2),2)+v(f(i,3),2))/3;
        face_centroid(i,3) = (v(f(i,1),3)+v(f(i,2),3)+v(f(i,3),3))/3;
    end
    model_ptcloud = face_centroid;
    model_ptcloud_normals = n;
else
    
    % storing vertices of mesh as model ptcloud
    model_ptcloud = v;
    model_ptcloud_normals = zeros(size(v,1),3);
    
end

end
