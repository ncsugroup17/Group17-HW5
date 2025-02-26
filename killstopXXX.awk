BEGIN {
    # Stop words 
    stop["is"];
    stop["the"];
    stop["in"]; 
    stop["but"]; 
    stop["can"]; 
    stop["a"]; 
    stop["the"];
    stop["is"]; 
    stop["in"]; 
    stop["of"]; 
    stop["to"]; 
    stop["a"]; 
    stop["that"];
    stop["it"]; 
    stop["for"];
    stop["on"]; 
    stop["with"];
    stop["as"]; 
    stop["this"]; 
    stop["was"]; 
    stop["at"]; 
    stop["by"]; 
    stop["an"]; 
    stop["be"]; 
    stop["from"];
    stop["or"]; 
    stop["are"];
}

{
    for (i = 1; i <= NF; i++) {
        if (!($i in stop)) {
            printf("%s ", $i);
        }
    }
    printf("\n");
}