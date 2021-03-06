!CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
!                                                                       
!   FFTPACK 5.0                                                         
!   Copyright (C) 1995-2004, Scientific Computing Division,             
!   University Corporation for Atmospheric Research                     
!   Licensed under the GNU General Public License (GPL)                 
!                                                                       
!   Authors:  Paul N. Swarztrauber and Richard A. Valent                
!                                                                       
!   $Id: sint1i.f,v 1.2 2004/06/15 21:29:20 rodney Exp $                
!                                                                       
!CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
                                                                        
      SUBROUTINE SINT1I (N, WSAVE, LENSAV, IER) 
      INTEGER    N, LENSAV, IER 
      REAL       WSAVE(LENSAV) 
!                                                                       
      IER = 0 
!                                                                       
      IF (LENSAV .LT. N/2 + N + INT(LOG(REAL(N))) +4) THEN 
        IER = 2 
        CALL XERFFT ('SINT1I', 3) 
        GO TO 300 
      ENDIF 
!                                                                       
      PI = 4.*ATAN(1.) 
      IF (N .LE. 1) RETURN 
      NS2 = N/2 
      NP1 = N+1 
      DT = PI/FLOAT(NP1) 
      DO 101 K=1,NS2 
         WSAVE(K) = 2.*SIN(K*DT) 
  101 END DO 
      LNSV = NP1 + INT(LOG(REAL(NP1))) +4 
      CALL RFFT1I (NP1, WSAVE(NS2+1), LNSV, IER1) 
      IF (IER1 .NE. 0) THEN 
        IER = 20 
        CALL XERFFT ('SINT1I',-5) 
      ENDIF 
!                                                                       
  300 CONTINUE 
      RETURN 
      END                                           
