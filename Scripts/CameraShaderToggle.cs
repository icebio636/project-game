using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]

public class CameraShaderToggle : MonoBehaviour
{
    public Shader ShaderOne;
    
    void OnEnable ()
    {
        if (ShaderOne != null)
            GetComponent<Camera>().SetReplacementShader(ShaderOne, "RenderType");
    } 

    void OnDisable ()
    {
        GetComponent<Camera>().ResetReplacementShader();
    }
}
