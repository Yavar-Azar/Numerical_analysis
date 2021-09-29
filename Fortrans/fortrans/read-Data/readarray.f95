program read
implicit none
character test
real X(4,3)
integer N,M,stat

open (unit=1, file='test', status='old', iostat=stat)

read (1,*) ((X(N,M), M=1,3), N=1,4)

write(*,*) X(2,3), X(4,1)

end program 
