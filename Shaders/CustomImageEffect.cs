using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]

public class CustomImageEffect : MonoBehaviour {

    public Material EffectMaterial;

	void OnRenderImage ( RenderTexture src, RenderTexture dest)
    {
        // src is the fully rendered scene (normally sent directly to monitor). 
        // we are intercepting this to apply an effect before it is sent to the monitor.

        Graphics.Blit(src, dest, EffectMaterial);
    }
}
