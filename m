Return-Path: <netdev+bounces-63635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBEB82EA38
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 08:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37A71C2311E
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 07:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEE711185;
	Tue, 16 Jan 2024 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Vuw2tCJm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7A11181
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-337ae00f39dso1123318f8f.2
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 23:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705390931; x=1705995731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2zW8ssqBbfwn3RmL6HavdIRb7aUpgurOAZIVIJGuCE=;
        b=Vuw2tCJmkSM+SRCIaElrw5IPtHUk56A+zzxf6EsQbd+OQhnIqMaFyTBumO9u5BwO6y
         TUBzPumZvMYe1iT/cUFWMZWCKT4KsVVXfWwH1UNvPazGS4qQ0apbfj475+0AMMQ/g4c3
         d/bos63Ee1Euif44KbJEYBTFKH+TDvlwakcEzwzqR0rEhozb2QNILsgD7jOyl+USosnI
         W5ChlmpB+zTuZtm+4OrO75/9PEB5Kbw7fDfaj5D7vY7NPYYwYQGrjw2uiND7xWaqKA4Z
         S+z0bD/jEljsvWnTBvgll8KUscdPMwnouGnNS/uOoQUoM6m1ItzDS36idNAE2H0Rb2yd
         Au+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705390931; x=1705995731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2zW8ssqBbfwn3RmL6HavdIRb7aUpgurOAZIVIJGuCE=;
        b=eRml7STMusgpdhrqbAAw/oB46006iNQbXHSnzZ4JQ8EuKKzFRaqXu6bbLAPgVTij34
         fCM7PSb5gLNSdCIDc6qFegDZEaqxiBel7FjZlW1RdJ81I3yFz6sf/OzYKaS6FM9Bxr+d
         QG0zARw0EKwc16I8LPWMwuorCFDW0QSQQPNDgvCZKf7j2ykoaOtC73qXEC+Za5sUWovv
         f6jHjvA5yXFRkPYFSLIp9DFNWqfpqpy3bDxHFPwnmbVroDsktOdn2geMRmONQIqajZni
         Qk+k65ypRtBQPwAyjDxqY8+1Aj08RwhRHozhotn1vtiLTfqNM+cPd+twTxc4RpwHkoUd
         9Kdg==
X-Gm-Message-State: AOJu0YzzQ11ZVEnRsmrSeATTOb/LYgqc04hL2pvKxR/zLTVtO/+Hn1if
	BkeSSqCMqvWRGsLMXSaCL4K+4CHF4hNCGA==
X-Google-Smtp-Source: AGHT+IGMxuG3v/EIE5obCLMalEWXcMFjvTO2FFACUpqum66sio2CcOB61+oeGrlKxAC3XGtlvVOGOQ==
X-Received: by 2002:adf:fdcd:0:b0:337:9f3b:5dba with SMTP id i13-20020adffdcd000000b003379f3b5dbamr2506945wrs.74.1705390931100;
        Mon, 15 Jan 2024 23:42:11 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i5-20020adfb645000000b003368c8d120fsm13870941wre.7.2024.01.15.23.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:42:10 -0800 (PST)
Date: Tue, 16 Jan 2024 08:42:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, davem@davemloft.net,
	milena.olech@intel.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, mschmidt@redhat.com,
	Jan Glaza <jan.glaza@intel.com>
Subject: Re: [PATCH net v3 2/3] dpll: fix register pin with unregistered
 parent pin
Message-ID: <ZaYzUXmnS3czrUsG@nanopsycho>
References: <20240115085241.312144-1-arkadiusz.kubalewski@intel.com>
 <20240115085241.312144-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115085241.312144-3-arkadiusz.kubalewski@intel.com>

Mon, Jan 15, 2024 at 09:52:40AM CET, arkadiusz.kubalewski@intel.com wrote:
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
>v3:
>- allow register with non registered parent dpll device for consistency
>
> drivers/dpll/dpll_core.c    | 6 ------
> drivers/dpll/dpll_netlink.c | 2 +-
> 2 files changed, 1 insertion(+), 7 deletions(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index fbac32af78b7..69005d8489d3 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -28,8 +28,6 @@ static u32 dpll_xa_id;
> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>-#define ASSERT_PIN_REGISTERED(p)	\
>-	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))

Also, for consistency, this could be called from
__dpll_pin_unregister(). But that is net-next material.


Reviewed-by: Jiri Pirko <jiri@nvidia.com>



> 
> struct dpll_device_registration {
> 	struct list_head list;
>@@ -613,8 +611,6 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
> 	    WARN_ON(!ops->state_on_dpll_get) ||
> 	    WARN_ON(!ops->direction_get))
> 		return -EINVAL;
>-	if (ASSERT_DPLL_REGISTERED(dpll))
>-		return -EINVAL;
> 
> 	mutex_lock(&dpll_lock);
> 	if (WARN_ON(!(dpll->module == pin->module &&
>@@ -692,8 +688,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
> 	    WARN_ON(!ops->state_on_pin_get) ||
> 	    WARN_ON(!ops->direction_get))
> 		return -EINVAL;
>-	if (ASSERT_PIN_REGISTERED(parent))
>-		return -EINVAL;
> 
> 	mutex_lock(&dpll_lock);
> 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv);
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 4c64611d32ac..108c002537e6 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -551,7 +551,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
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

