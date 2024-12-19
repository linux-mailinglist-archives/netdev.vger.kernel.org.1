Return-Path: <netdev+bounces-153354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3AE9F7BC7
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4DE1880150
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEC2223328;
	Thu, 19 Dec 2024 12:47:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170122080F1;
	Thu, 19 Dec 2024 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734612435; cv=none; b=jVzOklprco3SUlM/O+jnlE+4q0mHLKe6OqzXe9iZtpUBL8sE+4QQ8sDDcmH86P6nsMH+v8g5a7uc0VRf/1fW1HEghUaRhu2i7jirkiL3Fmg8BLM8fGM1sSRR4m98M+tHp+oZ5wGYB5IaHeQM/1NTbMvm2K8YK77xnObXGsxgybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734612435; c=relaxed/simple;
	bh=RhEpxSuvm4M3zv3YNHv5d0WqfzNybx1TXTn1jx4OBh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lVmF+t42PCTey/lIIqEgt3tR8GI5l2/WXz2vuunsuc8AUScgYHqdbdOjIEelVPTEBmJ/N4yd0lTie/ohh2mo1DUAxNvwdzQbaJH4jyLXi/HT61FPinplFuNYWQxKUpewFAzDugI8Y7KknihBZn1cxG1g/Mg3Kz1AcePU4Ig1PSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YDVcK0VzQz1kvPd;
	Thu, 19 Dec 2024 20:44:33 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F1859140138;
	Thu, 19 Dec 2024 20:47:08 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Dec 2024 20:47:08 +0800
Message-ID: <d9718b39-1a01-4c1b-92b8-8e221bd7ef21@huawei.com>
Date: Thu, 19 Dec 2024 20:46:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: page_pool: add
 page_pool_put_page_nosync()
To: Guowei Dang <guowei.dang@foxmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Furong Xu <0x1207@gmail.com>
References: <tencent_76E62F6A47A7C7E818FC7C74A6B02772F308@qq.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <tencent_76E62F6A47A7C7E818FC7C74A6B02772F308@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/19 11:11, Guowei Dang wrote:
> Add page_pool_put_page_nosync() to respond to dma_sync_size being 0.
> 
> The purpose of this is to make the semantics more obvious and may
> enable removing some checkings in the future.

It would be good to describe the actual use case of the above API in
the commit log too.

> 
> And in the long term, treating the nosync scenario separately provides
> more flexibility for the user and enable removing of the
> PP_FLAG_DMA_SYNC_DEV in the future.
> 
> Since we do have a page_pool_put_full_page(), adding a variant for
> the nosync seems reasonable.
> 
> Suggested-by: Yunsheng Lin <linyunsheng@huawei.com>
> Acked-by: Furong Xu <0x1207@gmail.com>
> Signed-off-by: Guowei Dang <guowei.dang@foxmail.com>
> ---
>  Documentation/networking/page_pool.rst |  5 ++++-
>  include/net/page_pool/helpers.h        | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
> index 9d958128a57c..a83f7c071132 100644
> --- a/Documentation/networking/page_pool.rst
> +++ b/Documentation/networking/page_pool.rst
> @@ -62,7 +62,8 @@ a page will cause no race conditions is enough.
>     :identifiers: struct page_pool_params
>  
>  .. kernel-doc:: include/net/page_pool/helpers.h
> -   :identifiers: page_pool_put_page page_pool_put_full_page
> +   :identifiers: page_pool_put_page
> +		 page_pool_put_page_nosync page_pool_put_full_page
>  		 page_pool_recycle_direct page_pool_free_va
>  		 page_pool_dev_alloc_pages page_pool_dev_alloc_frag
>  		 page_pool_dev_alloc page_pool_dev_alloc_va
> @@ -93,6 +94,8 @@ much of the page needs to be synced (starting at ``offset``).
>  When directly freeing pages in the driver (page_pool_put_page())
>  the ``dma_sync_size`` argument specifies how much of the buffer needs
>  to be synced.
> +If the ``dma_sync_size`` argument is 0, page_pool_put_page_nosync() should be
> +used instead of page_pool_put_page().

It would be good to describe when user should call page_pool_put_page_nosync()
and when user should call page_pool_put_page() as the above doesn't really
help user to decide using which API.

As I recall correctly, it seems there is some use case that user is able to
tell that it is ok the skip the dma sync to improve performance by calling
page_pool_put_page_nosync() even when the page_pool is created with
PP_FLAG_DMA_SYNC_DEV flags set.

>  
>  If in doubt set ``offset`` to 0, ``max_len`` to ``PAGE_SIZE`` and
>  pass -1 as ``dma_sync_size``. That combination of arguments is always
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index e555921e5233..5cc68d48624a 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -340,12 +340,14 @@ static inline void page_pool_put_netmem(struct page_pool *pool,
>   * the allocator owns the page and will try to recycle it in one of the pool
>   * caches. If PP_FLAG_DMA_SYNC_DEV is set, the page will be synced for_device
>   * using dma_sync_single_range_for_device().
> + * page_pool_put_page_nosync() should be used if dma_sync_size is 0.
>   */
>  static inline void page_pool_put_page(struct page_pool *pool,
>  				      struct page *page,
>  				      unsigned int dma_sync_size,
>  				      bool allow_direct)
>  {
> +	DEBUG_NET_WARN_ON_ONCE(!dma_sync_size);
>  	page_pool_put_netmem(pool, page_to_netmem(page), dma_sync_size,
>  			     allow_direct);
>  }
> @@ -372,6 +374,21 @@ static inline void page_pool_put_full_page(struct page_pool *pool,
>  	page_pool_put_netmem(pool, page_to_netmem(page), -1, allow_direct);
>  }
>  
> +/**
> + * page_pool_put_page_nosync() - release a reference on a page pool page
> + * @pool:	pool from which page was allocated
> + * @page:	page to release a reference on
> + * @allow_direct: released by the consumer, allow lockless caching
> + *
> + * Similar to page_pool_put_page(), but will not DMA sync the memory area.
> + */
> +static inline void page_pool_put_page_nosync(struct page_pool *pool,
> +					     struct page *page,
> +					     bool allow_direct)
> +{
> +	page_pool_put_netmem(pool, page_to_netmem(page), 0, allow_direct);
> +}
> +
>  /**
>   * page_pool_recycle_direct() - release a reference on a page pool page
>   * @pool:	pool from which page was allocated

