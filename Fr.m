function [ G ] = Fr( s )

% G=4./(exp(2.*s)+exp(-2.*s)+2);

G=1 - (tanh(s).^2);

end
