!this program convulate
program conv
implicit none


!Declare variables
character(len=20)::fdata,dataout
real,dimension(:,:),allocatable::data1,convmat
integer i,j,k,nstate,ngrid,stat
real a,delta,fw,const=2.174*(10**8)

!reading struct file

write(*,*) 'name of data file'
read(*,*) fdata

write(*,*) 'name of output file'
read(*,*) convfile
write(*,*) 'nstate='
read(*,*) nstates

write(*,*) 'fw='
read(*,*) fw
write(*,*) 'number of grid='
read(*,*) ngrid
	allocate(data1(nstate,2))
	allocate(convmat(ngrid,3))
	
	delta=5/ngrid
	write(*,*) delta
open(unit=1, file=fdata, status='old', iostat=stat)
	do i=1,nstate
		read(1,*) data1(i,1), data1(i,2)
			do j=1,ngrid
				x=j*delta
				convmat(j,1)=x
				convmat(j,2)=convmat(j,2)+((data1(i,2)/fw)*exp(-2.773*(((x-data1(i,1))**2)/(fw**2))))
			end do
	
open(unit=2, file=convfile, status='new')
	do j=1,ngrid
		write(2,*) convmat(j,1), convmat(j,2)
	end do
end program
