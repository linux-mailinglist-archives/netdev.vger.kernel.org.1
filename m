Return-Path: <netdev+bounces-249475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A58D19AE4
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6100303869F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1A82D6E5A;
	Tue, 13 Jan 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQEy7znO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2412D5950;
	Tue, 13 Jan 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316201; cv=none; b=NrfHfH1ibvsrO5s9S8WCIUL53Kat7n+xiBOMWicgXQtF/8IlyvBXrbkVVXG2zz8/5jOjJDzwtX2yu7yZvcKdGNkW1vqJTHskQwwKMJ85kOtCPpwx4KWWdTw+STVtVfEUU0kUncrIDrMSBFA9V3qO5yUkTP6yxRInFY7Cg1RHArI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316201; c=relaxed/simple;
	bh=mddwGk9E211pqqLNC87BrcxRIxMRADenQX665fNT+nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmJWllKxNMhA+jxOXnesHAYtuHTn5AIM9wppD/gJMdByaZrE5BFKAoijyN17Pn0+TutVOxip6FG94IS/2PKQgp0rodFcPlbgzV9tI/+f9GL6JGV8Nzldx7vRWnpm+r4wdhfKH/cbzI8klULQdTSLrRm6fzl8u/GUKPfLFIsNdoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQEy7znO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4680C16AAE;
	Tue, 13 Jan 2026 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768316201;
	bh=mddwGk9E211pqqLNC87BrcxRIxMRADenQX665fNT+nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQEy7znOEvUxQVJxKZIutih3qVH2s3AZ7kK6fZPcaUm9v3ikfbWiVeujHa7YYbOwf
	 HLkcSgTKMKZYjqRCgu4MtT2LzkWVtea1D0KE2bD3KXeCkWEP1ov/JAFQIki+qqS4yv
	 KQSJh4jbhl0E3RpHy4q1qlecCr6bqMgC6iVCuoXiCIMN4xX/D+65DxU47Xj7h/JHI2
	 +QpUSLZVdh4YQaS907kjL7ftjsMmPmyp8ZgmnmqMEosxO2u9caB21mCed5JEZfLz/E
	 SZX++KBa9Hj7Cxe1//y39fxHiELp6Bqet2nE7a0uK0igrZYrgiAZJAHYi/vGrua72Y
	 YawIfjvtPDD2g==
Date: Tue, 13 Jan 2026 15:56:38 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: airoha: implement get_link_ksettings
Message-ID: <aWZdJoELeXE4GtGY@lore-desk>
References: <20260110170212.570793-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F0XY5+WqgebaVLDU"
Content-Disposition: inline
In-Reply-To: <20260110170212.570793-1-olek2@wp.pl>


--F0XY5+WqgebaVLDU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Implement the .get_link_ksettings to get the rate, duplex, and
> auto-negotiation status.
>=20
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 315d97036ac1..00cae2833f09 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2803,6 +2803,7 @@ static const struct ethtool_ops airoha_ethtool_ops =
=3D {
>  	.get_drvinfo		=3D airoha_ethtool_get_drvinfo,
>  	.get_eth_mac_stats      =3D airoha_ethtool_get_mac_stats,
>  	.get_rmon_stats		=3D airoha_ethtool_get_rmon_stats,
> +	.get_link_ksettings	=3D phy_ethtool_get_link_ksettings,
>  	.get_link		=3D ethtool_op_get_link,
>  };

Tested-by: Lorenzo Bianconi <lorenzo@kernel.org>

Regards,
Lorenzo

> =20
> --=20
> 2.47.3
>=20

--F0XY5+WqgebaVLDU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWZdJgAKCRA6cBh0uS2t
rFqnAP90urg3GOxbCoFAMqLCFB/L1q7Qs9YnOIYJFgJgDjGEOgEApHYGEt+vKXfJ
hqWzAes4qvKgR6IWh7zYpF5BMJQ3pAI=
=6pTG
-----END PGP SIGNATURE-----

--F0XY5+WqgebaVLDU--

