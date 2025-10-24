Return-Path: <netdev+bounces-232525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4BBC0638E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E703AB2F7
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7946315D21;
	Fri, 24 Oct 2025 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZZwMPoI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE142F39C1;
	Fri, 24 Oct 2025 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308559; cv=none; b=oVmgX2TGsUqCOD90xHbW9klIk5Y1EHHg/fcB5N5vNmKZGLOvLyLDoFiM7y3jc9yB2dU0/n2XA4ocP/UPmMHezn9Vjc6NXWo7HXX5QFla/txIY2xXp2mLXTSbVFIrTfAlvlAwhrg01dEXk75McYCNN6W1Qu6NifMk6LHcJW9sqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308559; c=relaxed/simple;
	bh=qTx04iEbOhzfAAE0oGbIBuQx0pHVs8rGV9hEwJGbdr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rD6Ar2BGcthd4VWleaaPrUNTlSGnkKtEybGB7AidPShpMOoTN8I67PDekZIAHVzcfE8Wn3xyaRYke/FMw+QPXQ2ffZME7N/msldryWE+El6CgUcfC9DJsWNaiY53uBTQlLyR4858rZIuT8ejDxTl5+Hs2clj1EDXq8cvMXBhAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZZwMPoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89CCC4CEF1;
	Fri, 24 Oct 2025 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761308559;
	bh=qTx04iEbOhzfAAE0oGbIBuQx0pHVs8rGV9hEwJGbdr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZZwMPoI4s/dkfoY7KAucgUs/9klMClinqSNfZ+lPbew2rPPkkTZkcpwCsq4iEwSr
	 GU7a4I/9UE+bWIb3ZWgiZqbskXRY+DfPUO4pAiIyQ+EpAdHUnPcSm1Y/QWWFSN9IlP
	 guli5OJ9WNAF5ENb/zGrkG+J6g3a3A/wufa+MqBAQPQBUL8L/dYoBLjSfQQXNdI9zM
	 6/squULZR4gVKo5ZBftSemMSq8dtlN8GL4P1rTvlq4PB73Lk5u09iQc3iFCvTFhZkS
	 SMOr+80cTM6WlMF86IGL2Lh8Fb+XOz7cfBeljLJyvkQi1u4dVCOvNG2SufSislaEIt
	 ZvOQSGGnuLEEA==
Date: Fri, 24 Oct 2025 14:22:35 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Fix a copy and paste bug in probe()
Message-ID: <aPtvi1hwDKOZH3vB@lore-desk>
References: <aPtht6y5DRokn9zv@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="azbuYC81tseTLIZm"
Content-Disposition: inline
In-Reply-To: <aPtht6y5DRokn9zv@stanley.mountain>


--azbuYC81tseTLIZm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This code has a copy and paste bug where it accidentally checks "if (err)"
> instead of checking if "xsi_rsts" is NULL.  Also, as a free bonus, I
> changed the allocation from kzalloc() to  kcalloc() which is a kernel
> hardening measure to protect against integer overflows.
>=20
> Fixes: 5863b4e065e2 ("net: airoha: Add airoha_eth_soc_data struct")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 8483ea02603e..d0ef64a87396 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2985,11 +2985,11 @@ static int airoha_probe(struct platform_device *p=
dev)
>  		return err;
>  	}
> =20
> -	xsi_rsts =3D devm_kzalloc(eth->dev,
> -				eth->soc->num_xsi_rsts * sizeof(*xsi_rsts),
> +	xsi_rsts =3D devm_kcalloc(eth->dev,
> +				eth->soc->num_xsi_rsts, sizeof(*xsi_rsts),
>  				GFP_KERNEL);
> -	if (err)
> -		return err;
> +	if (!xsi_rsts)
> +		return -ENOMEM;
> =20
>  	eth->xsi_rsts =3D xsi_rsts;
>  	for (i =3D 0; i < eth->soc->num_xsi_rsts; i++)
> --=20
> 2.51.0
>=20

--azbuYC81tseTLIZm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaPtviwAKCRA6cBh0uS2t
rPipAP9ULxOBgv2wFtLbEDmV13eMnbOkkxwrAX135INBNPEm7gD/RJ5HNXgRC5fa
73KCPBdoSt5hEOBCmw1Rf7+x2TR7TAM=
=ScI+
-----END PGP SIGNATURE-----

--azbuYC81tseTLIZm--

