Return-Path: <netdev+bounces-200577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8A7AE6256
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B9D3A54A0
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C077625DB13;
	Tue, 24 Jun 2025 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="jxIs7JgR"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877CB27BF7D
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760716; cv=none; b=kIF2ZBR/HxskrQELfePfpvZykGqdp8riuI6mVf6d33CH43irsIAkYva7tAX9wtJdghVT8e7NqePDzWuC0U8oCcq61PqkLRmsSdLuCNMM9r0H39cvaWCx6yiLaLVPJMWEUn/YGGyQy/uF7lJo67woT6i1NOuoxQeRfEGAYyjfKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760716; c=relaxed/simple;
	bh=2INQHEmIzTX4jZ7A8ZVTGPgn0BrTiwg4K84YKfbcEuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Khmex/CkW3ha2Hx/5kw5G/S5fEOoiFpLIJSOjYBIrCzcwq6aQ+vwXCSlwuYvAzAUo/dhekuHpRljPmSTZScAh4r50HDdFAnOWA13QsN7qI77zVuM2mHKIQxJHRgWf3rYAkBITCymwQvmhbj85mDWE59TJGkeQgxbQp2WScm8OKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=jxIs7JgR; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Xm90+mKVIW2QS2sVZjgP5E6bEANSY3DHxcTsOaS68zA=; b=jxIs7JgRwKn8NJLjDnlgkCCAoj
	lyVB5YTWxiA/HyVwT7Udk8ZeyyTDVOZIhziYQGuY7FE0buzzyQhPh8T/t0M51wXQt76d6e5YNq91B
	90A9YSr2JdnXkeNpL+E/sGFR8CCEWq8nwl2l+6t/BuST6TotbTwHvxxCKJXC01WgtEyG4Kn3fE2KV
	MpWM9OTVvk9+Jevnwe243+51V9mCJqVURAUtxByeIh/F76Zj6m2jQedM47sb3XDC7SXw5FKrwy826
	TJET7aHCn0DJt07LNNEonzoknypHVzQYvtjAA2XAag0vhYXtBTI0mbOTGj8PXq7qrTZEOoGpS/sbx
	VeaFm9aw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uU0aN-000YIb-28;
	Tue, 24 Jun 2025 18:25:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 24 Jun 2025 18:25:00 +0800
Date: Tue, 24 Jun 2025 18:25:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aakash Kumar S <saakashkumar@marvell.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, akamaluddin@marvell.com,
	antony@phenome.org
Subject: Re: [PATCH] xfrm: Duplicate SPI Handling
Message-ID: <aFp8_Be2qHTWmyvI@gondor.apana.org.au>
References: <20250624101516.1468701-1-saakashkumar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624101516.1468701-1-saakashkumar@marvell.com>

On Tue, Jun 24, 2025 at 03:45:16PM +0530, Aakash Kumar S wrote:
>
> @@ -2565,18 +2586,12 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
>  	err = -ENOENT;
>  
>  	if (minspi == maxspi) {
> -		x0 = xfrm_state_lookup(net, mark, &x->id.daddr, minspi, x->id.proto, x->props.family);
> -		if (x0) {
> -			NL_SET_ERR_MSG(extack, "Requested SPI is already in use");
> -			xfrm_state_put(x0);
> -			goto unlock;
> -		}
>  		newspi = minspi;
>  	} else {
>  		u32 spi = 0;
>  		for (h = 0; h < high-low+1; h++) {
>  			spi = get_random_u32_inclusive(low, high);
> -			x0 = xfrm_state_lookup(net, mark, &x->id.daddr, htonl(spi), x->id.proto, x->props.family);
> +			x0 = xfrm_state_lookup_spi_proto(net, htonl(spi), x->id.proto);
>  			if (x0 == NULL) {
>  				newspi = htonl(spi);
>  				break;
> @@ -2586,6 +2601,13 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
>  	}
>  	if (newspi) {
>  		spin_lock_bh(&net->xfrm.xfrm_state_lock);
> +		x0 = xfrm_state_lookup_spi_proto(net, newspi, x->id.proto);
> +		if (x0) {
> +			NL_SET_ERR_MSG(extack, "Requested SPI is already in use");
> +			xfrm_state_put(x0);
> +			goto unlock;
> +		}
> +

There is a quality of implementation problem here.  The double checks
are racy and may result in an "already in use" error even though the
specified SPI range is not fully used up.

Ideally the range check should be conducted under lock, or there should
be a retry if the insertion failed for an SPI range request.  I think
a retry would be the easiest with an additional check for signals
interrupting the request.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

