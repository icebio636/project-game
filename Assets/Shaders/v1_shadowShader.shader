Shader "Unlit/v1_shadowShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Color ("Color", Color) = (1,1,1,1) 
		
		//introducing blend (formerly tween)
		_SecondaryTex("Texture", 2D) = "white" {}
		_Blend("Blend", Range(0,1)) = 0

		//Lut = lookup Texture
		_ToonLut ("Toon LUT", 2D) = "white" {}
		_RimColor ("Rim Color", Color) = (1,1,1,1)
		_RimPower ("Rim Power", Range (0, 10)) = 10
		
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}

		Pass
		{
			Tags
			{
				"LightMode" = "ForwardBase"
			}

			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase

			#include "UnityCG.cginc"
			#include "AutoLight.cginc"
			#include "Lighting.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : TEXCOORD1;
				float3 viewDir : TEXCOORD2;
			};

			sampler2D _MainTex;
			sampler2D _SecondaryTex;
			float _Blend;
			sampler2D _ToonLut;
			half3 _RimColor;
			half _RimPower;
			fixed4 _Color;

			
			

			v2f vert (appdata v)
			{
				v2f o;
				
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				o.normal = UnityObjectToWorldNormal(v.normal);
				o.viewDir = normalize(UnityWorldSpaceViewDir(mul(unity_ObjectToWorld, v.vertex)));

				return o;
			}

			fixed4 frag (v2f i) : SV_TARGET
			{
				float3 normal = normalize(i.normal);
				float ndotl = dot(normal, _WorldSpaceLightPos0);
				float ndotv = saturate(dot(normal, i.viewDir));

				float3 lut = tex2D(_ToonLut, float2(ndotl, 0));
				float3 rim = _RimColor * pow(1 - ndotv, _RimPower) * ndotl;

				float3 directDiffuse = lut * _LightColor0;
				float3 indirectDiffuse = unity_AmbientSky;

				fixed4 col1 = tex2D(_MainTex, i.uv) * _Color;
				col1.rgb *= directDiffuse + indirectDiffuse;
				col1.rgb += rim;
				col1.a = 1.0;

				fixed4 col2 = tex2D(_SecondaryTex, i.uv) * _Color;
				col2.rgb *= directDiffuse + indirectDiffuse;
				col2.rgb += rim;
				col2.a = 1.0;

				float4 col = lerp(col1, col2, _Blend);

				return col;

 			}
			ENDCG
		}
	}
	Fallback "Diffuse"
}
