#include this towards the top after begin sierra

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

