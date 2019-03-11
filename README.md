# ZyboZ7Audio
Fix for Zybo Z7 audio in petalinux.

This is for the 2017.4 Petalinux project.

This has only been tested on a Zybo-Z7-20 but should work on a Petalinux-Zybo-Z7-10



# Fixing Audio

First follow the instructions here to install petalinux and clone the petalinux project: https://github.com/Digilent/Petalinux-Zybo-Z7-20 or Zybo-Zy-10: https://github.com/Digilent/Petalinux-Zybo-Z7-10

Before building we need to patch the kernel and make some config changes.

There is an issue in the ssm2602 codec code in ssm2602.c, there is also another issue with the DMA driver in pl330.c which causes under-runs to stall playback.


In the AudioFix folder there is a cfg file that make sure that the audio stuff is not loaded as modules and also a patch file to fix the issues in ssm2602.c and pl330.c.

Copy these two files to: (CheckoutFolder)/Petalinux-Zybo-Z7-20/Zybo-Z7-20/project-spec/meta-user/recipes-kernel/linux/linux-xlnx

Now you need to edit this file: (CheckoutFolder)/Petalinux-Zybo-Z7-20/Zybo-Z7-20/project-spec/meta-user/recipes-kernel/linux/linux-xlnx_%.bbappend

You need to add the two files we copied to the bottom as follows:

```
SRC_URI += "file://user_2017-07-10-08-35-00.cfg \
            file://user_2017-07-11-07-44-00.cfg \
            file://user_2017-07-18-17-02-00.cfg \
            file://user_2017-07-28-03-36-00.cfg \
            file://user_2017-07-28-21-03-00.cfg \
            file://user_2017-10-11-17-11-00.cfg \
            file://user_2017-10-13-22-56-00.cfg \
            file://user_2018-02-13-04-02-00.cfg \
            file://user_2018-02-13-04-15-00.cfg \
            file://user_2018-03-05-17-31-00.cfg \
            file://user_2018-03-06-01-20-00.cfg \
            file://user_2018-06-29-17-10-00.cfg \
            file://0001-Changes-to-get-audio-working-on-Zybo-Z7-Petalinux.patch \
            file://user_2019-02-28-19-19-00.cfg \
            "


FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

KERNEL_VERSION_SANITY_SKIP = "1"
```


# Creating Gadget for class compliant audio and midi device (optional).

In the AudioMidDevice folder is another cfg file which will allow the Zybo Z7 to act as a class compliant audio and midi device, if you want this functionality copy that cfg along with the previous one and add to the bbappend file as well. You also need to edit (CheckoutFolder)/Petalinux-Zybo-Z7-20/Zybo-Z7-20/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi and set the usb mode to "peripheral":

&usb0 {	
	dr_mode = "peripheral";
	usb-phy = <&usb_phy0>;
};

To connect the Zybo Z7 to a computer use the usb port on the bottom and remove the USB Host power enable jumper next to the USB port. See callout 7 here: https://reference.digilentinc.com/reference/programmable-logic/zybo-z7/reference-manual

Also in the AudioMidiDevice folder is a script (AudoMidiGadget.sh), this can be used to set the Zybo Z7 to a 4x4 audio device and 64 channel midi device.



# Building

Now follow the rest of the instructions to build and deploy to your Zybo Z7: https://github.com/Digilent/Petalinux-Zybo-Z7-20 or Zybo-Zy-10: https://github.com/Digilent/Petalinux-Zybo-Z7-10


