Return-Path: <netdev+bounces-105961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C630913F44
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 01:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11013281117
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 23:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E61850BD;
	Sun, 23 Jun 2024 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5jAv67v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893459B71;
	Sun, 23 Jun 2024 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719186915; cv=none; b=eO5uYba6tFXpyNc1BNhoV/f5dIwAS7Zjry5ThD6o4lyOCBtsASp3w1mIBodCNAYsuFrUuRbSIXdHlc8CbNZOzN9kRd/714nSFyoXtTnB2PS7MVIBhv6NpVCA2RgLpsGd3FYPnMNXE5ZZv0bIphH+m6wAnghW9R0+g2IIEiqLB0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719186915; c=relaxed/simple;
	bh=81hwNvTIa/Ag38uYWhJDzLVrzAFW2Zxai7kcOQEcDNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htcwTA9FlQaqVFLjluPzyNxOfj2zvTcMwXXiw4aZz/0O/7RY2n8iyjSaiTOLT+HRiXO/xKL1sQykNLErNBNc3NKwjLJEKdkj+d8Wr76tVAiPTcAOxdwO1/UhToGiy6BgrLv5ewHWNYvrrmrNivasIWBZOwFQr/EOVWfpgozaz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5jAv67v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A1CC2BD10;
	Sun, 23 Jun 2024 23:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719186914;
	bh=81hwNvTIa/Ag38uYWhJDzLVrzAFW2Zxai7kcOQEcDNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5jAv67vjVEP9beXTZJ2VtFY/JZmkiHXE6HYzUdolob6miv7+1wM8B8mU4LoA3FPN
	 40vd34sorRQ29Y5JfoOBPPJRUlkW1J0/ksS706WZn29s0ahAPGMjJg+wjt85GEGKY0
	 6oxWuKoKksSVNIyaCOsN9JsNfDwHjAS8hkFoZRz980OKwP77fmsWD4YZF6tCugszNo
	 a/NgRcS0p6opj6K8QiwVEsC6pI3LQXKemuMQv0SE/goMcQD7SAYOysZ4KwjiaUbcq1
	 Mc7csvNUMpHJ41kTK3kIvJ7V+F9k/O3fo8GPYGVwPKomqDW/pgiun/yOCL7wnb/CPt
	 TuogvmCaOsUng==
Date: Mon, 24 Jun 2024 01:55:10 +0200
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
Message-ID: <Zni13uFslHz5R6Ns@lore-desk>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
 <2752c453-cabd-4ca0-833f-262b221de240@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z8+Orxv1Mp7S3hrH"
Content-Disposition: inline
In-Reply-To: <2752c453-cabd-4ca0-833f-262b221de240@lunn.ch>


--Z8+Orxv1Mp7S3hrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +static int airoha_fe_set_pse_oq_rsv(struct airoha_eth *eth,
> > +				    u32 port, u32 queue, u32 val)
> > +{
> > +	u32 orig_val, tmp, all_rsv, fq_limit;
> > +	const u32 pse_port_oq_id[] =3D {
> > +		PSE_PORT0_QUEUE,
> > +		PSE_PORT1_QUEUE,
> > +		PSE_PORT2_QUEUE,
> > +		PSE_PORT3_QUEUE,
> > +		PSE_PORT4_QUEUE,
> > +		PSE_PORT5_QUEUE,
> > +		PSE_PORT6_QUEUE,
> > +		PSE_PORT7_QUEUE,
> > +		PSE_PORT8_QUEUE,
> > +		PSE_PORT9_QUEUE,
> > +		PSE_PORT10_QUEUE
> > +	};
>=20
> > +static void airoha_fe_oq_rsv_init(struct airoha_eth *eth)
> > +{
> > +	int i;
> > +
> > +	/* hw misses PPE2 oq rsv */
> > +	airoha_fe_set(eth, REG_FE_PSE_BUF_SET,
> > +		      PSE_DEF_RSV_PAGE * PSE_PORT8_QUEUE);
> > +
> > +	for (i =3D 0; i < PSE_PORT0_QUEUE; i++)
> > +		airoha_fe_set_pse_oq_rsv(eth, 0, i, 0x40);
> > +	for (i =3D 0; i < PSE_PORT1_QUEUE; i++)
> > +		airoha_fe_set_pse_oq_rsv(eth, 1, i, 0x40);
> > +
> > +	for (i =3D 6; i < PSE_PORT2_QUEUE; i++)
> > +		airoha_fe_set_pse_oq_rsv(eth, 2, i, 0);
> > +
> > +	for (i =3D 0; i < PSE_PORT3_QUEUE; i++)
> > +		airoha_fe_set_pse_oq_rsv(eth, 3, i, 0x40);
>=20
> Code like this is making me wounder about the split between MAC
> driver, DSA driver and DSA tag driver. Or if it should actually be a
> pure switchdev driver?

airoha_eth driver implements just MAC features (FE and QDMA). Currently we =
only
support the connection to the DSA switch (GDM1). EN7581 SoC relies on mt753=
0 driver
for DSA (I have not posted the patch for mt7530 yet, I will do after airoha=
_eth
ones).

>=20
> If there some open architecture documentation for this device?
>=20
> What are these ports about?

airoha_fe_oq_rsv_init() (we can improve naming here :) is supposed to confi=
gure
hw pre-allocated memory for each queue available in Packet Switching Engine
(PSE) ports. PSE ports are not switch ports, but SoC internal ports used to
connect PSE to different modules. In particular, we are currently implement=
ing
just the two connections below:
- CDM1 (port0) connects PSE to QDMA1
- GDM1 (port1) connects PSE to MT7530 DSA switch

In the future we will post support for GDM2, GDM3 and GDM4 ports that are
connecting PSE to exteranl PHY modules.

>=20
> > +static void airoha_qdma_clenaup_rx_queue(struct airoha_queue *q)
>=20
> cleanup?

ack, I will fix it.

>=20
> > +static int airoha_dev_open(struct net_device *dev)
> > +{
> > +	struct airoha_eth *eth =3D netdev_priv(dev);
> > +	int err;
> > +
> > +	if (netdev_uses_dsa(dev))
> > +		airoha_fe_set(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
> > +	else
> > +		airoha_fe_clear(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
>=20
> Does that imply both instances of the GMAC are not connected to the
> switch? Can one be used with a PHY?

The check above is used to support configuration where MT7530 DSA switch mo=
dule
is not loaded (I tested this configuration removing the MT7530 DSA switch f=
rom
board dts and resetting the switch). Since for the moment we just support G=
DM1
port (PSE port connected to the switch) we can probably assume it is always=
 the
case and remove this check. In the future we will need this configuration t=
o support
GDM2 or GDM3 (PSE port connected to external phy modules). Do you prefer to
always set GDM1_STAG_EN_MASK for the moment?

Regards,
Lorenzo

>=20
> 	Andrew

--Z8+Orxv1Mp7S3hrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZni13gAKCRA6cBh0uS2t
rHWVAP9G9tnRvO/z/Pk+kj9q9+Hb52RRDPHJPzHdZ4NeNNyaAwD+OdKe16mUiEHX
g7cRgz5mSCl3+48FnP/UcWk1ZE6ZfQE=
=0MTD
-----END PGP SIGNATURE-----

--Z8+Orxv1Mp7S3hrH--

