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

* The *Mil Med* mesh has 4,631,316 elements, 328 MB.
* The Utah SCI has xxx elements, xxx MB.

### Simulation Characteristics

Table 1: Simulation index, mm=*Military Medicine*, either mesh or boundary condition.

item | `sim` | mesh | bc | T_sim | machine | # proc | cpu time | wall time
:---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: 
1 | `bob066b` | mm | mm | 10 ms | eclipse | 336 | hh:mm | hh: mm
2 | `bob067` | mm | mm | 10 ms | eclipse | 336 | hh:mm | hh: mm
3 | `sci001` | T1_Utah_SCI | mm | 5 | 6 | 7 | 8 | 9
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
