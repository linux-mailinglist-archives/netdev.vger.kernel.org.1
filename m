Return-Path: <netdev+bounces-225779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31DEB982F8
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 06:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EEC2E600C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 04:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E1B1D5CF2;
	Wed, 24 Sep 2025 04:18:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360262AF1B
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 04:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758687522; cv=none; b=BNQVIF69taxDVHFMhvQLUBj8L3EpiW9qNnmY6MoVrYkG/jftHBu/ump9OKdBWFmOcl1abNwVxvj/cHlsoa5Y+ntcC3zIKENTLIzsjs6yHCO4C95QAqtfnv00xz2YDt/DJquTbpjq7LbuKMueQ0fJGZ9YItB3dnmdSM6jGl8hutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758687522; c=relaxed/simple;
	bh=+vh3085ZrCQ/S1AOh9vVVM7GoBdoYxgoEaAPCqUpx3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auRZQudwgAH43JADaAc14kBmVaYpHWIp1rj0Uc8RLrJnxTCgneSgWLbjp2dl38ZGMWyj7v5OLN/mv6R2FNmJ6ncA4fc56p0CFKR9iNhFp90EqJPq8FQ2QWWm1dhCPkiUN8/9YtwhNGu6qC+kKeiAKv7lYAZAROQRIsWqG4ZKMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v1GxY-000000007T2-0b76;
	Wed, 24 Sep 2025 04:18:28 +0000
Date: Wed, 24 Sep 2025 05:18:19 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 0/2] lantiq_gswip fixes
Message-ID: <aNNxC7-b3hduosIh@pidgin.makrotopia.org>
References: <20250918072142.894692-1-vladimir.oltean@nxp.com>
 <20250919165008.247549ab@kernel.org>
 <20250918072142.894692-1-vladimir.oltean@nxp.com>
 <20250919165008.247549ab@kernel.org>
 <aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
 <aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
 <20250922110717.7n743dmxrcrokf4k@skbuf>
 <20250922113452.07844cd2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IqF9REbJGjM+29E2"
Content-Disposition: inline
In-Reply-To: <20250922113452.07844cd2@kernel.org>


--IqF9REbJGjM+29E2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 22, 2025 at 11:34:52AM -0700, Jakub Kicinski wrote:
> On Mon, 22 Sep 2025 14:07:17 +0300 Vladimir Oltean wrote:
> > - I don't think your local_termination.sh exercises the bug fixed by
> >   patch "[1/2] net: dsa: lantiq_gswip: move gswip_add_single_port_br()
> >   call to port_setup()". The port has to be initially down before
> >   joining a bridge, and be brought up afterwards. This can be tested
> >   manually. In local_termination.sh, although bridge_create() runs
> >   "ip link set $h2 up" after "ip link set $h2 master br0", $h2 was
> >   already up due to "simple_if_init $h2".
> 
> Waiting for more testing..

I've added printk statements to illustrate the function calls to
gswip_port_enable() and gswip_port_setup(), and tested both the current
'net' without (before.txt) and with (after.txt) patch
"net: dsa: lantiq_gswip: move gswip_add_single_port_br() call to port_setup()"
applied. This makes it obvious that gswip_port_enable() calls
gswip_add_single_port_br() even though the port is at this point
already a member of another bridge.

I'm ready to do more testing or spray for printk over it, just let me
know.

> 
> > - If the vast majority of users make use of this driver through OpenWrt,
> >   and if backporting to the required trees is done by OpenWrt and the
> >   fixes' presence in linux-stable is not useful, I can offer to resend
> >   this set plus the remaining patches all together through the net-next
> >   tree, and avoid complications such as merge conflicts.
> 
> FWIW I don't even see a real conflict when merging this. git seems to
> be figuring things out on its own.

My concern here was the upcoming merge of the 'net' tree with the
'net-next' tree which now already contains the splitting of the driver
into .h and .c file, and moved both into a dedicated folder.
This may result in needing (trivial) manual intervention.

It would be great if all of Vladimir's patches can be merged without
a long delay, so more patches adding support for newer hardware can
be added during the next merge window. Especially the conversion of
the open-coded register access functions to be replaced by regmap_*
calls should only be committed after Vladimir's fixes.


--IqF9REbJGjM+29E2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=before.txt

(AVM) EVA Revision: 1.1964 Version: 2964
(C) Copyright 2005 AVM Date: Nov 27 2013 Time: 14:33:10 (0) 3 0x0-0x740D

[FLASH:] MACRONIX Uniform-Flash 1MB 256 Bytes WriteBuffer
[FLASH:](Eraseregion [0] 16 sectors a 64kB) 
[NAND:] 512MB MICRON 2048 Pagesize 128k Blocksize 4096 Blocks 8Bit 1 CS HW
[SYSTEM:] VR9 on 500MHz/250MHz/250MHz

.Atheros 8030/35 detected

Eva_AVM >##.........................................................................
[    0.000000] Linux version 6.17.0-rc6+ (daniel@mixxxtop) (mips-openwrt-linux-gnu-gcc (OpenWrt GCC 14.3.0 r30716+1-56b083221f) 14.3.0, GNU ld (GNU Binutils) 2.42) #0 SMP Wed Sep 24 01:36:46 2025
[    0.000000] SoC: xRX200 rev 1.2
[    0.000000] printk: legacy bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00019556 (MIPS 34Kc)
[    0.000000] MIPS: machine is AVM FRITZ!Box 7490 (Micron NAND)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
[    0.000000] Detected 1 available secondary CPU(s)
[    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000] percpu: Embedded 12 pages/cpu s18224 r8192 d22736 u49152
[    0.000000] Kernel command line: console=ttyLTQ0,115200
[    0.000000] printk: log buffer data + meta data: 131072 + 409600 = 540672 bytes
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
[    0.000000] Writing ErrCtl register=00042004
[    0.000000] Readback ErrCtl register=00042004
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 65536
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
[    0.000000] NR_IRQS: 256
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] CPU Clock: 500MHz
[    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041786 ns
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns
[    0.010000] Calibrating delay loop... 331.77 BogoMIPS (lpj=1658880)
[    0.070000] pid_max: default: 32768 minimum: 301
[    0.090000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.100000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.130000] rcu: Hierarchical SRCU implementation.
[    0.140000] rcu: 	Max phase no-delay instances is 1000.
[    0.140000] smp: Bringing up secondary CPUs ...
[    0.150000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
[    0.150000] Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
[    0.150000] CPU1 revision is: 00019556 (MIPS 34Kc)
[    0.200000] Counter synchronization [CPU#0 -> CPU#1]: passed
[    0.210000] smp: Brought up 1 node, 2 CPUs
[    0.210000] Memory: 246400K/262144K available (8709K kernel code, 637K rwdata, 1068K rodata, 1284K init, 219K bss, 14608K reserved, 0K cma-reserved)
[    0.230000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.240000] posixtimers hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.240000] futex hash table entries: 512 (16384 bytes on 1 NUMA nodes, total 16 KiB, linear).
[    0.260000] pinctrl core: initialized pinctrl subsystem
[    0.270000] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.280000] dcdc-xrx200 1f106a00.dcdc: Core Voltage : 1016 mV
[    0.290000] /fpi@10000000/pinmux@e100b10: Fixed dependency cycle(s) with /fpi@10000000/pinmux@e100b10/pinmux
[    0.300000] pinctrl-xway 1e100b10.pinmux: Init done
[    0.310000] dma-xway 1e104100.dma: Init done - hw rev: 7, ports: 7, channels: 28
[    0.330000] usbcore: registered new interface driver usbfs
[    0.340000] usbcore: registered new interface driver hub
[    0.340000] usbcore: registered new device driver usb
[    0.350000] clocksource: Switched to clocksource MIPS
[    0.370000] NET: Registered PF_INET protocol family
[    0.370000] IP idents hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.380000] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.390000] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.400000] TCP established hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.410000] TCP bind hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.410000] TCP: Hash tables configured (established 2048 bind 2048)
[    0.420000] MPTCP token hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.430000] UDP hash table entries: 256 (order: 1, 14336 bytes, linear)
[    0.440000] UDP-Lite hash table entries: 256 (order: 1, 14336 bytes, linear)
[    0.440000] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.450000] PCI: CLS 0 bytes, default 32
[    0.450000] gptu: totally 6 16-bit timers/counters
[    0.460000] gptu: misc_register on minor 256
[    0.460000] gptu: succeeded to request irq 126
[    0.470000] gptu: succeeded to request irq 127
[    0.470000] gptu: succeeded to request irq 128
[    0.480000] gptu: succeeded to request irq 129
[    0.480000] gptu: succeeded to request irq 130
[    0.490000] gptu: succeeded to request irq 131
[    0.490000] No VPEs reserved for AP/SP, not initialize VPE loader
[    0.490000] Pass maxvpes=<n> argument as kernel argument
[    0.500000] No TCs reserved for AP/SP, not initializing RTLX.
[    0.500000] Pass maxtcs=<n> argument as kernel argument
[    0.520000] workingset: timestamp_bits=14 max_order=16 bucket_order=2
[    0.530000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.540000] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    0.560000] 1e100c00.serial: ttyLTQ0 at MMIO 0x1e100c00 (irq = 112, base_baud = 0) is a lantiq,asc
[    0.570000] printk: legacy console [ttyLTQ0] enabled
[    0.570000] printk: legacy console [ttyLTQ0] enabled
[    0.580000] printk: legacy bootconsole [early0] disabled
[    0.580000] printk: legacy bootconsole [early0] disabled
[    0.600000] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
[    0.600000] nand: Micron MT29F4G08ABADAWP
[    0.610000] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    0.620000] Scanning device for bad blocks
[    0.670000] Bad eraseblock 660 at 0x000005280000
[    0.670000] Bad eraseblock 692 at 0x000005680000
[    0.910000] 2 fixed-partitions partitions found on MTD device 14000000.nand
[    0.920000] Creating 2 MTD partitions on "14000000.nand":
[    0.920000] 0x000000000000-0x000000400000 : "kernel"
[    0.930000] 0x000000400000-0x000020000000 : "ubi"
[    0.950000] spi-lantiq-ssc 1e100800.spi: Lantiq SSC SPI controller (Rev 8, TXFS 8, RXFS 8, DMA 1)
[    0.960000] spi-nor spi0.4: supply vcc not found, using dummy regulator
[    0.970000] 3 fixed-partitions partitions found on MTD device spi0.4
[    0.970000] Creating 3 MTD partitions on "spi0.4":
[    0.980000] 0x000000000000-0x000000040000 : "urlader"
[    0.990000] 0x000000040000-0x0000000a0000 : "tffs (1)"
[    0.990000] 0x0000000a0000-0x000000100000 : "tffs (2)"
[    1.020000] NET: Registered PF_INET6 protocol family
[    1.030000] Segment Routing with IPv6
[    1.030000] In-situ OAM (IOAM) with IPv6
[    1.040000] NET: Registered PF_PACKET protocol family
[    1.040000] 8021q: 802.1Q VLAN Support v1.8
[    1.110000] pcie-xrx200 1d900000.pcie: switch pcie endianess requested
[    1.260000] PCI host bridge to bus 0000:00
[    1.260000] pci_bus 0000:00: root bus resource [mem 0x1c000000-0x1cffffff]
[    1.270000] pci_bus 0000:00: root bus resource [io  0x1d800000-0x1d8fffff]
[    1.270000] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    1.280000] ifx_pcie_rc_class_early_fixup: fixed pcie host bridge to pci-pci bridge
[    1.300000] pci 0000:00:00.0: 0x80849314 took 17184 usecs
[    1.300000] pci 0000:00:00.0: [1bef:0011] type 01 class 0x060400 PCIe Root Port
[    1.310000] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.320000] pci 0000:00:00.0:   bridge window [io  0x1d800000-0x1d8fffff]
[    1.320000] pci 0000:00:00.0:   bridge window [mem 0x1c000000-0x1cffffff]
[    1.330000] pci 0000:00:00.0:   bridge window [mem 0x1c000000-0x1cffffff pref]
[    1.340000] pci 0000:00:00.0: PME# supported from D0 D3hot
[    1.350000] pci 0000:01:00.0: [1912:0015] type 00 class 0x0c0330 PCIe Endpoint
[    1.350000] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00001fff 64bit]
[    1.360000] pci 0000:01:00.0: PME# supported from D0 D3hot
[    1.360000] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x1 link at 0000:00:00.0 (capable of 4.000 Gb/s with 5.0 GT/s PCIe x1 link)
[    1.380000] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.390000] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[    1.390000] pci 0000:00:00.0: bridge window [mem 0x1c000000-0x1c0fffff]: assigned
[    1.400000] pci 0000:01:00.0: BAR 0 [mem 0x1c000000-0x1c001fff 64bit]: assigned
[    1.410000] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.410000] pci 0000:00:00.0:   bridge window [mem 0x1c000000-0x1c0fffff]
[    1.420000] ifx_pcie_bios_map_irq port 0 dev 0000:00:00.0 slot 0 pin 1 
[    1.420000] ifx_pcie_bios_map_irq dev 0000:00:00.0 irq 144 assigned
[    1.430000] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
[    1.440000] pci 0000:01:00.0: enabling device (0000 -> 0002)
[    7.190000] pci 0000:01:00.0: xHCI HW not ready after 5 sec (HC bug?) status = 0x801
[    7.190000] pci 0000:01:00.0: 0x805ad5bc took 5621086 usecs
[    7.200000] UBI: auto-attach mtd1
[    7.200000] ubi0: attaching mtd1
[    8.870000] ubi0: scanning is finished
[    8.900000] ubi0: attached mtd1 (name "ubi", size 508 MiB)
[    8.900000] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 129024 bytes
[    8.910000] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 512
[    8.910000] ubi0: VID header offset: 512 (aligned 512), data offset: 2048
[    8.920000] ubi0: good PEBs: 4062, bad PEBs: 2, corrupted PEBs: 0
[    8.930000] ubi0: user volume: 2, internal volumes: 1, max. volumes count: 128
[    8.930000] ubi0: max/mean erase counter: 15/6, WL threshold: 4096, image sequence number: 699232088
[    8.940000] ubi0: available PEBs: 0, total reserved PEBs: 4062, PEBs reserved for bad PEB handling: 78
[    8.950000] ubi0: background thread "ubi_bgt0d" started, PID 311
[    8.950000] block ubiblock0_0: created from ubi0:0(rootfs)
[    8.960000] ubiblock: device ubiblock0_0 (rootfs) set to be root file[    8.970000] check access for rdinit=/init failed: -2, ignoring
[    8.980000] VFS: Mounted root (squashfs filesystem) readonly on device 254:0.
[    8.990000] Freeing unused kernel image (initmem) memory: 1284K
[    9.000000] This architecture does not have kernel memory protection.
[    9.000000] Run /sbin/init as init process
[   10.400000] init: Console is alive
[   10.400000] init: - watchdog -
[   11.360000] kmodloader: loading kernel modules from /etc/modules-boot.d/*
[   11.630000] SCSI subsystem initialized
[   11.650000] ifx_pcie_bios_map_irq port 0 dev 0000:01:00.0 slot 0 pin 1 
[   11.660000] ifx_pcie_bios_map_irq dev 0000:01:00.0 irq 144 assigned
[   11.670000] ifx_pcie_bios_map_irq port 0 dev 0000:01:00.0 slot 0 pin 1 
[   11.670000] ifx_pcie_bios_map_irq dev 0000:01:00.0 irq 144 assigned
[   12.120000] xhci-pci-renesas 0000:01:00.0: xHCI Host Controller
[   12.120000] xhci-pci-renesas 0000:01:00.0: new USB bus registered, assigned bus number 1
[   12.130000] xhci-pci-renesas 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x0000000100000090
[   12.140000] xhci-pci-renesas 0000:01:00.0: xHCI Host Controller
[   12.150000] xhci-pci-renesas 0000:01:00.0: new USB bus registered, assigned bus number 2
[   12.160000] xhci-pci-renesas 0000:01:00.0: Host supports USB 3.0 SuperSpeed
[   12.170000] hub 1-0:1.0: USB hub found
[   12.170000] hub 1-0:1.0: 2 ports detected
[   12.170000] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[   12.180000] hub 2-0:1.0: USB hub found
[   12.190000] hub 2-0:1.0: 2 ports detected
[   12.210000] usbcore: registered new interface driver usb-storage
[   12.210000] kmodloader: done loading kernel modules from /etc/modules-boot.d/*
[   12.220000] init: - preinit -
[   13.290000] usb 2-2: new SuperSpeed USB device number 2 using xhci-pci-renesas
[   15.440000] random: crng init done
Press the [f] key and hit [enter] to enter failsafe mode
Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
[   23.100000] UBIFS (ubi0:1): Mounting in unauthenticated mode
[   23.110000] UBIFS (ubi0:1): background thread "ubifs_bgt0_1" started, PID 483
[   23.160000] UBIFS (ubi0:1): recovery needed
[   23.270000] UBIFS (ubi0:1): recovery completed
[   23.270000] UBIFS (ubi0:1): UBIFS: mounted UBI device 0, volume 1, name "rootfs_data"
[   23.280000] UBIFS (ubi0:1): LEB size: 129024 bytes (126 KiB), min./max. I/O unit sizes: 2048 bytes/2048 bytes
[   23.290000] UBIFS (ubi0:1): FS size: 452616192 bytes (431 MiB, 3508 LEBs), max 3523 LEBs, journal size 22708224 bytes (21 MiB, 176 LEBs)
[   23.300000] UBIFS (ubi0:1): reserved for root: 4952683 bytes (4836 KiB)
[   23.310000] UBIFS (ubi0:1): media format: w5/r0 (latest is w5/r0), UUID 60E6CC7B-E541-4823-BBF7-57111F823DE1, small LPT model
[   23.330000] mount_root: switching to ubifs overlay
[   23.350000] urandom-seed: Seeding with /etc/urandom.seed
[   23.510000] procd: - early -
[   23.510000] procd: - watchdog -
[   24.350000] procd: - watchdog -
[   24.350000] procd: - ubus -
[   24.570000] procd: - init -
Please press Enter to activate this console.
[   26.990000] kmodloader: loading kernel modules from /etc/modules.d/*
[   29.190000] urngd: v1.0.2 started.
[   29.310000] gswip_port_enable called
[   29.310000] gswip 1e108000.switch: configuring for fixed/internal link mode
[   29.320000] gswip 1e108000.switch: Link is Up - 1Gbps/Full - flow control off
[   29.400000] gswip 1e108000.switch lan3 (uninitialized): PHY [1e108000.switch-mii:00] driver [Qualcomm Atheros AR8035] (irq=POLL)
[   29.510000] gswip 1e108000.switch lan4 (uninitialized): PHY [1e108000.switch-mii:01] driver [Qualcomm Atheros AR8035] (irq=POLL)
[   29.520000] gswip 1e108000.switch lan2 (uninitialized): PHY [1e108000.switch-mii:11] driver [Intel XWAY PHY11G (xRX v1.2 integrated)] (irq=POLL)
[   29.560000] gswip 1e108000.switch lan1 (uninitialized): PHY [1e108000.switch-mii:13] driver [Intel XWAY PHY11G (xRX v1.2 integrated)] (irq=POLL)
[   29.580000] lantiq,xrx200-net 1e10b308.eth eth0: entered promiscuous mode
[   29.580000] DSA: tree 0 setup
[   29.590000] gswip 1e108000.switch: probed GSWIP version 21 mod 0
[   29.600000] GACT probability on
[   29.610000] Mirror/redirect action on
[   29.630000] u32 classifier
[   29.630000]     input device check on
[   29.640000]     Actions configured
[   29.680000] mdio_netlink: loading out-of-tree module taints kernel.
[   29.720000] usbcore: registered new device driver r8152-cfgselector
[   29.920000] r8152-cfgselector 2-2: reset SuperSpeed USB device number 2 using xhci-pci-renesas
[   30.210000] r8152 2-2:1.0 eth1: v1.12.13
[   30.210000] usbcore: registered new interface driver r8152
[   30.220000] usbcore: registered new interface driver rtl8150
[   30.250000] kmodloader: done loading kernel modules from /etc/modules.d/*
[   39.870000] br-lan: port 1(eth1) entered blocking state
[   39.870000] br-lan: port 1(eth1) entered disabled state
[   39.880000] r8152 2-2:1.0 eth1: entered allmulticast mode
[   39.880000] r8152 2-2:1.0 eth1: entered promiscuous mode
[   39.910000] br-lan: port 1(eth1) entered blocking state
[   39.910000] br-lan: port 1(eth1) entered forwarding state
[   40.800000] br-lan: port 1(eth1) entered disabled state
[   43.450000] r8152 2-2:1.0 eth1: Promiscuous mode enabled
[   43.450000] r8152 2-2:1.0 eth1: carrier on
[   43.470000] br-lan: port 1(eth1) entered blocking state
[   43.470000] br-lan: port 1(eth1) entered forwarding state



BusyBox v1.37.0 (2025-09-24 01:36:46 UTC) built-in shell (ash)

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 OpenWrt SNAPSHOT, r31146+11-4eae48d9dc
 -----------------------------------------------------
=== WARNING! =====================================
There is no root password defined on this device!
Use the "passwd" command to set up a new password
in order to prevent unauthorized SSH logins.
--------------------------------------------------

 OpenWrt recently switched to the "apk" package manager!

 OPKG Command           APK Equivalent      Description
 ------------------------------------------------------------------
 opkg install <pkg>     apk add <pkg>       Install a package
 opkg remove <pkg>      apk del <pkg>       Remove a package
 opkg upgrade           apk upgrade         Upgrade all packages
 opkg files <pkg>       apk info -L <pkg>   List package contents
 opkg list-installed    apk info            List installed packages
 opkg update            apk update          Update package lists
 opkg search <pkg>      apk search <pkg>    Search for packages
 ------------------------------------------------------------------

For more https://openwrt.org/docs/guide-user/additional-software/opkg-to-apk-cheatsheet

root@OpenWrt:~# ip link set lan1 down
root@OpenWrt:~# ip link add br0 type bridge
root@OpenWrt:~# ip link set lan1 master br0
[  194.130000] br0: port 1(lan1) entered blocking state
[  194.130000] br0: port 1(lan1) entered disabled state
[  194.140000] gswip 1e108000.switch lan1: entered allmulticast mode
[  194.150000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  194.150000] gswip 1e108000.switch lan1: entered promiscuous mode
[  194.150000] gswip 1e108000.switch: port 4 failed to add 8e:ed:49:25:e7:e2 vid 1 to fdb: -22
[  194.170000] gswip 1e108000.switch: port 4 failed to add 4e:d6:f5:a0:ea:b7 vid 0 to fdb: -22
[  194.180000] gswip 1e108000.switch: port 4 failed to add 4e:d6:f5:a0:ea:b7 vid 1 to fdb: -22
[  194.180000] gswip 1e108000.switch: port 4 failed to delete 8e:ed:49:25:e7:e2 vid 1 from fdb: -2
root@OpenWrt:~# ip link set lan1 up
[  220.480000] gswip_port_enable called
[  220.480000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
root@OpenWrt:~# 

--IqF9REbJGjM+29E2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=after.txt

(AVM) EVA Revision: 1.1964 Version: 2964
(C) Copyright 2005 AVM Date: Nov 27 2013 Time: 14:33:10 (0) 3 0x0-0x740D

[FLASH:] MACRONIX Uniform-Flash 1MB 256 Bytes WriteBuffer
[FLASH:](Eraseregion [0] 16 sectors a 64kB) 
[NAND:] 512MB MICRON 2048 Pagesize 128k Blocksize 4096 Blocks 8Bit 1 CS HW
[SYSTEM:] VR9 on 500MHz/250MHz/250MHz

.Atheros 8030/35 detected

Eva_AVM >##.........................................................................
[    0.000000] Linux version 6.17.0-rc6+ (daniel@mixxxtop) (mips-openwrt-linux-gnu-gcc (OpenWrt GCC 14.3.0 r30716+1-56b083221f) 14.3.0, GNU ld (GNU Binutils) 2.42) #0 SMP Wed Sep 24 01:36:46 2025
[    0.000000] SoC: xRX200 rev 1.2
[    0.000000] printk: legacy bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00019556 (MIPS 34Kc)
[    0.000000] MIPS: machine is AVM FRITZ!Box 7490 (Micron NAND)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
[    0.000000] Detected 1 available secondary CPU(s)
[    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000] percpu: Embedded 12 pages/cpu s18224 r8192 d22736 u49152
[    0.000000] Kernel command line: console=ttyLTQ0,115200
[    0.000000] printk: log buffer data + meta data: 131072 + 409600 = 540672 bytes
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
[    0.000000] Writing ErrCtl register=00040103
[    0.000000] Readback ErrCtl register=00040103
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 65536
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
[    0.000000] NR_IRQS: 256
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] CPU Clock: 500MHz
[    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041786 ns
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns
[    0.010000] Calibrating delay loop... 331.77 BogoMIPS (lpj=1658880)
[    0.070000] pid_max: default: 32768 minimum: 301
[    0.090000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.100000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.130000] rcu: Hierarchical SRCU implementation.
[    0.140000] rcu: 	Max phase no-delay instances is 1000.
[    0.140000] smp: Bringing up secondary CPUs ...
[    0.150000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
[    0.150000] Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
[    0.150000] CPU1 revision is: 00019556 (MIPS 34Kc)
[    0.200000] Counter synchronization [CPU#0 -> CPU#1]: passed
[    0.210000] smp: Brought up 1 node, 2 CPUs
[    0.210000] Memory: 246400K/262144K available (8709K kernel code, 637K rwdata, 1068K rodata, 1284K init, 219K bss, 14608K reserved, 0K cma-reserved)
[    0.230000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.240000] posixtimers hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.240000] futex hash table entries: 512 (16384 bytes on 1 NUMA nodes, total 16 KiB, linear).
[    0.260000] pinctrl core: initialized pinctrl subsystem
[    0.270000] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.280000] dcdc-xrx200 1f106a00.dcdc: Core Voltage : 1016 mV
[    0.290000] /fpi@10000000/pinmux@e100b10: Fixed dependency cycle(s) with /fpi@10000000/pinmux@e100b10/pinmux
[    0.300000] pinctrl-xway 1e100b10.pinmux: Init done
[    0.310000] dma-xway 1e104100.dma: Init done - hw rev: 7, ports: 7, channels: 28
[    0.330000] usbcore: registered new interface driver usbfs
[    0.340000] usbcore: registered new interface driver hub
[    0.340000] usbcore: registered new device driver usb
[    0.350000] clocksource: Switched to clocksource MIPS
[    0.370000] NET: Registered PF_INET protocol family
[    0.370000] IP idents hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.380000] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.390000] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.400000] TCP established hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.410000] TCP bind hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.410000] TCP: Hash tables configured (established 2048 bind 2048)
[    0.420000] MPTCP token hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.430000] UDP hash table entries: 256 (order: 1, 14336 bytes, linear)
[    0.440000] UDP-Lite hash table entries: 256 (order: 1, 14336 bytes, linear)
[    0.440000] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.450000] PCI: CLS 0 bytes, default 32
[    0.450000] gptu: totally 6 16-bit timers/counters
[    0.460000] gptu: misc_register on minor 256
[    0.460000] gptu: succeeded to request irq 126
[    0.470000] gptu: succeeded to request irq 127
[    0.470000] gptu: succeeded to request irq 128
[    0.480000] gptu: succeeded to request irq 129
[    0.480000] gptu: succeeded to request irq 130
[    0.490000] gptu: succeeded to request irq 131
[    0.490000] No VPEs reserved for AP/SP, not initialize VPE loader
[    0.490000] Pass maxvpes=<n> argument as kernel argument
[    0.500000] No TCs reserved for AP/SP, not initializing RTLX.
[    0.500000] Pass maxtcs=<n> argument as kernel argument
[    0.520000] workingset: timestamp_bits=14 max_order=16 bucket_order=2
[    0.530000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.540000] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    0.560000] 1e100c00.serial: ttyLTQ0 at MMIO 0x1e100c00 (irq = 112, base_baud = 0) is a lantiq,asc
[    0.570000] printk: legacy console [ttyLTQ0] enabled
[    0.570000] printk: legacy console [ttyLTQ0] enabled
[    0.580000] printk: legacy bootconsole [early0] disabled
[    0.580000] printk: legacy bootconsole [early0] disabled
[    0.600000] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
[    0.600000] nand: Micron MT29F4G08ABADAWP
[    0.600000] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    0.610000] Scanning device for bad blocks
[    0.670000] Bad eraseblock 660 at 0x000005280000
[    0.670000] Bad eraseblock 692 at 0x000005680000
[    0.910000] 2 fixed-partitions partitions found on MTD device 14000000.nand
[    0.920000] Creating 2 MTD partitions on "14000000.nand":
[    0.920000] 0x000000000000-0x000000400000 : "kernel"
[    0.930000] 0x000000400000-0x000020000000 : "ubi"
[    0.950000] spi-lantiq-ssc 1e100800.spi: Lantiq SSC SPI controller (Rev 8, TXFS 8, RXFS 8, DMA 1)
[    0.960000] spi-nor spi0.4: supply vcc not found, using dummy regulator
[    0.970000] 3 fixed-partitions partitions found on MTD device spi0.4
[    0.970000] Creating 3 MTD partitions on "spi0.4":
[    0.980000] 0x000000000000-0x000000040000 : "urlader"
[    0.990000] 0x000000040000-0x0000000a0000 : "tffs (1)"
[    0.990000] 0x0000000a0000-0x000000100000 : "tffs (2)"
[    1.020000] NET: Registered PF_INET6 protocol family
[    1.030000] Segment Routing with IPv6
[    1.030000] In-situ OAM (IOAM) with IPv6
[    1.040000] NET: Registered PF_PACKET protocol family
[    1.040000] 8021q: 802.1Q VLAN Support v1.8
[    1.110000] pcie-xrx200 1d900000.pcie: switch pcie endianess requested
[    1.260000] PCI host bridge to bus 0000:00
[    1.260000] pci_bus 0000:00: root bus resource [mem 0x1c000000-0x1cffffff]
[    1.270000] pci_bus 0000:00: root bus resource [io  0x1d800000-0x1d8fffff]
[    1.270000] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    1.280000] ifx_pcie_rc_class_early_fixup: fixed pcie host bridge to pci-pci bridge
[    1.300000] pci 0000:00:00.0: 0x80849314 took 17143 usecs
[    1.300000] pci 0000:00:00.0: [1bef:0011] type 01 class 0x060400 PCIe Root Port
[    1.310000] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.310000] pci 0000:00:00.0:   bridge window [io  0x1d800000-0x1d8fffff]
[    1.320000] pci 0000:00:00.0:   bridge window [mem 0x1c000000-0x1cffffff]
[    1.330000] pci 0000:00:00.0:   bridge window [mem 0x1c000000-0x1cffffff pref]
[    1.340000] pci 0000:00:00.0: PME# supported from D0 D3hot
[    1.340000] pci 0000:01:00.0: [1912:0015] type 00 class 0x0c0330 PCIe Endpoint
[    1.350000] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00001fff 64bit]
[    1.360000] pci 0000:01:00.0: PME# supported from D0 D3hot
[    1.360000] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x1 link at 0000:00:00.0 (capable of 4.000 Gb/s with 5.0 GT/s PCIe x1 link)
[    1.380000] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.380000] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[    1.390000] pci 0000:00:00.0: bridge window [mem 0x1c000000-0x1c0fffff]: assigned
[    1.400000] pci 0000:01:00.0: BAR 0 [mem 0x1c000000-0x1c001fff 64bit]: assigned
[    1.400000] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.410000] pci 0000:00:00.0:   bridge window [mem 0x1c000000-0x1c0fffff]
[    1.420000] ifx_pcie_bios_map_irq port 0 dev 0000:00:00.0 slot 0 pin 1 
[    1.420000] ifx_pcie_bios_map_irq dev 0000:00:00.0 irq 144 assigned
[    1.430000] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
[    1.440000] pci 0000:01:00.0: enabling device (0000 -> 0002)
[    7.180000] pci 0000:01:00.0: xHCI HW not ready after 5 sec (HC bug?) status = 0x801
[    7.190000] pci 0000:01:00.0: 0x805ad5bc took 5619896 usecs
[    7.200000] UBI: auto-attach mtd1
[    7.200000] ubi0: attaching mtd1
[    8.870000] ubi0: scanning is finished
[    8.900000] ubi0: attached mtd1 (name "ubi", size 508 MiB)
[    8.900000] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 129024 bytes
[    8.910000] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 512
[    8.920000] ubi0: VID header offset: 512 (aligned 512), data offset: 2048
[    8.920000] ubi0: good PEBs: 4062, bad PEBs: 2, corrupted PEBs: 0
[    8.930000] ubi0: user volume: 2, internal volumes: 1, max. volumes count: 128
[    8.940000] ubi0: max/mean erase counter: 15/6, WL threshold: 4096, image sequence number: 699232088
[    8.940000] ubi0: available PEBs: 0, total reserved PEBs: 4062, PEBs reserved for bad PEB handling: 78
[    8.950000] ubi0: background thread "ubi_bgt0d" started, PID 310
[    8.960000] block ubiblock0_0: created from ubi0:0(rootfs)
[    8.970000] ubiblock: device ubiblock0_0 (rootfs) set to be root files[    8.970000] check access for rdinit=/init failed: -2, ignoring
[    8.990000] VFS: Mounted root (squashfs filesystem) readonly on device 254:0.
[    8.990000] Freeing unused kernel image (initmem) memory: 1284K
[    9.000000] This architecture does not have kernel memory protection.
[    9.000000] Run /sbin/init as init process
[   10.400000] init: Console is alive
[   10.410000] init: - watchdog -
[   11.370000] kmodloader: loading kernel modules from /etc/modules-boot.d/*
[   11.650000] SCSI subsystem initialized
[   11.670000] ifx_pcie_bios_map_irq port 0 dev 0000:01:00.0 slot 0 pin 1 
[   11.670000] ifx_pcie_bios_map_irq dev 0000:01:00.0 irq 144 assigned
[   11.680000] ifx_pcie_bios_map_irq port 0 dev 0000:01:00.0 slot 0 pin 1 
[   11.690000] ifx_pcie_bios_map_irq dev 0000:01:00.0 irq 144 assigned
[   12.130000] xhci-pci-renesas 0000:01:00.0: xHCI Host Controller
[   12.130000] xhci-pci-renesas 0000:01:00.0: new USB bus registered, assigned bus number 1
[   12.150000] xhci-pci-renesas 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x0000000100000090
[   12.160000] xhci-pci-renesas 0000:01:00.0: xHCI Host Controller
[   12.160000] xhci-pci-renesas 0000:01:00.0: new USB bus registered, assigned bus number 2
[   12.170000] xhci-pci-renesas 0000:01:00.0: Host supports USB 3.0 SuperSpeed
[   12.180000] hub 1-0:1.0: USB hub found
[   12.180000] hub 1-0:1.0: 2 ports detected
[   12.190000] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[   12.200000] hub 2-0:1.0: USB hub found
[   12.200000] hub 2-0:1.0: 2 ports detected
[   12.220000] usbcore: registered new interface driver usb-storage
[   12.230000] kmodloader: done loading kernel modules from /etc/modules-boot.d/*
[   12.240000] init: - preinit -
[   13.340000] usb 2-2: new SuperSpeed USB device number 2 using xhci-pci-renesas
[   15.530000] random: crng init done
Press the [f] key and hit [enter] to enter failsafe mode
Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
[   23.070000] UBIFS (ubi0:1): Mounting in unauthenticated mode
[   23.080000] UBIFS (ubi0:1): background thread "ubifs_bgt0_1" started, PID 481
[   23.130000] UBIFS (ubi0:1): recovery needed
[   23.240000] UBIFS (ubi0:1): recovery completed
[   23.250000] UBIFS (ubi0:1): UBIFS: mounted UBI device 0, volume 1, name "rootfs_data"
[   23.250000] UBIFS (ubi0:1): LEB size: 129024 bytes (126 KiB), min./max. I/O unit sizes: 2048 bytes/2048 bytes
[   23.260000] UBIFS (ubi0:1): FS size: 452616192 bytes (431 MiB, 3508 LEBs), max 3523 LEBs, journal size 22708224 bytes (21 MiB, 176 LEBs)
[   23.280000] UBIFS (ubi0:1): reserved for root: 4952683 bytes (4836 KiB)
[   23.280000] UBIFS (ubi0:1): media format: w5/r0 (latest is w5/r0), UUID F9F3831D-6951-43EA-ACB1-4E2F7B008A1F, small LPT model
[   23.300000] mount_root: switching to ubifs overlay
[   23.330000] urandom-seed: Seed file not found (/etc/urandom.seed)
[   23.470000] procd: - early -
[   23.470000] procd: - watchdog -
[   24.310000] procd: - watchdog -
[   24.320000] procd: - ubus -
[   24.530000] procd: - init -
Please press Enter to activate this console.
[   27.060000] kmodloader: loading kernel modules from /etc/modules.d/*
[   29.450000] urngd: v1.0.2 started.
[   29.570000] gswip_port_setup called
[   29.570000] gswip_port_enable called
[   29.580000] gswip 1e108000.switch: configuring for fixed/internal link mode
[   29.590000] gswip_port_setup called
[   29.590000] gswip 1e108000.switch: Link is Up - 1Gbps/Full - flow control off
[   29.680000] gswip 1e108000.switch lan3 (uninitialized): PHY [1e108000.switch-mii:00] driver [Qualcomm Atheros AR8035] (irq=POLL)
[   29.700000] gswip_port_setup called
[   29.790000] gswip 1e108000.switch lan4 (uninitialized): PHY [1e108000.switch-mii:01] driver [Qualcomm Atheros AR8035] (irq=POLL)
[   29.800000] gswip_port_setup called
[   29.820000] gswip 1e108000.switch lan2 (uninitialized): PHY [1e108000.switch-mii:11] driver [Intel XWAY PHY11G (xRX v1.2 integrated)] (irq=POLL)
[   29.830000] gswip_port_setup called
[   29.850000] gswip_port_setup called
[   29.850000] gswip 1e108000.switch lan1 (uninitialized): PHY [1e108000.switch-mii:13] driver [Intel XWAY PHY11G (xRX v1.2 integrated)] (irq=POLL)
[   29.870000] gswip_port_setup called
[   29.870000] lantiq,xrx200-net 1e10b308.eth eth0: entered promiscuous mode
[   29.880000] DSA: tree 0 setup
[   29.880000] gswip 1e108000.switch: probed GSWIP version 21 mod 0
[   29.910000] GACT probability on
[   29.930000] Mirror/redirect action on
[   29.990000] u32 classifier
[   29.990000]     input device check on
[   29.990000]     Actions configured
[   30.060000] mdio_netlink: loading out-of-tree module taints kernel.
[   30.100000] usbcore: registered new device driver r8152-cfgselector
[   30.280000] r8152-cfgselector 2-2: reset SuperSpeed USB device number 2 using xhci-pci-renesas
[   30.680000] r8152 2-2:1.0 eth1: v1.12.13
[   30.680000] usbcore: registered new interface driver r8152
[   30.690000] usbcore: registered new interface driver rtl8150
[   30.720000] kmodloader: done loading kernel modules from /etc/modules.d/*
[   40.110000] br-lan: port 1(eth1) entered blocking state
[   40.120000] br-lan: port 1(eth1) entered disabled state
[   40.120000] r8152 2-2:1.0 eth1: entered allmulticast mode
[   40.130000] r8152 2-2:1.0 eth1: entered promiscuous mode
[   40.200000] br-lan: port 1(eth1) entered blocking state
[   40.200000] br-lan: port 1(eth1) entered forwarding state
[   41.040000] br-lan: port 1(eth1) entered disabled state
[   43.700000] r8152 2-2:1.0 eth1: Promiscuous mode enabled
[   43.700000] r8152 2-2:1.0 eth1: carrier on
[   43.710000] br-lan: port 1(eth1) entered blocking state
[   43.720000] br-lan: port 1(eth1) entered forwarding state



BusyBox v1.37.0 (2025-09-24 01:36:46 UTC) built-in shell (ash)

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 OpenWrt SNAPSHOT, r31146+11-4eae48d9dc
 -----------------------------------------------------
=== WARNING! =====================================
There is no root password defined on this device!
Use the "passwd" command to set up a new password
in order to prevent unauthorized SSH logins.
--------------------------------------------------

 OpenWrt recently switched to the "apk" package manager!

 OPKG Command           APK Equivalent      Description
 ------------------------------------------------------------------
 opkg install <pkg>     apk add <pkg>       Install a package
 opkg remove <pkg>      apk del <pkg>       Remove a package
 opkg upgrade           apk upgrade         Upgrade all packages
 opkg files <pkg>       apk info -L <pkg>   List package contents
 opkg list-installed    apk info            List installed packages
 opkg update            apk update          Update package lists
 opkg search <pkg>      apk search <pkg>    Search for packages
 ------------------------------------------------------------------

For more https://openwrt.org/docs/guide-user/additional-software/opkg-to-apk-cheatsheet

root@OpenWrt:~# ip link set lan1 down
root@OpenWrt:~# ip link add br0 type bridge
root@OpenWrt:~# ip link set lan1 master br0
[   80.220000] br0: port 1(lan1) entered blocking state
[   80.230000] br0: port 1(lan1) entered disabled state
[   80.230000] gswip 1e108000.switch lan1: entered allmulticast mode
[   80.240000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[   80.250000] gswip 1e108000.switch lan1: entered promiscuous mode
[   80.250000] gswip 1e108000.switch: port 4 failed to add f6:a7:ab:f9:68:34 vid 1 to fdb: -22
[   80.260000] gswip 1e108000.switch: port 4 failed to add 5a:d1:4d:d0:d0:b5 vid 0 to fdb: -22
[   80.270000] gswip 1e108000.switch: port 4 failed to add 5a:d1:4d:d0:d0:b5 vid 1 to fdb: -22
[   80.280000] gswip 1e108000.switch: port 4 failed to delete f6:a7:ab:f9:68:34 vid 1 from fdb: -2

root@OpenWrt:~# ip link set lan1 up
[   90.640000] gswip_port_enable called
[   90.640000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
root@OpenWrt:~# 

--IqF9REbJGjM+29E2--

