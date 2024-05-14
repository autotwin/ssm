begin sierra simulation_name

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

  begin function gravity_accel
    type is constant
    begin values
      1.0
    end values
  end function gravity_accel

  begin function crush_soft
    type is piecewise linear
    abscissa = compaction
    ordinate = stress
    x scale  = 1.0
    x offset = 0.0
    y scale  = 1.0
    y offset = 0.0
    begin values
      0.0977 10.05e5    # (s, dyne/cm2)
      0.8    13.41e5 # (s, dyne/cm2)
    end values
  end function crush_soft

  begin function crush_hard
    type is piecewise linear
    abscissa = compaction
    ordinate = stress
    x scale  = 1.0
    x offset = 0.0
    y scale  = 1.0
    y offset = 0.0
    begin values
      0.0 17.4293e5    # (s, dyne/cm2)
      1.0 32.4293e5 # (s, dyne/cm2)
    end values
  end function crush_hard

  begin function constant_velocity
    type is piecewise linear
    abscissa = time_value
    ordinate = velocity_value
    x scale  = 1.0
    x offset = 0.0
    y scale  = 1.0
    y offset = 0.0
    begin values
      0.0    0.0 # (s, cm/s)
      0.001 20.0 # (s, cm/s)
      1.0   20.0 # (s, cm/s)
    end values 
  end function constant_velocity

  begin function load_unload
    type = piecewise linear
    abscissa = time_value
    ordinate = displacement_value
    x scale = 1.0
    x offset = 0.0
    y scale = 1.0
    y offset = 0.0
    begin values
      0.0  0.0
      1.0 -1.0
      2.0  0.0
    end values
  end function load_unload

  begin function ramp
    type = piecewise linear
    abscissa = time_value
    ordinate = displacement_value
    x scale = 1.0
    x offset = 0.0
    y scale = 1.0
    y offset = 0.0
    begin values
      0.0  0.0
      1.0 -1.0 # negative to create compression
    end values
  end function ramp

  {include("../../bcs/skull_rotate.txt")}

  {include("../../bcs/VelY.txt")}

  {include("../../bcs/VelZ.txt")}

  # ---------------------------------------------------------------------------
  # materials: listed in alphabetical order
  # ---------

  # ---------------------
  begin material al6061t6
  # ---------------------

    # asm.matweb.com, ma6061t6
      
    density = 2.77                 # g/cc = 0.098 lb/in^3
      
    begin parameters for model elastic_plastic

      youngs modulus    =  68.9e10 # dyne/cm^2 = 10e6 psi = 68.9 GPa
      poissons ratio    =   0.33   # cm/cm     = unitless
      yield stress      = 276.0e7  # dyne/cm^2 = 40e3 psi = 276 MPa
      hardening modulus =  68.9e7  # dyne/cm^2 = 10e3 psi =  68 MPa
      beta              =   1.0    # unitless 
      
    end parameters for model elastic_plastic

  end material al6061t6

  # -----------------
  begin material bone
  # -----------------

    # reference: Morse 2014, C. Franck Lacrosse paper
    # bone: linear elastic, E = 6.5 GPa, nu = 0.45; rho = ?
    # materials properties QC 2019-06-25 CBH with Materials for Casco document
  
    density = 1.210 # g/cc 

    begin parameters for model elastic
      youngs modulus  =   8.0e10  # dyne/cm^2 = 8.0 GPa
      poissons ratio  =   0.22    # cm/cm     = unitless
    end parameters for model elastic

    begin parameters for model elastic_plastic
      youngs modulus  =   8.0e10  # dyne/cm^2 = 8.0 GPa
      poissons ratio  =   0.22    # cm/cm     = unitless
      yield stress    =   6.40e8  # dyne/cm^2 = 64 MPa
      beta            =   1.0     # 1.0 is isotropic hardening, 0.0 is kinematic
      hardening modulus = 0.0     # dyne/cm^2 (perfect plasticity)
    end parameters for model elastic_plastic

    begin parameters for model johnson_cook
      youngs modulus      =  8.0e10     # dyne/cm^2 = 8.0 GPa
      poissons ratio      =  0.22       # cm/cm     = unitless
      yield stress        =  9.5e8      # dyne/cm^2 = 95 MPa
      hardening constant  =  0.0        # unitless
      hardening exponent  =  0.0        # unitless
      rate constant       =  0.0        # unitless
      reference rate      =  0.0        # unitless
      edot_ref            =  1.0        # unitless
      d1                  =  0.008      # unitless
      d2                  =  0.0        # unitless
      d3                  =  0.0        # unitless
      d4                  =  0.0        # unitless
      d5                  =  0.0        # unitless
    end parameters for model johnson_cook

  end material bone

  # ----------------
  begin material csf # cerebral spinal fluid
  # ----------------

    # materials properties QC 2019-06-25 CBH with Materials for Casco document
  
    density = 1.004 # g/cc

    begin parameters for model elastic
      # 2019-07-16 starting with Bob-035, specific (K, G) because less
      # sensitive than specifiying nu ~= 0.499
      #
      # youngs modulus  =   1.50e8    # dyne/cm^2 = 15.0 MPa
      # poissons ratio  =   0.4987252 # cm/cm = unitless
      #
      shear modulus     =   5.000e3   # dyne/cm^2 = 500 Pa, matches Zhang 2001
      bulk modulus      =   2.371e10  # dyne/cm^2 (match K for gray and white matter)
    end parameters for model elastic

  end material csf

  # -----------------
  begin material disc # see /cielo/sims/b1341_10.0 for rho, cs, possion, yield
  # -----------------
  
    # materials properties QC 2019-06-25 CBH with Materials for Casco document

    density = 1.000 # g/cc

    begin parameters for model elastic
      youngs modulus  =  4.27e8 # dyne/cm^2 = 42.7 MPa
                                # Yang 2016, Fig 2, 30-yo at 20%/s strain rate
      poissons ratio  =    0.40 # cm/cm = unitless
    end parameters for model elastic

  end material disc 

  # -----------------------
  begin material graymatter
  # -----------------------

    # reference: Morse 2014, C. Franck Lacrosse paper
    # general brain: neo-Hookean, K=2190 MPa, mu = 22.53 kPa; rho = 1040 kg/m^3
    # materials properties QC 2019-06-25 CBH with Materials for Casco document
    # for placeholder elastic and Swanson viscoelastic

    density = 1.040 # g/cc

    # placeholder prior to Swanson
    # begin parameters for model elastic
    #   youngs modulus  =   1.50e8 # dyne/cm^2 = 15.0 MPa
    #   poissons ratio  =   0.45   # cm/cm = unitless
    # end parameters for model elastic

    begin parameters for model viscoelastic_swanson
      bulk modulus  =   2.371e10 # dyne/cm^2 = 2.371e9 Pa
#     shear modulus =   3.400e5  # dyne/cm^2
      A1            =   3.400e5  # dyne/cm^2
      P1            =   0
      B1            =   0
      Q1            =   0
      C1            =   0
      R1            =   0
      cut off strain        = 0.05
      prony shear infinity  = 1.8824e-1  # Pa/Pa
      prony shear 1         = 8.1176e-1  # Pa/Pa
      prony shear 2         = 1.0e-4
      prony shear 3         = 1.0e-4
      prony shear 4         = 1.0e-4
      prony shear 5         = 1.0e-4
      prony shear 6         = 1.0e-4
      prony shear 7         = 1.0e-4
      prony shear 8         = 1.0e-4
      prony shear 9         = 1.0e-4
      prony shear 10        = 1.0e-4
      # shear relax time 1    = 2.50e-2  # seconds, formerly 1.4286e-3 s
      shear relax time 1    = 1.4286e-3  # seconds, investigate quick relaxation
      shear relax time 2    = 100
      shear relax time 3    = 150
      shear relax time 4    = 200
      shear relax time 5    = 250
      shear relax time 6    = 300
      shear relax time 7    = 350
      shear relax time 8    = 400
      shear relax time 9    = 450
      shear relax time 10   = 500
      wlf coef c1           = 1.0
      wlf coef c2           = 1.0
      wlf tref              = 298
      MAX POISSONS RATIO    = 0.49
      end parameters for model viscoelastic_swanson

  end material graymatter

  # ---------------------
  begin material helmetpad # formerly pads in Lud
  # ---------------------

    # materials properties QC 2019-06-25 CBH with Materials for Casco document

    density = 0.140 # g/cc

    begin parameters for model elastic_plastic
      youngs modulus  =  7.00e7 # dyne/cm^2 = 7.00e6 Pa
      poissons ratio  =    0.20 # cm/cm = unitless
      yield stress    =   2.5e6 # dyne/cm^2 = 2.5e5 Pa
      hardening modulus = 7.0e6 # dyne/cm^2 = 7.0e5 Pa 
      beta = 0.5                # unitless
    end parameters for model elastic_plastic

  end material helmetpad

  # --------------------------
  begin material helmetpadhard # from cyl-1mm-non-0305-hard-038.i
  # --------------------------

    # reference: Morse 2014, C. Franck Lacrosse paper
    # general brain: neo-Hookean, K=2190 MPa, mu = 22.53 kPa; rho = 1040 kg/m^3
    # materials properties QC 2019-06-25 CBH with Materials for Casco document
    # for placeholder elastic and Swanson viscoelastic

    # density = 0.059 # g/cc, 14.84 g / 250.518 cc = 0.059 
    density   = 1.103e-1 # g/cc  # 2019-08-09 match Sushant measured mass

    begin parameters for model elastic
      youngs modulus  =   1.50e8 # dyne/cm^2 = 15.0 MPa
      poissons ratio  =   0.45   # cm/cm = unitless
    end parameters for model elastic

    begin parameters for model elastic_plastic  # note, parameters from test data at 20/s
      youngs modulus     =   4.66e7    # dyne/cm^2 = 4.66 MPa
      poissons ratio     =   0.1       # cm/cm = unitless
      yield stress       =   0.21e7    # dyne/cm^2 = 0.21 MPa
      beta               =   1.0       # unitless
   #   hardening modulus  =   0.025e7   # dyne/cm^2 = 0.025 MPa
      hardening modulus  =   0.025e3   # dyne/cm^2 = 0.0000025 MPa, guess, want this to be close to flat
    end parameters for model elastic_plastic

    begin parameters for model viscoelastic_swanson
      bulk modulus  =   2.371e10 # dyne/cm^2 = 2.371e9 Pa
#     shear modulus =   3.400e5  # dyne/cm^2
      A1            =   3.400e5  # dyne/cm^2
      P1            =   0
      B1            =   0
      Q1            =   0
      C1            =   0
      R1            =   0
      cut off strain        = 0.05
      prony shear infinity  = 1.8824e-1  # Pa/Pa
      prony shear 1         = 8.1176e-1  # Pa/Pa
      prony shear 2         = 1.0e-4
      prony shear 3         = 1.0e-4
      prony shear 4         = 1.0e-4
      prony shear 5         = 1.0e-4
      prony shear 6         = 1.0e-4
      prony shear 7         = 1.0e-4
      prony shear 8         = 1.0e-4
      prony shear 9         = 1.0e-4
      prony shear 10        = 1.0e-4
      # shear relax time 1    = 2.50e-2  # seconds, formerly 1.4286e-3 s
      shear relax time 1    = 1.4286e-3
      shear relax time 2    = 100
      shear relax time 3    = 150
      shear relax time 4    = 200
      shear relax time 5    = 250
      shear relax time 6    = 300
      shear relax time 7    = 350
      shear relax time 8    = 400
      shear relax time 9    = 450
      shear relax time 10   = 500
      wlf coef c1           = 1.0
      wlf coef c2           = 1.0
      wlf tref              = 298
      MAX POISSONS RATIO    = 0.49
    end parameters for model viscoelastic_swanson

    begin parameters for model orthotropic_crush
      youngs modulus = 1.00e+07
      poissons ratio = 0.00

      ex = 1.00e+07
      ey = 1.00e+07
      ez = 1.00e+07
      gxy = 0.50e+07
      gyz = 0.50e+07
      gzx = 0.50e+07

      crush xx = crush_hard
      crush yy = crush_hard
      crush zz = crush_hard
      crush xy = crush_hard
      crush yz = crush_hard
      crush zx = crush_hard

      vmin = 0.70

      yield stress = 28.967650904744864e+07

    end parameters for model orthotropic_crush
      
  end material helmetpadhard

  # --------------------------
  begin material helmetpadsoft # from cyl-1mm-non-0305-soft-039.i
  # --------------------------

    # reference: Morse 2014, C. Franck Lacrosse paper
    # general brain: neo-Hookean, K=2190 MPa, mu = 22.53 kPa; rho = 1040 kg/m^3
    # materials properties QC 2019-06-25 CBH with Materials for Casco document
    # for placeholder elastic and Swanson viscoelastic

    # density = 0.056 # g/cc, 14.15 g / 250.518 cc = 0.059 
    density   = 1.047e-1 # g/cc  # 2019-08-09 match Sushant measured mass

    begin parameters for model elastic
      youngs modulus  =   1.50e8 # dyne/cm^2 = 15.0 MPa
      poissons ratio  =   0.45   # cm/cm = unitless
    end parameters for model elastic

    begin parameters for model elastic_plastic  # note, parameters from test data at 20/s
      youngs modulus     =   0.85e7    # dyne/cm^2 = 0.85 MPa
      poissons ratio     =   0.1       # cm/cm = unitless
      yield stress       =   0.048e7   # dyne/cm^2 = 0.048 MPa
      beta               =   1.0       # unitless
      hardening modulus  =   0.091e7   # dyne/cm^2 = 0.091 MPa
    end parameters for model elastic_plastic

    begin parameters for model viscoelastic_swanson
      bulk modulus  =   2.371e10 # dyne/cm^2 = 2.371e9 Pa
#     shear modulus =   3.400e5  # dyne/cm^2
      A1            =   3.400e5  # dyne/cm^2
      P1            =   0
      B1            =   0
      Q1            =   0
      C1            =   0
      R1            =   0
      cut off strain        = 0.05
      prony shear infinity  = 1.8824e-1  # Pa/Pa
      prony shear 1         = 8.1176e-1  # Pa/Pa
      prony shear 2         = 1.0e-4
      prony shear 3         = 1.0e-4
      prony shear 4         = 1.0e-4
      prony shear 5         = 1.0e-4
      prony shear 6         = 1.0e-4
      prony shear 7         = 1.0e-4
      prony shear 8         = 1.0e-4
      prony shear 9         = 1.0e-4
      prony shear 10        = 1.0e-4
      # shear relax time 1    = 2.50e-2  # seconds, formerly 1.4286e-3 s
      shear relax time 1    = 1.4286e-3
      shear relax time 2    = 100
      shear relax time 3    = 150
      shear relax time 4    = 200
      shear relax time 5    = 250
      shear relax time 6    = 300
      shear relax time 7    = 350
      shear relax time 8    = 400
      shear relax time 9    = 450
      shear relax time 10   = 500
      wlf coef c1           = 1.0
      wlf coef c2           = 1.0
      wlf tref              = 298
      MAX POISSONS RATIO    = 0.49
    end parameters for model viscoelastic_swanson

    begin parameters for model orthotropic_crush
      youngs modulus = 6.0e+06
      poissons ratio = 0.00

      ex = 6.000e+06
      ey = 6.000e+06
      ez = 6.000e+06
      gxy = 3.00e+06
      gyz = 3.00e+06
      gzx = 3.00e+06

      crush xx = crush_soft
      crush yy = crush_soft
      crush zz = crush_soft
      crush xy = crush_soft
      crush yz = crush_soft
      crush zx = crush_soft

      vmin = 0.7

      yield stress = 1.00e+08

    end parameters for model orthotropic_crush

  end material helmetpadsoft

  # ------------------------
  begin material helmetshell # formerly helmet in Lud
  # ------------------------

    # materials properties QC 2019-06-25 CBH with Materials for Casco document
    # density         = 1.440 # g/cc
    density         = 9.250e-1 # g/cc  # 2019-08-09 match Sushant measured mass

    begin parameters for model elastic_plastic
      youngs modulus  =    1.0e12 # dyne/cm^2 = 1.0e11 Pa
      poissons ratio  =      0.30 # cm/cm = unitless
      yield stress    =     8.2e9 # dyne/cm^2 =  8.2e8 Pa
      hardening modulus = 1.36e10 # dyne/cm^2 = 1.36e9 Pa
      beta = 0.5                  # unitless
   end parameters for model elastic_plastic

  end material helmetshell

  # ---------------------
  begin material hemi
  # ---------------------

    # 304 SS per Sushant  

    density = 8.00 # g/cc
      
    begin parameters for model elastic

      youngs modulus    =  193.0e10  # dyne/cm^2 = 10e6 psi = 193.0 GPa
      poissons ratio    =    0.29    # cm/cm     = unitless

    end parameters for model elastic

  end material hemi

  # ----------------------
  begin material magnesium
  # ----------------------

    # MEP pad, cf Malave email 2018-11-20-1232
    # DOT mass = 3226.4 g
    # travel arm assy (arm, mount, clamp) = 1773.6 g
    # asm.matweb.com, magnesium alloys, general
    # materials properties QC 2019-06-25 CBH with Materials for Casco document
      
    # density = 1.800 # g/cc 
    density = 2.080 # g/cc, increase to make sim mass match exp mass
      
    begin parameters for model elastic

      youngs modulus    =  4.050e11 # dyne/cm^2 = 4.50e10 Pa 
      poissons ratio    =  0.35     # cm/cm     = unitless

    end parameters for model elastic

  end material magnesium

  # ---------------------
  begin material membrane # formerly ft for falx-tentorium in Lud
  # ---------------------
  
    # materials properties QC 2019-06-25 CBH with Materials for Casco document

    density = 1.133 # g/cc

    begin parameters for model elastic
      youngs modulus  =   3.15e8 # dyne/cm^2 = 3.15e7 Pa
      poissons ratio  =   0.45   # cm/cm = unitless
    end parameters for model elastic

  end material membrane

  # -------------------
  begin material meppad
  # -------------------
      
    # MEP pad, cf 
    # Malave email 2018-11-20-1232
    # Fawzi email 2018-10-31-1036
    # Cadex created MEP from cast polyurethane called Triathane from
    # Crosslink Technology Inc Hardness 60 Shore A (not MEP
    # made from neoprene rubber), tensile modulus at 100% elongation 
    # is 397 psi = 2.737e7 dyne/cm^2, assume same in tension and compression
    # materials properties QC 2019-06-25 CBH with Materials for Casco document

    # density = 1.030 # g/cc, should yield pad mass 467.65 g
    density = 1.010 # g/cc, should yield pad mass 467.65 g
                    # update to make sim mass match exp mass
      
    begin parameters for model elastic

      # youngs modulus    =   2.4633e7 # dyne/cm^2 # s1 
      # youngs modulus    =   2.737e7  # dyne/cm^2 # s0 s3 s4 
      # youngs modulus    =   3.0107e7 # dyne/cm^2 # s2 s5
      # youngs modulus    =   3.2844e7 # dyne/cm^2 # s6
      # youngs modulus    =   3.5581e7 # dyne/cm^2 # s7
      # youngs modulus    =   3.8318e7 # dyne/cm^2 # s8
        youngs modulus    =   5.4740e7 # dyne/cm^2 # s9
      # poissons ratio    =   0.36    # cm/cm     = unitless # s3
      # poissons ratio    =   0.40    # cm/cm     = unitless # s0 s1 s2
      # poissons ratio    =   0.44    # cm/cm     = unitless # s4 s5
      # poissons ratio    =   0.48    # cm/cm     = unitless # s6
        poissons ratio    =   0.49    # cm/cm     = unitless # s7 s8 s9

    end parameters for model elastic

  end material meppad

  # ---------------------
  begin material mepplate
  # ---------------------
      
    # MEP plate, cf Malave email 2018-11-20-1232
    # Note: MEP (pad + plate) = 974.85 g (combined)
    # materials properties QC 2019-06-25 CBH with Materials for Casco document

    # density = 2.700 # g/cc, should yield plate mass 507.195 g
    density = 2.540 # g/cc, should yield plate mass 507.195 g
                    # update to make sim mass match exp mass 
      
    begin parameters for model elastic

      youngs modulus    =  6.89e11 # dyne/cm^2 = 10e6 psi = 6.89e10 Pa
      poissons ratio    =   0.33   # cm/cm     = unitless

    end parameters for model elastic

  end material mepplate

  # -------------------
  begin material muscle # exactly copy of skin for now 2019-02-18
                        # needs migration to match CTH Swanson model usage
  # -------------------
  
    # materials properties QC 2019-06-25 CBH with Materials for Casco document

    density = 1.200 # g/cc

    begin parameters for model elastic
      youngs modulus  =   1.67e8 # dyne/cm^2 = 1.67e7 Pa
      poissons ratio  =   0.42   # cm/cm = unitless
    end parameters for model elastic

  end material muscle 

  # ------------------
  begin material sinus
  # ------------------
  
    density = 1.218e-3 # g/cc

    begin parameters for model elastic
      youngs modulus  =   1398.e4 # dyne/cm^2 = 1.398 MPa
      poissons ratio  =   0.49    # cm/cm = unitless
    end parameters for model elastic

  end material sinus

  # -----------------
  begin material skin
  # -----------------

    # reference: Morse 2014, C. Franck Lacrosse paper
    # skin: neo-Hookean, K=34.7 MPa, mu = 5880 kPa; rho = 1040 kg/m^3
    # materials properties QC 2019-06-25 CBH with Materials for Casco document
  
    density = 1.200 # g/cc

    begin parameters for model elastic
      youngs modulus  =   1.67e8 # dyne/cm^2 = 1.67e7 Pa
      poissons ratio  =   0.42   # cm/cm = unitless
    end parameters for model elastic

  end material skin

  # ------------------------
  begin material whitematter
  # ------------------------
  
    # reference: Morse 2014, C. Franck Lacrosse paper
    # general brain: neo-Hookean, K=2190 MPa, mu = 22.53 kPa; rho = 1040 kg/m^3
    # materials properties QC 2019-06-25 CBH with Materials for Casco document
    # for placeholder elastic and Swanson viscoelastic

    density = 1.040 # g/cc

    # placeholder prior to Swanson
    # begin parameters for model elastic
    #   youngs modulus  =   1.50e8 # dyne/cm^2 = 15.0 MPa
    #   poissons ratio  =   0.45   # cm/cm = unitless
    # end parameters for model elastic

    begin parameters for model viscoelastic_swanson
      bulk modulus  =   2.371e10 # dyne/cm^2 = 2.371e9 Pa 
#     shear modulus =   4.100e5  # dyne/cm^2 
      A1            =   4.100e5  # dyne/cm^2
      P1            =   0
      B1            =   0
      Q1            =   0
      C1            =   0
      R1            =   0
      cut off strain        =  0.05
      prony shear infinity  = 1.9024e-1  # Pa/Pa
      prony shear 1         = 8.0976e-1  # Pa/Pa
      prony shear 2         = 1.0e-4
      prony shear 3         = 1.0e-4
      prony shear 4         = 1.0e-4
      prony shear 5         = 1.0e-4
      prony shear 6         = 1.0e-4
      prony shear 7         = 1.0e-4
      prony shear 8         = 1.0e-4
      prony shear 9         = 1.0e-4
      prony shear 10        = 1.0e-4
      # shear relax time 1    = 2.50e-2  # seconds, formerly 1.4286e-3 s
      shear relax time 1    = 1.4286e-3  # seconds, investigate quick relaxation
      shear relax time 2    = 100
      shear relax time 3    = 150
      shear relax time 4    = 200
      shear relax time 5    = 250
      shear relax time 6    = 300
      shear relax time 7    = 350
      shear relax time 8    = 400
      shear relax time 9    = 450
      shear relax time 10   = 500
      wlf coef c1           = 1.0
      wlf coef c2           = 1.0
      wlf tref              = 298
      MAX POISSONS RATIO    = 0.49
    end parameters for model viscoelastic_swanson

  end material whitematter

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

        termination time = 0.0001 # second
      # termination time = 0.001 # second
      # termination time = 0.006 # second
      # termination time = 0.008 # second
      # termination time = 0.010 # second
      # termination time = 0.012 # second
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
        at time 0.0 increment = 0.0002 # seconds
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
        at time 0.0 increment = 0.00002    # seconds, 50,000 Hz acquisition
      # at time 0.0 increment = 3.00003e-5 # seconds, 33,333 Hz acquisition
      # at time 0.0 increment = 0.0001     # seconds, 10,000 Hz acquisition

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
        at time 0.0 increment = 0.00002    # seconds, 50,000 Hz acquisition
      # at time 0.0 increment = 3.00003e-5 # seconds, 33,333 Hz acquisition
      # at time 0.0 increment = 0.0001     # seconds, 10,000 Hz acquisition

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

