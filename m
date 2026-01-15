Return-Path: <netdev+bounces-250188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F5BD24C50
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69F10300EBBC
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C916376BC2;
	Thu, 15 Jan 2026 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7NYU10p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A45932BF4B
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484406; cv=none; b=pLfApNPq+lIOVy3kqZnAi69/oTGJxUGH+QF4oPPY+to7vU+RKBaFji007k42xa/L1OD8zYaKUlNoKDewtOleYJx3iNwo9OI2WxlRyTBoY1SIGuN/bnlPHkP64pKBQETRvEyB5LfXmEI2KVKbijaxWEvPMtcuDhQ0cFY7vYPzLBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484406; c=relaxed/simple;
	bh=grQ06VHH5Zs834d5HBWaZvaELX00Hkf34g6d4HrTUww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZtBUPg2L0JxINiN2ZHVKty8dLNwkSuVFh+CJ/rPAmWQ1ciWsbLFX+8KxL/1Pwsbv4XgYLIR0t29Pm541wfLcvbnCXsN8eM/a0ywoYZbnYcLtZnTjJKNJZSLLnQdOQLVedtlCjdTDtud5bK0uZFUiLTm0yIAfQlWVFNum0qKRQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7NYU10p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4277C116D0;
	Thu, 15 Jan 2026 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768484406;
	bh=grQ06VHH5Zs834d5HBWaZvaELX00Hkf34g6d4HrTUww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7NYU10pwWmpzRf6cbU5f4xRtJXcgYUsYcqXeTPotviIVG3JHjElfxN8yO55+1qvk
	 1LJg46ESHuhVS9QY1FcaPDfwq+eKvizqalbyZ7YI5YzFCD/Y+YI65rZD2GrJoH/UN5
	 GXxErAArRg80HHv70Lf+rRXUfDBgQiKpJEjoF1IMWkpPqRwcwU4Lylh1V8JZqVQ/tV
	 lVtQklJQnTEYjbfWDVqq2OOssEdR6V91m7kOw+C1cRp3WuissUgUEzBFjS8L0+qLCp
	 7hNaMlHWR+70+tt8ld1w1tkmu19f+at0diFhljYG7/p7ixqx5eSppsugmknSXx5Tf3
	 I8Pcr0R9/Yvig==
Date: Thu, 15 Jan 2026 14:40:03 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sayantan Nandy <sayantann11@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	sayantan.nandy@airoha.com, bread.hsu@airoha.com,
	kuldeep.malik@airoha.com, aniket.negi@airoha.com,
	rajeev.kumar@airoha.com
Subject: Re: [PATCH] net: airoha_eth: increase max mtu to 9220 for DSA jumbo
 frames
Message-ID: <aWjuM3Ov0e45QyW4@lore-desk>
References: <20260115084837.52307-1-sayantann11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hTVUY/fjLDiK9ZZK"
Content-Disposition: inline
In-Reply-To: <20260115084837.52307-1-sayantann11@gmail.com>


--hTVUY/fjLDiK9ZZK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The Industry standard for jumbo frame MTU is 9216 bytes. When using DSA
> sub-system, an extra 4 byte tag is added to each frame. To allow users
> to set the standard 9216-byte MTU via ifconfig,increase AIROHA_MAX_MTU
> to 9220 bytes (9216+4).
>=20
> Signed-off-by: Sayantan Nandy <sayantann11@gmail.com>

I think the patch is fine, but here you are missing to specify this is v2
and this patch targets net-next. Moreover, please wait 24h before reposting
a new version of the same patch.

Regards,
Lorenzo

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

--hTVUY/fjLDiK9ZZK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWjuMwAKCRA6cBh0uS2t
rOa3AQC1RGQZqnY6BrNow/ISe6gGIq5sjzdfYKLQ0jWqs1VGxgD+JmqagFtjSGtr
U3SpJX78mwpooaSRhsohFIT1z+4WSwQ=
=OpV3
-----END PGP SIGNATURE-----

--hTVUY/fjLDiK9ZZK--

