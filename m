Return-Path: <netdev+bounces-155881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6DFA042F2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62F51612D4
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE011F37CA;
	Tue,  7 Jan 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ebOWH577"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846331F37D5;
	Tue,  7 Jan 2025 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260991; cv=none; b=E3yNOCeOo1GP+QpCmfmsE96v+HByf0wQ++TUYt2K2/mXYR6w1cuNXxpL9WctdFFpPTb06OFUo1dW6Ve0FpKw+MX4WwSjqGWannfJseiU4PBPcrMltVYC3iIIY0wkGmZVSDMkaYLnO1ZgjxelyKbUyQFc98/KDcGuzatxFO1ae0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260991; c=relaxed/simple;
	bh=mnCDeLfXd6aTR5RcF+pnbcjtGv5P6XGhQhxbBfa7b9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TG996YRJebW0snaK9Rfw/xAyQUK698uXV1t6hW47ncodFdSclIZ4RtBBLagghGGRDtz8828emNb2tWTeeeIWeXFVUqcNPeENddeVynKUUmdHyUKKE3izjlREo9d3T/AObWe86ZLqLo8FpjbyLl+Z3Uw++cB2EoadDCTE769UDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ebOWH577; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E4D0FF805;
	Tue,  7 Jan 2025 14:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736260985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5uq4PW9wrTvSgrbfTYLzSaeh2LuYKlH6oEw/KT9e74=;
	b=ebOWH577A/9JaunDKYgh0KOM9UjJTC/gFEseIFKocB5C1haiwDg460GKE8QSn60/6fbRxz
	5VlADaY/j2v2/kFmoHmn46iOGA3ngb9vLqccWygDKk6gywsn8m/XtRefXjzlufaU0FEa6P
	GnSAP74nAxR44Cjjq3EzjSr2zTu+3ptu+xwc4G4mqtav5MMmaUqErZHCyFQh0/XdapwSaX
	veLmEhBKelHhW6qnlFbOuKIUcQeyTaebvr/8vaODUfqdyvgkbSSSfjL7hNQzCns5gM5Mnk
	lO3PHdvow1nmoI0pBLBBxDom1Jy9Df8s01o7UX0+qpuq2sQAZDwyRyFt7JtN9g==
Date: Tue, 7 Jan 2025 15:43:02 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next RFC 0/5] net: phy: Introduce a port
 representation
Message-ID: <20250107154302.628e7982@kmaincent-XPS-13-7390>
In-Reply-To: <Z300BuATJoVDc_4S@pengutronix.de>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
	<Z2g3b_t3KwMFozR8@pengutronix.de>
	<Z2hgbdeTXjqWKa14@pengutronix.de>
	<Z3Zu5ZofHqy4vGoG@shell.armlinux.org.uk>
	<Z3bG-B0E2l47znkE@pengutronix.de>
	<20250107142605.6c605eaf@kmaincent-XPS-13-7390>
	<Z300BuATJoVDc_4S@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 7 Jan 2025 15:02:46 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Tue, Jan 07, 2025 at 02:26:05PM +0100, Kory Maincent wrote:
> > On Thu, 2 Jan 2025 18:03:52 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >  =20
> > > On Thu, Jan 02, 2025 at 10:48:05AM +0000, Russell King (Oracle) wrote=
: =20
>  [...] =20
>  [...] =20
> >=20
> > Couldn't we begin with something simple like the following and add all =
the
> > transformers and pairs information as you described later if the commun=
ity
> > feels we need it?
> >=20
> > mdis {
> >=20
> >     /* 1000BaseT Port with Ethernet and PoE */
> >     mdi0: ethernet-mdi@0 {
> >         reg =3D <0>; /* Port index */
> >         label =3D "ETH0"; /* Physical label on the device */
> >         connector =3D "RJ45"; /* Connector type */
> >         supported-modes =3D <10BaseT 100BaseTX 1000BaseT>; /* Supported=
 modes
> > */ lanes =3D <2>;
> >         variant =3D "MDI-X"; /* MDI or MDI-X */
> >         pse =3D <&pse1>;
> >     };
> > }; =20
>=20
> The problematic properties are lanes and variants.
>=20
> Lanes seems to not provide any additional information which is not
> provided by the supported-modes.
>=20
> We have at least following working variants, which are supported by (some=
?)
> microchip PHYs:
> https://microchip.my.site.com/s/article/1000Base-T-Differential-Pair-Swap=
ping
> For swapping A and B pairs, we may use MDI/MDI-X. What is about swapped
> C and D pairs?
>=20
> The IEEE 802.3 - 2022 has following variants:
> 14.5.2 Crossover function - only A<>B swap is supported
> 40.4.4 Automatic MDI/MDI-X Configuration - only A<>B swap is supported?
> 55.4.4 Automatic MDI/MDI-X configuration - 4 swap variants are supported
> 113.4.4 Automatic MDI/MDI-X configuration - 4 swap variants are supported
> 126.4.4 Automatic MDI/MDI-X configuration - 4 swap variants are supported
>=20
> This was only the pair swap. How to reflect the polarity swap withing
> the pairs?

Indeed I see what you mean. Maybe we could add it later as optional binding=
 and
only focus for now on the current needs.
According to Maxime proposition he wants the connector types and the
supported modes (or number of lanes). On my side I am interested in the PSE
phandle.

We could begin with this:
mdis {
    /* 1000BaseT Port with Ethernet and PoE */
    mdi0: ethernet-mdi@0 {
        reg =3D <0>; /* Port index */
        label =3D "ETH0"; /* Physical label on the device */
        connector =3D "RJ45"; /* Connector type */
        supported-modes =3D <10BaseT 100BaseTX 1000BaseT>; /* Supported mod=
es */
        pse =3D <&pse1>;
    };
}; =20

Your proposition will stay in our mind for future development on the subjec=
t.
I think we currently don't have enough time available to develop the full
package.
What do you think?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

