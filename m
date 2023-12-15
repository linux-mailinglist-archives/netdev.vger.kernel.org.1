Return-Path: <netdev+bounces-58088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822C1814FC5
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 19:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB941F21130
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB7F1DFFF;
	Fri, 15 Dec 2023 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="VK2doHdV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C9E1CF8D
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6cebbf51742so747124b3a.1
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 10:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702665105; x=1703269905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHhNylZvWxKrymEq2Ohe9dJxeQa7/IOYKx/BHydQeQs=;
        b=VK2doHdVaUElwW7G2QzKNfr+40DVphdfZhw88XlhGNIe2QfezUK8wWMFIGECIIRGjR
         IH4Abhncy53CsTppE95TUCrp5WKxfmakQXkhRrslHlTia6xFN/lyukYrh7v1Uq01KFJW
         g9CmXJxkTT3YSPgjvz++OBOj4Kg53amFR3Fv5SMWOFweTkN3FFbCYI6T0AlxCqX0NuD9
         5bkA7ethnMzy/sOi48fD+iWKLjw9Eg2OKvZp2qSkxAs/AszLjDZQNLCxZPfG0/if1M41
         nWZoRbPiFXerCgbO4fIKc0ftveg2X8OQ4tIIWzY/XZ6XYUoJIY24Ovlohiq91aHZznSW
         QVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702665105; x=1703269905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHhNylZvWxKrymEq2Ohe9dJxeQa7/IOYKx/BHydQeQs=;
        b=vM4bn/CY7VULL6Rpc0gXqvs8rm3nMUaI55jtCPWs078fy6Vp3xFQaQKliu+WHjfctv
         jMNMYa0GkmejExTFmtG647IPycrlkoG2Ud0/1qpIJe/lG3JYzDH5o1buO1e8+yZgig7D
         kU4f4752KTd3djPR9fxx6GibeqopIs5Tv9MZrv58AnLx/SHO3n4RqrvEMp6eR7Sdn9Do
         eKTUf+zzZKUD/JtayYP03OcakBNJVpmjot7WyzQALgT1YGGssCSUYJPEUPo2N9WAtvIH
         /9wzvnHCdrH6sqK13cdnQ39Yfgd/kcVzztWpwpFL0IZbm3R26umqRbhR4r1p6gEDHLlY
         urqw==
X-Gm-Message-State: AOJu0YwSQmZtCdEGd2N3pH+Iq3F2XlXVTg+PQmn1xlG3a2t4ARMox8ez
	m4/Dx6/NS2CzPs3OXeK7AxF5Wg==
X-Google-Smtp-Source: AGHT+IFpn36jgGDTOTZ/o+DqHYKNAcNzab23ijJOjqFd/JIlKVZ4yXwxC0Ia8qf+QhmHyTMXXzgWQA==
X-Received: by 2002:a05:6a00:10cc:b0:6ce:71af:842b with SMTP id d12-20020a056a0010cc00b006ce71af842bmr14367840pfu.8.1702665104771;
        Fri, 15 Dec 2023 10:31:44 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::5:b356])
        by smtp.gmail.com with ESMTPSA id ff14-20020a056a002f4e00b006ce7a834b1bsm13760766pfb.58.2023.12.15.10.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 10:31:44 -0800 (PST)
Message-ID: <ecefd186-0324-42af-9123-cfcd10267cdb@davidwei.uk>
Date: Fri, 15 Dec 2023 10:31:42 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/4] netdevsim: forward skbs from one
 connected port to another
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231214212443.3638210-1-dw@davidwei.uk>
 <20231214212443.3638210-3-dw@davidwei.uk> <ZXwuTRFSbDn_ON_E@nanopsycho>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZXwuTRFSbDn_ON_E@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-15 02:45, Jiri Pirko wrote:
> Thu, Dec 14, 2023 at 10:24:41PM CET, dw@davidwei.uk wrote:
>> Forward skbs sent from one netdevsim port to its connected netdevsim
>> port using dev_forward_skb, in a spirit similar to veth.
> 
> Perhaps better to write "dev_forward_skb()" to make obvious you talk
> about function.

Sorry, it's a bad habit at this point :)

> 
> 
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>> drivers/net/netdevsim/netdev.c | 23 ++++++++++++++++++-----
>> 1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>> index e290c54b0e70..c5f53b1dbdcc 100644
>> --- a/drivers/net/netdevsim/netdev.c
>> +++ b/drivers/net/netdevsim/netdev.c
>> @@ -29,19 +29,33 @@
>> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>> {
>> 	struct netdevsim *ns = netdev_priv(dev);
>> +	struct netdevsim *peer_ns;
>> +	int ret = NETDEV_TX_OK;
>>
>> +	rcu_read_lock();
> 
> Why do you need to be in rcu read locked section here?

So the RCU protected pointer `peer` does not change during the critical
section. Veth does something similar in its xmit() for its peer.

> 
> 
>> 	if (!nsim_ipsec_tx(ns, skb))
>> -		goto out;
>> +		goto err;
> 
> Not sure why you need to rename the label. Why "out" is not okay?
> 
>>
>> 	u64_stats_update_begin(&ns->syncp);
>> 	ns->tx_packets++;
>> 	ns->tx_bytes += skb->len;
>> 	u64_stats_update_end(&ns->syncp);
>>
>> -out:
>> -	dev_kfree_skb(skb);
>> +	peer_ns = rcu_dereference(ns->peer);
>> +	if (!peer_ns)
>> +		goto err;
> 
> This is definitelly not an error path, "err" label name is misleading.

That's fair, I can change it back. Lots has changed since my original
intentions.

> 
> 
>> +
>> +	skb_tx_timestamp(skb);
>> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
>> +		ret = NET_XMIT_DROP;
> 
> Hmm, can't you track dropped packets in ns->tx_dropped and expose in
> nsim_get_stats64() ?

I can add this.

> 
> 
>>
>> -	return NETDEV_TX_OK;
>> +	rcu_read_unlock();
>> +	return ret;
>> +
>> +err:
>> +	rcu_read_unlock();
>> +	dev_kfree_skb(skb);
>> +	return ret;
>> }
>>
>> static void nsim_set_rx_mode(struct net_device *dev)
>> @@ -302,7 +316,6 @@ static void nsim_setup(struct net_device *dev)
>> 	eth_hw_addr_random(dev);
>>
>> 	dev->tx_queue_len = 0;
>> -	dev->flags |= IFF_NOARP;
>> 	dev->flags &= ~IFF_MULTICAST;
>> 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>> 			   IFF_NO_QUEUE;
>> -- 
>> 2.39.3
>>

