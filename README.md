# ssm

Sierra Solid Mechanics simulations

## Goal

* Reproduce the *Mil Med* workflow.
* Substitute BCs: Compare RMU `8 krad/s` `8 ms` [boundary condition](https://github.com/autotwin/basis?tab=readme-ov-file#methods).
* Substitue mesh: Substitute Bob model with Autotwin [two material model](https://github.com/autotwin/pixel).

Boundary Condition | Mesh
:---: | :---:
![](figs/Terpsma_2020_Figure_4-10.png) | ![](figs/Terpsma_2020_Figure_C-4.png)
![](figs/AngAccel.png)| ![](figs/autotwin_bi_material_voxels.png)

> Figure 1: Reproduction of boundary condition and mesh figures.

### Mesh Characteristics

* The spheres mesh is 5,496,376 elements, 400 MB.
* The *Mil Med* mesh has 4,631,316 elements, 328 MB.
* The Utah SCI has xxx elements, xxx MB.

### Simulation Characteristics

> Table 1: Simulation index. 

item | `sim` | mesh | bc (ms, krad/s) | T_sim (ms) | machine | # proc | cpu time (hh:mm) | wall time (days)
:---: | :---: | :---: | :---: | ---: | :---: | ---: | ---: | ---: 
0 | [`vox_0.1cm`](https://github.com/autotwin/basis?tab=readme-ov-file#voxel-meshes) | spheres | 8, 8 | 20 | skybridge | 160 | 01:43 | 12
1 | `bob066b` | Bob | 10, 3 | 6.57 | eclipse | 336 | 04:00 | 56
2 | `bob067` | Bob | 10, 3 | 10 | eclipse | 336 | 02:35 | 36

![](figs/simulaton_time_to_completion.png)

> Figure 2: Analysis of time to completion for simulations. </br>Reference: `autotwin/ssm/analysis/simulaton_time_to_completion.xlsx` 

item | `sim` | mesh | bc (ms, krad/s) | T_sim (ms) | machine | # proc | cpu time (hh:mm) | wall time (days)
:---: | :---: | :---: | :---: | ---: | :---: | ---: | ---: | ---: 
3 | `bob068` | Bob | 10, 3 | 20 | eclipse | 336 | 05:57 | 83
4 | `bob069` | Bob | 10, 3 | 20 | eclipse | 700 | 04:00 | 117
. | - | - | - | - | - | - | - | -

![](figs/simulaton_time_to_completion_002.png)

### Pixel toward Ensemble

> Table 2: Pixel semantic values, anatomy, and color.

integer | anatomy | color
:---: | --- | ---
0 | void | dark blue
1 | skull | light blue
2 | CSF | green
3 | brain | yellow

> Table 3: Pixel semantic values, anatomy, and color.

size | dimension
--- | ---
Large | (256, 256, 150)
Medium | (128, 128, 75)
Small | (64, 64, 38)
Mini | (26, 26, 15)

![](figs/IXI013-HH-1212-T1_visualize.png)

> Figure 3: Sagittal section view of four sizes.

## References

* [casco_sim repo](https://cee-gitlab.sandia.gov/chovey/casco_sim)
* [Terpsma 2021 Mil Med](https://github.com/hovey/hovey.github.io/blob/master/docs/Terpsma_2021_001.pdf)
* [Terpsma 2020 SAND](https://github.com/hovey/hovey.github.io/blob/master/docs/Terpsma_2020_SAND2020_11444.pdf)
* [Minimum Working Example Utah brain Issue 19](https://github.com/autotwin/mesh/issues/19)

Axes | Figure
:---: | :---:
`X` axis is right to left ("yes" gesture head rotation).</br>`Z` axis is vertical (inferior to superior axis in Figure 4-9),</br> * `Y` axis horizontal (anterior to posterior axis in Figure 4-9).</br> | ![](figs/Terpsma_2020_Figure_C-4.png)

Linear Acceleration | Rotational Acceleration | Rotational Velocity
:--: | :--: | :--:
![](figs/Terpsma_2020_Figure_4-9.png) | ![](figs/Terpsma_2020_Figure_4-10.png) | ![](figs/Terpsma_2020_Figure_4-11.png)

> Figure 4  `Bob-066b` - Terpsma 2020 SAND, at page 22, Table 3-1, helmeted Bob onto inclined anvil is simulation reference `Bob-066b`.  Boundary condition: experimental angular velocity time history (Figure 4-11), which is a time integration of the angular acceleration time history (Figure 4-10), around `X` axis ("yes" gesture head rotation).

## Queue Reference

```bash
mywcid
sinfo
squeue -u chovey
squeue -u chovey --start
```

## SSM Questions

* Why does this no longer work:

```bash
# new, run this first
export PSM2_DEVICES='shm,self'
# then

# DRY code
IFILE="bob069.i"

echo "Check syntax of input deck: $IFILE"
adagio --check-syntax -i $IFILE  # to check syntax of input deck

# echo "Check syntax of input deck ($IFILE) and mesh loading"
adagio --check-input  -i $IFILE  # to check syntax of input deck and mesh load
```

* How do determine the number of equations being solved, not just the number of elements?
