classdef RoomAcoustic_main_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        HomeTab                         matlab.ui.container.Tab
        Hyperlink                       matlab.ui.control.Hyperlink
        InstructionsPanel               matlab.ui.container.Panel
        ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel_2  matlab.ui.control.Label
        SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3  matlab.ui.control.Label
        SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2  matlab.ui.control.Label
        SetdesiredsizeofenviornemntinConfigurepanelandclickLabel  matlab.ui.control.Label
        DirectionsLabel                 matlab.ui.control.Label
        ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel  matlab.ui.control.Label
        WelcomePanel                    matlab.ui.container.Panel
        RoomAcousticSimulatorLabel      matlab.ui.control.Label
        Image                           matlab.ui.control.Image
        ConfigureTab                    matlab.ui.container.Tab
        ResetButton_2                   matlab.ui.control.Button
        SimulateButton                  matlab.ui.control.Button
        SourceRecieverCoordinatesPanel  matlab.ui.container.Panel
        recYSpinner                     matlab.ui.control.Spinner
        YmLabel_2                       matlab.ui.control.Label
        recZSpinner                     matlab.ui.control.Spinner
        ZmLabel_2                       matlab.ui.control.Label
        recXSpinner                     matlab.ui.control.Spinner
        XmLabel_2                       matlab.ui.control.Label
        sourceZSpinner                  matlab.ui.control.Spinner
        ZmLabel                         matlab.ui.control.Label
        sourceYSpinner                  matlab.ui.control.Spinner
        YmLabel                         matlab.ui.control.Label
        sourceXSpinner                  matlab.ui.control.Spinner
        XmLabel                         matlab.ui.control.Label
        RecieveroLabel                  matlab.ui.control.Label
        SourcexLabel                    matlab.ui.control.Label
        RoomSizeParametersPanel         matlab.ui.container.Panel
        HeightmSlider                   matlab.ui.control.Slider
        HeightmSliderLabel              matlab.ui.control.Label
        DepthmSlider                    matlab.ui.control.Slider
        DepthmSliderLabel               matlab.ui.control.Label
        WidthmSliderLabel               matlab.ui.control.Label
        WidthmSlider                    matlab.ui.control.Slider
        ParametersPanel                 matlab.ui.container.Panel
        UIAxes                          matlab.ui.control.UIAxes
        SelectionTab                    matlab.ui.container.Tab
        Image2                          matlab.ui.control.Image
        ChooseEnviornmentPanel          matlab.ui.container.Panel
        IRSelectDropDown                matlab.ui.control.DropDown
        IRSelectDropDownLabel           matlab.ui.control.Label
        ErrorLabel                      matlab.ui.control.Label
        SelectModeListBox               matlab.ui.control.ListBox
        SelectModeListBoxLabel          matlab.ui.control.Label
        envSelect                       matlab.ui.control.DropDown
        EnviornementSelectDropDownLabel  matlab.ui.control.Label
        IRgraph                         matlab.ui.control.UIAxes
        SimulationTab                   matlab.ui.container.Tab
        SimulatePanel                   matlab.ui.container.Panel
        ExportButton                    matlab.ui.control.Button
        ErrorLabel_IR                   matlab.ui.control.Label
        PlayButton                      matlab.ui.control.Button
        ResetButton                     matlab.ui.control.Button
        ApplyIRButton                   matlab.ui.control.Button
        OutputGraph                     matlab.ui.control.UIAxes
        LoadSourceAudioFilePanel        matlab.ui.container.Panel
        PlaySample                      matlab.ui.control.Button
        LoadButton                      matlab.ui.control.Button
        FileNameEditField               matlab.ui.control.EditField
        FileNameEditFieldLabel          matlab.ui.control.Label
        UIAxes2                         matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        dropdown = [] % Drop down options 
        
        all_options = ["1st Baptist Nashivlle","Elveden Hall Suffolk England",...
            "Hamilton-Mausoleum","Heslington-church","Maes-howe" ,"Falkland Palace Dungeon",...
            "Gill-heads-mine", "hoffmann-lime-kiln-langcliffeuk", "newgrange", "st-patricks-church-patrington",...
            "trollers-gill", "tyndall-bruce-monument","usina-del-arte-symphony-hall",...
             "Creswell-Crags","York-Guildhall-Council-Chamber","Shrine & Parish-church",...
             "Lady-Chapel-St-Albans-Cathedral","York Minster"];
        IR = [] % Impulse Repsonse
        audioFile = [] % Audio sample loaded
        filePath = '' % pathname
        applied_IR = [] % Final output with applied IR
        fs_file = 48000 % sampling frequency
      
        RIR = [] % Description
    end
    
    methods (Access = private)
        
        function returnOptions(app,Uwidth,Udepth,Uheight)
             % Return array of rooms based on configuration 
            options = []; %dropdown options array
            %database
    
            %1st Baptist Nashivlles
            nashville = struct();
            nashville.width = 15; %inmeters
            nashville.depth = 24;
            nashville.height = 15;
    
            %elveden-hall-suffolk-england
            elveden_hall = struct();
            elveden_hall.width = 20;
            elveden_hall.depth = 30;
            elveden_hall.height = 10;
    
            %Hamilton-Mausoleum
            hamilton = struct();
            hamilton.width = 30;
            hamilton.depth = 25;
            hamilton.height = 37;
                
            %heslington-church-vaa-group-2
            heslington = struct();
            heslington.width = 12;
            heslington.depth = 12;
            heslington.height = 12;
    
            %maes-howe
            maes_howe = struct();
            maes_howe.width = 12;
            maes_howe.depth = 12;
            maes_howe.height = 12;
            
            %falkland-palace-bottle-dungeon
            falkland_dungeon = struct();
            falkland_dungeon.width = 2;
            falkland_dungeon.depth = 2;
            falkland_dungeon.height = 2;

            %Gill-heads-mine
            gill_heads_mine = struct();
            gill_heads_mine.width = 2;
            gill_heads_mine.depth = 30;
            gill_heads_mine.height = 4;

            %hoffmann-lime
            hoffmann = struct();
            hoffmann.width = 8;
            hoffmann.depth = 20;
            hoffmann.height = 8;

            %newgrange
            newgrange = struct();
            newgrange.width = 2;
            newgrange.depth = 18;
            newgrange.height = 2;
            
            %st-patricks-church-patrington
            patrington = struct();
            patrington.width = 27;
            patrington.depth = 46;
            patrington.height = 57.5;

            %trollers-gill
            trollers_gill = struct();
            trollers_gill.width = 100;
            trollers_gill.depth = 40;
            trollers_gill.height = 100;

            %tyndall-bruce-monument 
            tyndall_bruce = struct();
            tyndall_bruce.width = 3.4;
            tyndall_bruce.depth = 3.4;
            tyndall_bruce.height = 3.4;

            %usina-del-arte-symphony-hall
            usina_del_arte = struct();
            usina_del_arte.width = 28;
            usina_del_arte.depth = 41;
            usina_del_arte.height = 13;
            
            %Creswell-Crags 
            creswell_crags= struct();
            creswell_crags.width = 90;
            creswell_crags.depth = 100;
            creswell_crags.height = 100;

            %York-Guildhall-Council-Chamber
            york_guildhall= struct();
            york_guildhall.width = 10;
            york_guildhall.depth = 15;
            york_guildhall.height = 9;

            %Shrine & Parish-church
            shrine_parish = struct();
            shrine_parish.width = 14;
            shrine_parish.depth = 28;
            shrine_parish.height = 6;

            %Lady-Chapel-St-Albans-Cathedral
            lady_chapel = struct();
            lady_chapel.width = 9;
            lady_chapel.depth = 12;
            lady_chapel.height = 43;

            %York Minster
            york_minster = struct();
            york_minster.width = 70;
            york_minster.depth = 76;
            york_minster.height = 27;


 
            %Main enviornment struct to hold nested structs
            env = struct();
            env.("nashville") = nashville;
            env.("elveden_hall") = elveden_hall;
            env.("hamilton") = hamilton;
            env.("heslington") = heslington;
            env.("maes_howe") = maes_howe;
            env.("falkland_dungeon") = falkland_dungeon;
            env.("gill_heads_mine") = gill_heads_mine;
            env.("hoffmann") = hoffmann;
            env.("newgrange") = newgrange;
            env.("patrington") = patrington;
            env.("trollers_gill") = trollers_gill;
            env.("tyndall_bruce") = tyndall_bruce;
            env.("usina_del_arte") = usina_del_arte;
            env.("creswell_crags") = creswell_crags;
            env.("york_guildhall") = york_guildhall;
            env.("shrine_parish") = shrine_parish;
            env.("lady_chapel") = lady_chapel;
            env.("york_minster") = york_minster;

            %Suggestion algorithm
            fn = fieldnames(env); %returns keys in database
            tol = 3; %tolerance in meters

            for k=1:numel(fn)
                room = string(fn{k});
                isWidthWithinRange = (Uwidth >= env.(room).width - tol) && ...
                    (Uwidth <= env.(room).width + tol);
                isDepthWithinRange = (Udepth >= env.(room).depth - tol) && ...
                    (Udepth <= env.(room).depth + tol);
                isHeightWithinRange = (Uheight >= env.(room).height - tol) && ...
                    (Uheight <= env.(room).height + tol);
    
                if (isWidthWithinRange || isDepthWithinRange || isHeightWithinRange)
                    % check source/reciever distances
                    options = [options string(room)]; 
                end
            end
    
            %Format array to send to dropdown list
            % Delete the first element (first entry is always empty)
            options = options(1:end);
            app.dropdown = string(options);
            app.envSelect.Items = app.dropdown;

            if isempty(options)
                app.ErrorLabel.Visible= 'on';
            end
        end
        
        function [time,amplitude] = audioToArray(app,filename)
            %Takes audio input and returns two arrays time and amplitude
            %axis
            [y,fs] = audioread(string(filename));
            y = y(:,1);
            dt = 1/fs;
            time = 0:dt:(length(y)*dt)-dt;
            amplitude = y;

        end
        
        function [h] = rir(app, fs, mic, n, r, rm, src)
            %RIR   Room Impulse Response.
            %   [h] = RIR(FS, MIC, N, R, RM, SRC) performs a room impulse
            %         response calculation by means of the mirror image method.
            %
            %      FS  = sample rate.
            %      MIC = row vector giving the x,y,z coordinates of
            %            the microphone.
            %      N   = The program will account for (2*N+1)^3 virtual sources
            %      R   = reflection coefficient for the walls, in general -1<R<1.
            %      RM  = row vector giving the dimensions of the room.
            %      SRC = row vector giving the x,y,z coordinates of
            %            the sound source.
            %   NOTES:
            %
            %   1) All distances are in meters.
            %   2) The output is scaled such that the largest value of the
            %      absolute value of the output vector is equal to one.

            nn=-n:1:n;                            % Index for the sequence
            rms=nn+0.5-0.5*(-1).^nn;              % Part of equations 2,3,& 4
            srcs=(-1).^(nn);                      % part of equations 2,3,& 4
            xi=srcs*src(1)+rms*rm(1)-mic(1);      % Equation 2
            yj=srcs*src(2)+rms*rm(2)-mic(2);      % Equation 3
            zk=srcs*src(3)+rms*rm(3)-mic(3);      % Equation 4

            [i,j,k]=meshgrid(xi,yj,zk);           % convert vectors to 3D matrices
            d=sqrt(i.^2+j.^2+k.^2);               % Equation 5
            time=round(fs*d/343)+1;               % Similar to Equation 6

            [e,f,g]=meshgrid(nn, nn, nn);         % convert vectors to 3D matrices
            c=r.^(abs(e)+abs(f)+abs(g));          % Equation 9
            e=c./d;                               % Equivalent to Equation 10

            h=full(sparse(time(:),1,e(:)));       % Equivalent to equation 11
            h=h/max(abs(h));                      % Scale output
        end
        
        function [y] = fconv(app,x,h)
            %FCONV Fast Convolution
            %   [y] = FCONV(x, h) convolves x and h, and normalizes the output
            %         to +-1.
            %
            %      x = input vector
            %      h = input vector
            Ly = length(x) + length(h) - 1;		%
            Ly2 = pow2(nextpow2(Ly));			% Find smallest power of 2 that is > Ly
            X = fft(x, Ly2);					% Fast Fourier transform
            H = fft(h, Ly2);					% Fast Fourier transform
            Y = X .* H;							%
            y = real(ifft(Y, Ly2));				% Inverse fast Fourier transform
            y = y(1:1:Ly);						% Take just the first N elements
            y=y/max(abs(y));					% Normalize the output
            
        end
        
        function updateEntries(app)
            value = app.envSelect.Value;
            switch string(value)
                case {"nashville", app.all_options(1)}
                    app.Image2.ImageSource = "assets\1st-baptist-nashville\images\first_baptist_church_of_nashville_northwest_corner_2.jpg";
                    app.IRSelectDropDown.Items = ["Balcony" "Far" "Wide"];
                    switch app.IRSelectDropDown.Value
                        case "Balcony"
                            [time,app.IR] = audioToArray(app,"assets\1st-baptist-nashville\stereo\1st_baptist_nashville_balcony.wav");
                            plot(app.IRgraph,time,app.IR);
                        case "Far"
                            [time,app.IR] = audioToArray(app,"assets\1st-baptist-nashville\stereo\1st_baptist_nashville_far_close.wav");
                            plot(app.IRgraph,time,app.IR);
                        case "Wide"
                            [time,app.IR] = audioToArray(app,"assets\1st-baptist-nashville\stereo\1st_baptist_nashville_far_wide.wav");
                            plot(app.IRgraph,time,app.IR);
                    end
                case {"elveden_hall", app.all_options(2)}
                    app.Image2.ImageSource = "assets\elveden-hall-suffolk-england\images\elvedenlocationb.jpg";
                    app.IRSelectDropDown.Items = ["Marble" "Lord Cloaks" "Visitor Cloaks" "Smoking Room"];
                        switch app.IRSelectDropDown.Value
                            case "Marble"
                                [time,app.IR] = audioToArray(app,"assets\elveden-hall-suffolk-england\stereo\1a_marble_hall.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "Lord Cloaks"
                                [time,app.IR] = audioToArray(app,"assets\elveden-hall-suffolk-england\stereo\3a_hats_cloaks_the_lord.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "Visitor Cloaks"
                                [time,app.IR] = audioToArray(app,"assets\elveden-hall-suffolk-england\stereo\4a_hats_cloaks_visitors.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "Smoking Room"
                                [time,app.IR] = audioToArray(app,"assets\elveden-hall-suffolk-england\stereo\18a_smoking_room.wav"); 
                                plot(app.IRgraph,time,app.IR);
                        end
                case {"hamilton", app.all_options(3)}
                    app.IRSelectDropDown.Items = ["Main Chamber"];
                    app.Image2.ImageSource = "assets\hamilton-mausoleum\images\hm_int_sm.jpg";
                    [time,app.IR] = audioToArray(app,"assets\hamilton-mausoleum\stereo\hm2_000_ortf_48k.wav");
                    plot(app.IRgraph,time,app.IR);
                case {"heslington", app.all_options(4)}
                    app.Image2.ImageSource = "assets\heslington-church-vaa-group-2\images\heslington_church_impulse_response-4900.jpg";
                    app.IRSelectDropDown.Items = ["01" "02" "03" "04" "05" "06" "07"];
                    switch app.IRSelectDropDown.Value
                            case "01"
                                [time,app.IR] = audioToArray(app,"assets\heslington-church-vaa-group-2\b-format\impulseresponseheslingtonchurch-001.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "02"
                                [time,app.IR] = audioToArray(app,"assets\heslington-church-vaa-group-2\b-format\impulseresponseheslingtonchurch-002.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "03"
                                [time,app.IR] = audioToArray(app,"assets\heslington-church-vaa-group-2\b-format\impulseresponseheslingtonchurch-003.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "04"
                                [time,app.IR] = audioToArray(app,"assets\heslington-church-vaa-group-2\b-format\impulseresponseheslingtonchurch-004.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "05"
                                [time,app.IR] = audioToArray(app,"assets\heslington-church-vaa-group-2\b-format\impulseresponseheslingtonchurch-005.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "06"
                                [time,app.IR] = audioToArray(app,"assets\heslington-church-vaa-group-2\b-format\impulseresponseheslingtonchurch-006.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "07"
                                [time,app.IR] = audioToArray(app,"assets\heslington-church-vaa-group-2\b-format\impulseresponseheslingtonchurch-007.wav");
                                plot(app.IRgraph,time,app.IR);
                    end
                case {"maes_howe", app.all_options(5)}
                    app.Image2.ImageSource = "assets\maes-howe\images\mh_ext_sm.jpg";
                    app.IRSelectDropDown.Items = ["Center"];
                    [time,app.IR] = audioToArray(app,"assets\maes-howe\stereo\mh3_000_ortf_48k.wav");
                    plot(app.IRgraph,time,app.IR);
                case {"falkland_dungeon", app.all_options(6)}
                    app.Image2.ImageSource = "assets\falkland-palace-bottle-dungeon\images\dungeon.jpeg";
                    app.IRSelectDropDown.Items = ["Bottle"];
                    [time,app.IR] = audioToArray(app,"assets\falkland-palace-bottle-dungeon\b-format\bottledungeon1_sf_edited.wav");
                    plot(app.IRgraph,time,app.IR);
                case {"gill_heads_mine", app.all_options(7)}
                    app.Image2.ImageSource = "assets\gill-heads-mine\images\mine_entrance_b.jpg";
                    app.IRSelectDropDown.Items = ["Site One 1 Way" "Site One - 2 way" "Site Two - 1 Way" "Site Two - 2 Way"];
                    switch app.IRSelectDropDown.Value
                        case "Site One 1 Way"
                            [time,app.IR] = audioToArray(app,"assets\gill-heads-mine\b-format\mine_site1_1way_bformat.wav");
                            plot(app.IRgraph,time,app.IR);
                        case "Site One - 2 way"
                            [time,app.IR] = audioToArray(app,"assets\gill-heads-mine\b-format\mine_site1_2way_bformat.wav");
                            plot(app.IRgraph,time,app.IR);
                        case "Site Two - 1 Way"
                            [time,app.IR] = audioToArray(app,"assets\gill-heads-mine\b-format\mine_site2_1way_bformat.wav");
                            plot(app.IRgraph,time,app.IR);
                        case "Site Two - 2 Way"
                            [time,app.IR] = audioToArray(app,"assets\gill-heads-mine\b-format\mine_site2_2way_bformat.wav");
                            plot(app.IRgraph,time,app.IR);
                    end
                case {"hoffmann", app.all_options(8)}
                    app.Image2.ImageSource = "assets\hoffmann-lime-kiln-langcliffeuk\images\AdobeStock_118983058-scaled.jpeg";
                    app.IRSelectDropDown.Items = ["p1" "p2" "p3" "p4" "p5" "p6"];
                    switch app.IRSelectDropDown.Value
                            case "p1"
                                [time,app.IR] = audioToArray(app,"assets\hoffmann-lime-kiln-langcliffeuk\b-format\ir_p1.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "p2"
                                [time,app.IR] = audioToArray(app,"assets\hoffmann-lime-kiln-langcliffeuk\b-format\ir_p2.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "p3"
                                [time,app.IR] = audioToArray(app,"assets\hoffmann-lime-kiln-langcliffeuk\b-format\ir_p3.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "p4"
                                [time,app.IR] = audioToArray(app,"assets\hoffmann-lime-kiln-langcliffeuk\b-format\ir_p4.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "p5"
                                [time,app.IR] = audioToArray(app,"assets\hoffmann-lime-kiln-langcliffeuk\b-format\ir_p5.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "p6"
                                [time,app.IR] = audioToArray(app,"assets\hoffmann-lime-kiln-langcliffeuk\b-format\ir_p6.wav");
                                plot(app.IRgraph,time,app.IR);
                    end
                case {"newgrange", app.all_options(9)}
                    app.Image2.ImageSource = "assets\newgrange\images\structure.jpg";
                    app.IRSelectDropDown.Items = ["s1" "s2" "s3" "s4" "s5" "s6"];
                    switch app.IRSelectDropDown.Value
                            case "s1"
                                [time,app.IR] = audioToArray(app,"assets\newgrange\b-format\newgrange_s1r1.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "s2"
                                [time,app.IR] = audioToArray(app,"assets\newgrange\b-format\newgrange_s2r1.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "s3"
                                [time,app.IR] = audioToArray(app,"assets\newgrange\b-format\newgrange_s3r1.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "s4"
                                [time,app.IR] = audioToArray(app,"assets\newgrange\b-format\newgrange_s4r1.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "s5"
                                [time,app.IR] = audioToArray(app,"assets\newgrange\b-format\newgrange_s5r1.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "s6"
                                [time,app.IR] = audioToArray(app,"assets\newgrange\b-format\newgrange_s6r1.wav");
                                plot(app.IRgraph,time,app.IR);
                    end
                  case {"patrington", app.all_options(10)}
                    app.Image2.ImageSource = "assets\st-patricks-church-patrington\images\sl381519.jpg";
                    app.IRSelectDropDown.Items = ["s1" "s2" "s3"];
                    switch app.IRSelectDropDown.Value
                            case "s1"
                                [time,app.IR] = audioToArray(app,"assets\st-patricks-church-patrington\b-format\soundfield_s1r1.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "s2"
                                [time,app.IR] = audioToArray(app,"assets\st-patricks-church-patrington\b-format\soundfield_s2r2.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "s3"
                                [time,app.IR] = audioToArray(app,"assets\st-patricks-church-patrington\b-format\soundfield_s3r3.wav");
                                plot(app.IRgraph,time,app.IR);
                    end
                 case {"trollers_gill", app.all_options(11)}
                    app.Image2.ImageSource = "assets\trollers-gill\images\site1_b.jpg";
                    app.IRSelectDropDown.Items = ["site 1" "site 2" "site 3"];
                    switch app.IRSelectDropDown.Value
                        case "site 1"
                                [time,app.IR] = audioToArray(app,"assets\trollers-gill\b-format\dales_site1_4way_bformat.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "site 2"
                                [time,app.IR] = audioToArray(app,"assets\trollers-gill\b-format\dales_site2_4way_bformat.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "site 3"
                                [time,app.IR] = audioToArray(app,"assets\trollers-gill\b-format\dales_site3_4way_bformat.wav");
                                plot(app.IRgraph,time,app.IR);
                    end
                case {"tyndall_bruce", app.all_options(12)}
                    app.Image2.ImageSource = "assets\tyndall-bruce-monument\images\dsc00532.jpg";
                    app.IRSelectDropDown.Items = ["tyndall"];
                
                    [time,app.IR] = audioToArray(app,"assets\tyndall-bruce-monument\b-format\tyndall_bruce_b_format.wav");
                    plot(app.IRgraph,time,app.IR);
                case {"usina_del_arte", app.all_options(13)}
                    app.Image2.ImageSource = "assets\usina-del-arte-symphony-hall\images\usina_full.jpg";
                    app.IRSelectDropDown.Items = ["w" "x" "y" "z"];
                    switch app.IRSelectDropDown.Value
                        case "w"
                                [time,app.IR] = audioToArray(app,"assets\usina-del-arte-symphony-hall\b-format\ir_w_m5.s1.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "x"
                                [time,app.IR] = audioToArray(app,"assets\usina-del-arte-symphony-hall\b-format\ir_x_m5.s1.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "y"
                                [time,app.IR] = audioToArray(app,"assets\usina-del-arte-symphony-hall\b-format\ir_y_m5.s1.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "z"
                                [time,app.IR] = audioToArray(app,"assets\usina-del-arte-symphony-hall\b-format\ir_z_m5.s1.wav");
                                plot(app.IRgraph,time,app.IR);
                    end   
                case {"creswell_crags", app.all_options(14)}
                    app.Image2.ImageSource = "assets\creswell-crags\images\cc.jpg";
                    app.IRSelectDropDown.Items = ["bottom level" "main level" "pinehole" "grundypath"];
                    switch app.IRSelectDropDown.Value
                        case "bottom level"
                                [time,app.IR] = audioToArray(app,"assets\creswell-crags\b-format\1_r_rhcbottom_s_rhc_bottom.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "main level"
                                [time,app.IR] = audioToArray(app,"assets\creswell-crags\b-format\3_s_mainlevel_r_furtherin.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "pinehole"
                                [time,app.IR] = audioToArray(app,"assets\creswell-crags\b-format\6_r_pinholemouth_s_pinholepath.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "grundypath"
                                [time,app.IR] = audioToArray(app,"assets\creswell-crags\b-format\8_r_grundymouth_s_grundypath.wav");
                                plot(app.IRgraph,time,app.IR);
                    end
                case {"york_guildhall", app.all_options(15)}
                    app.Image2.ImageSource = "assets\york-guildhall-council-chamber\images\_dsc3190-edit-13.jpg";
                    app.IRSelectDropDown.Items = ["R1" "R2" "R3" "R4"];
                    switch app.IRSelectDropDown.Value
                        case "R1"
                                [time,app.IR] = audioToArray(app,"assets\york-guildhall-council-chamber\b-format\councilchamber_s1_r1_ir_1_96000.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "R2"
                                [time,app.IR] = audioToArray(app,"assets\york-guildhall-council-chamber\b-format\councilchamber_s1_r2_ir_1_96000.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "R3"
                                [time,app.IR] = audioToArray(app,"assets\york-guildhall-council-chamber\b-format\councilchamber_s1_r3_ir_1_96000.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "R4"
                                [time,app.IR] = audioToArray(app,"assets\york-guildhall-council-chamber\b-format\councilchamber_s1_r4_ir_1_96000.wav");
                                plot(app.IRgraph,time,app.IR);
                    end
                case {"shrine_parish", app.all_options(16)}
                    app.Image2.ImageSource = "assets\shrine-and-parish-church-all-saints-north-street-_\images\R.jpg";
                    app.IRSelectDropDown.Items = ["R1" "R2" "R3" "R4" "R5" "R6"];
                    switch app.IRSelectDropDown.Value
                        case "R1"
                                [time,app.IR] = audioToArray(app,"assets\shrine-and-parish-church-all-saints-north-street-_\b-format\r1_90_bformat.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "R2"
                                [time,app.IR] = audioToArray(app,"assets\shrine-and-parish-church-all-saints-north-street-_\b-format\r2_90_bformat.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "R3"
                                [time,app.IR] = audioToArray(app,"assets\shrine-and-parish-church-all-saints-north-street-_\b-format\r3_90_bformat.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "R4"
                                [time,app.IR] = audioToArray(app,"assets\shrine-and-parish-church-all-saints-north-street-_\b-format\r4_90_bformat.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "R5"
                                [time,app.IR] = audioToArray(app,"assets\shrine-and-parish-church-all-saints-north-street-_\b-format\r5_90_bformat.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "R6"
                                [time,app.IR] = audioToArray(app,"assets\shrine-and-parish-church-all-saints-north-street-_\b-format\r6_90_bformat.wav");
                                plot(app.IRgraph,time,app.IR);
                    end
                case {"lady_chapel", app.all_options(17)}
                    app.Image2.ImageSource = "assets\lady-chapel-st-albans-cathedral\images\lady_chapel_1.jpg";
                    app.IRSelectDropDown.Items = ["stalbans a" "stalbans b"];
                    switch app.IRSelectDropDown.Value
                        case "stalbans a"
                                [time,app.IR] = audioToArray(app,"assets\lady-chapel-st-albans-cathedral\b-format\stalbans_a_wxyz.wav");
                                plot(app.IRgraph,time,app.IR);
                        case "stalbans b"
                                [time,app.IR] = audioToArray(app,"assets\lady-chapel-st-albans-cathedral\b-format\stalbans_b_wxyz.wav");
                                plot(app.IRgraph,time,app.IR);
                    end
                case {"york_minster", app.all_options(18)}
                    app.Image2.ImageSource = "assets\york-minster\images\dsc_0285.jpg";
                    app.IRSelectDropDown.Items = ["york"];
                
                    [time,app.IR] = audioToArray(app,"assets\york-minster\b-format\minster1_bformat_48k.wav");
                    plot(app.IRgraph,time,app.IR);


            end
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: SimulateButton
        function SimulateButtonPushed(app, event)
    
            %Write data into properties
            Width = app.WidthmSlider.Value;
            Depth = app.DepthmSlider.Value;
            Height = app.HeightmSlider.Value;
            
            sourceCoord = [app.sourceXSpinner.Value, app.sourceYSpinner.Value, app.sourceZSpinner.Value];
            receiverCoord = [app.recXSpinner.Value,app.recYSpinner.Value,app.recZSpinner.Value];
            
            %app.sourceCoords = sourceCoord;
            %app.recieverCoords = receiverCoord;

            dist = norm(receiverCoord - sourceCoord);

            %Creating room Dimensions array
            roomDimensions = [Width Depth Height];
            X = [0;roomDimensions(1);roomDimensions(1);0;0];
            Y = [0;0;roomDimensions(2);roomDimensions(2);0];
            Z = [0;0;0;0;0];
            
            hold(app.UIAxes,'on');
            % draw a square in the xy plane with z = 0
            plot3(app.UIAxes,X,Y,Z,"k","LineWidth",1.5);
            % draw a square in the xy plane with z = 1
            plot3(app.UIAxes,X,Y,Z+roomDimensions(3),"k","LineWidth",1.5); 
            for k=1:length(X)-1
                plot3(app.UIAxes, [X(k);X(k)],[Y(k);Y(k)],[0;roomDimensions(3)],"k","LineWidth",1.5);
            end
            plot3(app.UIAxes,sourceCoord(1),sourceCoord(2),sourceCoord(3),"bx","LineWidth",2)
            plot3(app.UIAxes,receiverCoord(1),receiverCoord(2),receiverCoord(3),"ro","LineWidth",2)
            hold(app.UIAxes,'off');

            %Update options list based on user input
            returnOptions(app,Width,Depth,Height);
            updateEntries(app);

            %Generate Room Impulse Response
            app.RIR = rir(app,app.fs_file,receiverCoord, 6 ,0.75 ,roomDimensions,sourceCoord);

            
        end

        % Value changed function: SelectModeListBox
        function SelectModeListBoxValueChanged(app, event)
            value = app.SelectModeListBox.Value;
  
            switch value
                case "Suggestion Mode"
                    app.envSelect.Items = app.dropdown;
                    updateEntries(app);
                
                case "All Options"
                    % update the selection dropdown
                    app.envSelect.Items = app.all_options; 
                    value1 = app.envSelect.Value;
                    switch value1 %edge case first option
                        case {"nashville", app.all_options(1)}
                            app.Image2.ImageSource = "assets\1st-baptist-nashville\images\first_baptist_church_of_nashville_northwest_corner_2.jpg";
                        app.IRSelectDropDown.Items = ["Balcony" "Far" "Wide"];
                        switch app.IRSelectDropDown.Value
                            case "Balcony"
                                [time,app.IR] = audioToArray(app,"assets\1st-baptist-nashville\stereo\1st_baptist_nashville_balcony.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "Far"
                                [time,app.IR] = audioToArray(app,"assets\1st-baptist-nashville\stereo\1st_baptist_nashville_far_close.wav");
                                plot(app.IRgraph,time,app.IR);
                            case "Wide"
                                [time,app.IR] = audioToArray(app,"assets\1st-baptist-nashville\stereo\1st_baptist_nashville_far_wide.wav");
                                plot(app.IRgraph,time,app.IR);
                        end
                    end
                
            end
        end

        % Value changed function: envSelect
        function envSelectValueChanged(app, event)
            updateEntries(app);
        end

        % Button pushed function: LoadButton
        function LoadButtonPushed(app, event)
            [file, path] = uigetfile('*.wav'); %open a mp3 file
            app.FileNameEditField.Value = string(file);
            figure(app.UIFigure);
            [filepath,~,~] = fileparts(path);
            [output,fs] = audioread(fullfile(filepath,file));
            app.audioFile = output(:,1);
            dt = 1/fs;
            app.fs_file = fs;
            t = 0:dt:(length(app.audioFile)*dt)-dt;
            plot(app.UIAxes2,t,app.audioFile)

             
        end

        % Button pushed function: ApplyIRButton
        function ApplyIRButtonPushed(app, event)
            wetVal_IR = 0.75;
            wetVal_RIR = 0.25;
            if isempty(app.RIR) == 1 %If RIR is empty just use IR (Partial)

                output = conv(app.IR, app.audioFile);
                dt = 1/app.fs_file; 
                t = 0:dt:(length(output)*dt)-dt;
                app.applied_IR = output/max(output);
                plot(app.OutputGraph,t, app.applied_IR);
                
                
            elseif isempty(app.IR) ~= 1 % Using both RIR and IR (Full)

                app.ErrorLabel_IR.Visible = "off";

                output1 = fconv(app,app.audioFile, wetVal_RIR*app.RIR);

                output = conv(wetVal_IR*app.IR, output1);
                dt = 1/app.fs_file; 
                t = 0:dt:(length(output)*dt)-dt;
                app.applied_IR = output/max(output);
                plot(app.OutputGraph,t, app.applied_IR );
                
            else
                app.ErrorLabel_IR.Visible = "on";
            end

            
        end

        % Button pushed function: PlayButton
        function PlayButtonPushed(app, event)
            
            soundsc(app.applied_IR,app.fs_file)
        end

        % Button pushed function: PlaySample
        function PlaySampleButtonPushed(app, event)
            if isempty(app.audioFile) ~= 1
                soundsc(app.audioFile,app.fs_file)
            end
        end

        % Button pushed function: ResetButton, ResetButton_2
        function ResetButtonPushed(app, event)
            % Make current instance of app invisible
            app.UIFigure.Visible = 'off';
            % Open 2nd instance of app
            RoomAcoustic_main();  
            % Delete old instance
            close(app.UIFigure) 
        end

        % Value changed function: IRSelectDropDown
        function IRSelectDropDownValueChanged(app, event)
            value = app.IRSelectDropDown.Value;
            updateEntries(app)
        end

        % Button pushed function: ExportButton
        function ExportButtonPushed(app, event)
            audiowrite("output.wav",app.applied_IR,app.fs_file);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [2 1 639 480];

            % Create HomeTab
            app.HomeTab = uitab(app.TabGroup);
            app.HomeTab.Title = 'Home';
            app.HomeTab.BackgroundColor = [1 1 1];
            app.HomeTab.ForegroundColor = [0.149 0.149 0.149];

            % Create WelcomePanel
            app.WelcomePanel = uipanel(app.HomeTab);
            app.WelcomePanel.Title = 'Welcome';
            app.WelcomePanel.Position = [9 212 605 233];

            % Create Image
            app.Image = uiimage(app.WelcomePanel);
            app.Image.Position = [145 -55 326 258];
            app.Image.ImageSource = 'Dawn-over-the-Minack-1-1.jpg';

            % Create RoomAcousticSimulatorLabel
            app.RoomAcousticSimulatorLabel = uilabel(app.WelcomePanel);
            app.RoomAcousticSimulatorLabel.FontName = 'Cambria';
            app.RoomAcousticSimulatorLabel.FontSize = 23;
            app.RoomAcousticSimulatorLabel.FontWeight = 'bold';
            app.RoomAcousticSimulatorLabel.FontAngle = 'italic';
            app.RoomAcousticSimulatorLabel.Position = [173 158 277 75];
            app.RoomAcousticSimulatorLabel.Text = 'Room Acoustic Simulator';

            % Create InstructionsPanel
            app.InstructionsPanel = uipanel(app.HomeTab);
            app.InstructionsPanel.Title = 'Instructions';
            app.InstructionsPanel.Position = [7 28 619 185];

            % Create ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel
            app.ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel = uilabel(app.InstructionsPanel);
            app.ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel.FontName = 'Cambria';
            app.ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel.FontAngle = 'italic';
            app.ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel.Position = [12 127 534 22];
            app.ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel.Text = 'This is an acoustic room simulator powered by the Open AIR database. First set your room dimensions to';

            % Create DirectionsLabel
            app.DirectionsLabel = uilabel(app.InstructionsPanel);
            app.DirectionsLabel.HorizontalAlignment = 'center';
            app.DirectionsLabel.FontName = 'Cambria';
            app.DirectionsLabel.FontWeight = 'bold';
            app.DirectionsLabel.FontAngle = 'italic';
            app.DirectionsLabel.Position = [274 85 61 22];
            app.DirectionsLabel.Text = 'Directions';

            % Create SetdesiredsizeofenviornemntinConfigurepanelandclickLabel
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel = uilabel(app.InstructionsPanel);
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel.FontName = 'Cambria';
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel.FontAngle = 'italic';
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel.Position = [20 63 607 22];
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel.Text = '1. Set desired size of enviornemnt in Configure panel, and click simulate (if you don''t wish to set size, move to next step)';

            % Create SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2 = uilabel(app.InstructionsPanel);
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2.FontName = 'Cambria';
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2.FontAngle = 'italic';
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2.Position = [20 35 580 22];
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2.Text = '2. Select desired enviornement stage (suggestions will be populated based on user selection or choose all options) ';

            % Create SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3 = uilabel(app.InstructionsPanel);
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3.FontName = 'Cambria';
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3.FontAngle = 'italic';
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3.Position = [20 5 385 22];
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3.Text = '3. Simulate the enviornemnt by loading an audio file and clicking ''Apply IR''!';

            % Create ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel_2
            app.ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel_2 = uilabel(app.InstructionsPanel);
            app.ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel_2.FontName = 'Cambria';
            app.ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel_2.FontAngle = 'italic';
            app.ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel_2.Position = [10 108 546 22];
            app.ThisisanacousticroomsimulatorpoweredbytheOpenAIRdatabaseLabel_2.Text = ' generate a room impulse response, then choose an impulse response from an enviornment of your chosing!';

            % Create Hyperlink
            app.Hyperlink = uihyperlink(app.HomeTab);
            app.Hyperlink.URL = 'https://www.openairlib.net/';
            app.Hyperlink.Position = [568 1 63 22];
            app.Hyperlink.Text = 'Open AIR ';

            % Create ConfigureTab
            app.ConfigureTab = uitab(app.TabGroup);
            app.ConfigureTab.Title = 'Configure';

            % Create UIAxes
            app.UIAxes = uiaxes(app.ConfigureTab);
            title(app.UIAxes, 'Room Model')
            xlabel(app.UIAxes, 'X (m)')
            ylabel(app.UIAxes, 'Y (m)')
            zlabel(app.UIAxes, 'Z (m)')
            app.UIAxes.View = [-28 35];
            app.UIAxes.Projection = 'perspective';
            app.UIAxes.XLim = [-100 100];
            app.UIAxes.YLim = [-100 100];
            app.UIAxes.ZLim = [-100 100];
            app.UIAxes.XGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.ZGrid = 'on';
            app.UIAxes.Position = [117 229 377 227];

            % Create ParametersPanel
            app.ParametersPanel = uipanel(app.ConfigureTab);
            app.ParametersPanel.Title = 'Parameters';
            app.ParametersPanel.Position = [10 1 521 221];

            % Create RoomSizeParametersPanel
            app.RoomSizeParametersPanel = uipanel(app.ConfigureTab);
            app.RoomSizeParametersPanel.Title = 'Room Size Parameters';
            app.RoomSizeParametersPanel.Position = [16 10 242 182];

            % Create WidthmSlider
            app.WidthmSlider = uislider(app.RoomSizeParametersPanel);
            app.WidthmSlider.Position = [76 134 147 3];

            % Create WidthmSliderLabel
            app.WidthmSliderLabel = uilabel(app.RoomSizeParametersPanel);
            app.WidthmSliderLabel.HorizontalAlignment = 'right';
            app.WidthmSliderLabel.Position = [-1 111 57 22];
            app.WidthmSliderLabel.Text = 'Width (m)';

            % Create DepthmSliderLabel
            app.DepthmSliderLabel = uilabel(app.RoomSizeParametersPanel);
            app.DepthmSliderLabel.HorizontalAlignment = 'right';
            app.DepthmSliderLabel.Position = [2 61 59 22];
            app.DepthmSliderLabel.Text = 'Depth (m)';

            % Create DepthmSlider
            app.DepthmSlider = uislider(app.RoomSizeParametersPanel);
            app.DepthmSlider.Position = [74 80 149 3];

            % Create HeightmSliderLabel
            app.HeightmSliderLabel = uilabel(app.RoomSizeParametersPanel);
            app.HeightmSliderLabel.HorizontalAlignment = 'right';
            app.HeightmSliderLabel.Position = [1 22 62 22];
            app.HeightmSliderLabel.Text = 'Height (m)';

            % Create HeightmSlider
            app.HeightmSlider = uislider(app.RoomSizeParametersPanel);
            app.HeightmSlider.Position = [72 32 154 3];

            % Create SourceRecieverCoordinatesPanel
            app.SourceRecieverCoordinatesPanel = uipanel(app.ConfigureTab);
            app.SourceRecieverCoordinatesPanel.Title = 'Source & Reciever Coordinates';
            app.SourceRecieverCoordinatesPanel.Position = [270 10 247 182];

            % Create SourcexLabel
            app.SourcexLabel = uilabel(app.SourceRecieverCoordinatesPanel);
            app.SourcexLabel.Position = [65 124 57 22];
            app.SourcexLabel.Text = 'Source ''x''';

            % Create RecieveroLabel
            app.RecieveroLabel = uilabel(app.SourceRecieverCoordinatesPanel);
            app.RecieveroLabel.Position = [167 124 67 22];
            app.RecieveroLabel.Text = 'Reciever ''o''';

            % Create XmLabel
            app.XmLabel = uilabel(app.SourceRecieverCoordinatesPanel);
            app.XmLabel.HorizontalAlignment = 'right';
            app.XmLabel.Position = [19 99 31 22];
            app.XmLabel.Text = 'X(m)';

            % Create sourceXSpinner
            app.sourceXSpinner = uispinner(app.SourceRecieverCoordinatesPanel);
            app.sourceXSpinner.Limits = [0 100];
            app.sourceXSpinner.Position = [65 99 47 22];

            % Create YmLabel
            app.YmLabel = uilabel(app.SourceRecieverCoordinatesPanel);
            app.YmLabel.HorizontalAlignment = 'right';
            app.YmLabel.Position = [20 62 31 22];
            app.YmLabel.Text = 'Y(m)';

            % Create sourceYSpinner
            app.sourceYSpinner = uispinner(app.SourceRecieverCoordinatesPanel);
            app.sourceYSpinner.Limits = [0 100];
            app.sourceYSpinner.Position = [66 62 47 22];

            % Create ZmLabel
            app.ZmLabel = uilabel(app.SourceRecieverCoordinatesPanel);
            app.ZmLabel.HorizontalAlignment = 'right';
            app.ZmLabel.Position = [20 29 31 22];
            app.ZmLabel.Text = 'Z(m)';

            % Create sourceZSpinner
            app.sourceZSpinner = uispinner(app.SourceRecieverCoordinatesPanel);
            app.sourceZSpinner.Limits = [0 100];
            app.sourceZSpinner.Position = [66 29 47 22];

            % Create XmLabel_2
            app.XmLabel_2 = uilabel(app.SourceRecieverCoordinatesPanel);
            app.XmLabel_2.HorizontalAlignment = 'right';
            app.XmLabel_2.Position = [144 98 31 22];
            app.XmLabel_2.Text = 'X(m)';

            % Create recXSpinner
            app.recXSpinner = uispinner(app.SourceRecieverCoordinatesPanel);
            app.recXSpinner.Limits = [0 100];
            app.recXSpinner.Position = [190 98 47 22];

            % Create ZmLabel_2
            app.ZmLabel_2 = uilabel(app.SourceRecieverCoordinatesPanel);
            app.ZmLabel_2.HorizontalAlignment = 'right';
            app.ZmLabel_2.Position = [145 28 31 22];
            app.ZmLabel_2.Text = 'Z(m)';

            % Create recZSpinner
            app.recZSpinner = uispinner(app.SourceRecieverCoordinatesPanel);
            app.recZSpinner.Limits = [0 100];
            app.recZSpinner.Position = [191 28 47 22];

            % Create YmLabel_2
            app.YmLabel_2 = uilabel(app.SourceRecieverCoordinatesPanel);
            app.YmLabel_2.HorizontalAlignment = 'right';
            app.YmLabel_2.Position = [145 61 31 22];
            app.YmLabel_2.Text = 'Y(m)';

            % Create recYSpinner
            app.recYSpinner = uispinner(app.SourceRecieverCoordinatesPanel);
            app.recYSpinner.Limits = [0 100];
            app.recYSpinner.Position = [191 61 47 22];

            % Create SimulateButton
            app.SimulateButton = uibutton(app.ConfigureTab, 'push');
            app.SimulateButton.ButtonPushedFcn = createCallbackFcn(app, @SimulateButtonPushed, true);
            app.SimulateButton.Position = [544 82 87 22];
            app.SimulateButton.Text = 'Simulate';

            % Create ResetButton_2
            app.ResetButton_2 = uibutton(app.ConfigureTab, 'push');
            app.ResetButton_2.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);
            app.ResetButton_2.BackgroundColor = [0.8706 0.1294 0.1294];
            app.ResetButton_2.FontWeight = 'bold';
            app.ResetButton_2.Position = [555 32 66 23];
            app.ResetButton_2.Text = 'Reset';

            % Create SelectionTab
            app.SelectionTab = uitab(app.TabGroup);
            app.SelectionTab.Title = 'Selection';

            % Create IRgraph
            app.IRgraph = uiaxes(app.SelectionTab);
            title(app.IRgraph, 'Loaded IR Response')
            xlabel(app.IRgraph, 'Time')
            ylabel(app.IRgraph, 'Y')
            zlabel(app.IRgraph, 'Z')
            app.IRgraph.Position = [319 41 300 229];

            % Create ChooseEnviornmentPanel
            app.ChooseEnviornmentPanel = uipanel(app.SelectionTab);
            app.ChooseEnviornmentPanel.Title = 'Choose Enviornment';
            app.ChooseEnviornmentPanel.Position = [2 302 637 154];

            % Create EnviornementSelectDropDownLabel
            app.EnviornementSelectDropDownLabel = uilabel(app.ChooseEnviornmentPanel);
            app.EnviornementSelectDropDownLabel.HorizontalAlignment = 'right';
            app.EnviornementSelectDropDownLabel.FontWeight = 'bold';
            app.EnviornementSelectDropDownLabel.Position = [256 81 124 22];
            app.EnviornementSelectDropDownLabel.Text = 'Enviornement Select';

            % Create envSelect
            app.envSelect = uidropdown(app.ChooseEnviornmentPanel);
            app.envSelect.Items = {};
            app.envSelect.ValueChangedFcn = createCallbackFcn(app, @envSelectValueChanged, true);
            app.envSelect.Position = [395 81 219 22];
            app.envSelect.Value = {};

            % Create SelectModeListBoxLabel
            app.SelectModeListBoxLabel = uilabel(app.ChooseEnviornmentPanel);
            app.SelectModeListBoxLabel.HorizontalAlignment = 'center';
            app.SelectModeListBoxLabel.FontWeight = 'bold';
            app.SelectModeListBoxLabel.Position = [9 82 76 22];
            app.SelectModeListBoxLabel.Text = 'Select Mode';

            % Create SelectModeListBox
            app.SelectModeListBox = uilistbox(app.ChooseEnviornmentPanel);
            app.SelectModeListBox.Items = {'Suggestion Mode', 'All Options'};
            app.SelectModeListBox.ValueChangedFcn = createCallbackFcn(app, @SelectModeListBoxValueChanged, true);
            app.SelectModeListBox.Position = [100 63 137 43];
            app.SelectModeListBox.Value = 'Suggestion Mode';

            % Create ErrorLabel
            app.ErrorLabel = uilabel(app.ChooseEnviornmentPanel);
            app.ErrorLabel.FontWeight = 'bold';
            app.ErrorLabel.FontAngle = 'italic';
            app.ErrorLabel.FontColor = [0.902 0.3765 0.3765];
            app.ErrorLabel.Visible = 'off';
            app.ErrorLabel.Position = [77 32 184 22];
            app.ErrorLabel.Text = 'No IR match user configuration';

            % Create IRSelectDropDownLabel
            app.IRSelectDropDownLabel = uilabel(app.ChooseEnviornmentPanel);
            app.IRSelectDropDownLabel.HorizontalAlignment = 'right';
            app.IRSelectDropDownLabel.FontWeight = 'bold';
            app.IRSelectDropDownLabel.FontAngle = 'italic';
            app.IRSelectDropDownLabel.Position = [324 32 56 22];
            app.IRSelectDropDownLabel.Text = 'IR Select';

            % Create IRSelectDropDown
            app.IRSelectDropDown = uidropdown(app.ChooseEnviornmentPanel);
            app.IRSelectDropDown.Items = {};
            app.IRSelectDropDown.ValueChangedFcn = createCallbackFcn(app, @IRSelectDropDownValueChanged, true);
            app.IRSelectDropDown.FontWeight = 'bold';
            app.IRSelectDropDown.Position = [395 32 134 22];
            app.IRSelectDropDown.Value = {};

            % Create Image2
            app.Image2 = uiimage(app.SelectionTab);
            app.Image2.Position = [24 39 292 251];

            % Create SimulationTab
            app.SimulationTab = uitab(app.TabGroup);
            app.SimulationTab.Title = 'Simulation';

            % Create LoadSourceAudioFilePanel
            app.LoadSourceAudioFilePanel = uipanel(app.SimulationTab);
            app.LoadSourceAudioFilePanel.Title = 'Load Source Audio File';
            app.LoadSourceAudioFilePanel.Position = [2 235 636 221];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.LoadSourceAudioFilePanel);
            title(app.UIAxes2, 'Selected Audio File')
            xlabel(app.UIAxes2, 'Time')
            ylabel(app.UIAxes2, 'Y')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [312 8 300 185];

            % Create FileNameEditFieldLabel
            app.FileNameEditFieldLabel = uilabel(app.LoadSourceAudioFilePanel);
            app.FileNameEditFieldLabel.HorizontalAlignment = 'right';
            app.FileNameEditFieldLabel.Position = [31 127 60 22];
            app.FileNameEditFieldLabel.Text = 'File Name';

            % Create FileNameEditField
            app.FileNameEditField = uieditfield(app.LoadSourceAudioFilePanel, 'text');
            app.FileNameEditField.Position = [106 127 100 22];

            % Create LoadButton
            app.LoadButton = uibutton(app.LoadSourceAudioFilePanel, 'push');
            app.LoadButton.ButtonPushedFcn = createCallbackFcn(app, @LoadButtonPushed, true);
            app.LoadButton.Position = [224 127 82 22];
            app.LoadButton.Text = 'Load';

            % Create PlaySample
            app.PlaySample = uibutton(app.LoadSourceAudioFilePanel, 'push');
            app.PlaySample.ButtonPushedFcn = createCallbackFcn(app, @PlaySampleButtonPushed, true);
            app.PlaySample.Position = [119 63 75 22];
            app.PlaySample.Text = 'Play';

            % Create SimulatePanel
            app.SimulatePanel = uipanel(app.SimulationTab);
            app.SimulatePanel.Title = 'Simulate';
            app.SimulatePanel.Position = [2 10 628 221];

            % Create OutputGraph
            app.OutputGraph = uiaxes(app.SimulatePanel);
            title(app.OutputGraph, 'Output')
            xlabel(app.OutputGraph, 'Time')
            ylabel(app.OutputGraph, 'Y')
            zlabel(app.OutputGraph, 'Z')
            app.OutputGraph.Position = [316 9 300 185];

            % Create ApplyIRButton
            app.ApplyIRButton = uibutton(app.SimulatePanel, 'push');
            app.ApplyIRButton.ButtonPushedFcn = createCallbackFcn(app, @ApplyIRButtonPushed, true);
            app.ApplyIRButton.Position = [123 132 100 22];
            app.ApplyIRButton.Text = 'Apply IR';

            % Create ResetButton
            app.ResetButton = uibutton(app.SimulatePanel, 'push');
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);
            app.ResetButton.BackgroundColor = [0.8706 0.1294 0.1294];
            app.ResetButton.FontWeight = 'bold';
            app.ResetButton.Position = [5 7 65 25];
            app.ResetButton.Text = 'Reset';

            % Create PlayButton
            app.PlayButton = uibutton(app.SimulatePanel, 'push');
            app.PlayButton.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.PlayButton.Position = [137 70 74 22];
            app.PlayButton.Text = 'Play';

            % Create ErrorLabel_IR
            app.ErrorLabel_IR = uilabel(app.SimulatePanel);
            app.ErrorLabel_IR.FontWeight = 'bold';
            app.ErrorLabel_IR.FontAngle = 'italic';
            app.ErrorLabel_IR.FontColor = [0.902 0.3765 0.3765];
            app.ErrorLabel_IR.Visible = 'off';
            app.ErrorLabel_IR.Position = [130 104 88 22];
            app.ErrorLabel_IR.Text = 'No IR selected';

            % Create ExportButton
            app.ExportButton = uibutton(app.SimulatePanel, 'push');
            app.ExportButton.ButtonPushedFcn = createCallbackFcn(app, @ExportButtonPushed, true);
            app.ExportButton.Position = [124 28 100 23];
            app.ExportButton.Text = 'Export';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = RoomAcoustic_main_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end