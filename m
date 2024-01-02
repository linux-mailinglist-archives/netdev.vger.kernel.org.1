Return-Path: <netdev+bounces-60836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E2821A9C
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C881F223D1
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B1FDDB8;
	Tue,  2 Jan 2024 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wdp7xuMC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC58DDA8
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so7284254a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 03:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704193295; x=1704798095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuV9dEqq4UOjbiMUScVPu5oCvMlxOvjWdiBVKhoing8=;
        b=wdp7xuMCzHLyJleAnufJHlQRc5GoOjOR17wgY2GLJIMVdGWk8Yb3PWEaxcuMe5lRRP
         Al/UhW3h21JPZi8Dq+JOvMeeZb2SHaeoXX6QvQiu0mQbEitYJMpcHfeMaJPGeihhgSYZ
         3G34ifyfb2qwPusEM030Nw6lHuCvhEWtTJohxVA/IT12wHHRSu4eEDtZ6aLpBPq1dE5f
         Vhy3m6SnDspd/SF9SwlYvHHDmxTp9LyGAdPmhjhjz3big5yqySFI/V4nhyIcKPd8a/VT
         pckbLT07FTEMPQyPSKYAcuntZaqghoCsHzr9OToU552DivwhcBaii2Tp1jtbj2d3l2Nc
         mlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704193295; x=1704798095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuV9dEqq4UOjbiMUScVPu5oCvMlxOvjWdiBVKhoing8=;
        b=E+CmztEDMwZjSz3PQaF133Vxagd3d+opVUBNRqI706OYFCzAO/IYFnu4LyCbpUAqsN
         S8ZJCtp9HMn3F9ehNAcrsMBstlG38w/k+P48F1O9dlahlxP43sq6/0b0ZWzOaNFyMLVd
         bFuu33CMZtS4JIBDjWM2U3XR48NBFZ12Tdsrpwa2NioLJ1uVmX+K4slSuUUcJdFeU/32
         Pi8LIvI6HVzxLx9UGObMKgJFBosleh0Yo+wqkBeuXSEN2Bre5w5YaeeT0dciAr/r4scR
         9326W/pz5Whyzb9wB+m7gHOK2KpiMUvSRRe+GjhQhpe0cLu35XRhtqHrLSMXE0QKpUMD
         NFkA==
X-Gm-Message-State: AOJu0YxFaPFPenzX1mw89VF3D+Mbcxj1yuLAt5XRIGr0szEuwlQLX4MP
	VvTvQDXy89Gy2piM+wMneht5IOR+hmNohUb/1qQGWcNrUBpjNw==
X-Google-Smtp-Source: AGHT+IFh6GZL9LKYbRvwRR2fPPjBdxf3xgTEPvGsHQ1uZRp409Xf86hweTXSgYPdsnGP2Mke0RQ13A==
X-Received: by 2002:a50:ccc4:0:b0:552:ad20:521d with SMTP id b4-20020a50ccc4000000b00552ad20521dmr11521386edj.40.1704193294767;
        Tue, 02 Jan 2024 03:01:34 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o20-20020aa7c7d4000000b0055537e76e94sm8806038eds.57.2024.01.02.03.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 03:01:34 -0800 (PST)
Date: Tue, 2 Jan 2024 12:01:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 1/5] netdevsim: maintain a list of probed
 netdevsims
Message-ID: <ZZPtDSR0Sf5UsHv0@nanopsycho>
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

Again, what is the purpose of the lock? I was under impression, that you
just need to maintain consistency of the list. Or do you need it for
anything else?


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

