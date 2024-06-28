Return-Path: <netdev+bounces-107659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8B991BD2D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 13:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434F71C21ADF
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D28C155C96;
	Fri, 28 Jun 2024 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnKAtHc7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72258152526;
	Fri, 28 Jun 2024 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719573112; cv=none; b=OoqNKahwlIMSYunH2/lOsIgIPVx/X1yR3hPE8O0wQ04T/5KMeBuNkhESs65r2i3ptZB6TycQwgRNfqhGvXcq3a5TTuIjGaugdVBtMXqZTfQdknFidCaqkDY5LOT3DkdLA/whYcgjkCwC55dUXo3Fsf7hp0pmBCzjGMpXECqj5b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719573112; c=relaxed/simple;
	bh=IhCJ8q0wQv2Uqdfm8DAp0L2pfQSawU2VAK6mGUolM8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3cU8xYQ1XlC6f1pjS8VD4F4Ntvy1HH/OFlwXewbHf6cfprPAAZVMMo9cZ3m3Tn6TbBdqn90i0RdAFZ36y1QU+wm7+L2C1405Rpl2FCvyJcB2b0m0vLcikOGBQvRZ1t2bJkX4lApWXhgtwoEs1HcW61BP9udxSXlvwegRZGEH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnKAtHc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC7BC116B1;
	Fri, 28 Jun 2024 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719573111;
	bh=IhCJ8q0wQv2Uqdfm8DAp0L2pfQSawU2VAK6mGUolM8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rnKAtHc7PkDH8sTRhTTHhdadT8c30XblnQHJjzE+Rdg7OA9O3N4+nYdV53ffPxMJ7
	 u1JYkVOpauzsxKUX1lBzIKSNwXr26WnzJRgIxoN2BonG+6LIeRwpQiqyKHq5ck/V14
	 JU6fb5gdser9V849G5GLRza4GAaUttzRHgM8uWcZsAk+1/PioyD8xB2laahi+gF4iP
	 Yr1F0PFiPoa7YRd/6jD+GanvaPKBY8z4pvAD6YD359xvG/xBRkSiFSO49bVT/6MQLp
	 8KUmW/8W5xyyoTtcl2RzHDb2VDHihIeiBPKE2mFdapa0ApX4JDElmQmFYhGyXApOd7
	 dEQUxcVHjn9gQ==
Date: Fri, 28 Jun 2024 13:11:48 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Benjamin Larsson <benjamin.larsson@genexis.eu>, netdev@vger.kernel.org,
	nbd@nbd.name, lorenzo.bianconi83@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor@kernel.org, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com, rkannoth@marvell.com,
	sgoutham@marvell.com
Subject: Re: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <Zn6adEvjBBxAoQNK@lore-desk>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
 <2752c453-cabd-4ca0-833f-262b221de240@lunn.ch>
 <b023dfb3-ca8e-4045-b0b1-d6e498961e9c@genexis.eu>
 <4a39fa50-cffc-4f0c-a442-b666b024ba34@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lAs16Qv/8RWOgpBa"
Content-Disposition: inline
In-Reply-To: <4a39fa50-cffc-4f0c-a442-b666b024ba34@lunn.ch>


--lAs16Qv/8RWOgpBa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Jun 24, 2024 at 01:01:44AM +0200, Benjamin Larsson wrote:
> > Hi,
> > > Code like this is making me wounder about the split between MAC
> > > driver, DSA driver and DSA tag driver. Or if it should actually be a
> > > pure switchdev driver?
> > >=20
> > > If there some open architecture documentation for this device?
> > >=20
> > > What are these ports about?
> > >=20
> > > > +static int airoha_dev_open(struct net_device *dev)
> > > > +{
> > > > +	struct airoha_eth *eth =3D netdev_priv(dev);
> > > > +	int err;
> > > > +
> > > > +	if (netdev_uses_dsa(dev))
> > > > +		airoha_fe_set(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
> > > > +	else
> > > > +		airoha_fe_clear(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
> > > Does that imply both instances of the GMAC are not connected to the
> > > switch? Can one be used with a PHY?
> > >=20
> > > 	Andrew
> >=20
> > https://mirror2.openwrt.org/docs/MT7981B_Wi-Fi6_Platform_Datasheet_Open=
_V1.0.pdf
> >=20
> > page 107 (text for 9.1.1 is relevant but not a complete match). In the
> > EN7581 case there is a 5 port switch in the place of GMAC1 (one switch =
port
> > is connected to GDM1).
>=20
> The typical DSA architecture is that the SoC MAC is connected to a
> switch MAC port. You say here, the switch is directly connected to the
> GGM1. So there is no GMAC involved? If there is no MAC, you don't need
> a MAC driver.
>=20
> It seems more likely there is a GMAC, and the SGMII interface, or
> something similar is connected to the switch?
>=20
> 	Andrew
>=20

The EN7581 architecture is similar to MT7988a one. There is a MAC port (GDM=
1)=20
connected to a MT7530 DSA switch. With 'directly connected', I think Benjam=
in
means we rely on the switch internal PHYs for GDM1. Moreover the SoC suppor=
ts
other MAC ports (GDM2, GDM3, GDM4) that can be connected to extanl PHYs.
In v4 I will rework the driver adding the capability to plug even GDM{2,3,4=
}.

Regards,
Lorenzo

--lAs16Qv/8RWOgpBa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZn6acwAKCRA6cBh0uS2t
rCurAP4kKGx5QikXbXkc5wjqVKJmLfGMozX75vBvP6wutMTtygEAgmG8JBldpnqx
25QBff23NcdLFIuKepT+GxfjszfhAQ0=
=fIws
-----END PGP SIGNATURE-----

--lAs16Qv/8RWOgpBa--

