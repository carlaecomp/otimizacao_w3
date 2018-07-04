function np=np(it, m)
    
    x   = modulo((rand(1,m)*10^4),500)
    y   = modulo((rand(1,m)*10^4),500)
    px  = modulo((rand(1,m)*10^4),500)
    py  = modulo((rand(1,m)*10^4),500)
    gx  = modulo((rand(1,m)*10^4),500)
    gy  = modulo((rand(1,m)*10^4),500)
    vx  = modulo((rand(1,m)*10^4),500)
    vy  = modulo((rand(1,m)*10^4),500)
    w   = 0.5;
    c1  = 1;
    c2  = 1;
    
    for k=1:it
        for i=1:m
            if w3(x(i), y(i)) < w3(px(i), py(i))
                px(i) = x(i)
                py(i) = y(i)
                if w3(x(i), y(i)) < w3(gx(i), gy(i))
                    gx(i) = x(i)
                    gy(i) = y(i)
                end
            end
            np(i,:) = w3(gx(i), gy(i))
            
            for j=1:m
                r1 = rand()
                r2 = rand()
                vx(j) = w*vx(j) + c1*r1*(px(j)-x(j)) + c2*r2*(gx(j) -x(j))
                vy(j) = w*vy(j) + c1*r1*(py(j)-y(j)) + c2*r2*(gy(j) -y(j))
            end
            x(i+1) = x(i)+vx(i)
            y(i+1) = y(i)+vy(i)
        end
    end
    plot(np)
endfunction

function w3=w3(x,y)
    z=-x.*sin(sqrt(abs(x)))-y.*sin(sqrt(abs(y)));
    r=100*(y-x.^2).^2+(1-x).^2; 
    w3 = r-z;
endfunction
