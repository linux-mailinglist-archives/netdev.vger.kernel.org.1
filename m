Return-Path: <netdev+bounces-224953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879CEB8BC96
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 03:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D783B048C
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 01:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83131D86D6;
	Sat, 20 Sep 2025 01:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2081C42056
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330464; cv=none; b=S7ajFqhO+F4dhsjpNJ94H6XkueCBiK+sgzbRNG/A6d+Xci7BfTAYZWhXyt3BOJLQ2U99K8CrryHE9Mif37ZLHZ5gq2JNhL91y9CxJc8kojGQU4YXwxXEwZZLdqlVPpw/Y1aaia8vhGn4bLiWEtOcmXs2WIOUg0jJO368Eu/eB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330464; c=relaxed/simple;
	bh=xNBQCYsRzzLNoePwkO3Z0UM4AurBXNBdtDscEu6Ui+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRYczN4Dbj6hlmam7Jtk5NgpgNFCRirvehT2NKMUx6YTwOEKFwj7w0pb/cD1DlLyDhIVAWw4FSRTltXLW3wEuP+g1UT0esnEsTgeC6ADZQ3X2MgcvzBKQnjGXIxSR8llJ918Jrvz8Kdj6VgVOyk4K68b3oWhBNZycDt73PahsC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uzm4W-000000006mV-2Xcc;
	Sat, 20 Sep 2025 01:07:28 +0000
Date: Sat, 20 Sep 2025 02:07:25 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 0/2] lantiq_gswip fixes
Message-ID: <aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
References: <20250918072142.894692-1-vladimir.oltean@nxp.com>
 <20250919165008.247549ab@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yf/pDU8Z4y6qtN9p"
Content-Disposition: inline
In-Reply-To: <20250919165008.247549ab@kernel.org>


--yf/pDU8Z4y6qtN9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Vladimir,
Hi Jakub,

sorry for the late reply.
I got both patches in my testing tree for long time and can confirm that
both are fixing real issues.

On Fri, Sep 19, 2025 at 04:50:08PM -0700, Jakub Kicinski wrote:
> On Thu, 18 Sep 2025 10:21:40 +0300 Vladimir Oltean wrote:
> > This is a small set of fixes which I believe should be backported for
> > the lantiq_gswip driver. Daniel Golle asked me to submit them here:
> > https://lore.kernel.org/netdev/aLiDfrXUbw1O5Vdi@pidgin.makrotopia.org/
> > 
> > As mentioned there, a merge conflict with net-next is expected, due to
> > the movement of the driver to the 'drivers/net/dsa/lantiq' folder there.
> > Good luck :-/
> > 
> > Patch 2/2 fixes an old regression and is the minimal fix for that, as
> > discussed here:
> > https://lore.kernel.org/netdev/aJfNMLNoi1VOsPrN@pidgin.makrotopia.org/
> > 
> > Patch 1/2 was identified by me through static analysis, and I consider
> > it to be a serious deficiency. It needs a test tag.
> 
> Daniel, can we count on your for that?

I have now built the 'net' tree with only the two patches on top, and run
local_termination.sh for basic testing before and after. I've attached the
results of both test runs, before and after applying both patches.
Consider the whole series

Tested-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>

I hope we can proceed with the other important fixes Vladimir has pulled
out of his slieve[1], however, I agree that not all of them should go via
the 'net' tree, and I suppose (speaking for all of OpenWrt, which is the
main user when it comes to devices with Lantiq SoC containing those
switches) that going via net-next is fine -- we can still backport
individual commits, or even all of them, and apply them on OpenWrt's
current Linux 6.12 kernel sources.

[1]: https://github.com/vladimiroltean/linux/commits/lantiq-gswip/

--yf/pDU8Z4y6qtN9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=before.txt

(AVM) EVA Revision: 1.1964 Version: 2964
(C) Copyright 2005 AVM Date: Nov 27 2013 Time: 14:33:10 (0) 3 0x0-0x740D

[FLASH:] MACRONIX Uniform-Flash 1MB 256 Bytes WriteBuffer
[FLASH:](Eraseregion [0] 16 sectors a 64kB) 
[NAND:] 512MB MICRON 2048 Pagesize 128k Blocksize 4096 Blocks 8Bit 1 CS HW
[SYSTEM:] VR9 on 500MHz/250MHz/250MHz

.Atheros 8030/35 detected

Eva_AVM >##..................................................................
[    0.000000] Linux version 6.17.0-rc5+ (daniel@mixxxtop) (mips-openwrt-linux-gnu-gcc (OpenWrt GCC 14.3.0 r30716+1-56b083221f) 14.3.0, GNU ld (GNU Binutils) 2.42) #0 SMP Thu Sep  4 23:19:13 2025
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
[    0.000000] Writing ErrCtl register=00042003
[    0.000000] Readback ErrCtl register=00042003
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
[    0.210000] Memory: 246400K/262144K available (8707K kernel code, 638K rwdata, 1068K rodata, 1284K init, 219K bss, 14608K reserved, 0K cma-reserved)
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
[    0.980000] 0x000000040000-0x0000000a0000 : "tffs (1)"
[    0.990000] 0x0000000a0000-0x000000100000 : "tffs (2)"
[    1.010000] NET: Registered PF_INET6 protocol family
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
[    1.300000] pci 0000:00:00.0: 0x80848e10 took 17148 usecs
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
[    7.190000] pci 0000:01:00.0: xHCI HW not ready after 5 sec (HC bug?) status = 0x801
[    7.190000] pci 0000:01:00.0: 0x805ad224 took 5623107 usecs
[    7.200000] UBI: auto-attach mtd1
[    7.200000] ubi0: attaching mtd1
[    8.880000] ubi0: scanning is finished
[    8.900000] ubi0: attached mtd1 (name "ubi", size 508 MiB)
[    8.910000] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 129024 bytes
[    8.910000] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 512
[    8.920000] ubi0: VID header offset: 512 (aligned 512), data offset: 2048
[    8.930000] ubi0: good PEBs: 4062, bad PEBs: 2, corrupted PEBs: 0
[    8.930000] ubi0: user volume: 2, internal volumes: 1, max. volumes count: 128
[    8.940000] ubi0: max/mean erase counter: 14/6, WL threshold: 4096, image sequence number: 699232088
[    8.950000] ubi0: available PEBs: 0, total reserved PEBs: 4062, PEBs reserved for bad PEB handling: 78
[    8.960000] ubi0: background thread "ubi_bgt0d" started, PID 310
[    8.960000] block ubiblock0_0: created from ubi0:0(rootfs)
[    8.970000] ubiblock: device ubiblock0_0 (rootfs) set to be root files[    8.980000] check access for rdinit=/init failed: -2, ignoring
[    8.990000] VFS: Mounted root (squashfs filesystem) readonly on device 254:0.
[    9.000000] Freeing unused kernel image (initmem) memory: 1284K
[    9.000000] This architecture does not have kernel memory protection.
[    9.010000] Run /sbin/init as init process
[   10.410000] init: Console is alive
[   10.410000] init: - watchdog -
[   11.370000] kmodloader: loading kernel modules from /etc/modules-boot.d/*
[   11.640000] SCSI subsystem initialized
[   11.660000] ifx_pcie_bios_map_irq port 0 dev 0000:01:00.0 slot 0 pin 1 
[   11.660000] ifx_pcie_bios_map_irq dev 0000:01:00.0 irq 144 assigned
[   11.670000] ifx_pcie_bios_map_irq port 0 dev 0000:01:00.0 slot 0 pin 1 
[   11.680000] ifx_pcie_bios_map_irq dev 0000:01:00.0 irq 144 assigned
[   12.120000] xhci-pci-renesas 0000:01:00.0: xHCI Host Controller
[   12.130000] xhci-pci-renesas 0000:01:00.0: new USB bus registered, assigned bus number 1
[   12.140000] xhci-pci-renesas 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x0000000100000090
[   12.150000] xhci-pci-renesas 0000:01:00.0: xHCI Host Controller
[   12.150000] xhci-pci-renesas 0000:01:00.0: new USB bus registered, assigned bus number 2
[   12.160000] xhci-pci-renesas 0000:01:00.0: Host supports USB 3.0 SuperSpeed
[   12.170000] hub 1-0:1.0: USB hub found
[   12.170000] hub 1-0:1.0: 2 ports detected
[   12.180000] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[   12.190000] hub 2-0:1.0: USB hub found
[   12.190000] hub 2-0:1.0: 2 ports detected
[   12.210000] usbcore: registered new interface driver usb-storage
[   12.220000] kmodloader: done loading kernel modules from /etc/modules-boot.d/*
[   12.230000] init: - preinit -
[   13.310000] usb 2-2: new SuperSpeed USB device number 2 using xhci-pci-renesas
[   15.520000] random: crng init done
Press the [f] key and hit [enter] to enter failsafe mode
Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
[   23.070000] UBIFS (ubi0:1): Mounting in unauthenticated mode
[   23.080000] UBIFS (ubi0:1): background thread "ubifs_bgt0_1" started, PID 482
[   23.130000] UBIFS (ubi0:1): recovery needed
[   23.250000] UBIFS (ubi0:1): recovery completed
[   23.250000] UBIFS (ubi0:1): UBIFS: mounted UBI device 0, volume 1, name "rootfs_data"
[   23.260000] UBIFS (ubi0:1): LEB size: 129024 bytes (126 KiB), min./max. I/O unit sizes: 2048 bytes/2048 bytes
[   23.270000] UBIFS (ubi0:1): FS size: 452616192 bytes (431 MiB, 3508 LEBs), max 3523 LEBs, journal size 22708224 bytes (21 MiB, 176 LEBs)
[   23.280000] UBIFS (ubi0:1): reserved for root: 4952683 bytes (4836 KiB)
[   23.290000] UBIFS (ubi0:1): media format: w5/r0 (latest is w5/r0), UUID BCD8DFDD-8055-4773-BDB8-AAC44BCE2457, small LPT model
[   23.300000] mount_root: switching to ubifs overlay
[   23.320000] urandom-seed: Seeding with /etc/urandom.seed
[   23.480000] procd: - early -
[   23.480000] procd: - watchdog -
[   24.320000] procd: - watchdog -
[   24.330000] procd: - ubus -
[   24.530000] procd: - init -
Please press Enter to activate this console.
[   26.840000] kmodloader: loading kernel modules from /etc/modules.d/*
[   28.830000] urngd: v1.0.2 started.
[   29.290000] gswip 1e108000.switch: configuring for fixed/internal link mode
[   29.300000] gswip 1e108000.switch: Link is Up - 1Gbps/Full - flow control off
[   29.390000] gswip 1e108000.switch lan3 (uninitialized): PHY [1e108000.switch-mii:00] driver [Qualcomm Atheros AR8035] (irq=POLL)
[   29.490000] gswip 1e108000.switch lan4 (uninitialized): PHY [1e108000.switch-mii:01] driver [Qualcomm Atheros AR8035] (irq=POLL)
[   29.520000] gswip 1e108000.switch lan2 (uninitialized): PHY [1e108000.switch-mii:11] driver [Intel XWAY PHY11G (xRX v1.2 integrated)] (irq=POLL)
[   29.580000] gswip 1e108000.switch lan1 (uninitialized): PHY [1e108000.switch-mii:13] driver [Intel XWAY PHY11G (xRX v1.2 integrated)] (irq=POLL)
[   29.610000] lantiq,xrx200-net 1e10b308.eth eth0: entered promiscuous mode
[   29.620000] DSA: tree 0 setup
[   29.620000] gswip 1e108000.switch: probed GSWIP version 21 mod 0
[   29.660000] GACT probability on
[   29.680000] Mirror/redirect action on
[   29.740000] u32 classifier
[   29.740000]     input device check on
[   29.750000]     Actions configured
[   30.200000] mdio_netlink: loading out-of-tree module taints kernel.
[   30.270000] usbcore: registered new device driver r8152-cfgselector
[   30.460000] r8152-cfgselector 2-2: reset SuperSpeed USB device number 2 using xhci-pci-renesas
[   30.940000] r8152 2-2:1.0 eth1: v1.12.13
[   30.940000] usbcore: registered new interface driver r8152
[   30.960000] usbcore: registered new interface driver rtl8150
[   30.990000] kmodloader: done loading kernel modules from /etc/modules.d/*
[   39.590000] br-lan: port 1(eth1) entered blocking state
[   39.590000] br-lan: port 1(eth1) entered disabled state
[   39.590000] r8152 2-2:1.0 eth1: entered allmulticast mode
[   39.600000] r8152 2-2:1.0 eth1: entered promiscuous mode
[   39.680000] br-lan: port 1(eth1) entered blocking state
[   39.680000] br-lan: port 1(eth1) entered forwarding state
[   40.490000] br-lan: port 1(eth1) entered disabled state
[   43.360000] r8152 2-2:1.0 eth1: Promiscuous mode enabled
[   43.360000] r8152 2-2:1.0 eth1: carrier on
[   43.370000] br-lan: port 1(eth1) entered blocking state
[   43.380000] br-lan: port 1(eth1) entered forwarding state



BusyBox v1.37.0 (2025-09-04 23:19:13 UTC) built-in shell (ash)

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 OpenWrt SNAPSHOT, r30959+10-b4294bc980
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

root@OpenWrt:~# cd /selftests/drivers/net/dsa/
root@OpenWrt:/selftests/drivers/net/dsa# ./local_termination.sh lan1 lan2 lan3 lan4
[  149.240000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  149.270000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  151.370000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  152.410000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  157.820000] gswip 1e108000.switch lan2: entered promiscuous mode
[  158.280000] gswip 1e108000.switch lan1: Link is Down
[  158.300000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  158.590000] gswip 1e108000.switch lan2: left promiscuous mode
[  158.600000] gswip 1e108000.switch lan2: Link is Down
[  158.620000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  158.830000] gswip 1e108000.switch lan2: entered promiscuous mode
[  161.440000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  161.760000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  181.320000] gswip 1e108000.switch lan2: entered allmulticast mode
[  181.320000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  186.930000] gswip 1e108000.switch lan2: left allmulticast mode
[  186.940000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
TEST: lan2: Unicast IPv4 to primary MAC address                     [ OK ]
TEST: lan2: Unicast IPv4 to macvlan MAC address                     [ OK ]
TEST: lan2: Unicast IPv4 to unknown MAC address                     [ OK ]
TEST: lan2: Unicast IPv4 to unknown MAC address, promisc            [ OK ]
TEST: lan2: Unicast IPv4 to unknown MAC address, allmulti           [ OK ]
TEST: lan2: Multicast IPv4 to joined group                          [ OK ]
TEST: lan2: Multicast IPv4 to unknown group                         [XFAIL]
	reception succeeded, but should have failed
TEST: lan2: Multicast IPv4 to unknown group, promisc                [ OK ]
TEST: lan2: Multicast IPv4 to unknown group, allmulti               [ OK ]
TEST: lan2: Multicast IPv6 to joined group                          [ OK ]
TEST: lan2: Multicast IPv6 to unknown group                         [XFAIL]
	reception succeeded, but should have failed
TEST: lan2: Multicast IPv6 to unknown group, promisc                [ OK ]
TEST: lan2: Multicast IPv6 to unknown group, allmulti               [ OK ]
TEST: lan2: 1588v2 over L2 transport, Sync                          [ OK ]
TEST: lan2: 1588v2 over L2 transport, Follow-Up                     [ OK ]
TEST: lan2: 1588v2 over L2 transport, Peer Delay Request            [ OK ]
TEST: lan2: 1588v2 over IPv4, Sync                                  [ OK ]
TEST: lan2: 1588v2 over IPv4, Follow-Up                             [ OK ]
TEST: lan2: 1588v2 over IPv4, Peer Delay Request                    [ OK ]
TEST: lan2: 1588v2 over IPv6, Sync                                  [ OK ]
TEST: lan2: 1588v2 over IPv6, Follow-Up                             [ OK ]
TEST: lan2: 1588v2 over IPv6, Peer Delay Request                    [ OK ]
[  198.700000] gswip 1e108000.switch lan2: left promiscuous mode
[  198.730000] gswip 1e108000.switch lan2: Link is Down
[  198.960000] gswip 1e108000.switch lan1: Link is Down
[  199.580000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  199.770000] br0: port 1(lan2) entered blocking state
[  199.780000] br0: port 1(lan2) entered disabled state
[  199.780000] gswip 1e108000.switch lan2: entered allmulticast mode
[  199.790000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  199.820000] gswip 1e108000.switch lan2: entered promiscuous mode
[  199.830000] gswip 1e108000.switch: port 2 failed to add 00:00:de:ad:be:ee vid 1 to fdb: -22
[  199.840000] gswip 1e108000.switch: port 2 failed to add 00:00:de:ad:be:ee vid 0 to fdb: -22
[  199.850000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 0 to fdb: -22
[  199.880000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 1 to fdb: -22
[  199.910000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  200.330000] br0: entered promiscuous mode
[  202.730000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  203.130000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  203.130000] br0: port 1(lan2) entered blocking state
[  203.140000] br0: port 1(lan2) entered forwarding state
[  222.360000] br0: entered allmulticast mode
[  227.960000] br0: left allmulticast mode
TEST: vlan_filtering=0 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv4 to joined group       [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group      [XFAIL]
	reception succeeded, but should have failed
TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv6 to joined group       [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group      [XFAIL]
	reception succeeded, but should have failed
TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
[  231.700000] br0: left promiscuous mode
[  231.890000] br0: port 1(lan2) entered disabled state
[  232.200000] gswip 1e108000.switch lan2: left allmulticast mode
[  232.200000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
[  232.210000] gswip 1e108000.switch lan2: left promiscuous mode
[  232.210000] br0: port 1(lan2) entered disabled state
[  232.220000] gswip 1e108000.switch: port 2 failed to delete 00:01:02:03:04:02 vid 1 from fdb: -2
[  232.230000] gswip 1e108000.switch: port 2 failed to delete 00:01:02:03:04:02 vid 0 from fdb: -2
[  232.240000] gswip 1e108000.switch: port 2 failed to delete 00:00:de:ad:be:ee vid 1 from fdb: -2
[  232.240000] gswip 1e108000.switch: port 2 failed to delete 00:00:de:ad:be:ee vid 0 from fdb: -2
[  232.440000] gswip 1e108000.switch lan1: Link is Down
[  232.990000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  233.170000] br0: port 1(lan2) entered blocking state
[  233.180000] br0: port 1(lan2) entered disabled state
[  233.180000] gswip 1e108000.switch lan2: entered allmulticast mode
[  233.190000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  233.200000] gswip 1e108000.switch lan2: entered promiscuous mode
[  233.210000] br0: port 1(lan2) entered blocking state
[  233.210000] br0: port 1(lan2) entered forwarding state
[  233.230000] gswip 1e108000.switch: port 2 failed to add 00:00:de:ad:be:ee vid 1 to fdb: -22
[  233.250000] gswip 1e108000.switch: port 2 failed to add 00:00:de:ad:be:ee vid 0 to fdb: -22
[  233.250000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 0 to fdb: -22
[  233.270000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 1 to fdb: -22
[  233.300000] gswip 1e108000.switch lan2: Link is Down
[  233.300000] br0: port 1(lan2) entered disabled state
[  233.750000] br0: entered promiscuous mode
[  235.360000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  235.360000] br0: port 1(lan2) entered blocking state
[  235.370000] br0: port 1(lan2) entered forwarding state
[  236.160000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  255.280000] br0: entered allmulticast mode
[  260.870000] br0: left allmulticast mode
TEST: vlan_filtering=1 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv4 to joined group       [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group      [XFAIL]
	reception succeeded, but should have failed
TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv6 to joined group       [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group      [XFAIL]
	reception succeeded, but should have failed
TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
[  264.710000] br0: left promiscuous mode
[  264.890000] br0: port 1(lan2) entered disabled state
[  265.160000] gswip 1e108000.switch lan2: left allmulticast mode
[  265.170000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
[  265.170000] gswip 1e108000.switch lan2: left promiscuous mode
[  265.180000] br0: port 1(lan2) entered disabled state
[  265.190000] gswip 1e108000.switch: port 2 failed to delete 00:01:02:03:04:02 vid 1 from fdb: -2
[  265.190000] gswip 1e108000.switch: port 2 failed to delete 00:01:02:03:04:02 vid 0 from fdb: -2
[  265.200000] gswip 1e108000.switch: port 2 failed to delete 00:00:de:ad:be:ee vid 1 from fdb: -2
[  265.210000] gswip 1e108000.switch: port 2 failed to delete 00:00:de:ad:be:ee vid 0 from fdb: -2
[  265.390000] gswip 1e108000.switch lan1: Link is Down
[  265.530000] gswip 1e108000.switch lan2: Link is Down
[  265.950000] gswip 1e108000.switch lan2: entered promiscuous mode
[  266.470000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  266.920000] gswip 1e108000.switch lan2: left promiscuous mode
[  266.930000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  267.340000] gswip 1e108000.switch lan2: entered promiscuous mode
[  269.040000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  269.600000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  284.710000] lan2.100: entered promiscuous mode
[  290.290000] lan2.100: left promiscuous mode
[  293.250000] lan2.100: entered allmulticast mode
[  293.250000] gswip 1e108000.switch lan2: entered allmulticast mode
[  293.250000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  298.870000] lan2.100: left allmulticast mode
[  298.870000] gswip 1e108000.switch lan2: left allmulticast mode
[  298.870000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
TEST: VLAN upper: Unicast IPv4 to primary MAC address               [FAIL]
	reception failed
TEST: VLAN upper: Unicast IPv4 to macvlan MAC address               [FAIL]
	reception failed
TEST: VLAN upper: Unicast IPv4 to unknown MAC address               [FAIL]
	reception failed
TEST: VLAN upper: Unicast IPv4 to unknown MAC address, promisc      [FAIL]
	reception failed
TEST: VLAN upper: Unicast IPv4 to unknown MAC address, allmulti     [FAIL]
	reception failed
TEST: VLAN upper: Multicast IPv4 to joined group                    [FAIL]
	reception failed
TEST: VLAN upper: Multicast IPv4 to unknown group                   [ OK ]
TEST: VLAN upper: Multicast IPv4 to unknown group, promisc          [FAIL]
	reception failed
TEST: VLAN upper: Multicast IPv4 to unknown group, allmulti         [FAIL]
	reception failed
TEST: VLAN upper: Multicast IPv6 to joined group                    [FAIL]
	reception failed
TEST: VLAN upper: Multicast IPv6 to unknown group                   [ OK ]
TEST: VLAN upper: Multicast IPv6 to unknown group, promisc          [FAIL]
	reception failed
TEST: VLAN upper: Multicast IPv6 to unknown group, allmulti         [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over L2 transport, Sync                    [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over L2 transport, Follow-Up               [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over L2 transport, Peer Delay Request      [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over IPv4, Sync                            [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over IPv4, Follow-Up                       [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over IPv4, Peer Delay Request              [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over IPv6, Sync                            [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over IPv6, Follow-Up                       [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over IPv6, Peer Delay Request              [FAIL]
	reception failed
[  309.610000] gswip 1e108000.switch lan2: left promiscuous mode
[  309.730000] gswip 1e108000.switch lan2: Link is Down
[  310.080000] gswip 1e108000.switch lan1: Link is Down
[  310.520000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  310.650000] gswip 1e108000.switch lan2: entered promiscuous mode
[  311.200000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  311.650000] gswip 1e108000.switch lan2: left promiscuous mode
[  311.670000] gswip 1e108000.switch lan2: entered promiscuous mode
[  311.680000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  312.130000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  312.130000] br0: port 1(lan2) entered blocking state
[  312.140000] br0: port 1(lan2) entered disabled state
[  312.140000] gswip 1e108000.switch lan2: entered allmulticast mode
[  312.150000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  312.180000] gswip 1e108000.switch: port 2 failed to add 00:00:de:ad:be:ee vid 1 to fdb: -22
[  312.210000] gswip 1e108000.switch: port 2 failed to add 00:00:de:ad:be:ee vid 0 to fdb: -22
[  312.210000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 0 to fdb: -22
[  312.240000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 1 to fdb: -22
[  314.330000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  315.290000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  315.290000] br0: port 1(lan2) entered blocking state
[  315.300000] br0: port 1(lan2) entered forwarding state
[  326.280000] lan2.100: entered promiscuous mode
[  331.880000] lan2.100: left promiscuous mode
[  334.860000] lan2.100: entered allmulticast mode
[  340.450000] lan2.100: left allmulticast mode
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Sync   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Peer Delay Request   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Sync   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Peer Delay Request   [ OK ]
[  351.740000] gswip 1e108000.switch lan2: left allmulticast mode
[  351.740000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
[  351.750000] br0: port 1(lan2) entered disabled state
[  351.760000] gswip 1e108000.switch: port 2 failed to delete 00:01:02:03:04:02 vid 1 from fdb: -2
[  351.770000] gswip 1e108000.switch: port 2 failed to delete 00:01:02:03:04:02 vid 0 from fdb: -2
[  351.780000] gswip 1e108000.switch: port 2 failed to delete 00:00:de:ad:be:ee vid 1 from fdb: -2
[  351.790000] gswip 1e108000.switch: port 2 failed to delete 00:00:de:ad:be:ee vid 0 from fdb: -2
[  352.030000] gswip 1e108000.switch lan2: Link is Down
[  352.400000] gswip 1e108000.switch lan1: Link is Down
[  352.850000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  353.510000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  354.010000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  354.390000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  354.390000] br0: port 1(lan2) entered blocking state
[  354.400000] br0: port 1(lan2) entered disabled state
[  354.400000] gswip 1e108000.switch lan2: entered allmulticast mode
[  354.410000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  354.420000] gswip 1e108000.switch: port 2 failed to add 00:00:de:ad:be:ee vid 1 to fdb: -22
[  354.430000] gswip 1e108000.switch: port 2 failed to add 00:00:de:ad:be:ee vid 0 to fdb: -22
[  354.450000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 0 to fdb: -22
[  354.450000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 1 to fdb: -22
[  356.640000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  357.530000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  357.530000] br0: port 1(lan2) entered blocking state
[  357.540000] br0: port 1(lan2) entered forwarding state
[  368.030000] lan2.100: entered promiscuous mode
[  373.680000] lan2.100: left promiscuous mode
[  376.660000] lan2.100: entered allmulticast mode
[  382.240000] lan2.100: left allmulticast mode
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address   [FAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [FAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Sync   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Peer Delay Request   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Sync   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Peer Delay Request   [ OK ]
[  394.100000] gswip 1e108000.switch lan2: left allmulticast mode
[  394.100000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
[  394.110000] br0: port 1(lan2) entered disabled state
[  394.120000] gswip 1e108000.switch: port 2 failed to delete 00:01:02:03:04:02 vid 1 from fdb: -2
[  394.120000] gswip 1e108000.switch: port 2 failed to delete 00:01:02:03:04:02 vid 0 from fdb: -2
[  394.140000] gswip 1e108000.switch: port 2 failed to delete 00:00:de:ad:be:ee vid 1 from fdb: -2
[  394.140000] gswip 1e108000.switch: port 2 failed to delete 00:00:de:ad:be:ee vid 0 from fdb: -2
[  394.150000] gswip 1e108000.switch: bridge to leave does not exists
[  394.160000] gswip 1e108000.switch: port 2 failed to reset VLAN filtering to 0: -ENOENT
[  394.290000] gswip 1e108000.switch: bridge to leave does not exists
[  394.290000] gswip 1e108000.switch lan2: failed to kill vid 8100/100
[  394.430000] gswip 1e108000.switch lan2: Link is Down
[  394.810000] gswip 1e108000.switch lan1: Link is Down
[  395.390000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  395.780000] br0: port 1(lan2) entered blocking state
[  395.780000] br0: port 1(lan2) entered disabled state
[  395.780000] gswip 1e108000.switch lan2: entered allmulticast mode
[  395.790000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  395.820000] gswip 1e108000.switch: port 2 failed to add 00:00:de:ad:be:ee vid 1 to fdb: -22
[  395.820000] gswip 1e108000.switch: port 2 failed to add 00:00:de:ad:be:ee vid 0 to fdb: -22
[  395.840000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 0 to fdb: -22
[  395.840000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 1 to fdb: -22
[  395.910000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  396.520000] br0: entered promiscuous mode
[  398.010000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  398.010000] br0: port 1(lan2) entered blocking state
[  398.020000] br0: port 1(lan2) entered forwarding state
[  398.560000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  409.260000] br0.100: entered promiscuous mode
[  414.880000] br0.100: left promiscuous mode
[  417.870000] br0.100: entered allmulticast mode
[  417.870000] br0: entered allmulticast mode
[  423.500000] br0.100: left allmulticast mode
[  423.500000] br0: left allmulticast mode
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
[  427.270000] br0: left promiscuous mode
[  427.510000] br0: port 1(lan2) entered disabled state
[  427.750000] gswip 1e108000.switch lan2: left allmulticast mode
[  427.750000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
[  427.760000] br0: port 1(lan2) entered disabled state
[  427.760000] gswip 1e108000.switch: port 2 failed to delete 00:01:02:03:04:02 vid 1 from fdb: -2
[  427.770000] gswip 1e108000.switch: port 2 failed to delete 00:01:02:03:04:02 vid 0 from fdb: -2
[  427.780000] gswip 1e108000.switch: port 2 failed to delete 00:00:de:ad:be:ee vid 1 from fdb: -2
[  427.790000] gswip 1e108000.switch: port 2 failed to delete 00:00:de:ad:be:ee vid 0 from fdb: -2
[  428.040000] gswip 1e108000.switch lan1: Link is Down
[  428.160000] gswip 1e108000.switch lan2: Link is Down
[  428.600000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  428.970000] br0: port 1(lan2) entered blocking state
[  428.980000] br0: port 1(lan2) entered disabled state
[  428.980000] gswip 1e108000.switch lan2: entered allmulticast mode
[  428.990000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  429.010000] gswip 1e108000.switch: port 2 failed to add 00:00:de:ad:be:ee vid 1 to fdb: -22
[  429.020000] gswip 1e108000.switch: port 2 failed to add 00:00:de:ad:be:ee vid 0 to fdb: -22
[  429.050000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 0 to fdb: -22
[  429.050000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 1 to fdb: -22
[  429.700000] br0: entered promiscuous mode
[  429.820000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 100 to fdb: -22
[  429.880000] gswip 1e108000.switch: port 2 failed to add 00:00:de:ad:be:ee vid 100 to fdb: -22
[  431.280000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  431.290000] br0: port 1(lan2) entered blocking state
[  431.290000] br0: port 1(lan2) entered forwarding state
[  431.760000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  442.290000] br0.100: entered promiscuous mode
[  447.910000] br0.100: left promiscuous mode
[  450.900000] br0.100: entered allmulticast mode
[  450.900000] br0: entered allmulticast mode
[  456.500000] br0.100: left allmulticast mode
[  456.500000] br0: left allmulticast mode
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
[  460.360000] gswip 1e108000.switch: port 2 failed to delete 00:00:de:ad:be:ee vid 100 from fdb: -2
[  460.390000] gswip 1e108000.switch: port 2 failed to delete 00:01:02:03:04:02 vid 100 from fdb: -2
[  460.420000] br0: left promiscuous mode
[  460.640000] br0: port 1(lan2) entered disabled state
[  460.930000] gswip 1e108000.switch lan2: left allmulticast mode
[  460.940000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
[  460.940000] br0: port 1(lan2) entered disabled state
[  460.950000] gswip 1e108000.switch: port 2 failed to delete 00:01:02:03:04:02 vid 1 from fdb: -2
[  460.960000] gswip 1e108000.switch: port 2 failed to delete 00:01:02:03:04:02 vid 0 from fdb: -2
[  460.970000] gswip 1e108000.switch: port 2 failed to delete 00:00:de:ad:be:ee vid 1 from fdb: -2
[  460.970000] gswip 1e108000.switch: port 2 failed to delete 00:00:de:ad:be:ee vid 0 from fdb: -2
[  461.240000] gswip 1e108000.switch lan1: Link is Down
[  461.440000] gswip 1e108000.switch lan2: Link is Down
root@OpenWrt:/selftests/drivers/net/dsa# 

--yf/pDU8Z4y6qtN9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=after.txt

(AVM) EVA Revision: 1.1964 Version: 2964
(C) Copyright 2005 AVM Date: Nov 27 2013 Time: 14:33:10 (0) 3 0x0-0x740D

[FLASH:] MACRONIX Uniform-Flash 1MB 256 Bytes WriteBuffer
[FLASH:](Eraseregion [0] 16 sectors a 64kB) 
[NAND:] 512MB MICRON 2048 Pagesize 128k Blocksize 4096 Blocks 8Bit 1 CS HW
[SYSTEM:] VR9 on 500MHz/250MHz/250MHz

.Atheros 8030/35 detected

Eva_AVM >##..................................................................
[    0.000000] Linux version 6.17.0-rc5+ (daniel@mixxxtop) (mips-openwrt-linux-gnu-gcc (OpenWrt GCC 14.3.0 r30716+1-56b083221f) 14.3.0, GNU ld (GNU Binutils) 2.42) #0 SMP Thu Sep  4 23:19:13 2025
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
[    0.000000] Writing ErrCtl register=00042000
[    0.000000] Readback ErrCtl register=00042000
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
[    0.210000] Memory: 246400K/262144K available (8707K kernel code, 638K rwdata, 1068K rodata, 1284K init, 219K bss, 14608K reserved, 0K cma-reserved)
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
[    0.980000] 0x000000040000-0x0000000a0000 : "tffs (1)"
[    0.990000] 0x0000000a0000-0x000000100000 : "tffs (2)"
[    1.010000] NET: Registered PF_INET6 protocol family
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
[    1.300000] pci 0000:00:00.0: 0x80848e10 took 17155 usecs
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
[    7.190000] pci 0000:01:00.0: xHCI HW not ready after 5 sec (HC bug?) status = 0x801
[    7.190000] pci 0000:01:00.0: 0x805ad224 took 5623393 usecs
[    7.200000] UBI: auto-attach mtd1
[    7.200000] ubi0: attaching mtd1
[    8.880000] ubi0: scanning is finished
[    8.900000] ubi0: attached mtd1 (name "ubi", size 508 MiB)
[    8.910000] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 129024 bytes
[    8.910000] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 512
[    8.920000] ubi0: VID header offset: 512 (aligned 512), data offset: 2048
[    8.930000] ubi0: good PEBs: 4062, bad PEBs: 2, corrupted PEBs: 0
[    8.930000] ubi0: user volume: 2, internal volumes: 1, max. volumes count: 128
[    8.940000] ubi0: max/mean erase counter: 14/6, WL threshold: 4096, image sequence number: 699232088
[    8.950000] ubi0: available PEBs: 0, total reserved PEBs: 4062, PEBs reserved for bad PEB handling: 78
[    8.960000] ubi0: background thread "ubi_bgt0d" started, PID 308
[    8.960000] block ubiblock0_0: created from ubi0:0(rootfs)
[    8.970000] ubiblock: device ubiblock0_0 (rootfs) set to be root files[    8.980000] check access for rdinit=/init failed: -2, ignoring
[    8.990000] VFS: Mounted root (squashfs filesystem) readonly on device 254:0.
[    9.000000] Freeing unused kernel image (initmem) memory: 1284K
[    9.000000] This architecture does not have kernel memory protection.
[    9.010000] Run /sbin/init as init process
[   10.410000] init: Console is alive
[   10.410000] init: - watchdog -
[   11.360000] kmodloader: loading kernel modules from /etc/modules-boot.d/*
[   11.630000] SCSI subsystem initialized
[   11.660000] ifx_pcie_bios_map_irq port 0 dev 0000:01:00.0 slot 0 pin 1 
[   11.660000] ifx_pcie_bios_map_irq dev 0000:01:00.0 irq 144 assigned
[   11.670000] ifx_pcie_bios_map_irq port 0 dev 0000:01:00.0 slot 0 pin 1 
[   11.680000] ifx_pcie_bios_map_irq dev 0000:01:00.0 irq 144 assigned
[   12.120000] xhci-pci-renesas 0000:01:00.0: xHCI Host Controller
[   12.120000] xhci-pci-renesas 0000:01:00.0: new USB bus registered, assigned bus number 1
[   12.140000] xhci-pci-renesas 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x0000000100000090
[   12.140000] xhci-pci-renesas 0000:01:00.0: xHCI Host Controller
[   12.150000] xhci-pci-renesas 0000:01:00.0: new USB bus registered, assigned bus number 2
[   12.160000] xhci-pci-renesas 0000:01:00.0: Host supports USB 3.0 SuperSpeed
[   12.170000] hub 1-0:1.0: USB hub found
[   12.170000] hub 1-0:1.0: 2 ports detected
[   12.180000] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[   12.190000] hub 2-0:1.0: USB hub found
[   12.190000] hub 2-0:1.0: 2 ports detected
[   12.210000] usbcore: registered new interface driver usb-storage
[   12.210000] kmodloader: done loading kernel modules from /etc/modules-boot.d/*
[   12.230000] init: - preinit -
[   13.300000] usb 2-2: new SuperSpeed USB device number 2 using xhci-pci-renesas
[   15.550000] random: crng init done
Press the [f] key and hit [enter] to enter failsafe mode
Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
[   23.110000] UBIFS (ubi0:1): Mounting in unauthenticated mode
[   23.130000] UBIFS (ubi0:1): background thread "ubifs_bgt0_1" started, PID 480
[   23.250000] UBIFS (ubi0:1): UBIFS: mounted UBI device 0, volume 1, name "rootfs_data"
[   23.260000] UBIFS (ubi0:1): LEB size: 129024 bytes (126 KiB), min./max. I/O unit sizes: 2048 bytes/2048 bytes
[   23.270000] UBIFS (ubi0:1): FS size: 452616192 bytes (431 MiB, 3508 LEBs), max 3523 LEBs, journal size 22708224 bytes (21 MiB, 176 LEBs)
[   23.280000] UBIFS (ubi0:1): reserved for root: 4952683 bytes (4836 KiB)
[   23.290000] UBIFS (ubi0:1): media format: w5/r0 (latest is w5/r0), UUID 73BD5097-CAE2-483C-BF22-9C84AB2132D1, small LPT model
[   23.300000] mount_root: overlay filesystem has not been fully initialized yet
[   23.310000] mount_root: switching to ubifs overlay
- config restore -
[   24.320000] urandom-seed: Seed file not found (/etc/urandom.seed)
[   24.460000] procd: - early -
[   24.460000] procd: - watchdog -
[   25.290000] procd: - watchdog -
[   25.290000] procd: - ubus -
[   25.500000] procd: - init -
Please press Enter to activate this console.
[   27.890000] kmodloader: loading kernel modules from /etc/modules.d/*
[   30.110000] urngd: v1.0.2 started.
[   30.210000] gswip 1e108000.switch: configuring for fixed/internal link mode
[   30.210000] gswip 1e108000.switch: Link is Up - 1Gbps/Full - flow control off
[   30.290000] gswip 1e108000.switch lan3 (uninitialized): PHY [1e108000.switch-mii:00] driver [Qualcomm Atheros AR8035] (irq=POLL)
[   30.400000] gswip 1e108000.switch lan4 (uninitialized): PHY [1e108000.switch-mii:01] driver [Qualcomm Atheros AR8035] (irq=POLL)
[   30.430000] gswip 1e108000.switch lan2 (uninitialized): PHY [1e108000.switch-mii:11] driver [Intel XWAY PHY11G (xRX v1.2 integrated)] (irq=POLL)
[   30.460000] gswip 1e108000.switch lan1 (uninitialized): PHY [1e108000.switch-mii:13] driver [Intel XWAY PHY11G (xRX v1.2 integrated)] (irq=POLL)
[   30.480000] lantiq,xrx200-net 1e10b308.eth eth0: entered promiscuous mode
[   30.490000] DSA: tree 0 setup
[   30.490000] gswip 1e108000.switch: probed GSWIP version 21 mod 0
[   30.520000] GACT probability on
[   30.540000] Mirror/redirect action on
[   30.590000] u32 classifier
[   30.590000]     input device check on
[   30.590000]     Actions configured
[   30.690000] mdio_netlink: loading out-of-tree module taints kernel.
[   30.750000] usbcore: registered new device driver r8152-cfgselector
[   30.940000] r8152-cfgselector 2-2: reset SuperSpeed USB device number 2 using xhci-pci-renesas
[   31.280000] r8152 2-2:1.0 eth1: v1.12.13
[   31.280000] usbcore: registered new interface driver r8152
[   31.320000] usbcore: registered new interface driver rtl8150
[   31.360000] kmodloader: done loading kernel modules from /etc/modules.d/*
[   43.870000] br-lan: port 1(eth1) entered blocking state
[   43.870000] br-lan: port 1(eth1) entered disabled state
[   43.880000] r8152 2-2:1.0 eth1: entered allmulticast mode
[   43.890000] r8152 2-2:1.0 eth1: entered promiscuous mode
[   43.910000] br-lan: port 1(eth1) entered blocking state
[   43.910000] br-lan: port 1(eth1) entered forwarding state
[   44.800000] br-lan: port 1(eth1) entered disabled state
[   47.480000] r8152 2-2:1.0 eth1: Promiscuous mode enabled
[   47.490000] r8152 2-2:1.0 eth1: carrier on
[   47.500000] br-lan: port 1(eth1) entered blocking state
[   47.500000] br-lan: port 1(eth1) entered forwarding state



BusyBox v1.37.0 (2025-09-04 23:19:13 UTC) built-in shell (ash)

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 OpenWrt SNAPSHOT, r30959+10-b4294bc980
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

root@OpenWrt:~# cd /selftests/drivers/net/dsa
root@OpenWrt:/selftests/drivers/net/dsa# ./local_termination.sh lan1 lan2 lan3 lan4
[   79.760000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[   79.800000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[   81.930000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[   82.880000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[   88.350000] gswip 1e108000.switch lan2: entered promiscuous mode
[   88.840000] gswip 1e108000.switch lan1: Link is Down
[   88.850000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[   89.180000] gswip 1e108000.switch lan2: left promiscuous mode
[   89.180000] gswip 1e108000.switch lan2: Link is Down
[   89.200000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[   89.380000] gswip 1e108000.switch lan2: entered promiscuous mode
[   92.000000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[   92.320000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  111.950000] gswip 1e108000.switch lan2: entered allmulticast mode
[  111.950000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  117.530000] gswip 1e108000.switch lan2: left allmulticast mode
[  117.540000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
TEST: lan2: Unicast IPv4 to primary MAC address                     [ OK ]
TEST: lan2: Unicast IPv4 to macvlan MAC address                     [ OK ]
TEST: lan2: Unicast IPv4 to unknown MAC address                     [ OK ]
TEST: lan2: Unicast IPv4 to unknown MAC address, promisc            [ OK ]
TEST: lan2: Unicast IPv4 to unknown MAC address, allmulti           [ OK ]
TEST: lan2: Multicast IPv4 to joined group                          [ OK ]
TEST: lan2: Multicast IPv4 to unknown group                         [XFAIL]
	reception succeeded, but should have failed
TEST: lan2: Multicast IPv4 to unknown group, promisc                [ OK ]
TEST: lan2: Multicast IPv4 to unknown group, allmulti               [ OK ]
TEST: lan2: Multicast IPv6 to joined group                          [ OK ]
TEST: lan2: Multicast IPv6 to unknown group                         [XFAIL]
	reception succeeded, but should have failed
TEST: lan2: Multicast IPv6 to unknown group, promisc                [ OK ]
TEST: lan2: Multicast IPv6 to unknown group, allmulti               [ OK ]
TEST: lan2: 1588v2 over L2 transport, Sync                          [ OK ]
TEST: lan2: 1588v2 over L2 transport, Follow-Up                     [ OK ]
TEST: lan2: 1588v2 over L2 transport, Peer Delay Request            [ OK ]
TEST: lan2: 1588v2 over IPv4, Sync                                  [ OK ]
TEST: lan2: 1588v2 over IPv4, Follow-Up                             [ OK ]
TEST: lan2: 1588v2 over IPv4, Peer Delay Request                    [ OK ]
TEST: lan2: 1588v2 over IPv6, Sync                                  [ OK ]
TEST: lan2: 1588v2 over IPv6, Follow-Up                             [ OK ]
TEST: lan2: 1588v2 over IPv6, Peer Delay Request                    [ OK ]
[  129.120000] gswip 1e108000.switch lan2: left promiscuous mode
[  129.150000] gswip 1e108000.switch lan2: Link is Down
[  129.450000] gswip 1e108000.switch lan1: Link is Down
[  129.990000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  130.200000] br0: port 1(lan2) entered blocking state
[  130.200000] br0: port 1(lan2) entered disabled state
[  130.210000] gswip 1e108000.switch lan2: entered allmulticast mode
[  130.210000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  130.240000] gswip 1e108000.switch lan2: entered promiscuous mode
[  130.330000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  130.740000] br0: entered promiscuous mode
[  133.130000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  133.450000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  133.450000] br0: port 1(lan2) entered blocking state
[  133.460000] br0: port 1(lan2) entered forwarding state
[  152.670000] br0: entered allmulticast mode
[  158.310000] br0: left allmulticast mode
TEST: vlan_filtering=0 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv4 to joined group       [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group      [XFAIL]
	reception succeeded, but should have failed
TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv6 to joined group       [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group      [XFAIL]
	reception succeeded, but should have failed
TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
[  162.080000] br0: left promiscuous mode
[  162.230000] br0: port 1(lan2) entered disabled state
[  162.480000] gswip 1e108000.switch lan2: left allmulticast mode
[  162.480000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
[  162.490000] gswip 1e108000.switch lan2: left promiscuous mode
[  162.500000] br0: port 1(lan2) entered disabled state
[  162.710000] gswip 1e108000.switch lan1: Link is Down
[  163.270000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  163.470000] br0: port 1(lan2) entered blocking state
[  163.470000] br0: port 1(lan2) entered disabled state
[  163.480000] gswip 1e108000.switch lan2: entered allmulticast mode
[  163.480000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  163.500000] gswip 1e108000.switch lan2: entered promiscuous mode
[  163.510000] br0: port 1(lan2) entered blocking state
[  163.510000] br0: port 1(lan2) entered forwarding state
[  163.610000] gswip 1e108000.switch lan2: Link is Down
[  163.610000] br0: port 1(lan2) entered disabled state
[  164.040000] br0: entered promiscuous mode
[  165.770000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  165.770000] br0: port 1(lan2) entered blocking state
[  165.780000] br0: port 1(lan2) entered forwarding state
[  166.400000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  185.600000] br0: entered allmulticast mode
[  191.200000] br0: left allmulticast mode
TEST: vlan_filtering=1 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv4 to joined group       [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group      [XFAIL]
	reception succeeded, but should have failed
TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv6 to joined group       [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group      [XFAIL]
	reception succeeded, but should have failed
TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
[  195.050000] br0: left promiscuous mode
[  195.220000] br0: port 1(lan2) entered disabled state
[  195.480000] gswip 1e108000.switch lan2: left allmulticast mode
[  195.480000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
[  195.490000] gswip 1e108000.switch lan2: left promiscuous mode
[  195.490000] br0: port 1(lan2) entered disabled state
[  195.700000] gswip 1e108000.switch lan1: Link is Down
[  195.920000] gswip 1e108000.switch lan2: Link is Down
[  196.260000] gswip 1e108000.switch lan2: entered promiscuous mode
[  196.790000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  197.240000] gswip 1e108000.switch lan2: left promiscuous mode
[  197.260000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  197.650000] gswip 1e108000.switch lan2: entered promiscuous mode
[  199.370000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  199.930000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  215.040000] lan2.100: entered promiscuous mode
[  220.640000] lan2.100: left promiscuous mode
[  223.610000] lan2.100: entered allmulticast mode
[  223.610000] gswip 1e108000.switch lan2: entered allmulticast mode
[  223.610000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  229.200000] lan2.100: left allmulticast mode
[  229.200000] gswip 1e108000.switch lan2: left allmulticast mode
[  229.200000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
TEST: VLAN upper: Unicast IPv4 to primary MAC address               [FAIL]
	reception failed
TEST: VLAN upper: Unicast IPv4 to macvlan MAC address               [FAIL]
	reception failed
TEST: VLAN upper: Unicast IPv4 to unknown MAC address               [FAIL]
	reception failed
TEST: VLAN upper: Unicast IPv4 to unknown MAC address, promisc      [FAIL]
	reception failed
TEST: VLAN upper: Unicast IPv4 to unknown MAC address, allmulti     [FAIL]
	reception failed
TEST: VLAN upper: Multicast IPv4 to joined group                    [FAIL]
	reception failed
TEST: VLAN upper: Multicast IPv4 to unknown group                   [ OK ]
TEST: VLAN upper: Multicast IPv4 to unknown group, promisc          [FAIL]
	reception failed
TEST: VLAN upper: Multicast IPv4 to unknown group, allmulti         [FAIL]
	reception failed
TEST: VLAN upper: Multicast IPv6 to joined group                    [FAIL]
	reception failed
TEST: VLAN upper: Multicast IPv6 to unknown group                   [ OK ]
TEST: VLAN upper: Multicast IPv6 to unknown group, promisc          [FAIL]
	reception failed
TEST: VLAN upper: Multicast IPv6 to unknown group, allmulti         [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over L2 transport, Sync                    [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over L2 transport, Follow-Up               [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over L2 transport, Peer Delay Request      [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over IPv4, Sync                            [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over IPv4, Follow-Up                       [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over IPv4, Peer Delay Request              [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over IPv6, Sync                            [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over IPv6, Follow-Up                       [FAIL]
	reception failed
TEST: VLAN upper: 1588v2 over IPv6, Peer Delay Request              [FAIL]
	reception failed
[  239.910000] gswip 1e108000.switch lan2: left promiscuous mode
[  240.020000] gswip 1e108000.switch lan2: Link is Down
[  240.400000] gswip 1e108000.switch lan1: Link is Down
[  240.860000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  241.000000] gswip 1e108000.switch lan2: entered promiscuous mode
[  241.510000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  241.960000] gswip 1e108000.switch lan2: left promiscuous mode
[  241.980000] gswip 1e108000.switch lan2: entered promiscuous mode
[  241.990000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  242.430000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  242.470000] br0: port 1(lan2) entered blocking state
[  242.470000] br0: port 1(lan2) entered disabled state
[  242.470000] gswip 1e108000.switch lan2: entered allmulticast mode
[  242.480000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  244.650000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  245.610000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  245.610000] br0: port 1(lan2) entered blocking state
[  245.620000] br0: port 1(lan2) entered forwarding state
[  256.480000] lan2.100: entered promiscuous mode
[  262.080000] lan2.100: left promiscuous mode
[  265.090000] lan2.100: entered allmulticast mode
[  270.690000] lan2.100: left allmulticast mode
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Sync   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Peer Delay Request   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Sync   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Peer Delay Request   [ OK ]
[  282.120000] gswip 1e108000.switch lan2: left allmulticast mode
[  282.120000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
[  282.130000] br0: port 1(lan2) entered disabled state
[  282.400000] gswip 1e108000.switch lan2: Link is Down
[  282.770000] gswip 1e108000.switch lan1: Link is Down
[  283.220000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  283.890000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  284.330000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  284.790000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  284.790000] br0: port 1(lan2) entered blocking state
[  284.800000] br0: port 1(lan2) entered disabled state
[  284.800000] gswip 1e108000.switch lan2: entered allmulticast mode
[  284.810000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  286.970000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  286.970000] br0: port 1(lan2) entered blocking state
[  286.980000] br0: port 1(lan2) entered forwarding state
[  288.090000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  298.640000] lan2.100: entered promiscuous mode
[  304.250000] lan2.100: left promiscuous mode
[  307.260000] lan2.100: entered allmulticast mode
[  312.880000] lan2.100: left allmulticast mode
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address   [FAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [FAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Sync   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Peer Delay Request   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Sync   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Peer Delay Request   [ OK ]
[  324.810000] gswip 1e108000.switch lan2: left allmulticast mode
[  324.810000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
[  324.820000] br0: port 1(lan2) entered disabled state
[  324.850000] gswip 1e108000.switch: bridge to leave does not exists
[  324.860000] gswip 1e108000.switch: port 2 failed to reset VLAN filtering to 0: -ENOENT
[  324.990000] gswip 1e108000.switch: bridge to leave does not exists
[  324.990000] gswip 1e108000.switch lan2: failed to kill vid 8100/100
[  325.110000] gswip 1e108000.switch lan2: Link is Down
[  325.510000] gswip 1e108000.switch lan1: Link is Down
[  326.070000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  326.440000] br0: port 1(lan2) entered blocking state
[  326.450000] br0: port 1(lan2) entered disabled state
[  326.450000] gswip 1e108000.switch lan2: entered allmulticast mode
[  326.460000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  326.550000] gswip 1e108000.switch lan2: configuring for phy/internal link mode
[  327.160000] br0: entered promiscuous mode
[  328.650000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  328.650000] br0: port 1(lan2) entered blocking state
[  328.660000] br0: port 1(lan2) entered forwarding state
[  329.200000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  340.530000] br0.100: entered promiscuous mode
[  346.160000] br0.100: left promiscuous mode
[  349.150000] br0.100: entered allmulticast mode
[  349.150000] br0: entered allmulticast mode
[  354.790000] br0.100: left allmulticast mode
[  354.790000] br0: left allmulticast mode
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
[  358.590000] br0: left promiscuous mode
[  358.810000] br0: port 1(lan2) entered disabled state
[  359.070000] gswip 1e108000.switch lan2: left allmulticast mode
[  359.080000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
[  359.080000] br0: port 1(lan2) entered disabled state
[  359.370000] gswip 1e108000.switch lan1: Link is Down
[  359.850000] gswip 1e108000.switch lan2: Link is Down
[  359.950000] gswip 1e108000.switch lan1: configuring for phy/internal link mode
[  360.330000] br0: port 1(lan2) entered blocking state
[  360.330000] br0: port 1(lan2) entered disabled state
[  360.330000] gswip 1e108000.switch lan2: entered allmulticast mode
[  360.340000] lantiq,xrx200-net 1e10b308.eth eth0: entered allmulticast mode
[  361.070000] br0: entered promiscuous mode
[  362.080000] gswip 1e108000.switch lan1: Link is Up - 1Gbps/Full - flow control rx/tx
[  362.970000] gswip 1e108000.switch lan2: Link is Up - 1Gbps/Full - flow control rx/tx
[  362.970000] br0: port 1(lan2) entered blocking state
[  362.980000] br0: port 1(lan2) entered forwarding state
[  373.550000] br0.100: entered promiscuous mode
[  379.140000] br0.100: left promiscuous mode
[  382.140000] br0.100: entered allmulticast mode
[  382.140000] br0: entered allmulticast mode
[  387.780000] br0.100: left allmulticast mode
[  387.780000] br0: left allmulticast mode
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group   [XFAIL]
	reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
[  391.710000] br0: left promiscuous mode
[  391.930000] br0: port 1(lan2) entered disabled state
[  392.200000] gswip 1e108000.switch lan2: left allmulticast mode
[  392.200000] lantiq,xrx200-net 1e10b308.eth eth0: left allmulticast mode
[  392.210000] br0: port 1(lan2) entered disabled state
[  392.480000] gswip 1e108000.switch lan1: Link is Down
[  392.840000] gswip 1e108000.switch lan2: Link is Down
root@OpenWrt:/selftests/drivers/net/dsa# 

--yf/pDU8Z4y6qtN9p--

