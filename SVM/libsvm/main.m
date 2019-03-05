load fisheriris;

for i=1:max(size(meas,2))
    t = meas(:,i);
    t = (t-min(t(:)))./(max(t(:))-min(t(:)));
    meas(:,i) = t;
end 