# ssm

Sierra Solid Mechanics simulations

## Goal

* Reproduce the *Mil Med* workflow.
* Substitute BCs: Compare RMU `8 krad/s` `8 ms` [boundary condition](https://github.com/autotwin/basis?tab=readme-ov-file#methods).
* Substitue mesh: Substitute Bob model with Autotwin [two material model](https://github.com/autotwin/pixel).

Boundary Condition | Model
:--- | :---:
![](figs/Terpsma_2020_Figure_4-10.png) | ![](figs/Terpsma_2020_Figure_C-4.png)
![](figs/AngAccel.png)| ![](figs/autotwin_bi_material_voxels.png)

## Start Point

Axes | Figure
:--- | :---:
`X` axis is right to left ("yes" gesture head rotation).</br>`Z` axis is vertical (inferior to superior axis in Figure 4-9),</br> * `Y` axis horizontal (anterior to posterior axis in Figure 4-9).</br> | ![](figs/Terpsma_2020_Figure_C-4.png)

Linear Acceleration | Rotational Acceleration | Rotational Velocity
:--: | :--: | :--:
![](figs/Terpsma_2020_Figure_4-9.png) | ![](figs/Terpsma_2020_Figure_4-10.png) | ![](figs/Terpsma_2020_Figure_4-11.png)

> *Figure #*  `Bob-066b` - Terpsma 2020 SAND, at page 22, Table 3-1, helmeted Bob onto inclined anvil is simulation reference `Bob-066b`.  Boundary condition: experimental angular velocity time history (Figure 4-11), which is a time integration of the angular acceleration time history (Figure 4-10), around `X` axis ("yes" gesture head rotation).

The SSM input file: [`bob-1mm-5kg-helmet2-0305-hemi-066b.i`](input/bob-1mm-5kg-helmet2-0305-hemi-066b.i), from Terpsma 2020 at page 165

## End Point

RMU Boundary Conditions

```bash
# All_Hex_Dec.inp excerpt, starting at line 3229116, Anu Tripathy email 2023-03-02
** BOUNDARY CONDITIONS
**
** Name: Acc-BC-1 Type: Acceleration/Angular acceleration
*Boundary, amplitude=LIN_ACC_X, type=ACCELERATION
Ref, 1, 1, 1.
** Name: Acc-BC-2 Type: Acceleration/Angular acceleration
*Boundary, amplitude=LIN_ACC_Z, type=ACCELERATION
Ref, 2, 2, -1.
** Name: Acc-BC-3 Type: Acceleration/Angular acceleration
*Boundary, amplitude=LIN_ACC_Y, type=ACCELERATION
Ref, 3, 3, -1.
** Name: Acc-BC-4 Type: Acceleration/Angular acceleration
*Boundary, amplitude=ANG_VEL_X, type=ACCELERATION
Ref, 4, 4, 1.
** Name: Acc-BC-5 Type: Acceleration/Angular acceleration
*Boundary, amplitude=ANG_VEL_Z, type=ACCELERATION
Ref, 5, 5, -1.
** Name: Acc-BC-6 Type: Acceleration/Angular acceleration
*Boundary, amplitude=ANG_VEL_Y, type=ACCELERATION
```



* To come.

## References

* [casco_sim repo](https://cee-gitlab.sandia.gov/chovey/casco_sim)
* [Terpsma 2021 Mil Med](https://github.com/hovey/hovey.github.io/blob/master/docs/Terpsma_2021_001.pdf)
* [Terpsma 2020 SAND](https://github.com/hovey/hovey.github.io/blob/master/docs/Terpsma_2020_SAND2020_11444.pdf)
* [Minimum Working Example Utah brain Issue 19](https://github.com/autotwin/mesh/issues/19)