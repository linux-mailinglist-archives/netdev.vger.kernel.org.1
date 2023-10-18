Return-Path: <netdev+bounces-42176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E528D7CD78B
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CD91C20AE6
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 09:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECCE168DA;
	Wed, 18 Oct 2023 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="GfvJot/l"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A965813ACD
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 09:08:38 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345BBFA
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697620116; x=1729156116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pXc2+1Xj5gk7cF7ErX9Ox7Y2kRGI81RqLWGe3KTVQfA=;
  b=GfvJot/lwMzDYkxkJczvj4v40K3uQf00W7ZT2xFPLKqtxnZxLonwpds1
   PSEHqhNdQyEabf2SsSG2u9rKcrpH8r067ReAcUOO2LzxXPVCOA3aN+oTy
   D27ifS2XSh52quCDGPFsMQWs432oPZkRPCxXItrseUfGvaSdYJDVqHb+Z
   athSlnKOQEuLu4RPq1rmd5AnZTQUQsjNkG4J6CIIpTkTBLLkZU0cEgngO
   M52wI/0UWfOne3YsTahnbEwD6uEZ63W4moE0+FBPMqvIYI8NErpq/FlOl
   JZyHl96d2Bjaf3slrD1Y6TGrE05B8bRB144UlZjZIPGr1tE2hIVyGktTx
   w==;
X-IronPort-AV: E=Sophos;i="6.03,234,1694728800"; 
   d="scan'208";a="33524955"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Oct 2023 11:08:33 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1D6A1280082;
	Wed, 18 Oct 2023 11:08:33 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Russell King <linux@armlinux.org.uk>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, linux-imx@nxp.com, netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: Ethernet issue on imx6
Date: Wed, 18 Oct 2023 11:08:34 +0200
Message-ID: <2003440.PIDvDuAF1L@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231017124919.08601e9c@xps-13>
References: <20231012193410.3d1812cf@xps-13> <3527956.iIbC2pHGDl@steina-w> <20231017124919.08601e9c@xps-13>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Miquel,

Am Dienstag, 17. Oktober 2023, 12:49:19 CEST schrieb Miquel Raynal:
> Hi Alexander,
>=20
> alexander.stein@ew.tq-group.com wrote on Mon, 16 Oct 2023 16:41:50
>=20
> +0200:
> > Hi Miquel,
> >=20
> > Am Montag, 16. Oktober 2023, 15:31:54 CEST schrieb Miquel Raynal:
> > > Hi Alexander,
> > >=20
> > > Thanks a lot for your feedback.
> > >=20
> > > > > switch to partitions #0, OK
> > > > > mmc1 is current device
> > > > > reading boot.scr
> > > > > 444 bytes read in 10 ms (43 KiB/s)
> > > > > ## Executing script at 20000000
> > > > > Booting from mmc ...
> > > > > reading zImage
> > > > > 9160016 bytes read in 462 ms (18.9 MiB/s)
> > > > > reading <board>.dtb
> > > >=20
> > > > Which device tree is that?
> > > >=20
> > > > > 40052 bytes read in 22 ms (1.7 MiB/s)
> > > > > boot device tree kernel ...
> > > > > Kernel image @ 0x12000000 [ 0x000000 - 0x8bc550 ]
> > > > > ## Flattened Device Tree blob at 18000000
> > > > >=20
> > > > >    Booting using the fdt blob at 0x18000000
> > > > >    Using Device Tree in place at 18000000, end 1800cc73
> > > > >=20
> > > > > Starting kernel ...
> > > > >=20
> > > > > [    0.000000] Booting Linux on physical CPU 0x0
> > > > > [    0.000000] Linux version 6.5.0 (mraynal@xps-13)
> > > > > (arm-linux-gcc.br_real
> > > > > (Buildroot 2 020.08-14-ge5a2a90) 10.2.0, GNU ld (GNU Binutils) 2.=
34)
> > > > > #120
> > > > > SMP Thu Oct 12 18:10:20 CE ST 2023
> > > > > [    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7=
),
> > > > > cr=3D10c5387d [    0.000000] CPU: PIPT / VIPT nonaliasing data ca=
che,
> > > > > VIPT
> > > > > aliasing instruction cache
> > > > > [    0.000000] OF: fdt: Machine model: TQ TQMa6Q
> > > > > on MBa6x
> > > >=20
> > > > Your first mail mentions a custom board, but this indicates "TQMa6Q
> > > > on MBa6x", so which is it?
> > >=20
> > > It's a custom carrier board with a TQMA6Q-AA module.
> >=20
> > Could you please adjust the machine model to your mainboard if it is no=
t a
> > MBa6x? Thanks.
> > Which HW revision is this module? It should be printed in u-boot during
> > start. Can you provide a full log?
>=20
> The full kernel log is at the bottom of this e-mail:
> https://lore.kernel.org/netdev/20231013102718.6b3a2dfe@xps-13/
>=20
> On the module I read on a white sticker:
> 	TQMA6Q-AA
> 	RK.0203
> And on one side of the PCB:
> 	TQMa6x.0201
>=20
> Do you know if this module has the hardware workaround discussed below?
> (I don't have the schematics of the module)

Yes, the TQMA6Q-AA RK.0203 has the ethernet hardware workaround implemented=
=2E=20
So you should use the imx6q-tqma6a.dtsi (and eventuelly imx6qdl-tqma6a.dtsi=
)=20
module device tree.

> Here is also the U-Boot log:
>=20
> U-Boot 2017.11 (Aug 11 2023 - 19:35:47 +0200)
>=20
> CPU:   Freescale i.MX6Q rev1.5 at 792 MHz
> Reset cause: POR
> Board: TQMa6Q on a MBa6x
> I2C:   ready
> DRAM:  1 GiB
> PMIC: PFUZE100 ID=3D0x10 REV=3D0x21
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
> reading uboot.env
> In:    serial
> Out:   serial
> Err:   serial
> Net:   FEC [PRIME]
> Warning: FEC MAC addresses don't match:
> Address in SROM is         00:d0:93:44:a4:c0
> Address in environment is  fc:c2:3d:18:5f:91
>=20
> starting USB...
> USB0:   Port not available.
> USB1:   USB EHCI 1.00
> scanning bus 1 for devices... 3 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
>        scanning usb for ethernet devices... 1 Ethernet Device(s) found
> Hit any key to stop autoboot:  0
> switch to partitions #0, OK
> mmc1 is current device
> reading boot.scr
> 444 bytes read in 10 ms (43 KiB/s)
> ## Executing script at 20000000
> Booting from mmc ...
> reading zImage
> 7354128 bytes read in 368 ms (19.1 MiB/s)
> reading stephan_Stephanie_ControlUnit_A809_60_408.dtb
> 40002 bytes read in 25 ms (1.5 MiB/s)
> boot device tree kernel ...
> Kernel image @ 0x12000000 [ 0x000000 - 0x703710 ]
> ## Flattened Device Tree blob at 18000000
>    Booting using the fdt blob at 0x18000000
>    Using Device Tree in place at 18000000, end 1800cc41
>=20
> Starting kernel ...
>=20
> > > > Please note that there are two different module variants,
> > > > imx6qdl-tqma6a.dtsi and imx6qdl-tqma6b.dtsi. They deal with i.MX6's
> > > > ERR006687 differently. Package drop without any load somewhat
> > > > indicates
> > > > this issue.
> > >=20
> > > I've tried with and without the fsl,err006687-workaround-present DT
> > > property. It gets successfully parsed an I see the lower idle state
> > > being disabled under mach-imx. I've also tried just commenting out the
> > > registration of the cpuidle driver, just to be sure. I saw no
> > > difference.
> >=20
> > fsl,err006687-workaround-present requires a specific HW workaround, see
> > [1]. So this is not applicable on every module.
>=20
> Based on the information provided above, do you think I can rely on the
> HW workaround?

The original u-boot auto-detects if the hardware workaround is present and=
=20
default selects the appropriate device tree, either variant A or B, for MBa=
6x=20
usage.

> I've tried disabling the registration of both the CPUidle and CPUfreq
> drivers in the machine code and I see a real difference. The transfers
> are still not perfect though, but I believe this is related to the ~1%
> drop of the RGMII lines (timings are not perfect, but I could not
> extend them more).
>=20
> I believe if the hardware workaround is not available on this module I
> can still disable CPUidle and CPUfreq as a workaround of the
> workaround...?

It's hard say without knowing the cause of your problem. I didn't see any o=
f=20
these problems here.

> > > By the way, we tried with a TQ eval board with this SoM and saw the s=
ame
> > > issue (not me, I don't have this board in hands). Don't you experience
> > > something similar? I went across a couple of people reporting similar
> > > issues with these modules but none of them reported how they fixed it
> > > (if they did). I tried two different images based on TQ's Github using
> > > v4.14.69 and v5.10 kernels.

You mentioned a couple of other people having similar problems with these=20
modules. Can you tell me more about those? I'd like to gather more=20
information. Thanks.

Best regards,
Alexander

> >=20
> > Personally I've heard the first time about this issue. I never noticed
> > something like this. Does this issue also appear when using TCP? Or is =
it
> > an UDP only issue?
>=20
> With a mainline kernel:
> * With UDP I get a high drop rate.
> * With TCP I get slow/bumpy throughputs.
>=20
> > [1]
> > https://github.com/tq-systems/linux-tqmaxx/blob/TQMa8-fslc-5.10-2.1.x-i=
mx
> > / arch/arm/boot/dts/imx6qdl-tqma6a.dtsi#L36-L48
>=20
> Thanks,
> Miqu=E8l


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



