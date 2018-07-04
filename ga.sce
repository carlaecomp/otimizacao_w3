//[x,y]=meshgrid(-500:5:500,-500:5:500);
//
//z=-x.*sin(sqrt(abs(x)))-y.*sin(sqrt(abs(y)));
//x=x/500;
//y=y/500;
//r=100*(y-x.^2).^2+(1-x).^2; 
//w3 = r-z;
//surf(x,y,w3)

//it = 100;

function ga = geneticAlgorithm(func, it, size_pop, size_cromos, porc_c, porc_m)
    
    ga= func
//    pop= popGenerate(size_pop, size_cromos)
//    pop= crossPop(pop, size_cromos, porc_c)
//    pop= mutaPop(pop, porc_m)
//    pop= selectPop(pop) 
endfunction

function pop=popGenerate(size_pop)
    for i = 1:size_pop
        xy = modulo((rand(1,2)*10^4),500)
        x = xy(1,1)
        y = xy(1,2)
        z=-x.*sin(sqrt(abs(x)))-y.*sin(sqrt(abs(y)))
        r=100*(y-x.^2).^2+(1-x).^2; 
        w3 = r-z;
        pop(i,:) = [xy, w3]
    end
endfunction

function pop= crossPop(pop, size_pop, porc_c)
    
    father1 = int(modulo(rand()*100, size_pop))
    father1 = pop(father1,:)
    x1 = dec2bin(int(father1(1,1)))
    y1 = dec2bin(int(father1(1,2)))
    
    
    father2 = int(modulo(rand()*100, size_pop))
    father2 = pop(father2,:)
    x2 = dec2bin(int(father2(1,1)))
    y2 = dec2bin(int(father2(1,2)))
    
    p_x = int(modulo(rand()*100, length(x1)))
    p_y = int(modulo(rand()*100, length(y1)))
    
    x_s = strcat(part(x1, 1:p_x), part(x2, (p_x+1):length(x2)))
    x_s = bin2dec(x_s)
    
    y_s = strcat(part(y1, 1:p_y), part(y2, (p_y+1):length(y2)))
    y_s = bin2dec(y_s)
    
    z=-x_s.*sin(sqrt(abs(x_s)))-y_s.*sin(sqrt(abs(y_s)))
    r=100*(y_s-x_s.^2).^2+(1-x_s).^2; 
    w3 = r-z;
    size_pop_new = size(pop) 
    size_pop_new = size_pop_new(1,1)
    pop(size_pop_new,:) = [x_s, y_s, w3]       
    
    
endfunction

