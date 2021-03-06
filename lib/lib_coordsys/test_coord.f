      program  test_coord
c
c     test coordinate transormation subroutines
c
      IMPLICIT NONE
c

      double precision  sec2Mjd

      REAL*8   geod_pos(3), site_pos(3), rot_mat(3,3)
      real*8   site_pol(3)
      real*8   state_itrf(6), state_icrf(6)
c
      integer  i, j
      integer  ncent, ntarg
      real*8   time_JD
      real*8   time_GPS
      real*8   mjd
      real*8   sun_state_icrs(3)

      integer  year,month,day,hour,minute
      real*8   second
c
c     Initialization
c
      site_pos(1) = 3427821.12903406d0      
      site_pos(2) = 603665.177281756d0
      site_pos(3) = 5326878.12959883d0
c
c     call xyz2geod
c
      call xyz2geod(site_pos, geod_pos)

      time_GPS      =   941068900.00000000D0
      state_itrf(1) = -0.4779452763743789D+06 
      state_itrf(2) =   .6484966555560268E+07  
      state_itrf(3) =   .1307483700611788E+07
      state_itrf(4) =  0.1272104877037888D+04
      state_itrf(5) =  0.1633553889516119D+04
      state_itrf(6) = -0.7548829175912289D+04

      write(*,*)'state'
      write(*,*) time_GPS
      write(*,*)'coord'
      write(*,*) state_itrf(1), state_itrf(2), state_itrf(3)
      write(*,*)'vel'
      write(*,*) state_itrf(4), state_itrf(5), state_itrf(6)

c     call cal2gps(year,month,day,hour,minute,second, time_GPS)

      time_GPS = time_GPS - 630763200.0d0

c     call gps2cal(time_GPS,year,month,day,hour,minute,second )

      call ITRS2ICRS(time_GPS, state_itrf, state_icrf)

      write(*,*) state_icrf(1), state_icrf(2), state_icrf(3)
      write(*,*) state_icrf(4), state_icrf(5), state_icrf(6)

      stop

c
c     output
c
      write(*,*) (geod_pos(i),i=1,3)
c
      site_pos(1) = 1.0
      site_pos(2) = 1.0
      site_pos(3) = dsqrt(2.0d0)
c
      call xyz2pol(site_pos, site_pol)

      time_JD = 2455137.5936773727
      time_JD = 2454679.4999991320 
      ntarg = 11
      ncent = 3
      write(*,*) 'a'
      call planet_state(time_JD,ntarg,ncent,sun_state_icrs)

      write(*,*) 'sun_state_icrs', sun_state_icrs(1), 
     &                             sun_state_icrs(2), sun_state_icrs(3)
c
      write(*,*) (site_pol(i),i=1,3)

      end
