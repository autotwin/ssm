# Smoothed Meshes

* Source `.npy` segmentations [Google Drive - to come.]

```sh
alias automesh='/Users/chovey/autotwin/automesh/target/release/automesh'
```

```sh
cd ~/scratch/ixi
```

```sh
automesh mesh -i IXI012-HH-1211-T1_large.npy -o IXI012-HH-1211-T1_large.exo
```

```sh
    automesh 0.2.0
     Reading IXI012-HH-1211-T1_large.npy
        Done 1.935375ms
     Meshing IXI012-HH-1211-T1_large.exo
        Done 592.206375ms
     Writing IXI012-HH-1211-T1_large.exo
        Done 439.933708ms
```

```sh
automesh mesh -i IXI012-HH-1211-T1_large.npy -o IXI012-HH-1211-T1_large_s5.exo smooth -n 5
```

```sh
    automesh 0.2.0
     Reading IXI012-HH-1211-T1_large.npy
        Done 15.407125ms
     Meshing IXI012-HH-1211-T1_large_s5.exo
        Done 599.748125ms
   Smoothing IXI012-HH-1211-T1_large_s5.exo
        Done 3.327176333s
     Writing IXI012-HH-1211-T1_large_s5.exo
        Done 788.001292ms
```

```sh
automesh mesh -i IXI012-HH-1211-T1_large.npy -o IXI012-HH-1211-T1_large_s100.exo smooth -n 100
```

```sh
    automesh 0.2.0
     Reading IXI012-HH-1211-T1_large.npy
        Done 1.884042ms
     Meshing IXI012-HH-1211-T1_large_s100.exo
        Done 600.601958ms
   Smoothing IXI012-HH-1211-T1_large_s100.exo
        Done 47.554488667s
     Writing IXI012-HH-1211-T1_large_s100.exo
        Done 812.048417ms
```

```sh
automesh mesh -i IXI012-HH-1211-T1_large.npy -o IXI012-HH-1211-T1_large_s100_c.exo smooth -n 100 -c
```

```sh
    automesh 0.2.0
     Reading IXI012-HH-1211-T1_large.npy
        Done 1.616791ms
     Meshing IXI012-HH-1211-T1_large_s100_c.exo
        Done 579.381875ms
   Smoothing IXI012-HH-1211-T1_large_s100_c.exo
        Done 48.651804584s
     Writing IXI012-HH-1211-T1_large_s100_c.exo
        Done 794.155542ms
```