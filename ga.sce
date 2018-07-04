function pop = geneticAlgorithm(it, size_pop, porc_c, porc_m)
    
    for i=1:it
        pop= popGenerate(size_pop)
        pop= crossPop(pop, size_pop, porc_c)
        pop= mutaPop(pop, size_pop, porc_m)
        
        pop = gsort(pop,'lr','i')
        pop_best(i,:) = pop(1, :)
        
        pop= selectPop(pop, size_pop)
    end
    plotFunction(pop_best, pop)
    
endfunction

function pop=popGenerate(size_pop)
    rand('uniform')
    for i = 1:size_pop
        xy = int(modulo((rand(1,2)*10^4),500))
        x = xy(1,1)
        y = xy(1,2)
        z=-x.*sin(sqrt(abs(x)))-y.*sin(sqrt(abs(y)))
        r=100*(y-x.^2).^2+(1-x).^2; 
        w3 = r-z;
        pop(i,:) = [ w3, xy]
    end
endfunction

function pop= crossPop(pop, size_pop, porc_c)
    
    it = int(size_pop*(porc_c/100))
    
    for i=1:it
        father1 = int(modulo(rand()*100, size_pop))+1
        father1 = pop(father1,:)
        x1 = dec2bin(int(father1(1,2)))
        y1 = dec2bin(int(father1(1,3)))
        
        
        father2 = int(modulo(rand()*100, size_pop))+1
        father2 = pop(father2,:)
        x2 = dec2bin(int(father2(1,2)))
        y2 = dec2bin(int(father2(1,3)))
        
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
        size_pop_new = size_pop_new(1,1)+1
        
        pop(size_pop_new,:) = [w3, x_s, y_s]
        
        x_s = strcat(part(x2, 1:p_x), part(x1, (p_x+1):length(x1)))
        x_s = bin2dec(x_s)
        
        y_s = strcat(part(y2, 1:p_y), part(y1, (p_y+1):length(y1)))
        y_s = bin2dec(y_s)
        
        z=-x_s.*sin(sqrt(abs(x_s)))-y_s.*sin(sqrt(abs(y_s)))
        r=100*(y_s-x_s.^2).^2+(1-x_s).^2; 
        w3 = r-z;
        size_pop_new = size(pop) 
        size_pop_new = size_pop_new(1,1)+1
        
        pop(size_pop_new,:) = [w3, x_s, y_s]
    end
    
endfunction

function pop= mutaPop(pop, size_pop, porc_m)
    
    it = int(size_pop*(porc_m/100))
    
    for i=1:it
        father1 = int(modulo(rand()*100, size_pop))+1
        father1 = pop(father1,:)
        
        x1 = int(father1(1,2))
        y1 = int(father1(1,3))
        p_x = int(modulo(rand()*100, length(x1)))+1
        p_y = int(modulo(rand()*100, length(y1)))+1
        
        bit_inv_x = 1 - bitget(x1, p_x)
        x_s = bitset(x1, p_x, bit_inv_x)

        bit_inv_y = 1 - bitget(y1, p_y)
        y_s = bitset(y1, p_y, bit_inv_y)      
        
        z=-x_s.*sin(sqrt(abs(x_s)))-y_s.*sin(sqrt(abs(y_s)))
        r=100*(y_s-x_s.^2).^2+(1-x_s).^2; 
        w3 = r-z;
        size_pop_new = size(pop) 
        size_pop_new = size_pop_new(1,1)+1
        
        pop(size_pop_new,:) = [w3,x_s, y_s]
    end
    
endfunction

function pop_new=selectPop(pop, size_pop)
    for i=1:size_pop
        p1 = int(modulo(rand()*100, size_pop))+1
        p2 = int(modulo(rand()*100, size_pop))+1
        if(p1 < p2) 
            pop_new(i,:) = pop(p1, :)
        else
            pop_new(i,:) = pop(p2, :)
        end         
    end    
endfunction

function plotFunction(pop_best, pop)
    [x,y]=meshgrid(-500:5:500,-500:5:500);
    
    x=x/250;
    y=y/250;
    z=-x.*sin(sqrt(abs(x)))-y.*sin(sqrt(abs(y)));
    r=100*(y-x.^2).^2+(1-x).^2; 
    w3 = r-z;
    figure
    surf(x,y,w3)
    figure
    plot2d3('gnn',pop_best)
    
endfunction
