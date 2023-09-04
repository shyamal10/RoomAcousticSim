classdef RoomAcoustic_main_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        HomeTab                         matlab.ui.container.Tab
        InstructionsPanel               matlab.ui.container.Panel
        SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3  matlab.ui.control.Label
        SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2  matlab.ui.control.Label
        SetdesiredsizeofenviornemntinConfigurepanelandclickLabel  matlab.ui.control.Label
        DirectionsLabel                 matlab.ui.control.Label
        ThisisanacousticroomsimulatorusingOpenAIRIRLabel  matlab.ui.control.Label
        WelcomePanel                    matlab.ui.container.Panel
        AcousticSimulatorLabel          matlab.ui.control.Label
        Image                           matlab.ui.control.Image
        ConfigureTab                    matlab.ui.container.Tab
        SimulateButton                  matlab.ui.control.Button
        SourceRecieverCoordinatesPanel  matlab.ui.container.Panel
        recYSpinner                     matlab.ui.control.Spinner
        YSpinner_2Label                 matlab.ui.control.Label
        recZSpinner                     matlab.ui.control.Spinner
        ZSpinner_2Label                 matlab.ui.control.Label
        recXSpinner                     matlab.ui.control.Spinner
        XSpinner_2Label                 matlab.ui.control.Label
        sourceZSpinner                  matlab.ui.control.Spinner
        ZSpinnerLabel                   matlab.ui.control.Label
        sourceYSpinner                  matlab.ui.control.Spinner
        YSpinnerLabel                   matlab.ui.control.Label
        sourceXSpinner                  matlab.ui.control.Spinner
        XSpinnerLabel                   matlab.ui.control.Label
        RecieveroLabel                  matlab.ui.control.Label
        SourcexLabel                    matlab.ui.control.Label
        RoomSizeParametersPanel         matlab.ui.container.Panel
        HeightSlider                    matlab.ui.control.Slider
        HeightSliderLabel               matlab.ui.control.Label
        DepthSlider                     matlab.ui.control.Slider
        DepthSlider_2Label              matlab.ui.control.Label
        WidthSlider_2Label              matlab.ui.control.Label
        WidthSlider                     matlab.ui.control.Slider
        ParametersPanel                 matlab.ui.container.Panel
        UIAxes                          matlab.ui.control.UIAxes
        SelectionTab                    matlab.ui.container.Tab
        Image2                          matlab.ui.control.Image
        ChooseEnviornmentPanel          matlab.ui.container.Panel
        ErrorLabel                      matlab.ui.control.Label
        SelectModeListBox               matlab.ui.control.ListBox
        SelectModeListBoxLabel          matlab.ui.control.Label
        envSelect                       matlab.ui.control.DropDown
        EnviornementSelectDropDownLabel  matlab.ui.control.Label
        UIAxes4                         matlab.ui.control.UIAxes
        SimulationTab                   matlab.ui.container.Tab
        SimulatePanel                   matlab.ui.container.Panel
        ResetButton                     matlab.ui.control.Button
        SimulatePlayAudioButton         matlab.ui.control.Button
        UIAxes3                         matlab.ui.control.UIAxes
        LoadAudioFilePanel              matlab.ui.container.Panel
        LoadAudioButton                 matlab.ui.control.Button
        FileNameEditField               matlab.ui.control.EditField
        FileNameEditFieldLabel          matlab.ui.control.Label
        UIAxes2                         matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        dropdown = [] % Drop down options 
    end
    
    methods (Access = private)
        
        function returnOptions(app,Uwidth,Udepth,Uheight,U_sr_distance)
             % Return array of rooms based on configuration 
            options = []; %dropdown options array
            %database
    
            %1st Baptist Nashivlles
            nashville = struct();
            nashville.width = 15; %inmeters
            nashville.depth = 24;
            nashville.height = 15;
            nashville.srdist = [18 26 30]; %close, far wide, balcony
    
            %elveden-hall-suffolk-england
            elveden_hall = struct();
            elveden_hall.width = 20;
            elveden_hall.depth = 30;
            elveden_hall.height = 10;
            elveden_hall.srdist = [6 2 2 4]; %1a 3a 4a 18a
    
            %Hamilton-Mausoleum
            hamilton = struct();
            hamilton.width = 30;
            hamilton.depth = 25;
            hamilton.height = 37;
            hamilton.srdist = [4.7];
    
            %heslington-church-vaa-group-2
            heslington = struct();
            heslington.width = 12;
            heslington.depth = 12;
            heslington.height = 12;
            heslington.srdist = [4.5 5 4.1 4.5 11 12.1];
    
            %maes-howe
            maes_howe = struct();
            maes_howe.width = 12;
            maes_howe.depth = 12;
            maes_howe.height = 12;
            maes_howe.srdist = [2 2];
    
            %Main enviornment struct to hold nested structs
            env = struct();
            env.("nashville") = nashville;
            env.("elveden_hall") = elveden_hall;
            env.("hamilton") = hamilton;
            env.("heslington") = heslington;
            env.("maes_howe") = maes_howe;
    
            %Suggestion algorithm
            fn = fieldnames(env); %returns keys in database
            tol = 3;
            %dropdown = [];
            for k=1:numel(fn)
                room = string(fn{k});
                isWidthWithinRange = (Uwidth >= env.(room).width - tol) && ...
                    (Uwidth <= env.(room).width + tol);
                isDepthWithinRange = (Udepth >= env.(room).depth - tol) && ...
                    (Udepth <= env.(room).depth + tol);
                isHeightWithinRange = (Uheight >= env.(room).height - tol) && ...
                    (Uheight <= env.(room).height + tol);
    
                if (isWidthWithinRange && isDepthWithinRange && isHeightWithinRange)
                    % check source/reciever distances
                    a = 1;
                    arr = env.(room).srdist;
                    for a=1:numel(arr)
                        val = arr(a);
                        isSRwithinRange = (U_sr_distance >= (val - 1)) && ...
                            (U_sr_distance <= (val + 1));
                        if isSRwithinRange
                            options = [options string(room)]; %with IR info
                            %app.dropdown = [options string(room)]; %just room name
                        end
                    end
                    %         if isfield(env.(room),SRHeight)
                    %
                    %
                    %         end
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
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: SimulateButton
        function SimulateButtonPushed(app, event)
    
            %Write data into properties
            Width = app.WidthSlider.Value;
            Depth = app.DepthSlider.Value;
            Height = app.HeightSlider.Value;
            
            sourceCoord = [app.sourceXSpinner.Value, app.sourceYSpinner.Value, app.sourceZSpinner.Value];
            receiverCoord = [app.recXSpinner.Value,app.recYSpinner.Value,app.recZSpinner.Value];
            
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
            %set(app.UIAxes,gca,"View",[-28,35]); % set the azimuth and elevation of the plot
            for k=1:length(X)-1
                plot3(app.UIAxes, [X(k);X(k)],[Y(k);Y(k)],[0;roomDimensions(3)],"k","LineWidth",1.5);
            end
            plot3(app.UIAxes,sourceCoord(1),sourceCoord(2),sourceCoord(3),"bx","LineWidth",2)
            plot3(app.UIAxes,receiverCoord(1),receiverCoord(2),receiverCoord(3),"ro","LineWidth",2)

            hold(app.UIAxes,'off');
            %plot3(app.UIAxes,Width,Height,Depth,'.')

            %Update options list based on user input
            returnOptions(app,Width,Depth,Height,dist);
%             if isempty(app.dropdown2)
%                 app.ErrorLabel.HandleVisibility('on');
%             end
            
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

            % Create WelcomePanel
            app.WelcomePanel = uipanel(app.HomeTab);
            app.WelcomePanel.Title = 'Welcome';
            app.WelcomePanel.Position = [9 212 605 233];

            % Create Image
            app.Image = uiimage(app.WelcomePanel);
            app.Image.Position = [273 -56 324 324];
            app.Image.ImageSource = 'Dawn-over-the-Minack-1-1.jpg';

            % Create AcousticSimulatorLabel
            app.AcousticSimulatorLabel = uilabel(app.WelcomePanel);
            app.AcousticSimulatorLabel.FontName = 'Cambria';
            app.AcousticSimulatorLabel.FontSize = 24;
            app.AcousticSimulatorLabel.FontWeight = 'bold';
            app.AcousticSimulatorLabel.FontAngle = 'italic';
            app.AcousticSimulatorLabel.Position = [27 107 214 32];
            app.AcousticSimulatorLabel.Text = ' Acoustic Simulator';

            % Create InstructionsPanel
            app.InstructionsPanel = uipanel(app.HomeTab);
            app.InstructionsPanel.Title = 'Instructions';
            app.InstructionsPanel.Position = [11 28 605 185];

            % Create ThisisanacousticroomsimulatorusingOpenAIRIRLabel
            app.ThisisanacousticroomsimulatorusingOpenAIRIRLabel = uilabel(app.InstructionsPanel);
            app.ThisisanacousticroomsimulatorusingOpenAIRIRLabel.FontName = 'Cambria';
            app.ThisisanacousticroomsimulatorusingOpenAIRIRLabel.FontAngle = 'italic';
            app.ThisisanacousticroomsimulatorusingOpenAIRIRLabel.Position = [12 127 277 22];
            app.ThisisanacousticroomsimulatorusingOpenAIRIRLabel.Text = 'This is an acoustic room simulator using Open AIR IR. ';

            % Create DirectionsLabel
            app.DirectionsLabel = uilabel(app.InstructionsPanel);
            app.DirectionsLabel.FontName = 'Cambria';
            app.DirectionsLabel.FontAngle = 'italic';
            app.DirectionsLabel.Position = [13 87 56 22];
            app.DirectionsLabel.Text = 'Directions';

            % Create SetdesiredsizeofenviornemntinConfigurepanelandclickLabel
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel = uilabel(app.InstructionsPanel);
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel.FontName = 'Cambria';
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel.FontAngle = 'italic';
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel.Position = [20 63 365 22];
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel.Text = '1. Set desired size of enviornemnt in Configure panel, and click simulate';

            % Create SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2 = uilabel(app.InstructionsPanel);
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2.FontName = 'Cambria';
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2.FontAngle = 'italic';
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2.Position = [20 35 556 22];
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_2.Text = '2. Select desired enviornement stage (suggestions will be populated based on user selection in Configuration)';

            % Create SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3 = uilabel(app.InstructionsPanel);
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3.FontName = 'Cambria';
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3.FontAngle = 'italic';
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3.Position = [20 5 376 22];
            app.SetdesiredsizeofenviornemntinConfigurepanelandclickLabel_3.Text = '3. Simulate the enviornemnt with a chosen audio file by clicking simulate!';

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
            app.UIAxes.Position = [124 222 377 227];

            % Create ParametersPanel
            app.ParametersPanel = uipanel(app.ConfigureTab);
            app.ParametersPanel.Title = 'Parameters';
            app.ParametersPanel.Position = [10 1 521 221];

            % Create RoomSizeParametersPanel
            app.RoomSizeParametersPanel = uipanel(app.ConfigureTab);
            app.RoomSizeParametersPanel.Title = 'Room Size Parameters';
            app.RoomSizeParametersPanel.Position = [16 10 242 182];

            % Create WidthSlider
            app.WidthSlider = uislider(app.RoomSizeParametersPanel);
            app.WidthSlider.Position = [76 134 138 3];

            % Create WidthSlider_2Label
            app.WidthSlider_2Label = uilabel(app.RoomSizeParametersPanel);
            app.WidthSlider_2Label.HorizontalAlignment = 'right';
            app.WidthSlider_2Label.Position = [20 111 36 22];
            app.WidthSlider_2Label.Text = 'Width';

            % Create DepthSlider_2Label
            app.DepthSlider_2Label = uilabel(app.RoomSizeParametersPanel);
            app.DepthSlider_2Label.HorizontalAlignment = 'right';
            app.DepthSlider_2Label.Position = [15 60 38 22];
            app.DepthSlider_2Label.Text = 'Depth';

            % Create DepthSlider
            app.DepthSlider = uislider(app.RoomSizeParametersPanel);
            app.DepthSlider.Position = [70 80 144 3];

            % Create HeightSliderLabel
            app.HeightSliderLabel = uilabel(app.RoomSizeParametersPanel);
            app.HeightSliderLabel.HorizontalAlignment = 'right';
            app.HeightSliderLabel.Position = [11 20 40 22];
            app.HeightSliderLabel.Text = 'Height';

            % Create HeightSlider
            app.HeightSlider = uislider(app.RoomSizeParametersPanel);
            app.HeightSlider.Position = [68 31 154 3];

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

            % Create XSpinnerLabel
            app.XSpinnerLabel = uilabel(app.SourceRecieverCoordinatesPanel);
            app.XSpinnerLabel.HorizontalAlignment = 'right';
            app.XSpinnerLabel.Position = [25 99 25 22];
            app.XSpinnerLabel.Text = 'X';

            % Create sourceXSpinner
            app.sourceXSpinner = uispinner(app.SourceRecieverCoordinatesPanel);
            app.sourceXSpinner.Limits = [0 50];
            app.sourceXSpinner.Position = [65 99 47 22];

            % Create YSpinnerLabel
            app.YSpinnerLabel = uilabel(app.SourceRecieverCoordinatesPanel);
            app.YSpinnerLabel.HorizontalAlignment = 'right';
            app.YSpinnerLabel.Position = [26 62 25 22];
            app.YSpinnerLabel.Text = 'Y';

            % Create sourceYSpinner
            app.sourceYSpinner = uispinner(app.SourceRecieverCoordinatesPanel);
            app.sourceYSpinner.Limits = [0 50];
            app.sourceYSpinner.Position = [66 62 47 22];

            % Create ZSpinnerLabel
            app.ZSpinnerLabel = uilabel(app.SourceRecieverCoordinatesPanel);
            app.ZSpinnerLabel.HorizontalAlignment = 'right';
            app.ZSpinnerLabel.Position = [26 29 25 22];
            app.ZSpinnerLabel.Text = 'Z';

            % Create sourceZSpinner
            app.sourceZSpinner = uispinner(app.SourceRecieverCoordinatesPanel);
            app.sourceZSpinner.Limits = [0 10];
            app.sourceZSpinner.Position = [66 29 47 22];

            % Create XSpinner_2Label
            app.XSpinner_2Label = uilabel(app.SourceRecieverCoordinatesPanel);
            app.XSpinner_2Label.HorizontalAlignment = 'right';
            app.XSpinner_2Label.Position = [150 98 25 22];
            app.XSpinner_2Label.Text = 'X';

            % Create recXSpinner
            app.recXSpinner = uispinner(app.SourceRecieverCoordinatesPanel);
            app.recXSpinner.Limits = [0 50];
            app.recXSpinner.Position = [190 98 47 22];

            % Create ZSpinner_2Label
            app.ZSpinner_2Label = uilabel(app.SourceRecieverCoordinatesPanel);
            app.ZSpinner_2Label.HorizontalAlignment = 'right';
            app.ZSpinner_2Label.Position = [151 28 25 22];
            app.ZSpinner_2Label.Text = 'Z';

            % Create recZSpinner
            app.recZSpinner = uispinner(app.SourceRecieverCoordinatesPanel);
            app.recZSpinner.Limits = [0 50];
            app.recZSpinner.Position = [191 28 47 22];

            % Create YSpinner_2Label
            app.YSpinner_2Label = uilabel(app.SourceRecieverCoordinatesPanel);
            app.YSpinner_2Label.HorizontalAlignment = 'right';
            app.YSpinner_2Label.Position = [151 61 25 22];
            app.YSpinner_2Label.Text = 'Y';

            % Create recYSpinner
            app.recYSpinner = uispinner(app.SourceRecieverCoordinatesPanel);
            app.recYSpinner.Limits = [0 50];
            app.recYSpinner.Position = [191 61 47 22];

            % Create SimulateButton
            app.SimulateButton = uibutton(app.ConfigureTab, 'push');
            app.SimulateButton.ButtonPushedFcn = createCallbackFcn(app, @SimulateButtonPushed, true);
            app.SimulateButton.Position = [544 82 87 22];
            app.SimulateButton.Text = 'Simulate';

            % Create SelectionTab
            app.SelectionTab = uitab(app.TabGroup);
            app.SelectionTab.Title = 'Selection';

            % Create UIAxes4
            app.UIAxes4 = uiaxes(app.SelectionTab);
            title(app.UIAxes4, 'Loaded IR Response')
            xlabel(app.UIAxes4, 'Time')
            ylabel(app.UIAxes4, 'Y')
            zlabel(app.UIAxes4, 'Z')
            app.UIAxes4.Position = [319 41 300 229];

            % Create ChooseEnviornmentPanel
            app.ChooseEnviornmentPanel = uipanel(app.SelectionTab);
            app.ChooseEnviornmentPanel.Title = 'Choose Enviornment';
            app.ChooseEnviornmentPanel.Position = [2 302 637 154];

            % Create EnviornementSelectDropDownLabel
            app.EnviornementSelectDropDownLabel = uilabel(app.ChooseEnviornmentPanel);
            app.EnviornementSelectDropDownLabel.HorizontalAlignment = 'right';
            app.EnviornementSelectDropDownLabel.FontWeight = 'bold';
            app.EnviornementSelectDropDownLabel.Position = [293 81 124 22];
            app.EnviornementSelectDropDownLabel.Text = 'Enviornement Select';

            % Create envSelect
            app.envSelect = uidropdown(app.ChooseEnviornmentPanel);
            app.envSelect.Items = {};
            app.envSelect.Position = [432 81 161 22];
            app.envSelect.Value = {};

            % Create SelectModeListBoxLabel
            app.SelectModeListBoxLabel = uilabel(app.ChooseEnviornmentPanel);
            app.SelectModeListBoxLabel.HorizontalAlignment = 'right';
            app.SelectModeListBoxLabel.Position = [22 82 72 22];
            app.SelectModeListBoxLabel.Text = 'Select Mode';

            % Create SelectModeListBox
            app.SelectModeListBox = uilistbox(app.ChooseEnviornmentPanel);
            app.SelectModeListBox.Items = {'Suggestion Mode', 'All Options'};
            app.SelectModeListBox.Position = [109 63 137 43];
            app.SelectModeListBox.Value = 'Suggestion Mode';

            % Create ErrorLabel
            app.ErrorLabel = uilabel(app.ChooseEnviornmentPanel);
            app.ErrorLabel.FontWeight = 'bold';
            app.ErrorLabel.FontAngle = 'italic';
            app.ErrorLabel.FontColor = [0.902 0.3765 0.3765];
            app.ErrorLabel.Visible = 'off';
            app.ErrorLabel.Position = [70 27 184 22];
            app.ErrorLabel.Text = 'No IR match user configuration';

            % Create Image2
            app.Image2 = uiimage(app.SelectionTab);
            app.Image2.Position = [24 39 292 251];

            % Create SimulationTab
            app.SimulationTab = uitab(app.TabGroup);
            app.SimulationTab.Title = 'Simulation';

            % Create LoadAudioFilePanel
            app.LoadAudioFilePanel = uipanel(app.SimulationTab);
            app.LoadAudioFilePanel.Title = 'Load Audio File';
            app.LoadAudioFilePanel.Position = [2 235 636 221];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.LoadAudioFilePanel);
            title(app.UIAxes2, 'Selected Audio File')
            xlabel(app.UIAxes2, 'Time')
            ylabel(app.UIAxes2, 'Y')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [312 8 300 185];

            % Create FileNameEditFieldLabel
            app.FileNameEditFieldLabel = uilabel(app.LoadAudioFilePanel);
            app.FileNameEditFieldLabel.HorizontalAlignment = 'right';
            app.FileNameEditFieldLabel.Position = [30 148 60 22];
            app.FileNameEditFieldLabel.Text = 'File Name';

            % Create FileNameEditField
            app.FileNameEditField = uieditfield(app.LoadAudioFilePanel, 'text');
            app.FileNameEditField.Position = [105 148 100 22];

            % Create LoadAudioButton
            app.LoadAudioButton = uibutton(app.LoadAudioFilePanel, 'push');
            app.LoadAudioButton.Position = [115 99 69 22];
            app.LoadAudioButton.Text = 'Load Audio';

            % Create SimulatePanel
            app.SimulatePanel = uipanel(app.SimulationTab);
            app.SimulatePanel.Title = 'Simulate';
            app.SimulatePanel.Position = [2 10 628 221];

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.SimulatePanel);
            title(app.UIAxes3, 'Output')
            xlabel(app.UIAxes3, 'Time')
            ylabel(app.UIAxes3, 'Y')
            zlabel(app.UIAxes3, 'Z')
            app.UIAxes3.Position = [316 9 300 185];

            % Create SimulatePlayAudioButton
            app.SimulatePlayAudioButton = uibutton(app.SimulatePanel, 'push');
            app.SimulatePlayAudioButton.Position = [92 93 133 22];
            app.SimulatePlayAudioButton.Text = 'Simulate + Play Audio';

            % Create ResetButton
            app.ResetButton = uibutton(app.SimulatePanel, 'push');
            app.ResetButton.Position = [109 32 100 22];
            app.ResetButton.Text = 'Reset';

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