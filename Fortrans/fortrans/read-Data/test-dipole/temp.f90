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
real a,b,mux,muy,muz,mx,my,mz,qp,qn,rx,ry,rz,r

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
	qp=0
	qn=0
	do i=1,nat
		read(1,*) element(i), posit(i,1), posit(i,2), posit(i,3), posit(i,4), posit(i,5)
		mx=posit(i,1)*posit(i,2)+mx
		my=posit(i,1)*posit(i,3)+my
		mz=posit(i,1)*posit(i,4)+mz
		mux=(-posit(i,1)+posit(i,5))*posit(i,2)+mux
		muy=(-posit(i,1)+posit(i,5))*posit(i,3)+muy
		muz=(-posit(i,1)+posit(i,5))*posit(i,4)+muz
		qp=posit(i,1)+qp
		qn=(-posit(i,1)+posit(i,5))+qn
		end do
	
	mux=mux/qn
	muy=muy/qn
	muz=muz/qn
	mx=mx/qp
	my=my/qp
	mz=mz/qp
	
	rx=mx-mux
	ry=my-muy
	rz=mz-muz
	
	!  atomic unit  and to Debye
	
	r=1.88972*2.5417*sqrt((rx**2)+(ry**2)+(rz**2))
	
	write(*,*) 'summation  of atomic numbers = ' , qp
	write(*,*) 'summation  of Lowdin charges = ' , qn
	
	write(*,*) 'dipole center is =',  (mx+mux)/2 ,(my+muy)/2, (mz+muz)/2
	
	write(*,*) 'dipole components and srength is = ', qp*rx, qp*ry, qp*rz, r*qp
	
open(unit=2, file=output, status='new')
	write(2,*) 'summation  of atomic numbers = ' , qp
	write(2,*) 'summation  of Lowdin charges = ' , qn
	
	write(2,*) 'dipole center is =',  (mx+mux)/2 ,(my+muy)/2, (mz+muz)/2
	
	write(2,*) 'dipole components and srength is = ', qp*rx, qp*ry, qp*rz, r*qp
end program
