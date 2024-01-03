Return-Path: <netdev+bounces-61380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A4C82383F
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 23:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FBC1F23908
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 22:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB5D1802B;
	Wed,  3 Jan 2024 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="AEQi3zRo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524D51DA58
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d43df785c2so29594915ad.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 14:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1704321398; x=1704926198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVeZKB7qRvSymM0U0QuH/lrORE+skl2NPLppRlmAmOM=;
        b=AEQi3zRou/YFsSTkKaQ0botg/TIjZp7wwf71EWxttf+TxG0TG9hitB9GPwBTTG7VUI
         4HchwkcvZyI/bVeZvP/16yKKAlzQkUCqfdryGL/InbLzkDi3wxLtNTzieZJPFS0+GA5m
         Ml6zx6eJD9UPMKJLMgRkpAjHms7hI4t/joCxObavCDR2/1G8RtnVUJryW4wbieUC89wY
         zmcnxFff6fIuwjoUow6Fvh/fW23+Ti6UvJ9/JxFlFHkD0etT6To0ep44mWx3LL+evSCK
         r6w0ldWTbRtxhgfYE878KJ2tGMfnkFe7SoUg7or9heV+necZC3emq6e2ZzRw3ZpkelL+
         BEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321398; x=1704926198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVeZKB7qRvSymM0U0QuH/lrORE+skl2NPLppRlmAmOM=;
        b=o3xKfEs6T342U9iocXD+jGoDVlYhA+jykMtQm/ZYX0hGQKRzX5Etvvr/AXdW+ubhxP
         uIMwURMpJuCcNOnuHyt6JU3OYeNHeGQZvGSf15B0WG4DVR9HCcfVafWfIezxrjPsIYxi
         jm43djYDoatx+rztAjSJFtyfCuoqbiIN9FdTQB469BXFpYYsT64+3CdmEpZ5lr6+1OiU
         tvrKc/4R3yjcTzMlwZyWuhMikOsVwwxMOuc9YR9487d2vrJ9BFJVl2aUMPUH1bfz563h
         PCz7wbrQxorKYM5EZN5kh9ie8uOJAHIZDktjWpWeHiPtSkx/BOsIXLpVcSd7DMzCMu0o
         yxFw==
X-Gm-Message-State: AOJu0YwRDsTgXAltaZxkqH+u9Ynz2TCgFgaj4MHW+kU9ZfH3cFLupTQe
	Y1ipFltiSH8zFWTqO9Fig19AxcJeXNqFXA==
X-Google-Smtp-Source: AGHT+IFUEF+GSjXVKrGLIt5esTtuHO8dG4JAznrejZHF084AWL685YFCZyEcQgjHRW6O6nrkFz8npQ==
X-Received: by 2002:a17:902:f804:b0:1d4:a381:e933 with SMTP id ix4-20020a170902f80400b001d4a381e933mr3701176plb.130.1704321398574;
        Wed, 03 Jan 2024 14:36:38 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:a:897:c73b:17c6:3432? ([2620:10d:c090:500::4:9b01])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b001d053a56fb4sm24401191plh.67.2024.01.03.14.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 14:36:38 -0800 (PST)
Message-ID: <bf4760df-a78f-431d-8c33-b7a2f7fb393d@davidwei.uk>
Date: Wed, 3 Jan 2024 14:36:36 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] netdevsim: forward skbs from one
 connected port to another
Content-Language: en-GB
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231228014633.3256862-1-dw@davidwei.uk>
 <20231228014633.3256862-4-dw@davidwei.uk> <ZZPv42K9VRTao735@nanopsycho>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZZPv42K9VRTao735@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-02 03:13, Jiri Pirko wrote:
> Thu, Dec 28, 2023 at 02:46:31AM CET, dw@davidwei.uk wrote:
>> Forward skbs sent from one netdevsim port to its connected netdevsim
>> port using dev_forward_skb, in a spirit similar to veth.
>>
>> Add a tx_dropped variable to struct netdevsim, tracking the number of
>> skbs that could not be forwarded using dev_forward_skb().
>>
>> The xmit() function accessing the peer ptr is protected by an RCU read
>> critical section. The rcu_read_lock() is functionally redundant as since
>> v5.0 all softirqs are implicitly RCU read critical sections; but it is
>> useful for human readers.
>>
>> If another CPU is concurrently in nsim_destroy(), then it will first set
>> the peer ptr to NULL. This does not affect any existing readers that
>> dereferenced a non-NULL peer. Then, in unregister_netdevice(), there is
>> a synchronize_rcu() before the netdev is actually unregistered and
>> freed. This ensures that any readers i.e. xmit() that got a non-NULL
>> peer will complete before the netdev is freed.
>>
>> Any readers after the RCU_INIT_POINTER() but before synchronize_rcu()
>> will dereference NULL, making it safe.
>>
>> The codepath to nsim_destroy() and nsim_create() takes both the newly
>> added nsim_dev_list_lock and rtnl_lock. This makes it safe with
> 
> I don't see the rtnl_lock take in those functions.
> 
> 
> Otherwise, this patch looks fine to me.

For nsim_create(), rtnl_lock is taken in nsim_init_netdevsim(). For
nsim_destroy(), rtnl_lock is taken directly in the function.

What I mean here is, in the netdevsim device modification paths locks
are taken in this order:

devl_lock -> rtnl_lock

nsim_dev_list_lock is taken outside (not nested) of these.

In nsim_dev_peer_write() where two ports are linked, locks are taken in
this order:

nsim_dev_list_lock -> devl_lock -> rtnl_lock

This will not cause deadlocks and ensures that two ports being linked
are both valid.

> 
> 
>> concurrent calls to linking two netdevsims together.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>> drivers/net/netdevsim/netdev.c    | 21 ++++++++++++++++++---
>> drivers/net/netdevsim/netdevsim.h |  1 +
>> 2 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>> index 434322f6a565..0009d0f1243f 100644
>> --- a/drivers/net/netdevsim/netdev.c
 +++ b/drivers/net/netdevsim/netdev.c
>> @@ -29,19 +29,34 @@
>> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>> {
>> 	struct netdevsim *ns = netdev_priv(dev);
>> +	struct netdevsim *peer_ns;
>> +	int ret = NETDEV_TX_OK;
>>
>> 	if (!nsim_ipsec_tx(ns, skb))
>> 		goto out;
>>
>> +	rcu_read_lock();
>> +	peer_ns = rcu_dereference(ns->peer);
>> +	if (!peer_ns)
>> +		goto out_stats;
>> +
>> +	skb_tx_timestamp(skb);
>> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>> +		ret = NET_XMIT_DROP;
>> +
>> +out_stats:
>> +	rcu_read_unlock();
>> 	u64_stats_update_begin(&ns->syncp);
>> 	ns->tx_packets++;
>> 	ns->tx_bytes += skb->len;
>> +	if (ret == NET_XMIT_DROP)
>> +		ns->tx_dropped++;
>> 	u64_stats_update_end(&ns->syncp);
>> +	return ret;
>>
>> out:
>> 	dev_kfree_skb(skb);
>> -
>> -	return NETDEV_TX_OK;
>> +	return ret;
>> }
>>
>> static void nsim_set_rx_mode(struct net_device *dev)
>> @@ -70,6 +85,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>> 		start = u64_stats_fetch_begin(&ns->syncp);
>> 		stats->tx_bytes = ns->tx_bytes;
>> 		stats->tx_packets = ns->tx_packets;
>> +		stats->tx_dropped = ns->tx_dropped;
>> 	} while (u64_stats_fetch_retry(&ns->syncp, start));
>> }
>>
>> @@ -302,7 +318,6 @@ static void nsim_setup(struct net_device *dev)
>> 	eth_hw_addr_random(dev);
>>
>> 	dev->tx_queue_len = 0;
>> -	dev->flags |= IFF_NOARP;
>> 	dev->flags &= ~IFF_MULTICAST;
>> 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>> 			   IFF_NO_QUEUE;
>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>> index 24fc3fbda791..083b1ee7a1a2 100644
>> --- a/drivers/net/netdevsim/netdevsim.h
>> +++ b/drivers/net/netdevsim/netdevsim.h
>> @@ -98,6 +98,7 @@ struct netdevsim {
>>
>> 	u64 tx_packets;
>> 	u64 tx_bytes;
>> +	u64 tx_dropped;
>> 	struct u64_stats_sync syncp;
>>
>> 	struct nsim_bus_dev *nsim_bus_dev;
>> -- 
>> 2.39.3
>>

