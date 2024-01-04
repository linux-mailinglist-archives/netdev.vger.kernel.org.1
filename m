Return-Path: <netdev+bounces-61556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E368E82441B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2A41F22122
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEE820DFF;
	Thu,  4 Jan 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HWRqsw/8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140720DDF
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso5211915e9.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 06:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704379702; x=1704984502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGa++TRwAZq3fzlA5hMTBjKZSnxS4kuVXv5TKa7Exrk=;
        b=HWRqsw/8ardQcwEdzT0jz/z8shMD00Lj0Aqe1Lzqp6GzOLFexL9Q86jVUDv379Xl9H
         1TKH64uPhR7eTQuTxmv6b1M+ij2LPPtZwexTvaMEr9MfvnPBwBR7jQUtoWezHyeMvE7Q
         WxFFqpNvqFv5mowKbxptQo6p1Gq95EhezHZZe3KoK+v31aUYtzGMxWYbEw9IfGmPX6Mw
         cLUe0/COFVaClOS1qfmJn/hGqfNWi1QTCxzMXfY4oEwvWuRVyOsfKbr8CHCOKGS3jUhw
         2gPmIKPcIVthQsCygwPIIXbfMsQHimJjYpUO3xVZLBI+GXbmHExGdgDBXK4hv44nxg/8
         uGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704379702; x=1704984502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGa++TRwAZq3fzlA5hMTBjKZSnxS4kuVXv5TKa7Exrk=;
        b=i4fI5cg3ww/d1OaTh+ERKpOQzY3ixR17KNMzioi0jWn2PVFcRR3KmQhNnwLUHRzeya
         I1iGiXqY2zxOOmcF1HFemyPsRFeehlKVOwr4mU9TfTFnjYL+97RlNy1BNx3JpxrmcD3s
         FaQ1EDYq4JOh3WmBgfm3Py1POSompf/YDLUT6LPKXZRWFkxDil6QXBNEERXNFJrbk7XP
         xZCMsJgKNT/MXBc2KB1YBNFpo59aK6Ggzvxg/+o5Mk9GVv47+hO3C/UBvcQMbZIRhQJE
         ZPUiPzd3YyZ2SudHeaES3nirm0Ws1XmAYZZjayHtsGfGEANVen/yPUiM7vshQEdTcfHD
         L5Kw==
X-Gm-Message-State: AOJu0YxgLUURtqtVvZqe9cTE0eeIkz0D29kpjrZVgmf9QFNRLXEVzYi5
	vUYTP+ZezGFFOOt57ZirqnWgpWYDLs8UXg==
X-Google-Smtp-Source: AGHT+IGg0XeMNEmYEx0shTXxEiaTdcPXvmoDRYbZ3jwOwHS2gCH2Wsut50j4xUYc5JzJKxnIg8u3aA==
X-Received: by 2002:a05:600c:a08:b0:40d:583f:32bd with SMTP id z8-20020a05600c0a0800b0040d583f32bdmr397387wmp.91.1704379702398;
        Thu, 04 Jan 2024 06:48:22 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b0040d87b5a87csm5850142wmb.48.2024.01.04.06.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:48:21 -0800 (PST)
Date: Thu, 4 Jan 2024 15:48:20 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	michal.michalik@intel.com, milena.olech@intel.com,
	pabeni@redhat.com, kuba@kernel.org, Jan Glaza <jan.glaza@intel.com>
Subject: Re: [PATCH net v2 3/4] dpll: fix register pin with unregistered
 parent pin
Message-ID: <ZZbFNMMiRvgSi1Ge@nanopsycho>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
 <20240104111132.42730-4-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104111132.42730-4-arkadiusz.kubalewski@intel.com>

Thu, Jan 04, 2024 at 12:11:31PM CET, arkadiusz.kubalewski@intel.com wrote:
>In case of multiple kernel module instances using the same dpll device:
>if only one registers dpll device, then only that one can register
>directly connected pins with a dpll device. When unregistered parent is
>responsible for determining if the muxed pin can be registered with it
>or not, the drivers need to be loaded in serialized order to work
>correctly - first the driver instance which registers the direct pins
>needs to be loaded, then the other instances could register muxed type
>pins.
>
>Allow registration of a pin with a parent even if the parent was not
>yet registered, thus allow ability for unserialized driver instance
>load order.
>Do not WARN_ON notification for unregistered pin, which can be invoked
>for described case, instead just return error.
>
>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/dpll/dpll_core.c    | 4 ----
> drivers/dpll/dpll_netlink.c | 2 +-
> 2 files changed, 1 insertion(+), 5 deletions(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 0b469096ef79..c8a2129f5699 100644
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
>@@ -664,8 +662,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
> 	    WARN_ON(!ops->state_on_pin_get) ||
> 	    WARN_ON(!ops->direction_get))
> 		return -EINVAL;
>-	if (ASSERT_PIN_REGISTERED(parent))
>-		return -EINVAL;

This makes the pin-on-device and pin-on-pin register behaviour
different:
int
dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
                  const struct dpll_pin_ops *ops, void *priv)
{
	...
        if (ASSERT_DPLL_REGISTERED(dpll))
                return -EINVAL;

I think it is need to maintain the same set of restrictions and
behaviour the same for both.

With what you suggest, the user would just see couple of pins with no
parent (hidden one), no dpll devices (none would be registered).
That's odd.

PF0 is the owner of DPLL in your case.

From the user perspective, I think it should look like:
1) If PFn appears after PF0, it registers pins related to it, PF0
   created instances are there and valid. User sees them all.
2) If PF0 gets removed before PFn, it removes all dpll related entities,
   even those related to PFn. Users sees nothing.

So you have to make sure that the pin is hidden (not shown to the user)
in case the parent (device/pin) is not registered. Makes sense?



> 
> 	mutex_lock(&dpll_lock);
> 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv);
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 3ce9995013f1..f266db8da2f0 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -553,7 +553,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
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

