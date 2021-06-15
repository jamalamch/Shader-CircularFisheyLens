Shader "PEffect/CircularFisheyeLens"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Vview ("Field of view ", float) = 60
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
            float _Vview;
            fixed4 frag (v2f i) : SV_Target
            {
                float dist =  distance( i.uv, float2(0.5,0.5));
                fixed4 gl_FragColor;
                 {
                    float2 uv = i.uv /*+ float2(0,sin(i.vertex.x/50 + _Time[0]*50)/20)*/;

                    float2 circ = normalize(uv - float2(0.5,0.5));  // on the unit circle
                    float phi = radians(_Vview/2.0)*(2.0*dist);  // "latitude"
                    float3 vec = float3(sin(phi)*circ.x, sin(phi)*circ.y, cos(phi));
                    gl_FragColor = tex2D( _MainTex, vec*cos(phi) + float2(0.5,0.5));
                 } 
                return gl_FragColor;
            }
            ENDCG
        }
    }
}
