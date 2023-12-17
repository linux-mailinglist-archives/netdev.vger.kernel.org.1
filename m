Return-Path: <netdev+bounces-58341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 495DB815EC0
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 12:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91411F21E27
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 11:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A47432182;
	Sun, 17 Dec 2023 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DpWS2H2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D40F30FB9
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3363aa1b7d2so1915971f8f.0
        for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 03:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702813009; x=1703417809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zdlJHhAnJHw/qEwb0EYZSsEQ2pViiaD0tDI2i5QkEng=;
        b=DpWS2H2gMaV6H+U9ElVO6jHNZxWPkjM4fbYj/V92EyhP5k5d9WMk3pmqzbTfn5Iba0
         qkXii8+nwqsksNUujC5zO19uXM8FkRClxurpS9BrmbLQlTxcUu0wUsuztCkHHNkjF5kj
         +QmAZQNJBvsKUUSrDmD6EYa7ugG71OGXtOJKAppCMz2+H/wNaz6w79ZSeFcLXH30EWnW
         iUY7/Im35uth9qj/N0ZQsA1I9/0dt0U09/qsGpgIzzBmVVSExA3pm/y0I2BEeqzGTMp7
         4R7VHauuN1F9zoqExyo1WzacYAgkijSGGSUN9VMkhIj0+nYtM1/O3EIb9BBpYVt8uG2P
         LuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702813009; x=1703417809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdlJHhAnJHw/qEwb0EYZSsEQ2pViiaD0tDI2i5QkEng=;
        b=L9z+Kc0HG1+WulpxbLOnpdcdTPfuiWn400cfbNuoldFPUWCXk6NUVIZdZ0Wvwitnbh
         sYkAHM8HUxAdh9btz4RIyGKnvdzy3eAw2FQ0YF3Thqe6BfjGZao8oSMs/IZw/sFFG/vq
         Dp/4ZnfvK5qNeT7H+DI2ThpZWBR/o6b7WE/mLvlVfVfkcHltq2nZ1RdTaq4b+UKau6oM
         WUiFG1gJlRHrMPvRUp83XVOom7icqjPgiD7APWpUdN5v3S1AXAK4i+tAe0EEJMH9YGOx
         sT/gqpFhb9aa+lWCA9BBt4ct8TOhKIx9Vaj4E42tFLCY1bNh12ayYlr1uXSJ1XoPTm7z
         BdfQ==
X-Gm-Message-State: AOJu0Yw4oryVvIskQblBT58UCsn+wm0nryPn6p0d8bnLpCLo+OpIZ0RU
	Ds/gRd/daOpXJN/C/8YA+nPu6Q==
X-Google-Smtp-Source: AGHT+IFHvNRhKJ1frke6vLo/fNm7Xc11fQFSvlmey1vTMeqd4q01dQAa4qXp+RBSIiYnshCqF3lJew==
X-Received: by 2002:a5d:6e83:0:b0:333:2fd2:3bb7 with SMTP id k3-20020a5d6e83000000b003332fd23bb7mr4511808wrz.112.1702813009098;
        Sun, 17 Dec 2023 03:36:49 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d62c2000000b003366796301csm226922wrv.0.2023.12.17.03.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 03:36:48 -0800 (PST)
Date: Sun, 17 Dec 2023 12:36:46 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/4] netdevsim: forward skbs from one
 connected port to another
Message-ID: <ZX7dTtwmMHFVMhNv@nanopsycho>
References: <20231214212443.3638210-1-dw@davidwei.uk>
 <20231214212443.3638210-3-dw@davidwei.uk>
 <ZXwuTRFSbDn_ON_E@nanopsycho>
 <ecefd186-0324-42af-9123-cfcd10267cdb@davidwei.uk>
 <ZX1sV50prk_zl4TN@nanopsycho>
 <3ca24281-5ec7-4102-9e01-6e6f826a3a8c@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ca24281-5ec7-4102-9e01-6e6f826a3a8c@davidwei.uk>

Sun, Dec 17, 2023 at 03:59:53AM CET, dw@davidwei.uk wrote:
>On 2023-12-16 01:22, Jiri Pirko wrote:
>> Fri, Dec 15, 2023 at 07:31:42PM CET, dw@davidwei.uk wrote:
>>> On 2023-12-15 02:45, Jiri Pirko wrote:
>>>> Thu, Dec 14, 2023 at 10:24:41PM CET, dw@davidwei.uk wrote:
>>>>> Forward skbs sent from one netdevsim port to its connected netdevsim
>>>>> port using dev_forward_skb, in a spirit similar to veth.
>>>>
>>>> Perhaps better to write "dev_forward_skb()" to make obvious you talk
>>>> about function.
>>>
>>> Sorry, it's a bad habit at this point :)
>>>
>>>>
>>>>
>>>>>
>>>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>>>> ---
>>>>> drivers/net/netdevsim/netdev.c | 23 ++++++++++++++++++-----
>>>>> 1 file changed, 18 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>>>>> index e290c54b0e70..c5f53b1dbdcc 100644
>>>>> --- a/drivers/net/netdevsim/netdev.c
>>>>> +++ b/drivers/net/netdevsim/netdev.c
>>>>> @@ -29,19 +29,33 @@
>>>>> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>>>> {
>>>>> 	struct netdevsim *ns = netdev_priv(dev);
>>>>> +	struct netdevsim *peer_ns;
>>>>> +	int ret = NETDEV_TX_OK;
>>>>>
>>>>> +	rcu_read_lock();
>>>>
>>>> Why do you need to be in rcu read locked section here?
>>>
>>> So the RCU protected pointer `peer` does not change during the critical
>>> section. Veth does something similar in its xmit() for its peer.
>> 
>> RCU does not work like this. Please check out the documentation.
>
>When destroying a netdevsim in nsim_destroy(), rtnl_lock is held which prevents
>concurrent destruction of netdevsims. Then, unregister_netdevice() will
>eventually call synchronize_rcu_expedited().
>
>Let's say we have two netdevsims, A linked with B, where A->peer is B and
>B->peer is A.
>
>If we're destroying B in nsim_destroy(), then we first do
>rcu_assign_pointer(A->peer, NULL). Of course, any read-side critical sections
>that dereferenced a non-NULL A->peer won't be affected by this update.
>
>Then B's nsim_destroy() calls unregister_netdevice(), followed eventually by
>synchronize_rcu_expedited(). As I understand RCU, this will wait for one RCU
>grace period, or any nsim_start_xmit() that started _before_ B's
>rcu_assign_pointer(A->peer, NULL) to complete.
>
>RCU docs say that the caller of synchronize_rcu() upon return may be again
>concurrent w/ another nsim_start_xmit() reader. But they should see NULL for
>A->peer ptr due to the rcu_assign_pointer(A->peer, NULL) update during B's
>nsim_destroy(). So after synchronize_rcu() no skb from A should be forwarded to
>B anymore.
>
>In fact, it looks like since v5.0 being in a softirq handler serves as an RCU
>read-side critical section. So the rcu_read_lock() here in nsim_start_xmit() is
>actually redundant.
>
>I believe this is veth's intention too. There is a comment in veth_dellink()
>that says the pair of peer devices are guaranteed to be not freed before one
>RCU grace period.
>
>As long as adding/removing links is also under rtnl_lock, I think with RCU
>guarantees discussed above we will be SMP safe. Does this seem right to you?
>
>> 
>> 
>>>
>>>>
>>>>
>>>>> 	if (!nsim_ipsec_tx(ns, skb))
>>>>> -		goto out;
>>>>> +		goto err;
>>>>
>>>> Not sure why you need to rename the label. Why "out" is not okay?
>>>>
>>>>>
>>>>> 	u64_stats_update_begin(&ns->syncp);
>>>>> 	ns->tx_packets++;
>>>>> 	ns->tx_bytes += skb->len;
>>>>> 	u64_stats_update_end(&ns->syncp);
>>>>>
>>>>> -out:
>>>>> -	dev_kfree_skb(skb);


My point is, why don't take rcu_read_lock() here.


>>>>> +	peer_ns = rcu_dereference(ns->peer);
>>>>> +	if (!peer_ns)
>>>>> +		goto err;
>>>>
>>>> This is definitelly not an error path, "err" label name is misleading.
>>>
>>> That's fair, I can change it back. Lots has changed since my original
>>> intentions.
>>>
>>>>
>>>>
>>>>> +
>>>>> +	skb_tx_timestamp(skb);
>>>>> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>>>>> +		ret = NET_XMIT_DROP;
>>>>
>>>> Hmm, can't you track dropped packets in ns->tx_dropped and expose in
>>>> nsim_get_stats64() ?
>>>
>>> I can add this.
>>>
>>>>
>>>>
>>>>>
>>>>> -	return NETDEV_TX_OK;
>>>>> +	rcu_read_unlock();
>>>>> +	return ret;
>>>>> +
>>>>> +err:
>>>>> +	rcu_read_unlock();
>>>>> +	dev_kfree_skb(skb);
>>>>> +	return ret;
>>>>> }
>>>>>
>>>>> static void nsim_set_rx_mode(struct net_device *dev)
>>>>> @@ -302,7 +316,6 @@ static void nsim_setup(struct net_device *dev)
>>>>> 	eth_hw_addr_random(dev);
>>>>>
>>>>> 	dev->tx_queue_len = 0;
>>>>> -	dev->flags |= IFF_NOARP;
>>>>> 	dev->flags &= ~IFF_MULTICAST;
>>>>> 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>>>>> 			   IFF_NO_QUEUE;
>>>>> -- 
>>>>> 2.39.3
>>>>>

