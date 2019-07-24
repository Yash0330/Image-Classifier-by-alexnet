% change str to 1,2,3,.... for saving  upto how many iamge types you want to save for saving in respective folders for 
% imwrite in line 89

str = '1';

% Create the webcam object.
cam = webcam();

% Capture one frame to get its size.
videoFrame = snapshot(cam);
frameSize = size(videoFrame);

% Create the video player object.
videoPlayer = vision.VideoPlayer('Position', [100 100 [frameSize(2), frameSize(1)]+30]);
runLoop = true;
frameCount = 0;
i=1;

while runLoop && frameCount < 300

    % Get the next frame.
    videoFrame = snapshot(cam);
    videoFrameGray = rgb2gray(videoFrame);
    frameCount = frameCount + 1;
    
    imwrite(videoFrame,[ 'photos\',str,'\',int2str(i), '.jpg']);
    i = i+1; 
    
    % Display the annotated video frame using the video player object.
    step(videoPlayer, videoFrame);

    % Check whether the video player window has been closed.
    runLoop = isOpen(videoPlayer);
end

% Clean up.
clear cam;
release(videoPlayer);