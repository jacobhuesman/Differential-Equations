clear;

i = [0.5, 6.0, 10.5];
D = [16, 32, 48];
Y_r = 10E6;

p = (1 + i./100).^(1/12);

C = (Y_r .* (p - 1)) ./ (p .* (p.^(12.*D') - 1));
P = 12.*D'.*C;

u = @(t) 1.0 .* (t >= 0);
y = @(n, C, p, D) C ./ (p - 1) .* ( (p.^(n + 1) - 1).*u(n) - (p.^(n + 1 - 12*D) - 1).*u(n - 12*D));
for j = 1:1:3
    n = 0:1:(D(j)*12);
    P_t = (n+1) .* C(j,:)';
    y_t = y(n, C(j,:)', p', D(j));
    for k = 1:1:3     
        subplot(3,3,((j-1)*3+k-1)+1);
        plot(n, y_t(k,:), '-', n, P_t(k,:), '--', 'color', [0,0,0], 'linewidth', 1);
        title("APY of " + string(i(k))+"% over " + string(D(j)) + " years");
        legend('Value of Account', 'Principle Invested', 'Location','northwest');
        xlabel('Months');
        grid on;
    end
end