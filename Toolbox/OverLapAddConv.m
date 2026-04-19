function sigOut = OverLapAddConv(sigIn, hFilt, blockSize)

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
    
NFFT = 2^ceil(log2(2*blockSize - 1)) ;
hFFT = fft(hFilt,NFFT) ;

numBlks = ceil(lenSigIn/blockSize) ; % number of blocks
sigIn = [sigIn; zeros(numBlks*blockSize - lenSigIn,1)] ;

sigOut = zeros(numBlks*NFFT,1) ; % Initialize sigOut matrix

% Overlap Add Convolution
for I = 0 : numBlks - 1
    sigI = [sigIn( I*blockSize + 1 : (I+1)*blockSize ) ; ...
            zeros(NFFT-blockSize,1) ] ;
    sigOut( I*blockSize + 1 : I*blockSize + NFFT, 1 ) = ...
       sigOut( I*blockSize + 1 : I*blockSize + NFFT,1 ) + ...
       real( ifft( fft(sigI,NFFT) .* hFFT, NFFT) ) ;
end
sigOut = sigOut(1:lenSigIn + lenFilt - 1,1) ;




