Return-Path: <netdev+bounces-188324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E6AAC2A5
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CD0522328
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5523327B4F4;
	Tue,  6 May 2025 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="hurx8WBq"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F448264619;
	Tue,  6 May 2025 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530963; cv=none; b=Gqq4GwDGsUpJunKhg0xkpN+XrmAXqPjpQ6DBDzufiXcr/elmGiP9QbXU2TaaBfCbByLa1yCeYxmFUfdYgXQjc5m6TOKj119A3xq/13kOzqV7s844aC1KaL006cT0tNEoaBLGGfrP6qoJ/HnvIiGZXuVvc8LmeEbFaUQJ/YjCTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530963; c=relaxed/simple;
	bh=Q7SgzbjlvLlZUK6DeEH74+v9+PnOd4uNSEl87Z3HBLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUCyl1AJU95IDoIAbULWw6fs7RglrZ5pXM3gzH5kNRSKKrnVX02YL/OXv3AVf4EjSf4fCrVvXc1LwjwT/P2JkE2NGOpszjonakYFNTBsQrMPySDIjgo7U83UDKFqibhQz+jxM2ey00memx+gY48P8R40aJ7DaohmlaKUe5KtE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=hurx8WBq; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A9411048C2EF;
	Tue,  6 May 2025 13:29:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746530958; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BBiJ1+QCWS5L7SfLI3J26hRoymbqxHjfgh/WBSrZqwI=;
	b=hurx8WBqW/XXpYxFxpUOwvu6RRiNWSAAJsDH1cSOQnQ6yEJQ4MLGC3DG0/u6rxLBkaBNpf
	Bf1mUsEt1d/e0nPXfkoi73VF1qcR+38Q1ZdgFqZLmbIMowU++Bx0VBJaHbsKSRQd0Lew0R
	xL1WK9LlvTAD4Aq3pWWe3yfr9FY8nblUb9w9icmMEBUU/W3UboZA8wozWy/iId53HP8uBV
	itRLGWVnnlZ5NRkmeR3SUaXB8izfTrKfk1CU0mhN7xco7Src88MEruS7iOzA36rQvFJTZG
	6lys/L1SM6IAxgKA0AT0Jqjw+CDEk4OrGUoz+3ICs9YjZElht7f0xQ0v5YbFxQ==
Date: Tue, 6 May 2025 13:29:14 +0200
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
Message-ID: <20250506132914.794416cc@wsk>
In-Reply-To: <3e91e070-24a2-4dab-bca5-157fea921bf0@redhat.com>
References: <20250504145538.3881294-1-lukma@denx.de>
	<20250504145538.3881294-5-lukma@denx.de>
	<61ebe754-d895-47cb-a4b2-bb2650b9ff7b@redhat.com>
	<20250506130438.149c137e@wsk>
	<3e91e070-24a2-4dab-bca5-157fea921bf0@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LEAL1RWHfMmtL2h5UAQq/+1";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/LEAL1RWHfMmtL2h5UAQq/+1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On 5/6/25 1:04 PM, Lukasz Majewski wrote:
> >> On 5/4/25 4:55 PM, Lukasz Majewski wrote: =20
> >>> +		/* This does 16 byte alignment, exactly what we
> >>> need.
> >>> +		 * The packet length includes FCS, but we don't
> >>> want to
> >>> +		 * include that when passing upstream as it
> >>> messes up
> >>> +		 * bridging applications.
> >>> +		 */
> >>> +		skb =3D netdev_alloc_skb(pndev, pkt_len +
> >>> NET_IP_ALIGN);
> >>> +		if (unlikely(!skb)) {
> >>> +			dev_dbg(&fep->pdev->dev,
> >>> +				"%s: Memory squeeze, dropping
> >>> packet.\n",
> >>> +				pndev->name);
> >>> +			pndev->stats.rx_dropped++;
> >>> +			goto err_mem;
> >>> +		} else {
> >>> +			skb_reserve(skb, NET_IP_ALIGN);
> >>> +			skb_put(skb, pkt_len);      /* Make room
> >>> */
> >>> +			skb_copy_to_linear_data(skb, data,
> >>> pkt_len);
> >>> +			skb->protocol =3D eth_type_trans(skb,
> >>> pndev);
> >>> +			napi_gro_receive(&fep->napi, skb);
> >>> +		}
> >>> +
> >>> +		bdp->cbd_bufaddr =3D
> >>> dma_map_single(&fep->pdev->dev, data,
> >>> +
> >>> bdp->cbd_datlen,
> >>> +
> >>> DMA_FROM_DEVICE);
> >>> +		if (unlikely(dma_mapping_error(&fep->pdev->dev,
> >>> +
> >>> bdp->cbd_bufaddr))) {
> >>> +			dev_err(&fep->pdev->dev,
> >>> +				"Failed to map descriptor rx
> >>> buffer\n");
> >>> +			pndev->stats.rx_errors++;
> >>> +			pndev->stats.rx_dropped++;
> >>> +			dev_kfree_skb_any(skb);
> >>> +			goto err_mem;
> >>> +		}   =20
> >>
> >> This is doing the mapping and ev. dropping the skb _after_ pushing
> >> the skb up the stack, you must attempt the mapping first.
> >> =20
> >>> +static void mtip_free_buffers(struct net_device *dev)
> >>> +{
> >>> +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> >>> +	struct switch_enet_private *fep =3D priv->fep;
> >>> +	struct sk_buff *skb;
> >>> +	struct cbd_t *bdp;
> >>> +	int i;
> >>> +
> >>> +	bdp =3D fep->rx_bd_base;
> >>> +	for (i =3D 0; i < RX_RING_SIZE; i++) {
> >>> +		skb =3D fep->rx_skbuff[i];
> >>> +
> >>> +		if (bdp->cbd_bufaddr)
> >>> +			dma_unmap_single(&fep->pdev->dev,
> >>> bdp->cbd_bufaddr,
> >>> +					 MTIP_SWITCH_RX_FRSIZE,
> >>> +					 DMA_FROM_DEVICE);
> >>> +		if (skb)
> >>> +			dev_kfree_skb(skb);   =20
> >>
> >> I suspect that on error paths mtip_free_buffers() can be invoked
> >> multiple consecutive times with any successful allocation in
> >> between: skb will be freed twice. Likely you need to clear
> >> fep->rx_skbuff[i] here. =20
> >=20
> > I don't know what I shall say now.... really...  =20
>=20
> I suspect my email was not clear. AFAICS the current code contains at
> least 2 serious issues,

Yes, I'm now aware of them - thanks for pointing them out.

> possibly more not yet discovered due to the
> patch size.
> You need to submit (at least) a new revision coping with
> the provided feedback.

+1


>=20
> Thanks,
>=20
> Paolo
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/LEAL1RWHfMmtL2h5UAQq/+1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgZ8ooACgkQAR8vZIA0
zr2tAQgA5Oa/FI5CP0dp8gtrzF6QxKFwfVdILQE2zYrz6dkRXmXfQA1Um8K2+VtR
uE3XbqDmvFtS6YsJHLhfeg9FUHZkvIn1HxBDDuzzg6dCU67S/3jt+qrjWhSjinMg
CV7A576tXJdZny51jmznNd2Y7rlcZFIfpQ8aAYrtW66Rhf0TICvCgwNw2ChUIAG1
GbxFjyQFE+JhO7zQerW+lv+kcaM9eh4zSMs96yCPf8svcCPsOFn1KZorvkI/Hpgc
stPRomsy+QshxpcwMdWLC0QOBy5OLa77S+NCNvTWEpYWl5RarwoENSOdFjwaoYYp
7B9Jpc2ZlPxAOcpKlnL4naqsHuxBoQ==
=5IfA
-----END PGP SIGNATURE-----

--Sig_/LEAL1RWHfMmtL2h5UAQq/+1--

