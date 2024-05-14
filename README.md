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

### Mesh Characteristics

* The spheres mesh is 5,496,376 elements, 400 MB.
* The *Mil Med* mesh has 4,631,316 elements, 328 MB.
* The Utah SCI has xxx elements, xxx MB.

### Simulation Characteristics

Table 1: Simulation index, *Military Medicine* either Bob mesh and boundary condition of 10x3=10 ms and 3 krad, 8x8=8 ms and 8 krad angular acceleration pulse.

item | `sim` | mesh | bc | T_sim | machine | # proc | cpu time (hh:mm) | wall time (days)
:---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: 
0 | [`vox_0.1cm`](https://github.com/autotwin/basis?tab=readme-ov-file#voxel-meshes) | spheres | 8x8 | 20 ms | skybridge | 160 | 01:43 | 11.5
1 | `bob066b` | Bob | 10x3 | xxx ms | eclipse | 336 | xxx | xxx 
2 | `bob067` | Bob | 10x3 | xxx ms | eclipse | 336 | xxx | xxx
3 | [`sci001`](https://github.com/autotwin/mesh/tree/main/doc/T1_Utah_SCI_brain) | T1_Utah_SCI | 10x3 | 5 | 6 | 7 | 8 | 9
1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

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

> *Figure #*  `Bob-066b` - Terpsma 2020 SAND, at page 22, Table 3-1, helmeted Bob onto inclined anvil is simulation reference `Bob-066b`.  Boundary condition: experimental angular velocity time history (Figure 4-11), which is a time integration of the angular acceleration time history (Figure 4-10), around `X` axis ("yes" gesture head rotation).
