Return-Path: <netdev+bounces-193607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951E2AC4C61
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 12:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5404D16A976
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69C7255F26;
	Tue, 27 May 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="hVKcJoGL"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE624887A;
	Tue, 27 May 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748342714; cv=none; b=pP7K0trGM05EKH19AX+0KoNc8b2P/k5I+l18ATe8GdejilyVwgxvoc68/1OLGMuo8ZQI1pnESsnruaojylWP89wfCZNrpX+4EPc5M2MVJLdxG5Xw1mbCMNnouYQnCqRWDNsdqEKMLKUIdXXha5/e8vdb8OOu4s2wxPw4ztXhbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748342714; c=relaxed/simple;
	bh=DZRek0fypDGAuHORFoWyIKK8ZQOaWQ4cMJemoWuP3Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLtaZg8mNRPmHBZBdV7CMuSXmhYUQShFFE8ohjRlt9rfniRXQLGxlFVpU9HPtQU66rUKcf66dFfUOw34KjW1WaV6nEcJLrs0nIRqaM8n/Zt8MpN8Nqyt02M+kvltqfG8/sG6pg7Wdxf+F3xf3s8FI/pVUoskIq8Cxg2yH0wAEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=hVKcJoGL; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED1201039728C;
	Tue, 27 May 2025 12:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1748342709; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=CYl5P/HwzqOc69xueQ3SZGWwXPRhZuYRG9PQl2s53Ww=;
	b=hVKcJoGLJqXovMSPPk+8KTo1AJ4ZRJviwmFeJpVtolc/z0aB0Ts/ZIWCaBF4N4UEx0YLjJ
	x6rkh4r5W1u9s3EVEq4wOWEURKTF2SHeDLe+VwslHvsm4HbI523Z7zyegHn3t9ZRin7Exj
	wK0AYu1+rUQNUVAUoBt0kYTTTHRhwv45/mFqkBszi5YvO0vO611AoSMoX8v0eQMRU/tEbj
	c0ESnpshYXUpUgvnbNXH3OGh5YilUNtTKm5YMpjFnjTe+mEVWNLm4ykbm7O9PPt4EKNETu
	9AGwxgMLX3vfuwaUHzF/5+HXjAcbvVp4nPYS9bavzFXi72BzLo9RQRm/gErEYw==
Date: Tue, 27 May 2025 12:45:03 +0200
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
Message-ID: <20250527124503.2c33b5be@wsk>
In-Reply-To: <ec6487a8-277f-474b-b9ef-273a7f160604@redhat.com>
References: <20250504145538.3881294-1-lukma@denx.de>
	<20250504145538.3881294-5-lukma@denx.de>
	<61ebe754-d895-47cb-a4b2-bb2650b9ff7b@redhat.com>
	<20250513073109.485fec95@wsk>
	<ec6487a8-277f-474b-b9ef-273a7f160604@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x0CibV/49sytQrMnhEu.cIc";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/x0CibV/49sytQrMnhEu.cIc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On 5/13/25 7:31 AM, Lukasz Majewski wrote:
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
> >> the skb up the stack, you must attempt the mapping first. =20
> >=20
> > I've double check it - the code seems to be correct.
> >=20
> > This code is a part of mtip_switch_rx() function, which handles
> > receiving data.
> >=20
> > First, on probe, the initial dma memory is mapped for MTIP received
> > data.
> >=20
> > When we receive data, it is processed and afterwards it is "pushed"
> > up to the network stack.
> >=20
> > As a last step we do map memory for next, incoming data and leave
> > the function.
> >=20
> > Hence, IMHO, the order is OK and this part shall be left as is. =20
>=20
> First thing first, I'm sorry for lagging behind. This fell outside my
> radar. Let's keep the conversation on the new patch version, it should
> help me to avoid repeating this mistake.

+1

>=20
> /P
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/x0CibV/49sytQrMnhEu.cIc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmg1l7AACgkQAR8vZIA0
zr1MTQf/duDrLdfm82yHA91tF0QfoOm/ATV48YVaUyZ5+o9pkf5Smxkgalw0Yz6k
cvVrgg+sxKz4YhjostoVdGGBxHB2DtLhSOMPpJwNCXT9/QpuEQBebGow6WzKSAk9
LR0ECr8KKa1jmBnYOIBnB7yocMv35GM8yjosi0qgcjXNgaQInD2MnGuPk0wZuR59
EWbbzluqK95BxyaxsyvwFXCzXv+7eZqgWVOoENrESTakLtRH5yu4JBqriFhhVS5P
t4GS3tEjHLoGcZEQL1R0M+2hhjb+nWOi/oSIQ8t3+18Uafv0R/voN2sUeYV3QRnn
MnkLFCQXJtqfqssr36pL7OJiEW8hzg==
=rJLF
-----END PGP SIGNATURE-----

--Sig_/x0CibV/49sytQrMnhEu.cIc--

