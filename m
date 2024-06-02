Return-Path: <netdev+bounces-100021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 608078D776C
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 20:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031011F211EF
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B95FB8A;
	Sun,  2 Jun 2024 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMXRB2nP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F031E4A2;
	Sun,  2 Jun 2024 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717351811; cv=none; b=iqnkVFqnmtykCKkl7t0QqZLuZTzCOava4KuISTJVB4UPU37H7pYNayi5/4ypK6es+UfHHRnOcAJbI+oqDi+ayUNUL9Lqs7fbTcyt28o7Q5qSiE3QxqtM11lQRJtoZ67Q9+Gigr+vDTfzNdK0e25LyJehtxGrPoWSVauGCn2XxiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717351811; c=relaxed/simple;
	bh=+2MHK2yMT+QKsyqaCKdYfGSKtVMLtPAzggfxfAy/6mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blJZ4MiG5HluMLtwbsY/23TJHntGutHPj3StfoHVE5nlcgCJF+Vu54dIVBg598G2HqN621MDJHc8O8K31i0ElzI8Zjibmk1bUTpfy1oS5mi1t9J0C4oDZLhUhLUSgwR4LPJ8lQYoBvB6Dcdl9cSQ+essUpJqY7KQY9O3CvvbLMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMXRB2nP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FD1C2BBFC;
	Sun,  2 Jun 2024 18:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717351810;
	bh=+2MHK2yMT+QKsyqaCKdYfGSKtVMLtPAzggfxfAy/6mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMXRB2nPmoDXEmw78Xp2j8KvSgFsayRwfNGzYQHtr3rVYV8XL9yyY0i5oLVuEjs/4
	 cY8X7VLaWfJ+MTMikL0+t/l8EpqULi2xC8cGf0mumpKOEypU0uc3QdnEJCN9QHMsGZ
	 TtXEoanspd5DhWx2ud7/3wQKJ08BMz3t96GuH6b8JrdcYg0wyMYH4CuW/17o7D3W5/
	 d30Yg32xUJ9bFMS8eOcOI3igakZ+1E9kpGDDGqvcPfjwAF3FIBJuZYLf6kx83ELvtw
	 5kWgBRsx1uE5jaNuPv5fegJ0Jf8sktv/gGbc2VRuqTCoQuVq9p91VSE8prGhTCfDCR
	 QLcBaqXvjKztQ==
Date: Sun, 2 Jun 2024 20:10:06 +0200
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
	benjamin.larsson@genexis.eu
Subject: Re: [PATCH net-next 3/3] net: airoha: Introduce ethernet support for
 EN7581 SoC
Message-ID: <Zly1fi5kr9YNo2yN@lore-desk>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <4d63e7706ef7ae12aade49e41bb6d0bb6b429706.1717150593.git.lorenzo@kernel.org>
 <9efb0c64-d3b2-478b-953e-94ef8be3ddec@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rMKqNu+NNvg9Cdc8"
Content-Disposition: inline
In-Reply-To: <9efb0c64-d3b2-478b-953e-94ef8be3ddec@lunn.ch>


--rMKqNu+NNvg9Cdc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +static void airoha_remove(struct platform_device *pdev)
> > +{
> > +	struct airoha_eth *eth =3D platform_get_drvdata(pdev);
> > +	int i;
> > +
> > +	debugfs_remove(eth->debugfs_dir);
> > +
> > +	airoha_qdma_for_each_q_rx(eth, i) {
> > +		struct airoha_queue *q =3D &eth->q_rx[i];
> > +
> > +		netif_napi_del(&q->napi);
> > +		airoha_qdma_clenaup_rx_queue(q);
> > +		page_pool_destroy(q->page_pool);
> > +	}
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(eth->q_tx_irq); i++)
> > +		netif_napi_del(&eth->q_tx_irq[i].napi);
> > +	for (i =3D 0; i < ARRAY_SIZE(eth->q_tx); i++)
> > +		airoha_qdma_clenaup_tx_queue(&eth->q_tx[i]);
> > +}
>=20
> You don't appear to unregister the netdev. remove() should basically
> be the reverse of probe().
>=20
>     Andrew

ack, I will fix it in v2.

Regards,
Lorenzo

--rMKqNu+NNvg9Cdc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZly1fgAKCRA6cBh0uS2t
rGnRAQDL+Z25OzOQ0PBS7Q4U+fs6OlcTqibJhISHTyD7t+RhwgD9F7EUM814UEW/
+o/GVe1SP1g9LG4cu0E1pVX9uw2XRgI=
=aNJq
-----END PGP SIGNATURE-----

--rMKqNu+NNvg9Cdc8--

