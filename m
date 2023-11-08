Return-Path: <netdev+bounces-46651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55C57E59B1
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 16:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E656E1C20878
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0505530321;
	Wed,  8 Nov 2023 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2vGhQ9Yo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130DDF4E
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 15:07:45 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B4D1BE6
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 07:07:44 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9e1021dbd28so516761366b.3
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 07:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699456063; x=1700060863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WspmZ6Lg/AL0TXgWCN7RG+9beG4UFvhCrRtIg7dYa4k=;
        b=2vGhQ9YodD/l7tMBo2pqtE81i8vbwGt28NqTsPpPMh0W/jS1nYsmR/7CSDGZIQAK+R
         A3OvC2KiGQe2VrkuU+0fR9m5P+F/1cN9EwxZiw6lrNqdgnc/YXtZmWQ7jNdT/z3KBTPL
         U6nPOZRERRN7NcwVkck5IEH6fFMwqVROLP7fSRzhkC0Gd8s2hQf4nlkYtN+JxnAyLNXE
         lA60KIYG9wYcagTz8vqFReARIpY79+FX8SnBdL/7xg6kMA6Z6SUmsDAw0kDDILP/M+pr
         Y8aCuFABskb8sKPM/3Btb5HcVvkV2rRIpOpzttGeTotQO4uN7Vix3JQpA4SxHagPRcbM
         CIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699456063; x=1700060863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WspmZ6Lg/AL0TXgWCN7RG+9beG4UFvhCrRtIg7dYa4k=;
        b=Wc3TyBxdKl7xnZzIaUMlvhmGi6UQcGUSED+/JzH7eCHwOJtztQ0XoGbgzpBC7pcBUC
         rTrH7q6PufwynglWexYwRkVMUdRkhLBfaLQyrK4VqB2/moQeO5HPcNll5X58AEih/zk4
         Y3pGQHaS3evyjYwfSHKxBog/wqAm+WXkHe1RTMomD6tHrmuhVcZXeWvfxbQ0jdEvAT72
         NYR42e/aVW4mpf7A/Kz4LptbzpWtKlcPZN4ZpY5XHgvtvWjA5wNZJE6DaaS7ILXCqu+W
         ccsKe3P+AeNnD1K/UMzEVsg3rOA5RM84/h71OEqtW0NOm/1ioa2n45HA2eQcl3li7imt
         mexQ==
X-Gm-Message-State: AOJu0Yydb88Orhmh2yZnkvjdN6TG6DJgflf6ef1bgiRQKZIWPRgFIctu
	/X80nnGo4LF/jQ3nvyCXNNtCrg==
X-Google-Smtp-Source: AGHT+IHbeuEd87KDANVPO6PppQR9hYqmc8ue7re+AiZiFmOnXj4M5lXyijMWIkFyUatUWWixp+W0nQ==
X-Received: by 2002:a17:907:1b06:b0:9c3:d356:ad0c with SMTP id mp6-20020a1709071b0600b009c3d356ad0cmr1955332ejc.24.1699456063113;
        Wed, 08 Nov 2023 07:07:43 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b009de11cc12d2sm1181925ejb.55.2023.11.08.07.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:07:42 -0800 (PST)
Date: Wed, 8 Nov 2023 16:07:41 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	michal.michalik@intel.com, milena.olech@intel.com,
	pabeni@redhat.com, kuba@kernel.org
Subject: Re: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Message-ID: <ZUukPbTCww26jltC@nanopsycho>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-4-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108103226.1168500-4-arkadiusz.kubalewski@intel.com>

Wed, Nov 08, 2023 at 11:32:26AM CET, arkadiusz.kubalewski@intel.com wrote:
>In case of multiple kernel module instances using the same dpll device:
>if only one registers dpll device, then only that one can register

They why you don't register in multiple instances? See mlx5 for a
reference.


>directly connected pins with a dpll device. If unregistered parent
>determines if the muxed pin can be register with it or not, it forces
>serialized driver load order - first the driver instance which registers
>the direct pins needs to be loaded, then the other instances could
>register muxed type pins.
>
>Allow registration of a pin with a parent even if the parent was not
>yet registered, thus allow ability for unserialized driver instance

Weird.


>load order.
>Do not WARN_ON notification for unregistered pin, which can be invoked
>for described case, instead just return error.
>
>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/dpll/dpll_core.c    | 4 ----
> drivers/dpll/dpll_netlink.c | 2 +-
> 2 files changed, 1 insertion(+), 5 deletions(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 4077b562ba3b..ae884b92d68c 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -28,8 +28,6 @@ static u32 dpll_xa_id;
> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>-#define ASSERT_PIN_REGISTERED(p)	\
>-	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
> 
> struct dpll_device_registration {
> 	struct list_head list;
>@@ -641,8 +639,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
> 	    WARN_ON(!ops->state_on_pin_get) ||
> 	    WARN_ON(!ops->direction_get))
> 		return -EINVAL;
>-	if (ASSERT_PIN_REGISTERED(parent))
>-		return -EINVAL;
> 
> 	mutex_lock(&dpll_lock);
> 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv);
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 963bbbbe6660..ff430f43304f 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -558,7 +558,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
> 	int ret = -ENOMEM;
> 	void *hdr;
> 
>-	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED)))
>+	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
> 		return -ENODEV;
> 
> 	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>-- 
>2.38.1
>

