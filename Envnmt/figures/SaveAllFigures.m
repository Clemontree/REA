function SaveAllFigures(path)
% Folder = fullfile(pwd, path);
Folder = path
AllFigH = allchild(groot);
for iFig = 1:numel(AllFigH)
  fig = AllFigH(iFig);
  if ~isempty(fig.CurrentAxes)
  ax  = fig.CurrentAxes;
  ax.FontSize = 17;
  end
  fig.PaperUnits = 'centimeter';
  fig.PaperPosition = [0 0 29.7 21];
  FileName = [fig.Name, '.png'];
  saveas(fig, fullfile(Folder, FileName));
end
end