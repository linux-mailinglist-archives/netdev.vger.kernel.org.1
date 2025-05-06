Return-Path: <netdev+bounces-188311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30179AAC1FB
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4307F3B0456
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75AD279327;
	Tue,  6 May 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="EAAN14My"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68B278E49;
	Tue,  6 May 2025 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529494; cv=none; b=bzk2rD0sPBVUhzHwwiRVDsYCQagt1PU9EhjQdmF9SqOy6KmvRiVS+o+GLq05fXnyqfFtymQioMczbSJylkvJlFi+R2uP6AYIadk69IXprnP0Z1/kGbuE9z9oGAmwF9a1TJ6vCB6+DqtXqb/QewW2g9j5kV5Bqsk35cMyKMRGwJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529494; c=relaxed/simple;
	bh=pjPSBZN/Mfk5jqUTuqEyMQU0j98SWAtl2iKUPD9duZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGby3zc6+oXRBc84I6v5SFScXIwZYNs3vtZ1ptZ89M0zykPdaek0DmxLQyYnKnpUr02J2KeFEtgB8gjcPdlln1a6IExyJaCUBvlFH0d1cASxOduybZO0Z+xCGhLEtCsgaoJdIXScnsCcQfKU+dLV3VypdWxVXmTfi8JfLU1uMO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=EAAN14My; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A24331048C2EF;
	Tue,  6 May 2025 13:04:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746529483; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xoo6sbESeyMu4C1VAqN+/dYdjb4WLdeB4YQBhu0GSeE=;
	b=EAAN14MyA20btevFZPvu6BMNnnlFaTyQAnW6z0GPRjzZk3Yi2rmN7FPCyS3PA2YvBQj3sl
	FNhgRG9NVNpLKa+zBxYxtk+GbhVTaeScgVPKvzaRoM8/lYbWfq48kxtIijn92+jzPIPQiw
	l8Ba8h9SsikRqx7ilXFTkrWNwrxmQkgXJJsTvkqt8iXiBEjUebFgo8lE6dqSf0EmESvUbF
	cuOoIr0GteTs8hpT8shefM/KbYS8NHPRacoqlZW7Td93crdUK2o4dyjmO/6NJqB3PzqjYJ
	3g0flqLo00vwJmk+yY/YB+O00BGgPi1JAIzGH04jBGJF+8NKlC7l/yjPPvkNCA==
Date: Tue, 6 May 2025 13:04:38 +0200
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
Message-ID: <20250506130438.149c137e@wsk>
In-Reply-To: <61ebe754-d895-47cb-a4b2-bb2650b9ff7b@redhat.com>
References: <20250504145538.3881294-1-lukma@denx.de>
	<20250504145538.3881294-5-lukma@denx.de>
	<61ebe754-d895-47cb-a4b2-bb2650b9ff7b@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jzWygP56FGIH1XjAZKtG7zv";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/jzWygP56FGIH1XjAZKtG7zv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On 5/4/25 4:55 PM, Lukasz Majewski wrote:
> > +		/* This does 16 byte alignment, exactly what we
> > need.
> > +		 * The packet length includes FCS, but we don't
> > want to
> > +		 * include that when passing upstream as it messes
> > up
> > +		 * bridging applications.
> > +		 */
> > +		skb =3D netdev_alloc_skb(pndev, pkt_len +
> > NET_IP_ALIGN);
> > +		if (unlikely(!skb)) {
> > +			dev_dbg(&fep->pdev->dev,
> > +				"%s: Memory squeeze, dropping
> > packet.\n",
> > +				pndev->name);
> > +			pndev->stats.rx_dropped++;
> > +			goto err_mem;
> > +		} else {
> > +			skb_reserve(skb, NET_IP_ALIGN);
> > +			skb_put(skb, pkt_len);      /* Make room */
> > +			skb_copy_to_linear_data(skb, data,
> > pkt_len);
> > +			skb->protocol =3D eth_type_trans(skb, pndev);
> > +			napi_gro_receive(&fep->napi, skb);
> > +		}
> > +
> > +		bdp->cbd_bufaddr =3D dma_map_single(&fep->pdev->dev,
> > data,
> > +						  bdp->cbd_datlen,
> > +						  DMA_FROM_DEVICE);
> > +		if (unlikely(dma_mapping_error(&fep->pdev->dev,
> > +					       bdp->cbd_bufaddr)))
> > {
> > +			dev_err(&fep->pdev->dev,
> > +				"Failed to map descriptor rx
> > buffer\n");
> > +			pndev->stats.rx_errors++;
> > +			pndev->stats.rx_dropped++;
> > +			dev_kfree_skb_any(skb);
> > +			goto err_mem;
> > +		} =20
>=20
> This is doing the mapping and ev. dropping the skb _after_ pushing the
> skb up the stack, you must attempt the mapping first.
>=20
> > +static void mtip_free_buffers(struct net_device *dev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct sk_buff *skb;
> > +	struct cbd_t *bdp;
> > +	int i;
> > +
> > +	bdp =3D fep->rx_bd_base;
> > +	for (i =3D 0; i < RX_RING_SIZE; i++) {
> > +		skb =3D fep->rx_skbuff[i];
> > +
> > +		if (bdp->cbd_bufaddr)
> > +			dma_unmap_single(&fep->pdev->dev,
> > bdp->cbd_bufaddr,
> > +					 MTIP_SWITCH_RX_FRSIZE,
> > +					 DMA_FROM_DEVICE);
> > +		if (skb)
> > +			dev_kfree_skb(skb); =20
>=20
> I suspect that on error paths mtip_free_buffers() can be invoked
> multiple consecutive times with any successful allocation in between:
> skb will be freed twice. Likely you need to clear fep->rx_skbuff[i]
> here.

I don't know what I shall say now.... really...=20

>=20
> Side note: this patch is way too big for a proper review: you need to
> break it in multiple smaller ones, introducing the basic features
> separately.
>=20

This code is a basic version of the driver as discussed on March with
the community (Andrew).

It provides the basic functionality - like separate ports support and
then, if required, configures the IP block to perform L2 switching in
HW.=20

> Cheers,
>=20
> Paolo
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/jzWygP56FGIH1XjAZKtG7zv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgZ7MYACgkQAR8vZIA0
zr1SGgf/X4lTSbA5wV/GRygSxbZlIT0eA/yxbGzZMIHf7CmhmX20nnuSJN6B51s2
pqBZzQ6lcB8krbIdDTFJ1/W4xeUTeW5SZSI2UCXt6IlimlLwN5NkV3R+QBKEYOuK
bjHWjaafO8fSZtmvX67xuiSmBTtKDjLKGY95M0dIp+vahKvru1Fm/mwZL56xHQzR
yBrMeVkjFTttMxkIHdbxXTL4LyCefczvGGIiEHMBb/o0UTZzk2bnPeUKVW23/zd+
gUstiifHLosnY9DB/iIhR9kNCwHQGOwpp5VYWKSzG8fdU/ttDgmECQuAqMPncx0T
KEKJrQEQUIUNYoZ/4C1nSAM0N6Oh3w==
=NnK5
-----END PGP SIGNATURE-----

--Sig_/jzWygP56FGIH1XjAZKtG7zv--

