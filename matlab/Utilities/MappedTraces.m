function MappedTraces (eta_Mapped_MATRIX, d, TI, Burn_In, Str)

%%%%%%%%%%%%%%%%%%%
%%% Mapped plot %%%
%%%%%%%%%%%%%%%%%%%

figure(1);
for j = 1:d
    subplot(d,1,j);
    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, j));
    ylabel(sprintf('o^{MAPPED}_{%2d}',j))
    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
    %line(get(gca,'xlim'),[o_GMEM_TRUE(j) o_GMEM_TRUE(j)],'Color','red');
    %line(get(gca,'xlim'),[o_GMEM_MLE(j) o_GMEM_MLE(j)],'Color','green');
    
end



figure(2);
if Str.isdiagB == 0
    for j = 1 : d
        for i = 1:d
            subplot(d,d,j + (i - 1)*d);
            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, (j - 1)*d + i + d));
            ylabel(sprintf('\\beta^{MAPPED}_{%2d%2d}',i,j))
            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
            %line(get(gca,'xlim'),[B_GMEM_TRUE(i,j) B_GMEM_TRUE(i,j)],'Color','red');
            %line(get(gca,'xlim'),[B_GMEM_MLE(i,j) B_GMEM_MLE(i,j)],'Color','green');
            
        end
    end
else
    for j = 1:d
        subplot(d,1,j);
        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, j + d));
        ylabel(sprintf('\\beta^{MAPPED}_{%2d}',j))
        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
        %line(get(gca,'xlim'),[B_GMEM_TRUE(j) B_GMEM_TRUE(j)],'Color','red');
        %line(get(gca,'xlim'),[B_GMEM_MLE(j) B_GMEM_MLE(j)],'Color','green');
        
    end
end


figure(3)
if Str.isdiagB == 0
    if Str.isdiagA == 0
        for j = 1:d
            for i = 1:d
                subplot(d,d,j + (i - 1)*d);
                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, (j - 1)*d + i + d + d^2));
                ylabel(sprintf('\\alpha^{MAPPED}_{%2d%2d}',i,j))
                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                %line(get(gca,'xlim'),[A_GMEM_TRUE(i,j) A_GMEM_TRUE(i,j)],'Color','red');
                %line(get(gca,'xlim'),[A_GMEM_MLE(i,j) A_GMEM_MLE(i,j)],'Color','green');
                
            end
        end
    else
        for j = 1:d
            subplot(d,1,j);
            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, j + d + d^2));
            ylabel(sprintf('\\alpha^{MAPPED}_{%2d}',j))
            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
            %line(get(gca,'xlim'),[A_GMEM_TRUE(j) A_GMEM_TRUE(j)],'Color','red');
            %line(get(gca,'xlim'),[A_GMEM_MLE(j) A_GMEM_MLE(j)],'Color','green');
            
        end
    end
else
    if Str.isdiagA == 0
        for j = 1:d
            for i = 1:d
                subplot(d,d,(i - 1)*d + j);
                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, (j - 1)*d + i + d + d));
                ylabel(sprintf('\\alpha^{MAPPED}_{%2d%2d}',i,j))
                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                %line(get(gca,'xlim'),[A_GMEM_TRUE(i,j) A_GMEM_TRUE(i,j)],'Color','red');
                %line(get(gca,'xlim'),[A_GMEM_MLE(i,j) A_GMEM_MLE(i,j)],'Color','green');
                
            end
        end
    else
        for j = 1:d
            subplot(d,1,j);
            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, j + d + d));
            ylabel(sprintf('\\alpha^{MAPPED}_{%2d}',j))
            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
            %line(get(gca,'xlim'),[A_GMEM_TRUE(j) A_GMEM_TRUE(j)],'Color','red');
            %line(get(gca,'xlim'),[A_GMEM_MLE(j) A_GMEM_MLE(j)],'Color','green');
            
        end
    end
end




if isempty(Str.x_neg) == 0
    figure(4)
    if Str.isdiagB == 0
        if Str.isdiagA == 0
            if Str.isdiagAneg == 0
                for j = 1:d
                    for i = 1:d
                        subplot(d,d,(i - 1)*d + j)
                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + (j - 1)*d + i));
                        ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                        %line(get(gca,'xlim'),[Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)],'Color','red');
                        %line(get(gca,'xlim'),[Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)],'Color','green');
                        
                    end
                end
            else
                for j = 1:d
                    subplot(d,1,j)
                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + j));
                    ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d}',j))
                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                    %line(get(gca,'xlim'),[Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)],'Color','red');
                    %line(get(gca,'xlim'),[Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)],'Color','green');
                    
                end
            end
        else
            if Str.isdiagAneg == 0
                for j = 1:d
                    for i= 1:d
                        subplot(d,d,(i - 1)*d + j)
                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i));
                        ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                        %line(get(gca,'xlim'),[Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)],'Color','red');
                        %line(get(gca,'xlim'),[Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)],'Color','green');
                        
                    end
                end
            else
                for j = 1:d
                    subplot(d,1,j)
                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + j));
                    ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d}',j))
                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                    %line(get(gca,'xlim'),[Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)],'Color','red');
                    %line(get(gca,'xlim'),[Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)],'Color','green');
                    
                end
            end
        end
    else
        if Str.isdiagA == 0
            if Str.isdiagAneg == 0
                for j = 1:d
                    for i=1:d
                        subplot(d,d,(i - 1)*d + j)
                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i));
                        ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                        %line(get(gca,'xlim'),[Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)],'Color','red');
                        %line(get(gca,'xlim'),[Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)],'Color','green');
                        
                    end
                end
            else
                for j = 1:d
                    subplot(d,1,j)
                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + j));
                    ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d}',j))
                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                    %line(get(gca,'xlim'),[Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)],'Color','red');
                    %line(get(gca,'xlim'),[Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)],'Color','green');
                    
                end
            end
        else
            if Str.isdiagAneg == 0
                for j = 1:d
                    for i = 1:d
                        subplot(d,d,(i - 1)*d + j)
                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + (j - 1)*d + i));
                        ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                        %line(get(gca,'xlim'),[Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)],'Color','red');
                        %line(get(gca,'xlim'),[Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)],'Color','green');
                        
                    end
                end
            else
                for j = 1:d
                    subplot(d,1,j)
                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + j));
                    ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d}',j))
                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                    %line(get(gca,'xlim'),[Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)],'Color','red');
                    %line(get(gca,'xlim'),[Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)],'Color','green');
                    
                end
            end
        end
    end
end


if isempty(Str.x_lag) == 0
    figure(5)
    if isempty(Str.x_neg) == 0
        if Str.isdiagB == 0
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d2%d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                end
            else
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
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
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i =1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                end
            else
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
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
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                end
            else
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i=1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                end
            end
        else
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i= 1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                end
            else
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d + (j - 1)*d + i));
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d + j));
                            ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            %line(get(gca,'xlim'),[F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                            
                        end
                    end
                end
            end
        end
    end
    %saveas(figure(5),'TEST1 tracce F mapped.jpg')
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
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
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
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
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
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
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
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(6)
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + (l - 1)*d + i));
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                    %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(6+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                                %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(6+TI+l)
                                            subplot(d,1,j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + d*(TI) + d*(TI) + (l-1)*d + j));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
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
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
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
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
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
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        end
                    end
                else
                    if Str.isdiagAneg == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
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
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        end
                    end
                else
                    if Str.isdiagAneg == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(6)
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + (l - 1)*d + i));
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                                %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(6+l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + d^2*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(6+l)
                                    subplot(d,1,j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + (l-1)*d + j));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(6+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                            %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            %line(get(gca,'xlim'),[Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(6+TI+l)
                                        subplot(d,1,j)
                                        plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + d*(TI) + (l-1)*d + j));
                                        ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                        xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                        %line(get(gca,'xlim'),[Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        %line(get(gca,'xlim'),[Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
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
                            figure(6)
                            subplot(d,TI,(i - 1)*(TI) + l)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + (l - 1)*d + i));
                            ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                            %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                        end
                    end
                    
                    if Str.isdiagG == 0
                        for l = 1:(TI)
                            for j = 1:d
                                for i = 1:d
                                    figure(6+l)
                                    subplot(d,d,(i - 1)*d + j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                end
                            end
                            
                        end
                    else
                        for l = 1:(TI)
                            for j = 1:d
                                figure(6+l)
                                subplot(d,1,j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + d*(TI) + (l-1)*d + j));
                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                            end
                            
                        end
                    end
                else
                    for l = 1:(TI)
                        for i = 1:d
                            figure(6)
                            subplot(d,TI,(i - 1)*(TI) + l)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (l - 1)*d + i));
                            ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                            %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                        end
                    end
                    
                    if Str.isdiagG == 0
                        for l = 1:(TI)
                            for j = 1:d
                                for i = 1:d
                                    figure(6+l)
                                    subplot(d,d,(i - 1)*d + j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                end
                            end
                            
                        end
                    else
                        for l = 1:(TI)
                            for j = 1:d
                                figure(6+l)
                                subplot(d,1,j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + d*(TI) + (l-1)*d + j));
                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                            end
                            
                        end
                    end
                end
            else
                if Str.isdiagA == 0
                    for l = 1:(TI)
                        for i = 1:d
                            figure(6)
                            subplot(d,TI,(i - 1)*(TI) + l)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (l - 1)*d + i));
                            ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                            %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                        end
                    end
                    
                    if Str.isdiagG == 0
                        for l = 1:(TI)
                            for j = 1:d
                                for i = 1:d
                                    figure(6+l)
                                    subplot(d,d,(i - 1)*d + j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                end
                            end
                            
                        end
                    else
                        for l = 1:(TI)
                            for j = 1:d
                                figure(6+l)
                                subplot(d,1,j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + d*(TI) + (l-1)*d + j));
                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                            end
                            
                        end
                    end
                else
                    for l = 1:(TI)
                        for i = 1:d
                            figure(6)
                            subplot(d,TI,(i - 1)*(TI) + l)
                            plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + (l - 1)*d + i));
                            ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,j))
                            xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                            %line(get(gca,'xlim'),[K_GMEM_TRUE(i,j) K_GMEM_TRUE(i,j)],'Color','red');
                            %line(get(gca,'xlim'),[K_GMEM_MLE(i,j) K_GMEM_MLE(i,j)],'Color','green');
                        end
                    end
                    
                    if Str.isdiagG == 0
                        for l = 1:(TI)
                            for j = 1:d
                                for i = 1:d
                                    figure(6+l)
                                    subplot(d,d,(i - 1)*d + j)
                                    plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i));
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                    xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                    %line(get(gca,'xlim'),[G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                    %line(get(gca,'xlim'),[G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                end
                            end
                            
                        end
                    else
                        for l = 1:(TI)
                            for j = 1:d
                                figure(6+l)
                                subplot(d,1,j)
                                plot(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d*(TI) + (l-1)*d + j));
                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                xlim([0,size(eta_Mapped_MATRIX,1) - Burn_In])
                                %line(get(gca,'xlim'),[G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                %line(get(gca,'xlim'),[G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                            end
                            
                        end
                    end
                end
            end
        end
    end
end
