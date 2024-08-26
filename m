Return-Path: <netdev+bounces-121831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B495EEA4
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 12:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398541F2307A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C414D2B8;
	Mon, 26 Aug 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEWld4+4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDEF14BFB0;
	Mon, 26 Aug 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668847; cv=none; b=vDQAdtbtX6XqiTQo4ngHKCEuV9pKFc9JmKBElsLHbpleRnTIF4A3hitjpPfrX5IY0QgSgOPJFgrV0PpO4GhFUnHhb/zc7GikWvDvCdIstYHNJIgOZqj/OH2OEKbL8i0RE+SrtqqsbC4LASiE2JWVFcyG+4+SXXrWjucc4tA9UZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668847; c=relaxed/simple;
	bh=hid4EhDWclsotpH44zFZgrvb2Nus2dMpx95VfampcvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOeoxc+enF9fmqWThO8H2T2kAcS1WooQPgbJOa1MFCq2SVyHnz2pA9ucEWKyND+eNUpXkNWJG9VnLb1DFzR/7kD0ErDQMBqlLREzS0Vi2ZoolpniEhf1m4XiPzyxKIvJevJE7kvVrlMbyuKWSxZTnX65qHXu2RaRisMPa2Ty5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEWld4+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF3BC51408;
	Mon, 26 Aug 2024 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724668847;
	bh=hid4EhDWclsotpH44zFZgrvb2Nus2dMpx95VfampcvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HEWld4+4f750dIuyASymEoKJ0pp0AijzkLKfwLXXu7WJde1lkxYcYUA3un7bRLh1i
	 Uo1wzlxcRk87MW/28f+bvpf3UdpZF8uglnCglqq8yny0UPhWD8fX77r+p5vDzNIqfc
	 tNVkYGBiDDc6JZkkM0Oz3OqHeieO+msyqHEc0IpyODAfKs2NjRpFQWvSYW/XgijHs+
	 LrprZxF3U8sYJUvLwHD/1D52U5C4DrF+NELp8zVzyjiGUbgyvhGMoLIJ2yRe1afZIe
	 wFBftp3iiXuIIyyGm1m2BZ8eU8aPplsIULx6YgWjZDePratF/GOSbZc/1YrK8zvKKe
	 GQ/7NfPl19inQ==
Date: Mon, 26 Aug 2024 12:40:44 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Liao Chen <liaochen4@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, chris.snook@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH -next 3/3] net: airoha: fix module autoloading
Message-ID: <ZsxbrCWR7VpElXoP@lore-desk>
References: <20240826091858.369910-1-liaochen4@huawei.com>
 <20240826091858.369910-4-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aOyroMajbWG5tUEk"
Content-Disposition: inline
In-Reply-To: <20240826091858.369910-4-liaochen4@huawei.com>


--aOyroMajbWG5tUEk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
>=20
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/mediatek/airoha_eth.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/eth=
ernet/mediatek/airoha_eth.c
> index 1c5b85a86df1..a80c1fae5c2d 100644
> --- a/drivers/net/ethernet/mediatek/airoha_eth.c
> +++ b/drivers/net/ethernet/mediatek/airoha_eth.c
> @@ -2715,6 +2715,7 @@ static const struct of_device_id of_airoha_match[] =
=3D {
>  	{ .compatible =3D "airoha,en7581-eth" },
>  	{ /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, of_airoha_match);
> =20
>  static struct platform_driver airoha_driver =3D {
>  	.probe =3D airoha_probe,
> --=20
> 2.34.1
>=20

--aOyroMajbWG5tUEk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZsxbrAAKCRA6cBh0uS2t
rM9JAP9RdTUsfjVfhfHPNS54DnIiyA5FBDNG+N3GYffQKIdqXgD9Fr7UEcQEfivt
s2yyVa7F9pW7inNKrtSw0GxhbY/sHw4=
=8z2j
-----END PGP SIGNATURE-----

--aOyroMajbWG5tUEk--

