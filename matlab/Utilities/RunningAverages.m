function RunningAverages (SampleMean_vec, d, TI, NBurnIn, NMCMC0, NMCMC1, ...
    o_GMEM_TRUE,B_GMEM_TRUE,A_GMEM_TRUE,Aneg_GMEM_TRUE,F_GMEM_TRUE,K_GMEM_TRUE,...
    G_GMEM_TRUE,Gneg_GMEM_TRUE, Str)
%%%%%%%%%%%%%%%%%%%%%%%%
%%% Running averages %%%
%%%%%%%%%%%%%%%%%%%%%%%%

if isempty(o_GMEM_TRUE) == 0
    figure(26 + 8*(TI))
    for j = 1:d
        subplot(d,1,j)
        plot(SampleMean_vec(j,2:end))
        title(sprintf('mean(o_{%2d})',j))
        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
        %line(get(gca,'xlim'), [o_GMEM_MLE(j) o_GMEM_MLE(j)],'Color','green');
        line(get(gca,'xlim'), [o_GMEM_TRUE(j) o_GMEM_TRUE(j)],'Color','red');
    end

    %saveas(figure(26 + 8*(TI)),'TEST1 Tracce mean_o_mapped.jpg')

    figure(27 + 8*(TI))
    if Str.isdiagB == 0
        for j = 1:d
            for i = 1:d
                subplot(d,d,(i - 1)*d + j);
                plot(SampleMean_vec(d + (j - 1)*d + i,2:end))
                title(sprintf('mean(B_{%2d%2d})',i,j))
                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                %line(get(gca,'xlim'), [B_GMEM_MLE(i,j) B_GMEM_MLE(i,j)],'Color','green');
                line(get(gca,'xlim'), [B_GMEM_TRUE(i,j) B_GMEM_TRUE(i,j)],'Color','red');
            end
        end
    else
        for j = 1:d
            subplot(d,1,j)
            plot(SampleMean_vec(d + j,2:end))
            title(sprintf('mean(B_{%2d})',j))
            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
            %line(get(gca,'xlim'), [B_GMEM_MLE(j) B_GMEM_MLE(j)],'Color','green');
            line(get(gca,'xlim'), [B_GMEM_TRUE(j) B_GMEM_TRUE(j)],'Color','red');
        end
    end
    %saveas(figure(27 + 8*(TI)),'TEST1 Tracce mean_B_mapped.jpg')


    figure(28 + 8*(TI))
    if Str.isdiagB == 0
        if Str.isdiagA == 0
            for j = 1:d
                for i = 1:d
                    subplot(d,d,(i - 1)*d + j);
                    plot(SampleMean_vec(d + d^2 + (j - 1)*d + i,2:end))
                    title(sprintf('mean(A_{%2d%2d})',i,j))
                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                    %line(get(gca,'xlim'), [A_GMEM_MLE(i,j) A_GMEM_MLE(i,j)],'Color','green');
                    line(get(gca,'xlim'), [A_GMEM_TRUE(i,j) A_GMEM_TRUE(i,j)],'Color','red');
                end
            end
        else
            for j = 1:d
                subplot(d,1,j)
                plot(SampleMean_vec(d +  d^2 + j,2:end))
                title(sprintf('mean(A_{%2d})',j))
                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                %line(get(gca,'xlim'), [A_GMEM_MLE(j) A_GMEM_MLE(j)],'Color','green');
                line(get(gca,'xlim'), [A_GMEM_TRUE(j) A_GMEM_TRUE(j)],'Color','red');
            end
        end
    else
        if Str.isdiagA == 0
            for j = 1:d
                for i = 1:d
                    subplot(d,d,(i - 1)*d + j);
                    plot(SampleMean_vec(d +  d + (j - 1)*d + i,2:end))
                    title(sprintf('mean(A_{%2d%2d})',i,j))
                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                    %line(get(gca,'xlim'), [A_GMEM_MLE(i,j) A_GMEM_MLE(i,j)],'Color','green');
                    line(get(gca,'xlim'), [A_GMEM_TRUE(i,j) A_GMEM_TRUE(i,j)],'Color','red');
                end
            end
        else
            for j = 1:d
                subplot(d,1,j)
                plot(SampleMean_vec(d +  d + j,2:end))
                title(sprintf('mean(A_{%2d})',j))
                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                %line(get(gca,'xlim'), [A_GMEM_MLE(j) A_GMEM_MLE(j)],'Color','green');
                line(get(gca,'xlim'), [A_GMEM_TRUE(j) A_GMEM_TRUE(j)],'Color','red');
            end
        end
    end
    %saveas(figure(28 + 8*(TI)),'TEST1 Tracce mean_A_mapped.jpg')



    if isempty(Str.x_neg) == 0
        figure(29 + 8*(TI))
        if Str.isdiagB == 0
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            plot(SampleMean_vec(d +  2*d^2 + (j - 1)*d + i,2:end))
                            title(sprintf('mean(Aneg_{%2d%2d})',i,j))
                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                            %line(get(gca,'xlim'), [Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)],'Color','green');
                            line(get(gca,'xlim'), [Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)],'Color','red');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        plot(SampleMean_vec(d +  2*d^2 + j,2:end))
                        title(sprintf('mean(Aneg_{%2d})',j))
                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                        %line(get(gca,'xlim'), [Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)],'Color','green');
                        line(get(gca,'xlim'), [Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)],'Color','red');
                    end
                end
            else
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            plot(SampleMean_vec(2*d + d^2 + (j - 1)*d + i,2:end))
                            title(sprintf('mean(Aneg_{%2d%2d})',i,j))
                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                            %line(get(gca,'xlim'), [Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)],'Color','green');
                            line(get(gca,'xlim'), [Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)],'Color','red');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        plot(SampleMean_vec(2*d + d^2 + j,2:end))
                        title(sprintf('mean(Aneg_{%2d})',j))
                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                        %line(get(gca,'xlim'), [Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)],'Color','green');
                        line(get(gca,'xlim'), [Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)],'Color','red');
                    end
                end
            end
        else
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            plot(SampleMean_vec(2*d +  d^2 + (j - 1)*d + i,2:end))
                            title(sprintf('mean(Aneg_{%2d%2d})',i,j))
                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                            %line(get(gca,'xlim'), [Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)],'Color','green');
                            line(get(gca,'xlim'), [Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)],'Color','red');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        plot(SampleMean_vec(2*d +  d^2 + j,2:end))
                        title(sprintf('mean(Aneg_{%2d})',j))
                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                        %line(get(gca,'xlim'), [Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)],'Color','green');
                        line(get(gca,'xlim'), [Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)],'Color','red');
                    end
                end
            else
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            plot(SampleMean_vec(2*d + d + (j - 1)*d + i,2:end))
                            title(sprintf('mean(Aneg_{%2d%2d})',i,j))
                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                            %line(get(gca,'xlim'), [Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)],'Color','green');
                            line(get(gca,'xlim'), [Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)],'Color','red');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        plot(SampleMean_vec(2*d + d + j,2:end))
                        title(sprintf('mean(Aneg_{%2d})',j))
                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                        %line(get(gca,'xlim'), [Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)],'Color','green');
                        line(get(gca,'xlim'), [Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)],'Color','red');
                    end
                end
            end
        end
        %saveas(figure(29 + 8*(TI)),'TEST1 Tracce mean_Aneg_mapped.jpg')
    end


    if isempty(Str.x_lag) == 0
        figure(30 + 8*(TI))
        if isempty(Str.x_neg) == 0
            if Str.isdiagAneg == 0
                if Str.isdiagB == 0
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(d + 3*d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(d + 3*d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(2*d + 2*d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(2*d + 2*d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(2*d + 2*d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(2*d + 2*d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(3*d + d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(3*d + d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    end
                end
            else
                if Str.isdiagB == 0
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(2*d + 2*d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(2*d + 2*d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(3*d + d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(3*d + d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(3*d + d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(3*d + d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(3*d + d + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(3*d + d + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    end
                end
            end
        else
            if Str.isdiagB == 0
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(d + 2*d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(d + 2*d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(2*d + 2*d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(2*d + d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(2*d + d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(2*d + d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(3*d + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(3*d + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    end
            end
        end
        %saveas(figure(30 + 8*(TI)),'TEST1 Tracce mean_F_mapped.jpg')
    end

    if isempty(Str.TimeSteps) == 0
        if isempty(Str.x_lag) == 0
            if isempty(Str.x_neg) == 0
                if Str.isdiagAneg == 0
                    if Str.isdiagB == 0
                        if Str.isdiagA == 0
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(d + 4*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
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
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(4*d + d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
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
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(4*d + d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
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
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(4*d + d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(4*d + d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(5*d + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(5*d + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(5*d + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(5*d + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
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
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(d + 3*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(2*d + 2*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(2*d + 2*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(3*d + d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(2*d + 2*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(3*d + d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(3*d + d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(4*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        end
                    end
                end
            end
        else
            if isempty(Str.x_neg) == 0
                if Str.isdiagAneg == 0
                    if Str.isdiagB == 0
                        if Str.isdiagA == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(d + 4*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagA == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
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
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagA == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(4*d + d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
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
                                figure(31 + 8*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(SampleMean_vec(d + 3*d^2 + (l - 1)*d + i,2:end))
                                title(sprintf('mean(K_{%2d%2d})',i,l))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                            end
                        end
                        %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(SampleMean_vec(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                        title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(31 + 8*(TI) + l)
                                    subplot(d,1,j)
                                    plot(SampleMean_vec(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                    title(sprintf('mean(G%2d_{%2d})',l,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(31 + 8*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(SampleMean_vec(2*d + 2*d^2 + (l - 1)*d + i,2:end))
                                title(sprintf('mean(K_{%2d%2d})',i,l))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                            end
                        end
                        %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                        title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(31 + 8*(TI) + l)
                                    subplot(d,1,j)
                                    plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                    title(sprintf('mean(G%2d_{%2d})',l,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(31 + 8*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(SampleMean_vec(2*d + 2*d^2 + (l - 1)*d + i,2:end))
                                title(sprintf('mean(K_{%2d%2d})',i,l))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                            end
                        end
                        %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                        title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(31 + 8*(TI) + l)
                                    subplot(d,1,j)
                                    plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                    title(sprintf('mean(G%2d_{%2d})',l,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(31 + 8*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(SampleMean_vec(3*d + d^2 + (l - 1)*d + i,2:end))
                                title(sprintf('mean(K_{%2d%2d})',i,l))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                            end
                        end
                        %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(SampleMean_vec(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                        title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(31 + 8*(TI) + l)
                                    subplot(d,1,j)
                                    plot(SampleMean_vec(3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                    title(sprintf('mean(G%2d_{%2d})',l,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        end
                    end
                end
            end
        end
    end
else
    figure(26 + 8*(TI))
    for j = 1:d
        subplot(d,1,j)
        plot(SampleMean_vec(j,2:end))
        title(sprintf('mean(o_{%2d})',j))
        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
        %line(get(gca,'xlim'), [o_GMEM_MLE(j) o_GMEM_MLE(j)],'Color','green');
        %line(get(gca,'xlim'), [o_GMEM_TRUE(j) o_GMEM_TRUE(j)],'Color','red');
    end

    %saveas(figure(26 + 8*(TI)),'TEST1 Tracce mean_o_mapped.jpg')

    figure(27 + 8*(TI))
    if Str.isdiagB == 0
        for j = 1:d
            for i = 1:d
                subplot(d,d,(i - 1)*d + j);
                plot(SampleMean_vec(d + (j - 1)*d + i,2:end))
                title(sprintf('mean(B_{%2d%2d})',i,j))
                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                %line(get(gca,'xlim'), [B_GMEM_MLE(i,j) B_GMEM_MLE(i,j)],'Color','green');
                %line(get(gca,'xlim'), [B_GMEM_TRUE(i,j) B_GMEM_TRUE(i,j)],'Color','red');
            end
        end
    else
        for j = 1:d
            subplot(d,1,j)
            plot(SampleMean_vec(d + j,2:end))
            title(sprintf('mean(B_{%2d})',j))
            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
            %line(get(gca,'xlim'), [B_GMEM_MLE(j) B_GMEM_MLE(j)],'Color','green');
            %line(get(gca,'xlim'), [B_GMEM_TRUE(j) B_GMEM_TRUE(j)],'Color','red');
        end
    end
    %saveas(figure(27 + 8*(TI)),'TEST1 Tracce mean_B_mapped.jpg')


    figure(28 + 8*(TI))
    if Str.isdiagB == 0
        if Str.isdiagA == 0
            for j = 1:d
                for i = 1:d
                    subplot(d,d,(i - 1)*d + j);
                    plot(SampleMean_vec(d + d^2 + (j - 1)*d + i,2:end))
                    title(sprintf('mean(A_{%2d%2d})',i,j))
                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                    %line(get(gca,'xlim'), [A_GMEM_MLE(i,j) A_GMEM_MLE(i,j)],'Color','green');
                    %line(get(gca,'xlim'), [A_GMEM_TRUE(i,j) A_GMEM_TRUE(i,j)],'Color','red');
                end
            end
        else
            for j = 1:d
                subplot(d,1,j)
                plot(SampleMean_vec(d +  d^2 + j,2:end))
                title(sprintf('mean(A_{%2d})',j))
                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                %line(get(gca,'xlim'), [A_GMEM_MLE(j) A_GMEM_MLE(j)],'Color','green');
                %line(get(gca,'xlim'), [A_GMEM_TRUE(j) A_GMEM_TRUE(j)],'Color','red');
            end
        end
    else
        if Str.isdiagA == 0
            for j = 1:d
                for i = 1:d
                    subplot(d,d,(i - 1)*d + j);
                    plot(SampleMean_vec(d +  d + (j - 1)*d + i,2:end))
                    title(sprintf('mean(A_{%2d%2d})',i,j))
                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                    %line(get(gca,'xlim'), [A_GMEM_MLE(i,j) A_GMEM_MLE(i,j)],'Color','green');
                    %line(get(gca,'xlim'), [A_GMEM_TRUE(i,j) A_GMEM_TRUE(i,j)],'Color','red');
                end
            end
        else
            for j = 1:d
                subplot(d,1,j)
                plot(SampleMean_vec(d +  d + j,2:end))
                title(sprintf('mean(A_{%2d})',j))
                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                %line(get(gca,'xlim'), [A_GMEM_MLE(j) A_GMEM_MLE(j)],'Color','green');
                %line(get(gca,'xlim'), [A_GMEM_TRUE(j) A_GMEM_TRUE(j)],'Color','red');
            end
        end
    end
    %saveas(figure(28 + 8*(TI)),'TEST1 Tracce mean_A_mapped.jpg')



    if isempty(Str.x_neg) == 0
        figure(29 + 8*(TI))
        if Str.isdiagB == 0
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            plot(SampleMean_vec(d +  2*d^2 + (j - 1)*d + i,2:end))
                            title(sprintf('mean(Aneg_{%2d%2d})',i,j))
                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                            %line(get(gca,'xlim'), [Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)],'Color','green');
                            %line(get(gca,'xlim'), [Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)],'Color','red');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        plot(SampleMean_vec(d +  2*d^2 + j,2:end))
                        title(sprintf('mean(Aneg_{%2d})',j))
                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                        %line(get(gca,'xlim'), [Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)],'Color','green');
                        %line(get(gca,'xlim'), [Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)],'Color','red');
                    end
                end
            else
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            plot(SampleMean_vec(2*d + d^2 + (j - 1)*d + i,2:end))
                            title(sprintf('mean(Aneg_{%2d%2d})',i,j))
                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                            %line(get(gca,'xlim'), [Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)],'Color','green');
                            %line(get(gca,'xlim'), [Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)],'Color','red');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        plot(SampleMean_vec(2*d + d^2 + j,2:end))
                        title(sprintf('mean(Aneg_{%2d})',j))
                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                        %line(get(gca,'xlim'), [Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)],'Color','green');
                        %line(get(gca,'xlim'), [Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)],'Color','red');
                    end
                end
            end
        else
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            plot(SampleMean_vec(2*d +  d^2 + (j - 1)*d + i,2:end))
                            title(sprintf('mean(Aneg_{%2d%2d})',i,j))
                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                            %line(get(gca,'xlim'), [Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)],'Color','green');
                            %%line(get(gca,'xlim'), [Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)],'Color','red');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        plot(SampleMean_vec(2*d +  d^2 + j,2:end))
                        title(sprintf('mean(Aneg_{%2d})',j))
                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                        %line(get(gca,'xlim'), [Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)],'Color','green');
                        %line(get(gca,'xlim'), [Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)],'Color','red');
                    end
                end
            else
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            plot(SampleMean_vec(2*d + d + (j - 1)*d + i,2:end))
                            title(sprintf('mean(Aneg_{%2d%2d})',i,j))
                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                            %line(get(gca,'xlim'), [Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)],'Color','green');
                            %%line(get(gca,'xlim'), [Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)],'Color','red');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        plot(SampleMean_vec(2*d + d + j,2:end))
                        title(sprintf('mean(Aneg_{%2d})',j))
                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                        %line(get(gca,'xlim'), [Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)],'Color','green');
                        %line(get(gca,'xlim'), [Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)],'Color','red');
                    end
                end
            end
        end
        %saveas(figure(29 + 8*(TI)),'TEST1 Tracce mean_Aneg_mapped.jpg')
    end


    if isempty(Str.x_lag) == 0
        figure(30 + 8*(TI))
        if isempty(Str.x_neg) == 0
            if Str.isdiagAneg == 0
                if Str.isdiagB == 0
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(d + 3*d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    %line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(d + 3*d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                %line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(2*d + 2*d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    %line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(2*d + 2*d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                %line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(2*d + 2*d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    %line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(2*d + 2*d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                %line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(3*d + d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    %line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(3*d + d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                %line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    end
                end
            else
                if Str.isdiagB == 0
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(2*d + 2*d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    %line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(2*d + 2*d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                %line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(3*d + d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    %line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(3*d + d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                %line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(3*d + d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    %line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(3*d + d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                %line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(3*d + d + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    %line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(3*d + d + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                %line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    end
                end
            end
        else
            if Str.isdiagB == 0
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(d + 2*d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    %line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(d + 2*d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                %line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(2*d + 2*d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    %line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(2*d + d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                %line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(2*d + d^2 + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    %line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(2*d + d^2 + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                %line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    plot(SampleMean_vec(3*d + (j - 1)*d + i,2:end))
                                    title(sprintf('mean(F_{%2d%2d})',i,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)],'Color','green');
                                    %line(get(gca,'xlim'), [F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)],'Color','red');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j);
                                plot(SampleMean_vec(3*d + j,2:end))
                                title(sprintf('mean(F_{%2d})',j))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [F_GMEM_MLE(j) F_GMEM_MLE(j)],'Color','green');
                                %line(get(gca,'xlim'), [F_GMEM_TRUE(j) F_GMEM_TRUE(j)],'Color','red');
                            end
                        end
                    end
            end
        end
        %saveas(figure(30 + 8*(TI)),'TEST1 Tracce mean_F_mapped.jpg')
    end

    if isempty(Str.TimeSteps) == 0
        if isempty(Str.x_lag) == 0
            if isempty(Str.x_neg) == 0
                if Str.isdiagAneg == 0
                    if Str.isdiagB == 0
                        if Str.isdiagA == 0
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(d + 4*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
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
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(4*d + d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
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
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(4*d + d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
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
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(4*d + d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(4*d + d^2 + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(31 + 8*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        plot(SampleMean_vec(5*d + (l - 1)*d + i,2:end))
                                        title(sprintf('mean(K_{%2d%2d})',i,l))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                        %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(5*d + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(5*d + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(G%2d_{%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(31 + 8*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    plot(SampleMean_vec(5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                    title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                    %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                                end
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(31 + 8*(TI)+TI+l)
                                                subplot(d,1,j)
                                                plot(SampleMean_vec(5*d + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                                line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                            end
                                            %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
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
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(d + 3*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(2*d + 2*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(2*d + 2*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(3*d + d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(2*d + 2*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(3*d + d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(3*d + d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(4*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                            end
                        end
                    end
                end
            end
        else
            if isempty(Str.x_neg) == 0
                if Str.isdiagAneg == 0
                    if Str.isdiagB == 0
                        if Str.isdiagA == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(d + 4*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagA == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
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
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(2*d + 3*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagA == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(3*d + 2*d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(31 + 8*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    plot(SampleMean_vec(4*d + d^2 + (l - 1)*d + i,2:end))
                                    title(sprintf('mean(K_{%2d%2d})',i,l))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                    %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                                end
                            end
                            %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(31 + 8*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                            title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                            %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                        end
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,1,j)
                                        plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                        title(sprintf('mean(G%2d_{%2d})',l,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                    end
                                    %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(31 + 8*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                                title(sprintf('mean(Gneg%2d_{%2d%2d})',l,i,j))
                                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                                %line(get(gca,'xlim'), [Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)],'Color','green');
                                                %line(get(gca,'xlim'), [Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)],'Color','red');
                                            end
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(31 + 8*(TI)+TI+l)
                                            subplot(d,1,j)
                                            plot(SampleMean_vec(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                            title(sprintf('mean(Gneg%2d_{%2d%2d})',l,j))
                                            xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                            %line(get(gca,'xlim'), [Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)],'Color','green');
                                            line(get(gca,'xlim'), [Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)],'Color','red');
                                        end
                                        %saveas(figure(31 + 8*(TI)+TI+l),sprintf('TEST2 tracce Gneg_{%2d}',l))
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
                                figure(31 + 8*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(SampleMean_vec(d + 3*d^2 + (l - 1)*d + i,2:end))
                                title(sprintf('mean(K_{%2d%2d})',i,l))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                            end
                        end
                        %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(SampleMean_vec(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                        title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(31 + 8*(TI) + l)
                                    subplot(d,1,j)
                                    plot(SampleMean_vec(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                    title(sprintf('mean(G%2d_{%2d})',l,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(31 + 8*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(SampleMean_vec(2*d + 2*d^2 + (l - 1)*d + i,2:end))
                                title(sprintf('mean(K_{%2d%2d})',i,l))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                            end
                        end
                        %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                        title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(31 + 8*(TI) + l)
                                    subplot(d,1,j)
                                    plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                    title(sprintf('mean(G%2d_{%2d})',l,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(31 + 8*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(SampleMean_vec(2*d + 2*d^2 + (l - 1)*d + i,2:end))
                                title(sprintf('mean(K_{%2d%2d})',i,l))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                            end
                        end
                        %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                        title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(31 + 8*(TI) + l)
                                    subplot(d,1,j)
                                    plot(SampleMean_vec(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                    title(sprintf('mean(G%2d_{%2d})',l,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(31 + 8*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                plot(SampleMean_vec(3*d + d^2 + (l - 1)*d + i,2:end))
                                title(sprintf('mean(K_{%2d%2d})',i,l))
                                xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                %line(get(gca,'xlim'), [K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)],'Color','green');
                                %line(get(gca,'xlim'), [K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)],'Color','red');
                            end
                        end
                        %saveas(figure(31 + 8*(TI)),'TEST2 tracce K.jpg')
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(31 + 8*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        plot(SampleMean_vec(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2:end))
                                        title(sprintf('mean(G%2d_{%2d%2d})',l,i,j))
                                        xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                        %line(get(gca,'xlim'), [G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)],'Color','green');
                                        %line(get(gca,'xlim'), [G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)],'Color','red');
                                    end
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(31 + 8*(TI) + l)
                                    subplot(d,1,j)
                                    plot(SampleMean_vec(3*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2:end))
                                    title(sprintf('mean(G%2d_{%2d})',l,j))
                                    xlim([0,NBurnIn + NMCMC0 + NMCMC1])
                                    %line(get(gca,'xlim'), [G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)],'Color','green');
                                    %line(get(gca,'xlim'), [G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)],'Color','red');
                                end
                                %saveas(figure(31 + 8*(TI)+l),sprintf('TEST2 tracce G_{%2d}',l))
                            end
                        end
                    end
                end
            end
        end
    end
end