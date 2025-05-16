Return-Path: <netdev+bounces-190936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BB5AB95B3
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 07:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BE41BA7F2D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 05:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9CE221F05;
	Fri, 16 May 2025 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="L+lVcNK2"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5021CC79;
	Fri, 16 May 2025 05:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374859; cv=none; b=uQsGt32udfrdReukCs4LLMHBgDkRndR6lAPt/bjmkXarlMWGzipYaXhrs8VlYZ8pYC5UCLZGDbylHFBQCUJu4EqogEpxLnjdNpZtAozAcQ4olDCL2GfDGTNAOt7DY3z7J1vRnsgcHwcAbJ/joM8WnT+bbFDpYSXY6zTVPCGp8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374859; c=relaxed/simple;
	bh=hE/2RZ1PYyTSAjwfUMOIzb+0X8Tc/g40NO/t/GM1M2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0VjSC/Er5NJnBcURGX5+Z3BdmPjcX8UWvt8RCai0SJcvfbxQfT+6hSSwAOHk1ijBPeaHbyMVExX/PCfH5OWtTub8fzvASenet5sg+SdzJJGbAXCCiVAaO/zyABQB/YDrPpXc8JsHdtJlDF//JvCyl6A7CNQC53Ld0akvUtZ/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=L+lVcNK2; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E9EE10397281;
	Fri, 16 May 2025 07:54:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747374847; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=npw7oUOa65omh2AfzcTC00iOX1CPSJ9Fh+nCscZc5Qw=;
	b=L+lVcNK2s55ncmt8CcZOpWwgETi+D4+e9Q492CJjTyHaxO3Lbj+ZxgebA7H1rfoNlYpaPH
	+l1IIIgb4wJruB3r8NWRzqWoxeMEV7meEznD71Lppv3BgMOJG8wY5nZuE/LkqSVyJS5JOE
	S5FXcErYtg2hiLD8BJT4a2LelygYHAKhVemONn/kvlllsS5IGUJREfGqZr2nk/Gbz31Q/l
	wvX1mhR7FbSD2+dl9xiSvSwUna5vLEQC9RQRX2t2isuA5soeVoyCR1EYcVI6zwiF3r6zKz
	zaQ8j9maRTqo2EKYnwJZ/DaTnrcakhzaxLVEIgh+MpGolmiWj+g5NslaPAgXSg==
Date: Fri, 16 May 2025 07:54:02 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v11 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250516075402.5104a0b6@wsk>
In-Reply-To: <20250513073109.485fec95@wsk>
References: <20250504145538.3881294-1-lukma@denx.de>
	<20250504145538.3881294-5-lukma@denx.de>
	<61ebe754-d895-47cb-a4b2-bb2650b9ff7b@redhat.com>
	<20250513073109.485fec95@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ex0Iw2w7PZxxqHuvJIb/PVl";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/ex0Iw2w7PZxxqHuvJIb/PVl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> Hi Paolo,
>=20
> > On 5/4/25 4:55 PM, Lukasz Majewski wrote: =20
> > > +		/* This does 16 byte alignment, exactly what we
> > > need.
> > > +		 * The packet length includes FCS, but we don't
> > > want to
> > > +		 * include that when passing upstream as it
> > > messes up
> > > +		 * bridging applications.
> > > +		 */
> > > +		skb =3D netdev_alloc_skb(pndev, pkt_len +
> > > NET_IP_ALIGN);
> > > +		if (unlikely(!skb)) {
> > > +			dev_dbg(&fep->pdev->dev,
> > > +				"%s: Memory squeeze, dropping
> > > packet.\n",
> > > +				pndev->name);
> > > +			pndev->stats.rx_dropped++;
> > > +			goto err_mem;
> > > +		} else {
> > > +			skb_reserve(skb, NET_IP_ALIGN);
> > > +			skb_put(skb, pkt_len);      /* Make room
> > > */
> > > +			skb_copy_to_linear_data(skb, data,
> > > pkt_len);
> > > +			skb->protocol =3D eth_type_trans(skb,
> > > pndev);
> > > +			napi_gro_receive(&fep->napi, skb);
> > > +		}
> > > +
> > > +		bdp->cbd_bufaddr =3D
> > > dma_map_single(&fep->pdev->dev, data,
> > > +
> > > bdp->cbd_datlen,
> > > +
> > > DMA_FROM_DEVICE);
> > > +		if (unlikely(dma_mapping_error(&fep->pdev->dev,
> > > +
> > > bdp->cbd_bufaddr))) {
> > > +			dev_err(&fep->pdev->dev,
> > > +				"Failed to map descriptor rx
> > > buffer\n");
> > > +			pndev->stats.rx_errors++;
> > > +			pndev->stats.rx_dropped++;
> > > +			dev_kfree_skb_any(skb);
> > > +			goto err_mem;
> > > +		}   =20
> >=20
> > This is doing the mapping and ev. dropping the skb _after_ pushing
> > the skb up the stack, you must attempt the mapping first. =20
>=20
> I've double check it - the code seems to be correct.
>=20
> This code is a part of mtip_switch_rx() function, which handles
> receiving data.
>=20
> First, on probe, the initial dma memory is mapped for MTIP received
> data.
>=20
> When we receive data, it is processed and afterwards it is "pushed" up
> to the network stack.
>=20
> As a last step we do map memory for next, incoming data and leave the
> function.
>=20
> Hence, IMHO, the order is OK and this part shall be left as is.

Is the explanation sufficient?

>=20
> >  =20
> > > +static void mtip_free_buffers(struct net_device *dev)
> > > +{
> > > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > > +	struct switch_enet_private *fep =3D priv->fep;
> > > +	struct sk_buff *skb;
> > > +	struct cbd_t *bdp;
> > > +	int i;
> > > +
> > > +	bdp =3D fep->rx_bd_base;
> > > +	for (i =3D 0; i < RX_RING_SIZE; i++) {
> > > +		skb =3D fep->rx_skbuff[i];
> > > +
> > > +		if (bdp->cbd_bufaddr)
> > > +			dma_unmap_single(&fep->pdev->dev,
> > > bdp->cbd_bufaddr,
> > > +					 MTIP_SWITCH_RX_FRSIZE,
> > > +					 DMA_FROM_DEVICE);
> > > +		if (skb)
> > > +			dev_kfree_skb(skb);   =20
> >=20
> > I suspect that on error paths mtip_free_buffers() can be invoked
> > multiple consecutive times with any successful allocation in
> > between: skb will be freed twice. Likely you need to clear
> > fep->rx_skbuff[i] here. =20
>=20
> +1 - I will add it with v12.
>=20
> >=20
> > Side note: this patch is way too big for a proper review: you need
> > to break it in multiple smaller ones, introducing the basic features
> > separately.
> >=20
> > Cheers,
> >=20
> > Paolo
> >  =20
>=20
>=20
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ex0Iw2w7PZxxqHuvJIb/PVl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgm0voACgkQAR8vZIA0
zr1KMwf+LbqivlaOayX4KF7BX15t/6+4VtMYl0vfPvtkhJUk16KHiMdq8jOJgd1a
mEMSCZbdP79VOHquqMUl4dhBBt5pxa9HvHNEprTYncHrAGptXNbLkXtYzW0FCa4g
p9/ajwh6N/Q7vl1sc41w5b48sTt1inLufkbRnSZqrW+J4eTLIzXmjJCCpot2zKgr
nN8j4gzHwd+auHQkCP3yGhWb9Vxu+F1OAKcw5ChUuMYHw7IuJfTG5EF335HyPY2D
NZXKP56M+xsXOdGd4jLXKrr56wiBogIThnfvaBIJBDI8mjAJN23QWsIh/RuNz5FG
0gaOjQiU1Jb2i6tJC4Vk7PP6CGVDJQ==
=2uYa
-----END PGP SIGNATURE-----

--Sig_/ex0Iw2w7PZxxqHuvJIb/PVl--

