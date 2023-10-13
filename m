Return-Path: <netdev+bounces-40626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0807C8035
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 10:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF4D1C20A3D
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 08:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0FC107BF;
	Fri, 13 Oct 2023 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dgTstY0/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D616F107B8
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:27:29 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1560DBF
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 01:27:25 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB0ABFF811;
	Fri, 13 Oct 2023 08:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697185644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5EDRrh9oA4CC4u31z5PNvry1/nf5K919ZdBQ+ftM4k=;
	b=dgTstY0/JuXF3b6dE09+NveQLl2x5XT+7Kb+ymGHi8bhMNBKUJDFla93bDPgmBjvwEobQy
	rcMwlVVCZDq+qYLgwtAFPoHqqxP/Sr+gQ4h7sj6cL//PsKDC4Fr+QiFO2gd/WdpOWUN/md
	QwXtYcD4fblGiNaxoHs0GZ3TdxnMdPELw3iFzcOPouZ6PXme5cNduOCyLfiejDbl2IbNG5
	6vSf+K46iZ8/hJby86HPpF2rXqeq7Ok18iotAjkWz9o5xCf6jroYDMkN7Ek6R4J+HdIYSQ
	+z8arHkiRbS8cGYkSDW+S6IT3yX/wCDDqkHGizsT75d8yw2ZrmDNwwVb5SYP5w==
Date: Fri, 13 Oct 2023 10:27:18 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Russell King
 <linux@armlinux.org.uk>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-imx@nxp.com,
 netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: Ethernet issue on imx6
Message-ID: <20231013102718.6b3a2dfe@xps-13>
In-Reply-To: <20231012155857.6fd51380@hermes.local>
References: <20231012193410.3d1812cf@xps-13>
	<8e970415-4bc3-4c6f-8cd5-4bbd20d9261d@lunn.ch>
	<20231012155857.6fd51380@hermes.local>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Stephen & Andrew,

stephen@networkplumber.org wrote on Thu, 12 Oct 2023 15:58:57 -0700:

> On Thu, 12 Oct 2023 22:46:09 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> > > //192.168.1.1 is my host, so the below lines are from the board:
> > > # iperf3 -c 192.168.1.1 -u -b100M
> > > [  5]   0.00-10.05  sec   113 MBytes  94.6 Mbits/sec  0.044 ms  467/8=
2603 (0.57%)  receiver
> > > # iperf3 -c 192.168.1.1 -u -b90M
> > > [  5]   0.00-10.04  sec  90.5 MBytes  75.6 Mbits/sec  0.146 ms  12163=
/77688 (16%)  receiver
> > > # iperf3 -c 192.168.1.1 -u -b80M
> > > [  5]   0.00-10.05  sec  66.4 MBytes  55.5 Mbits/sec  0.162 ms  20937=
/69055 (30%)  receiver   =20
> >=20
> > Have you tried playing with =E2=80=90=E2=80=90pacing=E2=80=90timer ?
> >=20
> > Maybe iperf is producing a big bursts of packets and then silence for
> > a while. The burst is overflowing a buffer somewhere? Smooth the flow
> > and it might work better?

I've just tried and the results are kind of the opposite of what I
would expect. Here are the values so maybe you'll have a different
understanding:

=46rom --pacing-timer 1 to 100000 (should be microseconds IIUC), results
are the same. And then, increasing the period decreases the drop rate:

# iperf3 -c 192.168.1.1 -u -b1M --pacing-timer 1000
[  5]   0.00-10.04  sec   604 KBytes   493 Kbits/sec  0.062 ms  437/864 (51=
%)  receiver
# iperf3 -c 192.168.1.1 -u -b1M --pacing-timer 10000
[  5]   0.00-10.05  sec   581 KBytes   474 Kbits/sec  0.102 ms  452/863 (52=
%)  receiver
# iperf3 -c 192.168.1.1 -u -b1M --pacing-timer 100000
[  5]   0.00-10.05  sec   867 KBytes   707 Kbits/sec  0.094 ms  240/853 (28=
%)  receiver
# iperf3 -c 192.168.1.1 -u -b1M --pacing-timer 1000000
[  5]   0.00-10.05  sec  1.04 MBytes   866 Kbits/sec  0.080 ms  27/778 (3.5=
%)  receiver

> Please post the basic system info.
> Like kernel dmesg log.

Please find the logs below.

> All network statistics including ethtool.

PHY statistics remain empty:

# ethtool --phy-statistics eth0
PHY statistics:
     phy_receive_errors: 0
     phy_idle_errors: 0

Interrupts work as expected on the MAC side (I added traces in the IRQ
handler to see how it was behaving):

# cat /proc/interrupts | grep ethernet
 82:     344546          0          0          0  gpio-mxc   6 Level     21=
88000.ethernet
104:          1          0          0          0  gpio-mxc  28 Level     21=
88000.ethernet
337:          0          0          0          0     GIC-0 151 Level     21=
88000.ethernet

# ethtool -S eth0
NIC statistics:
     tx_dropped: 0
     tx_packets: 10118
     tx_broadcast: 0
     tx_multicast: 13
     tx_crc_errors: 0
     tx_undersize: 0
     tx_oversize: 0
     tx_fragment: 0
     tx_jabber: 0
     tx_collision: 0
     tx_64byte: 130
     tx_65to127byte: 61031
     tx_128to255byte: 19
     tx_256to511byte: 10
     tx_512to1023byte: 5
     tx_1024to2047byte: 14459
     tx_GTE2048byte: 0
     tx_octets: 26219280
     IEEE_tx_drop: 0
     IEEE_tx_frame_ok: 10118
     IEEE_tx_1col: 0
     IEEE_tx_mcol: 0
     IEEE_tx_def: 0
     IEEE_tx_lcol: 0
     IEEE_tx_excol: 0
     IEEE_tx_macerr: 0
     IEEE_tx_cserr: 0
     IEEE_tx_sqe: 0
     IEEE_tx_fdxfc: 0
     IEEE_tx_octets_ok: 26219280
     rx_packets: 35369
     rx_broadcast: 1
     rx_multicast: 5
     rx_crc_errors: 0
     rx_undersize: 0
     rx_oversize: 0
     rx_fragment: 0
     rx_jabber: 0
     rx_64byte: 10
     rx_65to127byte: 9083
     rx_128to255byte: 8
     rx_256to511byte: 8
     rx_512to1023byte: 0
     rx_1024to2047byte: 26260
     rx_GTE2048byte: 0
     rx_octets: 436459630
     IEEE_rx_drop: 0
     IEEE_rx_frame_ok: 35369
     IEEE_rx_crc: 0
     IEEE_rx_align: 0
     IEEE_rx_macerr: 0
     IEEE_rx_fdxfc: 0
     IEEE_rx_octets_ok: 436459630

> Any special qdisc or firewall configuration.

None.

> Likely a hardware or driver bug that is doing something wrong
> when a lot of packets are received.

Well, isn't it kind of the opposite? If we flood the interface it works
better than when we pace the traffic (that's what I see whenever I
reduce the throughput or when I enlarge the iperf timer).

I'm also doubtful about the fact that receiving full speed traffic makes
the uplink stable.

Thanks,
Miqu=C3=A8l

---

switch to partitions #0, OK
mmc1 is current device
reading boot.scr
444 bytes read in 10 ms (43 KiB/s)
## Executing script at 20000000
Booting from mmc ...
reading zImage
9160016 bytes read in 462 ms (18.9 MiB/s)
reading <board>.dtb
40052 bytes read in 22 ms (1.7 MiB/s)
boot device tree kernel ...
Kernel image @ 0x12000000 [ 0x000000 - 0x8bc550 ]
## Flattened Device Tree blob at 18000000
   Booting using the fdt blob at 0x18000000
   Using Device Tree in place at 18000000, end 1800cc73

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.5.0 (mraynal@xps-13) (arm-linux-gcc.br_real =
(Buildroot 2
020.08-14-ge5a2a90) 10.2.0, GNU ld (GNU Binutils) 2.34) #120 SMP Thu Oct 12=
 18:10:20 CE
ST 2023
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10=
c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] OF: fdt: Machine model: TQ TQMa6Q on MBa6x
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 160 MiB at 0x46000000
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000010000000-0x000000003fffffff]
[    0.000000]   HighMem  [mem 0x0000000040000000-0x000000004fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000010000000-0x000000004fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000010000000-0x000000004ffff=
fff]
[    0.000000] percpu: Embedded 13 pages/cpu s23124 r8192 d21932 u53248
[    0.000000] Kernel command line: root=3D/dev/mmcblk1p2 ro rootwait conso=
le=3Dttymxc1,115
200 cma=3D160M
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 260608
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 854196K/1048576K available (13312K kernel code, 1308=
K rwdata, 39
44K rodata, 1024K init, 401K bss, 30540K reserved, 163840K cma-reserved, 98=
304K highmem
)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 1=
0 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 errata 752271 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000001] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps eve=
ry 715827882
841ns
[    0.000018] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffff=
ffff, max_id
le_ns: 637086815595 ns
[    0.001530] Console: colour dummy device 80x30
[    0.001571] Calibrating delay loop (skipped), value calculated using tim=
er frequency
.. 6.00 BogoMIPS (lpj=3D30000)
[    0.001587] CPU: Testing write buffer coherency: ok
[    0.001625] CPU0: Spectre v2: using BPIALL workaround
[    0.001633] pid_max: default: 32768 minimum: 301
[    0.001764] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, =
linear)
[    0.001787] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 by=
tes, linear)
[    0.002589] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.003612] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb=
_adjust=3D1.
[    0.003775] Setting up static identity map for 0x10100000 - 0x10100078
[    0.003964] rcu: Hierarchical SRCU implementation.
[    0.003970] rcu:     Max phase no-delay instances is 1000.
[    0.005041] smp: Bringing up secondary CPUs ...
[    0.005965] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.005983] CPU1: Spectre v2: using BPIALL workaround
[    0.007009] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.007025] CPU2: Spectre v2: using BPIALL workaround
[    0.008023] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.008040] CPU3: Spectre v2: using BPIALL workaround
[    0.008149] smp: Brought up 1 node, 4 CPUs
[    0.008161] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.008171] CPU: All CPU(s) started in SVC mode.
[    0.008688] devtmpfs: initialized
[    0.017370] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant 9 rev 4
[    0.017636] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_
ns: 19112604462750000 ns
[    0.017660] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)
[    0.025946] pinctrl core: initialized pinctrl subsystem
[    0.027948] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.035191] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.036387] thermal_sys: Registered thermal governor 'step_wise'
[    0.036449] cpuidle: using governor menu
[    0.036568] CPU identified as i.MX6Q, silicon rev 1.5
[    0.042593] platform soc: Fixed dependency cycle(s) with /soc/aips-bus@0=
2000000/gpc@
020dc000
[    0.057409] platform 2400000.ipu: Fixed dependency cycle(s) with /soc/ai=
ps-bus@02000
000/ldb/lvds-channel@0/port@1/endpoint
[    0.057451] platform 2400000.ipu: Fixed dependency cycle(s) with /soc/hd=
mi@0120000/p
ort@1/endpoint
[    0.057476] platform 2400000.ipu: Fixed dependency cycle(s) with /soc/ai=
ps-bus@02000
000/ldb/lvds-channel@0/port@0/endpoint
[    0.057507] platform 2400000.ipu: Fixed dependency cycle(s) with /soc/hd=
mi@0120000/p
ort@0/endpoint
[    0.057530] platform 2400000.ipu: Fixed dependency cycle(s) with /soc/ai=
ps-bus@02000
000/iomuxc-gpr@020e0000/ipu1_csi0_mux/port@2/endpoint
[    0.058449] platform 2800000.ipu: Fixed dependency cycle(s) with /soc/ai=
ps-bus@02000
000/ldb/lvds-channel@0/port@3/endpoint
[    0.058510] platform 2800000.ipu: Fixed dependency cycle(s) with /soc/hd=
mi@0120000/p
ort@3/endpoint
[    0.058558] platform 2800000.ipu: Fixed dependency cycle(s) with /soc/ai=
ps-bus@02000
000/ldb/lvds-channel@0/port@2/endpoint
[    0.058611] platform 2800000.ipu: Fixed dependency cycle(s) with /soc/hd=
mi@0120000/p
ort@2/endpoint
[    0.058633] platform 2800000.ipu: Fixed dependency cycle(s) with /soc/ai=
ps-bus@02000
000/iomuxc-gpr@020e0000/ipu2_csi1_mux/port@2/endpoint
[    0.061550] No ATAGs?
[    0.061690] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchp=
oint registe
rs.
[    0.061702] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.063055] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.067250] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized=20
if possible.
[    0.068787] gpio gpiochip0: Static allocation of GPIO base is deprecated=
, use dynami
c allocation.
[    0.070727] gpio gpiochip1: Static allocation of GPIO base is deprecated=
, use dynami
c allocation.
[    0.072435] gpio gpiochip2: Static allocation of GPIO base is deprecated=
, use dynami
c allocation.
[    0.074182] gpio gpiochip3: Static allocation of GPIO base is deprecated=
, use dynami
c allocation.
[    0.075910] gpio gpiochip4: Static allocation of GPIO base is deprecated=
, use dynami
c allocation.
[    0.077677] gpio gpiochip5: Static allocation of GPIO base is deprecated=
, use dynami
c allocation.
[    0.079441] gpio gpiochip6: Static allocation of GPIO base is deprecated=
, use dynami
c allocation.
[    0.083631] SCSI subsystem initialized
[    0.084119] usbcore: registered new interface driver usbfs
[    0.084160] usbcore: registered new interface driver hub
[    0.084205] usbcore: registered new device driver usb
[    0.086993] pca953x 0-0020: supply vcc not found, using dummy regulator
[    0.087157] pca953x 0-0020: using no AI
[    0.100030] pca953x 0-0020: interrupt support not compiled in
[    0.120764] pca953x 0-0021: supply vcc not found, using dummy regulator
[    0.120904] pca953x 0-0021: using no AI
[    0.160606] pca953x 0-0022: supply vcc not found, using dummy regulator
[    0.160732] pca953x 0-0022: using no AI
[    0.200704] i2c i2c-0: IMX I2C adapter registered
[    0.201717] i2c i2c-1: IMX I2C adapter registered
[    0.201937] mc: Linux media interface: v0.10
[    0.202003] videodev: Linux video capture interface: v2.00
[    0.202117] pps_core: LinuxPPS API ver. 1 registered
[    0.202124] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <gi
ometti@linux.it>
[    0.202151] PTP clock support registered
[    0.202996] Advanced Linux Sound Architecture Driver Initialized.
[    0.203875] Bluetooth: Core ver 2.22
[    0.203918] NET: Registered PF_BLUETOOTH protocol family
[    0.203924] Bluetooth: HCI device and connection manager initialized
[    0.203937] Bluetooth: HCI socket layer initialized
[    0.203946] Bluetooth: L2CAP socket layer initialized
[    0.203965] Bluetooth: SCO socket layer initialized
[    0.204470] vgaarb: loaded
[    0.204864] clocksource: Switched to clocksource mxc_timer1
[    0.205119] VFS: Disk quotas dquot_6.6.0
[    0.205178] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    0.215795] NET: Registered PF_INET protocol family
[    0.216223] IP idents hash table entries: 16384 (order: 5, 131072 bytes,=
 linear)
[    0.218261] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, =
4096 bytes,=20
linear)
[    0.218290] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.218304] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes, linear)
[    0.218393] TCP bind hash table entries: 8192 (order: 5, 131072 bytes, l=
inear)
[    0.218680] TCP: Hash tables configured (established 8192 bind 8192)
[    0.218891] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.218944] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, lin=
ear)
[    0.219141] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.219687] RPC: Registered named UNIX socket transport module.
[    0.219697] RPC: Registered udp transport module.
[    0.219703] RPC: Registered tcp transport module.
[    0.219708] RPC: Registered tcp-with-tls transport module.
[    0.219713] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.221148] PCI: CLS 0 bytes, default 64
[    0.221977] armv7-pmu soc:pmu: hw perfevents: no interrupt-affinity prop=
erty, guessi
ng.
[    0.222197] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 co=
unters avail
able
[    0.223895] Initialise system trusted keyrings
[    0.224175] workingset: timestamp_bits=3D30 max_order=3D18 bucket_order=
=3D0
[    0.224818] NFS: Registering the id_resolver key type
[    0.224899] Key type id_resolver registered
[    0.224907] Key type id_legacy registered
[    0.224937] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.224946] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regist=
ering...
[    0.224982] jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
[    0.225263] fuse: init (API version 7.38)
[    0.366002] Key type asymmetric registered
[    0.366012] Asymmetric key parser 'x509' registered
[    0.366111] bounce: pool size: 64 pages
[    0.366141] io scheduler mq-deadline registered
[    0.366149] io scheduler kyber registered
[    0.366177] io scheduler bfq registered
[    0.374797] mxs-dma 110000.dma-apbh: initialized
[    0.380411] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq =3D 267, base=
_baud =3D 500000
0) is a IMX
[    0.380466] pfuze100-regulator 0-0008: Full layer: 2, Metal layer: 1
[    0.380517] printk: console [ttymxc1] enabled
[    0.420856] pfuze100-regulator 0-0008: FAB: 0, FIN: 0
[    0.426703] 21f0000.serial: ttymxc3 at MMIO 0x21f0000 (irq =3D 268, base=
_baud =3D 500000
0) is a IMX
[    0.429991] pfuze100-regulator 0-0008: pfuze100 found.
[    1.415972] dwhdmi-imx 120000.hdmi: Detected HDMI TX controller v1.30a w=
ith HDCP (DW
C HDMI 3D TX PHY)
[    1.438220] etnaviv etnaviv: bound 130000.gpu (ops 0xc0eaa4c0)
[    1.444322] etnaviv etnaviv: bound 134000.gpu (ops 0xc0eaa4c0)
[    1.450446] etnaviv etnaviv: bound 2204000.gpu (ops 0xc0eaa4c0)
[    1.456412] etnaviv-gpu 130000.gpu: model: GC2000, revision: 5108
[    1.462736] etnaviv-gpu 134000.gpu: model: GC320, revision: 5007
[    1.468843] etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215
[    1.474978] etnaviv-gpu 2204000.gpu: Ignoring GPU with VG and FE2.0
[    1.481750] [drm] Initialized etnaviv 1.3.0 20151214 for etnaviv on mino=
r 0
[    1.490567] imx-ipuv3 2400000.ipu: IPUv3H probed
[    1.497417] imx-drm display-subsystem: bound imx-ipuv3-crtc.2 (ops 0xc0e=
990bc)
[    1.504784] imx-drm display-subsystem: bound imx-ipuv3-crtc.3 (ops 0xc0e=
990bc)
[    1.512221] imx-drm display-subsystem: bound imx-ipuv3-crtc.6 (ops 0xc0e=
990bc)
[    1.519601] imx-drm display-subsystem: bound imx-ipuv3-crtc.7 (ops 0xc0e=
990bc)
[    1.526929] imx-drm display-subsystem: bound 120000.hdmi (ops 0xc0e99bb0)
[    1.533801] imx-drm display-subsystem: bound 2000000.aips-bus:ldb (ops 0=
xc0e9985c)
[    1.542009] [drm] Initialized imx-drm 1.0.0 20120507 for display-subsyst=
em on minor=20
1
[    1.617102] Console: switching to colour frame buffer device 128x48
[    1.639863] imx-drm display-subsystem: [drm] fb0: imx-drmdrmfb frame buf=
fer device
[    1.647569] imx-ipuv3 2800000.ipu: IPUv3H probed
[    1.664218] brd: module loaded
[    1.675094] loop: module loaded
[    1.678559] at24 0-0050: supply vcc not found, using dummy regulator
[    1.686264] at24 0-0050: 8192 byte 24c64 EEPROM, writable, 32 bytes/write
[    1.693254] at24 0-005e: supply vcc not found, using dummy regulator
[    1.700649] at24 0-005e: 6 byte 24mac402 EEPROM, read-only
[    1.707334] ahci-imx 2200000.sata: fsl,transmit-level-mV not specified, =
using 000000
24
[    1.715309] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not specified,=
 using 00000
480
[    1.723325] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not specifie=
d, using 000
02000
[    1.731527] ahci-imx 2200000.sata: fsl,receive-eq-mdB not specified, usi=
ng 05000000
[    1.739323] ahci-imx 2200000.sata: supply ahci not found, using dummy re=
gulator
[    1.746879] ahci-imx 2200000.sata: supply phy not found, using dummy reg=
ulator
[    1.754171] ahci-imx 2200000.sata: supply target not found, using dummy =
regulator
[    1.765103] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disab=
led
[    1.772093] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports 3 Gbp=
s 0x1 impl p
latform mode
[    1.780930] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo only =
pmp pio slum
 part ccc apst=20
[    1.791631] scsi host0: ahci-imx
[    1.795182] ata1: SATA max UDMA/133 mmio [mem 0x02200000-0x02203fff] por=
t 0x100 irq=20
281
[    1.807887] CAN device driver interface
[    1.815291] pps pps0: new PPS source ptp0
[    1.824500] fec 2188000.ethernet eth0: registered PHC device 0
[    1.830997] usbcore: registered new device driver r8152-cfgselector
[    1.837331] usbcore: registered new interface driver r8152
[    1.842875] usbcore: registered new interface driver lan78xx
[    1.848605] usbcore: registered new interface driver asix
[    1.854042] usbcore: registered new interface driver ax88179_178a
[    1.860192] usbcore: registered new interface driver cdc_ether
[    1.866080] usbcore: registered new interface driver smsc95xx
[    1.871862] usbcore: registered new interface driver net1080
[    1.877579] usbcore: registered new interface driver cdc_subset
[    1.883536] usbcore: registered new interface driver zaurus
[    1.889163] usbcore: registered new interface driver MOSCHIP usb-etherne=
t driver
[    1.896643] usbcore: registered new interface driver cdc_ncm
[    1.902339] usbcore: registered new interface driver r8153_ecm
[    1.908265] usbcore: registered new interface driver usb-storage
[    1.915845] imx_usb 2184000.usb: No over current polarity defined
[    1.925481] ci_hdrc ci_hdrc.0: EHCI Host Controller
[    1.930395] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus numb=
er 1
[    1.964891] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
[    1.970466] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice
=3D 6.05
[    1.978770] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.986022] usb usb1: Product: EHCI Host Controller
[    1.990909] usb usb1: Manufacturer: Linux 6.5.0 ehci_hcd
[    1.996243] usb usb1: SerialNumber: ci_hdrc.0
[    2.001210] hub 1-0:1.0: USB hub found
[    2.005040] hub 1-0:1.0: 1 port detected
[    2.013077] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    2.018008] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus numb=
er 2
[    2.054882] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    2.060434] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice
=3D 6.05
[    2.068736] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.075993] usb usb2: Product: EHCI Host Controller
[    2.080880] usb usb2: Manufacturer: Linux 6.5.0 ehci_hcd
[    2.086215] usb usb2: SerialNumber: ci_hdrc.1
[    2.091157] hub 2-0:1.0: USB hub found
[    2.094973] hub 2-0:1.0: 1 port detected
[    2.100576] SPI driver ads7846 has no spi_device_id for ti,tsc2046
[    2.106788] SPI driver ads7846 has no spi_device_id for ti,ads7843
[    2.112974] SPI driver ads7846 has no spi_device_id for ti,ads7845
[    2.119173] SPI driver ads7846 has no spi_device_id for ti,ads7873
[    2.126405] ata1: SATA link down (SStatus 0 SControl 300)
[    2.128977] rtc-ds1307 0-0068: SET TIME!
[    2.131859] ahci-imx 2200000.sata: no device found, disabling link.
[    2.138861] rtc-ds1307 0-0068: registered as rtc0
[    2.142031] ahci-imx 2200000.sata: pass ahci_imx..hotplug=3D1 to enable =
hotplug
[    2.148304] rtc-ds1307 0-0068: setting system clock to 2000-01-01T00:00:=
16 UTC (9466
84816)
[    2.164313] snvs_rtc 20cc000.snvs:snvs-rtc-lp: registered as rtc1
[    2.170598] i2c_dev: i2c /dev entries driver
[    2.179371] Bluetooth: HCI UART driver ver 2.3
[    2.183827] Bluetooth: HCI UART protocol H4 registered
[    2.189030] Bluetooth: HCI UART protocol LL registered
[    2.195090] sdhci: Secure Digital Host Controller Interface driver
[    2.201278] sdhci: Copyright(c) Pierre Ossman
[    2.205665] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.212740] sdhci-esdhc-imx 2194000.usdhc: Got CD GPIO
[    2.213147] caam 2100000.caam: Entropy delay =3D 3200
[    2.217980] sdhci-esdhc-imx 2194000.usdhc: Got WP GPIO
[    2.235314] caam 2100000.caam: Instantiated RNG4 SH0
[    2.247792] caam 2100000.caam: Instantiated RNG4 SH1
[    2.252993] caam 2100000.caam: device ID =3D 0x0a16010000000000 (Era 4)
[    2.254409] mmc0: SDHCI controller on 2198000.usdhc [2198000.usdhc] usin=
g ADMA
[    2.259488] caam 2100000.caam: job rings =3D 2, qi =3D 0
[    2.274830] caam algorithms registered in /proc/crypto
[    2.280160] caam 2100000.caam: registering rng-caam
[    2.284350] mmc1: SDHCI controller on 2194000.usdhc [2194000.usdhc] usin=
g ADMA
[    2.285314] caam 2100000.caam: rng crypto API alg registered prng-caam
[    2.297630] random: crng init done
[    2.303285] usbcore: registered new interface driver usbhid
[    2.308911] usbhid: USB HID core driver
[    2.313588] imx-ipuv3-csi imx-ipuv3-csi.0: Registered ipu1_csi0 capture =
as /dev/vide
o0
[    2.320064] mmc0: new DDR MMC card at address 0001
[    2.321564] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    2.326456] imx-ipuv3 2400000.ipu: Registered ipu1_ic_prpenc capture as =
/dev/video1
[    2.333527] mmcblk0: mmc0:0001 Q2J54A 3.64 GiB
[    2.340788] mmc1: new high speed SDHC card at address 1234
[    2.344970] imx-ipuv3 2400000.ipu: Registered ipu1_ic_prpvf capture as /=
dev/video2
[    2.345512] imx-ipuv3-csi imx-ipuv3-csi.1: Registered ipu1_csi1 capture =
as /dev/vide
o3
[    2.351359] mmcblk1: mmc1:1234 SA32G 28.8 GiB
[    2.358940] imx-ipuv3-csi imx-ipuv3-csi.4: Registered ipu2_csi0 capture =
as /dev/vide
o4
[    2.359085] mmcblk0boot0: mmc0:0001 Q2J54A 2.00 MiB
[    2.361287] mmcblk0boot1: mmc0:0001 Q2J54A 2.00 MiB
[    2.363107] mmcblk0rpmb: mmc0:0001 Q2J54A 512 KiB, chardev (243:0)
[    2.394649]  mmcblk1: p1 p2 p3
[    2.394924] usb 2-1: new high-speed USB device number 2 using ci_hdrc
[    2.394948] imx-ipuv3 2800000.ipu: Registered ipu2_ic_prpenc capture as =
/dev/video5
[    2.397988] imx-ipuv3 2800000.ipu: Registered ipu2_ic_prpvf capture as /=
dev/video6
[    2.419931] imx-ipuv3-csi imx-ipuv3-csi.5: Registered ipu2_csi1 capture =
as /dev/vide
o7
[    2.436511] NET: Registered PF_INET6 protocol family
[    2.442621] Segment Routing with IPv6
[    2.446385] In-situ OAM (IOAM) with IPv6
[    2.450396] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.457018] NET: Registered PF_PACKET protocol family
[    2.462109] can: controller area network core
[    2.466561] NET: Registered PF_CAN protocol family
[    2.471387] can: raw protocol
[    2.474365] can: broadcast manager protocol
[    2.478607] can: netlink gateway - max_hops=3D1
[    2.483072] Key type dns_resolver registered
[    2.489383] Registering SWP/SWPB emulation handler
[    2.504238] Loading compiled-in X.509 certificates
[    2.539840] video-mux 20e0000.iomuxc-gpr:ipu1_csi0_mux: Consider updatin=
g driver vid
eo-mux to match on endpoints
[    2.550967] video-mux 20e0000.iomuxc-gpr:ipu2_csi1_mux: Consider updatin=
g driver vid
eo-mux to match on endpoints
[    2.555909] usb 1-1: New USB device found, idVendor=3D0bda, idProduct=3D=
8179, bcdDevice=3D
 0.00
[    2.563328] imx-media: Registered ipu_ic_pp csc/scaler as /dev/video8
[    2.569363] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    2.576973] imx_thermal 2000000.aips-bus:tempmon: Industrial CPU tempera=
ture grade -
 max:105C critical:100C passive:95C
[    2.582980] usb 1-1: Product: 802.11n NIC
[    2.597803] usb 1-1: Manufacturer: Realtek
[    2.601909] usb 1-1: SerialNumber: 00E04C0001
[    2.610341] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    2.621866] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    2.627617] clk: Disabling unused clocks
[    2.631928] platform regulatory.0: Direct firmware load for regulatory.d=
b failed wit
h error -2
[    2.634899] ALSA device list:
[    2.640606] cfg80211: failed to load regulatory.db
[    2.643524]   No soundcards found.
[    2.648408] usb 2-1: New USB device found, idVendor=3D0424, idProduct=3D=
2517, bcdDevice=3D
 0.02
[    2.660001] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    2.667658] hub 2-1:1.0: USB hub found
[    2.671598] hub 2-1:1.0: 7 ports detected
[    2.700941] EXT4-fs (mmcblk1p2): INFO: recovery required on readonly fil=
esystem
[    2.708329] EXT4-fs (mmcblk1p2): write access will be enabled during rec=
overy
[    2.994978] usb 2-1.1: new high-speed USB device number 3 using ci_hdrc
[    3.145639] usb 2-1.1: New USB device found, idVendor=3D0424, idProduct=
=3D9e00, bcdDevic
e=3D 3.00
[    3.154030] usb 2-1.1: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[    3.164547] smsc95xx v2.0.0
[    3.289135] SMSC LAN8710/LAN8720 usb-002:003:01: attached PHY driver (mi=
i_bus:phy_ad
dr=3Dusb-002:003:01, irq=3D294)
[    3.300938] smsc95xx 2-1.1:1.0 eth1: register 'smsc95xx' at usb-ci_hdrc.=
1-1.1, smsc9
5xx USB 2.0 Ethernet, f2:f7:83:3c:d3:e8
[    3.766601] EXT4-fs (mmcblk1p2): recovery complete
[    4.017039] EXT4-fs (mmcblk1p2): mounted filesystem 1c93b4dc-44a6-4b43-9=
3b0-ce3b0bbd
0391 ro with ordered data mode. Quota mode: none.
[    4.029221] VFS: Mounted root (ext4 filesystem) readonly on device 179:1=
0.
[    4.037240] devtmpfs: mounted
[    4.042698] Freeing unused kernel image (initmem) memory: 1024K
[    4.049122] Run /sbin/init as init process
[    4.330114] EXT4-fs (mmcblk1p2): re-mounted 1c93b4dc-44a6-4b43-93b0-ce3b=
0bbd0391 r/w
. Quota mode: none.
Starting psplash: OK
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev:=20
[    4.650852] udevd[134]: starting version 3.2.9
[    4.692906] udevd[135]: starting eudev-3.2.9
done
Starting watchdog...
Initializing random number generator: OK
Saving random seed: OK
Starting usbguard daemon: OK
Starting rngd: OK
Starting system message bus: done
Starting network:
[    6.261676] Micrel KSZ9031 Gigabit PHY 2188000.ethernet-1:03: attached P=
HY driver (mii_bus:phy_addr=3D2188000.ethernet-1:03, irq=3D56)
OK
Starting chrony: OK
Starting php-fpm  done
Starting nginx...
Starting sshd: OK
Touchscreen Firmware
Tool version:   v0.29_20170705
APILIB version: v1.0.62.0705
Try to start Stephanie 5 GUI
login:
[    8.500637] fec 2188000.ethernet eth0: Link is Up - 100Mbps/Full - flow =
control rx/tx
[    8.533754] fec 2188000.ethernet eth0: Link is Down
[   11.147566] fec 2188000.ethernet eth0: Link is Up - 100Mbps/Full - flow =
control rx/t
x
[   12.646102] platform 2008000.ecspi: deferred probe pending
root
Password:=20
#=20
# ip link set dev eth0 up
# ip addr add 192.168.1.2/24 dev eth0
ip: RTNETLINK answers: File exists
# iperf3 -c 192.168.1.1

