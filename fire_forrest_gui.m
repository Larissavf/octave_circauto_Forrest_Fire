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
  "colormap", ([134, 188, 78; 0, 0, 0] ./ 255)
);

% on/of button
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
  "position", [1132 760 350 30],
  "backgroundcolor", [0.3, 0.4, 0.9],
  "foregroundcolor", [0 , 0, 0],
  "callback", @click_play_stop,
  "tooltipstring", "Regrow factor of the forrest"
);

%label p value slider
shared.p_value_lbl = uicontrol(
  "style", "text",
  "units", "pixels",
  "position", [1132 790 350 30],
  "string", "Regrow factor of the forrest",
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
  "position", [1132 620 350 30],
  "backgroundcolor", [0.3, 0.4, 0.9],
  "foregroundcolor", [0 , 0, 0.0],
  "callback", @click_playstop,
  "tooltipstring", "Speediness"
);

% label voor slider speed
shared.speed_lbl = uicontrol(
  "style", "text",
  "units", "pixels",
  "position", [1132 650 350 30],
  "string", "speediness",
  "fontsize", 10,
  "backgroundcolor", ([38, 38, 23] ./ 255),
  "foregroundcolor", [1, 1, 1]
);
