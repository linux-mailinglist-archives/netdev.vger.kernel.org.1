Return-Path: <netdev+bounces-198969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB21ADE76A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9643AD5B0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D46D283FFB;
	Wed, 18 Jun 2025 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="TvUNK0A7"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E40283FEA
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239909; cv=none; b=hoxwP66/68nG9B6JEMPKCt8HymOe0nu7I0iisEWEJp5SF7+llIPM2OZddJQwxd/yEwhCLtRtsnAkR0eJBo84YGNPBjS7k6gPczLKH1F/dQMGrDkEuK5xbXHDVeWB5drvSAHXNiTLTthXvQv75PPS+sgXPSZ7Z8eWVDYt31vkJX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239909; c=relaxed/simple;
	bh=RHL5A5Erl4nv0fUbzWe7NYmNnwzLlcApurU44zQfnfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsGWOc8y1c2LolgNmcEgXKTU6gOhz5qBzp3bVvS5q47dF9KRVZe7Bom+UCxYKfP2Vta2Clhecb/29MvlrEytmAJ2KmsNQn2v90qkFcQM5gGH3i1is/vfghF/KdmEf2Qw2LYWgYspnpY6h0nGqGAvOEyKKvGQBTjB4NaUbzM2yiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=TvUNK0A7; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TH7wzcg4EjlO8slhPCaBpUjUcQl55ZckswoT3qOUB50=; b=TvUNK0A7TL8/hw4sr3XJR86U25
	84+sT3l4rxsNkEQuYeHNZAJSCj0ZpB+sXlCMcsXfJWw/jWvKHhAVVOvEdctJAujo1M0cPfExg7grj
	gKISrbS4Fb70KL/7dKRQBcLtLjUs2H9BQzZohcH/m3ymLGZfmOAb/kPb8fcvJor/Tuq8x6ov3vx3+
	rbZmm1dZw2vMNot1KNEx4OCEB5PbQIBmKB8D7bMPmzazXI6D8pnlVJTGcBlxiFKkfvWQhztmt3uT1
	pMG9YlKb7lxni1RSz4hJU9lzxagmbpSui12nJhCbkSawFIaU2Adwkz0DzQMtBsDX8rXewaqqzH7q8
	1zkJkssA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uRp6d-000ulq-2p;
	Wed, 18 Jun 2025 17:45:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 18 Jun 2025 17:44:59 +0800
Date: Wed, 18 Jun 2025 17:44:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	steffen.klassert@secunet.com, Cosmin Ratiu <cratiu@nvidia.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] xfrm: hold device only for the asynchronous
 decryption
Message-ID: <aFKKm1Azr5nHGZR-@gondor.apana.org.au>
References: <20250618092550.68847-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618092550.68847-1-jianbol@nvidia.com>

On Wed, Jun 18, 2025 at 12:25:49PM +0300, Jianbo Liu wrote:
>
> @@ -649,18 +650,16 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  		XFRM_SKB_CB(skb)->seq.input.low = seq;
>  		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
>  
> -		dev_hold(skb->dev);
> -
>  		if (crypto_done)
>  			nexthdr = x->type_offload->input_tail(x, skb);
>  		else
>  			nexthdr = x->type->input(x, skb);
>  
> -		if (nexthdr == -EINPROGRESS)
> +		if (nexthdr == -EINPROGRESS) {
> +			dev_hold(skb->dev);

You can't do that.  The moment x->type->input is called the ref count
can be released on another CPU.  So incrementing the refcount after
its return is too late.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

