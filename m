Return-Path: <netdev+bounces-193378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C656AC3B25
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9474189572F
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11AE1E04BD;
	Mon, 26 May 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Ktg+TdPV"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74226256D
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748246899; cv=none; b=QPOSGBBdYxGzHDhucO/wzNZmRkXTtMaG3x1a91jiEbEinfGSbyeUXhrZKD/GOOXobpH6UsVq/FtV57vqeXzsEFqFrEmnKZf7fla42ZkqmCk7MQpPMSaeavtIFmUFbSxF18koVG/Z4Cq+Vpd2W8JA/9gFJ9A2eu2uyCuJAjNLrXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748246899; c=relaxed/simple;
	bh=NjrSu41DIqIYC1xoIE1H38UjuFeQ5TXPKvYnDCKxhEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKAHC/4XsB3Sb+lG8OqXjHccuypCMV3VfGjesefWx0zhFErI4OkcuGKuM8QxubBpJ2vGy/yxDcr1iGygUqQUbGMTroJz0yleVyoW4U9ILuIxG8gd/y8GgI/BRL1C/Nj+Cb25EQaD9hhPvSqtXjAM0WVO1W3useR0zyVltAUbgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Ktg+TdPV; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xLvOKcQLzAxvJjVw+ID0kB4ZGrzFEsUDY1myztbFtYU=; b=Ktg+TdPVBl49F9bMzkKIKy7uep
	sKDb0jhpBDgStp/RnTtnyLrpJJyBH3+VUIuYmcW2onkTnEnTtx6t1P6SPLXx4h/uHSuejldqSBPYS
	tTVMUydvQCOxyJoiOYnxjebYdDN696FNsofXwisgnnahi5Xa/QxSrOLhlKGxSFScql7vozxEr/U4g
	Pqx5PyOPEg96rOs4N+dWHCVJSd5ZNwdRVRzKYJ3dED1Vqvwl7y9HAfX7NNn9B9xZWkM9T6RWxU6hd
	ZCWWg575BlCjVEU7XEoL5JtjS4c10sVeaOeFE3fy15/Sikw80XglXK9baoitEDHKYXLR/3QV32QaA
	FM89Aa/Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uJSsR-008zQ7-2T;
	Mon, 26 May 2025 16:08:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 26 May 2025 16:08:07 +0800
Date: Mon, 26 May 2025 16:08:07 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aakash Kumar S <saakashkumar@marvell.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, akamaluddin@marvell.com
Subject: Re: [PATCH] xfrm: Duplicate =?utf-8?Q?SPI_?=
 =?utf-8?B?SGFuZGxpbmcg4oCT?= IPsec-v3 Compliance Concern
Message-ID: <aDQhZ_ikHEt_pLn_@gondor.apana.org.au>
References: <20250526064322.75199-1-saakashkumar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526064322.75199-1-saakashkumar@marvell.com>

On Mon, May 26, 2025 at 12:13:22PM +0530, Aakash Kumar S wrote:
>
>  static inline unsigned int
> -__xfrm_spi_hash(const xfrm_address_t *daddr, __be32 spi, u8 proto,
> -		unsigned short family, unsigned int hmask)
> +__xfrm_spi_hash(const xfrm_address_t * __maybe_unused daddr, __be32 spi,
> +		u8 __maybe_unused proto, unsigned short __maybe_unused family,
> +		unsigned int hmask)
>  {
> -	unsigned int h = (__force u32)spi ^ proto;
> -	switch (family) {
> -	case AF_INET:
> -		h ^= __xfrm4_addr_hash(daddr);
> -		break;
> -	case AF_INET6:
> -		h ^= __xfrm6_addr_hash(daddr);
> -		break;
> -	}
> +	unsigned int h = (__force u32)spi;
>  	return (h ^ (h >> 10) ^ (h >> 20)) & hmask;
>  }

I don't think this patch is sufficient.  The logic around state
lookups need to be changed to exclude the destination address
comparison to achieve your objective.

It's also dangerous to unilaterally do this since existing deployments
could rely on the old behaviour.  You'd need to add a toggle for
compatibility.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

