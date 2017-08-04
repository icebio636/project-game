using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]

public class CustomImageEffect_v2 : MonoBehaviour {

    public Material[] EffectMaterial;
    private int materialIndex;

    void Start()
    {
        materialIndex = 0;
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.R))
        {
            materialIndex++;
            Debug.Log("Image Effect Swap");
            if (materialIndex<EffectMaterial.Length)
            {
                Debug.Log("Shader: " + EffectMaterial[materialIndex].name + "is active");
            }
            else
            {
                materialIndex = 0;
                Debug.Log("Shader: " + EffectMaterial[materialIndex].name + "is active");
            }
        }
        

    }

    void OnRenderImage (RenderTexture src, RenderTexture dest)
    {
        // src is the fully rendered scene (normally sent directly to monitor). 
        // we are intercepting this to apply an effect before it is sent to the monitor.

        Graphics.Blit(src, dest, EffectMaterial[materialIndex]);
    }
}
