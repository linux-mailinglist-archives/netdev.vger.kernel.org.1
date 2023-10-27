Return-Path: <netdev+bounces-44851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7A77DA21C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7C67B21437
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5CD3C6AC;
	Fri, 27 Oct 2023 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cmAST5Ee"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098E3C084
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 20:58:30 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0161A5
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 13:58:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E50FFFF809;
	Fri, 27 Oct 2023 20:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1698440306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgxcwTks53EgmSEEB9IFwr5eCFEZ8fqmtxxLc4BgWS8=;
	b=cmAST5EeEWAR80AgkbfV9z0IHPkrR0tkkHnYHiZ3UIEFaeAQol+ftQCxFSVngyapGaz4Aa
	c4Q43wolSmrr9zOrOeUGhgWClFLxPv1Q9Si5Gq0UIKLZNxzP3spmrj9CeArbg/qCoNQbr5
	vL/HoMSNBQd4LBQ0mKNNIeaE3XCANRctrte7UvRWm0fLh0bEozfRmD6iB2J0dvCZsqWdMC
	zDs1menxFA17/+BIx8vGHAC0p/oVtEj5X2Biv8bNhoYZfaGi8hH/HWt0hagAcASwyPyiA5
	rnQf/GK2EehG3JNYi+bVK7+LkZvzmPn7KK5Un6kH9/AHmSUFFEJgSEM8ZG50wg==
Date: Fri, 27 Oct 2023 22:58:22 +0200
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
Message-ID: <20231027225822.109d7583@xps-13>
In-Reply-To: <2003440.PIDvDuAF1L@steina-w>
References: <20231012193410.3d1812cf@xps-13>
 <3527956.iIbC2pHGDl@steina-w>
 <20231017124919.08601e9c@xps-13>
 <2003440.PIDvDuAF1L@steina-w>
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

Hi Alexander,

> > The full kernel log is at the bottom of this e-mail:
> > https://lore.kernel.org/netdev/20231013102718.6b3a2dfe@xps-13/
> >=20
> > On the module I read on a white sticker:
> > 	TQMA6Q-AA
> > 	RK.0203
> > And on one side of the PCB:
> > 	TQMa6x.0201
> >=20
> > Do you know if this module has the hardware workaround discussed below?
> > (I don't have the schematics of the module) =20
>=20
> Yes, the TQMA6Q-AA RK.0203 has the ethernet hardware workaround implement=
ed.=20
> So you should use the imx6q-tqma6a.dtsi (and eventuelly imx6qdl-tqma6a.dt=
si)=20
> module device tree.

[...]

> > > > > Please note that there are two different module variants,
> > > > > imx6qdl-tqma6a.dtsi and imx6qdl-tqma6b.dtsi. They deal with i.MX6=
's
> > > > > ERR006687 differently. Package drop without any load somewhat
> > > > > indicates
> > > > > this issue. =20
> > > >=20
> > > > I've tried with and without the fsl,err006687-workaround-present DT
> > > > property. It gets successfully parsed an I see the lower idle state
> > > > being disabled under mach-imx. I've also tried just commenting out =
the
> > > > registration of the cpuidle driver, just to be sure. I saw no
> > > > difference. =20
> > >=20
> > > fsl,err006687-workaround-present requires a specific HW workaround, s=
ee
> > > [1]. So this is not applicable on every module. =20
> >=20
> > Based on the information provided above, do you think I can rely on the
> > HW workaround? =20
>=20
> The original u-boot auto-detects if the hardware workaround is present an=
d=20
> default selects the appropriate device tree, either variant A or B, for M=
Ba6x=20
> usage.

So apparently the hardware workaround would be on my module and is
already enabled by software. This would not be the real issue but just
making it worse. I think I diagnosed an issue related to the concurrent
use of DMA to read from the RAM with the IPU. Here is the link of the
new discussion:
https://lists.freedesktop.org/archives/dri-devel/2023-October/428251.html

> > I've tried disabling the registration of both the CPUidle and CPUfreq
> > drivers in the machine code and I see a real difference. The transfers
> > are still not perfect though, but I believe this is related to the ~1%
> > drop of the RGMII lines (timings are not perfect, but I could not
> > extend them more).
> >=20
> > I believe if the hardware workaround is not available on this module I
> > can still disable CPUidle and CPUfreq as a workaround of the
> > workaround...? =20
>=20
> It's hard say without knowing the cause of your problem. I didn't see any=
 of=20
> these problems here.
>=20
> > > > By the way, we tried with a TQ eval board with this SoM and saw the=
 same
> > > > issue (not me, I don't have this board in hands). Don't you experie=
nce
> > > > something similar? I went across a couple of people reporting simil=
ar
> > > > issues with these modules but none of them reported how they fixed =
it
> > > > (if they did). I tried two different images based on TQ's Github us=
ing
> > > > v4.14.69 and v5.10 kernels. =20
>=20
> You mentioned a couple of other people having similar problems with these=
=20
> modules. Can you tell me more about those? I'd like to gather more=20
> information. Thanks.

I searched again and found this one which really looked identical to my
initial issue:
https://community.nxp.com/t5/i-MX-Processors/Why-Imx6q-ethernet-is-too-slow=
/m-p/918992
Plus one other which I cannot find anymore.

>=20
> Best regards,
> Alexander

Thanks,
Miqu=C3=A8l

