function UnmappedTraces (eta_matrix, d, TI, Burn_In, Str)

%%%%%%%%%%%%%%%%%%%%%
%%% UnMapped Plot %%%
%%%%%%%%%%%%%%%%%%%%%

figure(7 + 2*(TI));
for j = 1:d
    subplot(d,1,j);
    plot(eta_matrix(Burn_In + 1 : end, j));
    ylabel(sprintf('\\omega_{%2d}',j))
    xlim([0,size(eta_matrix,1) - Burn_In])
end
%saveas(figure(7 + 2*(TI)),'TEST1 tracce o.jpg')


figure(8 + 2*(TI));
if Str.isdiagB == 0
    for j = 1 : d
        for i = 1:d
            subplot(d,d,(i - 1)*d + j);
            plot(eta_matrix(Burn_In + 1 : end, (j - 1)*d + i + d));
            ylabel(sprintf('\\beta_{%2d%2d}',i,j))
            xlim([0,size(eta_matrix,1) - Burn_In])
        end
    end
else
    for j = 1:d
        subplot(d,1,j);
        plot(eta_matrix(Burn_In + 1 : end, j + d));
        ylabel(sprintf('\\beta_{%2d}',j))
        xlim([0,size(eta_matrix,1) - Burn_In])
    end
end
%saveas(figure(8 + 2*(TI)),'TEST1 tracce B.jpg')

figure(9 + 2*(TI))
if Str.isdiagB == 0
    if Str.isdiagA == 0
        for j = 1:d
            for i = 1:d
                subplot(d,d,(i - 1)*d + j);
                plot(eta_matrix(Burn_In + 1 : end, (j - 1)*d + i + d + d^2));
                ylabel(sprintf('\\alpha_{%2d%2d}',i,j))
                xlim([0,size(eta_matrix,1) - Burn_In])
            end
        end
    else
        for j = 1:d
            subplot(d,1,j);
            plot(eta_matrix(Burn_In + 1 : end, j + d + d^2));
            ylabel(sprintf('\\alpha_{%2d}',j))
            xlim([0,size(eta_matrix,1) - Burn_In])
        end
    end
else
    if Str.isdiagA == 0
        for j = 1:d
            for i = 1:d
                subplot(d,d,(i - 1)*d + j);
                plot(eta_matrix(Burn_In + 1 : end, (j - 1)*d + i + d + d));
                ylabel(sprintf('\\alpha_{%2d%2d}',i,j))
                xlim([0,size(eta_matrix,1) - Burn_In])
            end
        end
    else
        for j = 1:d
            subplot(d,1,j);
            plot(eta_matrix(Burn_In + 1 : end, j + d + d));
            ylabel(sprintf('\\alpha_{%2d}',j))
            xlim([0,size(eta_matrix,1) - Burn_In])
        end
    end
end
%saveas(figure(9 + 2*(TI)),'TEST1 tracce A.jpg')

if isempty(Str.x_neg) == 0
    figure(10 + 2*(TI))
    if Str.isdiagB == 0
        if Str.isdiagA == 0
            if Str.isdiagAneg == 0
                for j = 1:d
                    for i=1:d
                        subplot(d,d,(i - 1)*d + j);
                        plot(eta_matrix(Burn_In + 1 : end, d + 2*d^2 + (j - 1)*d + i));
                        ylabel(sprintf('\\alpha^{(-)}_{%2d%2d}',i,j))
                        xlim([0,size(eta_matrix,1) - Burn_In])
                    end
                end
            else
                for j = 1:d
                    subplot(d,1,j)
                    plot(eta_matrix(Burn_In + 1 : end, d + 2*d^2 + j));
                    ylabel(sprintf('\\alpha^{(-)}_{%2d}',j))
                    xlim([0,size(eta_matrix,1) - Burn_In])
                end
            end
        else
            if Str.isdiagAneg == 0
                for j = 1:d
                    for i = 1:d
                        subplot(d,d,(i - 1)*d + j);
                        plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i));
                        ylabel(sprintf('\\alpha^{(-)}_{%2d%2d}',i,j))
                        xlim([0,size(eta_matrix,1) - Burn_In])
                    end
                end
            else
                for j = 1:d
                    subplot(d,1,j)
                    plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + j));
                    ylabel(sprintf('\\alpha^{(-)}_{%2d}',j))
                    xlim([0,size(eta_matrix,1) - Burn_In])
                end
            end
        end
    else
        if Str.isdiagA == 0
            if Str.isdiagAneg == 0
                for j = 1:d
                    for i = 1:d
                        subplot(d,d,(i - 1)*d + j);
                        plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i));
                        ylabel(sprintf('\\alpha^{(-)}_{%2d%2d}',i,j))
                        xlim([0,size(eta_matrix,1) - Burn_In])
                    end
                end
            else
                for j = 1:d
                    subplot(d,1,j)
                    plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + j));
                    ylabel(sprintf('\\alpha^{(-)}_{%2d}',j))
                    xlim([0,size(eta_matrix,1) - Burn_In])
                end
            end
        else
            if Str.isdiagAneg == 0
                for j = 1:d
                    for i = 1:d
                        subplot(d,d,(i - 1)*d + j);
                        plot(eta_matrix(Burn_In + 1 : end, 3*d + (j - 1)*d + i));
                        ylabel(sprintf('\\alpha^{(-)}_{%2d%2d}',i,j))
                        xlim([0,size(eta_matrix,1) - Burn_In])
                    end
                end
            else
                for j = 1:d
                    subplot(d,1,j)
                    plot(eta_matrix(Burn_In + 1 : end, 3*d + j));
                    ylabel(sprintf('\\alpha^{(-)}_{%2d}',j))
                    xlim([0,size(eta_matrix,1) - Burn_In])
                end
            end
        end
    end
    %saveas(figure(10 + 2*(TI)),'TEST1 tracce Aneg.jpg')
end



if isempty(Str.x_lag) == 0
    figure(11 + 2*(TI))
    if isempty(Str.x_neg) == 0
        if Str.isdiagB == 0
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, d + 3*d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, d + 3*d^2 + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                end
            else
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                end
            end
        else
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                end
            else
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, 3*d + d + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, 3*d + d + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                end
            end
        end
    else
        if Str.isdiagB == 0
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, d + 2*d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, d + 2*d^2 + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, d + 2*d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, d + 2*d^2 + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                end
            else
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                end
            end
        else
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                end
            else
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, 3*d + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, 3*d + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + d + (j - 1)*d + i));
                                ylabel(sprintf('\\phi_{%2d%2d}',i,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_matrix(Burn_In + 1 : end, 2*d + d + j));
                            ylabel(sprintf('\\phi_{%2d}',j))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                        end
                    end
                end
            end
        end
    end
    %saveas(figure(11 + 2*(TI)),'TEST1 tracce F mapped.jpg')
end



if isempty(Str.TimeSteps) == 0
    %L = length(Str.TimeSteps);
    if isempty(Str.x_lag) == 0
        if isempty(Str.x_neg) == 0
            if Str.isdiagB == 0
                if Str.isdiagA == 0
                    if Str.isdiagAneg == 0
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, d + 4*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        end
                    end
                else
                    if Str.isdiagAneg == 0
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        end
                    end
                end
            else
                if Str.isdiagA == 0
                    if Str.isdiagAneg == 0
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        end
                    end
                else
                    if Str.isdiagAneg == 0
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(12 + 2*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_matrix(Burn_In + 1 : end, 5*d + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 5*d + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 5*d + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(12 + 2*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_matrix(Burn_In + 1 : end, 5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_matrix,1) - Burn_In])
                                                
                                                
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_matrix(Burn_In + 1 : end, 5*d + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                        
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            if Str.isdiagB == 0
                if Str.isdiagA == 0
                    if Str.isdiagF == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, d + 3*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                        end
                    end
                end
            else
                if Str.isdiagA == 0
                    if Str.isdiagF == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 4*d + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 4*d + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                        end
                    end
                end
            end
        end
    else
        if isempty(Str.x_neg) == 0
            if Str.isdiagB == 0
                if Str.isdiagA == 0
                    if Str.isdiagAneg == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, d + 3*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        end
                    end
                else
                    if Str.isdiagAneg == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        end
                    end
                end
            else
                if Str.isdiagA == 0
                    if Str.isdiagAneg == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        end
                    end
                else
                    if Str.isdiagAneg == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(12 + 2*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_matrix(Burn_In + 1 : end, 4*d + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(12 + 2*(TI)+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_matrix(Burn_In + 1 : end, 4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 4*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 4*d + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,1,j)
                                    plot(eta_matrix(Burn_In + 1 : end, 4*d + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(12 + 2*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_matrix(Burn_In + 1 : end, 4*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma^{(-)}%2d_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_matrix,1) - Burn_In])
                                            
                                            
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(12 + 2*(TI)+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_matrix(Burn_In + 1 : end, 4*d + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma^{(-)}%2d_{%2d}',l,j))
                                        xlim([0,size(eta_matrix,1) - Burn_In])
                                        
                                        
                                    end
                                    
                                end
                            end
                        end
                    end
                end
            end
        else
            if Str.isdiagB == 0
                if Str.isdiagA == 0
                    for l = 1:(TI)
                        for i = 1:d
                            figure(12 + 2*(TI))
                            subplot(d,TI,(i - 1)*(TI) + l)
                            plot(eta_matrix(Burn_In + 1 : end, d + 2*d^2 + (l - 1)*d + i));
                            ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                            
                            
                        end
                    end
                    
                    if Str.isdiagG == 0
                        for l = 1:(TI)
                            for j = 1:d
                                for i = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,d,(i - 1)*d + j)
                                    plot(eta_matrix(Burn_In + 1 : end, d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                    ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                        end
                    else
                        for l = 1:(TI)
                            for j = 1:d
                                figure(12 + 2*(TI)+l)
                                subplot(d,1,j)
                                plot(eta_matrix(Burn_In + 1 : end, d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                            
                        end
                    end
                else
                    for l = 1:(TI)
                        for i = 1:d
                            figure(12 + 2*(TI))
                            subplot(d,TI,(i - 1)*(TI) + l)
                            plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + (l - 1)*d + i));
                            ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                            
                            
                        end
                    end
                    
                    if Str.isdiagG == 0
                        for l = 1:(TI)
                            for j = 1:d
                                for i = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,d,(i - 1)*d + j)
                                    plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                    ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                    
                                    
                                end
                            end
                            
                        end
                    else
                        for l = 1:(TI)
                            for j = 1:d
                                figure(12 + 2*(TI)+l)
                                subplot(d,1,j)
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + d*(TI) + (l-1)*d + j));
                                ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])
                                
                                
                            end
                            
                        end
                    end
                end
            else
                if Str.isdiagA == 0
                    for l = 1:(TI)
                        for i = 1:d
                            figure(12 + 2*(TI))
                            subplot(d,TI,(i - 1)*(TI) + l)
                            plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + (l - 1)*d + i));
                            ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                            xlim([0,size(eta_matrix,1) - Burn_In])
                            
                            
                        end
                    end
                    
                    if Str.isdiagG == 0
                        for l = 1:(TI)
                            for j = 1:d
                                for i = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,d,(i - 1)*d + j)
                                    plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                    ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])
                                end
                            end                            
                        end
                    else
                        for l = 1:(TI)
                            for j = 1:d
                                figure(12 + 2*(TI)+l)
                                subplot(d,1,j)
                                plot(eta_matrix(Burn_In + 1 : end, 2*d + d^2 + d*(TI) + (l-1)*d + j));
                                ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                xlim([0,size(eta_matrix,1) - Burn_In])                            
                            end                            
                        end
                    end
                else
                    for l = 1:(TI)
                        for i = 1:d
                            figure(12 + 2*(TI))
                            subplot(d,TI,(i - 1)*(TI) + l)
                            plot(eta_matrix(Burn_In + 1 : end, 3*d + (l - 1)*d + i));
                            ylabel(sprintf('\\kappa_{%2d%2d}',i,l))
                            xlim([0,size(eta_matrix,1) - Burn_In])     
                        end
                    end
                    if Str.isdiagG == 0
                        for l = 1:(TI)
                            for j = 1:d
                                for i = 1:d
                                    figure(12 + 2*(TI)+l)
                                    subplot(d,d,(i - 1)*d + j)
                                    plot(eta_matrix(Burn_In + 1 : end, 3*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                    ylabel(sprintf('\\gamma%2d_{%2d%2d}',l,i,j))
                                    xlim([0,size(eta_matrix,1) - Burn_In])     
                                end
                            end
                        end
                    else
                        for l = 1:(TI)
                            for j = 1:d
                                figure(12 + 2*(TI)+l)
                                subplot(d,1,j)
                                plot(eta_matrix(Burn_In + 1 : end, 3*d + d*(TI) + (l-1)*d + j));
                                ylabel(sprintf('\\gamma%2d_{%2d}',l,j))
                                xlim([0,size(eta_matrix,1) - Burn_In]) 
                            end
                        end
                    end
                end
            end
        end
    end
end