!this program reads two column charge data and integrate diff

program chdiff
implicit none


!Declare variables
character(len=20)::data1,newdata
real,dimension(:,:),allocatable::charge
integer i,j,nrow,stat
real  a,b,d,delta,diff,sum1,sum2,sum3,sumdiff,area

!reading struct file

write(*,*) 'data1'
read(*,*) data1

write(*,*) 'name of output file'
read(*,*) newdata

write(*,*) 'nrow='
read(*,*) nrow

write(*,*) 'please enter area a.u.'
read(*,*)  area
b=(0.52917721**3)
d=(0.52917721**2)
a=area*(0.52917721**2)
sum1=0
sum2=0
sum3=0
sumdiff=0
diff=0
allocate(charge(nrow,4))


open(unit=1, file=data1, status='old', iostat=stat)

	do i=1,nrow
		read(1,*)  charge(i,1), charge(i,2), charge(i,3), charge(i,4)
	end do
	delta=(charge(2,1)-charge(1,1))
	write(*,*) 'delta is', delta
open(unit=2, file=newdata, status='new')
        write(2,*) 'all data in angestrom'
	do j=1,nrow
	diff=(charge(j,4)-charge(j,3)-charge(j,2))
	sum1=charge(j,2)*delta+sum1
	sum2=charge(j,3)*delta+sum2
	sum3=charge(j,4)*delta+sum3
	sumdiff=diff*delta+sumdiff
      write(2,*) charge(j,1)*0.52917721, a*charge(j,2)/b, a*charge(j,3)/b, a*charge(j,4)/b, a*diff/b, a*sum1/d,     a*sum2/d, a*sum2/d, a*sumdiff/d
	end do
end program
