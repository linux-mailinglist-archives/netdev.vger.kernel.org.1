Return-Path: <netdev+bounces-172396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC1EA5474B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43770167EE1
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E971F5845;
	Thu,  6 Mar 2025 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dza/0pup"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE97E9;
	Thu,  6 Mar 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255519; cv=none; b=kgE7nnG6oiRTj6vXPiXN92ZYIJFc88PmCHaImEheeqFjlsI8SeaE7BI9EAKG8DVRP1HhcpfOsZeVLw88tjH7RNjHfmmaKzLK6tPqTsLVY1wKHTVf8q7isP1bsuzAZy0/2RfjUUSkNTYD+tb8z/VNdivPZjiMM9eaeFO63aviIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255519; c=relaxed/simple;
	bh=DQX5lg3HEIkDGfIdaCFSobFn9jNWVFULDjoXWXHvXzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA9pZQXMH5hZJEYKFrWRLsD5moSwrcaaLN+/8LJN0rjuvOgUnaZBcFSTurg+Jvf25wKz40S6lZBAlN4V78vDd2fIIcSJW5qCZ0Bnw0/Do2/XI62heFK+oH/Uqtz0E9CdN92/cd/ukRh4S0Pq2AInMOKDTSEPq8DNjpJGndBwHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dza/0pup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78383C4CEE0;
	Thu,  6 Mar 2025 10:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741255518;
	bh=DQX5lg3HEIkDGfIdaCFSobFn9jNWVFULDjoXWXHvXzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dza/0pup0UtKgDNsoV7kH1Bxb3D4inSmojbSpyY8HhQSReuuy6MNyosFgweLQaK56
	 2bIbbHloa0QK/XCmDFzpuADNpbh/LrFlKMTIP/+V2HJojOR0J/qpX6JOoxZm+Iftw8
	 DKF1XYQBl/m1aB25xTIUdZUiSqsKxmR1tAa97rw0vze24u5ucmzoAL0segs9rPEjgC
	 Url/qLypDRF0zl45dvzrObMkJYOELtv61lb5/RVVLTGeHBFwrVj+1STaAEKDKW/hyk
	 YTueA+5s8kU9pA0KYH6PRO+HPRKfhKYLZuq3Jcmf79HNjPFbUILbvnvznfkAg66D8W
	 vmw9GJu8s6Sfw==
Date: Thu, 6 Mar 2025 11:05:16 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] net: ethernet: Remove accidental duplication in Kconfig
 file
Message-ID: <Z8lzXDc8V09hz7k9@lore-desk>
References: <20250306094753.63806-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XigoDoLbpCnqzKzj"
Content-Disposition: inline
In-Reply-To: <20250306094753.63806-1-lukas.bulwahn@redhat.com>


--XigoDoLbpCnqzKzj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 06, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>=20
> Commit fb3dda82fd38 ("net: airoha: Move airoha_eth driver in a dedicated
> folder") accidentally added the line:
>=20
>   source "drivers/net/ethernet/mellanox/Kconfig"
>=20
> in drivers/net/ethernet/Kconfig, so that this line is duplicated in that
> file.
>=20
> Remove this accidental duplication.

Thx for fixing it, it was in my backlog.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: fb3dda82fd38 ("net: airoha: Move airoha_eth driver in a dedicated =
folder")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  drivers/net/ethernet/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index 7941983d21e9..f86d4557d8d7 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -21,7 +21,6 @@ source "drivers/net/ethernet/adaptec/Kconfig"
>  source "drivers/net/ethernet/aeroflex/Kconfig"
>  source "drivers/net/ethernet/agere/Kconfig"
>  source "drivers/net/ethernet/airoha/Kconfig"
> -source "drivers/net/ethernet/mellanox/Kconfig"
>  source "drivers/net/ethernet/alacritech/Kconfig"
>  source "drivers/net/ethernet/allwinner/Kconfig"
>  source "drivers/net/ethernet/alteon/Kconfig"
> --=20
> 2.48.1
>=20

--XigoDoLbpCnqzKzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ8lzXAAKCRA6cBh0uS2t
rNAtAP9V+Q8UNILqo204AczQON+hWYW+Nxp3hNLk/WODmD+jVgEAyLr8ClMd7Y3l
NQlj7zTHYDTTZvu0Wg6HnRtRR6MiSww=
=vhTP
-----END PGP SIGNATURE-----

--XigoDoLbpCnqzKzj--

