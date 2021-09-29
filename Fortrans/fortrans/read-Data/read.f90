!This program reads some data files and .....................................
!13 june 2012
!By Yavar Taghipour Azar


program read
implicit none
character(len=20),dimension(:),allocatable::fname
real ,dimension(:,:) ,allocatable::x,y,z
integer i,j,stat,filenum,r




!determine number of files and rows of data
write(*,*) 'please enter number of files which you want to open'  
write(*,*) 'number of files ='
read(*,*) filenum
0write(*,*) '_________________________________________________________________________________________'


write(*,*) 'please enter number of rows'
write(*,*) 'number of rows ='
read(*,*) r
write(*,*) '_________________________________________________________________________________________'
!.....................................................................................................


	


! determine dimension of arrays
allocate(fname(filenum))
allocate(x(filenum,r))
allocate(y(filenum,r))
allocate(z(filenum,r))



!Reading name offiles 
do j=1,filenum
write(*,*) 'please enter your',j,'th  filename'
read(*,*) fname(j)
end do


do j=1,filenum
	open (unit=j,file=fname(j), status='old', iostat=stat)
	read(j,*)
		do i=1,r
		read(j,*) x(j,i),y(j,i),z(j,i)
		end do
	close(j)
end do

write(*,*)  x(1,3),z(2,4),z(1,4)

end program 
