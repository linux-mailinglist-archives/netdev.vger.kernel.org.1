Return-Path: <netdev+bounces-155925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F96FA045C0
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716F53A0F89
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA15C1F4E31;
	Tue,  7 Jan 2025 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V20l7NbE"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20691F4714;
	Tue,  7 Jan 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266522; cv=none; b=A9gy8GrIdpjOWS/04VQYWwoCwzdmJHsxqZTYMQyWO/5qIFJBY38tLgToc0l6cj5vS/gudfU6UmCsFifPXaYdtKx2ABdCBiQAqkNPbJXj4+7ul44At+8ulykAq4vzbasZAleNCv4M9kzBFdRtxLOhAUx5ztEZ+eE/4gIzLENk7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266522; c=relaxed/simple;
	bh=2u9sis/CX1sSyRU1xwSGBBVxcF4ZSHYgYUdQrBzfq0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrMJYAAecap7r888gVqwYSy9Ikce7qyDeGaX8C3DQGCSB5op5dIaREIGs9dYN9n/SF5GK6s+hJ7HUl4k3dzZK++iX9mDF2N2pBlhzKLadB9A8YMWVDxswpwTWoaR9DD+LSUjJ5arOoq4HdNCCPrjb6UMhT+ZzXS/aOGV0WYp16M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V20l7NbE; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89E531BF205;
	Tue,  7 Jan 2025 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736266511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MK8mYVHZbDN/6h5Kw4iMe9hDfgJv3Y9+iZpzIdlqYg0=;
	b=V20l7NbE+xSSHApyqLhi7CXr0BK59hchRB6mQoSmtIB0/ay4uatrH9r4LV/W0NKfcB37D5
	JtqCqhtvGd7tWy577xDG6x2RvyaeDgvEZt+0mro1/lMCoRwb1EwdrVZeUEo80kPyEUbNnW
	fIAEmyiXI4OSOuRbDQ3OTJw4liamqKtk+pxzI9xDCbm7sJIkvnQ4FziJ5kqTdZ+wJq3ZfM
	KQUqb0BLaYe+kCC6bNUMgDTRurqiojtffl5A6T9IJbkcqhYI4pxsZUF79Q/kWbHCpFM2gT
	Mft8aS7m0R+LmC/FxB0UAhr8a5Ohxun8a4LwqOJJ2/vl2GGFsKgIQgTA4oKizg==
Date: Tue, 7 Jan 2025 17:15:07 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next RFC 0/5] net: phy: Introduce a port
 representation
Message-ID: <20250107171507.06908d71@fedora.home>
In-Reply-To: <Z31EVPD-3CGGXxnq@shell.armlinux.org.uk>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
	<Z2g3b_t3KwMFozR8@pengutronix.de>
	<Z2hgbdeTXjqWKa14@pengutronix.de>
	<Z3Zu5ZofHqy4vGoG@shell.armlinux.org.uk>
	<Z3bG-B0E2l47znkE@pengutronix.de>
	<20250107142605.6c605eaf@kmaincent-XPS-13-7390>
	<Z31EVPD-3CGGXxnq@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Oleksij, K=C3=B6ry, Russell,

Sorry for the silence so far, i'm now back from a restful holiday
break, and I'm catching-up on this discussion.

I'm replying here, but I've read the discussion so far, and thanks a
lot Oleksji for all the suggestions, it's nice to see that this is
interesting for you !

On Tue, 7 Jan 2025 15:12:20 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Jan 07, 2025 at 02:26:05PM +0100, Kory Maincent wrote:
> > On Thu, 2 Jan 2025 18:03:52 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >  =20
> > > On Thu, Jan 02, 2025 at 10:48:05AM +0000, Russell King (Oracle) wrote=
: =20
> > > > On Sun, Dec 22, 2024 at 07:54:37PM +0100, Oleksij Rempel wrote:   =
=20
> > > > > Here is updated version:
> > > > >=20
> > > > > ports {
> > > > >     /* 1000BaseT Port with Ethernet and simple PoE */
> > > > >     port0: ethernet-port@0 {
> > > > >         reg =3D <0>; /* Port index */
> > > > >         label =3D "ETH0"; /* Physical label on the device */
> > > > >         connector =3D "RJ45"; /* Connector type */
> > > > >         supported-modes =3D <10BaseT 100BaseTX 1000BaseT>; /* Sup=
ported
> > > > > modes */

So for these supported modes, this is something I've tried to avoid
actually, and for 2 reasons :

 - With the usual argument that DT is a HW description, supported-modes
doesn't work here. What matters is :

   - The medium used (is it twisted copper pairs ? backplane ? One of
the may flavors of fiber through a dedicated connector ?) and as a
complement, the number of lanes. This in itself isn't strictly
necessary. A BaseT1 PHY will obviously have only one lane on its MDI
for example. The reason I have included the lanes is mainly for BaseT,
where BaseT1 has one lane while the typical gigabit port has 4.

  I have however seen devices that have a 1G PHY connected to a RJ45
port with 2 lanes only, thus limiting the max achievable speed to 100M.
Here, we would explicietly describe the port has having 2 lanes.=20

 - The supported modes that can be achieved on a port is a bit
redundant considering that we already have a great deal of capability
discovery implemented in phylib, phylink, the SFP stack, etc.

> > > > >=20
> > > > >         transformer {
> > > > >             model =3D "ABC123"; /* Transformer model number */
> > > > >             manufacturer =3D "TransformerCo"; /* Manufacturer nam=
e */
> > > > >=20
> > > > >             pairs {
> > > > >                 pair@0 {
> > > > >                     name =3D "A"; /* Pair A */
> > > > >                     pins =3D <1 2>; /* Connector pins */
> > > > >                     phy-mapping =3D <PHY_TX0_P PHY_TX0_N>; /* PHY=
 pin
> > > > > mapping */ center-tap =3D "CT0"; /* Central tap identifier */
> > > > >                     pse-negative =3D <PSE_GND>; /* CT0 connected =
to GND */
> > > > >                 };
> > > > >                 pair@1 {
> > > > >                     name =3D "B"; /* Pair B */
> > > > >                     pins =3D <3 6>; /* Connector pins */
> > > > >                     phy-mapping =3D <PHY_RX0_P PHY_RX0_N>;
> > > > >                     center-tap =3D "CT1"; /* Central tap identifi=
er */
> > > > >                     pse-positive =3D <PSE_OUT0>; /* CT1 connected=
 to
> > > > > PSE_OUT0 */ };
> > > > >                 pair@2 {
> > > > >                     name =3D "C"; /* Pair C */
> > > > >                     pins =3D <4 5>; /* Connector pins */
> > > > >                     phy-mapping =3D <PHY_TXRX1_P PHY_TXRX1_N>; /*=
 PHY
> > > > > connection only */ center-tap =3D "CT2"; /* Central tap identifie=
r */
> > > > >                     /* No power connection to CT2 */
> > > > >                 };
> > > > >                 pair@3 {
> > > > >                     name =3D "D"; /* Pair D */
> > > > >                     pins =3D <7 8>; /* Connector pins */
> > > > >                     phy-mapping =3D <PHY_TXRX2_P PHY_TXRX2_N>; /*=
 PHY
> > > > > connection only */ center-tap =3D "CT3"; /* Central tap identifie=
r */
> > > > >                     /* No power connection to CT3 */
> > > > >                 };
> > > > >             };
> > > > >         };   =20
> >=20
> > Couldn't we begin with something simple like the following and add all =
the
> > transformers and pairs information as you described later if the commun=
ity feels
> > we need it? =20
>=20
> +1.

+1 as well. One thing is that I'd like to make so that describing the
port is some last-resort solution and make it really not mandatory.

That means, the internal port representation that the kernel maintains
should be able to be populated with sane defaults based on whatever
drives the port can do. As Russell says, things are working pretty well
so far, especially for single-port PHYs that can already indicated
pretty precisely what they can output.

Having a port representation in DT is useful for corner cases such as :

 - For a single-port PHY, when the PHY can't figure-out by itself what
the MDI is. For example, PHYs that can drive either copper or fiber and
that can't reliably derive the mode to use from its straps

 - For weirdnesses in the way the PHY port is wired in HW. As I
mentionned, the only case I encountered was 2 lanes on a 1G PHY, thus
limiting the speed to 100M max.

 - As an "attachment point" for things like PSE, that are really about
ports and not the PHY.

One could argue that this description isn't even needed, but OTHO with
the recent addition of vendor properties like "micrel,fiber-mode" or
"ti,fiber-mode", it appears that there's a gap to fill.

I do think that there's value in Oleksij's ideas, but this discussion
doesn't even include DT people who could help draw a line somewhere.

All that being said, if the status-quo from this discussion is "let's
keep it simple", I have some things I'd still like to discuss.

First, should we keep the lanes ?

And second, I'm confused about the way we deal with BaseX right now, as
we treat it both as a medium and as an MII mode.

If we look at 10G in comparison, we have a clear difference between the
phy_interface_mode "10GBaseR" and the linkmodes "10000BaseKR",
"10000BaseSR", etc.

We don't really have that for baseX, and it may already be too late,
but should we introduce the "1000BaseXS / 1000BaseLX / 1000BaseCX"
modes ?

Thanks everyone,

Maxime

