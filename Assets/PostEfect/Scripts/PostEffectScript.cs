using System.Collections;
using UnityEngine;

namespace PostEfect
{
    [ExecuteInEditMode]
    public class PostEffectScript : MonoBehaviour
    {
        [SerializeField] Material _material;

        void OnRenderImage(RenderTexture source, RenderTexture destination)
        {
            Graphics.Blit(source, destination, _material);
        }
    }
}