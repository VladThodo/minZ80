## Disclaimer

This schematic is still a work in progress. The project was built "on the go", with this schematic being produced only later. As a result, some errors might be present in the schematic, please try to make sense of it before attempting to recreate it. If you've noticed any problems, pleae feel free to open an issue or send me an email.

The memory managed is managed by a couple of logic chips (a NAND gate an a hex inverter, to be more specific). Each time the `/MREQ` line goes low, the CPU requests to access the memory (either read or write). This signal is passed through an inverter and "NANDed" (see NAND gate truth table) together with the `A15` address line from the CPU. As a result, the NAND gate produces a `0` (`LOW`) signal each time `/MREQ` and `A15` are active (notice that in the case of `/MREQ` the signal is active when low). 
As the Z80 starts executing instructions at adress `0x00`, we want to make sure that the ROM is availabile to the CPU right from the beginning.
