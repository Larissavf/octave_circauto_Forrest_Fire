% initialize the world randomly
numrows = 50;    % number of rows
numcols = 100;   % number of columns

shared.world = repmat(2, [numrows, numcols]);

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
  "colormap", ([76, 108, 35; 211, 97, 53; 239, 239, 230] ./ 255)
);

% play stop button
shared.play_tgl = uicontrol(
  "style", "togglebutton",
  "units", "pixels",
  "position", [1132 830 350 50],
  "backgroundcolor", ([218, 234, 215] ./ 255),
  "string", "play",
  "foregroundcolor", [0 , 0, 0.0],
  "callback", @click_play_stop,
  "tooltipstring", "Start game"
);

% P value slider
shared.p_value_sld = uicontrol(
  "style", "slider",
  "units", "pixels",
  "value", 0.01,
  "sliderstep", [0.0010000 0.0100000],
  "position", [1132 620 350 30],
  "backgroundcolor", [0.3, 0.4, 0.9],
  "foregroundcolor", [0 , 0, 0],
  "callback", @click_play_stop,
  "tooltipstring", "Regrow factor of the forrest"
);

%label p value slider
shared.p_value_lbl = uicontrol(
  "style", "text",
  "units", "pixels",
  "position", [1132 650 350 30],
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
  "position", [1132 690 350 30],
  "backgroundcolor", [0.3, 0.4, 0.9],
  "foregroundcolor", [0 , 0, 0],
  "callback", @click_play_stop,
  "tooltipstring", "fastness of forest fire spreading"
);

%label f value slider
shared.p_value_lbl = uicontrol(
  "style", "text",
  "units", "pixels",
  "position", [1132 720 350 30],
  "string", "fastness of forest fire spreading, F",
  "fontsize", 10,
  "backgroundcolor", ([38, 38, 23] ./ 255),
  "foregroundcolor", [1, 1, 1]
);

% slider of determening the speed
shared.speed_sld = uicontrol(
  "style", "slider",
  "units", "pixels",
  "value", 0.5,
  "position", [1132 760 350 30],
  "backgroundcolor", [0.3, 0.4, 0.9],
  "foregroundcolor", [0 , 0, 0.0],
  "callback", @click_playstop,
  "tooltipstring", "Speediness"
);

% label voor slider speed
shared.speed_lbl = uicontrol(
  "style", "text",
  "units", "pixels",
  "position", [1132 790 350 30],
  "string", "speediness",
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
  "tooltipstring", "change color of the world"
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
  "tooltipstring", "change color of the world"
);

shared.img = imagesc(shared.axs, shared.world, [0 2]);
axis(shared.axs, "off");
guidata(shared.fig, shared);


function click_step(source, event)

  %Creates next generation of world
    % source: Gui element that triggered function
    % event:  additional information (not used)
    shared = guidata(source);
    numrows = 50;    % number of rows
    numcols = 100;   % number of columns
    tree = get(shared.p_value_sld, "value");   % probability of a cell becoming a tree
    fire = get(shared.f_value_sld, "value"); % probability of a tree catching fire
    neighborhood = [0 1 0; 1 0 1; 0 1 0];

    world = shared.world;
    new_world = world;

  % apply the rules to update the world
  N_fire = conv2(new_world == 1, neighborhood, 'same');
    
    
  new_world(world == 0 & N_fire >= 1) = 1;
  new_world(world == 2 & rand(numrows, numcols) < tree) = 0;
  new_world(world == 0 & rand(numrows, numcols) < fire) = 1;
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
    while ishandle(shared.play_tgl) && get(shared.play_tgl, "value")
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
      shared.world = repmat(2, [numrows, numcols]);
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
    shared.world = (rand(100, 60) < 1/8);%make ff random worlddd
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
  %load file to display
    % Load world of user
    % source: Gui element that triggered function
    % event:  additional information (not used)
    % is the game on
  % get data
  shared = guidata(source);
  % get file
  file = uigetfile("*.csv", "Selecteer file");
  %open file
  shared.world = csvread(file);
  if shared.world == 1 | shared.world == 0 % check if file is ok
    % show file in gui
    set(shared.img, "cdata", shared.world);
    shared = guidata(source, shared);
  else
    msgbox("Wrong file can only have 1 and 0 as content", "Wrong content")
  endif

endfunction

function click_color_inv(source, event)
   % change color of world to inverse
    % source: Gui element that triggered function
    % event:  additional information (not used)

  % get data
  shared = guidata(source);
  if get(shared.color_box_inv, "value")
    set(shared.axs, "colormap", ([211, 97, 53; 76, 108, 35; 239, 239, 230] ./ 255)) % make world inverse
  else
    set(shared.axs, "colormap", ([76, 108, 35; 211, 97, 53; 239, 239, 230] ./ 255))  % make world normal
  endif
endfunction

function click_color_prp(source, event)
   % change color of world to less purple tint
    % source: Gui element that triggered function
    % event:  additional information (not used)

  % get data
  shared = guidata(source);
  if get(shared.color_box_prp, "value")
    set(shared.axs, "colormap", ([ 153, 143, 199 ; 57, 54, 69; 247, 241, 249] ./ 255)) % make world purple
  else
    set(shared.axs, "colormap", ([76, 108, 35; 211, 97, 53; 239, 239, 230] ./ 255)) % make world normal
  endif
endfunction
