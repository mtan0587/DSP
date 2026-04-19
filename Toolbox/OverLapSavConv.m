function sigOut = OverLapSavConv(sigIn, hFilt, blockSize)

% ensure sigIn and hFilt are column vectors
sigIn = sigIn(:) ; hFilt = hFilt(:) ;

% obtain length of signal and filter
lenSigIn = length(sigIn) ; 
lenFilt = length(hFilt) ;

% ensure blockSize exists and is >= 2*filterLen - 1
if ~exist('blockSize','var')
    blockSize = lenFilt ;
end
if ( blockSize < lenFilt )
    blockSize = lenFilt ;
end
    
NFFT = 2^ceil(log2(blockSize)) ;
hFFT = fft(hFilt,NFFT) ;

% Difference between BlockSize and (LenFilt-1: the bad conv values)
hopSize = NFFT - lenFilt + 1 ;
sigIn = [zeros(lenFilt-1,1); sigIn] ;
numBlks = floor( (lenSigIn+lenFilt-1)/hopSize ) ; % number of blocks
sigIn = [sigIn; zeros(numBlks*hopSize + NFFT - length(sigIn),1) ] ;

sigOut = zeros(numBlks*hopSize,1) ; % Initialize sigOut matrix

% Overlap Save Convolution
for I = 0 : numBlks
    sigI = sigIn( I*hopSize + 1 : I*hopSize + NFFT ) ;
    sigTmp = real( ifft( fft(sigI,NFFT) .* hFFT, NFFT) ) ;
    sigOut( I*hopSize + 1 : (I+1)*hopSize, 1)  = sigTmp(lenFilt : NFFT) ;
end
% Ensure correct output size
sigOut = sigOut(1:lenSigIn + lenFilt - 1,1) ;




