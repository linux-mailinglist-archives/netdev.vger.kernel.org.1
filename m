Return-Path: <netdev+bounces-250018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 033D0D22F66
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 08:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A442C300B881
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 07:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB91283C87;
	Thu, 15 Jan 2026 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxUWpxsP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B4B27510E
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768463824; cv=none; b=at4L2LM7cqcrq4dLSZ5hcqhuheGJX94DFthPF9QAjp9mNGWed6mmDK7RFfXwEaYseBjGDNKZ/p5Xe7gPtwS7zC5vyAvaHgJf8LaAdcHqLjCZN83ZRZabCo30/+63t7Dpb3US0tXILGJslTe7ib57nB85aPu7MbJFbTkRlLlDnq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768463824; c=relaxed/simple;
	bh=z7M1gJSxco/n4ZsPehNhTapu74iwMGfHlhkpGIYRppU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlwhLoYfYvEX0aGcPT2cVVW7I+C2/DhMXxM8TzAtkjO21L62UdZza26htUHh0kugzwKk0p0uDscDbM5Q5LQN4TmKm/XPrp6/91ZnJNEBVh6gmYGnLmOIuDsS5GKEwG9hCNeMR2lZxVZ283+n5UrwepH/jY/UyG9L5OqlonPvXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxUWpxsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899D1C116D0;
	Thu, 15 Jan 2026 07:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768463823;
	bh=z7M1gJSxco/n4ZsPehNhTapu74iwMGfHlhkpGIYRppU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxUWpxsPOzHxOA0tGdbH62iRX4bmlHdJ4ghaK0B9VqEVDKqGzIE19FruKFYFVBVGK
	 cWQqk+drILJSEIGsBFzk26fMSBtflhxTa6ReUMaFeCtJ7SHcwzGsq5sgpmHIvMBV3d
	 Zzo3ZgeYY1cL8RzYLYSI9NTRn4yXyXpJZ0zF+mPwTsObq8xoOEOeTYaQT2Bc6/sB/Z
	 xFxQ8jF8NHhhmVBGvlFHNEY+uVDBPWrc49KP+AmWf8VfMGN3lyy7Qj5rnz4/WSMNRr
	 O+bbaBgjpVLIC3fc1Yy9oHKzR46sxzkO/Jccdz8C5Ra1ycdyXERKoyyHLIzm2EgpYM
	 hvs1kzMCSec1Q==
Date: Thu, 15 Jan 2026 08:57:01 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sayantan Nandy <sayantann11@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	sayantan.nandy@airoha.com, bread.hsu@airoha.com,
	kuldeep.malik@airoha.com, aniket.negi@airoha.com
Subject: Re: [PATCH] net: airoha_eth: increase max MTU to 9220 for DSA jumbo
 frame support the industry standard for jumbo frame MTU is 9216 bytes. When
 using DSA sub-system, an extra 4 byte tag is added to each frame. To allow
 users to set the standard 9216-byte MTU via ifconfig ,increase
 AIROHA_MAX_MTU to 9220 bytes (9216+4).
Message-ID: <aWidzQgGXpbht9zL@lore-desk>
References: <20260115064043.45589-1-sayantann11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="agj4UNEhb8R3CoY5"
Content-Disposition: inline
In-Reply-To: <20260115064043.45589-1-sayantann11@gmail.com>


--agj4UNEhb8R3CoY5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This change ensures compatibility with common network equipment and jumbo=
 frame configurations.

can you please provide more details?

Regards,
Lorenzo

>=20
> Signed-off-by: Sayantan Nandy <sayantann11@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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

--agj4UNEhb8R3CoY5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWidzQAKCRA6cBh0uS2t
rE5mAQDNH43QGKQqdK54O/WNSaz5NO5TROfHNgllhMJoY2J7gAEArEqFD7ASdBH5
PfGPjeC1j0qi9Ysjn4GYqMIXUyyIWAQ=
=JgeZ
-----END PGP SIGNATURE-----

--agj4UNEhb8R3CoY5--

