!this program reads a file with following format and computes the Lowdin dipole
! nat
!
!element atomic_number x y z Lowdin charge
program rotatezstruct
implicit none


!Declare variables
character(len=20)::struct,output
character(len=20),dimension(:),allocatable::element
real,dimension(:,:),allocatable::posit
integer i,j,k,nat,stat
real a,b,mux,muy,muz,mx,my,mz,qp,qn

!reading struct file

write(*,*) 'name of struct file'
read(*,*) struct

write(*,*) 'name of output file'
read(*,*) output


open(unit=1, file=struct, status='old', iostat=stat)

read(1,*) nat
	allocate(element(nat))
	allocate(posit(nat,5))
	mux=0
	muy=0
	muz=0
	mx=0
	my=0
	mz=0
	do i=1,nat
		read(1,*) element(i), posit(i,1), posit(i,2), posit(i,3), posit(i,4), posit(i,5)
		mx=posit(i,1)*posit(i,2)+mx
		my=posit(i,1)*posit(i,3)+my
		mz=posit(i,1)*posit(i,4)+mz
		mux=posit(i,5)*posit(i,2)+mux
		muy=posit(i,5)*posit(i,3)+muy
		muz=posit(i,5)*posit(i,4)+muz
		qp=posit(i,1)+qp
		qn=
	end do
	
	
	
open(unit=2, file=output, status='new')
	write(2,*) nat
	write(2,*)
	do j=1,nat
		write(2,*) element(j),posit(j,1),a*posit(j,2)-b*posit(j,3),b*posit(j,2)+a*posit(j,3)
	end do
end program
