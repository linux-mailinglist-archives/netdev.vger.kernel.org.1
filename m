Return-Path: <netdev+bounces-236059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B80C381F9
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 22:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A30064E51FB
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 21:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0B2E7647;
	Wed,  5 Nov 2025 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8F5RNma"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E622E7179;
	Wed,  5 Nov 2025 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379797; cv=none; b=hpkDN++CZWOPf/dincBcmr4yvyfiycJZvfU5TlppO4hpNfbJoTlKmMG4DFrxeOQsycnne+MSe3cgr5bUWjx+/9CFe8wPzHD9B6kV71rjTmne8y2JqA01R4yo9nKriOMgREk9JlnzxuXjDLW9qpZ7uHEZ2808MFcSnWqWWq03sYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379797; c=relaxed/simple;
	bh=oK0VR5pT9U9v/hYdiS9OdTvRIaQntX9tuDQTRkkEYZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsBiI7xEBdBJomlEt+2xRESrIF+4qQNoGP6bM/rZo5m0z/nYedV9A/NFmH79x8hwzZBTeXTOzsGIfEkZNEOtHDGNlrEk1BWqkSc9o7g+xAduAqDLe2dsM8y+SMJDqvsjoGFId/xSXaFYAUzJUO69hGevbIXFLbrIIsBHfjZj/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8F5RNma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3936C4CEF5;
	Wed,  5 Nov 2025 21:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762379796;
	bh=oK0VR5pT9U9v/hYdiS9OdTvRIaQntX9tuDQTRkkEYZw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q8F5RNmacYdR/8lHBNMTMVRTOKnojMSoy+TXN5syqLQ+eY8hcgofbZ8I9kTB5klV8
	 sppxJzYY5/OzkXkRkeiJ+9DIqIhhKVaM3F/18fwr6mBOosJK3zbpEAoPJdWMEFF3Yy
	 flLPog5tBPAXohzjBwAoRfWHzmrSPYwCPKkY5VFze7r6sc8WzUEWw/V0Tgwv7R19Fo
	 KGUl1+mWSCVun5QGaoymx2u3K5jkT2/J3d+9OmpnmrvIsYtV4uQI0pJep+DbGT2uuA
	 ml+ByC6kXtM00gz/vYo3tR7fDOnrEcjaTu0k6OIXnO4FqKEjf/DHAULzgfC0YgEDy8
	 teiAOnQmPtZ0Q==
Message-ID: <1a07e27f-69de-4a38-884a-5ad078e7acf5@kernel.org>
Date: Wed, 5 Nov 2025 22:56:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/2] page_pool: expose max page pool ring size
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>
References: <20251105200801.178381-1-almasrymina@google.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251105200801.178381-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/11/2025 21.07, Mina Almasry wrote:
> Expose this as a constant so we can reuse it in drivers.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>   include/net/page_pool/types.h | 2 ++
>   net/core/page_pool.c          | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)


Looks good to me

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 1509a536cb85..5edba3122b10 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -58,6 +58,8 @@ struct pp_alloc_cache {
>   	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>   };
>   
> +#define PAGE_POOL_MAX_RING_SIZE 16384
> +

IIRC this was recently reduced to 16384 (from 32K), do you have a
use-case for higher limits?

>   /**
>    * struct page_pool_params - page pool parameters
>    * @fast:	params accessed frequently on hotpath
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 1a5edec485f1..7b2808da294f 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -211,7 +211,7 @@ static int page_pool_init(struct page_pool *pool,
>   		return -EINVAL;
>   
>   	if (pool->p.pool_size)
> -		ring_qsize = min(pool->p.pool_size, 16384);
> +		ring_qsize = min(pool->p.pool_size, PAGE_POOL_MAX_RING_SIZE);
>   
>   	/* DMA direction is either DMA_FROM_DEVICE or DMA_BIDIRECTIONAL.
>   	 * DMA_BIDIRECTIONAL is for allowing page used for DMA sending,
> 
> base-commit: 327c20c21d80e0d87834b392d83ae73c955ad8ff


