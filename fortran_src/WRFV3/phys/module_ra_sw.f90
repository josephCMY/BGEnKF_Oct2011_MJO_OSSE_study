



























MODULE module_ra_sw

      REAL,PRIVATE,SAVE :: CSSCA

CONTAINS


   SUBROUTINE SWRAD(dt,RTHRATEN,GSW,XLAT,XLONG,ALBEDO,            &
                    rho_phy,T3D,QV3D,QC3D,QR3D,                   &
                    QI3D,QS3D,QG3D,P3D,pi3D,dz8w,GMT,             &
                    R,CP,G,JULDAY,                                &
                    XTIME,DECLIN,SOLCON,                          &
                    F_QV,F_QC,F_QR,F_QI,F_QS,F_QG,                &
                    pm2_5_dry,pm2_5_water,pm2_5_dry_ec,           &
                    RADFRQ,ICLOUD,DEGRAD,warm_rain,               &
                    ids,ide, jds,jde, kds,kde,                    & 
                    ims,ime, jms,jme, kms,kme,                    &
                    its,ite, jts,jte, kts,kte,                    &
                    coszen,julian                                 & 
                    )

   IMPLICIT NONE

   INTEGER,    INTENT(IN   ) ::        ids,ide, jds,jde, kds,kde, &
                                       ims,ime, jms,jme, kms,kme, &
                                       its,ite, jts,jte, kts,kte

   LOGICAL,    INTENT(IN   ) ::        warm_rain
   INTEGER,    INTENT(IN   ) ::        icloud

   REAL, INTENT(IN    )      ::        RADFRQ,DEGRAD,             &
                                       XTIME,DECLIN,SOLCON

   REAL, DIMENSION( ims:ime, kms:kme, jms:jme ),                  &
         INTENT(IN    ) ::                                   P3D, &
                                                            pi3D, &
                                                         rho_phy, &
                                                            dz8w, &
                                                             T3D
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme ), OPTIONAL ,       &
         INTENT(IN    ) ::                             pm2_5_dry, &
                                                     pm2_5_water, &
                                                    pm2_5_dry_ec


   REAL, DIMENSION( ims:ime, kms:kme, jms:jme ),                  &
         INTENT(INOUT)  ::                              RTHRATEN

   REAL, DIMENSION( ims:ime, jms:jme ),                           &
         INTENT(IN   )  ::                                  XLAT, &
                                                           XLONG, &
                                                          ALBEDO

   REAL, DIMENSION( ims:ime, jms:jme ),                           &
         INTENT(INOUT)  ::                                   GSW

   REAL, INTENT(IN   )   ::                        GMT,R,CP,G,dt

   INTEGER, INTENT(IN  ) ::                               JULDAY  

   
   REAL, DIMENSION( ims:ime, jms:jme ), OPTIONAL, INTENT(IN) :: COSZEN
   REAL, OPTIONAL, INTENT(IN) :: JULIAN




   REAL, DIMENSION( ims:ime, kms:kme, jms:jme ),                  &
         OPTIONAL,                                                &
         INTENT(IN    ) ::                                        &
                                                            QV3D, &
                                                            QC3D, &
                                                            QR3D, &
                                                            QI3D, &
                                                            QS3D, &
                                                            QG3D

   LOGICAL, OPTIONAL, INTENT(IN )      ::        F_QV,F_QC,F_QR,F_QI,F_QS,F_QG
 

 
   REAL, DIMENSION( kts:kte ) ::                                  &
                                                          TTEN1D, &
                                                          RHO01D, &
                                                             P1D, &
                                                              DZ, &
                                                             T1D, &
                                                            QV1D, &
                                                            QC1D, &
                                                            QR1D, &
                                                            QI1D, &
                                                            QS1D, &
                                                            QG1D

   REAL::      XLAT0,XLONG0,ALB0,GSW0


   INTEGER :: i,j,K,NK
   LOGICAL :: predicate , do_topo_shading
   real :: aer_dry1(kts:kte),aer_water1(kts:kte)



   j_loop: DO J=jts,jte
   i_loop: DO I=its,ite


         DO K=kts,kte
            QV1D(K)=0.
            QC1D(K)=0.
            QR1D(K)=0.
            QI1D(K)=0.
            QS1D(K)=0.
            QG1D(K)=0.
         ENDDO

         DO K=kts,kte
            NK=kme-1-K+kms
            TTEN1D(K)=0.

            T1D(K)=T3D(I,NK,J)
            P1D(K)=P3D(I,NK,J)
            RHO01D(K)=rho_phy(I,NK,J)
            DZ(K)=dz8w(I,NK,J)
         ENDDO

         IF( PRESENT(pm2_5_dry) .AND. PRESENT(pm2_5_water) )THEN
            DO K=kts,kte
               NK=kme-1-K+kms
               aer_dry1(k)   = pm2_5_dry(i,nk,j)
               aer_water1(k) = pm2_5_water(i,nk,j)
            ENDDO
         ELSE
            DO K=kts,kte
               aer_dry1(k)   = 0.
               aer_water1(k) = 0.
            ENDDO
         ENDIF

         IF (PRESENT(F_QV) .AND. PRESENT(QV3D)) THEN
            IF (F_QV) THEN
               DO K=kts,kte
                  NK=kme-1-K+kms
                  QV1D(K)=QV3D(I,NK,J)
                  QV1D(K)=max(0.,QV1D(K))
               ENDDO
            ENDIF
         ENDIF

         IF (PRESENT(F_QC) .AND. PRESENT(QC3D)) THEN
            IF (F_QC) THEN
               DO K=kts,kte
                  NK=kme-1-K+kms
                  QC1D(K)=QC3D(I,NK,J)
                  QC1D(K)=max(0.,QC1D(K))
               ENDDO
            ENDIF
         ENDIF

         IF (PRESENT(F_QR) .AND. PRESENT(QR3D)) THEN
            IF (F_QR) THEN
               DO K=kts,kte
                  NK=kme-1-K+kms
                  QR1D(K)=QR3D(I,NK,J)
                  QR1D(K)=max(0.,QR1D(K))
               ENDDO
            ENDIF
         ENDIF


         IF ( PRESENT( F_QI ) ) THEN
            predicate = F_QI
         ELSE
            predicate = .FALSE.
         ENDIF

         IF ( predicate .AND. PRESENT( QI3D ) ) THEN
            DO K=kts,kte
               NK=kme-1-K+kms
               QI1D(K)=QI3D(I,NK,J)
               QI1D(K)=max(0.,QI1D(K))
            ENDDO
         ELSE
            IF (.not. warm_rain) THEN
               DO K=kts,kte
               IF(T1D(K) .lt. 273.15) THEN
                  QI1D(K)=QC1D(K)
                  QC1D(K)=0.
                  QS1D(K)=QR1D(K)
                  QR1D(K)=0.
               ENDIF
               ENDDO
            ENDIF
         ENDIF

         IF (PRESENT(F_QS) .AND. PRESENT(QS3D)) THEN
            IF (F_QS) THEN
               DO K=kts,kte          
                  NK=kme-1-K+kms
                  QS1D(K)=QS3D(I,NK,J)
                  QS1D(K)=max(0.,QS1D(K))
               ENDDO
            ENDIF
         ENDIF

         IF (PRESENT(F_QG) .AND. PRESENT(QG3D)) THEN
            IF (F_QG) THEN
               DO K=kts,kte          
                  NK=kme-1-K+kms
                  QG1D(K)=QG3D(I,NK,J)
                  QG1D(K)=max(0.,QG1D(K))
               ENDDO
            ENDIF
         ENDIF

         XLAT0=XLAT(I,J)
         XLONG0=XLONG(I,J)
         ALB0=ALBEDO(I,J)

           CALL SWPARA(TTEN1D,GSW0,XLAT0,XLONG0,ALB0,              &
                       T1D,QV1D,QC1D,QR1D,QI1D,QS1D,QG1D,P1D,      &
                       XTIME,GMT,RHO01D,DZ,                        &
                       R,CP,G,DECLIN,SOLCON,                       &
                       RADFRQ,ICLOUD,DEGRAD,aer_dry1,aer_water1,   &
                       kts,kte,                                    &
                       coszen(i,j),julian                          ) 
         GSW(I,J)=GSW0
         DO K=kts,kte          
            NK=kme-1-K+kms
            RTHRATEN(I,K,J)=RTHRATEN(I,K,J)+TTEN1D(NK)/pi3D(I,K,J)
         ENDDO

   ENDDO i_loop
   ENDDO j_loop                                          

   END SUBROUTINE SWRAD


   SUBROUTINE SWPARA(TTEN,GSW,XLAT,XLONG,ALBEDO,               &
                     T,QV,QC,QR,QI,QS,QG,P,                    &
                     XTIME, GMT, RHO0, DZ,                     &
                     R,CP,G,DECLIN,SOLCON,                     &
                     RADFRQ,ICLOUD,DEGRAD,aer_dry1,aer_water1, &
                     kts,kte,coszen,julian,                    &
                     slope_rad,shadow,slp_azi,slope            )









  IMPLICIT NONE

  INTEGER, INTENT(IN ) ::                 kts,kte

  REAL, DIMENSION( kts:kte ), INTENT(IN   )  ::                   &
                                                            RHO0, &
                                                               T, &
                                                               P, &
                                                              DZ, &
                                                              QV, &
                                                              QC, &
                                                              QR, &
                                                              QI, &
                                                              QS, &
                                                              QG

   REAL, DIMENSION( kts:kte ), INTENT(INOUT)::              TTEN

   REAL, INTENT(IN  )   ::               XTIME,GMT,R,CP,G,DECLIN, &
                                        SOLCON,XLAT,XLONG,ALBEDO, &
                                                  RADFRQ, DEGRAD

   REAL, OPTIONAL, INTENT(IN) :: COSZEN, JULIAN 


   INTEGER, INTENT(IN) :: icloud
   REAL, INTENT(INOUT)  ::                                   GSW


   INTEGER, OPTIONAL, INTENT(IN) :: slope_rad,shadow
   REAL, OPTIONAL,    INTENT(IN) :: slp_azi,slope



   REAL, DIMENSION( kts:kte+1 ) ::                         SDOWN

   REAL, DIMENSION( kts:kte )   ::                          XLWP, &
						            XATP, &
						            XWVP, &
                                             aer_dry1,aer_water1, &
						              RO

   REAL, DIMENSION( 4, 5 ) ::                             ALBTAB, &
                                                          ABSTAB

   REAL, DIMENSION( 4    ) ::                             XMUVAL

   REAL :: beta



      DATA ALBTAB/0.,0.,0.,0., &
           69.,58.,40.,15.,    &
           90.,80.,70.,60.,    &
           94.,90.,82.,78.,    &
           96.,92.,85.,80./

      DATA ABSTAB/0.,0.,0.,0., &
           0.,2.5,4.,5.,       &
           0.,2.6,7.,10.,      &
           0.,3.3,10.,14.,     &
           0.,3.7,10.,15./

      DATA XMUVAL/0.,0.2,0.5,1.0/

      REAL :: bext340, absc, alba, alw, csza,dabsa,dsca,dabs
      REAL :: bexth2o, dscld, hrang,ff,oldalb,oldabs,oldabc
      REAL :: soltop, totabs, tloctm, ugcm, uv,xabs,xabsa,wv
      REAL :: wgm, xalb, xi, xsca, xt24,xmu,xabsc,trans0,yj
      REAL :: xxlat,ww
      INTEGER :: iil,ii,jjl,ju,k,iu
      REAL :: da,eot 



   REAL :: diffuse_frac, corr_fac, csza_slp

       GSW=0.0
       bext340=5.E-6
       bexth2o=5.E-6
       SOLTOP=SOLCON
       
       if (present(coszen)) then
          csza=coszen
       else



          xt24 = mod(xtime+radfrq*0.5,1440.)+eot
          tloctm = gmt + xt24/60. + xlong/15.
          hrang = 15. * (tloctm-12.) * degrad
          xxlat = xlat * degrad
          csza = sin(xxlat) * sin(declin) &
               + cos(xxlat) * cos(declin) * cos(hrang)
       end if


      IF(CSZA.LE.1.E-9)GOTO 7

      DO K=kts, kte


         RO(K)=P(K)/(R*T(K))
         XWVP(K)=RO(K)*QV(K)*DZ(K)*1000.

          XATP(K)=RO(K)*DZ(K)
      ENDDO





      IF (ICLOUD.EQ.0)THEN
         DO K=kts, kte
            XLWP(K)=0.
         ENDDO
      ELSE
         DO K=kts, kte
            XLWP(K)=RO(K)*1000.*DZ(K)*(QC(K)+0.1*QI(K)+0.05* &
                    QR(K)+0.02*QS(K)+0.05*QG(K))
         ENDDO
      ENDIF

      XMU=CSZA
      SDOWN(1)=SOLTOP*XMU


      WW=0.
      UV=0.
      OLDALB=0.
      OLDABC=0.
      TOTABS=0.

      DSCA=0.
      DABS=0.
      DSCLD=0.


      DABSA=0.

      DO 200 K=kts,kte
         WW=WW+XLWP(K)
         UV=UV+XWVP(K)


         WGM=WW/XMU
         UGCM=UV*0.0001/XMU

         OLDABS=TOTABS

         TOTABS=2.9*UGCM/((1.+141.5*UGCM)**0.635+5.925*UGCM)



         beta=0.4*(1.0-XMU)+0.1

         XSCA=(cssca*XATP(K)+beta*aer_dry1(K)*bext340*DZ(K) &
              +beta*aer_water1(K)*bexth2o*DZ(K))/XMU   


         XABS=(TOTABS-OLDABS)*(SDOWN(1)-DSCLD-DSCA-DABSA)/SDOWN(K)

         XABSA=0.
         IF(XABS.LT.0.)XABS=0.

         ALW=ALOG10(WGM+1.)
         IF(ALW.GT.3.999)ALW=3.999

         DO II=1,3
            IF(XMU.GT.XMUVAL(II))THEN
              IIL=II
              IU=II+1
              XI=(XMU-XMUVAL(II))/(XMUVAL(II+1)-XMUVAL(II))+FLOAT(IIL)
            ENDIF
         ENDDO

         JJL=IFIX(ALW)+1
         JU=JJL+1
         YJ=ALW+1.

         ALBA=(ALBTAB(IU,JU)*(XI-IIL)*(YJ-JJL)   &
              +ALBTAB(IIL,JU)*(IU-XI)*(YJ-JJL)   &
              +ALBTAB(IU,JJL)*(XI-IIL)*(JU-YJ)   &
              +ALBTAB(IIL,JJL)*(IU-XI)*(JU-YJ))  &
             /((IU-IIL)*(JU-JJL))

         ABSC=(ABSTAB(IU,JU)*(XI-IIL)*(YJ-JJL)   &
              +ABSTAB(IIL,JU)*(IU-XI)*(YJ-JJL)   &
              +ABSTAB(IU,JJL)*(XI-IIL)*(JU-YJ)   &
              +ABSTAB(IIL,JJL)*(IU-XI)*(JU-YJ))  &
             /((IU-IIL)*(JU-JJL))

         XALB=(ALBA-OLDALB)*(SDOWN(1)-DSCA-DABS)/SDOWN(K)
         XABSC=(ABSC-OLDABC)*(SDOWN(1)-DSCA-DABS)/SDOWN(K)
         IF(XALB.LT.0.)XALB=0.
         IF(XABSC.LT.0.)XABSC=0.
         DSCLD=DSCLD+(XALB+XABSC)*SDOWN(K)*0.01
         DSCA=DSCA+XSCA*SDOWN(K)
         DABS=DABS+XABS*SDOWN(K)
         DABSA=DABSA+XABSA*SDOWN(K)
         OLDALB=ALBA
         OLDABC=ABSC

         TRANS0=100.-XALB-XABSC-XABS*100.-XSCA*100.
         IF(TRANS0.LT.1.)THEN
           FF=99./(XALB+XABSC+XABS*100.+XSCA*100.)
           XALB=XALB*FF
           XABSC=XABSC*FF
           XABS=XABS*FF
           XSCA=XSCA*FF
           TRANS0=1.
         ENDIF
         SDOWN(K+1)=AMAX1(1.E-9,SDOWN(K)*TRANS0*0.01)
         TTEN(K)=SDOWN(K)*(XABSC+XABS*100.+XABSA*100.)*0.01/( &
                 RO(K)*CP*DZ(K))
  200   CONTINUE

        GSW=(1.-ALBEDO)*SDOWN(kte+1)

    IF (PRESENT(slope_rad)) THEN


      if (slope_rad.eq.1) then



        diffuse_frac = min(1.,1/(max(0.1,2.1-2.8*log(log(SDOWN(kts)/max(SDOWN(kte+1),1.e-3))))))
        if ((slope.eq.0).or.(diffuse_frac.eq.1).or.(csza.lt.1.e-2)) then  
        corr_fac = 1
        goto 140
        endif



        csza_slp = ((SIN(XXLAT)*COS(HRANG))*                                          &
                    (-cos(slp_azi)*sin(slope))-SIN(HRANG)*(sin(slp_azi)*sin(slope))+  &
                    (COS(XXLAT)*COS(HRANG))*cos(slope))*                              &
                   COS(DECLIN)+(COS(XXLAT)*(cos(slp_azi)*sin(slope))+                 &
                   SIN(XXLAT)*cos(slope))*SIN(DECLIN)
        IF(csza_slp.LE.1.E-4) csza_slp = 0



        if (shadow.eq.1) csza_slp = 0


        corr_fac = diffuse_frac + (1-diffuse_frac)*csza_slp/csza

 140	continue   

        GSW=(1.-ALBEDO)*SDOWN(kte+1)*corr_fac 
        
      endif
    ENDIF

    7 CONTINUE

   END SUBROUTINE SWPARA


   SUBROUTINE swinit(swrad_scat,                                    &
                     allowed_to_read ,                              &
                     ids, ide, jds, jde, kds, kde,                  &
                     ims, ime, jms, jme, kms, kme,                  &
                     its, ite, jts, jte, kts, kte                   )

   IMPLICIT NONE

   LOGICAL , INTENT(IN)           :: allowed_to_read 
   INTEGER , INTENT(IN)           :: ids, ide, jds, jde, kds, kde,  &
                                     ims, ime, jms, jme, kms, kme,  &
                                     its, ite, jts, jte, kts, kte

   REAL , INTENT(IN)              :: swrad_scat


   cssca = swrad_scat * 1.e-5

   END SUBROUTINE swinit

END MODULE module_ra_sw
