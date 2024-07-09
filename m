Return-Path: <netdev+bounces-110432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4256792C597
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 23:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E111C22B27
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 21:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC20182A6D;
	Tue,  9 Jul 2024 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zdqnlp3c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2181B86D4;
	Tue,  9 Jul 2024 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561287; cv=none; b=hKmNRwkQ0TcOGqAzfmtWthOwfFy10yTHN5I+3/FchRQ/HChmD6391ULfMnAkSGmKlg7FklJLCoG7XLNfT/ptyPiPsjxQsTB/EcO5D0L4C6xKcWiWexhhnH4Lzgz9QOExw7I2mZa8k5mgWWtVaXuU+xHAcLc0X+oYiWBuzmOfKms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561287; c=relaxed/simple;
	bh=SbPui1m3AbW2qMNDA/2hyBzJDO2nizxqPFCaBUQhvh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSb8KkwoL+pL0hk4NSEDREfzvrjUwAbb10LV2vj6qsl/80TgCKlXUIHMNP8F3TXmtG4oGYm1g92vat140XKbJy/MyQ1pGsLkEtHLpvhqhM4UFl2WBhO3oJI6Ur77LPwvFGuHx0n576lmYeHgi2iObNPUHarojAKkfOkz7Aj3XR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zdqnlp3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C15C3277B;
	Tue,  9 Jul 2024 21:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720561285;
	bh=SbPui1m3AbW2qMNDA/2hyBzJDO2nizxqPFCaBUQhvh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zdqnlp3cfXCg1vtf8kYrFslpTxMjoIIVaYuKHXr3o9Zo5c9CssG94rFfBYPK1mIMF
	 WGJQ0XQs1RiB6iccNf7Rd+irjH77f9A1PANeZ6XmWxre7vg6E9CiGUFGH+Xuu1ajvC
	 dgMDk4XcpvCfRbv4neg6FTrwjUuhFDrSDvQocb/Gi0WOOLENSTCgswHGlcgwDYjYkR
	 OBBMmrjp56WwlXBCYT5W7ifjmsMRBdwhQCLAVBeuGDGs2MdF3DBSDuaj7lVVz45nP9
	 m4qXXRurak2mcvRWmOd2Bm4tF8kJpE8JrWQKEM31nifkiocXZFUN7aOWMh98TAtNm9
	 Qq4w5krFTQHng==
Date: Tue, 9 Jul 2024 23:41:21 +0200
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
	sgoutham@marvell.com, arnd@arndb.de, horms@kernel.org
Subject: Re: [PATCH v6 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <Zo2ugWhc3wHqyKLq@lore-desk>
References: <cover.1720504637.git.lorenzo@kernel.org>
 <bafc8bcf6c2d8c2b80e6bafebe3661d795ffcbee.1720504637.git.lorenzo@kernel.org>
 <68a37d33-6155-4ffc-a0ad-8c5a5b8fed25@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cq3ZvBjA33dFjzfY"
Content-Disposition: inline
In-Reply-To: <68a37d33-6155-4ffc-a0ad-8c5a5b8fed25@lunn.ch>


--Cq3ZvBjA33dFjzfY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +static int airoha_qdma_init_rx_queue(struct airoha_eth *eth,
> > +				     struct airoha_queue *q, int ndesc)
> > +{
> > +	struct page_pool_params pp_params =3D {
> > +		.order =3D 0,
> > +		.pool_size =3D 256,
> > +		.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> > +		.dma_dir =3D DMA_FROM_DEVICE,
> > +		.max_len =3D PAGE_SIZE,
> > +		.nid =3D NUMA_NO_NODE,
> > +		.dev =3D eth->dev,
> > +		.napi =3D &q->napi,
> > +	};
>=20
> I think you can make this const.

ack

>=20
> > +static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device=
_node *np)
> > +{
>=20
> > +	port =3D netdev_priv(dev);
> > +	mutex_init(&port->stats.mutex);
> > +	port->dev =3D dev;
> > +	port->eth =3D eth;
> > +	port->id =3D id;
> > +
> > +	err =3D register_netdev(dev);
> > +	if (err)
> > +		return err;
> > +
> > +	eth->ports[index] =3D port;
>=20
> eth->ports[index] appears to be used in
> airoha_qdma_rx_process(). There is a small race condition here, since
> the interface could be in use before register_netdev() returns,
> e.g. NFS root. It would be better to do the assignment before
> registering the interface.

actually I check eth->ports[] is not NULL before accessing it in
airoha_qdma_rx_process():

	p =3D airoha_qdma_get_gdm_port(eth, desc);
	if (p < 0 || !eth->ports[p]) {
		...
	}

Moreover, in airoha_alloc_gdm_port(), I set eth->ports[index] pointer just =
if
register_netdev() is successful in order to avoid to call unregister_netdev=
()
on an not-registered net_device in the airoha_probe() error path. I guess w=
e can
even check reg_state for this:

	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
		...
		if (dev->reg_state =3D=3D NETREG_REGISTERED)
			unregister_netdev(dev);
	}

What do you prefer?

Regards,
Lorenzo

>=20
> These are quite minor, so please add to the next version:
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>=20
>     Andrew
>=20
> ---
> pw-bot: cr

--Cq3ZvBjA33dFjzfY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZo2ugQAKCRA6cBh0uS2t
rGN2AP0bH3wSTrIDAe85Rz4cnutNGUlzziiMIYqhemR1cSKNpwEAoNK2xWm5yS8V
emtoQ9fNnbYzEVx2KF1312Kt2xUh/QA=
=d8Yw
-----END PGP SIGNATURE-----

--Cq3ZvBjA33dFjzfY--

