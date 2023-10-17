Return-Path: <netdev+bounces-41854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF357CC101
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3F71C20842
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B10381BD;
	Tue, 17 Oct 2023 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FenBL/z0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12990381A6
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:49:28 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B155DB0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:49:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC59D1C000C;
	Tue, 17 Oct 2023 10:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697539765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YktfQXJJf6eq8h6WB2b8ng8dgtoMCtj13PRTZnCb60E=;
	b=FenBL/z0uH+1PM+PZV1tupY3MEjeUf01YQrqTTFTGAqmU5bMknPupU+kX7L6A5PH7B86ws
	O6DPFRaFKXxlDWBPRnwIqD9CzqwNhsnYzkuophO9wTY19itatGBIN8oto0ponr+l8upgsO
	t1YA8JjPylCPARDdK1NZGhV2dwy7/iJmWV4sW4vjPZo2YfdC5ZlgSVxM7wdWVNi0GmHbyR
	zls/nhpaRD3v3BAlohiS/N7eR+in822E1xm+ArZfW7tDnYiKm3pGZ72UTe5oyIKxkn0uql
	fhhe1leXPTpbAUwJTBTWXJPB1b5SiYOBXfixFiAoPp6t+bu6Z4rjZ9GrsyJoKA==
Date: Tue, 17 Oct 2023 12:49:19 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Andrew Lunn
 <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Russell King
 <linux@armlinux.org.uk>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-imx@nxp.com,
 netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: Ethernet issue on imx6
Message-ID: <20231017124919.08601e9c@xps-13>
In-Reply-To: <3527956.iIbC2pHGDl@steina-w>
References: <20231012193410.3d1812cf@xps-13>
	<2245614.iZASKD2KPV@steina-w>
	<20231016153154.31d92529@xps-13>
	<3527956.iIbC2pHGDl@steina-w>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Alexander,

alexander.stein@ew.tq-group.com wrote on Mon, 16 Oct 2023 16:41:50
+0200:

> Hi Miquel,
>=20
> Am Montag, 16. Oktober 2023, 15:31:54 CEST schrieb Miquel Raynal:
> > Hi Alexander,
> >=20
> > Thanks a lot for your feedback.
> >  =20
> > > > switch to partitions #0, OK
> > > > mmc1 is current device
> > > > reading boot.scr
> > > > 444 bytes read in 10 ms (43 KiB/s)
> > > > ## Executing script at 20000000
> > > > Booting from mmc ...
> > > > reading zImage
> > > > 9160016 bytes read in 462 ms (18.9 MiB/s)
> > > > reading <board>.dtb =20
> > >=20
> > > Which device tree is that?
> > >  =20
> > > > 40052 bytes read in 22 ms (1.7 MiB/s)
> > > > boot device tree kernel ...
> > > > Kernel image @ 0x12000000 [ 0x000000 - 0x8bc550 ]
> > > > ## Flattened Device Tree blob at 18000000
> > > >=20
> > > >    Booting using the fdt blob at 0x18000000
> > > >    Using Device Tree in place at 18000000, end 1800cc73
> > > >=20
> > > > Starting kernel ...
> > > >=20
> > > > [    0.000000] Booting Linux on physical CPU 0x0
> > > > [    0.000000] Linux version 6.5.0 (mraynal@xps-13)
> > > > (arm-linux-gcc.br_real
> > > > (Buildroot 2 020.08-14-ge5a2a90) 10.2.0, GNU ld (GNU Binutils) 2.34)
> > > > #120
> > > > SMP Thu Oct 12 18:10:20 CE ST 2023
> > > > [    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7),
> > > > cr=3D10c5387d [    0.000000] CPU: PIPT / VIPT nonaliasing data cach=
e, VIPT
> > > > aliasing instruction cache
> > > > [    0.000000] OF: fdt: Machine model: TQ TQMa6Q
> > > > on MBa6x =20
> > >=20
> > > Your first mail mentions a custom board, but this indicates "TQMa6Q
> > > on MBa6x", so which is it? =20
> >=20
> > It's a custom carrier board with a TQMA6Q-AA module. =20
>=20
> Could you please adjust the machine model to your mainboard if it is not =
a=20
> MBa6x? Thanks.
> Which HW revision is this module? It should be printed in u-boot during s=
tart.=20
> Can you provide a full log?

The full kernel log is at the bottom of this e-mail:
https://lore.kernel.org/netdev/20231013102718.6b3a2dfe@xps-13/

On the module I read on a white sticker:
	TQMA6Q-AA
	RK.0203
And on one side of the PCB:
	TQMa6x.0201

Do you know if this module has the hardware workaround discussed below?
(I don't have the schematics of the module)

Here is also the U-Boot log:

U-Boot 2017.11 (Aug 11 2023 - 19:35:47 +0200)

CPU:   Freescale i.MX6Q rev1.5 at 792 MHz
Reset cause: POR
Board: TQMa6Q on a MBa6x
I2C:   ready
DRAM:  1 GiB
PMIC: PFUZE100 ID=3D0x10 REV=3D0x21
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
reading uboot.env
In:    serial
Out:   serial
Err:   serial
Net:   FEC [PRIME]
Warning: FEC MAC addresses don't match:
Address in SROM is         00:d0:93:44:a4:c0
Address in environment is  fc:c2:3d:18:5f:91

starting USB...
USB0:   Port not available.
USB1:   USB EHCI 1.00
scanning bus 1 for devices... 3 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
       scanning usb for ethernet devices... 1 Ethernet Device(s) found
Hit any key to stop autoboot:  0=20
switch to partitions #0, OK
mmc1 is current device
reading boot.scr
444 bytes read in 10 ms (43 KiB/s)
## Executing script at 20000000
Booting from mmc ...
reading zImage
7354128 bytes read in 368 ms (19.1 MiB/s)
reading stephan_Stephanie_ControlUnit_A809_60_408.dtb
40002 bytes read in 25 ms (1.5 MiB/s)
boot device tree kernel ...
Kernel image @ 0x12000000 [ 0x000000 - 0x703710 ]
## Flattened Device Tree blob at 18000000
   Booting using the fdt blob at 0x18000000
   Using Device Tree in place at 18000000, end 1800cc41

Starting kernel ...

> > > Please note that there are two different module variants,
> > > imx6qdl-tqma6a.dtsi and imx6qdl-tqma6b.dtsi. They deal with i.MX6's
> > > ERR006687 differently. Package drop without any load somewhat indicat=
es
> > > this issue. =20
> >=20
> > I've tried with and without the fsl,err006687-workaround-present DT
> > property. It gets successfully parsed an I see the lower idle state
> > being disabled under mach-imx. I've also tried just commenting out the
> > registration of the cpuidle driver, just to be sure. I saw no
> > difference. =20
>=20
> fsl,err006687-workaround-present requires a specific HW workaround, see [=
1].=20
> So this is not applicable on every module.

Based on the information provided above, do you think I can rely on the
HW workaround?

I've tried disabling the registration of both the CPUidle and CPUfreq
drivers in the machine code and I see a real difference. The transfers
are still not perfect though, but I believe this is related to the ~1%
drop of the RGMII lines (timings are not perfect, but I could not
extend them more).

I believe if the hardware workaround is not available on this module I
can still disable CPUidle and CPUfreq as a workaround of the
workaround...?

> > By the way, we tried with a TQ eval board with this SoM and saw the same
> > issue (not me, I don't have this board in hands). Don't you experience
> > something similar? I went across a couple of people reporting similar
> > issues with these modules but none of them reported how they fixed it
> > (if they did). I tried two different images based on TQ's Github using
> > v4.14.69 and v5.10 kernels. =20
>=20
> Personally I've heard the first time about this issue. I never noticed=20
> something like this. Does this issue also appear when using TCP? Or is it=
 an=20
> UDP only issue?

With a mainline kernel:
* With UDP I get a high drop rate.
* With TCP I get slow/bumpy throughputs.

> [1] https://github.com/tq-systems/linux-tqmaxx/blob/TQMa8-fslc-5.10-2.1.x=
-imx/
> arch/arm/boot/dts/imx6qdl-tqma6a.dtsi#L36-L48

Thanks,
Miqu=C3=A8l

