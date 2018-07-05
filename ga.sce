function pop = geneticAlgorithm(it, size_pop, porc_c, porc_m)
    tic()
    for i=1:it
        pop= popGenerate(size_pop)
        pop= crossPop(pop, size_pop, porc_c)
        pop= mutaPop(pop, size_pop, porc_m)
        
        pop = gsort(pop,'lr','i')
        pop_best(i,:) = pop(1, :)
        pop= selectPop(pop, size_pop)
    end
    plotFunction(pop_best, pop)
    disp("toc")
    disp(toc())
endfunction

function pop=popGenerate(size_pop)
    rand("normal")
    for i = 1:size_pop
        xy = int(modulo((rand(1,2)*10^4),500))
        x = xy(1,1)
        y = xy(1,2)
        w3 = fitness(x,y)
        pop(i,:) = [ w3, xy]
    end
endfunction

function pop= crossPop(pop, size_pop, porc_c)
    rand("uniform")
    it = int(size_pop*(porc_c/100))
    
    for i=1:it
        father1 = int(modulo(rand()*100, size_pop))+1
        father1 = pop(father1,:)
        
        signal_x = 1;
        signal_y = 1;
        
        if(father1(1,2) < 0)
            father1(1,2) = father1(1,2)*(-1)
            signal_x = -1
        end
        
        if(father1(1,3) < 0)
            father1(1,3) = father1(1,3)*(-1)
            signal_y = -1
        end
        
        x1 = dec2bin(int(father1(1,2)))
        y1 = dec2bin(int(father1(1,3)))
        
        
        father2 = int(modulo(rand()*100, size_pop))+1
        father2 = pop(father2,:)
        
        if(father2(1,2) < 0)
            father2(1,2) = father2(1,2)*(-1)
            signal_x = -1
        end
        
        if(father2(1,3) < 0)
            father2(1,3) = father2(1,3)*(-1)
            signal_y = -1
        end
        
        x2 = dec2bin(int(father2(1,2)))
        y2 = dec2bin(int(father2(1,3)))
        
        p_x = int(modulo(rand()*100, length(x1)))
        p_y = int(modulo(rand()*100, length(y1)))
        
        x_s = strcat(part(x1, 1:p_x), part(x2, (p_x+1):length(x2)))
        x_s = bin2dec(x_s)
        
        y_s = strcat(part(y1, 1:p_y), part(y2, (p_y+1):length(y2)))
        y_s = bin2dec(y_s)
        
        w3 = fitness(x_s,y_s)
        size_pop_new = size(pop) 
        size_pop_new = size_pop_new(1,1)+1
        
        pop(size_pop_new,:) = [w3, x_s, y_s]
        
        x_s = strcat(part(x2, 1:p_x), part(x1, (p_x+1):length(x1)))
        x_s = signal_x*bin2dec(x_s)
        
        y_s = strcat(part(y2, 1:p_y), part(y1, (p_y+1):length(y1)))
        y_s = signal_y*bin2dec(y_s)
        
        w3 = fitness(x_s,y_s)
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
        
        signal_x = 1;
        signal_y = 1;
        
        x1 = int(father1(1,2))
        y1 = int(father1(1,3))
        if(x1 < 0)
            x1 = x1*(-1)
            signal_x = -1
        end
        if(y1 < 0)
            y1 = y1*(-1)
            signal_y = -1
        end
        p_x = int(modulo(rand()*100, length(x1)))+1
        p_y = int(modulo(rand()*100, length(y1)))+1
        
        bit_inv_x = 1 - bitget(x1, p_x)
        x_s = signal_x*bitset(x1, p_x, bit_inv_x)

        bit_inv_y = 1 - bitget(y1, p_y)
        y_s = signal_y*bitset(y1, p_y, bit_inv_y)      
        
        w3 = fitness(x_s,y_s)
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


function fitness=fitness(x,y)
    z=-x.*sin(sqrt(abs(x)))-y.*sin(sqrt(abs(y)));
    x =x/250;
    y =y/250;
    r=100*(y-x.^2).^2+(1-x).^2; 
    fitness = r-z;
endfunction

function plotFunction(pop_best, pop)
    [x,y]=meshgrid(-500:5:500,-500:5:500);
    z=-x.*sin(sqrt(abs(x)))-y.*sin(sqrt(abs(y)));
    
    
    x=x/250;
    y=y/250;
    r=100*(y-x.^2).^2+(1-x).^2; 
    w3 = r-z;
    figure
    surf(x*250, y*250,w3)
    figure
    plot(pop_best(:,1))
endfunction
