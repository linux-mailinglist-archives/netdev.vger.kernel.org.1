Return-Path: <netdev+bounces-46861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8A87E6B27
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 14:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44EE7B20AD8
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 13:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065AE1DFED;
	Thu,  9 Nov 2023 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="trfx3AyI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29EA1DFEC
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 13:20:31 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B354A30D7
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 05:20:16 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507adc3381cso1048424e87.3
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 05:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699536015; x=1700140815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=903ll40CqDNJzGklBXfrEVrovf33BBg7v0iLnvEmgxY=;
        b=trfx3AyIFxYcdPKKeeBO+JdPqnym9lZpKP8vc7KlPiZpU5FFV/6J2RLI7/xtkQibn5
         Z4lTW4OcVJl3joFJ5lOTqTD+F+mv+1DUmGdFRSW3/lnRENh2TubM+h+BONC4eFaS2bgN
         +d5WJKgPFzyDpHzkTF52IgVXjC0wFA3Cbwq+jvJJuFIrz5wU/AwxH2GSfTJEFyU1kERN
         +7wsET6icRrhw9XSHGgfzPsLIuVYOdHyCgSxNxTH/fX67KAqMNXkuaGfBvnvwZaMuV8b
         GLsY8WvGWfrRZNV48I+j4y/FvRKwN6CqtdFSE2JVaJR2X/JXtm5peqgV5/63iKNDxluv
         pWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699536015; x=1700140815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=903ll40CqDNJzGklBXfrEVrovf33BBg7v0iLnvEmgxY=;
        b=qABpA5lajrheGh9Pdvwbdrv0TOuBgroIX18Lb2iNESK174ow/ye09QWpH8v56YXpFa
         Gok6VUGN91gHRLgMcy6EdZehqATSfKrS4kp2sWxvj5r5jR4EaAmlELC77MyQxDmWWSmT
         g2b6NKPlm7/aVe7mGN67JqEpW/Y0KSeHSwAJrJ3u96aKY6K2pZNtJyhbI3sRVMSugO6R
         FvdszRp7xG86wRZdEhMSwGNZ6DNbfipHhojwcYNt2DfwmA7lRcPlEwKV6fi1cS68j8/Z
         icbe0VXkeutIge8VBSaPs3pGdePEIhkazWTpSS2+OVvVqk15gFjk7TNimWLKa3X+fbhi
         o6pA==
X-Gm-Message-State: AOJu0YwUysKSJ3bPLUbG0Q5jjeSbVUuxAXAHCL4f9c/YpQTrgS0+K3o6
	yehBfIde2k1YrshUarx7fmDKVQ==
X-Google-Smtp-Source: AGHT+IEbTo4CeuXwGTTwY2Y5Y1L7hxw9u4xr/ihcCb+ZHhwgIG7yGxNkY1U9Sirzc4QnUHlVLndHog==
X-Received: by 2002:a05:6512:480b:b0:500:b42f:1830 with SMTP id eo11-20020a056512480b00b00500b42f1830mr1058974lfb.63.1699536014617;
        Thu, 09 Nov 2023 05:20:14 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id e22-20020a1709067e1600b009ddaa2183d4sm2489056ejr.42.2023.11.09.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:20:14 -0800 (PST)
Date: Thu, 9 Nov 2023 14:20:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Message-ID: <ZUzcjUqoL6gcxW6f@nanopsycho>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-4-arkadiusz.kubalewski@intel.com>
 <ZUukPbTCww26jltC@nanopsycho>
 <DM6PR11MB46572BD8C43DACA0FF15C2CF9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46572BD8C43DACA0FF15C2CF9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>

Thu, Nov 09, 2023 at 10:59:04AM CET, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Wednesday, November 8, 2023 4:08 PM
>>
>>Wed, Nov 08, 2023 at 11:32:26AM CET, arkadiusz.kubalewski@intel.com wrote:
>>>In case of multiple kernel module instances using the same dpll device:
>>>if only one registers dpll device, then only that one can register
>>
>>They why you don't register in multiple instances? See mlx5 for a
>>reference.
>>
>
>Every registration requires ops, but for our case only PF0 is able to

What makes PF0 so special? Smell like broken FW design... Care to fix
it?


>control dpll pins and device, thus only this can provide ops.
>Basically without PF0, dpll is not able to be controlled, as well
>as directly connected pins.
>
>>
>>>directly connected pins with a dpll device. If unregistered parent
>>>determines if the muxed pin can be register with it or not, it forces
>>>serialized driver load order - first the driver instance which
>>>registers the direct pins needs to be loaded, then the other instances
>>>could register muxed type pins.
>>>
>>>Allow registration of a pin with a parent even if the parent was not
>>>yet registered, thus allow ability for unserialized driver instance
>>
>>Weird.
>>
>
>Yeah, this is issue only for MUX/parent pin part, couldn't find better
>way, but it doesn't seem to break things around..
>
>Thank you!
>Arkadiusz
>
>>
>>>load order.
>>>Do not WARN_ON notification for unregistered pin, which can be invoked
>>>for described case, instead just return error.
>>>
>>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>>functions")
>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>---
>>> drivers/dpll/dpll_core.c    | 4 ----
>>> drivers/dpll/dpll_netlink.c | 2 +-
>>> 2 files changed, 1 insertion(+), 5 deletions(-)
>>>
>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c index
>>>4077b562ba3b..ae884b92d68c 100644
>>>--- a/drivers/dpll/dpll_core.c
>>>+++ b/drivers/dpll/dpll_core.c
>>>@@ -28,8 +28,6 @@ static u32 dpll_xa_id;
>>> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>>> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
>>> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>>>-#define ASSERT_PIN_REGISTERED(p)	\
>>>-	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
>>>
>>> struct dpll_device_registration {
>>> 	struct list_head list;
>>>@@ -641,8 +639,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent,
>>struct dpll_pin *pin,
>>> 	    WARN_ON(!ops->state_on_pin_get) ||
>>> 	    WARN_ON(!ops->direction_get))
>>> 		return -EINVAL;
>>>-	if (ASSERT_PIN_REGISTERED(parent))
>>>-		return -EINVAL;
>>>
>>> 	mutex_lock(&dpll_lock);
>>> 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv); diff
>>>--git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c index
>>>963bbbbe6660..ff430f43304f 100644
>>>--- a/drivers/dpll/dpll_netlink.c
>>>+++ b/drivers/dpll/dpll_netlink.c
>>>@@ -558,7 +558,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct
>>dpll_pin *pin)
>>> 	int ret = -ENOMEM;
>>> 	void *hdr;
>>>
>>>-	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED)))
>>>+	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>>> 		return -ENODEV;
>>>
>>> 	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>>--
>>>2.38.1
>>>

