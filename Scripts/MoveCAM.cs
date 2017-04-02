using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveCAM : MonoBehaviour
{
    public float speed = 5.0f;
    public float rotationPositive = 5.0f;
    public float rotationNegative = -5.0f;

    void Update()
    {
        if (Input.GetKey(KeyCode.RightArrow))
        {
            transform.Translate(new Vector3(speed * Time.deltaTime, 0, 0));
        }
        if (Input.GetKey(KeyCode.LeftArrow))
        {
            transform.Translate(new Vector3(-speed * Time.deltaTime, 0, 0));
        }
        if (Input.GetKey(KeyCode.DownArrow))
        {
            transform.Translate(new Vector3(0, -speed * Time.deltaTime, 0));
        }
        if (Input.GetKey(KeyCode.UpArrow))
        {
            transform.Translate(new Vector3(0, speed * Time.deltaTime, 0));
        }
        if (Input.GetKey(KeyCode.E))
        {
            transform.Rotate(Time.deltaTime, rotationPositive, 0);
        }
        if (Input.GetKey(KeyCode.Q))
        {
            transform.Rotate(Time.deltaTime, rotationNegative, 0);
        }
    }

}