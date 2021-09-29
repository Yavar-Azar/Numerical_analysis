!this program reads structure file from xy format input and change it

program rotateystruct
implicit none


!Declare variables
character(len=20)::struct,rotated
character(len=20),dimension(:),allocatable::element
real,dimension(:,:),allocatable::posit
integer i,j,k,nat,stat
real alpha,a,b

!reading struct file

write(*,*) 'name of struct file'
read(*,*) struct

write(*,*) 'name of output file'
read(*,*) rotated

write(*,*) 'enter alpha in degree'

write(*,*) 'alpha='
read(*,*) alpha
alpha=alpha*3.14159265/180
a=cos(alpha)
b=sin(alpha) 
write(*,*) 'a=',a
write(*,*) 'b=',b

open(unit=1, file=struct, status='old', iostat=stat)

read(1,*) nat
	allocate(element(nat))
	allocate(posit(nat,3))
	
	do i=1,nat
		read(1,*) element(i), posit(i,1), posit(i,2), posit(i,3)
	end do
	
open(unit=2, file=rotated, status='new')
	write(2,*) nat
	write(2,*)
	do j=1,nat
		write(2,*) element(j),a*posit(j,1)+b*posit(j,3),posit(j,2),b*posit(j,1)-a*posit(j,3)
	end do
end program
