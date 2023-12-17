Return-Path: <netdev+bounces-58314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEAC815D3E
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 04:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9F01C215B2
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 03:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51264653;
	Sun, 17 Dec 2023 02:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="MUcwPlLp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3583A3D
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6cedc988cf6so861162b3a.3
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 18:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702781995; x=1703386795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u4HtNCasZrLZkpGsmYoGQVdO4D+Mh54IM/kVCP+4Gb4=;
        b=MUcwPlLplHQCysASz20/gtljr4tgmrODVDuJASB0LkwfeKDwIZ/kr8jNwE4POlgrBG
         Sn5i0OkKReODL4wUHvB1VUH9rjE36BzZmMFagAVaOgRMYPgpa++bFdyUTqedF2tgnci7
         QEF235ao/QngNOLqp9Pp1UxOvP/PMiThMcFremsjsYA7/tFBQIkqd6J3BFdaq98Iu5Oi
         7JucVy4+P6CAbweJ5+Zy363XijJH7yRkhVXWVWLOIfgTMbap74ocAj1lqIs7+bcxHHi3
         KfTPAcfQwQogimA7vQPz+JiTzF44cwjgAh6C1vtIZPcTuvc8Yt3xUtN08muPbKJhkKdG
         brFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702781995; x=1703386795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4HtNCasZrLZkpGsmYoGQVdO4D+Mh54IM/kVCP+4Gb4=;
        b=vZTEeADD4rjxG2A7GE7MKM8SyHO/FsK4DTfLu1DGSF8J11lCKoF4B3pRx7Z9+KKi0s
         27e9mO1XW4/KJICrVcjnlJACVS27MaZzipUswz4Xf/FmEX6fhCrJVOZIo4h5PuBJZ8hK
         A5734yQo1qrpIi/Cgx7xV0v20YpxTFnQLwH2a6b1IqfllUX3Xnb40YuJ0ltz9wiUfuKx
         8AFm9lNREKK4z4oavNkam3d42OOa4wDeqmUPR2+F9Nx39fc1M0mf0SdaIbe8wuqxbIR5
         J0ymxhyMI/EaH0QMET2Z/ne8/bkOK5A4mOmX9h3QJ7uvh9Yv0buMB5rFM3i5vWpfguM5
         9b7w==
X-Gm-Message-State: AOJu0YzTHoUoxI8lmIMqTKjZyOnqL0UGAVfjD3+st35hIZ8UtDasvFFB
	bG/eX+UFuU9vidprS0fS9ZsZdQ==
X-Google-Smtp-Source: AGHT+IGT3uENPbLyw7fsMJYbN9YONQutxK0+MtloCKobG5wMGNPJH8Tq5PWzAPGoBlmpr2AgiTNH0w==
X-Received: by 2002:a17:902:c946:b0:1d3:535e:c58 with SMTP id i6-20020a170902c94600b001d3535e0c58mr4597420pla.105.1702781995039;
        Sat, 16 Dec 2023 18:59:55 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:2103:835:39e6:facb:229b? ([2620:10d:c090:400::4:c572])
        by smtp.gmail.com with ESMTPSA id i1-20020a170902c28100b001d3adee1112sm77800pld.272.2023.12.16.18.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 18:59:54 -0800 (PST)
Message-ID: <3ca24281-5ec7-4102-9e01-6e6f826a3a8c@davidwei.uk>
Date: Sat, 16 Dec 2023 18:59:53 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/4] netdevsim: forward skbs from one
 connected port to another
Content-Language: en-GB
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231214212443.3638210-1-dw@davidwei.uk>
 <20231214212443.3638210-3-dw@davidwei.uk> <ZXwuTRFSbDn_ON_E@nanopsycho>
 <ecefd186-0324-42af-9123-cfcd10267cdb@davidwei.uk>
 <ZX1sV50prk_zl4TN@nanopsycho>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZX1sV50prk_zl4TN@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-16 01:22, Jiri Pirko wrote:
> Fri, Dec 15, 2023 at 07:31:42PM CET, dw@davidwei.uk wrote:
>> On 2023-12-15 02:45, Jiri Pirko wrote:
>>> Thu, Dec 14, 2023 at 10:24:41PM CET, dw@davidwei.uk wrote:
>>>> Forward skbs sent from one netdevsim port to its connected netdevsim
>>>> port using dev_forward_skb, in a spirit similar to veth.
>>>
>>> Perhaps better to write "dev_forward_skb()" to make obvious you talk
>>> about function.
>>
>> Sorry, it's a bad habit at this point :)
>>
>>>
>>>
>>>>
>>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>>> ---
>>>> drivers/net/netdevsim/netdev.c | 23 ++++++++++++++++++-----
>>>> 1 file changed, 18 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>>>> index e290c54b0e70..c5f53b1dbdcc 100644
>>>> --- a/drivers/net/netdevsim/netdev.c
>>>> +++ b/drivers/net/netdevsim/netdev.c
>>>> @@ -29,19 +29,33 @@
>>>> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>>> {
>>>> 	struct netdevsim *ns = netdev_priv(dev);
>>>> +	struct netdevsim *peer_ns;
>>>> +	int ret = NETDEV_TX_OK;
>>>>
>>>> +	rcu_read_lock();
>>>
>>> Why do you need to be in rcu read locked section here?
>>
>> So the RCU protected pointer `peer` does not change during the critical
>> section. Veth does something similar in its xmit() for its peer.
> 
> RCU does not work like this. Please check out the documentation.

When destroying a netdevsim in nsim_destroy(), rtnl_lock is held which prevents
concurrent destruction of netdevsims. Then, unregister_netdevice() will
eventually call synchronize_rcu_expedited().

Let's say we have two netdevsims, A linked with B, where A->peer is B and
B->peer is A.

If we're destroying B in nsim_destroy(), then we first do
rcu_assign_pointer(A->peer, NULL). Of course, any read-side critical sections
that dereferenced a non-NULL A->peer won't be affected by this update.

Then B's nsim_destroy() calls unregister_netdevice(), followed eventually by
synchronize_rcu_expedited(). As I understand RCU, this will wait for one RCU
grace period, or any nsim_start_xmit() that started _before_ B's
rcu_assign_pointer(A->peer, NULL) to complete.

RCU docs say that the caller of synchronize_rcu() upon return may be again
concurrent w/ another nsim_start_xmit() reader. But they should see NULL for
A->peer ptr due to the rcu_assign_pointer(A->peer, NULL) update during B's
nsim_destroy(). So after synchronize_rcu() no skb from A should be forwarded to
B anymore.

In fact, it looks like since v5.0 being in a softirq handler serves as an RCU
read-side critical section. So the rcu_read_lock() here in nsim_start_xmit() is
actually redundant.

I believe this is veth's intention too. There is a comment in veth_dellink()
that says the pair of peer devices are guaranteed to be not freed before one
RCU grace period.

As long as adding/removing links is also under rtnl_lock, I think with RCU
guarantees discussed above we will be SMP safe. Does this seem right to you?

> 
> 
>>
>>>
>>>
>>>> 	if (!nsim_ipsec_tx(ns, skb))
>>>> -		goto out;
>>>> +		goto err;
>>>
>>> Not sure why you need to rename the label. Why "out" is not okay?
>>>
>>>>
>>>> 	u64_stats_update_begin(&ns->syncp);
>>>> 	ns->tx_packets++;
>>>> 	ns->tx_bytes += skb->len;
>>>> 	u64_stats_update_end(&ns->syncp);
>>>>
>>>> -out:
>>>> -	dev_kfree_skb(skb);
>>>> +	peer_ns = rcu_dereference(ns->peer);
>>>> +	if (!peer_ns)
>>>> +		goto err;
>>>
>>> This is definitelly not an error path, "err" label name is misleading.
>>
>> That's fair, I can change it back. Lots has changed since my original
>> intentions.
>>
>>>
>>>
>>>> +
>>>> +	skb_tx_timestamp(skb);
>>>> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>>>> +		ret = NET_XMIT_DROP;
>>>
>>> Hmm, can't you track dropped packets in ns->tx_dropped and expose in
>>> nsim_get_stats64() ?
>>
>> I can add this.
>>
>>>
>>>
>>>>
>>>> -	return NETDEV_TX_OK;
>>>> +	rcu_read_unlock();
>>>> +	return ret;
>>>> +
>>>> +err:
>>>> +	rcu_read_unlock();
>>>> +	dev_kfree_skb(skb);
>>>> +	return ret;
>>>> }
>>>>
>>>> static void nsim_set_rx_mode(struct net_device *dev)
>>>> @@ -302,7 +316,6 @@ static void nsim_setup(struct net_device *dev)
>>>> 	eth_hw_addr_random(dev);
>>>>
>>>> 	dev->tx_queue_len = 0;
>>>> -	dev->flags |= IFF_NOARP;
>>>> 	dev->flags &= ~IFF_MULTICAST;
>>>> 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>>>> 			   IFF_NO_QUEUE;
>>>> -- 
>>>> 2.39.3
>>>>

