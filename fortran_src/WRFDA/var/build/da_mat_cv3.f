












module da_mat_cv3

contains

      SUBROUTINE ZERM(A,MI,MJ,NA) 
      INTEGER MI, MJ, NA
      DIMENSION A(NA,*)
      DO J=1,MJ
       CALL ZERV(A(1,J),MI)
      ENDDO
      RETURN
      END SUBROUTINE ZERM

      SUBROUTINE ZERV(D,M)    
      INTEGER M, I
      DIMENSION D(M)
      DO I=1,M
       D(I)=0.
      ENDDO
      RETURN
      END SUBROUTINE ZERV

      SUBROUTINE MULMV(A,D,E,MI,MJ,NA)
      INTEGER MI, MJ, NA, J
      DIMENSION A(NA,*),D(*),E(*)
      CALL ZERV(E,MJ)
      DO J=1,MJ
       CALL MADVS(A(1,J),D(J),E,MI)
      ENDDO
      RETURN
      END SUBROUTINE MULMV

      SUBROUTINE MADVS(D,S,E,M)
      INTEGER M, I
      DIMENSION D(*),E(*)
      DO I=1,M
       E(I)=E(I)+D(I)*S
      ENDDO
      RETURN
      END SUBROUTINE MADVS

     subroutine LINMM(a,b,m,mm,na,nb)
      DIMENSION A(NA,*),B(NB,*),ipiv(m)
      CALL LDUM(A,IPIV,D,M,NA)
      CALL UDLMM(A,B,IPIV,M,MM,NA,NB)
      RETURN
      END subroutine LINMM



















      SUBROUTINE LDUM(A,IPIV,D,M,NA)
      PARAMETER(NN=500)
      DIMENSION A(NA,*),IPIV(*),S(NN)

      IF(M.GT.NN)STOP
      DO I=1,M
       AAM=0.
       DO J=1,M
	AA=ABS(A(I,J))
	IF(AA.GT.AAM)AAM=AA
       ENDDO
       IF(AAM.EQ.0.)THEN
	PRINT'('' ROW '',I3,'' OF MATRIX IN LUFM VANISHES'')',I
	STOP
       ENDIF
       S(I)=1./AAM
      ENDDO
      D=1.
      IPIV(M)=M
      DO J=1,M-1
       JP=J+1
       ABIG=S(J)*ABS(A(J,J))
       IBIG=J
       DO I=JP,M
	AA=S(I)*ABS(A(I,J))
	IF(AA.GT.ABIG)THEN
	 IBIG=I
	 ABIG=AA
	ENDIF
       ENDDO

       IPIV(J)=IBIG
       IF(IBIG.NE.J)THEN
	D=-D
	DO K=1,M
	 T=A(J,K)
	 A(J,K)=A(IBIG,K)
	 A(IBIG,K)=T
	ENDDO
	S(IBIG)=S(J)
       ENDIF
       AJJ=A(J,J)
       IF(AJJ.EQ.0.)THEN
			   JM=J-1
  PRINT'('' FAILURE IN LDUM:''/'' MATRIX SINGULAR, RANK='',i3)',JM
			   STOP
       ENDIF
       AJJI=1./AJJ
       DO I=JP,M
	AIJ=AJJI*A(I,J)
	A(I,J)=AIJ
	DO K=JP,M
	 A(I,K)=A(I,K)-AIJ*A(J,K)
	ENDDO
       ENDDO
      ENDDO
      RETURN
      END SUBROUTINE LDUM
















      SUBROUTINE UDLMM(A,B,IPIV,M,MM,NA,NB)
      DIMENSION A(NA,*),B(NB,*),IPIV(*)
      DO K=1,MM 
       DO I=1,M
	L=IPIV(I)
	S=B(L,K)
	B(L,K)=B(I,K)
	CALL DSBVR(B(1,K),A(I,1),S,I-1,NA)
	B(I,K)=S
       ENDDO
       B(M,K)=B(M,K)/A(M,M)
       DO I=M-1,1,-1
	AIII=1./A(I,I)
	CALL DSBVR(B(I+1,K),A(I,I+1),B(I,K),M-I,NA)
	B(I,K)=B(I,K)*AIII
       ENDDO
      ENDDO
      RETURN
      END SUBROUTINE UDLMM

      subroutine DSBVR(D,A,S,M,NA)
      DIMENSION D(M),A(NA,*)
      DO I=1,M
       S=S-D(I)*A(1,I)
      ENDDO
      RETURN
      END subroutine DSBVR


end module da_mat_cv3
