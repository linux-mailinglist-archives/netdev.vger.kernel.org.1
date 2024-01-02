Return-Path: <netdev+bounces-60840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66091821AA9
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9821F2237A
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C785DDB6;
	Tue,  2 Jan 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qNRHbmH+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7520DDAD
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ccabf5a4beso79358471fa.2
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 03:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704193460; x=1704798260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESvYrzRhy4KCK+QuO97KL6XzHH+q0EoXNyd7CFaD8mM=;
        b=qNRHbmH+azjumNBeVqrbV2r35GDoCLSfs4x+qDVY+hJal6WX3vx/1O8id+XZUewGZ+
         GNkcME62B57aSLO5sNQC6cTZlycBlER0XywJ1edyNGHq4yP2zJ6VZfmIZ4Fd6ETtRbQy
         2MxAA2vE/QTWvAYMt6D0xjt+TVtkDNZqB4pSB20XKlFhY7wEDXd0Yd7Eb6sza0/lQNbo
         dtk01dNLLON8hgQFI98+mBD5O4dC1EpG1CUqgDgSwVIjQoHMGdiwEdXRDnnwc8G1vf0e
         3tF5royvwJa43jKCXkxU/UxaDZaEA+NGxVf31pvpsZDYLbjyFGg8VYICi/lyV6cGHtEh
         KzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704193460; x=1704798260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESvYrzRhy4KCK+QuO97KL6XzHH+q0EoXNyd7CFaD8mM=;
        b=Zy5f8lesCvWbwZvIDAkEdrb6jhgvthJVCVsy6Zu5Y4jcwqOHec/PnyBvjQlH5hgb6f
         qBna41q3rK9/6J/J/XnKh6G9VXWE7gVudCkBhkr0avvxUZNbin8J+0cMwUn4x2sq4L9u
         9cXmSnj3U9rmHCTNpV7urSQK9NhdntUnNe1RaGk4znJjz/mznofOSPizd5bvnTWa9RNl
         EMnYT/9E8IKX1mZU9xoCDB5RmiQdXpf4YZ6a26pkjI6zYFRMPePAlguj98XZUUA8eDX1
         xNaLAP+5LvrPReBDEnABiWIo2oGl6+yd8/bJgLOafF5BKjX7F/tyCUb3WmMhI34SeqNl
         Asrw==
X-Gm-Message-State: AOJu0YzWUW8fga82DiIg1Bf4ndSQrR7+v9zAbGYIK5SmzW9hTz7ZvTCH
	iPXyH/+UMr7T42TnyJPsfcqJBs7q+d7nMQ==
X-Google-Smtp-Source: AGHT+IFmuc9lvWwKsxl1C1cd4VJ4ndufwhZeOc7xvErLMERXzFAsFnmmajJ6jGV+O4wM9rtmFR26wQ==
X-Received: by 2002:a05:651c:550:b0:2cc:d571:e2f6 with SMTP id q16-20020a05651c055000b002ccd571e2f6mr3037688ljp.70.1704193459893;
        Tue, 02 Jan 2024 03:04:19 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v13-20020aa7dbcd000000b00554d57621eesm11012081edt.90.2024.01.02.03.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 03:04:18 -0800 (PST)
Date: Tue, 2 Jan 2024 12:04:17 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 1/5] netdevsim: maintain a list of probed
 netdevsims
Message-ID: <ZZPtsfyHfDyuqfxM@nanopsycho>
References: <20231228014633.3256862-1-dw@davidwei.uk>
 <20231228014633.3256862-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228014633.3256862-2-dw@davidwei.uk>

Thu, Dec 28, 2023 at 02:46:29AM CET, dw@davidwei.uk wrote:
>In this patch I added a linked list nsim_dev_list of probed nsim_devs,
>added during nsim_drv_probe() and removed during nsim_drv_remove(). A
>mutex nsim_dev_list_lock protects the list.
>
>Signed-off-by: David Wei <dw@davidwei.uk>
>---
> drivers/net/netdevsim/dev.c       | 19 +++++++++++++++++++
> drivers/net/netdevsim/netdevsim.h |  1 +
> 2 files changed, 20 insertions(+)
>
>diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>index b4d3b9cde8bd..8d477aa99f94 100644
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
>@@ -1607,6 +1610,11 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
> 
> 	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_LEGACY;
> 	devl_unlock(devlink);
>+
>+	mutex_lock(&nsim_dev_list_lock);
>+	list_add(&nsim_dev->list, &nsim_dev_list);
>+	mutex_unlock(&nsim_dev_list_lock);
>+
> 	return 0;
> 
> err_hwstats_exit:
>@@ -1668,8 +1676,19 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
> {
> 	struct nsim_dev *nsim_dev = dev_get_drvdata(&nsim_bus_dev->dev);
> 	struct devlink *devlink = priv_to_devlink(nsim_dev);
>+	struct nsim_dev *pos, *tmp;
>+
>+	mutex_lock(&nsim_dev_list_lock);
>+	list_for_each_entry_safe(pos, tmp, &nsim_dev_list, list) {
>+		if (pos == nsim_dev) {
>+			list_del(&nsim_dev->list);
>+			break;
>+		}
>+	}
>+	mutex_unlock(&nsim_dev_list_lock);

This is just:
	mutex_lock(&nsim_dev_list_lock);
	list_del(&nsim_dev->list);
	mutex_unlock(&nsim_dev_list_lock);

The loop is not good for anything.



> 
> 	devl_lock(devlink);
>+

Remove this leftover line addition.


> 	nsim_dev_reload_destroy(nsim_dev);
> 
> 	nsim_bpf_dev_exit(nsim_dev);
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

