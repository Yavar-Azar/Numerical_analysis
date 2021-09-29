!this program reads structure file from bulk and makes n*m surface cell


program structgen
implicit none


!Declare variables

character(len=20)::struct,spcell

character(len=20),allocatable::spelement(:),element(:)
real,dimension(:,:),allocatable::supercell,posit

integer i,j,k,l,nat,stat,n,m,s
real u,v,w,p,q,r

!reading struct file

write(*,*) 'name of struct file'
read(*,*) struct

write(*,*) 'name of output file'
read(*,*) spcell

write(*,*) 'enter first vector as u,v,w'

write(*,*) 'u='
read(*,*) u
 
write(*,*) 'v='
read(*,*) v

write(*,*) 'w='
read(*,*) w

write(*,*) 'first vector is =',u,v,w

write(*,*) 'enter second vector as p,q,r'

write(*,*) 'p='
read(*,*) p
 
write(*,*) 'q='
read(*,*) q

write(*,*) 'r='
read(*,*) r

write(*,*) 'second vector is =',p,q,r

write(*,*) 'please enter n,m for n*m supercell'

write(*,*) 'n='
read(*,*) n

write(*,*) 'm='
read(*,*) m


open(unit=1, file=struct, status='old', iostat=stat)

read(1,*) nat
	allocate(element(nat))
	allocate(posit(nat,3))
	
	do i=1,nat
		read(1,*) element(i), posit(i,1), posit(i,2), posit(i,3)
	end do
	
	s=nat*n*m
	allocate(spelement(s))
	allocate(supercell(s,3))


	do i=1,n
		do j=1,nat
			 k=j+nat*(i-1)
			 spelement(k)=element(j)
			 supercell(k,1)=posit(j,1)+(i-1)*u
			 supercell(k,2)=posit(j,2)+(i-1)*v
			 supercell(k,3)=posit(j,3)+(i-1)*w
        	end do
        end do
        
        
        write(*,*) k
        
        
       do i=1,m
		do j=1,k
			 l=j+k*(i-1)
			 spelement(l)=spelement(j)
			 supercell(l,1)=supercell(j,1)+(i-1)*p
			 supercell(l,2)=supercell(j,2)+(i-1)*q
			 supercell(l,3)=supercell(j,3)+(i-1)*r
        	end do
        end do
         
!write supercell to output file	
open(unit=2, file=spcell, status='new')
	write(2,*) nat*n*m      
	write(2,*)
	do j=1,nat*n*m
		write(2,*) spelement(j), supercell(j,1),supercell(j,2), supercell(j,3)
	end do
end program
        
        	
        	
        
        	
        	
	
	
