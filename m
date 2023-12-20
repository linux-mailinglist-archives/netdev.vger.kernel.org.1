Return-Path: <netdev+bounces-59178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A341B819B05
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 09:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBD41C25879
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE1F1CA9A;
	Wed, 20 Dec 2023 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QWxxkVe4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D11F619
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-553ba2f0c8fso763084a12.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 00:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1703062631; x=1703667431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IEnqSCPt7vUlkl/75m/D/rV7ai0B3mDjespBowAGqdw=;
        b=QWxxkVe4T/dYb0MGmzq1wceWIamlOpyrtfyQPJa0CrqZrX27LysJE4cTHeAMs8flZu
         KQVRxzuRvXfrvJCsGi366UDy4FbOFXg4mHDAAOjWeW4io+sypZUjvxLv2I1VIKkJo8XR
         /aJG3mJaw/y5K54n2usYKpc97B6uk1aNrpXS68gVfsYHAt1NvTc5wBZWFYyQ9ve5YyCk
         ME9tgPBVFlopDLik5rrh/CAv0PhfGfwF4yf+xno0w+n4oHzJ+hkTu0NHtjo3nokHXsby
         IoiT+eFBn3Lp8aw4pehBkyMG7lxh+qTTMVlNzxnbNGrhPXeSED9F5RbZ4NZkVV5y/oZw
         D2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703062631; x=1703667431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEnqSCPt7vUlkl/75m/D/rV7ai0B3mDjespBowAGqdw=;
        b=NfvwIADii7+sl6zK/GGCNrRfpmNatbdmUrNICWOCxvlN5ZllZaJF4EtpxHh2dW/jaX
         QgRqoHOqW4u5pMMTDLtOsBbOx68uwuKd1LYVTtxXw9HyJitGQR0qXrDFhCQzjMoMiC8e
         vwjBfrULFzdJ2zBReCdZYKFfvaDmJMQsZs3Fhs8AfWJExd4N/5lZxJLzMgfOYSf8uF03
         r5HHun6RIvNExZUR22sHe5UwfUzDpTWfdaJyiYt7tqe7lndI4OgzC6gn04gZwnChRkVB
         f/AENvtrLsTncyTTH5iSbMEYHoxo5qcB18M9079Mxh52MvH+Bloxk8oo/CsHUUgvqhMq
         UOpA==
X-Gm-Message-State: AOJu0YxHbJ7ZMtps4rPgxZWVydlHozOTPWIWpekUUn80sKRzMg5VLomb
	y9OwllH56p/s5BiAQ94z4wDAIJQktnpA2wM5iuU=
X-Google-Smtp-Source: AGHT+IGiWLLG1AjDvxkCP+uBSuUdmjUYyycT2JXa+ixuF2DvXUSmRQ3Dtp8OQFcgJqoCqs6XfnqQSw==
X-Received: by 2002:a50:c90c:0:b0:548:68a3:618e with SMTP id o12-20020a50c90c000000b0054868a3618emr5574610edh.9.1703062630842;
        Wed, 20 Dec 2023 00:57:10 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id fi8-20020a056402550800b005528001d5c6sm6048384edb.62.2023.12.20.00.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:57:10 -0800 (PST)
Date: Wed, 20 Dec 2023 09:57:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 1/5] netdevsim: maintain a list of probed
 netdevsims
Message-ID: <ZYKsZdjn-ZOp11L4@nanopsycho>
References: <20231220014747.1508581-1-dw@davidwei.uk>
 <20231220014747.1508581-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220014747.1508581-2-dw@davidwei.uk>

Wed, Dec 20, 2023 at 02:47:43AM CET, dw@davidwei.uk wrote:
>This patch adds a linked list nsim_dev_list of probed netdevsims, added
>during nsim_drv_probe() and removed during nsim_drv_remove(). A mutex
>nsim_dev_list_lock protects the list.

In the commit message, you should use imperative mood, command
the codebase what to do:
https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes


>
>Signed-off-by: David Wei <dw@davidwei.uk>
>---
> drivers/net/netdevsim/dev.c       | 17 +++++++++++++++++
> drivers/net/netdevsim/netdevsim.h |  1 +
> 2 files changed, 18 insertions(+)
>
>diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>index b4d3b9cde8bd..e30a12130e07 100644
>--- a/drivers/net/netdevsim/dev.c
>+++ b/drivers/net/netdevsim/dev.c
>@@ -35,6 +35,9 @@
> 
> #include "netdevsim.h"
> 
>+static LIST_HEAD(nsim_dev_list);
>+static DEFINE_MUTEX(nsim_dev_list_lock);
>+
> static unsigned int
> nsim_dev_port_index(enum nsim_dev_port_type type, unsigned int port_index)
> {
>@@ -1531,6 +1534,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
> 				 nsim_bus_dev->initial_net, &nsim_bus_dev->dev);
> 	if (!devlink)
> 		return -ENOMEM;
>+	mutex_lock(&nsim_dev_list_lock);

I don't follow. You claim you use this mutex to protect the list.
a) why don't you use spin-lock?
b) why don't don't you take the lock just for list manipulation?


> 	devl_lock(devlink);
> 	nsim_dev = devlink_priv(devlink);
> 	nsim_dev->nsim_bus_dev = nsim_bus_dev;
>@@ -1544,6 +1548,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
> 	spin_lock_init(&nsim_dev->fa_cookie_lock);
> 
> 	dev_set_drvdata(&nsim_bus_dev->dev, nsim_dev);
>+	list_add(&nsim_dev->list, &nsim_dev_list);
> 
> 	nsim_dev->vfconfigs = kcalloc(nsim_bus_dev->max_vfs,
> 				      sizeof(struct nsim_vf_config),
>@@ -1607,6 +1612,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
> 
> 	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_LEGACY;
> 	devl_unlock(devlink);
>+	mutex_unlock(&nsim_dev_list_lock);
> 	return 0;
> 
> err_hwstats_exit:
>@@ -1668,8 +1674,18 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
> {
> 	struct nsim_dev *nsim_dev = dev_get_drvdata(&nsim_bus_dev->dev);
> 	struct devlink *devlink = priv_to_devlink(nsim_dev);
>+	struct nsim_dev *pos, *tmp;
> 
>+	mutex_lock(&nsim_dev_list_lock);
> 	devl_lock(devlink);
>+
>+	list_for_each_entry_safe(pos, tmp, &nsim_dev_list, list) {
>+		if (pos == nsim_dev) {
>+			list_del(&nsim_dev->list);
>+			break;
>+		}
>+	}
>+
> 	nsim_dev_reload_destroy(nsim_dev);
> 
> 	nsim_bpf_dev_exit(nsim_dev);
>@@ -1681,6 +1697,7 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
> 	kfree(nsim_dev->vfconfigs);
> 	kfree(nsim_dev->fa_cookie);
> 	devl_unlock(devlink);
>+	mutex_unlock(&nsim_dev_list_lock);
> 	devlink_free(devlink);
> 	dev_set_drvdata(&nsim_bus_dev->dev, NULL);
> }
>diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>index 028c825b86db..babb61d7790b 100644
>--- a/drivers/net/netdevsim/netdevsim.h
>+++ b/drivers/net/netdevsim/netdevsim.h
>@@ -277,6 +277,7 @@ struct nsim_vf_config {
> 
> struct nsim_dev {
> 	struct nsim_bus_dev *nsim_bus_dev;
>+	struct list_head list;
> 	struct nsim_fib_data *fib_data;
> 	struct nsim_trap_data *trap_data;
> 	struct dentry *ddir;
>-- 
>2.39.3
>

