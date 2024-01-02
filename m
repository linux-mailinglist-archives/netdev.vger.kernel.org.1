Return-Path: <netdev+bounces-60834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69AE821A90
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305041F22438
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4294D52C;
	Tue,  2 Jan 2024 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="n4JJFhXy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57866E545
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d76923ec4so31673295e9.3
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 02:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704192926; x=1704797726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLMR5wS3IoGGRf8c5X8kccEUSYURU+NmbvlUckN/Og0=;
        b=n4JJFhXyJthROQHzDZ7zRmQ0xY2VwrjCwLRePL9Fc5tGRmpSb9J00mo3JZdRUrqPhl
         oko+O8JIWRaYh60FolxIlOTy2OT1JllA0dZPYNeTlj/sce8nVlhNqnPQQQ4K5ETBjGOw
         qoJ5u9mc5gQWFyukt+OLxrTIoEDWAJ2HnZden0a2SqrkRPkCsC4BrIqhxFePzpY5WsIk
         k+RkSY0ahs/NC/4gObiOpm+SpBXtcDsD0Vm9alFGvOdEJsOav13EHXLw44wwNQv78So6
         kGX6ry2FglKcyNo/6E8qDgEEP2ZZbDabvMVcEm9Sr6VXxgX4aOo7KWK2Qr0f3Vq6qf1Q
         7wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704192926; x=1704797726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLMR5wS3IoGGRf8c5X8kccEUSYURU+NmbvlUckN/Og0=;
        b=UDJMKriUShOa9Kg0BbwUQdsVPTtpJ9hRsppbyUfeiEr0lyRDgEdc61LsmluuWpyVOA
         SnKhkZNJHHyUOv1sHZqH1ijaR6vX3W1n5k4MMueCzwS9/+xSknnbo2UGVom9y/vHqeoQ
         Ml/FKotouf5SPw8wHRch971VhLsa1oy6SyO0wAQCIF2ASdX+oixXTMnV9u+EBySrLwRk
         ffZli9pU9zEIaf9mfK54C/+XUtO4p9kV2sJO/zZqZB0uPSBYu3EPxmkMsHZVBK/RMxeG
         DAvQca7PMLMASN7LP253kMLBbH+uJJo/0/T8/64VLoa5IKrMTOoigqz0vUYtkpsBB8Au
         mJ+Q==
X-Gm-Message-State: AOJu0YzTt+psfhQjuw8kdHG0cqc0y6h6WLXtnPnKmfutCwXHA/oOSw6t
	H0uTCRpLLwXiHYTcYSIBWmxHDlOSVk2qKesM0mvB1f/VgzyvIw==
X-Google-Smtp-Source: AGHT+IE6TMSgbO7zSF5/xAwH/oQkJFXpm6ZbKbiezqtRtsdlBaNfuja7rLWvY1vk5teAPk8pg71e+A==
X-Received: by 2002:a05:600c:19cc:b0:40d:5f8a:5b13 with SMTP id u12-20020a05600c19cc00b0040d5f8a5b13mr4787536wmq.65.1704192926242;
        Tue, 02 Jan 2024 02:55:26 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id je22-20020a05600c1f9600b0040d7d6280c2sm14464985wmb.7.2024.01.02.02.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 02:55:25 -0800 (PST)
Date: Tue, 2 Jan 2024 11:55:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 1/5] netdevsim: maintain a list of probed
 netdevsims
Message-ID: <ZZPrnC8MYKnXqIS_@nanopsycho>
References: <20231220014747.1508581-1-dw@davidwei.uk>
 <20231220014747.1508581-2-dw@davidwei.uk>
 <ZYKsZdjn-ZOp11L4@nanopsycho>
 <b09032d1-c9f3-4f44-9815-9d1b2a65068d@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b09032d1-c9f3-4f44-9815-9d1b2a65068d@davidwei.uk>

Fri, Dec 22, 2023 at 01:45:58AM CET, dw@davidwei.uk wrote:
>On 2023-12-20 00:57, Jiri Pirko wrote:
>> Wed, Dec 20, 2023 at 02:47:43AM CET, dw@davidwei.uk wrote:
>>> This patch adds a linked list nsim_dev_list of probed netdevsims, added
>>> during nsim_drv_probe() and removed during nsim_drv_remove(). A mutex
>>> nsim_dev_list_lock protects the list.
>> 
>> In the commit message, you should use imperative mood, command
>> the codebase what to do:
>> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes
>
>Thanks, I didn't know about this. Will edit the commit messages.
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
>I'm using a mutex unless I know (or someone else who knows better point
>out) that a spinlock is better. It is simple, there are fewer gotchas,
>and I anticipate actual contention here to be near 0. The
>nsim_bus_dev_list is also protected by a mutex.
>
>Is a spinlock better here and if so why?

spinlock has lower overhead. If you don't need to sleep with the lock,
spinlock is probably better for you.


>
>> b) why don't don't you take the lock just for list manipulation?
>
>Many code paths interact here, touching drivers and netdevs. There is an
>ordering of locks being taken:
>
>1. nsim_bus_dev->dev.mutex
>2. devlink->lock
>3. rtnl_lock
>
>I was careful to avoid deadlocking by acquiring locks in the same order.
>But looking at it again, I can reduce the critical section by acquiring
>nsim_dev_list_lock after devlink->lock, thanks.
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

