Return-Path: <netdev+bounces-270577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mABDLtFtwWnDTAQAu9opvQ
	(envelope-from <netdev+bounces-270577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:44:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F662F8B19
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FA2233D39C6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C39425782D;
	Mon, 23 Mar 2026 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yDcDmEFq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5032517AF
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278228; cv=none; b=NeWCDGLTV7TOpVF/XPk4gMFzK7Z/eom2J5uc3A8G/Rg8CscyqyDR8gHeREwFnFhg0h8Jcld/gZH2M7dC7ZI8gngmQ6vIOg/PnNYLhh1RLZIbvwRfyDtz8L0sGwqz8HGaed6TbxioE+gvYm6810ZszLMRJ48kElNUlbX9edalJ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278228; c=relaxed/simple;
	bh=uqt0OKbhfBVS12qhq3P1dfykaFDIoj76YuanlIrntCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oowufPT8f7RfVI6nIfa8YTiRZq0w2v86Vqr6isrlHdoRxfqxRA5oq4SvUWJAYTIhaHUhrSTAGYtPCJF7FvTw9YzSUkNftbjr8vOQnF+wFjqbBnDvA4I9ax+3SOAC8TAN2kk0klRKzUjU6tGbafDdxijwZX/CnoiXz5Aq+tewIxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yDcDmEFq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fe655187so38712475e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774278222; x=1774883022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=65XL03/5D/OxM0Pku9HxE63oFNPPzZeXqQncP9gzT08=;
        b=yDcDmEFqLO+AXOaJkXCCg1oYU1y3an5rmCcFdnIXEadS5+F2biXRvFU7qrNRTxEkS2
         VFVENN+SSEQNRjtY8RH0kZ9fwYJhg0j6qkGHirePY1CNulAbl6uC16krCLYEXlZM1UlR
         04cXPVx8j1P1N2uXslob7k7WbawTYFXJPOiT5NYsgJPqSx8K50y7nZEd/hJJCQsRBH8O
         qt5typ/jSFbNSLrgRpjQ4/ZNnwrtCEZveUde9cVuQT3pcpM44dtcah7URx71Tv+1cgnU
         xpc8ItxqdnEmT+nCWa12V3Txbq8bXUChkrXpUZ9dZIMxL2CrnVsE/+khfCZy9jgh6hGu
         bb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774278222; x=1774883022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65XL03/5D/OxM0Pku9HxE63oFNPPzZeXqQncP9gzT08=;
        b=GNhDHmZzMOKpuUgaoe6Q8wGkqA3752xvrvgDC/I6BQg/oH9WNsOYwKNTykA2tv3Gb4
         0GQNFpKWi9xNJMFpQxe2Ih2XK28JwcgR27j6mj2IPsQX4RdT9/F0mC/32F4jzp9ao3wn
         nl9v2woozBbCbDiN8GDX3h7WsXhoi1lv9bSy1kx6bEsq6NUKJ1PeMVaLV+8I0n3tzwqe
         oUaM9BooQ5dBP+yM4p6xyWIWotrkGeLScLbyEowSu2EHkpgSjRP/t9He/gXkRJ/IUurw
         Q3GYpWfbbMMYZiOy1MQdxvNcXqJYEMlqA4xvG/lQLPoGpqTrO0fcSDk7RC11I++b5Rwp
         r3Gg==
X-Gm-Message-State: AOJu0Yz5dmFU15QhWJxfvEjGGr2k0qKLypo/2eEdPY5Xbz0NqDpam9G/
	cdOuqLveSVzv2m1ilf38J/x8KD08t5pgtuIzLGuTuut8kJhaFm7dZlrIM5xw7IkliN0=
X-Gm-Gg: ATEYQzxg/ffF86cWxp1VhhoqD02v5ChFNxLbdoz93zN768HRqURftbALAQyD9+oY+Rl
	bEO1Xbl7QmwhexDyfkSroKGQStH44GSRrVcv6iEc362CB7o4ZQUFHCr6gFjP1GlYu/jhxfR4tq2
	R1TMPt0qitr/IIn/t9j8WYAHPJjFy4MSZjSWaFYSHzcP9HVQzhXjJg9ZfbgSN9zhV67MJAqicvy
	m92twFa1iCuR7gSlT7XWdx42dbbCq/dShw1wP0z+bFelOnQWMDZvsl4zIeUZ1K6ij0QD5sZfawF
	nCd6HjRj9AiKKnmqX91kdr2O6kOEClN6QlL6IkxcWcsMb+Vu4LvZjwoeqYjS0HcZlRXX8nqLLqe
	D8bPCdHx5Lnu/N3M4yqJfAvh81SDc1QHTcKZJDHMGI1z58bPXyEZnP3qAR0T3j2jiUxgenTzV8r
	wxWDT3S510CubchEoAwPOQ4vRV7aKMQ+0pbCk=
X-Received: by 2002:a05:600c:1d15:b0:485:ae14:8173 with SMTP id 5b1f17b1804b1-486febb5ffemr174241675e9.1.1774278222241;
        Mon, 23 Mar 2026 08:03:42 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe6d923fsm464712385e9.1.2026.03.23.08.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:03:41 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:03:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org, 
	Simon Horman <horms@kernel.org>, Michal Schmidt <mschmidt@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] devlink: unify devlink_shd_get_priv() into
 devlink_priv()
Message-ID: <fc7iebxveew5yi2trlpumcmugwzerixdm536kvgp5hlxmm4zw6@vmcbn76n7fvt>
References: <20260323132136.13191-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323132136.13191-1-przemyslaw.kitszel@intel.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-270577-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 06F662F8B19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Mar 23, 2026 at 02:21:36PM +0100, przemyslaw.kitszel@intel.com wrote:
>Unify access API to shared devlink priv data with normal devlink.
>
>Thanks to Jiri Piro, we now have ability to create shared devlink
>instances [1]. Introduction series have added usege of those for mlx, but
>without priv data attached to the shared devlink.
>
>Current API makes it possible to access shared devlink instance's priv
>data:
>
>	void *devlink_shd_get_priv(struct devlink *devlink);
>
>but it is easy to to forget (especially during rebase from "before shared
>devlinks" era) and call:
>
>	void *devlink_priv(struct devlink *devlink);
>
>which even has the same signature, so it's hard to catch the error.
>
>New proposed API unifies both calls into one, without any increase in the
>observerd struct size. (Alternative could be to store additional pointer,
>set during devlink_alloc).

You should use some AI corrector :) too many typos.

>
>Unexport the less convenient API call.
>
>[1] commit 411ad0605875 ("Merge branch 'devlink-introduce-shared-devlink-instance-for-pfs-on-same-chip'")
>[1] https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us
>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>---
>sorry that I have not mentioned it during [1] review, it got obvious
>for me only after working with the code
>---
> net/devlink/devl_internal.h |  4 ++++
> net/devlink/core.c          |  3 +++
> net/devlink/sh_dev.c        | 11 ++++++++---
> 3 files changed, 15 insertions(+), 3 deletions(-)
>
>diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
>index 7dfb7cdd2d23..abbe308ee9bd 100644
>--- a/net/devlink/devl_internal.h
>+++ b/net/devlink/devl_internal.h
>@@ -58,6 +58,7 @@ struct devlink {
> 	struct mutex lock;
> 	struct lock_class_key lock_key;
> 	u8 reload_failed:1;
>+	u8 is_shd:1;
> 	refcount_t refcount;
> 	struct rcu_work rwork;
> 	struct devlink_rel *rel;
>@@ -72,6 +73,9 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
> 				struct net *net, struct device *dev,
> 				const struct device_driver *dev_driver);
> 
>+/* Get private data from shared devlink instance */
>+void *devlink_shd_get_priv(struct devlink *devlink);
>+
> #define devl_warn(devlink, format, args...)				\
> 	do {								\
> 		if ((devlink)->dev)					\
>diff --git a/net/devlink/core.c b/net/devlink/core.c
>index eeb6a71f5f56..4c97e2e2c073 100644
>--- a/net/devlink/core.c
>+++ b/net/devlink/core.c
>@@ -232,6 +232,9 @@ int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
> 
> void *devlink_priv(struct devlink *devlink)
> {
>+	if (devlink->is_shd)
>+		return devlink_shd_get_priv(devlink);
>+
> 	return &devlink->priv;
> }
> EXPORT_SYMBOL_GPL(devlink_priv);
>diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
>index 9b7456d64b57..450e3218759e 100644
>--- a/net/devlink/sh_dev.c
>+++ b/net/devlink/sh_dev.c
>@@ -31,6 +31,11 @@ static struct devlink_shd *devlink_shd_lookup(const char *id)
> 	return NULL;
> }
> 
>+static struct devlink_shd *devlink_to_shd(struct devlink *devlink)
>+{
>+	return &devlink->priv;
>+}

Can you rather have unexported __devlink_priv() above existing
devlink_priv()?


>+
> static struct devlink_shd *devlink_shd_create(const char *id,
> 					      const struct devlink_ops *ops,
> 					      size_t priv_size,
>@@ -43,13 +48,14 @@ static struct devlink_shd *devlink_shd_create(const char *id,
> 				  &init_net, NULL, driver);
> 	if (!devlink)
> 		return NULL;
>-	shd = devlink_priv(devlink);
>+	shd = devlink_to_shd(devlink);
> 
> 	shd->id = kstrdup(id, GFP_KERNEL);
> 	if (!shd->id)
> 		goto err_devlink_free;
> 	shd->priv_size = priv_size;
> 	refcount_set(&shd->refcount, 1);
>+	devlink->is_shd = 1;
> 
> 	devl_lock(devlink);
> 	devl_register(devlink);
>@@ -137,7 +143,7 @@ void devlink_shd_put(struct devlink *devlink)
> 	struct devlink_shd *shd;
> 
> 	mutex_lock(&shd_mutex);
>-	shd = devlink_priv(devlink);
>+	shd = devlink_to_shd(devlink);
> 	if (refcount_dec_and_test(&shd->refcount))
> 		devlink_shd_destroy(shd);
> 	mutex_unlock(&shd_mutex);
>@@ -159,4 +165,3 @@ void *devlink_shd_get_priv(struct devlink *devlink)
> 
> 	return shd->priv;
> }
>-EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
>-- 
>2.39.3
>

