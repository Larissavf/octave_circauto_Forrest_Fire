numrows = 50;    % number of rows
numcols = 100;   % number of columns

% initialize the world randomly
world = zeros(numrows, numcols);  % 0: white, 1: green, 2: oranje 3;rood zwart


tree = 0.01;   % probability of a cell becoming a tree
fire = 0.0001;  % probability of a tree catching fire

while (1),
  % apply the rules to update the world
  new_world = world;
  for row = 1:numrows
    for col = 1:numcols
      currentpixel = world(row, col);
      neighbors = world(max(row-1,1):min(row+1,numrows), max(col-1,1):min(col+1,numcols));
      greenneighbors = sum(neighbors(:) == 1);
      redneighbors = sum(neighbors(:) == 2);
      if currentpixel == 1 && redneighbors >= 1
        new_world(row, col) = 2;  % Tree lights on fire
      elseif currentpixel == 0
        if rand() < tree
          new_world(row,col) = 1;  % Becomes a tree
        end
      elseif currentpixel == 1
        if rand() < fire
          new_world(row,col) = 2;  % Lights on fire
        end
      elseif currentpixel == 2
        new_world(row, col) = 0;  % Cell died
      end
    end
  end
  world = new_world;
  colormap([1 1 1; 0 1 0; 1 0 0]);  % white, green, red
  imagesc(world, [0 2]);
  drawnow;
end
