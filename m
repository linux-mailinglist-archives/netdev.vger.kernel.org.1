Return-Path: <netdev+bounces-41337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A787CA97B
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3741C209B1
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15427EE6;
	Mon, 16 Oct 2023 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U3zi0KRI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670126E16
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:32:03 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F887119
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:32:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF3F460142;
	Mon, 16 Oct 2023 13:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697463119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ljZPxh2jdputm9TemFdHIvPMdXoKUEwFt2DcsNbr8A=;
	b=U3zi0KRIXU3t/54+TkkzuG4DwAoXPyrb7H3WsBiamS03+LZvy8OLa1NcumuwTHhlp5hI2q
	elFtGkjhGnXqr7105eWogdIblmJzZLQx78qYuoLuq2UQob1JkIMnHkihiuK277Cv4cG5/U
	amGJ4MKiVbvb64g9QIEDjCVcOA2EqL0MokR6lAFDtQwJNWk2hg7alAhnEMTmJit6nR3siz
	eVRrjeQ8F7L4hEk8xBo6phHxyjUVYE/8Km1trBu4SKbmfV6BqhRU9Ik6/dTkEVJIsN7PXL
	ce5CjanNNOE93Y+amUfIkA5tzq0VMJDW/QWdM9ALW6VfbsYGUCA686Ee//+lwg==
Date: Mon, 16 Oct 2023 15:31:54 +0200
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
Message-ID: <20231016153154.31d92529@xps-13>
In-Reply-To: <2245614.iZASKD2KPV@steina-w>
References: <20231012193410.3d1812cf@xps-13>
	<20231012155857.6fd51380@hermes.local>
	<20231013102718.6b3a2dfe@xps-13>
	<2245614.iZASKD2KPV@steina-w>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Alexander,

Thanks a lot for your feedback.

> > switch to partitions #0, OK
> > mmc1 is current device
> > reading boot.scr
> > 444 bytes read in 10 ms (43 KiB/s)
> > ## Executing script at 20000000
> > Booting from mmc ...
> > reading zImage
> > 9160016 bytes read in 462 ms (18.9 MiB/s)
> > reading <board>.dtb =20
>=20
> Which device tree is that?
>=20
> > 40052 bytes read in 22 ms (1.7 MiB/s)
> > boot device tree kernel ...
> > Kernel image @ 0x12000000 [ 0x000000 - 0x8bc550 ]
> > ## Flattened Device Tree blob at 18000000
> >    Booting using the fdt blob at 0x18000000
> >    Using Device Tree in place at 18000000, end 1800cc73
> >=20
> > Starting kernel ...
> >=20
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 6.5.0 (mraynal@xps-13) (arm-linux-gcc.br_r=
eal
> > (Buildroot 2 020.08-14-ge5a2a90) 10.2.0, GNU ld (GNU Binutils) 2.34) #1=
20
> > SMP Thu Oct 12 18:10:20 CE ST 2023
> > [    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7),
> > cr=3D10c5387d [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, V=
IPT
> > aliasing instruction cache
> > [    0.000000] OF: fdt: Machine model: TQ TQMa6Q
> > on MBa6x =20
>=20
> Your first mail mentions a custom board, but this indicates "TQMa6Q
> on MBa6x", so which is it?

It's a custom carrier board with a TQMA6Q-AA module.

> Please note that there are two different module variants, imx6qdl-tqma6a.=
dtsi=20
> and imx6qdl-tqma6b.dtsi. They deal with i.MX6's ERR006687 differently.
> Package drop without any load somewhat indicates this issue.

I've tried with and without the fsl,err006687-workaround-present DT
property. It gets successfully parsed an I see the lower idle state
being disabled under mach-imx. I've also tried just commenting out the
registration of the cpuidle driver, just to be sure. I saw no
difference.

By the way, we tried with a TQ eval board with this SoM and saw the same
issue (not me, I don't have this board in hands). Don't you experience
something similar? I went across a couple of people reporting similar
issues with these modules but none of them reported how they fixed it
(if they did). I tried two different images based on TQ's Github using
v4.14.69 and v5.10 kernels.

Thanks,
Miqu=C3=A8l

