Return-Path: <netdev+bounces-41409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929957CADE9
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15D4BB20ED7
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9862C85F;
	Mon, 16 Oct 2023 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIxqsPs7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C42C848;
	Mon, 16 Oct 2023 15:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40323C433C8;
	Mon, 16 Oct 2023 15:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697471028;
	bh=KflpWEqX7L8WyrGy1c91r65GrP/uvGSP3yrFJnPap1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dIxqsPs7/I47MoMm8sZ5jmn5lqUcuYDCCam58k6Xtn/xVKVpV5IAvJcgFjRl1Ba1T
	 PvKET3E6toxxkP02X1pJubkAfVn9JveoKAD7w/e43vsm103/dCTifZu5g/2lzlA8Y9
	 CIk7z755isPQu7huNSuEgc/TtcgNAu1sx0dxEihs8yUmYvPRm/78FNJRxO/HGRBSYi
	 xoHvXIiEPAQLR9eT5g5dJn9JRGSSZKKhneipjT8IQ3CbIpS2kQydF9VKwlhcxhYuRd
	 WJervn19g9gGFo3Q7vcbkIJm3EVg7IWLFhcw22qtucwUDjltvaJKKvblFJf2sffItc
	 19qlXJSfXVcXQ==
Date: Mon, 16 Oct 2023 08:43:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Michael Walle <michael@walle.cc>, Jacob Keller
 <jacob.e.keller@intel.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231016084346.10764b4a@kernel.org>
In-Reply-To: <20231016170027.42806cb7@kmaincent-XPS-13-7390>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
	<20231009155138.86458-9-kory.maincent@bootlin.com>
	<2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
	<20231010102343.3529e4a7@kmaincent-XPS-13-7390>
	<20231013090020.34e9f125@kernel.org>
	<6ef6418d-6e63-49bd-bcc1-cdc6eb0da2d5@lunn.ch>
	<20231016124134.6b271f07@kmaincent-XPS-13-7390>
	<20231016072204.1cb41eab@kernel.org>
	<20231016170027.42806cb7@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Oct 2023 17:00:27 +0200 K=C3=B6ry Maincent wrote:
> On Mon, 16 Oct 2023 07:22:04 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> > > This is the main reason I changed this. This is Linux implementation
> > > purpose to know whether it should go through netdev or phylib, and th=
en
> > > each of these drivers could use other timestamps which are hardware
> > > related.   =20
> >=20
> > For an integrated design there's 90% chance the stamping is done=20
> > by the MAC. Even if it isn't there's no difference between PHY
> > and MAC in terms of quality. =20
>=20
> Ok, but there might be quality difference in case of several timestamp
> configuration done in the MAC. Like the timestamping precision vs frequen=
cy
> precision. In that case how ethtool would tell the driver to switch betwe=
en
> them?

What's the reason for timestamp precision differences?
My understanding so far was the the differences come from:
 1. different stamping device (i.e. separate "piece of silicon",
    accessed over a different bus, with different PHC etc.)
 2. different stamping point (MAC vs DMA)

I don't think any "integrated" device would support stamps which
differ under category 1.

> My solution could work for this case by simply adding new values to the e=
num:
>=20
> enum {
> 	NETDEV_TIMESTAMPING =3D (1 << 0),
> 	PHYLIB_TIMESTAMPING =3D (1 << 1),
> 	MAC_TS_PRECISION =3D (1 << 2)|(1 << 0),
> 	MAC_FREQ_PRECISION =3D (2 << 2)|(1 << 0),
> }
>=20
> Automatically Linux will go through the netdev implementation and could p=
ass
> the enum value to the netdev driver.

We can add multiple fields to netlink. Why use the magic encoding?

> > But there is a big difference between MAC/PHY and DMA which would
> > both fall under NETDEV? =20
>=20
> Currently there is no DMA timestamping support right?

Kinda. Some devices pass DMA stamps as "HW stamps", and pretend they
are "good enough". But yes, there's no distinction at API level.

> And I suppose it fill fall under the net device management?

Yes.

> In that case we will have MAC and DMA under netdev and PHY under phylib a=
nd
> we won't have to do anything more than this timestamping management patch=
:=20
> https://lore.kernel.org/netdev/20231009155138.86458-14-kory.maincent@boot=
lin.com/

Maybe we should start with a doc describing what APIs are at play,
what questions they answer, and what hard use cases we have.

I'm not opposed to the ethool API reporting just the differences
from my point 1. (in the first paragraph). But then we shouldn't
call that "layer", IMO, but device or source or such.

