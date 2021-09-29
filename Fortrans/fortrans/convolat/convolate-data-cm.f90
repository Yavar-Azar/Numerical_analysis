!	Yavar Taghipour Azar   30 june 2013
!	This program convolute oscillator strength to give extiction coefficient -
!	 output format is colm(1)=wavelength in eV, colm(2)=wavelength in nm, colm(3)=extinction in M^-1.cm^-1
program conv
implicit none


!Declare variables
character(len=20)::fdata,convfile
real*8,dimension(:,:),allocatable::data1,convmat
integer i,j,k,nstate,stat,ngrid
real*8 a,delta,x,fw,const,y
! the constant in main equation is 2.175*10**8--for unit conversion of fwhm from eV to cm-1 we change it as follows
const=2.6996*(10**4)
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
	allocate(data1(nstate,2))
	allocate(convmat(ngrid,3))
	convmat=0
	delta=0.005
	write(*,*) delta
open(unit=1, file=fdata, status='old', iostat=stat)
	do i=1,nstate
		read(1,*) data1(i,1), data1(i,2)
			do j=1,ngrid
				x=j*delta
				y=0.00012398*data1(i,1)
				convmat(j,1)=x
				convmat(j,2)=convmat(j,2)+const*((data1(i,2)/fw)*exp(-2.773*(((x-y)**2)/(fw**2))))
			end do
	end do
	
open(unit=2, file=convfile, status='new')
	do j=1,ngrid
		write(2,*) convmat(j,1),1239.84/convmat(j,1), convmat(j,2)
	end do
end program
