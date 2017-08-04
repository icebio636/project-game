using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraManager : MonoBehaviour {

    public GameObject[] cameras;
    private int camIndex;

    void start ()
    {
        camIndex = 0;

        //turn off all cameras except the first one
        for (int i=1; i < cameras.Length; i++)
        {
            cameras[i].gameObject.SetActive(false);
        }

        //if any cameras were added to the controller, enable the first one
        if (cameras.Length>0)
        {
            cameras[0].gameObject.SetActive(true);
            Debug.Log("Camera: " + cameras[0].GetComponent<Camera>().name + "is active");
        }
    }

    void Update ()
    {
        //C button switches to next camera
        //the current camera in the index is set to inactive and the next camera in the array is active
        //when the end of the array is reached the array begins again

    if (Input.GetKeyDown(KeyCode.C))
        {
            camIndex++;
            Debug.Log("swapCAM active");
            if (camIndex<cameras.Length)
            {
                cameras[camIndex - 1].gameObject.SetActive(false);
                cameras[camIndex].gameObject.SetActive(true);
                Debug.Log("Camera: " + cameras[camIndex].GetComponent<Camera>().name + "is active");
            }
            else
            {
                cameras[camIndex - 1].gameObject.SetActive(false);
                camIndex = 0;
                cameras[camIndex].gameObject.SetActive(true);
                Debug.Log("Camera: " + cameras[camIndex].GetComponent<Camera>().name + "is active");
            }
        }
    }
}
