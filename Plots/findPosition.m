function pos = findPosition(time, timevector)
    % Finds times given a vector of times to be found and a vector of times
    % to be searched
    dim = size(time);
    pos = zeros(dim);
    for i = 1:dim(1)
        for j = 1:dim(2)
            [~, p] = min(abs(timevector-time(i,j)));
            pos(i,j) = p;
        end
    end
end