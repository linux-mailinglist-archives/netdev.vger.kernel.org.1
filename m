Return-Path: <netdev+bounces-81249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB142886BF3
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2155BB226D2
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26843FB96;
	Fri, 22 Mar 2024 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b="tgrPZ+8Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtpo48.interia.pl (smtpo48.interia.pl [217.74.67.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9EA3FE2D
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109949; cv=none; b=CU04w3CF3NUHu3o8PnS5Qjqznw+7rlgQ/6loyi64xDVehENgAVkYiZvlNc6H20XkAja240J8OpBiic5L0eLB8DDXa+e0r59tYoHV0ByqjOlx3sC3skAXzAHOr2gJTLWg+rpwDRqnj63vf6BMlyaSKKWrGCHDgWyPY0SwPf8f+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109949; c=relaxed/simple;
	bh=lw2OjIGhTYXcTrLfX6mdIhKHZzQ4NuJAwrMsD7cVDXI=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=qe4EtJUQtaAA0zVmfZ+BhxIlWtnDeIkeorrx0aNAxfrEOojLyOKOCiOiznMWRTe7t1zwJmllW52mmdf+Gr/q2iCWPbIPJEMLu4MYa0Kga7LshLv9WUqWpUb/42XmT2wAueP8Fy/fpJEUjwJVRIq/jT1AwExNizV9MINHE3KNHQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=poczta.fm; spf=pass smtp.mailfrom=poczta.fm; dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b=tgrPZ+8Y; arc=none smtp.client-ip=217.74.67.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Date: Fri, 22 Mar 2024 13:18:38 +0100
From: Robert <777777@poczta.fm>
Subject: Re: [BUG] mtk-t7xx driver on aarch64/cortex-a53
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "chandrashekar.devegowda@intel.com" <chandrashekar.devegowda@intel.com>,
	"linuxwwan@intel.com" <linuxwwan@intel.com>,
	"chiranjeevi.rapolu@linux.intel.com" <chiranjeevi.rapolu@linux.intel.com>,
	"haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
	"m.chetan.kumar@linux.intel.com" <m.chetan.kumar@linux.intel.com>,
	"ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
	"loic.poulain@linaro.org" <loic.poulain@linaro.org>, "ryazanov.s.a@gmail.com"
	<ryazanov.s.a@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
X-Mailer: interia.pl/pf09
In-Reply-To: <vglpeczsxljzntxhyjew@hpkd>
References: <vglpeczsxljzntxhyjew@hpkd>
Message-Id: <booxubaynjyypezhkuic@plbc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1711109935; bh=OrB/2stwM7M+hTrquWy15PBt3gYzHtsoZlrqVPrat2Y=;
	h=Date:From:Subject:To:Message-Id:MIME-Version:Content-Type;
	b=tgrPZ+8YAp80rKJbmN6yWXtxd9qVyzQJbv9uStT8pGwliRjV6PDJ070or8/hM51Dr
	 nk9zv0E4sVJivmAclBSAm/MPMAW1RyJnCUPVxU6ocK1A53G7BqEpfQVhHxR/DSfR6A
	 BGikgNsMRhtH4CwbbcVqp1z9PA0XQkGZb1+pnRpY=

decode_stacktarce.sh output:

[  236.043132] kmodloader: loading kernel modules from /etc/modules.d/*
[  236.055665] mtk_t7xx 0003:01:00.0: assign IRQ: got 113
[  236.060820] mtk_t7xx 0003:01:00.0: enabling device (0000 -> 0002)
[  236.067013] mtk_t7xx 0003:01:00.0: enabling bus mastering
[  236.073529] (unnamed net_device) (dummy): netif_napi_add_weight() called=
 with weight 128
[  236.082757] mtk-pcie-gen3 11280000.pcie: msi#0x1 address_hi 0x0 address_=
lo 0x11280c00 data 1
[  236.091292] mtk-pcie-gen3 11280000.pcie: msi#0x2 address_hi 0x0 address_=
lo 0x11280c00 data 2
[  236.094906] Unable to handle kernel paging request at virtual address ff=
ffffc08521f004
[  236.099754] mtk-pcie-gen3 11280000.pcie: msi#0x3 address_hi 0x0 address_=
lo 0x11280c00 data 3
[  236.101619] Unable to handle kernel paging request at virtual address ff=
ffffc08521d004
[  236.101624] Mem abort info:
[  236.101625]   ESR =3D 0x0000000096000061
[  236.101627]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  236.101630]   SET =3D 0, FnV =3D 0
[  236.101632]   EA =3D 0, S1PTW =3D 0
[  236.101634]   FSC =3D 0x21: alignment fault
[  236.101636] Data abort info:
[  236.101637]   ISV =3D 0, ISS =3D 0x00000061, ISS2 =3D 0x00000000
[  236.101639]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
[  236.101641]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  236.101644] swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D0000000046ad60=
00
[  236.101646] [ffffffc08521d004] pgd=3D100000013ffff003, p4d=3D100000013ff=
ff003, pud=3D100000013ffff003, pmd=3D0068000020a00711
[  236.101656] Internal error: Oops: 0000000096000061 [#1] SMP
[  236.101659] Modules linked in: mtk_t7xx(+) qcserial pppoe ppp_async opti=
on nft_fib_inet nf_flow_table_inet mt7921u(O) mt7921s(O) mt7921e(O) mt7921_=
common(O) iwlmvm(O) iwldvm(O) usb_wwan rndis_host qmi_wwan pppox ppp_generi=
c nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir nft_=
quota nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offlo=
ad nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_chain_nat nf_tables nf_nat =
nf_flow_table nf_conntrack mt7996e(O) mt792x_usb(O) mt792x_lib(O) mt7915e(O=
) mt76_usb(O) mt76_sdio(O) mt76_connac_lib(O) mt76(O) mac80211(O) iwlwifi(O=
) huawei_cdc_ncm cfg80211(O) cdc_ncm cdc_ether wwan usbserial usbnet slhc s=
fp rtc_pcf8563 nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_def=
rag_ipv6 nf_defrag_ipv4 mt6577_auxadc mdio_i2c libcrc32c compat(O) cdc_wdm =
cdc_acm at24 crypto_safexcel pwm_fan i2c_gpio i2c_smbus industrialio i2c_al=
go_bit i2c_mux_reg i2c_mux_pca954x i2c_mux_pca9541 i2c_mux_gpio i2c_mux dum=
my oid_registry tun sha512_arm64 sha1_ce sha1_generic seqiv
[  236.101784]  md5 geniv des_generic libdes cbc authencesn authenc leds_gp=
io xhci_plat_hcd xhci_pci xhci_mtk_hcd xhci_hcd nvme nvme_core gpio_button_=
hotplug(O) dm_mirror dm_region_hash dm_log dm_crypt dm_mod dax usbcore usb_=
common ptp aquantia pps_core mii tpm encrypted_keys trusted
[  236.101825] CPU: 2 PID: 4331 Comm: kworker/u9:1 Tainted: G           O  =
     6.6.22 #0
[  236.101830] Hardware name: Bananapi BPI-R4 (DT)
[  236.101833] Workqueue: md_hk_wq t7xx_fsm_uninit [mtk_t7xx]
[  236.101850] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  236.101854] pc : t7xx_cldma_hw_set_start_addr+0x1c/0x3c mtk_t7xx
[  236.101866] lr : t7xx_cldma_start+0xac/0x13c mtk_t7xx
[  236.101876] sp : ffffffc084ae3d30
[  236.101877] x29: ffffffc084ae3d30 x28: 0000000000000000 x27: 00000000000=
00000
[  236.101883] x26: 0000000000000000 x25: ffffff80c2786380 x24: ffffff80c7b=
d8805
[  236.101888] x23: 0000000000000000 x22: ffffff80c820c9b8 x21: ffffff80c82=
0c128
[  236.101893] x20: 0000000000000001 x19: ffffff80c820c080 x18: 00000000000=
00014
[  236.101898] x17: 0000000092cfe117 x16: 0000000024f52690 x15: 00000000966=
b8fca
[  236.101903] x14: 0000000003e1b73b x13: 00000000b4eeebcb x12: 00000000000=
00001
[  236.101908] x11: 0000000000000000 x10: 0000000000000000 x9 : 00000000000=
00000
[  236.101913] x8 : ffffff80cdcaa8b4 x7 : ffffff80c820c818 x6 : 00000000000=
00018
[  236.101918] x5 : 0000000000000870 x4 : 0000000000000000 x3 : 00000000000=
00000
[  236.101922] x2 : 000000010dc9d000 x1 : ffffffc08521d004 x0 : ffffffc0852=
1d004
[  236.101928] Call trace:
[  236.101930] t7xx_cldma_hw_set_start_addr+0x1c/0x3c mtk_t7xx
[  236.101941] t7xx_fsm_uninit+0x578/0x5ec mtk_t7xx
[  236.101951] process_one_work+0x154/0x2a0=20
[  236.101960] worker_thread+0x2ac/0x488=20
[  236.101964] kthread+0xe0/0xec=20
[  236.101969] ret_from_fork+0x10/0x20=20
[ 236.101976] Code: f9400800 91001000 8b214001 d50332bf (f9000022)
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	f9400800 	ldr	x0, [x0, #16]
   4:	91001000 	add	x0, x0, #0x4
   8:	8b214001 	add	x1, x0, w1, uxtw
   c:	d50332bf 	dmb	oshst
  10:*	f9000022 	str	x2, [x1]		<-- trapping instruction

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	f9000022 	str	x2, [x1]
[  236.101978] ---[ end trace 0000000000000000 ]---
[  236.107624] Mem abort info:
[  236.107625]   ESR =3D 0x0000000096000061
[  236.107626]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  236.107629]   SET =3D 0, FnV =3D 0
[  236.107630]   EA =3D 0, S1PTW =3D 0
[  236.107632]   FSC =3D 0x21: alignment fault
[  236.107633] Data abort info:
[  236.107634]   ISV =3D 0, ISS =3D 0x00000061, ISS2 =3D 0x00000000
[  236.107636]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
[  236.107638]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  236.107640] swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D0000000046ad60=
00
[  236.107643] [ffffffc08521f004] pgd=3D100000013ffff003, p4d=3D100000013ff=
ff003, pud=3D100000013ffff003, pmd=3D0068000020a00711
[  236.109126] pstore: backend (ramoops) writing error (-28)
[  236.116167] mtk-pcie-gen3 11280000.pcie: msi#0x4 address_hi 0x0 address_=
lo 0x11280c00 data 4
[  236.124017] Kernel panic - not syncing: Oops: Fatal exception
[  236.124020] SMP: stopping secondary CPUs
[  237.136907] SMP: failed to stop secondary CPUs 0,2
[  237.136910] Kernel Offset: disabled
[  237.136911] CPU features: 0x0,00000000,20000000,1000400b
[  237.136914] Memory Limit: none
PANIC at PC : 0x000000004300490c
Temat: [BUG] mtk-t7xx driver on aarch64/cortex-a53
Data: 2024-03-22 9:06
Nadawca: "Robert" &lt;777777@poczta.fm>
Adresat: netdev@vger.kernel.org;=20
DW: chandrashekar.devegowda@intel.com; linuxwwan@intel.com; chiranjeevi.rap=
olu@linux.intel.com; haijun.liu@mediatek.com; m.chetan.kumar@linux.intel.co=
m; ricardo.martinez@linux.intel.com; loic.poulain@linaro.org; ryazanov.s.a@=
gmail.com; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; paben=
i@redhat.com;=20

>=20
>> Hi
>=20
> We are facing possible bug in the driver mtk-t7xx under OpenWrt linux
6.1/6.6.
>=20
> From first glance it looks like the driver is accessing an address in
the PCIe MMIO range in 32-bit alignment (ffffffc084a1d004)=20
> but likely the SoC only supports 64-bit aligned (so only addresses
ending on 0 or 8 will work) access there,=20
> hence the [ 294.051349] FSC =3D 0x21: alignment fault.
>=20
>=20
>=20
> [CUT]
> ...
> [   12.285356] mtk_t7xx 0003:01:00.0: assign IRQ: got 113
> [   12.290512] mtk_t7xx 0003:01:00.0: enabling device (0000 -> 0002)
> [   12.296612] mtk_t7xx 0003:01:00.0: enabling bus mastering
> [   12.303087] (unnamed net_device) (dummy): netif_napi_add_weight()
called with weight 128
> [   12.312160] mtk-pcie-gen3 11280000.pcie: msi#0x1 address_hi 0x0
address_lo 0x11280c00 data 1
> [   12.320666] mtk-pcie-gen3 11280000.pcie: msi#0x2 address_hi 0x0
address_lo 0x11280c00 data 2
> [   12.329153] mtk-pcie-gen3 11280000.pcie: msi#0x3 address_hi 0x0
address_lo 0x11280c00 data 3
> [   12.331706] Unable to handle kernel paging request at virtual
address ffffffc083a1d004
> [   12.345488] Mem abort info:
> [   12.345518] mtk-pcie-gen3 11280000.pcie: msi#0x4 address_hi 0x0
address_lo 0x11280c00 data 4
> [   12.348269]   ESR =3D 0x0000000096000061
> [   12.356716] mtk-pcie-gen3 11280000.pcie: msi#0x5 address_hi 0x0
address_lo 0x11280c00 data 5
> [   12.360421]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [   12.368862] mtk-pcie-gen3 11280000.pcie: msi#0x6 address_hi 0x0
address_lo 0x11280c00 data 6
> [   12.374133]   SET =3D 0, FnV =3D 0
> [   12.374135]   EA =3D 0, S1PTW =3D 0
> [   12.382574] mtk-pcie-gen3 11280000.pcie: msi#0x7 address_hi 0x0
address_lo 0x11280c00 data 7
> [   12.385593]   FSC =3D 0x21: alignment fault
> [   12.388751] mtk-pcie-gen3 11280000.pcie: msi#0x8 address_hi 0x0
address_lo 0x11280c00 data 8
> [   12.397137] Data abort info:
> [   12.397138]   ISV =3D 0, ISS =3D 0x00000061, ISS2 =3D 0x00000000
> [   12.397140]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
> [   12.422958]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [   12.428261] swapper pgtable: 4k pages, 39-bit VAs,
pgdp=3D0000000046ad6000
> [   12.434950] [ffffffc083a1d004] pgd=3D100000013ffff003,
p4d=3D100000013ffff003, pud=3D100000013ffff003, pmd=3D0068000020a00711
> [   12.445552] Internal error: Oops: 0000000096000061 [#1] SMP
> [   12.451113] Modules linked in: mtk_t7xx mt7996e(O) mt792x_usb(O)
mt792x_lib(O) mt7915e(O) mt76_usb(O) mt76_sdio(O) mt76_connac_lib(O)
mt76(O) mac80211(O) iwlwifi(O) huawei_cdc_ncm cfg80211(O) cdc_ncm cdc_ether
wwan usbserial usbnet slhc sfp rtc_pcf8563 nfnetlink nf_reject_ipv6
nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 mt6577_auxadc
mdio_i2c libcrc32c compat(O) cdc_wdm cdc_acm at24 crypto_safexcel pwm_fan
i2c_gpio i2c_smbus industrialio i2c_algo_bit i2c_mux_reg i2c_mux_pca954x
i2c_mux_pca9541 i2c_mux_gpio i2c_mux dummy oid_registry tun sha512_arm64
sha1_ce sha1_generic seqiv md5 geniv des_generic libdes cbc authencesn
authenc leds_gpio xhci_plat_hcd xhci_pci xhci_mtk_hcd xhci_hcd nvme
nvme_core gpio_button_hotplug(O) dm_mirror dm_region_hash dm_log dm_crypt
dm_mod dax usbcore usb_common ptp aquantia pps_core mii tpm encrypted_keys
trusted
> [   12.526834] CPU: 2 PID: 1526 Comm: kworker/u9:0 Tainted: G        =20
 O       6.6.22 #0
> [   12.534740] Hardware name: Bananapi BPI-R4 (DT)
> [   12.539259] Workqueue: md_hk_wq t7xx_fsm_uninit [mtk_t7xx]
> [   12.542217] sfp sfp2: module XICOM            XC-SFP+-SR       rev
A    sn C202307141626    dc 230714
> [   12.544746] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS
BTYPE=3D--)
> [   12.554144] mtk_soc_eth 15100000.ethernet eth1: switched to
inband/10gbase-r link mode
> [   12.561064] pc : t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
> [   12.575139] lr : t7xx_cldma_start+0xac/0x13c [mtk_t7xx]
> [   12.580359] sp : ffffffc0813dbd30
> [   12.583661] x29: ffffffc0813dbd30 x28: 0000000000000000 x27:
0000000000000000
> [   12.590786] x26: 0000000000000000 x25: ffffff80c6888140 x24:
ffffff80c11f7e05
> [   12.591893] sfp sfp1: module XICOM            XC-SFP+-LR       rev
A    sn C202307141707    dc 230714
> [   12.593855] hwmon hwmon2: temp1_input not attached to any thermal
zone
> [   12.597909] x23: 0000000000000000 x22: ffffff80c0fdb9b8
> [   12.607297] mtk_soc_eth 15100000.ethernet eth2: switched to
inband/10gbase-r link mode
> [   12.613792]  x21: ffffff80c0fdb128
> [   12.613794] x20: 0000000000000001 x19: ffffff80c0fdb080 x18:
0000000000000014
> [   12.631986] hwmon hwmon3: temp1_input not attached to any thermal
zone
> [   12.637419] x17: 00000000752a0f20 x16: 00000000468ff952 x15:
00000000246d1885
> [   12.651056] x14: 00000000b48c7dff x13: 000000001b6aa29e x12:
0000000000000001
> [   12.658180] x11: 0000000000000000 x10: 0000000000000000 x9 :
0000000000000000
> [   12.665304] x8 : ffffff80c90fdfb4 x7 : ffffff80c0fdb818 x6 :
0000000000000018
> [   12.672428] x5 : 0000000000000870 x4 : 0000000000000000 x3 :
0000000000000000
> [   12.679553] x2 : 00000001090f0000 x1 : ffffffc083a1d004 x0 :
ffffffc083a1d004
> [   12.686678] Call trace:
> [   12.689114]  t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
> [   12.694942]  t7xx_fsm_uninit+0x578/0x5ec [mtk_t7xx]
> [   12.699814]  process_one_work+0x154/0x2a0
> [   12.703818]  worker_thread+0x2ac/0x488
> [   12.707558]  kthread+0xe0/0xec
> [   12.710603]  ret_from_fork+0x10/0x20
> [   12.714172] Code: f9400800 91001000 8b214001 d50332bf (f9000022)
> [   12.720253] ---[ end trace 0000000000000000 ]---
> [   12.731558] pstore: backend (ramoops) writing error (-28)
> [   12.736948] Kernel panic - not syncing: Oops: Fatal exception
> [   12.742680] SMP: stopping secondary CPUs
> [   12.746593] Kernel Offset: disabled
> [   12.750069] CPU features: 0x0,00000000,20000000,1000400b
> [   12.755370] Memory Limit: none
> [   12.765071] Rebooting in 1 seconds..
> PANIC at PC : 0x000000004300490c
>=20
> Kindly
> Robert
>=20
>=20

