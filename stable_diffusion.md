- online stable diffusion Automatic1111 WebUI
https://rundiffusion.com/

- controlnet
- https://www.youtube.com/watch?v=mhJa1dhIFWg&ab_channel=VladimirChopine%5BGeekatPlay%5D
- https://www.youtube.com/watch?v=LnqNyd21x9U&ab_channel=TheUbie-StreamingandReacts%21
- https://huggingface.co/lllyasviel/ControlNet/blob/main/README.md
- https://github.com/lllyasviel/ControlNet?tab=readme-ov-file


- official A1111
- https://github.com/Mikubill/sd-webui-controlnet

- sd_xl_control net
- https://github.com/Mikubill/sd-webui-controlnet/discussions/2039

- extesion
- https://github.com/Coyote-A/ultimate-upscale-for-automatic1111
- https://github.com/pkuliyi2015/multidiffusion-upscaler-for-automatic1111


- tcmalloc
- https://discourse.nixos.org/t/trying-to-get-stable-diffusion-automatic1111-to-work/33562/7
```
You can just replace it with TCMALLOC="" to disable the whole thing. If there’s a good reason they’re asking for that other allocator, it seems nixpkgs provides it in the gperftools attribute:

❯ nix-locate libtcmall
gperftools.out                                        0 s /nix/store/00000000000000000000000000000000-gperftools-2.10/lib/libtcmalloc.so
```

- https://github.com/virchau13/automatic1111-webui-nix
- https://github.com/gbtb/nix-stable-diffusion/blob/master/flake.nix

- https://civitai.com/models/123313?modelVersionId=380969
- https://civitai.com/models/321390/mjolnir-sdxl-lightning?modelVersionId=360372
- https://civitai.com/images/7615937

- inpaint anything
- https://www.youtube.com/watch?v=k8FfCicu5G8
