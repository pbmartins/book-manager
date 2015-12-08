[Set,users] = usersMovies('u.data');

Nu = length(users);

k = 1000;
coefA = coef_a_b(k);
coefB = coef_a_b(k);

%m = max(udata(:,2))%---retorna o maximo valor do filmes para assim escolhermos
% o numero primo a seguir valor de c = 1693
%m=1682;

c = 1693;

tic
Docs_signatures = zeros(Nu,k);
for i = 1:Nu
    signature = zeros(1,k);
    for k = 1:1000
        min = 2000;
        for j = 1:length(Set{i})
            %hash_code = mod(coefA(k) * Set{i}(j) + coefB(k),c); 
            hash_code = HashFunction(num2str(Set{i}(j)),length(Set{i}));
            if hash_code < min
                min = hash_code;
            end
        end
    signature(1,k) = min;
    end
    Docs_signatures(i,:) = signature;
end
toc
JDist=zeros(Nu);
for n1 = 1:Nu% Get the MinHash signature for document i.
  signature1 = Docs_signatures(n1,:);
    
  %For each of the other test documents...
  for n2= n1+1:Nu
    
    % Get the MinHash signature for document j.
    signature2 = Docs_signatures(n2,:);
    
    count = 0;
    %Count the number of positions in the minhash signature which are equal.
    
    for k = 1:1000
      count = count + (signature1(k) == signature2(k));
    
    % Record the percentage of positions which matched.    
    end
     JDist(n1,n2) = 1-(count / k);
  end
end
threshold =0.4  % limiar de decisao
% Array para guardar pares similares (user1, user2, distancia)
SimilarUsers= zeros(1,3);
k= 1;
  for n1= 1:Nu,
  for n2= n1+1:Nu,
    if (JDist(n1,n2)<0.4)
      SimilarUsers(k,:)= [users(n1) users(n2) JDist(n1,n2)];
      k= k+1;
    end
  end
  end
SimilarUsers

        
        
% N=length(Set{2})
% M=zeros(1,N);
% for i=1:X
%     M(1,i)=HashFunction(num2str(Set{2}(i)),X);
% end
% Sign2(1,k)=min(M)