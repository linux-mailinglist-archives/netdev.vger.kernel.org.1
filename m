Return-Path: <netdev+bounces-232213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5E4C02BE6
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEC43AFB35
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8192D34A3DA;
	Thu, 23 Oct 2025 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="KunML/GK"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119734A3BB;
	Thu, 23 Oct 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240889; cv=none; b=j3Mh1B/KAJ+xcI1crHs8idI0/BVd8gU6E0QHgAF/sn6qwi/81GTm1AL+3LcRIMfnIziLSStV4imBAGBE+CyoKVMZ6xb+KAm9XX4tmZMiZEfatZkwsEZaePi/0CxUF1ksRxm9S/7WCODmENThBO7CZkS2ed+hsvjitjyMEL9woDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240889; c=relaxed/simple;
	bh=4mvBtd+JM8exXbe9AWHZWE3jMMHvBUZ4E+yfeNOdYU8=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=ZwelL62STycp9zRQtBwG9KW4NWxJePWZyC3TNQC+R6pa9quRBwdwuXLdBH0q3CoZzEeyVAT4kFYppIxlJVsOBIcNs+JIOWda5Ci3SvwD/OfwZ16PyiXNFH855S4a5gg6U+9P0VornK6A0a0mT6ibvedBVVE7CCm6px+ALXcfJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=KunML/GK; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1761240870; x=1761845670; i=frank-w@public-files.de;
	bh=KWd60wQAEvAS9EWsGdgEN6EFu0cFhNFw5+tgq9IhdzA=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:In-Reply-To:
	 References:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=KunML/GKt0mH8im2N51YCT2QskYZdu1AWe0EZfK/jvvbbtaWncKv+qzot5nIMyvi
	 yo/DTGCJQJ/Ahtl8xRAOB41+KrEqla6cAJ62DwlrD2zv52A1VPyoa0sO3dtR++Cu9
	 hsc5QY29O5brZpyjT4IKwv9Y9hgUkFAmZca1bl51R5N1QA07vZJgiG5gi13N/fKuQ
	 Jg04k2pOXuDnEy+1z6wLsfCxWk9KUh+GWwvl4boyNxC64iqKbLHbdPKEmwkSiuncW
	 RIvd+PDQevDBaqMq0MO+QQJ1yNJn488U/kJf1DXcy4qlewWWV9fXNAHs7zWP7PHbD
	 9ZXXhi45muS1jACrjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.155.184] ([217.61.155.184]) by
 trinity-msg-rest-gmx-gmx-live-654c5495b9-fz7pw (via HTTP); Thu, 23 Oct 2025
 17:34:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-47d20d09-1f01-4181-9e9a-b805dd6937a8-1761240870369@trinity-msg-rest-gmx-gmx-live-654c5495b9-fz7pw>
From: frank-w@public-files.de
To: laura.nao@collabora.com
Cc: angelogioacchino.delregno@collabora.com, conor+dt@kernel.org,
 daniel@makrotopia.org, devicetree@vger.kernel.org,
 guangjie.song@mediatek.com, kernel@collabora.com, krzk+dt@kernel.org,
 laura.nao@collabora.com, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 mturquette@baylibre.com, netdev@vger.kernel.org, p.zabel@pengutronix.de,
 richardcochran@gmail.com, robh@kernel.org, sboyd@kernel.org,
 wenst@chromium.org
Subject: Aw: Re: issue with [PATCH v6 06/27] clk: mediatek: clk-gate:
 Refactor mtk_clk_register_gate to use mtk_gate struct
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 17:34:30 +0000
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251023110922.186619-1-laura.nao@collabora.com>
References: <trinity-00d61a0e-40f3-449d-814a-eccd621b4665-1760291406778@trinity-msg-rest-gmx-gmx-live-ddd79cd8f-fsr29>
 <20251023110922.186619-1-laura.nao@collabora.com>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:rh0N8WZD+CKlMU4LKGzQtCTBuckW95eL36IRVW98AiVQOO9joMIEPAgHzP5MGqm7Sc6Dw
 81zFeDrHvBE0Ltg7YUYTM5FsoRkNzQVc+X7KO2NmzD6edcNgN4gY+cq9b4MwUJj8ftIf9TKSmzPL
 BOLk+qXwRotx9zZLZNfpU6LPLPA/QljyQEbEYdNlDQj618ADhQdkFIMradfsqPuSmLTTwm91eIs+
 KSIRqJXzxaz2ZxBMTp78ZO0xVrZm60mBW/gHK+0LzkvoPUE7sIU007Iof/bTQaN/G3RPcakNOQUH
 NTzY1agrmgcioGxyqYkBvUy0bVpQVFNYxLaB3H5QDUa13Nvzg4lQIauz5yi/YYUNeQ=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u2q8T/bXpsk=;rfzfvZ60IcYhXHZkcgQhb6lgKMk
 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
 t+Ja8c8QNAcBZe620g8B1UwIYOHcRdtw==

Hi Laura

thanks for first look

tried to replace the -1 values in infracfg driver with 0, but then it's ge=
tting worse (debug uart issues came on top and still the "Unable to handle =
kernel paging request" for on mmc driver while enabling the clock gate - ms=
dc_gate_clock)=2E

i wonder why msdc_gate_clock disables the clocks and msdc_ungate_clock ena=
bles them=2E=2E=2Ebut in mmc driver first ungate is called which failes and=
 then=20

mmc itself seems to be probed already, maybe switch to uhs triggers this

[    3=2E659479] mtk-msdc 11230000=2Emmc: Got CD GPIO
[    3=2E698999] mtk-msdc 11230000=2Emmc: msdc_track_cmd_data: cmd=3D52 ar=
g=3D00000C00; host->error=3D0x00000002
[    3=2E708205] mtk-msdc 11230000=2Emmc: msdc_track_cmd_data: cmd=3D52 ar=
g=3D80000C08; host->error=3D0x00000002
[    3=2E727275] mtk-msdc 11230000=2Emmc: msdc_track_cmd_data: cmd=3D5 arg=
=3D00000000; host->error=3D0x00000002
[    3=2E736355] mtk-msdc 11230000=2Emmc: msdc_track_cmd_data: cmd=3D5 arg=
=3D00000000; host->error=3D0x00000002
[    3=2E745425] mtk-msdc 11230000=2Emmc: msdc_track_cmd_data: cmd=3D5 arg=
=3D00000000; host->error=3D0x00000002
[    3=2E754505] mtk-msdc 11230000=2Emmc: msdc_track_cmd_data: cmd=3D5 arg=
=3D00000000; host->error=3D0x00000002

[    3=2E796499] mmc0: host does not support reading read-only switch, ass=
uming write-enable
[    3=2E810131] mmc0: new high speed SDHC card at address aaaa
[    3=2E817725] mmcblk0: mmc0:aaaa SC32G 29=2E7 GiB
[    3=2E837920]  mmcblk0: p1 p2 p3 p4 p5 p6

the msdc_track_cmd_data errors already appearing on other boards since thi=
s error is printed at early boottime (not later) by a recent commit, so i g=
uess this is unrelated=2E

the other code position where msdc_gate_clock is called it in msdc_runtime=
_suspend which seems to be called on first access to mmc while
bootup (mount rootfs + starting init), not sure why=2E=2E=2E

which debugging do you want? tried adding debug in mtk_cg_enable / mtk_cg_=
disable and it is running through console=2E=2E=2Estopped that after 2 minu=
tes=2E

and yes, the -1 cause very high "bit" through BIT(cg->gate->shift), but se=
t this to 0 seems not fixing it

so i tried debugging it from the msdc driver

[    6=2E023214] systemd[1]: Hostname set to <bpi-r4-lite>=2E # first acce=
ss to sdcard (read from /etc/hostname)
[    6=2E117320] mtk-msdc 11230000=2Emmc: msdc_runtime_suspend:3308 before=
 gate_clock
[    6=2E124547] mtk-msdc 11230000=2Emmc: msdc_gate_clock:925 before bulk_=
disable_unprepare
[    6=2E132296] Unable to handle kernel paging request at virtual address=
 ffffffc0813d2388
=2E=2E=2E
[    6=2E235005] pc : mtk_cg_disable+0x18/0x38
[    6=2E239009] lr : clk_core_disable+0x7c/0x150
[    6=2E243271] sp : ffffffc083a6bbc0
[    6=2E246573] x29: ffffffc083a6bbc0 x28: ffffff80012f2180 x27: 00000000=
00000000
[    6=2E253698] x26: ffffff80012f21c0 x25: 00000000000f4240 x24: ffffff80=
001a1ac0
[    6=2E260823] x23: 0000000000000008 x22: 0000000000000004 x21: ffffff80=
014c4738
[    6=2E267947] x20: ffffff800134e600 x19: ffffff800134e600 x18: 00000000=
ffffffff
[    6=2E275072] x17: 755f656c62617369 x16: 645f6b6c75622065 x15: 726f6665=
62203532
[    6=2E282197] x14: 00000000ffffffea x13: ffffffc083a6b918 x12: ffffffc0=
81869cf0
[    6=2E289321] x11: 0000000000000001 x10: 0000000000000001 x9 : 00000000=
00017fe8
[    6=2E296446] x8 : c0000000ffffefff x7 : ffffffc081811c70 x6 : 00000000=
00057fa8
[    6=2E303570] x5 : ffffffc081869c98 x4 : ffffffc081ace6a8 x3 : 00000000=
00000001
[    6=2E310695] x2 : 0000000000000001 x1 : ffffffc0813d2370 x0 : ffffff80=
01376800
[    6=2E317820] Call trace:
[    6=2E320256]  mtk_cg_disable+0x18/0x38 (P)
[    6=2E324258]  clk_core_disable+0x7c/0x150
[    6=2E328172]  clk_disable+0x30/0x4c
[    6=2E331566]  clk_bulk_disable+0x3c/0x58
[    6=2E335392]  msdc_gate_clock+0x48/0x15c
[    6=2E339220]  msdc_runtime_suspend+0x2a0/0x2e4

result is same with 0 instead of -1, but uart is than scrambled=2E=2E=2Etr=
ied also with changing only spi0/2 to 0 from -1 (sdmmc is connected to spi2=
 pins),
but has same effect=2E

so than i tried removng the __initconst in infracfg clocks and this seems =
fixing the issue=2E=2E=2Ewonder why this came up with your patch, imho this
should also happen before=2E

only noticed with my debugs, that sdmmc does the
gate_clock/ungate_clock nearly every second=2E=2E=2Enot sure if this is no=
rmal as we normally do not see it=2E

regards Frank

> Gesendet: Donnerstag, 23=2E Oktober 2025 um 13:09
> Von: "Laura Nao" <laura=2Enao@collabora=2Ecom>
> An: frank-w@public-files=2Ede
> CC: angelogioacchino=2Edelregno@collabora=2Ecom, conor+dt@kernel=2Eorg, =
daniel@makrotopia=2Eorg, devicetree@vger=2Ekernel=2Eorg, guangjie=2Esong@me=
diatek=2Ecom, kernel@collabora=2Ecom, krzk+dt@kernel=2Eorg, laura=2Enao@col=
labora=2Ecom, linux-arm-kernel@lists=2Einfradead=2Eorg, linux-clk@vger=2Eke=
rnel=2Eorg, linux-kernel@vger=2Ekernel=2Eorg, linux-mediatek@lists=2Einfrad=
ead=2Eorg, matthias=2Ebgg@gmail=2Ecom, mturquette@baylibre=2Ecom, netdev@vg=
er=2Ekernel=2Eorg, p=2Ezabel@pengutronix=2Ede, richardcochran@gmail=2Ecom, =
robh@kernel=2Eorg, sboyd@kernel=2Eorg, wenst@chromium=2Eorg
> Betreff: Re: issue with [PATCH v6 06/27] clk: mediatek: clk-gate: Refact=
or mtk_clk_register_gate to use mtk_gate struct
>
> Hi Frank,
>=20
> On 10/12/25 19:50, Frank Wunderlich wrote:
> > Hi,
> >
> > this patch seems to break at least the mt7987 device i'm currently wor=
king on with torvalds/master + a bunch of some patches for mt7987 support=
=2E
> >
> > if i revert these 2 commits my board works again:
> >
> > Revert "clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use=
 mtk_gate struct" =3D> 8ceff24a754a
> > Revert "clk: mediatek: clk-gate: Add ops for gates with HW voter"
> >
> > if i reapply the first one (i had to revert the second before), it is =
broken again=2E
> >
> > I have seen no changes to other clock drivers in mtk-folder=2E Mt7987 =
clk driver is not upstream yet, maybe you can help us changing this driver =
to work again=2E
> >
> > this is "my" commit adding the mt7987 clock driver=2E=2E=2E
> >
> > https://github=2Ecom/frank-w/BPI-Router-Linux/commit/7480615e752dee7ea=
9e60dfaf31f39580b4bf191
> >
> > start of trace (had it sometimes with mmc or spi and a bit different w=
ith 2p5g phy, but this is maybe different issue):
> >
> > [    5=2E593308] Unable to handle kernel paging request at virtual add=
ress ffffffc081371f88
> > [    5=2E593322] Mem abort info:
> > [    5=2E593324]   ESR =3D 0x0000000096000007
> > [    5=2E593326]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [    5=2E593329]   SET =3D 0, FnV =3D 0
> > [    5=2E593331]   EA =3D 0, S1PTW =3D 0
> > [    5=2E593333]   FSC =3D 0x07: level 3 translation fault
> > [    5=2E593336] Data abort info:
> > [    5=2E593337]   ISV =3D 0, ISS =3D 0x00000007, ISS2 =3D 0x00000000
> > [    5=2E593340]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > [    5=2E593343]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > [    5=2E593345] swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D0000000=
045294000
> > [    5=2E593349] [ffffffc081371f88] pgd=3D1000000045a7f003, p4d=3D1000=
000045a7f003, pud=3D1000000045a7f003, pmd=3D1000000045a82003, pte=3D0000000=
000000000
> > [    5=2E593364] Internal error: Oops: 0000000096000007 [#1]  SMP
> > [    5=2E593369] Modules linked in:
> > [    5=2E593375] CPU: 0 UID: 0 PID: 1570 Comm: udevd Not tainted 6=2E1=
7=2E0-bpi-r4 #7 NONE=20
> > [    5=2E593381] Hardware name: Bananapi BPI-R4-LITE (DT)
> > [    5=2E593385] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS=
 BTYPE=3D--)
> > [    5=2E593390] pc : mtk_cg_enable+0x14/0x38
> > [    5=2E593404] lr : clk_core_enable+0x70/0x16c
> > [    5=2E593411] sp : ffffffc085853090
> > [    5=2E593413] x29: ffffffc085853090 x28: 0000000000000000 x27: ffff=
ffc0800b82c4
> > [    5=2E593420] x26: ffffffc085853754 x25: 0000000000000004 x24: ffff=
ff80001828f4
> > [    5=2E593426] x23: 0000000000000000 x22: ffffff80030620c0 x21: ffff=
ff8007819580
> > [    5=2E593432] x20: 0000000000000000 x19: ffffff8000feee00 x18: 0000=
003e39f23000
> > [    5=2E593438] x17: ffffffffffffffff x16: 0000000000020000 x15: ffff=
ff8002f590a0
> > [    5=2E593444] x14: ffffff800346e000 x13: 0000000000000000 x12: 0000=
000000000000
> > [    5=2E593450] x11: 0000000000000001 x10: 0000000000000000 x9 : 0000=
000000000000
> > [    5=2E593455] x8 : ffffffc085853528 x7 : 0000000000000000 x6 : 0000=
000000002c01
> > [    5=2E593461] x5 : ffffffc080858794 x4 : 0000000000000014 x3 : 0000=
000000000001
> > [    5=2E593467] x2 : 0000000000000000 x1 : ffffffc081371f70 x0 : ffff=
ff8001028c00
> > [    5=2E593473] Call trace:
> > [    5=2E593476]  mtk_cg_enable+0x14/0x38 (P)
> > [    5=2E593484]  clk_core_enable+0x70/0x16c
> > [    5=2E593490]  clk_enable+0x28/0x54
> > [    5=2E593496]  mtk_spi_runtime_resume+0x84/0x174
> > [    5=2E593506]  pm_generic_runtime_resume+0x2c/0x44
> > [    5=2E593513]  __rpm_callback+0x40/0x228
> > [    5=2E593521]  rpm_callback+0x38/0x80
> > [    5=2E593527]  rpm_resume+0x590/0x774
> > [    5=2E593533]  __pm_runtime_resume+0x5c/0xcc
> > [    5=2E593539]  spi_mem_access_start=2Eisra=2E0+0x38/0xdc
> > [    5=2E593545]  spi_mem_exec_op+0x40c/0x4e0
> >
> > it is not clear for me, how to debug further as i have different clock=
 drivers (but i guess either the infracfg is the right)=2E
> > maybe the critical-flag is not passed?
> >
> > regards Frank
> >
>=20
> Could you try adding some debug prints to help identify the specific=20
> gate/gates causing the issue? It would be very helpful in narrowing=20
> down the problem=2E
>=20
> A couple notes - I noticed that some mux-gate clocks have -1 assigned to=
=20
> the _gate, _upd_ofs, and _upd unsigned int fields=2E Not sure this is=20
> directly related to the crash above, but it=E2=80=99s something that sho=
uld=20
> be addressed regardless:
>=20
> MUX_GATE_CLR_SET_UPD(CLK_INFRA_MUX_UART0_SEL, "infra_mux_uart0_sel",
> 		     infra_mux_uart0_parents, 0x0018, 0x0010, 0x0014,
> 		     0, 1, -1, -1, -1),
>=20
> I think __initconst should also be removed from clocks that are used at=
=20
> runtime=2E I=E2=80=99m not certain this is directly related to the issue=
, but I
> wanted to mention it in case it=E2=80=99s helpful=2E
>=20
> Best,
>=20
> Laura
>=20
> >
> >> Gesendet: Sonntag, 21=2E September 2025 um 18:53
> >> Von: "Stephen Boyd" <sboyd@kernel=2Eorg>
> >> An: "Laura Nao" <laura=2Enao@collabora=2Ecom>, angelogioacchino=2Edel=
regno@collabora=2Ecom, conor+dt@kernel=2Eorg, krzk+dt@kernel=2Eorg, matthia=
s=2Ebgg@gmail=2Ecom, mturquette@baylibre=2Ecom, p=2Ezabel@pengutronix=2Ede,=
 richardcochran@gmail=2Ecom, robh@kernel=2Eorg
> >> CC: guangjie=2Esong@mediatek=2Ecom, wenst@chromium=2Eorg, linux-clk@v=
ger=2Ekernel=2Eorg, devicetree@vger=2Ekernel=2Eorg, linux-kernel@vger=2Eker=
nel=2Eorg, linux-arm-kernel@lists=2Einfradead=2Eorg, linux-mediatek@lists=
=2Einfradead=2Eorg, netdev@vger=2Ekernel=2Eorg, kernel@collabora=2Ecom, "La=
ura Nao" <laura=2Enao@collabora=2Ecom>
> >> Betreff: Re: [PATCH v6 06/27] clk: mediatek: clk-gate: Refactor mtk_c=
lk_register_gate to use mtk_gate struct
> >>
> >> Quoting Laura Nao (2025-09-15 08:19:26)
> >>> MT8196 uses a HW voter for gate enable/disable control, with
> >>> set/clr/sta registers located in a separate regmap=2E Refactor
> >>> mtk_clk_register_gate() to take a struct mtk_gate, and add a pointer=
 to
> >>> it in struct mtk_clk_gate=2E This allows reuse of the static gate da=
ta
> >>> (including HW voter register offsets) without adding extra function
> >>> arguments, and removes redundant duplication in the runtime data str=
uct=2E
> >>>
> >>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino=2Edelregno=
@collabora=2Ecom>
> >>> Reviewed-by: Chen-Yu Tsai <wenst@chromium=2Eorg>
> >>> Signed-off-by: Laura Nao <laura=2Enao@collabora=2Ecom>
> >>> ---
> >>
> >> Applied to clk-next
> >
>=20
>

