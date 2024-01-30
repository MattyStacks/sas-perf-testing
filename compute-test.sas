/* Change these two variables to add more data to your output dataset. */
%let num_rows = 100;
%let num_iterations = 1;

Data test_data;
    do i = 1 to &num_rows;
        x = rand("Uniform");
        y = rand("Uniform");
        z = rand("Uniform");
        output;
    end;
run;

%macro run_benchmark;
    %local t1 t2 elapsed_seconds;
    %let t1 = %sysfunc(datetime());

    data _null_;
        set test_data;
        array vals[3] x y z;
        do j = 1 to &num_iterations;
            sum = sum(of vals[*]);
            mean = mean(of vals[*]);
            std_dev = std(of vals[*]);
        end;
    run;

    %let t2 = %sysfunc(datetime());
    %let elapsed_seconds = %sysevalf((&t2 - &t1), integer);
    %put Execution time for benchmark: &elapsed_seconds;
%mend;

%run_benchmark;
