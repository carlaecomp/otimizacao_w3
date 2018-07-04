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
//    pop= crossPop(pop, size_cromos, porc_c)
//    pop= mutaPop(pop, porc_m)
//    pop= selectPop(pop) 
endfunction

function pop=popGenerate(size_pop, size_cromos)
    for i = 1:size_pop
        pop(i,:) = part(dec2bin(int(rand(1,2)*(10^5))), 1:size_cromos)
    end
endfunction

function pop= crossPop(pop, size_pop, size_cromos, porc_c)
    father1 = int(modulo(rand()*100, size_pop))
    father1 = pop(father1,:)
    x1 = father1(1,1)
    y1 = father1(1,2)
    
    
    father2 = int(modulo(rand()*100, size_pop))
    father2 = pop(father2,:)
    x2 = father2(1,1)
    y2 = father2(1,2)
    p1 = int(modulo(rand()*100, size_cromos))
    p2 = int(modulo(rand()*100, size_cromos))
    
    son
    
endfunction

