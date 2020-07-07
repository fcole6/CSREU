hold on

c = hsv(10);

for i = 1:10
    k = 61;
    N_vals_i = N_vals(11-i,:);
    for j = 1:60
        if N_vals_i(j) == 0
            N_vals_i = N_vals_i(1:j-1);
            k = j-1;
            break;
        end
    end
    lam_vals_i = log(lam_vals(11-i,1:k));
    plot(N_vals_i,lam_vals_i,N_vals_i(end),lam_vals_i(end),'k*');
    txt = ['\omega = ', num2str(omeg_vals(11-i))];
    text(N_vals_i(1),lam_vals_i(1),txt);
end

colororder(c);
nvals = [0,2];
caxis(nvals);
xlabel('Side Length');
xticks(51:50:651);
xtickangle(45);
ylabel('log( E-Val with Largest Re Part )');
title('Log( Max e-val ) vs. Side Length of Perturbed Graph - 2-D Lattice');