using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovePLAYER : MonoBehaviour
{

    public float speed;
    private Rigidbody rb;
    public float jumpheight = 5.0f;
    public float extraweight = 5.0f;
    public float turnRight = 5.0f;
    public float turnLeft = -5.0f;
    public bool landed = false;

    //for future use
    private Renderer myRenderer;

    //movement

    void Start()
    {
        rb = GetComponent<Rigidbody>();
        //for future use
        myRenderer = GetComponent<Renderer>();
    }

    void FixedUpdate()
    {
        float moveHorizontal = Input.GetAxis("Horizontal");
        float moveVertical = Input.GetAxis("Vertical");

        Vector3 movement = new Vector3(moveHorizontal, 0.0f, moveVertical);
        rb.velocity = movement * speed;

        //the problem here is the infinite nature of 'falling' creating too much friction to move on the ground
        
        if (Input.GetKey(KeyCode.Space)) //&& landed == true)
        {
            rb.AddForce(transform.up * jumpheight);
            landed = false;
        }

        //else if (landed == false)
        {
            rb.AddForce(-transform.up * extraweight);
            print("falling!");
        }

        if (Input.GetKey(KeyCode.X))
        {
            transform.Rotate(Time.deltaTime, turnRight, 0);
        }
        if (Input.GetKey(KeyCode.Z))
        {
            transform.Rotate(Time.deltaTime, turnLeft, 0);
        }
    }

    //collision test

    void OnCollisionEnter(Collision myCollision)
    {
        print (myCollision.collider.name);
    }

}