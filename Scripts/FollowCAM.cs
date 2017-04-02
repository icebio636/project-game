using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowCAM : MonoBehaviour {

    //player
    public Transform target;
    //rotation insert here
    //lag
    public float smoothing = 5f;

    Vector3 offset;
    
    void Start()
    {
        offset = transform.position - target.position;
    }

    void FixedUpdate()
    {
        //lerp is 'inbetween' ie. the camera moves to an average position between those three vectors
        Vector3 targetCamPos = target.position + offset;
        transform.position = Vector3.Lerp(transform.position, targetCamPos, smoothing * Time.deltaTime);
    }
}

