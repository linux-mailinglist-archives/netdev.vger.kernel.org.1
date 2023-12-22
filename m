Return-Path: <netdev+bounces-59826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABF781C266
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 01:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6A01F227E6
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 00:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158A838A;
	Fri, 22 Dec 2023 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="de8BApsu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C25390
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1053129a12.3
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 16:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703205961; x=1703810761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmBjPxNkAJK1ngFnnGxvUs7wz7MqRrqBk7zRiBCteXs=;
        b=de8BApsu21aHCwb8HmBQFT3N36Vo73RNIZOA/xoKR9tLVA7XkRT3a+onzKslnLJ6FC
         o83iteMZH2EpKBTuyUSZ4/HMIcOCbQ99DijKrXFkdRPrlEe0S8QPIOyR1P28VYW3Z+hP
         0JeWGztoOBPbdg/NQ5Brbe7OsW8Ujy1gZoGcMkPLQokShw8yZwbqx7GeCRLrrnmtV2Ye
         VaZu9kQV9p/F0peb3JVVqF0u8Y5I0Rr3Owrabc+ZQGPu92HXSwqHa9OJgwdP9av6SoE+
         5yH7TQAtrvm41SOv9p1X90Pb42dq+YuxS13nvx0UvjbovRNddTfwq5IlrSNMTr5bK1Ow
         5zuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703205961; x=1703810761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmBjPxNkAJK1ngFnnGxvUs7wz7MqRrqBk7zRiBCteXs=;
        b=W/kml/DNEAHPSbhLwDHbWcOyvXJ4HTY0cq8+JjIoEZL/gR3qoVlA9URtcjHGAH+vwR
         h37l6K8raRi59NMmQnWGvR+YmuBXhZbT8GGWSHRWuL06B2PizFbvpccB6xO5NwTZYeZ9
         ZhEqUD25zZ6ldE2c37W4ugaiaHf3PbPMBKZFLp0KLFF9wCc7AeK/LYLSIWIyxORg7Fzq
         bOBd68zJyGEvY7UQRzvlidfz3VXkQKQIKeNW0u48ZcOpT07Bt5E+wzvhQLj90qBAQoAp
         KkN3xpBfuUtcz1mFSrXIRibFbggeO7pHdKUhf7LkGvj0zwAEv0G3uMVdQcNINrUjSwMQ
         VrDg==
X-Gm-Message-State: AOJu0YypLZs3+iDgvGRdsCbJkVOQSU8WmzSHxJBZOOyHxcLBtyyKuiUg
	Gq7SY9edkVHHRLFLm04AvKm4EoY1uXlGgw==
X-Google-Smtp-Source: AGHT+IFSpKcs7B2MtlRdYjxJuz+5zQWDZemIcc5aIahK0hPXJFbI15HDFx8AJDvcaZ0IogoOfBqG8A==
X-Received: by 2002:a17:902:ee93:b0:1cf:d650:380a with SMTP id a19-20020a170902ee9300b001cfd650380amr533182pld.13.1703205961158;
        Thu, 21 Dec 2023 16:46:01 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c1::14f8? ([2620:10d:c090:400::4:865e])
        by smtp.gmail.com with ESMTPSA id nh24-20020a17090b365800b00287731b0ceasm6022825pjb.13.2023.12.21.16.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 16:46:00 -0800 (PST)
Message-ID: <b09032d1-c9f3-4f44-9815-9d1b2a65068d@davidwei.uk>
Date: Thu, 21 Dec 2023 16:45:58 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/5] netdevsim: maintain a list of probed
 netdevsims
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231220014747.1508581-1-dw@davidwei.uk>
 <20231220014747.1508581-2-dw@davidwei.uk> <ZYKsZdjn-ZOp11L4@nanopsycho>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZYKsZdjn-ZOp11L4@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-20 00:57, Jiri Pirko wrote:
> Wed, Dec 20, 2023 at 02:47:43AM CET, dw@davidwei.uk wrote:
>> This patch adds a linked list nsim_dev_list of probed netdevsims, added
>> during nsim_drv_probe() and removed during nsim_drv_remove(). A mutex
>> nsim_dev_list_lock protects the list.
> 
> In the commit message, you should use imperative mood, command
> the codebase what to do:
> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes

Thanks, I didn't know about this. Will edit the commit messages.

> 
> 
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>> drivers/net/netdevsim/dev.c       | 17 +++++++++++++++++
>> drivers/net/netdevsim/netdevsim.h |  1 +
>> 2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>> index b4d3b9cde8bd..e30a12130e07 100644
>> --- a/drivers/net/netdevsim/dev.c
>> +++ b/drivers/net/netdevsim/dev.c
>> @@ -35,6 +35,9 @@
>>
>> #include "netdevsim.h"
>>
>> +static LIST_HEAD(nsim_dev_list);
>> +static DEFINE_MUTEX(nsim_dev_list_lock);
>> +
>> static unsigned int
>> nsim_dev_port_index(enum nsim_dev_port_type type, unsigned int port_index)
>> {
>> @@ -1531,6 +1534,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>> 				 nsim_bus_dev->initial_net, &nsim_bus_dev->dev);
>> 	if (!devlink)
>> 		return -ENOMEM;
>> +	mutex_lock(&nsim_dev_list_lock);
> 
> I don't follow. You claim you use this mutex to protect the list.
> a) why don't you use spin-lock?

I'm using a mutex unless I know (or someone else who knows better point
out) that a spinlock is better. It is simple, there are fewer gotchas,
and I anticipate actual contention here to be near 0. The
nsim_bus_dev_list is also protected by a mutex.

Is a spinlock better here and if so why?

> b) why don't don't you take the lock just for list manipulation?

Many code paths interact here, touching drivers and netdevs. There is an
ordering of locks being taken:

1. nsim_bus_dev->dev.mutex
2. devlink->lock
3. rtnl_lock

I was careful to avoid deadlocking by acquiring locks in the same order.
But looking at it again, I can reduce the critical section by acquiring
nsim_dev_list_lock after devlink->lock, thanks.

> 
> 
>> 	devl_lock(devlink);
>> 	nsim_dev = devlink_priv(devlink);
>> 	nsim_dev->nsim_bus_dev = nsim_bus_dev;
>> @@ -1544,6 +1548,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>> 	spin_lock_init(&nsim_dev->fa_cookie_lock);
>>
>> 	dev_set_drvdata(&nsim_bus_dev->dev, nsim_dev);
>> +	list_add(&nsim_dev->list, &nsim_dev_list);
>>
>> 	nsim_dev->vfconfigs = kcalloc(nsim_bus_dev->max_vfs,
>> 				      sizeof(struct nsim_vf_config),
>> @@ -1607,6 +1612,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>>
>> 	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_LEGACY;
>> 	devl_unlock(devlink);
>> +	mutex_unlock(&nsim_dev_list_lock);
>> 	return 0;
>>
>> err_hwstats_exit:
>> @@ -1668,8 +1674,18 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
>> {
>> 	struct nsim_dev *nsim_dev = dev_get_drvdata(&nsim_bus_dev->dev);
>> 	struct devlink *devlink = priv_to_devlink(nsim_dev);
>> +	struct nsim_dev *pos, *tmp;
>>
>> +	mutex_lock(&nsim_dev_list_lock);
>> 	devl_lock(devlink);
>> +
>> +	list_for_each_entry_safe(pos, tmp, &nsim_dev_list, list) {
>> +		if (pos == nsim_dev) {
>> +			list_del(&nsim_dev->list);
>> +			break;
>> +		}
>> +	}
>> +
>> 	nsim_dev_reload_destroy(nsim_dev);
>>
>> 	nsim_bpf_dev_exit(nsim_dev);
>> @@ -1681,6 +1697,7 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
>> 	kfree(nsim_dev->vfconfigs);
>> 	kfree(nsim_dev->fa_cookie);
>> 	devl_unlock(devlink);
>> +	mutex_unlock(&nsim_dev_list_lock);
>> 	devlink_free(devlink);
>> 	dev_set_drvdata(&nsim_bus_dev->dev, NULL);
>> }
>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>> index 028c825b86db..babb61d7790b 100644
>> --- a/drivers/net/netdevsim/netdevsim.h
>> +++ b/drivers/net/netdevsim/netdevsim.h
>> @@ -277,6 +277,7 @@ struct nsim_vf_config {
>>
>> struct nsim_dev {
>> 	struct nsim_bus_dev *nsim_bus_dev;
>> +	struct list_head list;
>> 	struct nsim_fib_data *fib_data;
>> 	struct nsim_trap_data *trap_data;
>> 	struct dentry *ddir;
>> -- 
>> 2.39.3
>>

