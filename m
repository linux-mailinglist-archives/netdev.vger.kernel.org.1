Return-Path: <netdev+bounces-251176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0955BD3B03D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C736303DD32
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AFD29D269;
	Mon, 19 Jan 2026 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0qXyLKY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEAC1A316E
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839278; cv=none; b=t2GddCdmXPojxNjdJd9t9uj15DNuN+W8XsRv+e5Ek/RPUEPqHkT6RYcPFweToMCAQm0oEMtUrA/gFpy48HfTJQYVxZI/REzPDfNA5vZnVVs04wYWJC+bjxX0jUkjlBrThxnoEPr7EOYqawK51FJIQwCS0J0VTqSDV2SYckaHCvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839278; c=relaxed/simple;
	bh=lSfsVlCqyZvf6pA1XPog974EukldB/XYySTEmAm9AVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKoX8exDy5Qk9sKq7PUtxiWAytA5PucoHzQkXf6XqoJ2NzYDk+NLz8hBddiGKTIf2gn1A2pkLI7FTMLmcnfuZdypQ7mjkVOzguRbhazFfvxiP0/G+lm5vkB3+JVuIHKPSE3XRYYypUGT/yI3sPBrGVvluuSXMjReSZQV/C/Dyys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0qXyLKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A157FC116C6;
	Mon, 19 Jan 2026 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768839278;
	bh=lSfsVlCqyZvf6pA1XPog974EukldB/XYySTEmAm9AVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0qXyLKYlu8MTMpc+PeSAw5wrgSVGYKLiidFDfPtqfjHPKJ5owqrFpAQUytFgwaCx
	 Edof5E5tvwaMud5QVyJEgsRq4rAOpl01lKEJmFYfWW1c8GQNvd8hA80FkkmHSiPa5F
	 LOWX2t4UboNXW+DFSjaHME8VvT7MLmV8xuGW4dbpUY0wwv+FLf65blXLLtCkkjG3ex
	 pIsXuJPKVkKgpCx6gD8e70FCcuXRwG4bbJ+6fNrxeU/UtAQ8VH/vYAvwoLwyIr69RN
	 m6YciAeGPSU0wKIoIkhffEUIvRtouSRbBEmt9r9lcbTFkEgeIvri1io0PDDAWT8x5Y
	 G0BLP48bm4Kpg==
Date: Mon, 19 Jan 2026 17:14:35 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sayantan Nandy <sayantann11@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	sayantan.nandy@airoha.com, bread.hsu@airoha.com,
	kuldeep.malik@airoha.com, aniket.negi@airoha.com,
	brown.huang@airoha.com
Subject: Re: [PATCH net-next v3] net: airoha_eth: increase max MTU to 9220
 for DSA jumbo frames
Message-ID: <aW5Yay8rDupPfB-H@lore-desk>
References: <20260119073658.6216-1-sayantann11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J2jysX/UvlOutc68"
Content-Disposition: inline
In-Reply-To: <20260119073658.6216-1-sayantann11@gmail.com>


--J2jysX/UvlOutc68
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> The industry standard jumbo frame MTU is 9216 bytes. When using the DSA
> subsystem, a 4-byte tag is added to each Ethernet frame.
>=20
> Increase AIROHA_MAX_MTU to 9220 bytes (9216 + 4) so that users can set a
> standard 9216-byte MTU on DSA ports.
>=20
> The underlying hardware supports significantly larger frame sizes
> (approximately 16K). However, the maximum MTU is limited to 9220 bytes
> for now, as this is sufficient to support standard jumbo frames and does
> not incur additional memory allocation overhead.
>=20
>=20
> Signed-off-by: Sayantan Nandy <sayantann11@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
> v3:
> - Document that hardware supports larger MTU (~16K), but limit to 9220 fo=
r now
> - Target net-next (netdev/main) as this is a feature enhancement
> - No functional changes
>=20
> v2:
> - Clarified commit message regarding DSA tag overhead
>=20
>  drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index fbbc58133364..20e602d61e61 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -21,7 +21,7 @@
>  #define AIROHA_MAX_NUM_IRQ_BANKS	4
>  #define AIROHA_MAX_DSA_PORTS		7
>  #define AIROHA_MAX_NUM_RSTS		3
> -#define AIROHA_MAX_MTU			9216
> +#define AIROHA_MAX_MTU			9220
>  #define AIROHA_MAX_PACKET_SIZE		2048
>  #define AIROHA_NUM_QOS_CHANNELS		4
>  #define AIROHA_NUM_QOS_QUEUES		8
> --=20
> 2.43.0
>=20

--J2jysX/UvlOutc68
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaW5YawAKCRA6cBh0uS2t
rBEmAQDHxUyhIPGHm22GhCpC1m40BZZI353lz/CrFQ+Y1qkV/wD+LNlBeyE/03VJ
edunfoIYQPT9G31c6f8yeJVTeuFmKg8=
=KIMb
-----END PGP SIGNATURE-----

--J2jysX/UvlOutc68--

