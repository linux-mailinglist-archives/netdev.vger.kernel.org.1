Return-Path: <netdev+bounces-172395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB2A54750
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D83A7A965B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8BD1F4188;
	Thu,  6 Mar 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL7ogPBm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E0B2E64A;
	Thu,  6 Mar 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255434; cv=none; b=nu+TgNMgrJk8+XX69iIDbYihGwH6lm3E6IfKZ/lC+9XDZbqeAJXbW/4JNk2uPOW5PVX1YhzMfuCCVwK0WHtsHnGiRDoWrMRJuu50h9A4EuA/2aDxHheJZuGEbYF/AQSljuxsIfmWjKUS+YbQEHokwZRw8BxjA3laTNcLQY3qCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255434; c=relaxed/simple;
	bh=Wbtc/VWtrwzW/JVi9BqzKa6DRXsMZV5G0xEJdfogr7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n75iGnQWlj22S2nbS/9KchTYm5am+kfnLb5qCNCGDX4xW2fqMM2oqbDdHTw8ZtZKXxS+CL6d8fAeUdIwmCy/G09lXbqXq+cKfOxYLI9QfF/Z7BmQnYxwFeweda+SnHblYhTogzSIsm6X/csCjTs4v5DkYww8j/3jphh3fI95k48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL7ogPBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EE8C4CEE0;
	Thu,  6 Mar 2025 10:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741255434;
	bh=Wbtc/VWtrwzW/JVi9BqzKa6DRXsMZV5G0xEJdfogr7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eL7ogPBmqNtZhXSP2IlPVYn13/1pqa/WpjYcZRaScouvKdz1xomjpm/Sj20/ICuIH
	 x6myFplC/GBDhmrOPh0MA5I9tMdR0TMSClxUncPXR7LaBCGt1+c5j+Wz7fLsdzAywj
	 gXWS/S1Cn6yqreVd99geuhCIFMjj3nsc+zqqxfYkT/3VxOTzQNk/2bRONIWle54j+S
	 yoeGpSja2USCNPp2aeSbAXP+e5jyCU3RBNkXxtyMegig5uUJqOogPgdwMAArXShMO5
	 JZTTOIw58PPdJZ3dQXeD9L2lrR5jNgjkVjDwf45K6jepKCHlrtvEyXiU14s0X+n2qq
	 23kVvHWO+KdMQ==
Date: Thu, 6 Mar 2025 11:03:51 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust entry in AIROHA ETHERNET DRIVER
Message-ID: <Z8lzBx-A3372P8Pv@lore-desk>
References: <20250306094636.63709-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5lTqbbBiqNaWNbWm"
Content-Disposition: inline
In-Reply-To: <20250306094636.63709-1-lukas.bulwahn@redhat.com>


--5lTqbbBiqNaWNbWm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>=20
> Commit fb3dda82fd38 ("net: airoha: Move airoha_eth driver in a dedicated
> folder") moves the driver to drivers/net/ethernet/airoha/, but misses to
> adjust the AIROHA ETHERNET DRIVER section in MAINTAINERS. Hence,
> ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about a brok=
en
> reference.
>=20
> Adjust the file entry to the dedicated folder for this driver.

Thx for fixing it, it was in my backlog.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 37fedd2a0813..f9d3ff8b4ddb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -726,7 +726,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for =
non-subscribers)
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> -F:	drivers/net/ethernet/mediatek/airoha_eth.c
> +F:	drivers/net/ethernet/airoha/
> =20
>  AIROHA PCIE PHY DRIVER
>  M:	Lorenzo Bianconi <lorenzo@kernel.org>
> --=20
> 2.48.1
>=20

--5lTqbbBiqNaWNbWm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ8lzBwAKCRA6cBh0uS2t
rAW3AP9Ap1HMYdHGy1e7oc/z4Mvd9W/lBms+ZnwVsLYo6Ql/AwD9Ezb0TReXGZzU
RbjBQYkv0msYfWFjjkurfgOZgwdj+Ac=
=QIY1
-----END PGP SIGNATURE-----

--5lTqbbBiqNaWNbWm--

