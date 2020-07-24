    hold on
    plot(log_omeg(1,:),log_lam(1,:),':g*');
    plot(log_omeg(2,:),log_lam(2,:),':g*');
    plot(log_omeg(6,:),log_lam(6,:),':g*');
    plot(log_omeg(5,:),log_lam(5,:),':k*');
    plot(log_omeg(3,:),log_lam(3,:),':k*');
    plot(log_omeg(4,:),log_lam(4,:),':k*');
    title("Largest Eigenvalue v. Perturbation, 2-D Lattice");
    xlabel("log(omega)");
    ylabel("1/log(lambda)");
