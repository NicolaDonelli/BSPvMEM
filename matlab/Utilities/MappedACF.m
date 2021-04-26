function MappedACF(eta_Mapped_MATRIX, d, TI, Burn_In, NLAGS, yToll, Str)


%%%%%%%%%%%%
%%% ACFs %%%
%%%%%%%%%%%%

figure(13 + 4*(TI));
for j = 1:d
    subplot (d,1,j)
    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, j), NLAGS);
    area(LAGS, ACF, 'FaceColor', 'k')
    ylim([-0.5 1])
    ylabel(sprintf('ACF \\omega^{MAPPED}_%2d',j))
    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
end


figure(14 + 4*(TI))
if Str.isdiagB == 0
    for j = 1:d
        for i = 1:d
            subplot(d,d,(i - 1)*d + j);
            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + (j - 1)*d + i), NLAGS);
            area(LAGS, ACF, 'FaceColor', 'k')
            ylim([-0.5 1])
            ylabel(sprintf('ACF \\beta^{MAPPED}_{%2d%2d}',i,j))
            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
        end
    end
else
    for j = 1:d
        subplot (d,1,j)
        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + j), NLAGS);
        area(LAGS, ACF, 'FaceColor', 'k')
        ylim([-0.5 1])
        ylabel(sprintf('ACF \\beta^{MAPPED}_%2d',j))
        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
    end
end


figure(15 + 4*(TI))
if Str.isdiagB == 0
    if Str.isdiagA == 0
        for j = 1:d
            for i = 1:d
                subplot(d,d,(i - 1)*d + j);
                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + d^2 + (j - 1)*d + i), NLAGS);
                area(LAGS, ACF, 'FaceColor', 'k')
                ylim([-0.5 1])
                ylabel(sprintf('ACF \\alpha^{MAPPED}_{%2d%2d}',i,j))
                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
            end
        end
    else
        for j = 1:d
            subplot(d,1,j)
            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + d^2 + j), NLAGS);
            area(LAGS, ACF, 'FaceColor', 'k')
            ylim([-0.5 1])
            ylabel(sprintf('ACF \\alpha^{MAPPED}_%2d',j))
            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
        end
    end
else
    if Str.isdiagA == 0
        for j = 1:d
            for i = 1:d
                subplot(d,d,(i - 1)*d + j);
                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + d + (j - 1)*d + i), NLAGS);
                area(LAGS, ACF, 'FaceColor', 'k')
                ylim([-0.5 1])
                ylabel(sprintf('ACF \\alpha^{MAPPED}_{%2d%2d}',i,j))
                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
            end
        end
    else
        for j = 1:d
            subplot(d,1,j)
            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + d + j), NLAGS);
            area(LAGS, ACF, 'FaceColor', 'k')
            ylim([-0.5 1])
            ylabel(sprintf('ACF \\alpha^{MAPPED}_%2d',j))
            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
        end
    end
end



if isempty(Str.x_neg) == 0
    figure(16 + 4*(TI))
    if Str.isdiagB == 0
        if Str.isdiagA == 0
            if Str.isdiagAneg == 0
                for j = 1:d
                    for i = 1:d
                        subplot(d,d,(i - 1)*d + j);
                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + (j - 1)*d + i), NLAGS);
                        area(LAGS, ACF, 'FaceColor', 'k')
                        ylim([-0.5 1])
                        ylabel(sprintf('ACF \\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                    end
                end
            else
                for j = 1:d
                    subplot(d,1,j)
                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + j), NLAGS);
                    area(LAGS, ACF, 'FaceColor', 'k')
                    ylim([-0.5 1])
                    ylabel(sprintf('ACF \\alpha^{(-) MAPPED}_%2d',j))
                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                end
            end
        else
            if Str.isdiagAneg == 0
                for j = 1:d
                    for i = 1:d
                        subplot(d,d,(i - 1)*d + j);
                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i), NLAGS);
                        area(LAGS, ACF, 'FaceColor', 'k')
                        ylim([-0.5 1])
                        ylabel(sprintf('ACF \\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                    end
                end
            else
                for j = 1:d
                    subplot(d,1,j)
                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + j), NLAGS);
                    area(LAGS, ACF, 'FaceColor', 'k')
                    ylim([-0.5 1])
                    ylabel(sprintf('ACF \\alpha^{(-) MAPPED}_%2d',j))
                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                end
            end
        end
    else
        if Str.isdiagA == 0
            if Str.isdiagAneg == 0
                for j = 1:d
                    for i = 1:d
                        subplot(d,d,(i - 1)*d + j);
                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i), NLAGS);
                        area(LAGS, ACF, 'FaceColor', 'k')
                        ylim([-0.5 1])
                        ylabel(sprintf('ACF \\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                    end
                end
            else
                for j = 1:d
                    subplot(d,1,j)
                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + j), NLAGS);
                    area(LAGS, ACF, 'FaceColor', 'k')
                    ylim([-0.5 1])
                    ylabel(sprintf('ACF \\alpha^{(-) MAPPED}_%2d',j))
                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                end
            end
        else
            if Str.isdiagAneg == 0
                for j = 1:d
                    for i = 1:d
                        subplot(d,d,(i - 1)*d + j);
                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d + (j - 1)*d + i), NLAGS);
                        area(LAGS, ACF, 'FaceColor', 'k')
                        ylim([-0.5 1])
                        ylabel(sprintf('ACF \\alpha^{(-) MAPPED}_{%2d%2d}',i,j))
                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                    end
                end
            else
                for j = 1:d
                    subplot(d,1,j)
                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d + j), NLAGS);
                    area(LAGS, ACF, 'FaceColor', 'k')
                    ylim([-0.5 1])
                    ylabel(sprintf('ACF \\alpha^{(-) MAPPED}_%2d',j))
                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                end
            end
        end
    end
end



if isempty(Str.x_lag) == 0
    figure(17 + 4*(TI))
    if isempty(Str.x_neg) == 0
        if Str.isdiagB == 0
            if Str.isdiagA == 0
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k')
                                ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k')
                            ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');    ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');    ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                end
            else
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
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
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                end
            else
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
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
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 2*d^2 + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                end
            else
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
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
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d^2 + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                end
            else
                if Str.isdiagAneg == 0
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for j = 1:d
                            for i = 1:d
                                subplot(d,d,(i - 1)*d + j);
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d + (j - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d%2d}',i,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                    else
                        for j = 1:d
                            subplot(d,1,j)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + d + j),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');        ylabel(sprintf('ACF \\phi^{MAPPED}_{%2d}',j))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
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
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
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
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
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
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
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
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            end
                        end
                    else
                        if Str.isdiagF == 0
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            end
                        else
                            for l = 1:(TI)
                                for i = 1:d
                                    figure(18 + 4*(TI))
                                    subplot(d,TI,(i - 1)*(TI) + l)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + (l - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                            if Str.isdiagG == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI) + l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                        
                                    end
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                                if Str.isdiagGneg == 0
                                    for l = 1:(TI)
                                        for j = 1:d
                                            for i = 1:d
                                                figure(18 + 4*(TI)+TI+l)
                                                subplot(d,d,(i - 1)*d + j)
                                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                                area(LAGS, ACF, 'FaceColor', 'k');
                                                ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                                ylim([-0.5,1])
                                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                            end
                                        end
                                        
                                    end
                                else
                                    for l = 1:(TI)
                                        for j = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,1,j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 5*d + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
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
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
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
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                        end
                    end
                else
                    if Str.isdiagF == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
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
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 - d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 - d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 - d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 4*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        end
                    end
                else
                    if Str.isdiagAneg == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
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
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 3*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        end
                    end
                else
                    if Str.isdiagAneg == 0
                        for l = 1:(TI)
                            for i = 1:d
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + 2*d^2 - d^2 + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        end
                    else
                        for l = 1:(TI)
                            for i = 1:d
                                figure(18 + 4*(TI))
                                subplot(d,TI,(i - 1)*(TI) + l)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + (l - 1)*d + i),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                        end
                        
                        if Str.isdiagG == 0
                            for l = 1:(TI)
                                for j = 1:d
                                    for i = 1:d
                                        figure(18 + 4*(TI) + l)
                                        subplot(d,d,(i - 1)*d + j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + d^2*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + d^2*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                    end
                                    
                                end
                            end
                        else
                            for l = 1:(TI)
                                for j = 1:d
                                    figure(18 + 4*(TI)+l)
                                    subplot(d,1,j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + (l-1)*d + j),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                                
                            end
                            if Str.isdiagGneg == 0
                                for l = 1:(TI)
                                    for j = 1:d
                                        for i = 1:d
                                            figure(18 + 4*(TI)+TI+l)
                                            subplot(d,d,(i - 1)*d + j)
                                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                            area(LAGS, ACF, 'FaceColor', 'k');
                                            ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                            ylim([-0.5,1])
                                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                        end
                                    end
                                    
                                end
                            else
                                for l = 1:(TI)
                                    for j = 1:d
                                        figure(18 + 4*(TI)+TI+l)
                                        subplot(d,1,j)
                                        [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 4*d + d*(TI) + d*(TI) + (l-1)*d + j),NLAGS);
                                        area(LAGS, ACF, 'FaceColor', 'k');
                                        ylabel(sprintf('ACF \\gamma^{(-)}%2d^{MAPPED}_{%2d}',l,j))
                                        ylim([-0.5,1])
                                        line(get(gca,'xlim'),[yToll yToll], 'Color','red');
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
                            figure(18 + 4*(TI))
                            subplot(d,TI,(i - 1)*(TI) + l)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 - d^2 + (l - 1)*d + i),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');
                            ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                    
                    if Str.isdiagG == 0
                        for l = 1:(TI)
                            for j = 1:d
                                for i = 1:d
                                    figure(18 + 4*(TI) + l)
                                    subplot(d,d,(i - 1)*d + j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 - d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                        end
                    else
                        for l = 1:(TI)
                            for j = 1:d
                                figure(18 + 4*(TI)+l)
                                subplot(d,1,j)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, d + 3*d^2 - d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                            
                        end
                    end
                else
                    for l = 1:(TI)
                        for i = 1:d
                            figure(18 + 4*(TI))
                            subplot(d,TI,(i - 1)*(TI) + l)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 - d^2 + (l - 1)*d + i),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');
                            ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                    
                    if Str.isdiagG == 0
                        for l = 1:(TI)
                            for j = 1:d
                                for i = 1:d
                                    figure(18 + 4*(TI) + l)
                                    subplot(d,d,(i - 1)*d + j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 - d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                        end
                    else
                        for l = 1:(TI)
                            for j = 1:d
                                figure(18 + 4*(TI)+l)
                                subplot(d,1,j)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 - d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                            
                        end
                    end
                end
            else
                if Str.isdiagA == 0
                    for l = 1:(TI)
                        for i = 1:d
                            figure(18 + 4*(TI))
                            subplot(d,TI,(i - 1)*(TI) + l)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 - d^2 + (l - 1)*d + i),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');
                            ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                    
                    if Str.isdiagG == 0
                        for l = 1:(TI)
                            for j = 1:d
                                for i = 1:d
                                    figure(18 + 4*(TI) + l)
                                    subplot(d,d,(i - 1)*d + j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 - d^2 + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                        end
                    else
                        for l = 1:(TI)
                            for j = 1:d
                                figure(18 + 4*(TI)+l)
                                subplot(d,1,j)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 2*d + 2*d^2 - d^2 + d*(TI) + (l-1)*d + j),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                            
                        end
                    end
                else
                    for l = 1:(TI)
                        for i = 1:d
                            figure(18 + 4*(TI))
                            subplot(d,TI,(i - 1)*(TI) + l)
                            [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + (l - 1)*d + i),NLAGS);
                            area(LAGS, ACF, 'FaceColor', 'k');
                            ylabel(sprintf('ACF \\kappa^{MAPPED}_{%2d}',i))
                            ylim([-0.5,1])
                            line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                        end
                    end
                    
                    if Str.isdiagG == 0
                        for l = 1:(TI)
                            for j = 1:d
                                for i = 1:d
                                    figure(18 + 4*(TI) + l)
                                    subplot(d,d,(i - 1)*d + j)
                                    [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d*(TI) + (l-1)*d^2 + (j - 1)*d + i),NLAGS);
                                    area(LAGS, ACF, 'FaceColor', 'k');
                                    ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d%2d}',l,i,j))
                                    ylim([-0.5,1])
                                    line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                                end
                            end
                            
                        end
                    else
                        for l = 1:(TI)
                            for j = 1:d
                                figure(18 + 4*(TI)+l)
                                subplot(d,1,j)
                                [ACF, LAGS] = autocorr(eta_Mapped_MATRIX(Burn_In + 1 : end, 3*d + d*(TI) + (l-1)*d + j),NLAGS);
                                area(LAGS, ACF, 'FaceColor', 'k');
                                ylabel(sprintf('ACF \\gamma%2d^{MAPPED}_{%2d}',l,j))
                                ylim([-0.5,1])
                                line(get(gca,'xlim'),[yToll yToll], 'Color','red');
                            end
                            
                        end
                    end
                end
            end
        end
    end
end
