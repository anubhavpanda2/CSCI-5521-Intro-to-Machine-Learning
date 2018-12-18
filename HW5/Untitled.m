VideoReader('record.avi');
   ii = 1;
   workingDir = "C:\Users\anubh\Downloads\HW5\New folder";
   while hasFrame(shuttleVideo)
      img = readFrame(shuttleVideo);
      filename = [sprintf('%04d',ii) '.png'];
      fullname = fullfile(workingDir,filename);
      imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
      ii = ii+1;
   end