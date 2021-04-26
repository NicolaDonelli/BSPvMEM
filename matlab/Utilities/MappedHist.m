function MappedHist (eta_Mapped_MATRIX, d, TI, Burn_In, ...
    o_GMEM_TRUE, B_GMEM_TRUE, A_GMEM_TRUE, Aneg_GMEM_TRUE, F_GMEM_TRUE, ...
    K_GMEM_TRUE, G_GMEM_TRUE, Gneg_GMEM_TRUE, Str)

%%%%%%%%%%%%%%%%%%
%%% Histograms %%%
%%%%%%%%%%%%%%%%%%
Quantiles = [quantile(eta_Mapped_MATRIX(Burn_In + 1:end, :),0.025)' quantile(eta_Mapped_MATRIX(Burn_In + 1:end, :),0.975)'];


if isempty(o_GMEM_TRUE) == 0
    figure (19 + 6*(TI))
    for j = 1:d
        subplot(d,1,j)
        hist(eta_Mapped_MATRIX(Burn_In + 1:end, j), 20);
        ylabel(sprintf('\\omega^{MAPPED}_{%2d}',j))
        line([o_GMEM_TRUE(j) o_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
        %line([o_GMEM_MLE(j) o_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
        line([Quantiles(j,1) Quantiles(j,1)], get(gca,'ylim'),  'Color', 'green');
        line([Quantiles(j,2) Quantiles(j,2)], get(gca,'ylim'),  'Color', 'green');
    end
    

    figure(20 + 6*(TI))
    if Str.isdiagB == 0
        for j = 1:d
            for i = 1:d
                subplot(d,d,(i - 1)*d + j);
                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + (j - 1)*d + i), 20);
                ylabel(sprintf('\\beta^{MAPPED}_{%2d%2d}',i,j))
                line([B_GMEM_TRUE(i,j) B_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                %line([B_GMEM_MLE(i,j) B_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                line([Quantiles(d + (j - 1)*d + i,1) Quantiles(d + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                line([Quantiles(d + (j - 1)*d + i,2) Quantiles(d + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
            end
        end
    else
        for j = 1:d
            subplot(d,1,j)
            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + j), 20);
            ylabel(sprintf('\\beta^{MAPPED}_ {%2d}',j))
            line([B_GMEM_TRUE(j) B_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
            %line([B_GMEM_MLE(j) B_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
            line([Quantiles(d + j,1) Quantiles(d + j,1)], get(gca,'ylim'),  'Color', 'green');
            line([Quantiles(d + j,2) Quantiles(d + j,2)], get(gca,'ylim'),  'Color', 'green');
        end
    end

   

    figure(21 + 6*(TI))
    if Str.isdiagB == 0
        if Str.isdiagA == 0
            for j = 1:d
                for i = 1:d
                    subplot(d,d,(i - 1)*d + j);
                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + d^2 + (j - 1)*d + i), 20);
                    ylabel(sprintf('\\alpha^{MAPPED}_{%2d%2d}',i,j))
                    line([A_GMEM_TRUE(i,j) A_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                    %line([A_GMEM_MLE(i,j) A_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                    line([Quantiles(d + d^2 + (j - 1)*d + i,1) Quantiles(d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                    line([Quantiles(d + d^2 + (j - 1)*d + i,2) Quantiles(d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                end
            end
        else
            for j = 1:d
                subplot(d,1,j)
                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + d^2 + j), 20);
                ylabel(sprintf('\\alpha^{MAPPED}_{%2d}',j))
                line([A_GMEM_TRUE(j) A_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                %line([A_GMEM_MLE(j) A_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                line([Quantiles(d + d^2 + j,1) Quantiles(d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                line([Quantiles(d + d^2 + j,2) Quantiles(d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
            end
        end
    else
        if Str.isdiagA == 0
            for j = 1:d
                for i = 1:d
                    subplot(d,d,(i - 1)*d + j);
                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + d + (j - 1)*d + i), 20);
                    ylabel(sprintf('\\alpha^{MAPPED}_{%2d%2d}',i,j))
                    line([A_GMEM_TRUE(i,j) A_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                    %line([A_GMEM_MLE(i,j) A_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                    line([Quantiles(d + d + (j - 1)*d + i,1) Quantiles(d + d + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                    line([Quantiles(d + d + (j - 1)*d + i,2) Quantiles(d + d + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                end
            end
        else
            for j = 1:d
                subplot(d,1,j)
                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + d + j), 20);
                ylabel(sprintf('\\alpha^{MAPPED}_{%2d}',j))
                line([A_GMEM_TRUE(j) A_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                %line([A_GMEM_MLE(j) A_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                line([Quantiles(d + d + j,1) Quantiles(d + d + j,1)], get(gca,'ylim'),  'Color', 'green');
                line([Quantiles(d + d + j,2) Quantiles(d + d + j,2)], get(gca,'ylim'),  'Color', 'green');
            end
        end
    end
   


    if isempty(Str.x_neg) == 0
        figure(22 + 6*(TI))
        if Str.isdiagB == 0
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + (j - 1)*d + i), 20);
                            ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                            line([Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                            %line([Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                            line([Quantiles(d + 2*d^2 + (j - 1)*d + i,1) Quantiles(d + 2*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                            line([Quantiles(d + 2*d^2 + (j - 1)*d + i,2) Quantiles(d + 2*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + j), 20);
                        ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d}',j))
                        line([Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                        %line([Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                        line([Quantiles(d + 2*d^2 + j,1) Quantiles(d + 2*d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                        line([Quantiles(d + 2*d^2 + j,2) Quantiles(d + 2*d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                    end
                end
            else
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + (j - 1)*d + i), 20);
                            ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                            line([Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                            %line([Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                            line([Quantiles(2*d + d^2 + (j - 1)*d + i,1) Quantiles(2*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                            line([Quantiles(2*d + d^2 + (j - 1)*d + i,2) Quantiles(2*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + j), 20);
                        ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d}',j))
                        line([Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                        %line([Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                        line([Quantiles(2*d + d^2 + j,1) Quantiles(2*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                        line([Quantiles(2*d + d^2 + j,2) Quantiles(2*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                    end
                end
            end
        else
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + (j - 1)*d + i), 20);
                            ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                            line([Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                            %line([Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                            line([Quantiles(2*d + d^2 + (j - 1)*d + i,1) Quantiles(2*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                            line([Quantiles(2*d + d^2 + (j - 1)*d + i,2) Quantiles(2*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + j), 20);
                        ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d}',j))
                        line([Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                        %line([Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                        line([Quantiles(2*d + d^2 + j,1) Quantiles(2*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                        line([Quantiles(2*d + d^2 + j,2) Quantiles(2*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                    end
                end
            else
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d + (j - 1)*d + i), 20);
                            ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                            line([Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                            %line([Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                            line([Quantiles(2*d + d + (j - 1)*d + i,1) Quantiles(2*d + d + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                            line([Quantiles(2*d + d + (j - 1)*d + i,2) Quantiles(2*d + d + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d + j), 20);
                        ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d}',j))
                        line([Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                        %line([Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                        line([Quantiles(2*d + d + j,1) Quantiles(2*d + d + j,1)], get(gca,'ylim'),  'Color', 'green');
                        line([Quantiles(2*d + d + j,2) Quantiles(2*d + d + j,2)], get(gca,'ylim'),  'Color', 'green');
                    end
                end
            end
        end
    end


    if isempty(Str.x_lag) == 0
        figure(23 + 6*(TI))
        if isempty(Str.x_neg) == 0
            if Str.isdiagB == 0
                if Str.isdiagA == 0
                    if Str.isdiagAneg == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(d + 3*d^2 + (j - 1)*d + i,1) Quantiles(d + 3*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(d + 3*d^2 + (j - 1)*d + i,2) Quantiles(d + 3*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(d + 3*d^2 + j,1) Quantiles(d + 3*d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(d + 3*d^2 + j,2) Quantiles(d + 3*d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + 2*d^2 + j,1) Quantiles(2*d + 2*d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + 2*d^2 + j,2) Quantiles(2*d + 2*d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                    end
                else
                    if Str.isdiagAneg == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + 2*d^2 + j,1) Quantiles(2*d + 2*d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + 2*d^2 + j,2) Quantiles(2*d + 2*d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d^2 + (j - 1)*d + i,1) Quantiles(3*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d^2 + (j - 1)*d + i,2) Quantiles(3*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(3*d + d^2 + j,1) Quantiles(3*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(3*d + d^2 + j,2) Quantiles(3*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + 2*d^2 + j,1) Quantiles(2*d + 2*d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + 2*d^2 + j,2) Quantiles(2*d + 2*d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d^2 + (j - 1)*d + i,1) Quantiles(3*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d^2 + (j - 1)*d + i,2) Quantiles(3*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(3*d + d^2 + j,1) Quantiles(3*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(3*d + d^2 + j,2) Quantiles(3*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                    end
                else
                    if Str.isdiagAneg == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d^2 + (j - 1)*d + i,1) Quantiles(3*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d^2 + (j - 1)*d + i,2) Quantiles(3*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(3*d + d^2 + j,1) Quantiles(3*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(3*d + d^2 + j,2) Quantiles(3*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d + (j - 1)*d + i,1) Quantiles(3*d + d + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d + (j - 1)*d + i,2) Quantiles(3*d + d + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(3*d + d + j,1) Quantiles(3*d + d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(3*d + d + j,2) Quantiles(3*d + d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(d + 2*d^2 + (j - 1)*d + i,1) Quantiles(d + 2*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(d + 2*d^2 + (j - 1)*d + i,2) Quantiles(d + 2*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(d + 2*d^2 + j,1) Quantiles(d + 2*d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(d + 2*d^2 + j,2) Quantiles(d + 2*d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + d^2 + (j - 1)*d + i,1) Quantiles(2*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + d^2 + (j - 1)*d + i,2) Quantiles(2*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + d^2 + j,1) Quantiles(2*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + d^2 + j,2) Quantiles(2*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                end
            else
                if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + d^2 + (j - 1)*d + i,1) Quantiles(2*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + d^2 + (j - 1)*d + i,2) Quantiles(2*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + d^2 + j,1) Quantiles(2*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + d^2 + j,2) Quantiles(2*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + (j - 1)*d + i,1) Quantiles(3*d + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + (j - 1)*d + i,2) Quantiles(3*d + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(3*d + j,1) Quantiles(3*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(3*d + j,2) Quantiles(3*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                end
            end
        end
        
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
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 4*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(d + 4*d^2 + (l - 1)*d + i,1) Quantiles(d + 4*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(d + 4*d^2 + (l - 1)*d + i,2) Quantiles(d + 4*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 4*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,1) Quantiles(4*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,2) Quantiles(4*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,1) Quantiles(4*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,2) Quantiles(4*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,1) Quantiles(4*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,2) Quantiles(4*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,1) Quantiles(4*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,2) Quantiles(4*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 5*d + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(5*d + (l - 1)*d + i,1) Quantiles(5*d + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(5*d + (l - 1)*d + i,2) Quantiles(5*d + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 5*d + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 5*d + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(5*d + d*(TI) + (l-1)*d + j,1) Quantiles(5*d + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(5*d + d*(TI) + (l-1)*d + j,2) Quantiles(5*d + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 5*d + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(d + 3*d^2 + (l - 1)*d + i,1) Quantiles(d + 3*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(d + 3*d^2 + (l - 1)*d + i,2) Quantiles(d + 3*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d^2 + (l - 1)*d + i,1) Quantiles(3*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d^2 + (l - 1)*d + i,2) Quantiles(3*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d^2 + (l - 1)*d + i,1) Quantiles(3*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d^2 + (l - 1)*d + i,2) Quantiles(3*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d^2 + (l - 1)*d + i,1) Quantiles(3*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d^2 + (l - 1)*d + i,2) Quantiles(3*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(4*d + (l - 1)*d + i,1) Quantiles(4*d + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(4*d + (l - 1)*d + i,2) Quantiles(4*d + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(4*d + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(4*d + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
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
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(d + 3*d^2 + (l - 1)*d + i,1) Quantiles(d + 3*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(d + 3*d^2 + (l - 1)*d + i,2) Quantiles(d + 3*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagAneg == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d +d^2 + (l - 1)*d + i,1) Quantiles(3*d +d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d +d^2 + (l - 1)*d + i,2) Quantiles(3*d +d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d +d^2 + (l - 1)*d + i,1) Quantiles(3*d +d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d +d^2 + (l - 1)*d + i,2) Quantiles(3*d +d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagAneg == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d +d^2 + (l - 1)*d + i,1) Quantiles(3*d +d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d +d^2 + (l - 1)*d + i,2) Quantiles(3*d +d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(4*d + (l - 1)*d + i,1) Quantiles(4*d + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(4*d + (l - 1)*d + i,2) Quantiles(4*d + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                figure(24 + 6*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + (l - 1)*d + i), 20);
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(d + 2*d^2 + (l - 1)*d + i,1) Quantiles(d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(d + 2*d^2 + (l - 1)*d + i,2) Quantiles(d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(24 + 6*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(24 + 6*(TI)+l)
                                    subplot(d,1,j)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                                %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(24 + 6*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + (l - 1)*d + i), 20);
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + d^2 + (l - 1)*d + i,1) Quantiles(2*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + d^2 + (l - 1)*d + i,2) Quantiles(2*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(24 + 6*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(24 + 6*(TI)+l)
                                    subplot(d,1,j)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                                %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(24 + 6*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + (l - 1)*d + i), 20);
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + d^2 + (l - 1)*d + i,1) Quantiles(2*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + d^2 + (l - 1)*d + i,2) Quantiles(2*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(24 + 6*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(24 + 6*(TI)+l)
                                    subplot(d,1,j)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                                %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(24 + 6*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + (l - 1)*d + i), 20);
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(3*d + (l - 1)*d + i,1) Quantiles(3*d + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(3*d + (l - 1)*d + i,2) Quantiles(3*d + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(24 + 6*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(24 + 6*(TI)+l)
                                    subplot(d,1,j)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d*(TI) + (l-1)*d + j), 20);
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                                %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                            end
                        end
                    end
                end
            end
        end
    end
else
    figure (19 + 6*(TI))
    for j = 1:d
        subplot(d,1,j)
        hist(eta_Mapped_MATRIX(Burn_In + 1:end, j), 20);
        ylabel(sprintf('\\omega^{MAPPED}_{%2d}',j))
        %line([o_GMEM_TRUE(j) o_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
        %line([o_GMEM_MLE(j) o_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
        line([Quantiles(j,1) Quantiles(j,1)], get(gca,'ylim'),  'Color', 'green');
        line([Quantiles(j,2) Quantiles(j,2)], get(gca,'ylim'),  'Color', 'green');
    end
    %saveas(figure(19 + 6*(TI)),'TEST1 HIST o mapped.jpg')

    figure(20 + 6*(TI))
    if Str.isdiagB == 0
        for j = 1:d
            for i = 1:d
                subplot(d,d,(i - 1)*d + j);
                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + (j - 1)*d + i), 20);
                ylabel(sprintf('\\beta^{MAPPED}_{%2d%2d}',i,j))
                %line([B_GMEM_TRUE(i,j) B_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                %line([B_GMEM_MLE(i,j) B_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                line([Quantiles(d + (j - 1)*d + i,1) Quantiles(d + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                line([Quantiles(d + (j - 1)*d + i,2) Quantiles(d + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
            end
        end
    else
        for j = 1:d
            subplot(d,1,j)
            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + j), 20);
            ylabel(sprintf('\\beta^{MAPPED}_ {%2d}',j))
            %line([B_GMEM_TRUE(j) B_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
            %line([B_GMEM_MLE(j) B_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
            line([Quantiles(d + j,1) Quantiles(d + j,1)], get(gca,'ylim'),  'Color', 'green');
            line([Quantiles(d + j,2) Quantiles(d + j,2)], get(gca,'ylim'),  'Color', 'green');
        end
    end

    %saveas(figure(20 + 6*(TI)),'TEST1 HIST B mapped.jpg')

    figure(21 + 6*(TI))
    if Str.isdiagB == 0
        if Str.isdiagA == 0
            for j = 1:d
                for i = 1:d
                    subplot(d,d,(i - 1)*d + j);
                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + d^2 + (j - 1)*d + i), 20);
                    ylabel(sprintf('\\alpha^{MAPPED}_{%2d%2d}',i,j))
                    %line([A_GMEM_TRUE(i,j) A_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                    %line([A_GMEM_MLE(i,j) A_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                    line([Quantiles(d + d^2 + (j - 1)*d + i,1) Quantiles(d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                    line([Quantiles(d + d^2 + (j - 1)*d + i,2) Quantiles(d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                end
            end
        else
            for j = 1:d
                subplot(d,1,j)
                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + d^2 + j), 20);
                ylabel(sprintf('\\alpha^{MAPPED}_{%2d}',j))
                %line([A_GMEM_TRUE(j) A_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                %line([A_GMEM_MLE(j) A_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                line([Quantiles(d + d^2 + j,1) Quantiles(d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                line([Quantiles(d + d^2 + j,2) Quantiles(d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
            end
        end
    else
        if Str.isdiagA == 0
            for j = 1:d
                for i = 1:d
                    subplot(d,d,(i - 1)*d + j);
                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + d + (j - 1)*d + i), 20);
                    ylabel(sprintf('\\alpha^{MAPPED}_{%2d%2d}',i,j))
                    %line([A_GMEM_TRUE(i,j) A_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                    %line([A_GMEM_MLE(i,j) A_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                    line([Quantiles(d + d + (j - 1)*d + i,1) Quantiles(d + d + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                    line([Quantiles(d + d + (j - 1)*d + i,2) Quantiles(d + d + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                end
            end
        else
            for j = 1:d
                subplot(d,1,j)
                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + d + j), 20);
                ylabel(sprintf('\\alpha^{MAPPED}_{%2d}',j))
                %line([A_GMEM_TRUE(j) A_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                %line([A_GMEM_MLE(j) A_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                line([Quantiles(d + d + j,1) Quantiles(d + d + j,1)], get(gca,'ylim'),  'Color', 'green');
                line([Quantiles(d + d + j,2) Quantiles(d + d + j,2)], get(gca,'ylim'),  'Color', 'green');
            end
        end
    end
    %saveas(figure(21 + 6*(TI)),'TEST1 HIST A mapped.jpg')


    if isempty(Str.x_neg) == 0
        figure(22 + 6*(TI))
        if Str.isdiagB == 0
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + (j - 1)*d + i), 20);
                            ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                            %line([Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                            %line([Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                            line([Quantiles(d + 2*d^2 + (j - 1)*d + i,1) Quantiles(d + 2*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                            line([Quantiles(d + 2*d^2 + (j - 1)*d + i,2) Quantiles(d + 2*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + j), 20);
                        ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d}',j))
                        %line([Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                        %line([Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                        line([Quantiles(d + 2*d^2 + j,1) Quantiles(d + 2*d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                        line([Quantiles(d + 2*d^2 + j,2) Quantiles(d + 2*d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                    end
                end
            else
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + (j - 1)*d + i), 20);
                            ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                            %line([Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                            %line([Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                            line([Quantiles(2*d + d^2 + (j - 1)*d + i,1) Quantiles(2*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                            line([Quantiles(2*d + d^2 + (j - 1)*d + i,2) Quantiles(2*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + j), 20);
                        ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d}',j))
                        %line([Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                        %line([Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                        line([Quantiles(2*d + d^2 + j,1) Quantiles(2*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                        line([Quantiles(2*d + d^2 + j,2) Quantiles(2*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                    end
                end
            end
        else
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + (j - 1)*d + i), 20);
                            ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                            %line([Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                            %line([Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                            line([Quantiles(2*d + d^2 + (j - 1)*d + i,1) Quantiles(2*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                            line([Quantiles(2*d + d^2 + (j - 1)*d + i,2) Quantiles(2*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + j), 20);
                        ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d}',j))
                        %line([Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                        %line([Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                        line([Quantiles(2*d + d^2 + j,1) Quantiles(2*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                        line([Quantiles(2*d + d^2 + j,2) Quantiles(2*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                    end
                end
            else
                if Str.isdiagAneg == 0
                    for j = 1:d
                        for i = 1:d
                            subplot(d,d,(i - 1)*d + j);
                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d + (j - 1)*d + i), 20);
                            ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                            %line([Aneg_GMEM_TRUE(i,j) Aneg_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                            %line([Aneg_GMEM_MLE(i,j) Aneg_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                            line([Quantiles(2*d + d + (j - 1)*d + i,1) Quantiles(2*d + d + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                            line([Quantiles(2*d + d + (j - 1)*d + i,2) Quantiles(2*d + d + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                        end
                    end
                else
                    for j = 1:d
                        subplot(d,1,j)
                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d + j), 20);
                        ylabel(sprintf('\\alpha^{(-) MAPPED}_{%2d}',j))
                        %line([Aneg_GMEM_TRUE(j) Aneg_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                        %line([Aneg_GMEM_MLE(j) Aneg_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                        line([Quantiles(2*d + d + j,1) Quantiles(2*d + d + j,1)], get(gca,'ylim'),  'Color', 'green');
                        line([Quantiles(2*d + d + j,2) Quantiles(2*d + d + j,2)], get(gca,'ylim'),  'Color', 'green');
                    end
                end
            end
        end
        %saveas(figure(22 + 6*(TI)),'TEST1 HIST Aneg mapped.jpg')
    end


    if isempty(Str.x_lag) == 0
        figure(23 + 6*(TI))
        if isempty(Str.x_neg) == 0
            if Str.isdiagB == 0
                if Str.isdiagA == 0
                    if Str.isdiagAneg == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    %line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(d + 3*d^2 + (j - 1)*d + i,1) Quantiles(d + 3*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(d + 3*d^2 + (j - 1)*d + i,2) Quantiles(d + 3*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                %line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(d + 3*d^2 + j,1) Quantiles(d + 3*d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(d + 3*d^2 + j,2) Quantiles(d + 3*d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    %line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                %line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + 2*d^2 + j,1) Quantiles(2*d + 2*d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + 2*d^2 + j,2) Quantiles(2*d + 2*d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                    end
                else
                    if Str.isdiagAneg == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    %line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                %line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + 2*d^2 + j,1) Quantiles(2*d + 2*d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + 2*d^2 + j,2) Quantiles(2*d + 2*d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    %line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d^2 + (j - 1)*d + i,1) Quantiles(3*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d^2 + (j - 1)*d + i,2) Quantiles(3*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                %line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(3*d + d^2 + j,1) Quantiles(3*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(3*d + d^2 + j,2) Quantiles(3*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    %line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                %line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + 2*d^2 + j,1) Quantiles(2*d + 2*d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + 2*d^2 + j,2) Quantiles(2*d + 2*d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    %line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d^2 + (j - 1)*d + i,1) Quantiles(3*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d^2 + (j - 1)*d + i,2) Quantiles(3*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                %line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(3*d + d^2 + j,1) Quantiles(3*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(3*d + d^2 + j,2) Quantiles(3*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                    end
                else
                    if Str.isdiagAneg == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    %line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d^2 + (j - 1)*d + i,1) Quantiles(3*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d^2 + (j - 1)*d + i,2) Quantiles(3*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                %line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(3*d + d^2 + j,1) Quantiles(3*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(3*d + d^2 + j,2) Quantiles(3*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    %line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d + (j - 1)*d + i,1) Quantiles(3*d + d + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d + (j - 1)*d + i,2) Quantiles(3*d + d + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                %line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(3*d + d + j,1) Quantiles(3*d + d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(3*d + d + j,2) Quantiles(3*d + d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    %line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(d + 2*d^2 + (j - 1)*d + i,1) Quantiles(d + 2*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(d + 2*d^2 + (j - 1)*d + i,2) Quantiles(d + 2*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                %line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(d + 2*d^2 + j,1) Quantiles(d + 2*d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(d + 2*d^2 + j,2) Quantiles(d + 2*d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    %line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + d^2 + (j - 1)*d + i,1) Quantiles(2*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + d^2 + (j - 1)*d + i,2) Quantiles(2*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                %line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + d^2 + j,1) Quantiles(2*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + d^2 + j,2) Quantiles(2*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                end
            else
                if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    %line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + d^2 + (j - 1)*d + i,1) Quantiles(2*d + d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + d^2 + (j - 1)*d + i,2) Quantiles(2*d + d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                %line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + d^2 + j,1) Quantiles(2*d + d^2 + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + d^2 + j,2) Quantiles(2*d + d^2 + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                else
                        if Str.isdiagF == 0
                            for j = 1:d
                                for i = 1:d
                                    subplot(d,d,(i - 1)*d + j);
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + (j - 1)*d + i), 20);
                                    ylabel(sprintf('\\phi^{MAPPED}_{%2d%2d}',i,j))
                                    %line([F_GMEM_TRUE(i,j) F_GMEM_TRUE(i,j)], get(gca,'ylim'),  'Color', 'red');
                                    %line([F_GMEM_MLE(i,j) F_GMEM_MLE(i,j)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + (j - 1)*d + i,1) Quantiles(3*d + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + (j - 1)*d + i,2) Quantiles(3*d + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                        else
                            for j = 1:d
                                subplot(d,1,j)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + j), 20);
                                ylabel(sprintf('\\phi^{MAPPED}_{%2d}',j))
                                %line([F_GMEM_TRUE(j) F_GMEM_TRUE(j)], get(gca,'ylim'),  'Color', 'red');
                                %line([F_GMEM_MLE(j) F_GMEM_MLE(j)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(3*d + j,1) Quantiles(3*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(3*d + j,2) Quantiles(3*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                end
            end
        end
        
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
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 4*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(d + 4*d^2 + (l - 1)*d + i,1) Quantiles(d + 4*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(d + 4*d^2 + (l - 1)*d + i,2) Quantiles(d + 4*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 4*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(d + 4*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,1) Quantiles(4*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,2) Quantiles(4*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 3*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,1) Quantiles(4*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,2) Quantiles(4*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(3*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,1) Quantiles(4*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,2) Quantiles(4*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            end
                        else
                            if Str.isdiagF == 0
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,1) Quantiles(4*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(4*d + d^2 + (l - 1)*d + i,2) Quantiles(4*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for i = 1:d
                                        figure(24 + 6*(TI))
                                        subplot(d,TI,(i - 1)*(TI) + l)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 5*d + (l - 1)*d + i), 20);
                                        ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                        %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(5*d + (l - 1)*d + i,1) Quantiles(5*d + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(5*d + (l - 1)*d + i,2) Quantiles(5*d + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                                if Str.isdiagG == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI) + TI + l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 5*d + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(5*d + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                            
                                        end
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 5*d + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                            %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(5*d + d*(TI) + (l-1)*d + j,1) Quantiles(5*d + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(5*d + d*(TI) + (l-1)*d + j,2) Quantiles(5*d + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                    end
                                    if Str.isdiagGneg == 0
                                        for l = 1:(TI)
                                            for j = 1:d
                                                for i = 1:d
                                                    figure(24 + 6*(TI)+TI+l)
                                                    subplot(d,d,(i - 1)*d + j)
                                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end,  5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                    ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                    %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                    %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                    line([Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                    line([Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                                end
                                            end
                                            
                                        end
                                    else
                                        for l = 1:(TI)
                                            for j = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,1,j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 5*d + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                                %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(5*d + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(d + 3*d^2 + (l - 1)*d + i,1) Quantiles(d + 3*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(d + 3*d^2 + (l - 1)*d + i,2) Quantiles(d + 3*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d^2 + (l - 1)*d + i,1) Quantiles(3*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d^2 + (l - 1)*d + i,2) Quantiles(3*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d^2 + (l - 1)*d + i,1) Quantiles(3*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d^2 + (l - 1)*d + i,2) Quantiles(3*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d^2 + (l - 1)*d + i,1) Quantiles(3*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d^2 + (l - 1)*d + i,2) Quantiles(3*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(4*d + (l - 1)*d + i,1) Quantiles(4*d + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(4*d + (l - 1)*d + i,2) Quantiles(4*d + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(4*d + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(4*d + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
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
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(d + 3*d^2 + (l - 1)*d + i,1) Quantiles(d + 3*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(d + 3*d^2 + (l - 1)*d + i,2) Quantiles(d + 3*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(d + 3*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagAneg == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d +d^2 + (l - 1)*d + i,1) Quantiles(3*d +d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d +d^2 + (l - 1)*d + i,2) Quantiles(3*d +d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2) Quantiles(2*d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d +d^2 + (l - 1)*d + i,1) Quantiles(3*d +d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d +d^2 + (l - 1)*d + i,2) Quantiles(3*d +d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagAneg == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d +d^2 + (l - 1)*d + i,1) Quantiles(3*d +d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d +d^2 + (l - 1)*d + i,2) Quantiles(3*d +d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(3*d +d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(24 + 6*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + (l - 1)*d + i), 20);
                                    ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                    %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(4*d + (l - 1)*d + i,1) Quantiles(4*d + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(4*d + (l - 1)*d + i,2) Quantiles(4*d + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(24 + 6*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                            ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI) + TI + l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d*(TI) + d^2*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d + j,1) Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d + j,2) Quantiles(4*d + d*(TI) + d^2*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(24 + 6*(TI)+l)
                                        subplot(d,1,j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                    %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(24 + 6*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                hist(eta_Mapped_MATRIX(Burn_In + 1:end,  4*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                                ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d%2d}',l,i,j))
                                                %line([Gneg_GMEM_TRUE(i,j,l) Gneg_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                                %line([Gneg_GMEM_MLE(i,j,l) Gneg_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                                line([Quantiles(4*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(4*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                                line([Quantiles(4*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(4*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(24 + 6*(TI)+TI+l)
                                            subplot(d,1,j)
                                            hist(eta_Mapped_MATRIX(Burn_In + 1:end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j), 20);
                                            ylabel(sprintf('\\gamma%2d^{(-) MAPPED}_{%2d}',l,j))
                                            %line([Gneg_GMEM_TRUE(j,l) Gneg_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                            %line([Gneg_GMEM_MLE(j,l) Gneg_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                            line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                            line([Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2) Quantiles(4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
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
                                figure(24 + 6*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + (l - 1)*d + i), 20);
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(d + 2*d^2 + (l - 1)*d + i,1) Quantiles(d + 2*d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(d + 2*d^2 + (l - 1)*d + i,2) Quantiles(d + 2*d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(24 + 6*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(24 + 6*(TI)+l)
                                    subplot(d,1,j)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, d + 2*d^2 + d*(TI) + (l-1)*d + j), 20);
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(d + 2*d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                                %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(24 + 6*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + (l - 1)*d + i), 20);
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + d^2 + (l - 1)*d + i,1) Quantiles(2*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + d^2 + (l - 1)*d + i,2) Quantiles(2*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(24 + 6*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(24 + 6*(TI)+l)
                                    subplot(d,1,j)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                                %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                            end
                        end
                    end
                else
                    if Str.isdiagA == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(24 + 6*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + (l - 1)*d + i), 20);
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(2*d + d^2 + (l - 1)*d + i,1) Quantiles(2*d + d^2 + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(2*d + d^2 + (l - 1)*d + i,2) Quantiles(2*d + d^2 + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(24 + 6*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(24 + 6*(TI)+l)
                                    subplot(d,1,j)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 2*d + d^2 + d*(TI) + (l-1)*d + j), 20);
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,1) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,2) Quantiles(2*d + d^2 + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                                %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(24 + 6*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + (l - 1)*d + i), 20);
                                ylabel(sprintf('\\kappa^{MAPPED}_{%2d%2d}',i,l))
                                %line([K_GMEM_TRUE(i,l) K_GMEM_TRUE(i,l)], get(gca,'ylim'),  'Color', 'red');
                                %line([K_GMEM_MLE(i,l) K_GMEM_MLE(i,l)], get(gca,'ylim'),  'Color', 'yellow');
                                line([Quantiles(3*d + (l - 1)*d + i,1) Quantiles(3*d + (l - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                line([Quantiles(3*d + (l - 1)*d + i,2) Quantiles(3*d + (l - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(24 + 6*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i), 20);
                                        ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        %line([G_GMEM_TRUE(i,j,l) G_GMEM_TRUE(i,j,l)], get(gca,'ylim'),  'Color', 'red');
                                        %line([G_GMEM_MLE(i,j,l) G_GMEM_MLE(i,j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                        line([Quantiles(3*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1) Quantiles(3*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,1)], get(gca,'ylim'),  'Color', 'green');
                                        line([Quantiles(3*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2) Quantiles(3*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i,2)], get(gca,'ylim'),  'Color', 'green');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(24 + 6*(TI)+l)
                                    subplot(d,1,j)
                                    hist(eta_Mapped_MATRIX(Burn_In + 1:end, 3*d + d*(TI) + (l-1)*d + j), 20);
                                    ylabel(sprintf('\\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    %line([G_GMEM_TRUE(j,l) G_GMEM_TRUE(j,l)], get(gca,'ylim'),  'Color', 'red');
                                    %line([G_GMEM_MLE(j,l) G_GMEM_MLE(j,l)], get(gca,'ylim'),  'Color', 'yellow');
                                    line([Quantiles(3*d + d*(TI) + (l-1)*d + j,1) Quantiles(3*d + d*(TI) + (l-1)*d + j,1)], get(gca,'ylim'),  'Color', 'green');
                                    line([Quantiles(3*d + d*(TI) + (l-1)*d + j,2) Quantiles(3*d + d*(TI) + (l-1)*d + j,2)], get(gca,'ylim'),  'Color', 'green');
                                end
                                %saveas(figure(24 + 6*(TI) + l),sprintf('TEST2 tracce G_%2d',l))
                            end
                        end
                    end
                end
            end
        end
    end
end
