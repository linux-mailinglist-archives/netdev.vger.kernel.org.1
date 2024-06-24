Return-Path: <netdev+bounces-106116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDDC914E21
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1792810B8
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCC813D61B;
	Mon, 24 Jun 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBUDf713"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA153389;
	Mon, 24 Jun 2024 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234879; cv=none; b=QCCFILb1XHntt5Y3M2EnOPYM7GaSAjFkLmHi8C02j/I6sROOqM6Pk9oZWwB7cKz2Y3l6AzA4Bl4uBxehA1SN4HVPThDrzt0w+W64Xt1oCqoRsZn5bmbPTGAs11b3qhtdQLPQUWa/oO9IFV/+Wfm7UpYpVLuvDpMQqKAtIn18BkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234879; c=relaxed/simple;
	bh=hWNaWrPpdbV9TanGy2wQEruPknSvEpTLlJ+o+tyefZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5rxt2FTT9wN09b5FMYnnpXaQinYqWSLOohEH+yoCv++X1PGQFOVJ8KzO4C+fZsSOLzhtG7iGi7XLd9fgb1BPKMTrzFzwyei13/fLwRWEgXh3KVSy/DYmTE5TxNB3A5PKfnZbvrj57k7Qq+J7aB26sEWzK1EHvcmDY7wwjZ2ZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBUDf713; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882F3C2BBFC;
	Mon, 24 Jun 2024 13:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719234879;
	bh=hWNaWrPpdbV9TanGy2wQEruPknSvEpTLlJ+o+tyefZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBUDf713NrvwXOjtaM1kIwLqyIwrjLr3idjpOqTi3xh6pwmgH8Oss50pyG56XMqog
	 nR1UcHmfbWaW8WhQ00U1drIzbawhPKoPgLTbA738vKQMbiCH7SD7e6qM7v4VoD7mKl
	 ObRWeh2MaKsjJik6XP96U8fkodlTOJ0s6LHMe5WDObkp2u1XXTRoe1FXUHbohUHzrT
	 lbuu+DWSdW7t26DgJRtHctEnoKKCmHqGc6cCjuNiaikuFgyMzC2St5/m6mKG5fz1IA
	 cvfuPGT2/pw4dSMqyxbgaG985erbiR3jsYhyKId3HS9AgCaM9escQhBbWLRBI4oWqu
	 XhREMtwMEwJiw==
Date: Mon, 24 Jun 2024 15:14:35 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com
Subject: Re: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <ZnlxO2yAxkkkejU-@lore-desk>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
 <2752c453-cabd-4ca0-833f-262b221de240@lunn.ch>
 <Zni13uFslHz5R6Ns@lore-desk>
 <e9ae143c-e72f-419b-b4da-2f603a4ccec0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gaFNliSXRBvSyy0T"
Content-Disposition: inline
In-Reply-To: <e9ae143c-e72f-419b-b4da-2f603a4ccec0@lunn.ch>


--gaFNliSXRBvSyy0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > > +static void airoha_fe_oq_rsv_init(struct airoha_eth *eth)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	/* hw misses PPE2 oq rsv */
> > > > +	airoha_fe_set(eth, REG_FE_PSE_BUF_SET,
> > > > +		      PSE_DEF_RSV_PAGE * PSE_PORT8_QUEUE);
> > > > +
> > > > +	for (i =3D 0; i < PSE_PORT0_QUEUE; i++)
> > > > +		airoha_fe_set_pse_oq_rsv(eth, 0, i, 0x40);
> > > > +	for (i =3D 0; i < PSE_PORT1_QUEUE; i++)
> > > > +		airoha_fe_set_pse_oq_rsv(eth, 1, i, 0x40);
> > > > +
> > > > +	for (i =3D 6; i < PSE_PORT2_QUEUE; i++)
> > > > +		airoha_fe_set_pse_oq_rsv(eth, 2, i, 0);
> > > > +
> > > > +	for (i =3D 0; i < PSE_PORT3_QUEUE; i++)
> > > > +		airoha_fe_set_pse_oq_rsv(eth, 3, i, 0x40);
> > >=20
> > > Code like this is making me wounder about the split between MAC
> > > driver, DSA driver and DSA tag driver. Or if it should actually be a
> > > pure switchdev driver?
> >=20
> > airoha_eth driver implements just MAC features (FE and QDMA). Currently=
 we only
> > support the connection to the DSA switch (GDM1). EN7581 SoC relies on m=
t7530 driver
> > for DSA (I have not posted the patch for mt7530 yet, I will do after ai=
roha_eth
> > ones).
> >=20
> > >=20
> > > If there some open architecture documentation for this device?
> > >=20
> > > What are these ports about?
> >=20
> > airoha_fe_oq_rsv_init() (we can improve naming here :) is supposed to c=
onfigure
> > hw pre-allocated memory for each queue available in Packet Switching En=
gine
> > (PSE) ports. PSE ports are not switch ports, but SoC internal ports use=
d to
> > connect PSE to different modules. In particular, we are currently imple=
menting
> > just the two connections below:
> > - CDM1 (port0) connects PSE to QDMA1
> > - GDM1 (port1) connects PSE to MT7530 DSA switch
> >=20
> > In the future we will post support for GDM2, GDM3 and GDM4 ports that a=
re
> > connecting PSE to exteranl PHY modules.
>=20
> I've not looked at the datasheet yet, but maybe add some ASCII art
> diagram of the architecture in the commit message, or even a .rst file
> somewhere under Documentation. It is hard to get the big picture
> looking at just the code, and only the MAC driver without all the
> other parts.

ack, I will do my best :)

>=20
> > > > +static int airoha_dev_open(struct net_device *dev)
> > > > +{
> > > > +	struct airoha_eth *eth =3D netdev_priv(dev);
> > > > +	int err;
> > > > +
> > > > +	if (netdev_uses_dsa(dev))
> > > > +		airoha_fe_set(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
> > > > +	else
> > > > +		airoha_fe_clear(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
> > >=20
> > > Does that imply both instances of the GMAC are not connected to the
> > > switch? Can one be used with a PHY?
> >=20
> > The check above is used to support configuration where MT7530 DSA switc=
h module
> > is not loaded (I tested this configuration removing the MT7530 DSA swit=
ch from
> > board dts and resetting the switch). Since for the moment we just suppo=
rt GDM1
> > port (PSE port connected to the switch) we can probably assume it is al=
ways the
> > case and remove this check. In the future we will need this configurati=
on to support
> > GDM2 or GDM3 (PSE port connected to external phy modules). Do you prefe=
r to
> > always set GDM1_STAG_EN_MASK for the moment?
>=20
> If it will be needed, then keep it. But it is the sort of thing which
> raises questions, so its good to explain it, either in the commit
> message, or in the code.

ack, I will add it in v4

Regards,
Lorenzo

>=20
> 	Andrew

--gaFNliSXRBvSyy0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZnlxOwAKCRA6cBh0uS2t
rLAcAP0TZ4SmPSOYdAipm/w/6nxNNN3oeqZPkNWcEiN3sorJOQD/Z2gU/LcXKBFE
trXO0WHHjTAgVPPBiyOn0KB0uGbUbQI=
=saWx
-----END PGP SIGNATURE-----

--gaFNliSXRBvSyy0T--

