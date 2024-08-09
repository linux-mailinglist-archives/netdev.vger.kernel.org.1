Return-Path: <netdev+bounces-117130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A1294CD03
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991461C20DBD
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CA5190682;
	Fri,  9 Aug 2024 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyDA6BQZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE819066F;
	Fri,  9 Aug 2024 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194755; cv=none; b=Ae/CsBBT5D3d/VG9EfF1M+mWeHahgw94NQOzzMAhmVc0+vz87npBU6yWcr81h3twx1tOKVLowLSYN+6LhPb2sV+xqrM7NpOoFN4molEYeLpKUsXg9Uzeh+RjVhuBxO0CagC8+QmWySiDUDC2mOX3cIy/100Thj32GdxtqTWn+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194755; c=relaxed/simple;
	bh=piWThwkqtUm8CO/JgmWnxZJEh/EOiBvqbPWcfMgo3ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZ1xQeLVAgVWstMAbxQ6oJiCze56ZZrCfHWGoYSMqx9utYIwtKG79zU63Zt9W1SK6zulLkaokLhxKgTnNSjVgaiqO9AotgTfsOP8sNp/HgAg31/LEMAu3KBItKc40eQkED/hZQU8s+XPPfst6AiBB+TJUdT7yuzn/6kaKB2uAys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyDA6BQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88DDC32782;
	Fri,  9 Aug 2024 09:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723194754;
	bh=piWThwkqtUm8CO/JgmWnxZJEh/EOiBvqbPWcfMgo3ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VyDA6BQZ95z5jFOgrdCuipDh410D8nKYHzh97JKQb71pJCRneMLOnoP0eGQvRf9Ts
	 9W7pOmHO9Zn92APvFCSxgBCJHjn6Kd4yISx4Naen6LHEX9BYf1G2mbMAI+KVcXWtL/
	 1ancCxSvqPcEr55h9IY7efGfcyl6gY2yoTovJui48LBw+gC1ffEsPJQDXjlMS8Lygo
	 FZaUQWxXSUDiD1U4ZIbBWnN4MG412ogqQFqA3vNI4PdGzzRzinGAvwGo3NGHGlvs/0
	 jEPj2umLY9p1msZ9TtQTjqVJxl+nU23z2Rl8rq8wapqctBwhdFaibFterm1eT9p0Ft
	 3aCVALjQrkMWA==
Message-ID: <3e78e255-d50a-40fb-a438-bfcebb11b049@kernel.org>
Date: Fri, 9 Aug 2024 11:12:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] page_pool: unexport set dma_addr helper
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240808214520.2648194-1-almasrymina@google.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240808214520.2648194-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/08/2024 23.45, Mina Almasry wrote:
> This helper doesn't need to be exported. Move it to page_pool_priv.h
> 
> Moving the implementation to the .c file allows us to hide netmem
> implementation details in internal header files rather than the public
> file.
> 

Hmm, I worry this is a performance paper cut.
AFAICT this cause the page_pool_set_dma_addr() to be a function call,
while it before was inlined and on 64bit archs it is a simple assignment
"page->dma_addr = addr".

See below, maybe a simple 'static' function define will resolve this.

> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v2: https://patchwork.kernel.org/project/netdevbpf/patch/20240805212536.2172174-6-almasrymina@google.com/
> - Move get back to the public header. (Jakub)
> - Move set to the internal header page_pool_priv.h (Jakub)
> 
> ---
>   include/net/page_pool/helpers.h | 23 -----------------------
>   net/core/page_pool.c            | 17 +++++++++++++++++
>   net/core/page_pool_priv.h       |  6 ++++++
>   3 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 2b43a893c619d..375656baa2d45 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -423,24 +423,6 @@ static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
>   	return page_pool_get_dma_addr_netmem(page_to_netmem((struct page *)page));
>   }
>   
> -static inline bool page_pool_set_dma_addr_netmem(netmem_ref netmem,
> -						 dma_addr_t addr)
> -{
> -	struct page *page = netmem_to_page(netmem);
> -
> -	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
> -		page->dma_addr = addr >> PAGE_SHIFT;
> -
> -		/* We assume page alignment to shave off bottom bits,
> -		 * if this "compression" doesn't work we need to drop.
> -		 */
> -		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
> -	}
> -
> -	page->dma_addr = addr;
> -	return false;
> -}
> -
>   /**
>    * page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
>    * @pool: &page_pool the @page belongs to
> @@ -463,11 +445,6 @@ static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
>   				      page_pool_get_dma_dir(pool));
>   }
>   
> -static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
> -{
> -	return page_pool_set_dma_addr_netmem(page_to_netmem(page), addr);
> -}
> -
>   static inline bool page_pool_put(struct page_pool *pool)
>   {
>   	return refcount_dec_and_test(&pool->user_cnt);
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 2abe6e919224d..d689a20780f40 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1099,3 +1099,20 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
>   	}
>   }
>   EXPORT_SYMBOL(page_pool_update_nid);
> +
> +bool page_pool_set_dma_addr_netmem(netmem_ref netmem, dma_addr_t addr)


Maybe defining function as 'static bool' will make compiler inline it(?)

> +{
> +	struct page *page = netmem_to_page(netmem);
> +
> +	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
> +		page->dma_addr = addr >> PAGE_SHIFT;
> +
> +		/* We assume page alignment to shave off bottom bits,
> +		 * if this "compression" doesn't work we need to drop.
> +		 */
> +		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
> +	}
> +
> +	page->dma_addr = addr;
> +	return false;
> +}
> diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
> index 90665d40f1eb7..4fbc69ace7d21 100644
> --- a/net/core/page_pool_priv.h
> +++ b/net/core/page_pool_priv.h
> @@ -8,5 +8,11 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict);
>   int page_pool_list(struct page_pool *pool);
>   void page_pool_detached(struct page_pool *pool);
>   void page_pool_unlist(struct page_pool *pool);
> +bool page_pool_set_dma_addr_netmem(netmem_ref netmem, dma_addr_t addr);
> +
> +static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
> +{
> +	return page_pool_set_dma_addr_netmem(page_to_netmem(page), addr);
> +}
>   
>   #endif

