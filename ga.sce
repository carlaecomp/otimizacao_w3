[x,y]=meshgrid(-500:5:500,-500:5:500);
//
z=-x.*sin(sqrt(abs(x)))-y.*sin(sqrt(abs(y)));
x=x/500;
y=y/500;
r=100*(y-x.^2).^2+(1-x).^2; 
w3 = r-z;
//surf(x,y,w3)

it = 100;

function ga = geneticAlgorithm(func, it, size_pop, size_cromos, porc_c, porc_m)
    
    ga= func
//    pop= popGenerate(size_pop, size_cromos)
//    pop= crossPop(pop, porc_c)
//    pop= mutaPop(pop, porc_m)
//    pop= selectPop(pop) 
endfunction

function pop=popGenerate(size_pop, size_cromos)
    for i = 1:size_pop
        pop(i,:) = part(dec2bin(int(rand(1,2)*(10^5))), 1:size_cromos)
    end
endfunction

