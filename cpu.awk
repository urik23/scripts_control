BEGIN	{a = 0  # En realitat, no cal, perque ja s'inicialitza a zero.
         }

	{cmd = "./extractCpu.sh " $1
	 while ((cmd | getline var) > 0)
	    {
             # printf("var = %s\n", var)	# No cal, es nomes per debug.
	     a += var
	    }
	 close(cmd)
	}

END	{
         #print a	# No cal, es nomes per debug.
	 print a / NR
	}

