﻿Shader "Unlit/v1_textureShader"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_SecondaryTex("Texture", 2D) = "white" {}
		_Tween("Tween", Range(0,1)) = 0 
		_Color ("Color", color) = (1,1,1,1)
	}

	SubShader
	{
		Tags 
	{
		"Queue" = "Transparent"
		"PreviewType" = "Plane"
	}
		
		Pass
		{

		Blend SrcAlpha OneMinusSrcAlpha	
		
		CGPROGRAM

				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				struct appdata
					{
						float4 vertex : POSITION;
						float2 uv : TEXCOORD0;
					};

				struct v2f
					{
						float4 vertex : SV_POSITION;
						float2 uv : TEXCOORD0;
					};

				v2f vert(appdata v)
					{
						v2f o;
						o.vertex = UnityObjectToClipPos(v.vertex);
						o.uv = v.uv;
						return o;
					}

				sampler2D _MainTex;
				sampler2D _SecondaryTex;
				float _Tween;
				float4 _Color;

				float4 frag(v2f i) : SV_Target
					{
						float4 color1 = tex2D(_MainTex, i.uv) * _Color ;
						float4 color2 = tex2D(_SecondaryTex, i.uv) * _Color ;

						float4 color = lerp(color1, color2, _Tween);
						return color;
					}
			ENDCG
		}
	}
}
