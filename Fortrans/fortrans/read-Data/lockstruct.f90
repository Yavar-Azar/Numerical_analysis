!this program reads structure file from xy format input and change it

program shiftstruct
implicit none


!Declare variables
character(len=20)::struct,shifted
character(len=20),dimension(:),allocatable::element
real,dimension(:,:),allocatable::posit
integer i,j,k,nat,stat

!reading struct file

write(*,*) 'name of struct file'
read(*,*) struct

write(*,*) 'name of output file'
read(*,*) shifted



open(unit=1, file=struct, status='old', iostat=stat)

read(1,*) nat
	allocate(element(nat))
	allocate(posit(nat,3))
	
	do i=1,nat
		read(1,*) element(i), posit(i,1), posit(i,2), posit(i,3)
	end do
	
open(unit=2, file=shifted, status='new')
	write(2,*) nat
	write(2,*)
	do j=1,nat
		write(2,*) element(j), posit(j,1), posit(j,2), posit(j,3), 0, 0, 0
	end do
end program
