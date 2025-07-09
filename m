Return-Path: <netdev+bounces-205365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF1EAFE54C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BF65480B2
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090628A716;
	Wed,  9 Jul 2025 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ZOFR5QYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D565628A701;
	Wed,  9 Jul 2025 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055706; cv=none; b=INjOdasfwC75uD5G37D+bWBmDl5xzHE3j6GP9HLdJPrZ+nR3rYerhOE0AoZKPAo+Ij7VBy1hrTF4/l8a1hGV6F+MREBN3M1CAs97FbSzj7olfYggDRGmFsWOlR6Px+zj6a9dBCfbw9OFF8xjR7CKtikH7gB/Y9P9yCXc+RDN4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055706; c=relaxed/simple;
	bh=n4/DC3bhdUZoFTEoFep2p7ibhgZD9ZHc56z5gU/C1Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CD/auQ331q0qnZKW6P8uwELIqeBP+L5wRpXYbCuRApBuRFm517YikDaSuQWGkgEcR63L4mUSSapMAYRbe7iS4mfv/tINts+ljx28cc/GRPOHQSDaUP1WNdUgkRnTKjz7Xmyi3JqU1Di/JkYQWoPqiFLOeB8z8apn87PMo8HoxnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ZOFR5QYJ; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86578103972A7;
	Wed,  9 Jul 2025 12:08:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752055701; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=FsxQbQPIJsaYTNOu6ABUMe0d1muypWFSA2FGjsr9hv4=;
	b=ZOFR5QYJmEImw0t8AqiKiZi5hRhUsSDtDlUVGIS/tUYksC4yoQ27YObM0jcDNKmO4vuUnH
	pdj8Z7iZN+40EH8d9HeL2x7deLr2PBODbaRgerSiLocF5B6C8AnLAYlY6ZQXoFIXeNHmM4
	PDk8LbWwrGlZmWNFtFU7x/BTVfF/ZHH/f8RuBrLOUkkoUbWZTP2Ew2nJki3o2zoRaQb86W
	3YE44lWolkv7qhe8wPGRebTXD4bzsyYaTFmZsAx1vjvn46ZzK1g/vFBfoDSHbKiyd0cdLe
	0EsKGZENUVrx6pJbJQ8lGmKaW6ruKtHDitD3pifYamAk7ljyesoF3NGy6pRD1w==
Date: Wed, 9 Jul 2025 12:08:16 +0200
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
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v14 06/12] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250709120817.5b2f631a@wsk>
In-Reply-To: <ea22a546-9381-48c3-8bb6-258fdd784ca3@redhat.com>
References: <20250701114957.2492486-1-lukma@denx.de>
	<20250701114957.2492486-7-lukma@denx.de>
	<ea22a546-9381-48c3-8bb6-258fdd784ca3@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kSh+3R=zs/0/CbqzphcKx.b";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/kSh+3R=zs/0/CbqzphcKx.b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On 7/1/25 1:49 PM, Lukasz Majewski wrote:
> > +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> > +					struct net_device *dev,
> > int port) +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	unsigned short status;
> > +	struct cbd_t *bdp;
> > +	void *bufaddr;
> > +
> > +	spin_lock(&fep->hw_lock); =20
>=20
> mtip_start_xmit_port() runs with BH disabled. The above lock variant
> is inconsistent with what you use in patch 4.

I've looked into the fec_main.c driver. They use for TX path
__netif_tx_lock(nq, cpu); which is a simple spin_lock(). I've followed
the same approach (as _irqsave() seems to be an overkill).

This function (mtip_start_xmit_port()) is call as a callback from:
.ndo_start_xmit (member of struct net_device_ops).

IIRC net core code provides locking on this call anyway.

> Please be sure to run
> tests vs the next iteration with CONFIG_PROVE_LOCKING enabled.

This is already enabled. Locking in this driver is a bit special, as
one uDMA is used for both ports... (unlikely as in fec_main.c).

>=20
> /P
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/kSh+3R=zs/0/CbqzphcKx.b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhuP5EACgkQAR8vZIA0
zr2DCAgAxD7rrFXIyi+rHYv1bwydkkv0xAPwNNg4ilaG0hVeKYG1argzJUIBwp1E
Oo/EvG2HUoBs/I83nrGq+Uk5SX6R4zqDIx/iYu+/V/9hll06UV6MmtdNW772+LRD
slkfHgqjAAiVSfGvE1iUPZc8nkR7+0foXlv/dIeQWaYoROg2dQtK/p+X8SUMe914
ojjlmPsxPPIbfIclJc+lIqQgrJbme2z4EYldIjK+aTfjiRtAFdnMdnCUjtqw5slO
MpSrlAYs00wS4RS+KH+Zlp12ief5Zaw4h5H2vfX65p/2pV84RBAT9E6SL7ZC2rsh
TYfU75uh2iv8ow1RM40r+MrWqaOCNg==
=f3nq
-----END PGP SIGNATURE-----

--Sig_/kSh+3R=zs/0/CbqzphcKx.b--

