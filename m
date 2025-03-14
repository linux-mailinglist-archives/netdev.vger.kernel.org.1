Return-Path: <netdev+bounces-174959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD8AA61A06
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C2B3B2952
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428CF204875;
	Fri, 14 Mar 2025 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug4sIOBC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08E2AEE1;
	Fri, 14 Mar 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978938; cv=none; b=mxiQmIdZDKQVwqb0v6UOAB2/fxF1ZVFVlibvs9ZZtHa6Y+ccjdMiwEuKzCubXRFCGB3xRe6gm7kHI7WhuXwyKQasCof6OJ2gL4vXbiyF0seq3m7+rTow3Y9SFXX5bQMHqJJOWrXxqgUM1Y8zLtb5Zn2xxRwn7rp0wuUhlulix94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978938; c=relaxed/simple;
	bh=6FXnnEH09QAZ8cazzLfIiksMA3P3FtrJqIeAvTlUtZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCgluKbo4MY3Zfqp0LthwmUM2q6WcpUIAF1R3LNJvA+u25lCqTWn9Mb86L5+DIaZs1z2rQ9fnwhKH7ADymUmWEXauFIGKESR85GSx/IZ+EDJSjBDPPED6Jjd8RHnnRrhtX4QnFwU/VWX+XUH2Fs2l3tjlBJTFkF+/pInXnpDfuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug4sIOBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355A6C4CEE3;
	Fri, 14 Mar 2025 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741978937;
	bh=6FXnnEH09QAZ8cazzLfIiksMA3P3FtrJqIeAvTlUtZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ug4sIOBCu/atbRHws0kDAWy+P5JRCWkjk10Zl3FLpFAtgKe9A5Uem7BJTId/TGUOU
	 j7vwrcb4rZJcwex9/ELOavYmCYBdGo5p0vvWxXrM0E1G4siGrk+myBlWzNZy5umxmq
	 PEBcZtM8OxpuaFmiPPVS10CjJFTLgFWfMofJK86xa31Ki67vsNJDHlZtIrVCx04EjD
	 0fGaMIt3VpbtboLeO/oQzxgqVc+vf9FAsjOLzCZcdgiHpF/YYFofa1zJQhV4gU3Cn/
	 dRqzB5ucYs9eEA2Ohfxd5/tzmh5ky4yShDRLraFXOHwAY8JSO7Hm5x8US02JVWHtEM
	 bN+S6ZWSr8APg==
Date: Fri, 14 Mar 2025 20:02:15 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: airoha: fix CONFIG_DEBUG_FS check
Message-ID: <Z9R9NxIsMAyUZFYf@lore-desk>
References: <20250314155009.4114308-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FZYNFFCFDJf0hCka"
Content-Disposition: inline
In-Reply-To: <20250314155009.4114308-1-arnd@kernel.org>


--FZYNFFCFDJf0hCka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The #if check causes a build failure when CONFIG_DEBUG_FS is turned
> off:
>=20
> In file included from drivers/net/ethernet/airoha/airoha_eth.c:17:
> drivers/net/ethernet/airoha/airoha_eth.h:543:5: error: "CONFIG_DEBUG_FS" =
is not defined, evaluates to 0 [-Werror=3Dundef]
>   543 | #if CONFIG_DEBUG_FS
>       |     ^~~~~~~~~~~~~~~
>=20
> Replace it with the correct #ifdef.
>=20
> Fixes: 3fe15c640f38 ("net: airoha: Introduce PPE debugfs support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index f66b9b736b94..60690b685710 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -540,7 +540,7 @@ void airoha_ppe_deinit(struct airoha_eth *eth);
>  struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
>  						  u32 hash);
> =20
> -#if CONFIG_DEBUG_FS
> +#ifdef CONFIG_DEBUG_FS
>  int airoha_ppe_debugfs_init(struct airoha_ppe *ppe);
>  #else
>  static inline int airoha_ppe_debugfs_init(struct airoha_ppe *ppe)
> --=20
> 2.39.5
>=20

--FZYNFFCFDJf0hCka
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ9R9NgAKCRA6cBh0uS2t
rEjOAP9PNYodICfGjmIM6RqqwfDUTqlRvi1GK0wpap1X8ufqJgEAl2iP+EBO7tAb
SxEklWiXoPTNumH+pUYGDB1aGt621wE=
=8zdq
-----END PGP SIGNATURE-----

--FZYNFFCFDJf0hCka--

