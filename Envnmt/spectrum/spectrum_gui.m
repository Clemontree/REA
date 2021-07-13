function varargout = spectrum_gui(varargin)
% usage: spectrum_gui(data,Fs,NFFT,overlap,Window,detrend,#composites, name)
% see gui for available options
% parameter changes within the gui do not affect output variable!

% SPECTRUM_GUI M-file for spectrum_gui.fig
%      SPECTRUM_GUI, by itself, creates a new SPECTRUM_GUI or raises the existing
%      singleton*.
%
%      H = SPECTRUM_GUI returns the handle to a new SPECTRUM_GUI or the handle to
%      the existing singleton*.
%
%      All inputs are passed to spectrum_gui_OpeningFcn via varargin.
%

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @spectrum_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @spectrum_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before spectrum_gui is made visible.
function spectrum_gui_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to spectrum_gui (see VARARGIN)
handles.data=varargin{1};
if size(handles.data,1)<size(handles.data,2)
    handles.data=handles.data';
end
if size(handles.data,2)>4
    disp('Only 1 to 4 input columns supported...');
    return
end
if ~isempty(find(isnan(handles.data)))
    disp('nan are not allowed in input data...');
    return
end
handles.Spec=spectrum.welch;
b=nextpow2(length(handles.data));
if length(handles.data)<(2^b)
    b=b-1;
end
for i=1:10
    a(i)={num2str(2^(b-i+1))};
end
set(handles.popupmenu1_NFFT,'string',a);
handles.line(1)=line('Parent',handles.axes1,'XData',[],'YData',[],'Color','k','LineWidth',1);
handles.line_cl(1)=line('Parent',handles.axes1,'XData',[],'YData',[],'Color','k','LineWidth',0.5,'LineStyle','--');
handles.line_cu(1)=line('Parent',handles.axes1,'XData',[],'YData',[],'Color','k','LineWidth',0.5,'LineStyle','--');
if size(handles.data,2)>1
    handles.line(2)=line('Parent',handles.axes1,'XData',[],'YData',[],'Color','b','LineWidth',1);
    handles.line_cl(2)=line('Parent',handles.axes1,'XData',[],'YData',[],'Color','b','LineWidth',0.5,'LineStyle','--');
    handles.line_cu(2)=line('Parent',handles.axes1,'XData',[],'YData',[],'Color','b','LineWidth',0.5,'LineStyle','--');
end 
if size(handles.data,2)>2
    handles.line(3)=line('Parent',handles.axes1,'XData',[],'YData',[],'Color','r','LineWidth',1);
    handles.line_cl(3)=line('Parent',handles.axes1,'XData',[],'YData',[],'Color','r','LineWidth',0.5,'LineStyle','--');
    handles.line_cu(3)=line('Parent',handles.axes1,'XData',[],'YData',[],'Color','r','LineWidth',0.5,'LineStyle','--');
end
if size(handles.data,2)>3
    handles.line(4)=line('Parent',handles.axes1,'XData',[],'YData',[],'Color','g','LineWidth',1);
    handles.line_cl(4)=line('Parent',handles.axes1,'XData',[],'YData',[],'Color','g','LineWidth',0.5,'LineStyle','--');
    handles.line_cu(4)=line('Parent',handles.axes1,'XData',[],'YData',[],'Color','g','LineWidth',0.5,'LineStyle','--');
end
if nargin>4, set(handles.edit1_Fs,'String',num2str(varargin{2})); end
if nargin>5, set(handles.popupmenu1_NFFT,'Value',max([find(strcmpi(get(handles.popupmenu1_NFFT,'String'),num2str(varargin{3}))) 1])); end
if nargin>6, set(handles.popupmenu2_overlap,'Value',max([find(strcmpi(get(handles.popupmenu2_overlap,'String'),num2str(varargin{4}))) 1])); end
if nargin>7, set(handles.popupmenu3_window,'Value',max([find(strcmpi(get(handles.popupmenu3_window,'String'),varargin{5})) 1])); end
if nargin>8, set(handles.popupmenu4_detrend,'Value',max([find(strcmpi(get(handles.popupmenu4_detrend,'String'),varargin{6})) 1])); end
if nargin>9, set(handles.popupmenu_comp,'Value',max([find(strcmpi(get(handles.popupmenu_comp,'String'),num2str(varargin{7}))) 1])); end
if nargin>11, set(handles.popupmenu6_display,'Value',max([find(strcmpi(get(handles.popupmenu6_display,'String'),num2str(varargin{9}))) 1])); end

handles=Recalc(hObject,handles);

% Update handles structure
guidata(hObject, handles);
if nargin>10
set(gcf,'name',varargin{8},'numbertitle','off');
end


% --- Outputs from this function are returned to the command line.
function varargout = spectrum_gui_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.PSD;

% --- Executes on selection change in popupmenu1_NFFT.
function popupmenu1_NFFT_Callback(hObject, ~, handles)
% handles    structure with handles and user data (see GUIDATA)
Recalc(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu1_NFFT_CreateFcn(hObject, ~, ~)
% handles    empty - handles not created until after all CreateFcns called
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on selection change in popupmenu2_overlap.
function popupmenu2_overlap_Callback(hObject, ~, handles)
% handles    structure with handles and user data (see GUIDATA)
over=get(handles.popupmenu2_overlap,'String'); over=str2num(over{get(handles.popupmenu2_overlap,'Value')});
set(handles.Spec,'OverlapPercent',over);
Recalc(hObject,handles);


% --- Executes during object creation, after setting all properties.
function popupmenu2_overlap_CreateFcn(hObject, ~, ~)
% handles    empty - handles not created until after all CreateFcns called
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in popupmenu3_window.
function popupmenu3_window_Callback(hObject, ~, handles)
% handles    structure with handles and user data (see GUIDATA)
win=get(handles.popupmenu3_window,'String'); win=win{get(handles.popupmenu3_window,'Value')};
set(handles.Spec,'WindowName',win);
Recalc(hObject,handles);


% --- Executes during object creation, after setting all properties.
function popupmenu3_window_CreateFcn(hObject, ~, ~)
% handles    empty - handles not created until after all CreateFcns called
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit1_Fs_Callback(hObject, ~, handles)
% handles    structure with handles and user data (see GUIDATA)
Recalc(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit1_Fs_CreateFcn(hObject, ~, ~)
% handles    empty - handles not created until after all CreateFcns called
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in popupmenu4_detrend.
function popupmenu4_detrend_Callback(hObject, ~, handles)
% handles    structure with handles and user data (see GUIDATA)
Recalc(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu4_detrend_CreateFcn(hObject, ~, ~)
% handles    empty - handles not created until after all CreateFcns called
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on selection change in popupmenu6_display.
function popupmenu6_display_Callback(hObject, ~, handles)
% handles    structure with handles and user data (see GUIDATA)
Recalc(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu6_display_CreateFcn(hObject, ~, ~)
% handles    empty - handles not created until after all CreateFcns called
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on button press in checkbox1_conf.
function checkbox1_conf_Callback(hObject, ~, handles)
% handles    structure with handles and user data (see GUIDATA)
Recalc(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_comp_CreateFcn(hObject, ~, ~)
% hObject    handle to popupmenu_comp (see GCBO)
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton_export.
function pushbutton_export_Callback(~, ~, handles)
% handles    structure with handles and user data (see GUIDATA)
assignin('base', 'spectrum',handles.PSD);

% --- Executes on selection change in popupmenu_comp.
function popupmenu_comp_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_comp (see GCBO)
% handles    structure with handles and user data (see GUIDATA)
Recalc(hObject,handles);


% --------------------------------------------------------------------
function handles1=Recalc(hObject,handles)
% handles    structure with handles and user data (see GUIDATA)
NFFT=get(handles.popupmenu1_NFFT,'String'); NFFT=str2num(NFFT{get(handles.popupmenu1_NFFT,'Value')});
Fs=str2num(get(handles.edit1_Fs,'String'));
set(handles.Spec,'SegmentLength',NFFT);
if isfield(handles,'PSD')
    handles=rmfield(handles,'PSD');
end
for i=1:size(handles.data,2)
    if get(handles.popupmenu4_detrend,'Value')==1
        data(:,i)=handles.data(:,i);
    elseif get(handles.popupmenu4_detrend,'Value')==2
        data(:,i)=detrend(handles.data(:,i),'constant');
    else
        data(:,i)=detrend(handles.data(:,i),'linear');
    end
    com=(get(handles.popupmenu_comp, 'Value'));
    if com==1
        handles.PSD(i)=psd(handles.Spec,data(:,i),'Fs',Fs,'NFFT',NFFT,'ConfLevel',0.95);
    else
        PSDc.Frequencies=[]; PSDc.Data=[]; PSDc.ConfInterval=[];
        PSD=psd(handles.Spec,data(:,i),'Fs',Fs,'NFFT',NFFT,'ConfLevel',0.95);
        f=10.^(log10(PSD.Frequencies(2))+(0:com).*log10(PSD.Frequencies(end)/PSD.Frequencies(2))/com);
        for i2=1:com
            clear PSD
            %NFFT2=2^(floor(log2(NFFT)*(1-(i2-1)/com))+3); if NFFT2>NFFT, NFFT2=NFFT; end
            NFFT2=2^(nextpow2(Fs/f(i2))+3); if NFFT2>NFFT, NFFT2=NFFT; end 
            set(handles.Spec,'SegmentLength',NFFT2);
            PSD=psd(handles.Spec,data(:,i),'Fs',Fs,'NFFT',NFFT2,'ConfLevel',0.95);
            i3=find(PSD.Frequencies>=f(i2) & PSD.Frequencies<f(i2+1) & PSD.Frequencies~=0);
            i4=length(PSDc.Frequencies);
            PSDc.Frequencies(i4+1:i4+length(i3),1)=PSD.Frequencies(i3);
            PSDc.Data(i4+1:i4+length(i3),1)=PSD.Data(i3);
            PSDc.ConfInterval(i4+1:i4+length(i3),:)=PSD.ConfInterval(i3,:);
        end
        handles.PSD(i)=PSDc;
        set(handles.Spec,'SegmentLength',NFFT);
    end
    switch get(handles.popupmenu6_display,'Value')
        case 1
            set(handles.line(i),'XData',1:length(handles.data(:,i)),'YData',handles.data(:,i));
            set(handles.line_cl(i),'XData',[],'YData',[]);
            set(handles.line_cu(i),'XData',[],'YData',[]);
            set(handles.axes1,'XScale','linear','YScale','linear');
        case 2
            if get(handles.popupmenu4_detrend,'Value')==1
                data(:,i)=handles.data(:,i);
            elseif get(handles.popupmenu4_detrend,'Value')==2
                data(:,i)=detrend(handles.data(:,i),'constant');
            else
                data(:,i)=detrend(handles.data(:,i),'linear');
            end
            set(handles.line(i),'XData',1:length(handles.data(:,i)),'YData',data(:,i));
            set(handles.line_cl(i),'XData',[],'YData',[]);
            set(handles.line_cu(i),'XData',[],'YData',[]);
            set(handles.axes1,'XScale','linear','YScale','linear');
        case 3
            set(handles.line(i),'XData',handles.PSD(i).Frequencies,'YData',handles.PSD(i).Data);
            if get(handles.checkbox1_conf,'Value')==1
                set(handles.line_cl(i),'XData',handles.PSD(i).Frequencies,'YData',handles.PSD(i).ConfInterval(:,1));
                set(handles.line_cu(i),'XData',handles.PSD(i).Frequencies,'YData',handles.PSD(i).ConfInterval(:,2));
            else
                set(handles.line_cl(i),'XData',[],'YData',[]);
                set(handles.line_cu(i),'XData',[],'YData',[]);
            end
            set(handles.axes1,'XScale','log','YScale','log');
        case 4
            set(handles.line(i),'XData',handles.PSD(i).Frequencies,'YData',handles.PSD(i).Data.*handles.PSD(i).Frequencies);
            if get(handles.checkbox1_conf,'Value')==1
                set(handles.line_cl(i),'XData',handles.PSD(i).Frequencies,'YData',handles.PSD(i).ConfInterval(:,1).*handles.PSD(i).Frequencies);
                set(handles.line_cu(i),'XData',handles.PSD(i).Frequencies,'YData',handles.PSD(i).ConfInterval(:,2).*handles.PSD(i).Frequencies);
            else
                set(handles.line_cl(i),'XData',[],'YData',[]);
                set(handles.line_cu(i),'XData',[],'YData',[]);
            end
            set(handles.axes1,'XScale','log','YScale','linear');
        case 5
            switch get(handles.popupmenu3_window,'Value');
                case 1
                    data(:,i)=bartlett(length(handles.data(:,i)));
                case 2
                    data(:,i)= barthannwin(length(handles.data(:,i)));
                case 3
                    data(:,i)= blackman(length(handles.data(:,i)));
                case 4
                    data(:,i)=blackmanharris(length(handles.data(:,i)));
                case 5
                    data(:,i)=bohmanwin(length(handles.data(:,i)));
                case 6
                    data(:,i)=chebwin(length(handles.data(:,i)));
                case 7
                    data(:,i)=flattopwin(length(handles.data(:,i)));
                case 8
                    data(:,i)=gausswin(length(handles.data(:,i)));
                case 9
                    data(:,i)=hamming(length(handles.data(:,i)));
                case 10
                    data(:,i)=hann(length(handles.data));
                case 11
                    data=kaiser(length(handles.data(:,i)));
                case 12
                    data(:,i)=nuttallwin(length(handles.data(:,i)));
                case 13
                    data(:,i)=parzenwin(length(handles.data(:,i)));
                case 14
                    data(:,i)=rectwin(length(handles.data(:,i)));
                case 15
                    data(:,i)=triang(length(handles.data));
                case 16
                    data=tukeywin(length(handles.data(:,i)));
            end
        set(handles.line(i),'XData',1:length(handles.data(:,i)),'YData',data(:,i));
        set(handles.line_cl(i),'XData',[],'YData',[]);
        set(handles.line_cu(i),'XData',[],'YData',[]);
        set(handles.axes1,'XScale','linear','YScale','linear');
    end
end
guidata(hObject, handles);
handles1=handles;





