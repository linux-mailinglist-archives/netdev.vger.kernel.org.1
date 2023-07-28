Return-Path: <netdev+bounces-22214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9A67668E4
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499A2282593
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640BD10953;
	Fri, 28 Jul 2023 09:32:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565DB10950
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 09:32:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E24204
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690536726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcjUt618Z45nMTb+RFtsmBBBhq7ViXpq+z7I95/Kk+o=;
	b=Aj23PC+VMiq6A7MXrtkCzCVHkCRZgmcHRjCJuaOLWPq6YfwUSKuUQOm9C4ybxrGifXrD8J
	XyMplmNEfplWEuPhAgbdHe04NHX8D00uJd+nagH9ix9BWb6+cc5Wta4t2wsJX6oj3XcLyW
	+hbfl6pogtgHKZD1tFNt5k2CLxFCI8A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-VEABHKvvNl2YGsFGPQBdzQ-1; Fri, 28 Jul 2023 05:32:04 -0400
X-MC-Unique: VEABHKvvNl2YGsFGPQBdzQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5223854ef71so1222032a12.1
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 02:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690536723; x=1691141523;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcjUt618Z45nMTb+RFtsmBBBhq7ViXpq+z7I95/Kk+o=;
        b=AHvmJtmJtUbGNExmQI2PEpczr9HTqSSWUeJxvPfeUYxHMqaFDTBJFkuVJlvu6eFvZc
         vLT/ghlDJTpKj8PUpuNmDt5E0NhHOzx6GjvT0GKmcso8Lalt4HyLPxM4hB4uaqC5F+Td
         fBNPSW2hx58U4Ktl6qdW0xQqWj3zRQn3snJFhO5dBwp73QfbhN5IMZSGF1/7vm1wU4Yn
         M5FeY+QwPc3pzDpsBFfGjyViw5hVYT1J12dA3IzLBmDut2Lcu+c2Rmy2IO88110fNyfa
         /BQHKh8sRYcdm6STaPazdfXmS0k202A70miNAY3cbR4oTtcrrUvJEP7W7YG4NNibxP7f
         TsHQ==
X-Gm-Message-State: ABy/qLbtU9S1BG/XYU0rONk3iHfwN6VEUcN3EIQJ+IycTpcE8srr9DR7
	Y0SvTlJEXO4/TfOmc8rI+6/lw7fQKSHttTGyY2qdmpU+88I+Scmi6a0rT01UZdjiM/FeY8vSmW4
	RyUZD1TADxWVR9CVK
X-Received: by 2002:aa7:d616:0:b0:522:3081:ddb4 with SMTP id c22-20020aa7d616000000b005223081ddb4mr1368398edr.20.1690536723366;
        Fri, 28 Jul 2023 02:32:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGdL9m3DjLNN/ZU/lTc9TOFyIZ02cvDfIMMhRXp57SSjAnA34gcDPuPkMEe2O1hvcsTsletfg==
X-Received: by 2002:aa7:d616:0:b0:522:3081:ddb4 with SMTP id c22-20020aa7d616000000b005223081ddb4mr1368388edr.20.1690536723082;
        Fri, 28 Jul 2023 02:32:03 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id x8-20020aa7d388000000b005228614c358sm1584021edq.88.2023.07.28.02.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 02:32:02 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <db85d260-fdad-9b7c-cf7e-2e848151292d@redhat.com>
Date: Fri, 28 Jul 2023 11:32:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, qingfang.deng@siflower.com.cn
Subject: Re: [PATCH net-next 9/9] net: skbuff: always try to recycle PP pages
 directly when in softirq
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-10-aleksander.lobakin@intel.com>
In-Reply-To: <20230727144336.1646454-10-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 27/07/2023 16.43, Alexander Lobakin wrote:
> Commit 8c48eea3adf3 ("page_pool: allow caching from safely localized
> NAPI") allowed direct recycling of skb pages to their PP for some cases,
> but unfortunately missed a couple of other majors.
> For example, %XDP_DROP in skb mode. The netstack just calls kfree_skb(),
> which unconditionally passes `false` as @napi_safe. Thus, all pages go
> through ptr_ring and locks, although most of time we're actually inside
> the NAPI polling this PP is linked with, so that it would be perfectly
> safe to recycle pages directly.

The commit messages is hard to read. It would help me as the reader if
you used a empty line between paragraphs, like in this location (same
goes for other commit descs).

> Let's address such. If @napi_safe is true, we're fine, don't change
> anything for this path. But if it's false, check whether we are in the
> softirq context. It will most likely be so and then if ->list_owner
> is our current CPU, we're good to use direct recycling, even though
> @napi_safe is false -- concurrent access is excluded. in_softirq()
> protection is needed mostly due to we can hit this place in the
> process context (not the hardirq though).

This patch make me a little nervous, as it can create hard-to-debug bugs
if this isn't 100% correct.  (Thanks for previous patch that exclude
hardirq via lockdep).

> For the mentioned xdp-drop-skb-mode case, the improvement I got is
> 3-4% in Mpps. As for page_pool stats, recycle_ring is now 0 and
> alloc_slow counter doesn't change most of time, which means the
> MM layer is not even called to allocate any new pages.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org> # in_softirq()
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   net/core/skbuff.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index e701401092d7..5ba3948cceed 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -901,8 +901,10 @@ bool page_pool_return_skb_page(struct page *page, bool napi_safe)
>   	/* Allow direct recycle if we have reasons to believe that we are
>   	 * in the same context as the consumer would run, so there's
>   	 * no possible race.
> +	 * __page_pool_put_page() makes sure we're not in hardirq context
> +	 * and interrupts are enabled prior to accessing the cache.
>   	 */
> -	if (napi_safe) {
> +	if (napi_safe || in_softirq()) {

I used to have in_serving_softirq() in PP to exclude process context
that just disabled BH to do direct recycling (into a lockless array).
This changed in kernel v6.3 commit 542bcea4be86 ("net: page_pool: use
in_softirq() instead") to help threaded NAPI.  I guess, nothing blew up
so I guess this was okay to relax this.

>   		const struct napi_struct *napi = READ_ONCE(pp->p.napi);
>   
>   		allow_direct = napi &&

AFAIK this in_softirq() will allow process context with disabled BH to
also recycle directly into the PP lockless array.  With the additional
checks (that are just outside above diff-context) that I assume makes
sure CPU (smp_processor_id()) also match.  Is this safe?

--Jesper


