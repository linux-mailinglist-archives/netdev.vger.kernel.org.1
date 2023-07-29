Return-Path: <netdev+bounces-22574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 112357680C8
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 19:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB361C20AA8
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254C8171D6;
	Sat, 29 Jul 2023 17:39:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A49D15BD
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 17:39:51 +0000 (UTC)
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ACF35A5
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 10:39:48 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w1.tutanota.de (Postfix) with ESMTP id 65E92FBF8FC;
	Sat, 29 Jul 2023 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1690652386;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=o3YmWCV4Bm/uHVP1rli1ZMDtt4dpfdgbkOv6zVUtjII=;
	b=j+34sXLFNIn/JMoaV7UAdSxqDtYauthdelG6nogdgQIAA9WRWnPIONwPeF38qdEF
	+Qye6n60w2499MCSwKUAzvcjUi/rH639nHE+Yo7RhMgoOOPMpbpiJima1xpj8yePYox
	8pd27G9DkKGKWTrJzhoIDcgO6VbGR8W0zaP97sF/ND+X3PqiFdVtZUQqveBdu8kDSDE
	qRo5Y4KSyMmt9yO2ElAyk6XVivpjEDBpK9+j1VPcQLxUSiLP6yNlKBtQmyQMXuwSpWg
	P3tQL7dmieUpvisuzyj0h7uWoPJLB/fvBTpzc4GzqniJyqq1w4Ssy+Qmro40YYVg3zz
	E1Y6LrpipQ==
Date: Sat, 29 Jul 2023 19:39:46 +0200 (CEST)
From: kkiot@tuta.io
To: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc: "Neftin, Sasha" <sasha.neftin@intel.com>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
	"Avivi, Amir" <amir.avivi@intel.com>,
	"Soesan, Ron" <ron.soesan@intel.com>,
	Netdev <netdev@vger.kernel.org>,
	Intel Wired Lan <intel-wired-lan@lists.osuosl.org>
Message-ID: <NaXj1Gm--3-9@tuta.io>
In-Reply-To: <SJ1PR11MB61809DFD99185423133BC9F8B807A@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <NaDlWbh--3-9@tuta.io> <c1f53618-359b-3500-cde5-651fd53b9d99@intel.com> <SJ1PR11MB61809DFD99185423133BC9F8B807A@SJ1PR11MB6180.namprd11.prod.outlook.com>
Subject: RE: [Intel-wired-lan] PROBLEM: igc driver - Ethernet NIC speed
 not
 changing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

29 juil. 2023, 08:02 de muhammad.husaini.zulkifli@intel.com:

> Hello,
>
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Neftin, Sasha
>> Sent: Saturday, 29 July, 2023 3:51 PM
>> To: kkiot@tuta.io; Brandeburg, Jesse <jesse.brandeburg@intel.com>;
>> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Ruinskiy, Dima
>> <dima.ruinskiy@intel.com>; Avivi, Amir <amir.avivi@intel.com>; Soesan, R=
on
>> <ron.soesan@intel.com>
>> Cc: Netdev <netdev@vger.kernel.org>; Intel Wired Lan <intel-wired-
>> lan@lists.osuosl.org>
>> Subject: Re: [Intel-wired-lan] PROBLEM: igc driver - Ethernet NIC speed =
not
>> changing
>>
>> On 7/25/2023 23:38, kkiot@tuta.io wrote:
>> > [1.] One line summary of the problem: igc driver - Ethernet NIC speed
>> > not changing [2.] Full description of the problem/report:
>> > Trying to change my I225-V's connection speed to 1000 Mbps down from
>> > 2500 Mbps=C2=A0as a workaround=C2=A0to disconnection issues, but chang=
es won't
>> > apply, regardless of using NetworkManager or ethtool.
>> >
>> > NetworkManager displays the changed values, but they don't seem to
>> > actually apply.
>> >
>> > Using ethtool to change the speed to 1000 Mbps (`ethtool -s enp6s0
>> > speed
>> > 1000`) also fails.
>> > The interface gets brought down then up with the same 2500 Mbps speed.
>>
>> I would suspect "link speed" is a consequent problem here. Please, check
>> your setup. Why does disconnection happen again and again? Any problems
>> with the PCIe link? (caused by reset adapter) I recommend you contact th=
e
>> platform's vendor support.
>>
This is a known problem with some earlier versions of I225-V and it happens=
 outside of Linux and the igc driver. It has been solved by newer revisions=
 so I think we should not stress over that. The best I can do is get a repl=
acement.

>
> IMHO, we shall use the advertise command instead of speed command
> since we are using legacy advertise setting.
> Could you try with below command and see if the link activity happen
> accordingly?
>
> Ex:
>
> ethtool -s <interface> advertise <value>
>
> <value> -  : 2   (10Mbps)
>  : 8   (100Mbps)
>  : 32 (1000Mbps)
>
Hi,
I ran the command `ethtool -s enp6s0 advertise 0x020` which corresponds to =
"1000baseT Full", and it indeed works just fine. Interface quickly adopts t=
he 1 Gbps speed. This seems to be a better command to use than "ethtool -s =
speed". Thanks!


>> > [3.] Keywords (i.e., modules, networking, kernel): driver, networking,
>> > igc, intel [4.] Kernel information [4.1.] Kernel version (from
>> > /proc/version):=C2=A0Linux version 6.4.6-arch1-1
>> > (linux@archlinux) (gcc (GCC) 13.1.1 20230714, GNU ld (GNU Binutils)
>> > 2.40.0) #1 SMP PREEMPT_DYNAMIC Mon, 24 Jul 2023 20:19:38 +0000 [4.2.]
>> > Kernel .config file: Cannot obtain [5.] Most recent kernel version
>> > which did not have the bug: 6.2.9 or more recent?
>> > [6.] Output of Oops.. message (if applicable) with symbolic
>> > information resolved (see Documentation/admin-guide/bug-hunting.rst)
>> > N/A [7.] A small shell script or example program which triggers the
>> > problem (if possible) # ethtool -s [INTERFACE] speed 1000 [8.]
>> > Environment [8.1.] Software (add the output of the ver_linux script
>> > here) Cannot obtain [8.2.] Processor information (from /proc/cpuinfo):
>> > processor : 0
>> > vendor_id : AuthenticAMD
>> > cpu family : 23
>> > model : 113
>> > model name : AMD Ryzen 5 3600 6-Core Processor stepping : 0 microcode
>> > : 0x8701030 cpu MHz : 2473.153 cache size : 512 KB physical id : 0
>> > siblings : 12 core id : 0 cpu cores : 6 apicid : 0 initial apicid : 0
>> > fpu : yes fpu_exception : yes cpuid level : 16 wp : yes flags : fpu
>> > vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36
>> > clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp
>> > lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf
>> > rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1
>> > sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
>> > cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
>> > osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
>> > perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp
>> > vmmcall fsgsbase bmi1
>> > avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni
>> > xsaveopt xsavec xgetbv1 cqm_llc cqm_occup_llc cqm_mbm_total
>> > cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv
>> > svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists
>> > pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl rdpid
>> > overflow_recov succor smca sev sev_es bugs : sysret_ss_attrs
>> > spectre_v1 spectre_v2 spec_store_bypass retbleed smt_rsb bogomips :
>> > 7188.50 TLB size : 3072 4K pages clflush size : 64 cache_alignment :
>> > 64 address sizes : 43 bits physical, 48 bits virtual power management:
>> > ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
>> >
>> > (repeats 12x: 12 threads processor)
>> > [8.3.] Module information (from /proc/modules):
>> > igc 188416 0 - Live 0x0000000000000000 [8.4.] Loaded driver and
>> > hardware information (/proc/ioports, /proc/iomem) /proc/ioports
>> > 0000-0000 : PCI Bus 0000:00
>> >  =C2=A0 0000-0000 : dma1
>> >  =C2=A0 0000-0000 : pic1
>> >  =C2=A0 0000-0000 : timer0
>> >  =C2=A0 0000-0000 : timer1
>> >  =C2=A0 0000-0000 : keyboard
>> >  =C2=A0 0000-0000 : PNP0800:00
>> >  =C2=A0 0000-0000 : keyboard
>> >  =C2=A0 0000-0000 : rtc0
>> >  =C2=A0 0000-0000 : dma page reg
>> >  =C2=A0 0000-0000 : pic2
>> >  =C2=A0 0000-0000 : ACPI PM2_CNT_BLK
>> >  =C2=A0 0000-0000 : dma2
>> >  =C2=A0 0000-0000 : fpu
>> >  =C2=A0 0000-0000 : pnp 00:03
>> >  =C2=A0 0000-0000 : pnp 00:03
>> > 0000-0000 : PCI Bus 0000:00
>> > 0000-0000 : PCI Bus 0000:00
>> >  =C2=A0 0000-0000 : serial
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0=C2=A0=C2=A0 0000-0000 : ACPI PM1a_EVT_BLK
>> >  =C2=A0=C2=A0=C2=A0 0000-0000 : ACPI PM1a_CNT_BLK
>> >  =C2=A0=C2=A0=C2=A0 0000-0000 : ACPI PM_TMR
>> >  =C2=A0=C2=A0=C2=A0 0000-0000 : ACPI GPE0_BLK
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0=C2=A0=C2=A0 0000-0000 : piix4_smbus
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0=C2=A0=C2=A0 0000-0000 : piix4_smbus
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0 0000-0000 : pnp 00:04
>> >  =C2=A0 0000-0000 : pnp 00:04
>> > 0000-0000 : PCI conf1
>> > 0000-0000 : PCI Bus 0000:00
>> >  =C2=A0 0000-0000 : PCI Bus 0000:07
>> >  =C2=A0=C2=A0=C2=A0 0000-0000 : PCI Bus 0000:08
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000-0000 : PCI Bus 0000:09
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000-0000 : 0000:09:00.0
>> >
>> > /proc/iomem
>> > 00000000-00000000 : Reserved
>> > 00000000-00000000 : System RAM
>> > 00000000-00000000 : Reserved
>> >  =C2=A0 00000000-00000000 : PCI Bus 0000:00
>> >  =C2=A0 00000000-00000000 : System ROM
>> > 00000000-00000000 : System RAM
>> > 00000000-00000000 : Reserved
>> > 00000000-00000000 : System RAM
>> > 00000000-00000000 : ACPI Non-volatile Storage
>> > 00000000-00000000 : System RAM
>> > 00000000-00000000 : Reserved
>> > 00000000-00000000 : System RAM
>> > 00000000-00000000 : System RAM
>> > 00000000-00000000 : System RAM
>> > 00000000-00000000 : System RAM
>> > 00000000-00000000 : System RAM
>> > 00000000-00000000 : Reserved
>> > 00000000-00000000 : System RAM
>> > 00000000-00000000 : Reserved
>> > 00000000-00000000 : System RAM
>> > 00000000-00000000 : Reserved
>> > 00000000-00000000 : System RAM
>> > 00000000-00000000 : Reserved
>> >  =C2=A0 00000000-00000000 : MSFT0101:00
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : MSFT0101:00
>> >  =C2=A0 00000000-00000000 : MSFT0101:00
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : MSFT0101:00
>> > 00000000-00000000 : ACPI Tables
>> > 00000000-00000000 : ACPI Non-volatile Storage
>> > 00000000-00000000 : Reserved
>> > 00000000-00000000 : System RAM
>> > 00000000-00000000 : Reserved
>> > 00000000-00000000 : PCI Bus 0000:00
>> >  =C2=A0 00000000-00000000 : PCI MMCONFIG 0000 [bus 00-7f]
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : pnp 00:00
>> >  =C2=A0 00000000-00000000 : PCI Bus 0000:0b
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:0b:00.3
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : xhci-hcd
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:0b:00.1
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : ccp
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:0b:00.4
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : ICH HD audio
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:0b:00.1
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : ccp
>> >  =C2=A0 00000000-00000000 : PCI Bus 0000:07
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : PCI Bus 0000:08
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : PCI Bus 0000:09
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:0=
9:00.0
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:0=
9:00.0
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:0=
9:00.1
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000=
000 : ICH HD audio
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:07:00.0
>> >  =C2=A0 00000000-00000000 : PCI Bus 0000:02
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : PCI Bus 0000:03
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : PCI Bus 0000:06
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:0=
6:00.0
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000=
000 : igc
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:0=
6:00.0
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000=
000 : igc
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:02:00.1
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:02:00.1
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : ahci
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:02:00.0
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : xhci-hcd
>> >  =C2=A0 00000000-00000000 : PCI Bus 0000:01
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:01:00.0
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : nvme
>> > 00000000-00000000 : pnp 00:01
>> >  =C2=A0 00000000-00000000 : MSFT0101:00
>> > 00000000-00000000 : amd_iommu
>> > 00000000-00000000 : Reserved
>> > 00000000-00000000 : IOAPIC 0
>> > 00000000-00000000 : IOAPIC 1
>> > 00000000-00000000 : Reserved
>> >  =C2=A0 00000000-00000000 : pnp 00:04
>> > 00000000-00000000 : Reserved
>> >  =C2=A0 00000000-00000000 : AMDIF030:00
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : AMDIF030:00 AMDIF030:00
>> > 00000000-00000000 : Reserved
>> >  =C2=A0 00000000-00000000 : HPET 0
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : PNP0103:00
>> > 00000000-00000000 : Reserved
>> > 00000000-00000000 : Reserved
>> >  =C2=A0 00000000-00000000 : AMDI0030:00
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : AMDI0030:00 AMDI0030:00
>> > 00000000-00000000 : pnp 00:04
>> > 00000000-00000000 : Reserved
>> >  =C2=A0 00000000-00000000 : AMDI0010:03
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : AMDI0010:03 AMDI0010:03
>> > 00000000-00000000 : Reserved
>> > 00000000-00000000 : Local APIC
>> >  =C2=A0 00000000-00000000 : pnp 00:04
>> > 00000000-00000000 : pnp 00:04
>> > 00000000-00000000 : System RAM
>> >  =C2=A0 00000000-00000000 : Kernel code
>> >  =C2=A0 00000000-00000000 : Kernel rodata
>> >  =C2=A0 00000000-00000000 : Kernel data
>> >  =C2=A0 00000000-00000000 : Kernel bss
>> > 00000000-00000000 : Reserved
>> > 00000000-00000000 : PCI Bus 0000:00
>> >  =C2=A0 00000000-00000000 : PCI Bus 0000:07
>> >  =C2=A0=C2=A0=C2=A0 00000000-00000000 : PCI Bus 0000:08
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : PCI Bus 0000:09
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:0=
9:00.0
>> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:0=
9:00.0
>> > 00000000-00000000 : 0000:09:00.0
>> > [8.5.] PCI information ('lspci -vvv' as root)
>> > 06:00.0 Ethernet controller: Intel Corporation Ethernet Controller
>> > I225-V (rev 02)
>> > Subsystem: ASUSTeK Computer Inc. Ethernet Controller I225-V
>> > Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr-
>> > Stepping- SERR- FastB2B- DisINTx+
>> > Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> > <TAbort-
>> > <MAbort- >SERR- <PERR- INTx-
>> > Latency: 0, Cache Line Size: 64 bytes
>> > Interrupt: pin A routed to IRQ 36
>> > IOMMU group: 15
>> > Region 0: Memory at fcc00000 (32-bit, non-prefetchable) [size=3D1M]
>> > Region 3: Memory at fcd00000 (32-bit, non-prefetchable) [size=3D16K]
>> > Capabilities: [40] Power Management version 3
>> > Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
>> > PME(D0+,D1-,D2-,D3hot+,D3cold+)
>> > Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 PME-
>> > Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bit+
>> > Address: 0000000000000000=C2=A0 Data: 0000
>> > Masking: 00000000=C2=A0 Pending: 00000000
>> > Capabilities: [70] MSI-X: Enable+ Count=3D5 Masked- Vector table: BAR=
=3D3
>> > offset=3D00000000
>> > PBA: BAR=3D3 offset=3D00002000
>> > Capabilities: [a0] Express (v2) Endpoint, MSI 00
>> > DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1
>> > <64us
>> > ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W
>> > DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>> > RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>> > MaxPayload 512 bytes, MaxReadReq 512 bytes
>> > DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>> > LnkCap: Port #9, Speed 5GT/s, Width x1, ASPM L1, Exit Latency L1 <4us
>> > ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>> > LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>> > ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> > LnkSta: Speed 5GT/s, Width x1
>> > TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>> > DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
>> > 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
>> > EmergencyPowerReduction Not Supported,
>> EmergencyPowerReductionInit-
>> > FRS- TPHComp- ExtTPHComp-
>> > AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>> > DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
>> > 10BitTagReq- OBFF Disabled,
>> > AtomicOpsCtl: ReqEn-
>> > LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis- Transmit
>> > Margin: Normal Operating Range, EnterModifiedCompliance-
>> > ComplianceSOS-
>> > Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
>> > LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
>> > EqualizationPhase1-
>> > EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
>> > Retimer- 2Retimers- CrosslinkRes: unsupported
>> > Capabilities: [100 v2] Advanced Error Reporting
>> > UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>> > MalfTLP-
>> > ECRC- UnsupReq- ACSViol-
>> > UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>> > MalfTLP-
>> > ECRC- UnsupReq- ACSViol-
>> > UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
>> > MalfTLP+ ECRC- UnsupReq- ACSViol-
>> > CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
>> > CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
>> > AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+
>> > ECRCChkEn-
>> > MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>> > HeaderLog: 00000000 00000000 00000000 00000000
>> > Capabilities: [140 v1] Device Serial Number 24-4b-fe-ff-ff-5a-40-86
>> > Capabilities: [1c0 v1] Latency Tolerance Reporting Max snoop latency:
>> > 0ns Max no snoop latency: 0ns
>> > Capabilities: [1f0 v1] Precision Time Measurement
>> > PTMCap: Requester:+ Responder:- Root:-
>> > PTMClockGranularity: 4ns
>> > PTMControl: Enabled:+ RootSelected:-
>> > PTMEffectiveGranularity: Unknown
>> > Capabilities: [1e0 v1] L1 PM Substates
>> > L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+
>> > L1_PM_Substates+
>> > L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>> > L1SubCtl2:
>> > Kernel driver in use: igc
>> > Kernel modules: igc
>> > [8.6.] SCSI information (from /proc/scsi/scsi) Empty [8.7.] Other
>> > information that might be relevant to the problem (please look in
>> > /proc and include all information that you think to be relevant):
>> > Relevant logs after running `ethtool -s enp6s0 speed 1000`:
>> >
>> > juil. 25 21:14:56 kkiotarch NetworkManager[459]: <info>
>> > [1690312496.0963] device (enp6s0): carrier: link connected juil. 25
>> > 21:14:56 kkiotarch kernel: igc 0000:06:00.0 enp6s0: NIC Link is Up
>> > 2500 Mbps Full Duplex, Flow Control: RX/TX
>> >
>> > [X.] Other notes, patches, fixes, workarounds:
>> > As a temporary solution, I have forced port speed to be set at 1000
>> > Mbps via my router.
>>
>> rather auto negotiated to 1G (force speed is n/a for 1G/2.5G). This won'=
t
>> resolve disconnetions.
>>
>> >
>> > Apologies if this should have submitted to my distribution's bug
>> > report first (Arch Linux); on my current kernel version, there should
>> > be no patches applied here compared to upstream.
>> >
>> > Thank you,
>> > KKIOT
>> >
>> > _______________________________________________
>> > Intel-wired-lan mailing list
>> > Intel-wired-lan@osuosl.org
>> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan@osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>>


