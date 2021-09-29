!this program convulate
program conv
implicit none


!Declare variables
character(len=20)::fdata,convfile
real*8,dimension(:,:),allocatable::data1,convmat
integer i,j,k,nstate,stat,ngrid
real*8 a,delta,x,y,fw,const
const=2.174*(10**8)
!reading struct file

write(*,*) 'name of data file'
read(*,*) fdata

write(*,*) 'name of output file'
read(*,*) convfile
write(*,*) 'nstate='
read(*,*) nstate

write(*,*) 'fw='
read(*,*) fw
write(*,*) 'number of grid='
read(*,*) ngrid
	allocate(data1(nstate,3))
	allocate(convmat(ngrid,3))
	convmat=0
	delta=0.001
	write(*,*) delta
open(unit=1, file=fdata, status='old', iostat=stat)
	do i=1,nstate
		read(1,*) data1(i,1), data1(i,2)
			do j=1,ngrid
				x=j*delta
				data1(i,3)=(data1(i,1))*0.00012398
				convmat(j,1)=x
				convmat(j,2)=convmat(j,2)+(10**8)*((data1(i,2)/fw)*exp(-2.773*(((x-data1(i,3))**2)/(fw**2))))
			end do
	end do
	
open(unit=2, file=convfile, status='new')
	do j=1,ngrid
		write(2,*) convmat(j,1), convmat(j,2)
	end do
end program
