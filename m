Return-Path: <netdev+bounces-59851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575C281C475
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 05:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1081F284109
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 04:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC16D6FD;
	Fri, 22 Dec 2023 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="FYFbvffS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE278F58
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6da5d410432so1088388a34.2
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 20:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703220883; x=1703825683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxctZQusd6bBRe1zeqqjjQDcp9DdNMcDk9VOdMbD+HY=;
        b=FYFbvffSLotgZ/48aBj1qwV46+kJ0I/co0RgzJqX6EYc8cNMItpTM3n5JC0owSaPlb
         lUhiMZk7zZAflcA1b96iuRqPkRzUsWo17qq/yz75wn3kzS0VL5zXrI6TjKduAEdlT4VW
         KXXYsbZHdzd6wilo2VVY3WZ5ifOX+gie6EXwxXy0z/ZP3h/riuBdJcbupqB23mB4Tes2
         a907cHm/OrL25XVhbkBorHIWIi5ESGcZu02edTZE9CgyTBhH6SnyJIoPkVYFt1HhjYxg
         +ttLEs8F44543rkdUtlwUUSZd4aYyuv6QKxwa0Fdlm7roSgQ+7ul4hplh9uO+HsX372u
         E6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703220883; x=1703825683;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxctZQusd6bBRe1zeqqjjQDcp9DdNMcDk9VOdMbD+HY=;
        b=h7KR9/SHtbJMQzxGik0xd6vUPj2K2Cr64GKXS6VSOr4kWFtm1BzAXyQTVkM1kfmpsc
         DMyqVRF5JjTC9dqxL9CskWAqmyo/ZeXntogQpCDDZiB+dXNtFVkmOTRkl5N7iWu9fo0F
         +dju+EHYxV9w15Z5F1yUoqIqyebtcrcNb84yha2qWV6n4rq4uJs6GiiQMLjWehiylCbc
         4Za8wdDOfglGvZwUtk838AIvaVG669yqdBxSPS69biW+x5OWKsmNVJxpmoWIevNAYS6x
         IdtatZR93oJlgkcq1fPbv7KWEo1fyh4qnsYjqDPgRvVz/a01suEKWriBUW+aXKtUVvK+
         KIzA==
X-Gm-Message-State: AOJu0YwKDxuG+Wpo/U7F+z9qSHP5pxCZ2IN8GZqj8fnIFIN4QNOto/La
	HqH0Ku3DxNAC9+d2JGdFAodK+v7hwOVv/w==
X-Google-Smtp-Source: AGHT+IFlGJM4LTU3qKlH5NCR9oqFjYeEVj29Ryp5x641uQkLKaR/3ddA5Hrr5CeVeoEWigh8teBt+g==
X-Received: by 2002:a9d:65c2:0:b0:6db:af9a:b3c5 with SMTP id z2-20020a9d65c2000000b006dbaf9ab3c5mr700589oth.41.1703220883318;
        Thu, 21 Dec 2023 20:54:43 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c1::1007? ([2620:10d:c090:400::4:b6d3])
        by smtp.gmail.com with ESMTPSA id o23-20020a63e357000000b005c66a7d70fdsm2163702pgj.61.2023.12.21.20.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 20:54:42 -0800 (PST)
Message-ID: <33935a3b-4064-4d85-b3f7-c5e51b8dce5b@davidwei.uk>
Date: Thu, 21 Dec 2023 20:54:25 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/5] netdevsim: maintain a list of probed
 netdevsims
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231220014747.1508581-1-dw@davidwei.uk>
 <20231220014747.1508581-2-dw@davidwei.uk> <ZYKsZdjn-ZOp11L4@nanopsycho>
 <b09032d1-c9f3-4f44-9815-9d1b2a65068d@davidwei.uk>
In-Reply-To: <b09032d1-c9f3-4f44-9815-9d1b2a65068d@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-21 16:45, David Wei wrote:
> On 2023-12-20 00:57, Jiri Pirko wrote:
>> Wed, Dec 20, 2023 at 02:47:43AM CET, dw@davidwei.uk wrote:
>>> This patch adds a linked list nsim_dev_list of probed netdevsims, added
>>> during nsim_drv_probe() and removed during nsim_drv_remove(). A mutex
>>> nsim_dev_list_lock protects the list.
>>
>> In the commit message, you should use imperative mood, command
>> the codebase what to do:
>> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes
> 
> Thanks, I didn't know about this. Will edit the commit messages.
> 
>>
>>
>>>
>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>> ---
>>> drivers/net/netdevsim/dev.c       | 17 +++++++++++++++++
>>> drivers/net/netdevsim/netdevsim.h |  1 +
>>> 2 files changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>>> index b4d3b9cde8bd..e30a12130e07 100644
>>> --- a/drivers/net/netdevsim/dev.c
>>> +++ b/drivers/net/netdevsim/dev.c
>>> @@ -35,6 +35,9 @@
>>>
>>> #include "netdevsim.h"
>>>
>>> +static LIST_HEAD(nsim_dev_list);
>>> +static DEFINE_MUTEX(nsim_dev_list_lock);
>>> +
>>> static unsigned int
>>> nsim_dev_port_index(enum nsim_dev_port_type type, unsigned int port_index)
>>> {
>>> @@ -1531,6 +1534,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>>> 				 nsim_bus_dev->initial_net, &nsim_bus_dev->dev);
>>> 	if (!devlink)
>>> 		return -ENOMEM;
>>> +	mutex_lock(&nsim_dev_list_lock);
>>
>> I don't follow. You claim you use this mutex to protect the list.
>> a) why don't you use spin-lock?
> 
> I'm using a mutex unless I know (or someone else who knows better point
> out) that a spinlock is better. It is simple, there are fewer gotchas,
> and I anticipate actual contention here to be near 0. The
> nsim_bus_dev_list is also protected by a mutex.
> 
> Is a spinlock better here and if so why?
> 
>> b) why don't don't you take the lock just for list manipulation?
> 
> Many code paths interact here, touching drivers and netdevs. There is an
> ordering of locks being taken:
> 
> 1. nsim_bus_dev->dev.mutex
> 2. devlink->lock
> 3. rtnl_lock
> 
> I was careful to avoid deadlocking by acquiring locks in the same order.
> But looking at it again, I can reduce the critical section by acquiring
> nsim_dev_list_lock after devlink->lock, thanks.

Looking at this again, I need to prevent concurrent nsim_dev
modifications _and_ nsim_dev_port modifications. This is because
nsim_dev_peer_write() needs to traverse both of those lists to link up
two netdevsims.

I cannot use the existing devlink->lock for this, because to take it in
nsim_dev_peer_write() I need to first safely get a nsim_dev. That's why
in the patch I take nsim_dev_list_lock early with a seemingly large
critical section.

I think the following locking scheme would work:

In nsim_drv_probe():

1. Take nsim_dev_list_lock
2. Take devlink->lock
3. Construct nsim_dev
4. Construct all nsim_dev_ports
  a. Take rtnl_lock for each netdevsim port
5. Add to nsim_dev_list
6. Release devlink->lock
7. Release nsim_dev_list_lock

Maybe 5 and 6 can be swapped, but I don't think it matters.

In nsim_drv_remove():

1. Take nsim_dev_list_lock
2. Take devlink->lock
3. Remove from nsim_dev_list
4. Destroy nsim_dev
5. Destroy all nsim_dev_ports
  a. During which, take rtnl_lock for each netdevsim
6. Release devlink->lock
7. Release nsim_dev_list_lock

Similarly, maybe 2 and 3 can be swapped.

In nsim_drv_port_add():

1. Take devlink->lock
2. Take rtnl_lock and create netdevsim
3. Add to port_list
4. Release devlink->lock

In nsim_dev_port_del():

1. Take devlink->lock
2. Remove from port_list
3. Take rtnl_lock and destroy netdevsim
4. Release devlink->lock

In nsim_dev_peer_write():

1. Take nsim_dev_list_lock
   No concurrent modifications to nsim_dev_list, get peer nsim_dev
2. Take devlink->lock
   No concurrent modifications to port_list, get peer port and check
   current port in private_data still exists
3. Do the linking
4. Release devlink->lock
5. Release nsim_dev_list_lock

In v4 I am taking rtnl_lock which may be a mistake. I don't know if
there are other code paths that can modify a netdevsim's underlying
net_device without taking devlink lock. If so, then I'd also need to
take rtnl_lock after devlink->lock.

> 
>>
>>
>>> 	devl_lock(devlink);
>>> 	nsim_dev = devlink_priv(devlink);
>>> 	nsim_dev->nsim_bus_dev = nsim_bus_dev;
>>> @@ -1544,6 +1548,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>>> 	spin_lock_init(&nsim_dev->fa_cookie_lock);
>>>
>>> 	dev_set_drvdata(&nsim_bus_dev->dev, nsim_dev);
>>> +	list_add(&nsim_dev->list, &nsim_dev_list);
>>>
>>> 	nsim_dev->vfconfigs = kcalloc(nsim_bus_dev->max_vfs,
>>> 				      sizeof(struct nsim_vf_config),
>>> @@ -1607,6 +1612,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>>>
>>> 	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_LEGACY;
>>> 	devl_unlock(devlink);
>>> +	mutex_unlock(&nsim_dev_list_lock);
>>> 	return 0;
>>>
>>> err_hwstats_exit:
>>> @@ -1668,8 +1674,18 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
>>> {
>>> 	struct nsim_dev *nsim_dev = dev_get_drvdata(&nsim_bus_dev->dev);
>>> 	struct devlink *devlink = priv_to_devlink(nsim_dev);
>>> +	struct nsim_dev *pos, *tmp;
>>>
>>> +	mutex_lock(&nsim_dev_list_lock);
>>> 	devl_lock(devlink);
>>> +
>>> +	list_for_each_entry_safe(pos, tmp, &nsim_dev_list, list) {
>>> +		if (pos == nsim_dev) {
>>> +			list_del(&nsim_dev->list);
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> 	nsim_dev_reload_destroy(nsim_dev);
>>>
>>> 	nsim_bpf_dev_exit(nsim_dev);
>>> @@ -1681,6 +1697,7 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
>>> 	kfree(nsim_dev->vfconfigs);
>>> 	kfree(nsim_dev->fa_cookie);
>>> 	devl_unlock(devlink);
>>> +	mutex_unlock(&nsim_dev_list_lock);
>>> 	devlink_free(devlink);
>>> 	dev_set_drvdata(&nsim_bus_dev->dev, NULL);
>>> }
>>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>>> index 028c825b86db..babb61d7790b 100644
>>> --- a/drivers/net/netdevsim/netdevsim.h
>>> +++ b/drivers/net/netdevsim/netdevsim.h
>>> @@ -277,6 +277,7 @@ struct nsim_vf_config {
>>>
>>> struct nsim_dev {
>>> 	struct nsim_bus_dev *nsim_bus_dev;
>>> +	struct list_head list;
>>> 	struct nsim_fib_data *fib_data;
>>> 	struct nsim_trap_data *trap_data;
>>> 	struct dentry *ddir;
>>> -- 
>>> 2.39.3
>>>

