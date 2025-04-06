Return-Path: <netdev+bounces-179479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1517A7D0AD
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 23:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD9A3ACB3D
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A38C20E6FB;
	Sun,  6 Apr 2025 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="hXR1Cj6J"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0F14831E;
	Sun,  6 Apr 2025 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743974689; cv=none; b=rLxCUTqLAV8sh6KDL1fQinEmSMF0vH3YxmY69Ev+zwS365lxIJKseKoss+verSZDOvaF/P75PCm3HO2+ADBbWLK2as4pF/gvJUtVGvBcLayJ70Iv4FXcfSI3a98rRchLcC6oXFxADRvAm5AYmqjIK+Thv8MYC/yjZCNu67A2k2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743974689; c=relaxed/simple;
	bh=kcLBmHUDELpVIjBDW7WOFfPs229RgQceNLXEbd1UJOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CkEwiZbNGMWan3r+1lMGGL135ZwVVgLnwG38t4K/Aeisqa0B+xKhXxwoq08Q0IvWAQE5eyOEetLmr3fqF1grENGYd0TUl9QhTXhiKS1JNPqkGI8kOvzJYQeOxsw1Vqi8Ylofj4CU1kkstMfocd5FpgTJ6CucRi61aSwuGvwVdBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=hXR1Cj6J; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 941EA103B92CE;
	Sun,  6 Apr 2025 23:24:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743974677; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=AmDn6RQJ+QRV6q6JMcajnOpUP8bbZFJKY8h5RYYtrj0=;
	b=hXR1Cj6JiEpHHtfFp5082ABIz3Ak8Om151NMhGXcN0eH+00EcXMRaWfTWSG4ICuq8+a6kk
	PTS24XASiBCImp0rsWts4wT8v0c/Slugz744qxWJRN1sbi4+u6/4baMRPLwQd8522KXcNN
	qo6OUWirQp7OJ3ZJHc2xC4X1VvNfUh6/Iu+Ex2LIK4o87Y2dDRieYlvDaDdFdMsh9eytzY
	3R5MwONrRpoDy+r/VhjddzNeqj92p2pnTavGmB7kWO2N0y0/DerCac0yZShc+CzNarlZ5U
	QfHW1q0jnpXP0b7+2htYYXjI4A1eYZZ4f1hJfC+v0s1Y6ANJ7Ahmt3nDB87Jvw==
Date: Sun, 6 Apr 2025 23:24:31 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] net: mtip: The L2 switch driver for imx287
Message-ID: <20250406232431.48e837e0@wsk>
In-Reply-To: <8f431197-474e-4cd5-9c3e-d573c3f3e6b5@lunn.ch>
References: <20250331103116.2223899-1-lukma@denx.de>
	<20250331103116.2223899-5-lukma@denx.de>
	<8f431197-474e-4cd5-9c3e-d573c3f3e6b5@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ACv8R=knW+t0ni5QKQO7U2=";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/ACv8R=knW+t0ni5QKQO7U2=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > +static void read_atable(struct switch_enet_private *fep, int index,
> > +			unsigned long *read_lo, unsigned long
> > *read_hi) +{
> > +	unsigned long atable_base =3D (unsigned long)fep->hwentry;
> > +
> > +	*read_lo =3D readl((const void *)atable_base + (index << 3));
> > +	*read_hi =3D readl((const void *)atable_base + (index << 3)
> > + 4); +}
> > +
> > +static void write_atable(struct switch_enet_private *fep, int
> > index,
> > +			 unsigned long write_lo, unsigned long
> > write_hi) +{
> > +	unsigned long atable_base =3D (unsigned long)fep->hwentry;
> > +
> > +	writel(write_lo, (void *)atable_base + (index << 3));
> > +	writel(write_hi, (void *)atable_base + (index << 3) + 4);
> > +} =20
>=20
> It would be nice to have the mtip_ prefix on all functions.

Ok.

>=20
> > +static int mtip_open(struct net_device *dev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	int ret, port_idx =3D priv->portnum - 1;
> > +
> > +	if (fep->usage_count =3D=3D 0) {
> > +		clk_enable(fep->clk_ipg);
> > +		netif_napi_add(dev, &fep->napi, mtip_rx_napi);
> > +
> > +		ret =3D mtip_alloc_buffers(dev);
> > +		if (ret)
> > +			return ret; =20
>=20
> nitpick: You might want to turn the clock off before returning the
> error.

Ok.

>=20
> > +	}
> > +
> > +	fep->link[port_idx] =3D 0;
> > +
> > +	/* Probe and connect to PHY when open the interface, if
> > already
> > +	 * NOT done in the switch driver probe (or when the device
> > is
> > +	 * re-opened).
> > +	 */
> > +	ret =3D mtip_mii_probe(dev);
> > +	if (ret) {
> > +		mtip_free_buffers(dev); =20
>=20
> I've not checked. Does this do the opposite of netif_napi_add()?

No, the netif_napi_add() is required here as well.

>=20
> > +static void mtip_set_multicast_list(struct net_device *dev)
> > +{
> > +	unsigned int i, bit, data, crc;
> > +
> > +	if (dev->flags & IFF_PROMISC) {
> > +		dev_info(&dev->dev, "%s: IFF_PROMISC\n",
> > __func__); =20
>=20
> You can save one level of indentation with a return here.

Ok.

>=20
> > +	} else {
> > +		if (dev->flags & IFF_ALLMULTI) {
> > +			dev_info(&dev->dev, "%s: IFF_ALLMULTI\n",
> > __func__); =20
>=20
> and other level here.

Ok.

>=20
> > +		} else {
> > +			struct netdev_hw_addr *ha;
> > +			u_char *addrs;
> > +
> > +			netdev_for_each_mc_addr(ha, dev) {
> > +				addrs =3D ha->addr;
> > +				/* Only support group multicast
> > for now */
> > +				if (!(*addrs & 1))
> > +					continue; =20
>=20
> You could pull there CRC caluclation out into a helper. You might also
> want to search the tree and see if it exists somewhere else.
>=20

The ether_crc_le(ndev->addr_len,=C2=B7ha->addr); could be the replacement.

However, when I look on the code and compare it with fec_main.c's
set_multicast_list() - it looks like a dead code.

The calculated hash is not used at all (in fec_main.c it is written to
some registers).

I've refactored the code to do similar things, but taking into account
already set switch setup (promisc must be enabled from the outset).

> > +
> > +				/* calculate crc32 value of mac
> > address */
> > +				crc =3D 0xffffffff;
> > +
> > +				for (i =3D 0; i < 6; i++) { =20
>=20
> Is 6 the lengh of a MAC address? There is a #define for that.

This is not needed and can be replaced with already present function.

>=20
> > +					data =3D addrs[i];
> > +					for (bit =3D 0; bit < 8;
> > +					     bit++, data >>=3D 1) {
> > +						crc =3D (crc >> 1) ^
> > +						(((crc ^ data) &
> > 1) ?
> > +						CRC32_POLY : 0);
> > +					}
> > +				}
> > +			}
> > +		}
> > +	}
> > +}
> > + =20
>=20
> > +struct switch_enet_private *mtip_netdev_get_priv(const struct
> > net_device *ndev) +{
> > +	if (ndev->netdev_ops =3D=3D &mtip_netdev_ops)
> > +		return netdev_priv(ndev);
> > +
> > +	return NULL;
> > +}
> > + =20
>=20
> > +static int __init mtip_switch_dma_init(struct switch_enet_private
> > *fep) +{
> > +	struct cbd_t *bdp, *cbd_base;
> > +	int ret, i;
> > +
> > +	/* Check mask of the streaming and coherent API */
> > +	ret =3D dma_set_mask_and_coherent(&fep->pdev->dev,
> > DMA_BIT_MASK(32));
> > +	if (ret < 0) {
> > +		dev_warn(&fep->pdev->dev, "No suitable DMA
> > available\n"); =20
>=20
> Can you recover from this? Or should it be dev_err()?
>=20

It was my mistake - of course there shall be dev_err().

> More later...
>=20
> 	Andrew


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ACv8R=knW+t0ni5QKQO7U2=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfy8Q8ACgkQAR8vZIA0
zr2K6gf+IeVFnsg+cnEFsWjR/QZHoQEjkMHlOs/vdNba2jlurd4lPwjLvpxs75Lw
o6ISVIdS1JlB/6kmNCSiL8Ktz0H77nfuz1IpJju2duk9TPTwq0/qoHbQqWaxWGVg
1++fPBxV4EYRfR2I4JXTHTGuPVoREgsCTGcd2sF1JUX5RLxjYg8phEd+LV7TpZnT
aIyh6gBIDZKfZ3hTpS73Dzkb+FIqt3EhRuPBX49Gq8ch69mXgEC9PXe0JTe5Xoww
W1P9HKOuUptjr/i+g6V1sQ9t8IGzMxaVme2Ya/TlR4S11+uX4mLZUJGg3Bbi6wVT
tKRaF1x3+3vfVWuSkSY+NiPr5q3aLw==
=eAzq
-----END PGP SIGNATURE-----

--Sig_/ACv8R=knW+t0ni5QKQO7U2=--

