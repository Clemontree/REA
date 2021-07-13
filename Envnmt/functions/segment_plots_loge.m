function [segFrequency, fig] = segment_plots_loge(Param,ecOgiveOxygen,reaOgiveOxygen)
    % called in REA_depl_processing.m
    % 14/04/2016 from REA_segment_deployment_2bis.m
    % TO DO: plot more ogives together (depl axis rotation, seg axis rotation, + time shift) 
    % 18/04/2019 transformed into procedure to be run after
    % semgent_fluxes_ogives ; variable names simplified: no Depl et Param
    % structure,no_DeplRotation, _SegRotation, _SegRotationTimeShift
    % no (iSegment,:)
    
            
    %segFrequency =
    %[(0:nFrequencyFFT/2)/nFrequencyFFT*Param.SAMPLINGFREQUENCY]';
    %%Desactivated for test by Guilherme, the next command was copied from
    %%main5.m
     segFrequency = (0:Param.NFREQUENCYFFT/2)'/Param.NFREQUENCYFFT*Param.ADVSAMPLINGFREQUENCY;

    %% plot and save segment REA and EC ogives on segment
    % REA for deployment rotation, segment rotation, segment rotation and
    % time shift, EC for deployment rotation and the latter processing
    fig= figure();
 %   subplot(1,3,1)
       semilogx(flipud(segFrequency),reaOgiveOxygen,'b:')
       hold on
       semilogx(flipud(segFrequency),ecOgiveOxygen,'b')
       yline(0,'k--');
     %   title({[location,' on ',datestr(segDate(iSegment),'dd/mm/yy'),' segment ',num2str(iSegment)];...
%         title({    'ogives: REA (..) and EC(-)'; 'O_2'})
    %    legend('REA(w,O_2)','EC(w'',O_2'') no TS','Location','SE')
        xlabel('f(Hz)')
        ylabel('O_2 (µM m^{-2} d^{-1} Hz^{-1})') 
        xlim([Param.ADVSAMPLINGFREQUENCY/Param.NFREQUENCYFFT  Param.ADVSAMPLINGFREQUENCY/2])
%     subplot(1,3,2)
%         semilogx(flipud(segFrequency),reaOgiveHeat_DeplRotation(iSegment,:),'g')
%         hold on
%         semilogx(flipud(segFrequency),reaOgiveHeat_SegRotation(iSegment,:),'k')
%         semilogx(flipud(segFrequency),reaOgiveHeat_SegRotationTimeShift(iSegment,:),'m')
%         semilogx(flipud(segFrequency),ecOgiveHeat_DeplRotation(iSegment,:),'g--')
%         semilogx(flipud(segFrequency),ecOgiveHeat_SegRotation(iSegment,:),'k--')
%         semilogx(flipud(segFrequency),ecOgiveHeat_SegRotationTimeShift(iSegment,:),'m--')
%         title({[num2str(RUNNINGAVERAGEMIN),'-min mean from w'];REABCOEFFICIENTFLAG;'heat'})  % formerly value of b in 2nd line
%     %    legend('REA(w,T)','EC(w'',T'') no TS','Location','SE')
%         xlabel('f(Hz)')
%         ylabel('heat (W m^{-2})')
%         xlim([SAMPLINGFREQUENCY/nFrequencyFFT  SAMPLINGFREQUENCY/2])     
%     subplot(1,3,3)
%        semilogx(flipud(segFrequency),reaOgiveParticle_DeplRotation(iSegment,:),'r')
%         hold on
%         semilogx(flipud(segFrequency),reaOgiveParticle_SegRotation(iSegment,:),'k')
%         semilogx(flipud(segFrequency),reaOgiveParticle_SegRotationTimeShift(iSegment,:),'m')
%         semilogx(flipud(segFrequency),ecOgiveParticle_DeplRotation(iSegment,:),'r--')
%         semilogx(flipud(segFrequency),ecOgiveParticle_SegRotation(iSegment,:),'k--')
%         semilogx(flipud(segFrequency),ecOgiveParticle_SegRotationTimeShift(iSegment,:),'m--')
%         title({'color, black, magenta: depl and seg rot, time shift';'particles'})
%     %    legend('REA(w,C)','EC(w'',C'') no TS','Location','NE')
%         xlabel('f(Hz)')
%         ylabel('particles (g m^{-2} d^{-1})')
%         xlim([SAMPLINGFREQUENCY/nFrequencyFFT  SAMPLINGFREQUENCY/2])     
    % subplot(1,3,1)
    %     semilogx(flipud(fseg),ogive_REA_O2)
    %     hold on
    %     semilogx(flipud(fseg),ogive_O2w,'k--')
    %     title({[location,' on ',datestr(segDate(segment),'dd/mm/yy'),' segment ',num2str(segment)];'ogives: REA: sign(w)'' & X'' (-); EC: w'' & X'' (--)';...
    %          'O_2'})
    % %    legend('REA(w,O_2)','EC(w'',O_2'') no TS','Location','SE')
    %     xlabel('f(Hz)')
    %     ylabel('O_2 (mmol m^{-2} d^{-1})') 
    %     xlim([SAMPLINGFREQUENCY/nFrequencyFFT  SAMPLINGFREQUENCY/2])     
    % subplot(1,3,2)
    %     semilogx(flipud(fseg),ogive_REA_heat,'g')
    %     hold on
    %     semilogx(flipud(fseg),ogive_Tw,'k--')
    %     title({[num2str(RUNNINGAVERAGEMIN),'-min mean from w'];REABCOEFFICIENTFLAG;'heat'})  % formerly value of b in 2nd line
    % %    legend('REA(w,T)','EC(w'',T'') no TS','Location','SE')
    %     xlabel('f(Hz)')
    %     ylabel('heat (W m^{-2})')
    %     xlim([SAMPLINGFREQUENCY/nFrequencyFFT  SAMPLINGFREQUENCY/2])     
    % subplot(1,3,3)
    %     semilogx(flipud(fseg),ogive_REA_C,'r')
    %     hold on
    %     semilogx(flipud(fseg),ogive_Cw,'k--')
    %     title({''': linear detrending';'particles'})
    % %    legend('REA(w,C)','EC(w'',C'') no TS','Location','NE')
    %     xlabel('f(Hz)')
    %     ylabel('particles (g m^{-2} d^{-1})')
    %     xlim([SAMPLINGFREQUENCY/nFrequencyFFT  SAMPLINGFREQUENCY/2])     
    %print('-dpng',[Param.FIGUREDIRECTORY,Depl.location,Depl.date,'_depl',num2str(iDeployment),'_seg',num2str(iSegment),'_',num2str(Param.FLUXRANGEMIN),'min_',num2str(Param.RUNNINGAVERAGEMIN),'min_',Param.REABCOEFFICIENTFLAG,'_ogives'])
    %print([Param.FIGUREDIRECTORY '/' Depl.location,Depl.date],'-dpng','-r0')
    %print([Param.FIGUREDIRECTORY '/' 'ogive' '_' Depl.location '_' Depl.date],'-dpng','-r0')

    %close(fig)

    % HavelP1_20120328_depl2_seg1_30min_1min_bfixed_ogives


    %%  plot and save segment raw data
    % fig=figure;
    % subplot(3,1,1)
    %     plot(Time_seg,segOxygen);
    %     xlim([min(Time_seg) max(Time_seg)])
    %     datetick('x','HH:MM','keeplimits')
    %     ylabel('[O_2] (mmol m^{-3})')
    %     title('microelectrode O_2')
    % subplot(3,1,2)
    %     plot(Time_seg,segTemperature,'g');
    %     xlim([min(Time_seg) max(Time_seg)])
    %     datetick('x','HH:MM','keeplimits')
    %     ylabel('T (Â°C)')
    %     title('thermistor temp.')
    % subplot(3,1,3)
    %     plot(Time_seg,segParticle,'r');
    %     xlim([min(Time_seg) max(Time_seg)])
    %     datetick('x','HH:MM','keeplimits')
    %     ylabel('particles (mg/L)')
    %     title('particles (ADV)')
    % print('-dpng',[FIGUREDIRECTORY,location,date,'_depl',num2str(iDeployment),'_seg',num2str(i),'_',num2str(FLUXRANGEMIN),'min_raw_variables'])
    % close(fig)
end 