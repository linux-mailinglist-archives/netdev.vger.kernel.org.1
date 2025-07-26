Return-Path: <netdev+bounces-210340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAB6B12C8E
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 23:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1A63AF227
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 21:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F037285C8A;
	Sat, 26 Jul 2025 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="c3NaRGG0"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBEB1F8723;
	Sat, 26 Jul 2025 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753564158; cv=none; b=NsBMrLV2wS7hyYdfyElFqREQl4oxWOKnnrPSkOMFLsoEhPOfDZfei5I+9kh0BgjzGdN1FPt/sbEVoKDVxLsolmoboMjuhJZZ0xG0GumGYcl3SCSd9QsPL5YhiYzMlS0blxr1UXbGTYuXwikgf42wFn6CvB4T599nSMrTvc6BwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753564158; c=relaxed/simple;
	bh=sXxHQ9fIaVtZCyKD6Q1O1pKMBD4vdvinWgLBpp6cyGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xs+z5Ppx1neSrZahnztQfiblk3/Yt/gGKAqz50LP3ag1/yj6u/Y0KgX/ruoDmel6/bKuHEM/68iyaqDf1juprn+qKLECvCouTjMdB90cz47qQfRyV/V+/19YgkLKFK3WJgk2+0yp2RFmR/QVfFZqC83/JHMqwyqMDo6T8w3c/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=c3NaRGG0; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2D2F10391E80;
	Sat, 26 Jul 2025 23:09:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753564152; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eNISZlrzl0Z3dZdoogVfl+lJdfeLWJhnuVzoA7+Ixkk=;
	b=c3NaRGG00BtAzqGFmo87hfj9z0wshVOQm8vOwNQFLymfIbbgscrohKzlZ0mF8STj2V0rSk
	5b7Y3etuydPLum0x2qmSTy6tirEHVQHrIlOuxMFfkzF9sw3c3XkiHkit73qdLQvgaAvGeP
	ID8cq003K+IVbx5VNFcQtZgJqHYYjeS/Rpsp+KRd+s3TFwtGXA/3cI1EgbR8/eJ/XmGFhM
	3uugmBQRDBIPQQqgh+SniVBET/izCY4uTLQdnBbsB+VmhfVQTSEft7IGss/ySBolLM43ii
	f2DGm7I6oLa2SQ7iTyEyEpP5T3W5ntH7nuIvrvq3vw1+sfBLhLVej9JgSJMspg==
Date: Sat, 26 Jul 2025 23:09:08 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v16 06/12] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250726230908.3d1e4c87@wsk>
In-Reply-To: <20250725151618.0bc84bdb@kernel.org>
References: <20250724223318.3068984-1-lukma@denx.de>
	<20250724223318.3068984-7-lukma@denx.de>
	<20250725151618.0bc84bdb@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IKCY4fFb7hT6jq/Pg_jxQM6";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/IKCY4fFb7hT6jq/Pg_jxQM6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Fri, 25 Jul 2025 00:33:12 +0200 Lukasz Majewski wrote:
> > +static void swap_buffer(void *bufaddr, int len)
> > +{
> > +	int i;
> > +	unsigned int *buf =3D bufaddr;
> > + =20
>=20
> nit: reverse xmas tree

Ok.

>=20
> > +	if (status & BD_ENET_TX_READY) {
> > +		/* All transmit buffers are full. Bail out.
> > +		 * This should not happen, since dev->tbusy should
> > be set.
> > +		 */
> > +		netif_stop_queue(dev);
> > +		dev_err_ratelimited(&fep->pdev->dev, "%s: tx queue
> > full!.\n",
> > +				    dev->name);
> > +		spin_unlock(&fep->hw_lock); =20
>=20
> As we discussed on previous revision you have many to one mapping
> of netdevs to queues. I think the warning should only be printed
> if the drivers is in "single netdev" mode. Otherwise it _will_
> trigger.

It will not trigger (as far as I understand the HW) because no matter
which interface will call this function, there will be next, available
descriptor provided to perform the transmission to switch port 0.

>=20
> BTW you should put the print after the unlock, console writes are
> slow.

+1

>=20
> > +static void mtip_timeout(struct net_device *dev, unsigned int
> > txqueue) +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct cbd_t *bdp;
> > +	int i;
> > +
> > +	dev->stats.tx_errors++;
> > +
> > +	if (IS_ENABLED(CONFIG_SWITCH_DEBUG)) { =20
>=20
> why are you hiding the debug info under a CONFIG_ ?=20
> (which BTW appears not to be defined at all)

The CONFIG_SWITCH_DEBUG is rather a "local" variable.

> Seems useful to know the state of the HW when the queue hung.
> You can use a DO_ONCE() if you want to avoid spamming logs

Hmmm.... Good point. I will rewrite it.

>=20
> > +	/* Set buffer length and buffer pointer */
> > +	bufaddr =3D skb->data; =20
>=20
> You should call skb_cow_data() if you want to write to the skb data.

This is the place where I do send data... (the *xmit_port function).

For reading I do have pool of pages and then I do copy the data to skb.

>=20
> > +static void mtip_timeout(struct net_device *dev, unsigned int
> > txqueue) +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct cbd_t *bdp;
> > +	int i;
> > +
> > +	dev->stats.tx_errors++; =20
>=20
> timeouts are already counted by the stack, I think the statistic
> is exposed per-queue in sysfs

Ok. I will remove it.

>=20
> > +		spin_lock_bh(&fep->hw_lock);
> > +		dev_info(&dev->dev, "%s: transmit timed out.\n",
> > dev->name);
> > +		dev_info(&dev->dev,
> > +			 "Ring data: cur_tx %lx%s, dirty_tx %lx
> > cur_rx: %lx\n",
> > +			 (unsigned long)fep->cur_tx,
> > +			 fep->tx_full ? " (full)" : "",
> > +			 (unsigned long)fep->dirty_tx,
> > +			 (unsigned long)fep->cur_rx);
> > +
> > +		bdp =3D fep->tx_bd_base;
> > +		dev_info(&dev->dev, " tx: %u buffers\n",
> > TX_RING_SIZE);
> > +		for (i =3D 0; i < TX_RING_SIZE; i++) {
> > +			dev_info(&dev->dev, "  %08lx: %04x %04x
> > %08x\n",
> > +				 (kernel_ulong_t)bdp, bdp->cbd_sc,
> > +				 bdp->cbd_datlen,
> > (int)bdp->cbd_bufaddr);
> > +			bdp++;
> > +		}
> > +
> > +		bdp =3D fep->rx_bd_base;
> > +		dev_info(&dev->dev, " rx: %lu buffers\n",
> > +			 (unsigned long)RX_RING_SIZE);
> > +		for (i =3D 0 ; i < RX_RING_SIZE; i++) {
> > +			dev_info(&dev->dev, "  %08lx: %04x %04x
> > %08x\n",
> > +				 (kernel_ulong_t)bdp,
> > +				 bdp->cbd_sc, bdp->cbd_datlen,
> > +				 (int)bdp->cbd_bufaddr);
> > +			bdp++;
> > +		}
> > +		spin_unlock_bh(&fep->hw_lock); =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/IKCY4fFb7hT6jq/Pg_jxQM6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmiFQ/QACgkQAR8vZIA0
zr01lwf9GsVk2YF8UuVzfEfWghkxAMjT42fDPAJABZxKQQiRLoDiTWsctU9lSOq3
dDKZvdScv+0smZgfukCgwdUUdQV20xV4178yo7weQuSg1jPPLonTQ7sZTbV1Eg0p
ayOpB7BPG1PBjqlVdvjGFu4sf/m6Mdwp5CQ4IAtQuY4PoTVqlIxfhRJ7Z7Vt/ZS3
kOosem9z7v6OSTAo0vwfERyfgkXn0Z+S2rPrg1zzm8MsOETmqTnXRDDolN8bRycW
oaFeF748G7QTVUlmE7Z3qnkFTDGm5DLCgF5AowfSCbbJFISfaOOvAb/IRTOJGYQQ
jHXaWPJCKfknuPWzQ+hVId/6QyhUQA==
=qmTS
-----END PGP SIGNATURE-----

--Sig_/IKCY4fFb7hT6jq/Pg_jxQM6--

