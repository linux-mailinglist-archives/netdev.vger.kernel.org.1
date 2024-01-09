Return-Path: <netdev+bounces-62714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BFE828A90
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85259B21E0F
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E557A3A8C5;
	Tue,  9 Jan 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ufvvK4J6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870A72D621
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3f3ee00a2so14419825ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 08:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1704819503; x=1705424303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/JLLk+9bKmnSuCvyOKaTeOPorNycA/8Lxr3gtDisPk0=;
        b=ufvvK4J62HF/TjrZv/RvyR8vupxKGzj5VPvIiRKqeQHat5yqXcf/Qyw1OrF6l4lhq9
         EtJSKk1D1JUehpCSI9HVUHIHV6yzJnEI/ETRr6n/VQlNbJYRglcxe8Oi9e3DE6v8K1rJ
         NMFGgFY5oF1FaWKcQoEESkZ+StqF59HthHb6LQdfo2xS53+d9+H4wMHBrpq5KVXA7IVm
         4BHPK+JU2aeHMzJcNuFXatrqrerq1HmdM4IKNkwpUXBtyFKh07TrmZbck3LgByPU+SXq
         uJwnXy9AX2uAStWhahLkQTJpOE7J/+WjLgbPqNuUMlzJsvG8GABFH8CZKTJefvm5BXoW
         fXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704819503; x=1705424303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/JLLk+9bKmnSuCvyOKaTeOPorNycA/8Lxr3gtDisPk0=;
        b=ECk3NfWxyyeF7HBvGQp3XViKKTQRgyz1e9aLu2HwJ85niAR8lju7G9CRU9AUWxuvcf
         6X+MchPHF/UW8YHs4RK1eSPnI93KmZ0jIkxOgc+da5GOsar0f9qFtER10ni1+By4XApQ
         M+vFWjGZKQ6gwAHZQ8jGIOVLaHoalZU5lHlfOOjj8p2EGeTOtMbkJpg8rQZf7vl/Rubf
         vt5MaDcmvngBRLebwVTnRSs7ciYf9+vequc3lmWw85d+2VfDGMijwnxz/HjuUuvbr7u+
         qN5Kv4HK95jg8yoYkeIYOKGTqZKcgptoVZQ3sg3dqSKoIkAAwEufdn43eUol2xWFghcU
         ueKw==
X-Gm-Message-State: AOJu0Yy7SGsi8ONH45PSS5RvcRCY+j41bgP5y8IJRCc3OKEJMfvagykt
	4k9tsqq+CLHbZqGG8pgj0bN8xNmSi0M3Sw==
X-Google-Smtp-Source: AGHT+IEci60OdHsMBuZvgZp1jFQTQJ9gyZUmEsbKI3zOCpcBl5lRH3h+n6TN7HALCWv+H93d8/FR5g==
X-Received: by 2002:a17:903:252:b0:1d4:368d:3d6a with SMTP id j18-20020a170903025200b001d4368d3d6amr2890413plh.17.1704819502713;
        Tue, 09 Jan 2024 08:58:22 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::4:ea02])
        by smtp.gmail.com with ESMTPSA id az5-20020a170902a58500b001d398889d4dsm2010576plb.127.2024.01.09.08.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 08:58:22 -0800 (PST)
Message-ID: <08910686-138c-4722-a807-9636df5ccd03@davidwei.uk>
Date: Tue, 9 Jan 2024 08:58:21 -0800
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
 <bf4760df-a78f-431d-8c33-b7a2f7fb393d@davidwei.uk>
 <ZZZ7C0dhg2KzaNfi@nanopsycho>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZZZ7C0dhg2KzaNfi@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-04 01:31, Jiri Pirko wrote:
> Wed, Jan 03, 2024 at 11:36:36PM CET, dw@davidwei.uk wrote:
>> On 2024-01-02 03:13, Jiri Pirko wrote:
>>> Thu, Dec 28, 2023 at 02:46:31AM CET, dw@davidwei.uk wrote:
>>>> Forward skbs sent from one netdevsim port to its connected netdevsim
>>>> port using dev_forward_skb, in a spirit similar to veth.
>>>>
>>>> Add a tx_dropped variable to struct netdevsim, tracking the number of
>>>> skbs that could not be forwarded using dev_forward_skb().
>>>>
>>>> The xmit() function accessing the peer ptr is protected by an RCU read
>>>> critical section. The rcu_read_lock() is functionally redundant as since
>>>> v5.0 all softirqs are implicitly RCU read critical sections; but it is
>>>> useful for human readers.
>>>>
>>>> If another CPU is concurrently in nsim_destroy(), then it will first set
>>>> the peer ptr to NULL. This does not affect any existing readers that
>>>> dereferenced a non-NULL peer. Then, in unregister_netdevice(), there is
>>>> a synchronize_rcu() before the netdev is actually unregistered and
>>>> freed. This ensures that any readers i.e. xmit() that got a non-NULL
>>>> peer will complete before the netdev is freed.
>>>>
>>>> Any readers after the RCU_INIT_POINTER() but before synchronize_rcu()
>>>> will dereference NULL, making it safe.
>>>>
>>>> The codepath to nsim_destroy() and nsim_create() takes both the newly
>>>> added nsim_dev_list_lock and rtnl_lock. This makes it safe with
>>>
>>> I don't see the rtnl_lock take in those functions.
>>>
>>>
>>> Otherwise, this patch looks fine to me.
>>
>> For nsim_create(), rtnl_lock is taken in nsim_init_netdevsim(). For
>> nsim_destroy(), rtnl_lock is taken directly in the function.
>>
>> What I mean here is, in the netdevsim device modification paths locks
>> are taken in this order:
>>
>> devl_lock -> rtnl_lock
>>
>> nsim_dev_list_lock is taken outside (not nested) of these.
>>
>> In nsim_dev_peer_write() where two ports are linked, locks are taken in
>> this order:
>>
>> nsim_dev_list_lock -> devl_lock -> rtnl_lock
>>
>> This will not cause deadlocks and ensures that two ports being linked
>> are both valid.
> 
> Okay. Perhaps would be good to document this in a comment somewhere in
> the code?

Yep, I'll add this.

> 
> 
>>
>>>
>>>
>>>> concurrent calls to linking two netdevsims together.
>>>>
>>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>>> ---
>>>> drivers/net/netdevsim/netdev.c    | 21 ++++++++++++++++++---
>>>> drivers/net/netdevsim/netdevsim.h |  1 +
>>>> 2 files changed, 19 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>>>> index 434322f6a565..0009d0f1243f 100644
>>>> --- a/drivers/net/netdevsim/netdev.c
>> +++ b/drivers/net/netdevsim/netdev.c
>>>> @@ -29,19 +29,34 @@
>>>> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>>> {
>>>> 	struct netdevsim *ns = netdev_priv(dev);
>>>> +	struct netdevsim *peer_ns;
>>>> +	int ret = NETDEV_TX_OK;
>>>>
>>>> 	if (!nsim_ipsec_tx(ns, skb))
>>>> 		goto out;
>>>>
>>>> +	rcu_read_lock();
>>>> +	peer_ns = rcu_dereference(ns->peer);
>>>> +	if (!peer_ns)
>>>> +		goto out_stats;
>>>> +
>>>> +	skb_tx_timestamp(skb);
>>>> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>>>> +		ret = NET_XMIT_DROP;
>>>> +
>>>> +out_stats:
>>>> +	rcu_read_unlock();
>>>> 	u64_stats_update_begin(&ns->syncp);
>>>> 	ns->tx_packets++;
>>>> 	ns->tx_bytes += skb->len;
>>>> +	if (ret == NET_XMIT_DROP)
>>>> +		ns->tx_dropped++;
>>>> 	u64_stats_update_end(&ns->syncp);
>>>> +	return ret;
>>>>
>>>> out:
>>>> 	dev_kfree_skb(skb);
>>>> -
>>>> -	return NETDEV_TX_OK;
>>>> +	return ret;
>>>> }
>>>>
>>>> static void nsim_set_rx_mode(struct net_device *dev)
>>>> @@ -70,6 +85,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>>>> 		start = u64_stats_fetch_begin(&ns->syncp);
>>>> 		stats->tx_bytes = ns->tx_bytes;
>>>> 		stats->tx_packets = ns->tx_packets;
>>>> +		stats->tx_dropped = ns->tx_dropped;
>>>> 	} while (u64_stats_fetch_retry(&ns->syncp, start));
>>>> }
>>>>
>>>> @@ -302,7 +318,6 @@ static void nsim_setup(struct net_device *dev)
>>>> 	eth_hw_addr_random(dev);
>>>>
>>>> 	dev->tx_queue_len = 0;
>>>> -	dev->flags |= IFF_NOARP;
>>>> 	dev->flags &= ~IFF_MULTICAST;
>>>> 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>>>> 			   IFF_NO_QUEUE;
>>>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>>>> index 24fc3fbda791..083b1ee7a1a2 100644
>>>> --- a/drivers/net/netdevsim/netdevsim.h
>>>> +++ b/drivers/net/netdevsim/netdevsim.h
>>>> @@ -98,6 +98,7 @@ struct netdevsim {
>>>>
>>>> 	u64 tx_packets;
>>>> 	u64 tx_bytes;
>>>> +	u64 tx_dropped;
>>>> 	struct u64_stats_sync syncp;
>>>>
>>>> 	struct nsim_bus_dev *nsim_bus_dev;
>>>> -- 
>>>> 2.39.3
>>>>

