L=1e5;  % Set Length
n=8e5;  % Filter Length

%%Find the Optimal value to K
k=round(n/L * log(2));

%%Generate Random String Cell
set_string= RandomStringGenerator(40,L);

%%Generate New Random String Cell Different From The Previous
set_test= unique(setdiff(RandomStringGenerator(40,L),set_string));

%% Calculate False Positives

tFp=0;
pFp=0;
count=0;

bloom_filter = BloomFilter(n,k,set_string);
tFp=(1-exp((-k*L)/(n)))^k;
for i=1:L
    if(isMember(bloom_filter,set_test{i},k))
      count=count+1;
    end
end
pFp=count/L;

%% Conclusion

fprintf('Set Length = %d\n',L);
fprintf('Filter  Length = %d\n',n);
fprintf('Optimal K = %d\n',k);
fprintf('False Positive Probability(T) = %d\n',tFp);
fprintf('False Positive Probability(P) = %d\n',pFp);
