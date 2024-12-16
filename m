Return-Path: <netdev+bounces-152119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E059F2C50
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5DB1882FC3
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB5A1FFC6D;
	Mon, 16 Dec 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFRsrcOF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277AE1FFC46
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339128; cv=none; b=QZ50MN4o1up3j9fPwOvJbUcAvBmxokTDHzLFxENIgGwplIKWk9UsWIzgl6vE0y4tgXNjMhsb48trlKs7o4i0phOXQ4VHgjK5Z2AHn1HOJigvyKczwpUflus23Heq20mOP8QcnY++FmGeUI6Wz8DB1dPt7ELH3OMJgMOtP9HXvmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339128; c=relaxed/simple;
	bh=cw6agu2cPh7pWd/ovT6/NMYCbs8xgL2IfhBflTw9RKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGt8NNg1xz088dG0TEK5PJU3GTFv6wEBMxLfz/hujN1F9gUPVu4l74VljOSKcwMkR1aJ+Ws/53kclm1+dmxtDXzRqRCS05d0bZIxX2p7KCD0nZ/F2mFBUgZnf9aX3yzN4MRFX4Sg0J1kEw//AexkC+joxNfsfDEovHRGigcCqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFRsrcOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B426FC4CED0;
	Mon, 16 Dec 2024 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734339127;
	bh=cw6agu2cPh7pWd/ovT6/NMYCbs8xgL2IfhBflTw9RKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OFRsrcOF4OBWRenVFNHPeUnZz+Y62IbGF2AzGsilVYu8xGNyHPBlwWi5JU2qfkTGp
	 DwrMuZ1IewMRszNz6mBBs6SmWH/n0KzpjaZWpsljK/3jUp/54H4V/9vuW+MVqtjKB6
	 Nx3DwuobUj0z+JysAX+H9r05fVbkf5TXDuxHHvfjGyroK32f3m/X3J1RIlXYU+F1tc
	 n5zyIDDqt5MIAsRuCzYE9IQgYnEQ7AfGGAG9JCLTTaALrInFHJaGJhxEBE2/axyqAD
	 FrFN7IuQ4IG1IE2owxmQFS2yYVORZkcVTqzaHIT5WpHQLEV1KF2AaU/FhYuV/8LMbX
	 nv8K1EVDXVgvg==
Message-ID: <9e55f21d-e246-45d2-bad1-b1bcde95b4e6@kernel.org>
Date: Mon, 16 Dec 2024 09:52:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: page_pool: rename
 page_pool_is_last_ref()
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, asml.silence@gmail.com,
 almasrymina@google.com
References: <20241215212938.99210-1-kuba@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20241215212938.99210-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/12/2024 22.29, Jakub Kicinski wrote:
> page_pool_is_last_ref() releases a reference while the name,
> to me at least, suggests it just checks if the refcount is 1.
> The semantics of the function are the same as those of
> atomic_dec_and_test() and refcount_dec_and_test(), so just
> use the _and_test() suffix.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Hopefully this doesn't conflict with anyone's work, I've been
> deferring sending this rename forever because I always look
> at it while reviewing an in-flight series and then I'm worried
> it will conflict.
> 
> v2:
>   - rebased on Olek's changes
> v1: https://lore.kernel.org/20241213153759.3086474-1-kuba@kernel.org
> 
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> CC: aleksander.lobakin@intel.com
> CC: asml.silence@gmail.com
> CC: almasrymina@google.com
> ---
>   include/net/page_pool/helpers.h | 4 ++--
>   net/core/page_pool.c            | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)

Looks good to me.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>



> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index e555921e5233..776a3008ac28 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -306,7 +306,7 @@ static inline void page_pool_ref_page(struct page *page)
>   	page_pool_ref_netmem(page_to_netmem(page));
>   }
>   
> -static inline bool page_pool_is_last_ref(netmem_ref netmem)
> +static inline bool page_pool_unref_and_test(netmem_ref netmem)
>   {
>   	/* If page_pool_unref_page() returns 0, we were the last user */
>   	return page_pool_unref_netmem(netmem, 1) == 0;
> @@ -321,7 +321,7 @@ static inline void page_pool_put_netmem(struct page_pool *pool,
>   	 * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
>   	 */
>   #ifdef CONFIG_PAGE_POOL
> -	if (!page_pool_is_last_ref(netmem))
> +	if (!page_pool_unref_and_test(netmem))
>   		return;
>   
>   	page_pool_put_unrefed_netmem(pool, netmem, dma_sync_size, allow_direct);
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index e07ad7315955..9733206d6406 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -897,7 +897,7 @@ void page_pool_put_netmem_bulk(netmem_ref *data, u32 count)
>   	for (u32 i = 0; i < count; i++) {
>   		netmem_ref netmem = netmem_compound_head(data[i]);
>   
> -		if (page_pool_is_last_ref(netmem))
> +		if (page_pool_unref_and_test(netmem))
>   			data[bulk_len++] = netmem;
>   	}
>   

