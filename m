Return-Path: <netdev+bounces-61339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A182375A
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 22:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8BF1F25EF3
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 21:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7931DA26;
	Wed,  3 Jan 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="eTTDZt20"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98F1DA24
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d4c767d3a8so12328625ad.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 13:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1704319061; x=1704923861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dF1XseMalDwxXHnPUQtLfZnV6qT5EwIMOLhd4zEwdU8=;
        b=eTTDZt205imrezK8mSnnEFWZKbpk8XdNt7vlajsdA3O92gN2DOEiZMDba1OBfUGsgf
         wuZCg/oGDPHZKB7HdKSvF/f7T6tJx6SfpqyOjQN/3+XIh4368h5o5x9cNJidf5OTX4WU
         mtdPgOV6YtEeSHLZ3ZXDDu8fj8xO3r/fMZ+cDdv1BKltUZtWhRidmM9BnDk0+b7G/iPC
         hJYHQk86JN5iIq7b+xEVirM4jky5OFkpGg+r1rcW3F3SGO9kn5H8/8wpTpCimHhUAUVu
         S0XgLYLg8b5ZtllSL6Lq/Ir8kXN1e7ev+3MSmsI66sIVmqn4VPh7yVjeJx5A6wEMQ45j
         MSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704319061; x=1704923861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dF1XseMalDwxXHnPUQtLfZnV6qT5EwIMOLhd4zEwdU8=;
        b=tA7mm1Yfqomzpy7g+84qYO+RuZDZi1RIAlnxhzK1zaLBehs7Si4mVPX9G1qevakXvv
         XnD2XPmWNYXNkY5L32O+abXnImUjb8HDgttZxLy0rWc6RQ1jMlrdcZbBewRYWry2KmPn
         EdmXI6se+7AJYEyjt4vJ0IQa9B57oXsa12F5EZ1tpw1t5RDmh8KK6iCy5ZyhbF1RHfWK
         Ez6iLPwW891Sd3bHfVPi/c/lWMy+X7a62MILn5/yzyUWjKjwyYvIfuRiIzwYnlARHZst
         xNp8hI0cz2TBY+N0fYh5Hk69vboUgqu75eXayLpE6NraV1jy9MRcU9HqgGCmX2Ta55IO
         gfgw==
X-Gm-Message-State: AOJu0Yy/8xSk1Uop78U0mRL3UgMKvta4Prp5UTiz7QdFuTO1JqIN/6AC
	nqNPGEuxXBu3VZJrwybYChVkAwzHf1Bm7eqM72qNB6Vd5BaBUA2F
X-Google-Smtp-Source: AGHT+IFL0PuHURIZaTpioqW64HIBxDbDukbscPBbQ6nQ5KunHGLxldPpuaRBPh264kI+6JMh/UHiJg==
X-Received: by 2002:a17:902:d506:b0:1d4:1d20:b7af with SMTP id b6-20020a170902d50600b001d41d20b7afmr13214687plg.29.1704319061523;
        Wed, 03 Jan 2024 13:57:41 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:a:897:c73b:17c6:3432? ([2620:10d:c090:500::4:9b01])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e5c100b001cf658f20ecsm24120912plf.96.2024.01.03.13.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 13:57:41 -0800 (PST)
Message-ID: <24f640eb-6f28-4704-855b-afb1dfe06613@davidwei.uk>
Date: Wed, 3 Jan 2024 13:57:40 -0800
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
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
References: <20231228014633.3256862-1-dw@davidwei.uk>
 <20231228014633.3256862-4-dw@davidwei.uk>
 <CANn89iKB4odj7Taw_C-m48BGYmir-fjR-fFbmQj6DbkD+RacXg@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CANn89iKB4odj7Taw_C-m48BGYmir-fjR-fFbmQj6DbkD+RacXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-01-02 03:20, Eric Dumazet wrote:
> On Thu, Dec 28, 2023 at 2:46 AM David Wei <dw@davidwei.uk> wrote:
>>
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
>> concurrent calls to linking two netdevsims together.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  drivers/net/netdevsim/netdev.c    | 21 ++++++++++++++++++---
>>  drivers/net/netdevsim/netdevsim.h |  1 +
>>  2 files changed, 19 insertions(+), 3 deletions(-)
>>
> 
> 
>> @@ -302,7 +318,6 @@ static void nsim_setup(struct net_device *dev)
>>         eth_hw_addr_random(dev);
>>
>>         dev->tx_queue_len = 0;
>> -       dev->flags |= IFF_NOARP;
> 
> This part seems to be unrelated to this patch ?

Hi Eric, I found that this change is needed for skb forwarding to work.
Would you prefer me splitting this change into its own patch?

> 
>>         dev->flags &= ~IFF_MULTICAST;
>>         dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>>                            IFF_NO_QUEUE;

