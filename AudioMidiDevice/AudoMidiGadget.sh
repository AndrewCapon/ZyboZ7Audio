bcomposite
mkdir cfg
mount none cfg -t configfs
mkdir cfg/usb_gadget/g1
cd cfg/usb_gadget/g1

mkdir configs/c.1
mkdir strings/0x409

echo "Zybo Z7" > strings/0x409/product
echo "AndyCap" > strings/0x409/manufacturer

mkdir functions/uac2.0
echo 15 > functions/uac2.0/p_chmask 
echo 15 > functions/uac2.0/c_chmask
echo 44100 > functions/uac2.0/c_srate
echo 44100 > functions/uac2.0/p_srate

mkdir functions/midi.usb0
echo 4 > functions/midi.usb0/in_ports
echo 4 > functions/midi.usb0/out_ports

ln -s functions/uac2.0 configs/c.1
ln -s functions/midi.usb0 configs/c.1

ls /sys/class/udc > UDC

