Return-Path: <netdev+bounces-189980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A527AB4B07
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 07:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA0719E7C0B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 05:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC131E5734;
	Tue, 13 May 2025 05:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="AyOcLNrg"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585A1E5716;
	Tue, 13 May 2025 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747114281; cv=none; b=CnkMQ0zqfHZuP6NGpef+VGZ9JywmOlbl5W2e2Z35mLFc268kFBeWZskcaONBh8n+/E+pdv4aUxfBE8ipz7cYoUv9jInBlU2l1p74AFCk6FdPL2aOu9WrJiCghdUPXUlXpDLZVbTMbH32hydHZlVP7EmJ7WTR4pp3JyZWZCsj4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747114281; c=relaxed/simple;
	bh=VtWsJ5jxF5ditBS+PzMpbSYMYidoIRW8fVv6/2U8zto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmyfvO/d/LoeN1pWf7dWidKQ+sWCL0ccXCyaQB1fqPPjgttwhwmb4F93zV4NcjjndZoZfpeHEOtNV/gnu0Y+HSj6NvIvpGB5YQITR69tQ40a1B1+Vx5WMOnN7B9EGTORsh252StcF2DjPtNMi7ynKpah3O0E+IuME7vaBCCmnRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=AyOcLNrg; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 257C0101F54F9;
	Tue, 13 May 2025 07:31:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747114276; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=AOoLpSlcMEI3x/GsGXxu7WykZ1/+A4nN7MIcD+H/+uQ=;
	b=AyOcLNrgYSbYvX4wYgUv7mAVOse9uZXTb2e+Unl8AVKvxYEBs1D9iqL+oee+kyOUJMQeh0
	p8TL9HQCLcGSTXMaQtY5jJwQO9bkdLR0tdV9uKejyTTl/I2RVZhXVcR+0gbCfS+TD3WQXt
	WQBIMODdESc0ckXiMmWXI9zZZ8FiJZX117MsatlhANrhd6M2Ev4JBfYNLP2oe3PV8hZE/t
	l4gLRaLVEmSC/r8zxEuRJDSVUEIRtFDUcsjYVJiXRvKd6xsn3/wSxqK2vNqEAS2vyP12ot
	jisN+XZssVfk7xllsfE8hzFW3p42yDJtW2K/NE5Ct+138mhoEwrK7BLTv/V02w==
Date: Tue, 13 May 2025 07:31:09 +0200
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
Message-ID: <20250513073109.485fec95@wsk>
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
Content-Type: multipart/signed; boundary="Sig_/NdXiA+ua5HLGGlUZSgHFP74";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/NdXiA+ua5HLGGlUZSgHFP74
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

I've double check it - the code seems to be correct.

This code is a part of mtip_switch_rx() function, which handles
receiving data.

First, on probe, the initial dma memory is mapped for MTIP received
data.

When we receive data, it is processed and afterwards it is "pushed" up
to the network stack.

As a last step we do map memory for next, incoming data and leave the
function.

Hence, IMHO, the order is OK and this part shall be left as is.

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

+1 - I will add it with v12.

>=20
> Side note: this patch is way too big for a proper review: you need to
> break it in multiple smaller ones, introducing the basic features
> separately.
>=20
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

--Sig_/NdXiA+ua5HLGGlUZSgHFP74
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgi2R0ACgkQAR8vZIA0
zr22dAf7BLxjZukHTC/6XVODiBt97iljTiAjzfkSLa9WXpEue6HV1GmD6tkt3wnJ
HdyON1QvZxs7JUywLFPzF6JgjFz6rxpTR/EpvshLzQOkyW991XrhmPyvHRvUCS2+
hddDVP0K+6Nbo2EEmlkq3383XOZwPtP93pYieNwkzml9NDgY7tdxwl6fumWOX05c
obTZQIo6zLfjjoK2alr3lqYke6CfmkJRl7o8/xhcu9Ju9hYIpJl1EPhePCn0ZcVq
Pmorr7BxDgT1h0M/DnxyRC1RfzIhSekjIaL6+ZBzBWM5mYXy/oDO8jk1q6pS1lPP
5WomLLwha1NwFG4Y8w+1Ll6gH++xTg==
=g2d0
-----END PGP SIGNATURE-----

--Sig_/NdXiA+ua5HLGGlUZSgHFP74--

