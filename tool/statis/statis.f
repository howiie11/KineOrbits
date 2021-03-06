*
*  program statis
*   
      program statis
*************************************************************************
*
*  Function
*  ========
*
*  calculate the statis information for a given colum data, including
*  the minimal/maximal/mean/std of the data
*
*
*  Notes
*  =====
*
*  Input data file name must be 'zz', or else, the program will stop
*  with error 'not matched file name'
*
*
*  History
*  =======
*
*  Codey by shjzhang 2007/10/20
*
*
*************************************************************************
c
      implicit none
c
      integer       MAX_REC
      parameter(    MAX_REC=100000)
c
      integer       i, j, k, ios
      integer       irec
      integer       nrec
c
      real*8        datas(MAX_REC)
      real*8        mini, maxi, mean, std
c
      character*100 data_file
c
      data_file ='zz'
c
      do i=1, MAX_REC
        datas(i) = 0.0d0
      enddo
c
      open(unit=101, file=data_file, status='old', iostat=ios)
c
      if(ios.ne.0)then
        write(*,*) 'open file error'
        stop
      endif 
c
      irec =1
100   continue
c
      read(101, *, end=200) datas(irec)
c
      irec = irec + 1
c
      goto 100
c
200   continue
c
      nrec = irec - 1
c
c     Calculate statiss
c
      mini = 9999.0d0
c
c     minimal
c   
      do irec=1, nrec
        if(datas(irec).lt.mini)then
          mini = datas(irec)
        endif
      enddo
c
      maxi = -9999.0d0
c
c     maximal
c   
      do irec=1, nrec
        if(datas(irec).gt.maxi)then
          maxi = datas(irec)
        endif
      enddo
c
c     mean
c
      mean = 0.0d0
c
      do irec=1, nrec
        mean = mean + datas(irec)
      enddo
      mean = mean/dble(nrec)
c
c     Standard deviation
c
      std = 0.0d0
c
      do irec=1, nrec
        std = std + (datas(irec) - mean)**2
      enddo
c
      std = dsqrt(std/dble((nrec-1)))
c
      write(*,'(4A8)')  "MINI","MAXI","MEAN","STD"
      write(*,'(4f8.3)') mini,  maxi,  mean,  std
c
      end

