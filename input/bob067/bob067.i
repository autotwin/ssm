begin sierra simulation_name

  # Reproduce original Military Medicine results, created with
  # https://cee-gitlab.sandia.gov/chovey/casco_sim/-/blob/master/bob-1mm-5kg-helmet2-0305-hemi-066b/bob-1mm-5kg-helmet2-0305-hemi-066b.i
  # commit hash: d6872e0e022ec7db029db3951fba65d1ce18c76e
  # parent file: ~/autotwin/ssm/input/bob066b/bob-1mm-5kg-helmet2-0305-hemi-066b.i

  # ------------------------------------
  # units: grams, centimeters, seconds
  # -----

  # ---------------------------------------------------------------------------
  # include files
  # -----------------
  
  {include("../../include/e_vm-functions.i")}
  {include("../../include/e_dot_vm-functions.i")}

  # ---------------------------------------------------------------------------
  # direction vectors
  # -----------------

  define point origin with coordinates 0.0 0.0 0.0
  define point cg with coordinates 33.6315 21.4892 12.3570

  define direction x_positive with vector 1.0 0.0 0.0
  define direction y_positive with vector 0.0 1.0 0.0
  define direction z_positive with vector 0.0 0.0 1.0

  define axis x_axis with point origin direction x_positive 
  define axis y_axis with point origin direction y_positive
  define axis z_axis with point origin direction z_positive

  define axis cg_rotation_axis with point cg direction x_positive

  # ---------------------------------------------------------------------------
  # user functions 
  # --------------

  {include("../../include/user-functions.i")}

  {include("../../bcs/skull_rotate.txt")}
  {include("../../bcs/VelY.txt")}
  {include("../../bcs/VelZ.txt")}

  # ---------------------------------------------------------------------------
  # materials: listed in alphabetical order
  # ---------

  {include("../../material/al6061t6.txt")}
  {include("../../material/bone.txt")}
  {include("../../material/csf.txt")}
  {include("../../material/disc.txt")}
  {include("../../material/graymatter.txt")}
  {include("../../material/helmetpad.txt")}
  {include("../../material/helmetpadhard.txt")}
  {include("../../material/helmetpadsoft.txt")}
  {include("../../material/helmetshell.txt")}
  {include("../../material/hemi.txt")}
  {include("../../material/magnesium.txt")}
  {include("../../material/membrane.txt")}
  {include("../../material/meppad.txt")}
  {include("../../material/mepplate.txt")}
  {include("../../material/muscle.txt")}
  {include("../../material/sinus.txt")}
  {include("../../material/skin.txt")}
  {include("../../material/whitematter.txt")}

  begin rigid body rigidSkull
    reference location = 33.6315 21.4892 12.3570
#    magnitude = 1000.0
#    direction = y_positive
#    angular velocity = 1570.0 # 90 deg rotation at t=0.001
#    angular velocity = 1000.0
#    cylindrical axis = cg_rotation_axis
  end rigid body rigidSkull
  
  begin solid section rigidSection
    rigid body = rigidSkull
  end solid section rigidSection


  # ---------------------------------------------------------------------------
  # mesh

  # ---------------------------------------------------------------------------
  # mesh
  # ----

  begin finite element model crush

    database name = ../../geometry/bob-1mm-5kg-helmet2-hemi.g
    # database name = /projects/sibl/data/bob-1mm-5kg-helmet-hemi/bob-1mm-5kg-helmet2-hemi.g
    # database name = ../geometry/bob-1mm-5kg-helmet2-hemi.g
    # database name = ../../geometry/data/bob-1mm-5kg-helmet-hemi/bob-1mm-5kg-helmet2-hemi.g
    # database name = /projects/sibl/geometry/data/bob-1mm-5kg-helmet-hemi/bob-1mm-5kg-helmet2-hemi.g
    # database name = /projects/sibl/geometry/data/bob-1mm-5kg-helmet-hemi/bob-1mm-5kg-helmet-hemi.g
    # database name = /projects/sibl/geometry/data/bob-2mm-5kg-helmet-mep/bob-2mm-5kg-helmet-mep.g
    # database name = /projects/sibl/geometry/data/bob-2mm-5kg-non-mep/bob-2mm-5kg-non-mep.g
    # database name = /projects/sibl/geometry/data/bob-2mm-non-mep/bob-2mm-non-mep.g
    # database name = /projects/sibl/geometry/data/bob-1mm-non-mep/bob-1mm-non-mep.g
    # database name = /projects/sibl/geometry/data/bob-non-mep/bob-2mm-non-mep.g
    # database name = /projects/sibl/geometry/data/dot-sphere-mep/dot_sphere_mep.g
    # database name = dot_sphere_mep.g
    # database name = sphere.g
    # database name = quarter_sphere_block_target.g
    # database name = quarter_sphere.g
    # database name = foam_cube_001.g
    # database name = /projects/sibl/casco/geo/foam_cube_001.g
    database type = exodusII

    omit block block_12 block_20 block_21 block_22 block_23 block_24 \#
               block_25 block_211 block_221 block_231 block_241 block_251

    # -------------------
    # Bob material blocks
    # -------------------
    # with bob-2mm-5kg-non-0305-mep-031, block 5 (larnyx) no longer exists
    # begin parameters for block block_1 block_2 block_3 block_4 \#
    #   block_5 block_6 block_7 block_8 block_9 block_10
    #
    #   material = magnesium
    #   model = elastic
    #
    # end parameters for block block_1 block_2 block_3 block_4 \#
    #   block_5 block_6 block_7 block_8 block_9 block_10

    # ------------------------
    begin parameters for block block_1 # bone

      material = bone
    #  model = elastic
      model = elastic_plastic
      section = rigidSection

    end parameters for block block_1

    # ------------------------
    begin parameters for block block_2 # disc

      material = disc
      model = elastic
      section = rigidSection

    end parameters for block block_2

    # ------------------------
    begin parameters for block block_3 # vasculature

      material = csf # temporarily model as csf
      model = elastic

    end parameters for block block_3

    # ------------------------
    begin parameters for block block_4 # airway_sinus 

      material = sinus
      model = elastic
      section = rigidSection

    end parameters for block block_4

    # ------------------------
    # with bob-2mm-5kg-non-0305-mep-031, block 5 (larnyx) no longer exists
    # begin parameters for block block_5 # larynx

    #   material = sinus # temporarily model as sinus
    #   model = elastic

    # end parameters for block block_5

    # ------------------------
  # begin parameters for block block_6 # membrane
    begin parameters for block block_5 # membrane

      material = membrane
      model = elastic

  # end parameters for block block_6
    end parameters for block block_5

    # ------------------------
  # begin parameters for block block_7 # CSF
    begin parameters for block block_6 # CSF

      material = csf
      model = elastic

  # end parameters for block block_7
    end parameters for block block_6

    # ------------------------
  # begin parameters for block block_8 # white matter
    begin parameters for block block_7 # white matter

      material = whitematter
      model = viscoelastic_swanson

  # end parameters for block block_8
    end parameters for block block_7

    # ------------------------
  # begin parameters for block block_9 # gray matter
    begin parameters for block block_8 # gray matter

      material = graymatter
      model = viscoelastic_swanson

  # end parameters for block block_9
    end parameters for block block_8

    # ------------------------
  # begin parameters for block block_10 # muscle 
    begin parameters for block block_9 # muscle 

      material = muscle 
      model = elastic
      section = rigidSection

  # end parameters for block block_10
    end parameters for block block_9

    # ------------------------
  # begin parameters for block block_11 # skin
    begin parameters for block block_10 # skin

      material = skin
      model = elastic
      section = rigidSection

  # end parameters for block block_11
    end parameters for block block_10

    # -------------------
    # Hemispherical Target
    # -------------------
#    begin parameters for block block_12 # hemi
#
#      material = hemi
#      model = elastic
#
#    end parameters for block block_12

#    # -------------------
#    # Helmet Shell - Kevlar
#    # -------------------
#    begin parameters for block block_20
#
#      material = helmetshell
#      model = elastic_plastic
#
#    end parameters for block block_20
#
#    # -------------------
#    # Helmet Foam - Hard
#    # -------------------
#    begin parameters for block block_21 block_22 block_23 block_24 block_25
#
#      material = helmetpadhard
#      # model = elastic_plastic
#      model = orthotropic_crush
#
#    end parameters for block block_21 block_22 block_23 block_24 block_25
#
#    # -------------------
#    # Helmet Foam - Soft
#    # -------------------
#    begin parameters for block block_211 block_221 block_231 block_241 block_251
#
#      material = helmetpadsoft
#      # model = elastic_plastic
#      model = orthotropic_crush
#
#    end parameters for block block_211 block_221 block_231 block_241 block_251



  end finite element model crush

  # ---------------------------------------------------------------------------
  # procedures
  # ----------

  begin presto procedure presto_procedure

    # ------------
    # time control
    # ------------

    begin time control
  
      begin time stepping block phase_1

        start time = 0.000 # second

        begin parameters for presto region presto_region
          time step scale factor = 1.0 # unitless
        end parameters for presto region presto_region

      end time stepping block phase_1

      # termination time = 0.0001 # second
      # termination time = 0.001 # second
      # termination time = 0.006 # second
      # termination time = 0.008 # second
        termination time = 0.010 # second
      # termination time = 0.012 # second
      # termination time = 0.020 # second
      # termination time = 0.025 # second
      # termination time = 0.035 # second
      # termination time = 0.040 # second
      # termination time = 0.100 # second

    end time control

    # -------------
    # presto region
    # -------------

    begin presto region presto_region

      use finite element model crush

      # ----------------------
      # to locate c.g. of Bob 
      # ----------------------
      begin mass properties
        block = block_1 block_2 block_3 block_4 block_5 block_6 block_7 \#
                block_8 block_9 block_10
        structure name = assembly_bob
      end mass properties

      # ---------------------------
      # to tally the hard foam mass 
      # ---------------------------
#      begin mass properties
#        block = block_21 block_22 block_23 block_24 block_25
#        structure name = assembly_hardfoam 
#      end mass properties

      # ---------------------------
      # to tally the soft foam mass 
      # ---------------------------
#      begin mass properties
#        block = block_211 block_221 block_231 block_241 block_251
#        structure name = assembly_softfoam 
#      end mass properties

      # ---------------------------
      # to tally the hard/soft foam pad assembly mass
      # ---------------------------
#      begin mass properties
#        block = block_21  block_22  block_23  block_24  block_25 \#
#                block_211 block_221 block_231 block_241 block_251
#        structure name = assembly_allfoam
#      end mass properties

      # --------------------
       begin initial velocity
          
         # node set commands
         block = block_3 block_5 block_6 block_7 block_8
          
         # direction specification commands
         # component = z # vertical axis direction
         direction = z_positive
          
         # magnitude specification commands
         magnitude = 304.8 # cm/s = 10 ft/s
          
       end initial velocity

       begin prescribed rotational velocity
         rigid body = rigidSkull
#         block = block_1
#         cylindrical axis = cg_rotation_axis
         component = x
         function = skull_rotate
         scale factor = -1.0 # radians/sec
       end prescribed rotational velocity

       begin prescribed velocity
         rigid body = rigidSkull
         direction = z_positive
         function = VelZ
         scale factor = 1.0   #
       end prescribed velocity

       begin prescribed velocity
         rigid body = rigidSkull
         direction = y_positive
         function = VelY
         scale factor = -1.0   #
       end prescribed velocity

#      begin prescribed velocity
#        block = block_1
#        node set subroutine = aupst_trans_rot_velocity

      # -------------
      # begin gravity
      #   function = gravity_accel
      #   direction = z_positive
      #   gravitational constant = 981.0 # cm/s^2
      #   # gravitational constant = 0.0 # cm/s^2
      # end gravity

      # ---------------------------------
      begin contact definition contact_definition
        # User manual page 623/968
        # DASH search algorithm activates augmented Lagrange enforcement, and 
        # ACME search algorithm activates kinematic enforcement
        # see Section 8.9
        search = dash
        skin all blocks = on
           
        begin tied model tied_model
        end tied model tied_model 
           
        begin constant friction model friction_model
          friction coefficient = 0.2
        end constant friction model friction_model
          
        begin interaction defaults
          general contact = on
          self contact = off
          friction model = friction_model
        end interaction defaults

        initial overlap removal = on

        begin remove initial overlap
          overlap normal tolerance = 0.1
          overlap tangential tolerance = 0.1
          overlap iterations = 100
          debug iteration plot = off
        end remove initial overlap

        #   
        begin constant friction model friction_model
          friction coefficient = 0.2
        end constant friction model friction_model
          

#        begin interaction foam_to_helmet
#          surfaces           = block_20 block_21 block_22 block_23 block_24 block_25
#          friction model     = tied_model
#        end interaction foam_to_helmet


      #
      end contact definition contact_definition

      # -------------------------------

      {include("../../include/e_vm-variables.i")}
      {include("../../include/e_dot_vm-variables.i")}

      # -------------------------------

      # -------------------------------
      begin element death dead_ele
        INCLUDE ALL BLOCKS
        death on inversion = on
        death on ill defined contact = on
        death steps = 5
        # force valid acme connectivity  # 2024-05-13 causes error, why?
      end element death dead_ele
      # -------------------------------

      # -------------------------------
      begin results output field_exodus

        database name = output_field.e
        database type = exodusII
      # at time 0.0 increment = 0.00002 # seconds
      # at time 0.0 increment = 0.0001 # seconds
      # at time 0.0 increment = 0.0002 # seconds
        at time 0.0 increment = 0.001  # seconds
      # at time 0.0 increment = 0.010  # seconds
 
        # ----------
        # kinematics
        # ----------
          nodal variables   = coordinates    as x
          nodal variables   = displacement   as displvec
          nodal variables   = velocity       as v

        # ------
        # stress
        # ------
          element variables = von_mises          # real 
          element variables = hydrostatic_stress # real
          element variables = fluid_pressure     # real

        # ------
        # strain
        # ------
          element variables = min_principal_log_strain  # real
          element variables = max_principal_log_strain  # real
          element variables = max_shear_log_strain      # real
          element variables = min_principal_green_lagrange_strain # real
          element variables = max_principal_green_lagrange_strain # real
        #
        # -----------
        # strain rate
        # -----------
          element variables = min_principal_rate_of_deformation # real
          element variables = max_principal_rate_of_deformation # real
          element variables = min_principal_green_lagrange_strain_rate # real
          element variables = max_principal_green_lagrange_strain_rate # real

        # ----
        # misc
        # ----
          element variables = overlap_volume_ratio
          element variables = death_status as dead_or_alive

        # ----------
        # invariants
        # ----------
          element variables = e_vm     # real, von Mises of GL strain
          element variables = e_dot_vm # real, von Mises of GL strain rate

        # ------
        # energy
        # ------
          global variables  = timestep         as ts
          global variables  = contact_energy   as ce
          global variables  = external_energy  as ee
          global variables  = internal_energy  as ie
          global variables  = kinetic_energy   as ke
          global variables  = hourglass_energy as hge # check this is near zero
          global variables  = strain_energy    as se
          global variables  = momentum         as mo

      end results output field_exodus

      # -------------------------------
      begin heartbeat output hscth_file

        stream name = history.csv
        format = SpyHis
      # at time 0.0 increment = 0.00002    # seconds, 50,000 Hz acquisition
      # at time 0.0 increment = 3.00003e-5 # seconds, 33,333 Hz acquisition
      # at time 0.0 increment = 0.0001     # seconds, 10,000 Hz acquisition
        at time 0.0 increment = 0.0005     # seconds,  2,000 Hz acquisition

        # -----------------------------
        # helmet
        # -----------------------------
        node coordinates   nearest location 33.61001, 21.349597, 26.401136 as rhel
        node displacement  nearest location 33.61001, 21.349597, 26.401136 as uhel
        node velocity      nearest location 33.61001, 21.349597, 26.401136 as vhel
        #
        # -----------------------------
        # Bob head superior-to-inferior every cm in z direction
        # -----------------------------
        # add 34.0 22.0 22.5 from CTH
        # 
        node displacement(z)   nearest location 34.0, 21.0, 23.0 as u23
        node velocity(z)       nearest location 34.0, 21.0, 23.0 as v23
        # node acceleration(z)   nearest location 34.0, 21.0, 23.0 as a23
        #
        node displacement(z)   nearest location 34.0, 21.0, 22.0 as u22
        node velocity(z)       nearest location 34.0, 21.0, 22.0 as v22
        # node acceleration(z)   nearest location 34.0, 21.0, 22.0 as a22
        #
        node displacement(z)   nearest location 34.0, 21.0, 21.0 as u21
        node velocity(z)       nearest location 34.0, 21.0, 21.0 as v21
        # node acceleration(z)   nearest location 34.0, 21.0, 21.0 as a21
        #
        node displacement(z)   nearest location 34.0, 21.0, 20.0 as u20
        node velocity(z)       nearest location 34.0, 21.0, 20.0 as v20
        # node acceleration(z)   nearest location 34.0, 21.0, 20.0 as a20
        #
        node displacement(z)   nearest location 34.0, 21.0, 19.0 as u19
        node velocity(z)       nearest location 34.0, 21.0, 19.0 as v19
        # node acceleration(z)   nearest location 34.0, 21.0, 19.0 as a19
        #
        node displacement(z)   nearest location 34.0, 21.0, 18.0 as u18
        node velocity(z)       nearest location 34.0, 21.0, 18.0 as v18
        # node acceleration(z)   nearest location 34.0, 21.0, 18.0 as a18
        #
        node displacement(z)   nearest location 34.0, 21.0, 17.0 as u17
        node velocity(z)       nearest location 34.0, 21.0, 17.0 as v17
        # node acceleration(z)   nearest location 34.0, 21.0, 17.0 as a17
        #
        node displacement(z)   nearest location 34.0, 21.0, 16.0 as u16
        node velocity(z)       nearest location 34.0, 21.0, 16.0 as v16
        # node acceleration(z)   nearest location 34.0, 21.0, 16.0 as a16
        #
        node displacement(z)   nearest location 34.0, 21.0, 15.0 as u15
        node velocity(z)       nearest location 34.0, 21.0, 15.0 as v15
        # node acceleration(z)   nearest location 34.0, 21.0, 15.0 as a15
        #
        node displacement(z)   nearest location 34.0, 21.0, 14.0 as u14
        node velocity(z)       nearest location 34.0, 21.0, 14.0 as v14
        # node acceleration(z)   nearest location 34.0, 21.0, 14.0 as a14
        #
        node displacement(z)   nearest location 34.0, 21.0, 13.0 as u13
        node velocity(z)       nearest location 34.0, 21.0, 13.0 as v13
        # node acceleration(z)   nearest location 34.0, 21.0, 13.0 as a13
        #
        node displacement(z)   nearest location 34.0, 21.0, 12.0 as u12
        node velocity(z)       nearest location 34.0, 21.0, 12.0 as v12
        # node acceleration(z)   nearest location 34.0, 21.0, 12.0 as a12
        #
        node displacement(z)   nearest location 34.0, 21.0, 11.0 as u11
        node velocity(z)       nearest location 34.0, 21.0, 11.0 as v11
        # node acceleration(z)   nearest location 34.0, 21.0, 11.0 as a11
        #
        node displacement(z)   nearest location 34.0, 21.0, 10.0 as u10
        node velocity(z)       nearest location 34.0, 21.0, 10.0 as v10
        # node acceleration(z)   nearest location 34.0, 21.0, 10.0 as a10
        #
        # --------------------------------
        # Bob c.g. from assembly_bob begin
        # --------------------------------
        # Bob-1mm center of gravity
        node coordinates     nearest location 33.6315, 21.4892, 13.3570 as rcg # shifting up by 1 cell so it does not coincide with rb ref node
        node displacement    nearest location 33.6315, 21.4892, 13.3570 as ucg # shifting up by 1 cell so it does not coincide with rb ref node
        node velocity        nearest location 33.6315, 21.4892, 13.3570 as vcg # shifting up by 1 cell so it does not coincide with rb ref node
        # node acceleration  nearest location 33.6315, 21.4892, 12.3570 as acg
        #
        # Bob-2mm center of gravity
        # node coordinates    nearest location 33.6329, 21.4885, 12.3519 as rcg
        # node displacement   nearest location 33.6329, 21.4885, 12.3519 as ucg
        # node velocity       nearest location 33.6329, 21.4885, 12.3519 as vcg
        # node acceleration   nearest location 33.6329, 21.4885, 12.3519 as acg
        #
        # Bob-1mm center of gravity - top of head
        node coordinates     nearest location 33.6315, 21.4892, 22.7000 as tcg_r  # node 4178148
        node displacement    nearest location 33.6315, 21.4892, 22.7000 as tcg_u  # node 4178148
        # ------------------------------
        # Bob c.g. from assembly_bob end
        # ------------------------------
        #
        # ---------------------------------
        # Bob bone tracers angular velocity begin
        # ---------------------------------
        # Bob-1mm 
        # from origin O to point P, superior, posterior, midline skull
        node coordinates     nearest location 33.6315, 25.8, 21.3 as rOP
        node displacement    nearest location 33.6315, 25.8, 21.3 as uOP
        node velocity        nearest location 33.6315, 25.8, 21.3 as vOP
        #
        # from origin O to point Q, inferior, posterior, midline skull
        node coordinates     nearest location 33.6315, 29.5, 10.2 as rOQ
        node displacement    nearest location 33.6315, 29.5, 10.2 as uOQ
        node velocity        nearest location 33.6315, 29.5, 10.2 as vOQ
        #
        # from origin O to point R, superior, anterior, midline skull
        node coordinates     nearest location 33.6315, 14.6, 19.7 as rOR
        node displacement    nearest location 33.6315, 14.6, 19.7 as uOR
        node velocity        nearest location 33.6315, 14.6, 19.7 as vOR
        #
        # ---------------------------------
        # Bob bone tracers angular velocity end
        # ---------------------------------

      end heartbeat output hscth_file

      begin heartbeat output rigid_body_file

        stream name = rigid_history.csv
        format = SpyHis
      # at time 0.0 increment = 0.00002    # seconds, 50,000 Hz acquisition
      # at time 0.0 increment = 3.00003e-5 # seconds, 33,333 Hz acquisition
      # at time 0.0 increment = 0.0001     # seconds, 10,000 Hz acquisition
        at time 0.0 increment = 0.0005     # seconds,  2,000 Hz acquisition

        # -----------------------------
        # rigid body
        # -----------------------------

        global displx_rigidSkull
        global disply_rigidSkull
        global displz_rigidSkull
        global velx_rigidSkull
        global vely_rigidSkull
        global velz_rigidSkull
        global ax_rigidSkull
        global ay_rigidSkull
        global az_rigidSkull
        global rotdx_rigidSkull
        global rotdy_rigidSkull
        global rotdz_rigidSkull
        global rotvx_rigidSkull
        global rotvy_rigidSkull
        global rotvz_rigidSkull
        global rotax_rigidSkull
        global rotay_rigidSkull
        global rotaz_rigidSkull

      end heartbeat output rigid_body_file

      # See SSM User Guide v4.50, Section 9.6.1 Restart Options, page 777/988
      # Here is the most basic restart: restart data is written at the 
      # last step of analysis or if SSM detects an internal error, such as 
      # element inversion.
      #
      begin restart data restart_data
        database name = g.rsout  # the restart file
        at wall time 700m increment = 12h  # 700 m = 11 hours 40 minutes
        restart = auto
      end restart data restart_data

    end presto region presto_region

  end presto procedure presto_procedure

  # ---------------------------------------------------------------------------
  # end
  # ---

end sierra simulation_name

