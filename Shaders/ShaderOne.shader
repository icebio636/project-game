// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/ShaderOne"
{
	
	//Variables
	Properties{
		_MainTexture("Main Texture", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
	}

	SubShader 
	{

		Pass 
		{
			CGPROGRAM

			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction

			#include "UnityCG.cginc"

			//pull information
			//vertices;normals;color;uv;etc
		
			struct appdate {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			float4 _Color;
			sampler2D _MainTexture;


			//vertex function
			//build the object

			v2f vertexFunction(appdata IN) {
				
				v2f OUT;

				OUT.position = UnityObjectToClipPos(IN.vertex);
				OUT.uv = IN.uv; 

				return OUT;

			}

			//fragment function
			//color the object
			
			fixed4 fragmentFunction(v2f IN) : SV_Target{

				float 4 textureColor = tex2D( _MainTexture, IN.uv);
			
				return textureColor * _Color;
			}
			
			ENDCG
			}
		}
}
