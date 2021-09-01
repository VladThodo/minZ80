## Disclaimer

This schematic is still a work in progress. The project was built "on the go", with this schematic being produced only later. As a result, some errors might be present in the schematic, please try to make sense of it before attempting to recreate it. If you've noticed any problems, pleae feel free to open an issue or send me an email.

The working principle of the computer is pretty straightforward, the more complicated bit being only the memory switching part. This is done by a couple of logic chips (a NAND gate an a hex inverter, to be more specific). Each time the `/MREQ` line goes low, the CPU requests to access the memory (either read or write). 
