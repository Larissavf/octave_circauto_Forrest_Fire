% initialize the world randomly
shared.numrows = 50;    % number of rows
shared.numcols = 100;   % number of columns

shared.world = repmat(2, [shared.numrows, shared.numcols]);

%popup window
shared.fig = figure(
  "position", [160,90,1600,900],
  "menubar", "none",
  "name", "Forest Fire model",
  "color", ([38, 38, 23] ./ 255),
  "resize", "off"
  );

% show the world
shared.axs = axes(
  "units", "pixels",
  "position", [20, 15, 1000, 870],
  "colormap", ([71, 163, 62; 211, 97, 53; 239, 239, 230] ./ 255)
);

% play stop button
shared.play_tgl = uicontrol(
  "style", "togglebutton",
  "units", "pixels",
  "position", [1132 830 350 50],
  "backgroundcolor", ([218, 234, 215] ./ 255),
  "string", "Play",
  "foregroundcolor", [0 , 0, 0.0],
  "callback", @click_play_stop,
  "tooltipstring", "Start game"
);

% step button
shared.step_btn = uicontrol(
  "style", "pushbutton",
  "units", "pixels",
  "position", [1132 775 350 50],
  "backgroundcolor", ([218, 234, 215] ./ 255),
  "string", "Step",
  "foregroundcolor", [0 , 0, 0.0],
  "callback", @click_step,
  "tooltipstring", "Step"
);

% P value slider
shared.p_value_sld = uicontrol(
  "style", "slider",
  "units", "pixels",
  "value", 0.01,
  "sliderstep", [0.0010000 0.0100000],
  "position", [1132 590 350 30],
  "backgroundcolor", [0.3, 0.4, 0.9],
  "foregroundcolor", [0 , 0, 0],
  "callback", @click_play_stop,
  "tooltipstring", "Regrow factor of the forrest"
);

%label p value slider
shared.p_value_lbl = uicontrol(
  "style", "text",
  "units", "pixels",
  "position", [1132 620 350 30],
  "string", "Regrow factor of the forrest, P",
  "fontsize", 10,
  "backgroundcolor", ([38, 38, 23] ./ 255),
  "foregroundcolor", [1, 1, 1]
);

% f value slider
shared.f_value_sld = uicontrol(
  "style", "slider",
  "units", "pixels",
  "value", 0.0001,
  "sliderstep", [0.00010000 0.00100000],
  "position", [1132 650 350 30],
  "backgroundcolor", [0.3, 0.4, 0.9],
  "foregroundcolor", [0 , 0, 0],
  "callback", @click_play_stop,
  "tooltipstring", "Fastness of forest fire spreading"
);

%label f value slider
shared.p_value_lbl = uicontrol(
  "style", "text",
  "units", "pixels",
  "position", [1132 680 350 30],
  "string", "Fastness of forest fire spreading, F",
  "fontsize", 10,
  "backgroundcolor", ([38, 38, 23] ./ 255),
  "foregroundcolor", [1, 1, 1]
);

% slider of determening the speed
shared.speed_sld = uicontrol(
  "style", "slider",
  "units", "pixels",
  "value", 0.5,
  "position", [1132 710 350 30],
  "backgroundcolor", [0.3, 0.4, 0.9],
  "foregroundcolor", [0 , 0, 0.0],
  "callback", @click_play_stop,
  "tooltipstring", "Speediness"
);

% label voor slider speed
shared.speed_lbl = uicontrol(
  "style", "text",
  "units", "pixels",
  "position", [1132 740 350 30],
  "string", "Speediness",
  "fontsize", 10,
  "backgroundcolor", ([38, 38, 23] ./ 255),
  "foregroundcolor", [1, 1, 1]
);

% clear button
shared.cl_btn = uicontrol(
  "units", "pixels",
  "style", "pushbutton",
  "position", [1132 225 175 50],
  "backgroundcolor", ([218, 234, 215] ./ 255),
  "string", "Clear",
  "foregroundcolor", [0 , 0, 0.0],
  "callback", @click_clear,
  "tooltipstring", "Clear screen"
  );

% button to make random world
shared.rnd_btn = uicontrol("units", "pixels",
  "style", "pushbutton",
  "position", [1330 225 175 50],
  "backgroundcolor", ([218, 234, 215] ./ 255),
  "string", "Random",
  "foregroundcolor", [0 , 0, 0.0],
  "callback", @click_rand,
  "tooltipstring", "Makes random beauty"
  );

% button to save file
shared.save_btn = uicontrol(
  "units", "pixels",
  "style", "pushbutton",
  "position", [1330 15 175 50],
  "backgroundcolor", ([218, 234, 215] ./ 255),
  "string", "Save",
  "foregroundcolor", [0 , 0, 0.0],
  "callback", @click_save,
  "tooltipstring", "Save the pretty world"
);

% button to load file
shared.load_btn = uicontrol(
  "units", "pixels",
  "style", "pushbutton",
  "position", [1132 15 175 50],
  "backgroundcolor", ([218, 234, 215] ./ 255),
  "string", "Load",
  "foregroundcolor", [0 , 0, 0.0],
  "callback", @click_load,
  "tooltipstring", "Load a pretty world"
);

% make colors purple
shared.color_box_prp = uicontrol(
  "units", "pixels",
  "style", "checkbox",
  "position", [1232 300 150 40],
  "backgroundcolor", ([38, 38, 23] ./ 255),
  "string", "Purple",
  "foregroundcolor", [1 , 1, 1],
  "callback", @click_color_prp,
  "tooltipstring", "Change color of the world"
);

% make colors inverse
shared.color_box_inv = uicontrol(
  "units", "pixels",
  "style", "checkbox",
  "position", [1132 300 100 40],
  "backgroundcolor", ([38, 38, 23] ./ 255),
  "string", "Inverse",
  "foregroundcolor", [1 , 1, 1],
  "callback", @click_color_inv,
  "tooltipstring", "Change color of the world"
);

% edit button
shared.edit_tgl = uicontrol(
  "style", "togglebutton",
  "units", "pixels",
  "position", [1132 530 350 50],
  "backgroundcolor", ([218, 234, 215] ./ 255),
  "string", "Edit",
  "foregroundcolor", [0 , 0, 0.0],
  "callback", @click_edit,
  "tooltipstring", "Edit world"
);

% help button
shared.help_btn = uicontrol(
  "style", "pushbutton",
  "units", "pixels",
  "position", [1555 15 30 30],
  "backgroundcolor", ([218, 234, 215] ./ 255),
  "string", "?",
  "foregroundcolor", [0 , 0, 0.0],
  "callback", @click_help,
  "tooltipstring", "Help"
);

% button to save file
shared.tree_btn = uicontrol(
  "units", "pixels",
  "style", "pushbutton",
  "position", [1230 150 175 50],
  "backgroundcolor", ([218, 234, 215] ./ 255),
  "string", "Tree",
  "foregroundcolor", [0 , 0, 0.0],
  "callback", @click_tree,
  "tooltipstring", "Make world full of tree"
);




shared.img = imagesc(shared.axs, shared.world, [0 2]);
axis(shared.axs, "off");
guidata(shared.fig, shared);

function click_step(source, event)
  %Creates next generation of world
    % source: Gui element that triggered function
    % event:  additional information (not used)
    shared = guidata(source);
    tree = get(shared.p_value_sld, "value");   % probability of a cell becoming a tree
    fire = get(shared.f_value_sld, "value"); % probability of a tree catching fire
    neighborhood = [0 1 0; 1 0 1; 0 1 0];

    world = shared.world;
    new_world = world;

  % apply the rules to update the world
  N_fire = conv2(new_world == 1, neighborhood, 'same');

  new_world(world == 0 & N_fire >= 1) = 1;
  new_world(world == 2 & rand(shared.numrows, shared.numcols) < tree) = 0;
  new_world(world == 0 & rand(shared.numrows, shared.numcols) < fire) = 1;
  new_world(world == 1) = 2;

  shared.world = new_world;
  set(shared.img, "cdata", shared.world);
  guidata(source,shared);
  drawnow;
endfunction

% makes a movie of the world and her generations
function click_play_stop(source, event)
 % Keep stepping forward until stopped
  %   source: GUI element that triggered function
  %   event:  additional information (not used)

  % Collect data
  shared = guidata(source);
  % Check whether button was pressed or released
  if get(shared.play_tgl, "value")
     % Button pressed (i.e.: "Start"): update appearance to "Stop"
    set(shared.play_tgl, "string", "Stop", "tooltipstring", "Stop animation");
    % Keep stepping forward one generation until button is released
    while ishandle(shared.play_tgl) && get(shared.play_tgl, "value");
      click_step(source, event);
      duration = (1.0 - get(shared.speed_sld, "value")) .^ 2;
      pause(duration);
    endwhile
  else
    % Button released (i.e.: "Stop"): update appearance to "Start"
    set(shared.play_tgl, "string", "Start", "tooltipstring", "Start animation");
  endif
endfunction


%Makes world clean
function click_clear(source, event)
   % clear world of user
    % source: Gui element that triggered function
    % event:  additional information (not used)
    % get data
     shared = guidata(source);
    % request
    choice = questdlg("Are you sure to clear the world?", "Confirmation", "yes", "cancel");
    if strcmp(choice, "Yes")
       if get(shared.play_tgl, "value")
        set(shared.play_tgl, "value", 0, "string", "Play", "tooltipstring", "play animaition");
        drawnow();
       endif
       % make empy world
      shared.world = repmat(2, [shared.numrows, shared.numcols]);
      set(shared.img, "cdata", shared.world);
      guidata(source, shared);
    endif
endfunction

% makes random world
function click_rand(source, event)
   % Make random world
    % source: Gui element that triggered function
    % event:  additional information (not used)

   % get data
  shared = guidata(source);
  % request
  choice = questdlg("Are you sure to clear the world?", "Confirmation", "yes", "cancel");
  if strcmp(choice, "Yes")
     if get(shared.play_tgl, "value")
      set(shared.play_tgl, "value", 0, "string", "Play", "tooltipstring", "play animaition");
      drawnow();
     endif
     % make random world
    shared.world = randi((0:2:2), shared.numrows, shared.numcols);%make random world
    shared.step2 = 0;
    set(shared.img, "cdata", shared.world);
    guidata(source, shared);
  endif
endfunction

%saves world to file
function click_save(source, event)
   % save world of user
    % source: Gui element that triggered function
    % event:  additional information (not used)
  % get data
  shared = guidata(source);
    % put file in good spot
    filename = uiputfile(
      {"*.bmp;*.gif;*.png", "Supported image formats"; "*.csv;*.txt", "Supported text data formats"},
      "Choose filename");
    if (length(filename) > 4)
      % get data
      shared = guidata(source);
      if strcmpi(filename(end-3 : end), ".bmp") || strcmpi(filename(end-3 : end), ".gif") ...
        || strcmpi(filename(end-3 : end), ".png") % if correct end
        colormap = get(shared.display_axs, "colormap");
        imwrite(uint8(shared.world), colormap, filename)   % write world to file
      elseif strcmpi(filename(end-3 : end), ".csv") || strcmpi(filename(end-3 : end), ".txt")  % if correct end
        csvwrite(filename, uint8(shared.world))
      else
        msgbox("Wrong type of file can only use .bmp, .gif or .png as image and .csv and txt for text", "Wrong type file")
      endif
    endif
  endfunction


function click_load(source, event)
  % Load the world from file (callback function)
  %   source: GUI element that triggered function
  %   event:  additional information (not used)

  % Get filename from user
  [filename, filepath] = uigetfile(
    {"*.csv;*.txt", "Supported text data formats"},
    "Choose file");
  % Check if a valid file was chosen
  if ischar(filename) && ischar(filepath)
    shared = guidata(source); 
    % Load text data file
    if strcmpi(filename(end-3 : end), ".csv") || ...
       strcmpi(filename(end-3 : end), ".txt")
      shared.world = csvread(fullfile(filepath, filename));
      % Update figure and attached data
      set(shared.img, "cdata", shared.world);
      guidata(source, shared);
    end
  end
end
function click_color_inv(source, event)
   % change color of world to inverse
    % source: Gui element that triggered function
    % event:  additional information (not used)

  % get data
  shared = guidata(source);
  % if the other color box is on
  if get(shared.color_box_prp, "value")
    set(shared.color_box_prp, "value", "0")
  endif
  if get(shared.color_box_inv, "value")
    set(shared.axs, "colormap", ([211, 97, 53; 76, 108, 35; 239, 239, 230] ./ 255)) % make world inverse
  else
    set(shared.axs, "colormap", ([76, 108, 35; 211, 97, 53; 239, 239, 230] ./ 255))  % make world normal
  endif
  guidata(source, shared);
endfunction

function click_color_prp(source, event)
   % change color of world to less purple tint
    % source: Gui element that triggered function
    % event:  additional information (not used)

  % get data
  shared = guidata(source);
  % if the other color box is on
  if get(shared.color_box_inv, "value")
    set(shared.color_box_inv, "value", "0")
  endif
  if get(shared.color_box_prp, "value")
    set(shared.axs, "colormap", ([ 153, 143, 199 ; 57, 54, 69; 247, 241, 249] ./ 255)) % make world purple
  else
    set(shared.axs, "colormap", ([76, 108, 35; 211, 97, 53; 239, 239, 230] ./ 255)) % make world normal
  endif
endfunction

%Makes world edit
function click_edit(source, event)
   % edit world of user
    % source: Gui element that triggered function
    % event:  additional information (not used)
    % get data
     shared = guidata(source);

     msgbox("If you want to quit editing, press ENTER", "Close edit")
     % set world on pause
       if get(shared.play_tgl, "value")
        set(shared.play_tgl, "value", 0, "string", "Play", "tooltipstring", "play animaition");
        drawnow();
       endif
       % deactivate step en play button
       set(shared.step_btn, "enable", "off", "backgroundcolor", ([51, 51, 31]/ 255))
       set(shared.play_tgl, "enable", "off", "backgroundcolor", ([51, 51, 31]/ 255))
       % edit world
       do
        [x, y, btn] = ginput(1);
        disp(x)
        disp(y)
        row = round(y);
        col = round(x);
        if row > 0 && row <= rows(shared.world) && col > 0 && col <= columns(shared.world)
          % left button is tree
          if btn == 1 && shared.world(row,col) != 0
            shared.world(row, col) = 0;
          elseif btn == 1 && shared.world(row,col) == 0
            shared.world(row, col) = 2;
          % right button is fire
          elseif btn == 3 && shared.world(row,col) != 1
            shared.world(row, col) = 1;
          elseif btn == 3 && shared.world(row,col) == 1
            shared.world(row, col) = 2;
          endif
          % update world
          set(shared.img, "cdata", shared.world);
          guidata(source, shared);
        endif
       until isempty(x)
       %undo edit tgl
       set(shared.edit_tgl, "value", 0);
       % reactivate step en play button
       set(shared.step_btn, "enable", "on", "backgroundcolor", ([218, 234, 215] ./ 255));
       set(shared.play_tgl, "enable", "on", "backgroundcolor", ([218, 234, 215] ./ 255));
    set(shared.img, "cdata", shared.world); % world full with tree
    guidata(source, shared);
endfunction

function click_help(source, event)
   % go to help
    % source: Gui element that triggered function
    % event:  additional information (not used)
    web("http://langers.nl/wiki/doku.php?id=forest_fire_2023:welkom#welkom")
endfunction

function  click_tree(source, event)
   % world full of tree
    % source: Gui element that triggered function
    % event:  additional information (not used)
    % get data
     shared = guidata(source);
     %stop playing
     if get(shared.play_tgl, "value")
      set(shared.play_tgl, "value", 0, "string", "Play", "tooltipstring", "play animaition");
      drawnow();
     endif
     %request
     choice = questdlg("Are you sure to clear the world?", "Confirmation", "yes", "cancel");
     if strcmp(choice, "Yes")
    shared.world = zeros(shared.numrows, shared.numcols)
    set(shared.img, "cdata", zeros(shared.numrows, shared.numcols)); % world full with tree
    guidata(source, shared);
    endif

endfunction
