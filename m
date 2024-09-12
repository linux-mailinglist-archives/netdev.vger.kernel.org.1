Return-Path: <netdev+bounces-127842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9461976DB2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E280D1C2371D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2C01B1507;
	Thu, 12 Sep 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2/oqNWI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84044C8F;
	Thu, 12 Sep 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154774; cv=none; b=TLbTnTGtlIWqi3d4vqc0hHMVFaraNnlG5JcO5KNM1eroNHDKP1OGTIh7jxvPcE2RePnuvdTx4Z3pG7CCrCOTnTsuPxESCgEo/9NqYznr7BxwIBz9U4WljhoynqacDKXASsfzsXwNqiSaC/6RM+jmqXEIjHYVHoQtUeGADdSy83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154774; c=relaxed/simple;
	bh=eT5iKufiEqBrOOHnVVD75u4spQv2bu9zWq9lPSq8HXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJFZPeDBme2cs801sPs+f97uARdrrbML8YMqr4AwqPtqaizSPBftpDjCVnknGZ6XOnEE1ZnYGPRWZ3OK/iLBr1o5TJLaNcNaNaKNqjk839BVIWmJqRGzdmFfyOsbgCygjqkye+OuQztSTV2GQEBG6mBFQVavZ+Ug0A+Ehqow6Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2/oqNWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF6AC4CEC3;
	Thu, 12 Sep 2024 15:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726154773;
	bh=eT5iKufiEqBrOOHnVVD75u4spQv2bu9zWq9lPSq8HXQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a2/oqNWImsRF63TtKZfRJokrnQh4veCjTbq8hYaoS9r9/Yla+QR4K3v5VSPGCCS0i
	 +yoIRYu5jYInrsMx4sav4baIgWZoq2sBsmviRHLGnm/HKuIgMAgA8GLOp4ipAeJZZC
	 3ZhR/LjYn8m1a1NLPKFYxeMmnGPmZzKhbmtHxqy/CIbNjMpwZy9HdPz9hMAlpBZAjl
	 g62bFol1VIR/rCH2bMlqFDbj7IOQlltbhGCbDfPggFVZ0spBs+f/vLCm6Hf6ynSBX2
	 6Yu4zhB7Bq2QHE4aLFsinS9rgN5mIoyQ8YO4jzFEC+1wabGY8125ICWZFUwZWav4PN
	 dilesEWC9lkOg==
Message-ID: <73a104e0-d73f-4836-92fd-4bef415900d4@kernel.org>
Date: Thu, 12 Sep 2024 17:26:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] memory-provider: fix compilation issue without
 SYSFS
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Willem de Bruijn <willemb@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240912-net-next-fix-get_netdev_rx_queue_index-v1-1-d73a1436be8c@kernel.org>
 <CAHS8izOkpnLM_Uev79skrmdQjdOGwy_oYWV7xb3hNpSb=yYZ6g@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAHS8izOkpnLM_Uev79skrmdQjdOGwy_oYWV7xb3hNpSb=yYZ6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mina,

Thank you for your reply!

On 12/09/2024 14:49, Mina Almasry wrote:
> On Thu, Sep 12, 2024 at 3:25 AM Matthieu Baerts (NGI0)
> <matttbe@kernel.org> wrote:
>>
>> When CONFIG_SYSFS is not set, the kernel fails to compile:
>>
>>      net/core/page_pool_user.c:368:45: error: implicit declaration of function 'get_netdev_rx_queue_index' [-Werror=implicit-function-declaration]
>>       368 |                 if (pool->slow.queue_idx == get_netdev_rx_queue_index(rxq)) {
>>           |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> When CONFIG_SYSFS is not set, get_netdev_rx_queue_index() is not defined
>> as well. In this case, page_pool_check_memory_provider() cannot check
>> the memory provider, and a success answer can be returned instead.
>>
> 
> Thanks Matthieu, and sorry about that.
> 
> I have reproduced the build error and the fix resolves it. But...
> 
>> Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/core/page_pool_user.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
>> index 48335766c1bf..a98c0a76b33f 100644
>> --- a/net/core/page_pool_user.c
>> +++ b/net/core/page_pool_user.c
>> @@ -353,6 +353,7 @@ void page_pool_unlist(struct page_pool *pool)
>>  int page_pool_check_memory_provider(struct net_device *dev,
>>                                     struct netdev_rx_queue *rxq)
>>  {
>> +#ifdef CONFIG_SYSFS
>>         struct net_devmem_dmabuf_binding *binding = rxq->mp_params.mp_priv;
>>         struct page_pool *pool;
>>         struct hlist_node *n;
>> @@ -372,6 +373,9 @@ int page_pool_check_memory_provider(struct net_device *dev,
>>         }
>>         mutex_unlock(&page_pools_lock);
>>         return -ENODATA;
>> +#else
>> +       return 0;
> 
> ...we can't assume success when we cannot check the memory provider.
> The memory provider check is somewhat critical; we rely on it to
> detect that the driver does not support memory providers or is not
> doing the right thing, and report that to the user. I don't think we
> can silently disable the check when the CONFIG_SYSFS is disabled.
> Please return -ENODATA or some other error here.

I initially returned 0 to have the same behaviour as when
CONFIG_PAGE_POOL is not defined. But thanks to your explanations, I
understand it seems better to return -ENODATA here. Or another errno, to
let the userspace understanding there is a different error? I can send a
v2 after the 24h rate-limit period if you are OK with that.

> If we disable devmem TCP for !CONFIG_SYSFS we should probably add
> something to the docs saying this. I can do that in a follow up
> change.

Good point, thank you.

> However, I'm looking at the definition of get_netdev_rx_queue_index()
> and at first glance I don't see anything there that is actually
> dependent on CONFIG_SYSFS. Can we do this instead? I have build-tested
> it and it resolves the build issue as well:
> 
> ```
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> index ac34f5fb4f71..596836abf7bf 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h
> @@ -45,7 +45,6 @@ __netif_get_rx_queue(struct net_device *dev, unsigned int rxq)
>         return dev->_rx + rxq;
>  }
> 
> -#ifdef CONFIG_SYSFS
>  static inline unsigned int
>  get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
>  {
> @@ -55,7 +54,6 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
>         BUG_ON(index >= dev->num_rx_queues);
>         return index;
>  }
> -#endif
>  ```

I briefly looked at taking this path when I saw what this helper was
doing, but then I saw all operations related to the received queues were
enabled only when CONFIG_SYSFS is set, see commit a953be53ce40
("net-sysfs: add support for device-specific rx queue sysfs
attributes"). I understood from that it is better not to look at
dev->_rx or dev->num_rx_queues when CONFIG_SYSFS is not set. I'm not
very familiar to that part of the code, but it feels like removing this
#ifdef might be similar to the "return 0" I suggested: silently
disabling the check, no?

I *think* it might be clearer to return an error when SYSFS is not set.

> Matthieu, I'm happy to follow up with v2 of this fix if you don't have time.
If you prefer to explore other ways than returning an error in
page_pool_check_memory_provider() when SYSFS is not set, yes please do
the follow-up if you don't mind. My main goal is to stop my CI to
complain about that when compiling with 'make tinyconfig' + MPTCP :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


