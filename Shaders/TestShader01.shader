Shader "Custom/TestShader01"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		//_NoiseTex ("Noise Texture", 2D) = "white" {}
		//_Dampening ("Dampening", Float) = 10 {}
		//_Spreading ("Spreading", Float) = 100 {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
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
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			//sampler2D _NoiseTex;

			//float _Dampening;
			//float _Spreading;

			fixed4 frag(v2f i) : SV_Target
			{

				//float2 offset = float2 (
					//tex2D(_NoiseTex, float2(i.worldPosition.y / _Spreading , _Time[1])).r,
					//tex2D(_NoiseTex, float2( _Time[1], i.worldPosition.x / _Spreading)).r,);

			//offset -= 0.5;
				
				fixed4 col = tex2D(_MainTex, i.uv + float2(0, sin(i.vertex.x / 100 + _Time[1]/2) / 30));
				// just invert the colors
				// col = 1 - col;
				// turn screen blue
				col.b = 1;
				return col;
			}
			ENDCG
		}
	}
}
