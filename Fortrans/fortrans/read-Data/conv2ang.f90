!this program reads structure file

program shiftstruct
implicit none


!Declare variables
character(len=20)::struct,convted
character(len=20),dimension(:),allocatable::element
real,dimension(:,:),allocatable::posit
integer i,j,k,nat,stat
real u,v,w

!reading struct file

write(*,*) 'name of struct file'
read(*,*) struct

write(*,*) 'name of output file'
read(*,*) convted


open(unit=1, file=struct, status='old', iostat=stat)

read(1,*) nat
	allocate(element(nat))
	allocate(posit(nat,3))
	
	do i=1,nat
		read(1,*) element(i), posit(i,1), posit(i,2), posit(i,3)
	end do
	
open(unit=2, file=convted, status='new')
	write(2,*) nat
	write(2,*)
	do j=1,nat
		write(2,*) element(j), 0.52917*(posit(j,1)), 0.52917*(posit(j,2)), 0.52917*(posit(j,3))
	end do
end program
