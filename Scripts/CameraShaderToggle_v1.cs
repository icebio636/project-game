using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]

public class CameraShaderToggle_v1 : MonoBehaviour
{
    public Shader shader;
    
    void OnEnable ()
    {
 
        if (shader != null)
            GetComponent<Camera>().SetReplacementShader(shader, "RenderType");
    } 

    void OnDisable ()
    {
        GetComponent<Camera>().ResetReplacementShader();
    }
}
