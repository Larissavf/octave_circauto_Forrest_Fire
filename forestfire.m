numrows = 50;    % number of rows
numcols = 100;   % number of columns



% 2 = leeg
% 1 = vuur
% 0 = boom
% 3 = bes
#world = zeros(numrows, numcols);  % 0: white, 1: green, 2: orange, 3: red/black
world = repmat(2, [numrows, numcols]);
neighborhood = [0 1 0; 1 0 1; 0 1 0];



tree = 0.001;   % probability of a cell becoming a tree
fire = 0.0001;  % probability of a tree catching fire

while (1)
 new_world = world;
 #stop = true;
  % apply the rules to update the world
  N_fire = conv2(new_world == 1, neighborhood, 'same');
    
    
  new_world(world == 0 & N_fire >= 1) = 1;
  new_world(world == 2 & rand(numrows, numcols) < tree) = 0;
  new_world(world == 0 & rand(numrows, numcols) < fire) = 1;
  new_world(world == 1) = 2;



  world = new_world;
  colormap([0 1 0 ;1 0 0 ; 1 1 1]);  % green, red, white
  imagesc(world, [0 2]);
  drawnow;
end
