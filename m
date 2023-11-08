Return-Path: <netdev+bounces-46646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E117E58F1
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 15:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD343B20D05
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3A41BDDA;
	Wed,  8 Nov 2023 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mYYmkMSR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092772A1A7
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 14:30:07 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56508213A
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 06:30:06 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9d10f94f70bso1059613466b.3
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 06:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699453805; x=1700058605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqFYSyfDnsfrkZxmEenita9GfDckTQaGoW2e4dYhJ8k=;
        b=mYYmkMSRh3f5O5x/qmA4LAxOxg5II9xqeqQQfGFQmwRre3Vtjb4fHWDb0i0JU7jyE+
         l+VM2QzM0YahVHQYlwcy3pmhgZ08/sHJ+3PoIDHWJ7MW6PPJo6mIMsSCvPW0hbUVQnJ2
         QdASrJThhMdtlx/tGXnjcuvzqjfJJpr0jcwA+ADefotKerVdVohnh9ceBy/pHbZbPqWa
         91y573oq+JVtHXHvr6PEZgJ5SpXFvYvt+pTaJPibwBM2wpf1fszvoAnZTjPn35qSQAaZ
         sZz0rnQXcZJKxKG8yCCbP2i/SG5INKrWSWQnYGcUpTPbnJr2NWYm0kpk6VyF2pWfdGOy
         ALog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699453805; x=1700058605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqFYSyfDnsfrkZxmEenita9GfDckTQaGoW2e4dYhJ8k=;
        b=sqETvdayeZrusBAV4VxHSJHxXU5cJ+TchiyetDDKAG3+gDA3HIyLIOAJAScTNxFdrb
         sfr7ji3NwS/0PYqtzuVRscqzV/Ijl33zjq2j9Pv5qxRQcBExh6s0XbAE2wSf65++pw0u
         cT7ad13/Z50em5jc3OfKXnC2AQz7ouj+ncH0AgreZBxRKz1UYE9h+LNDiOgJKRAk2MaB
         q2HmZ8B64aj4mwcF7avwkNkvzHAG0nYgoXEidzVQwjz95U5KBNWdiRgxwWESpvSLzns+
         kBq9uGl+CYDmCKr4R9Ii9Ndb2MkTpPF/awP6T1wB7qks9UqWeee2pEcysfhdyl7Z9HUy
         /mCA==
X-Gm-Message-State: AOJu0YyE6AzVaK8xPALHbuLuu+kb9eiYa5vqy8ivIjWm4Ib7RF7m5irq
	5AYxTeEEYp2h60aK/04Ve566uw==
X-Google-Smtp-Source: AGHT+IFY+DLVbduO84g93eYfANGJP/kR2DtWD0fYbMs2KW8rMAPhSsiglIJIv3lFAY2eaflaV+gstA==
X-Received: by 2002:a17:906:ee81:b0:9dc:21c7:9ae5 with SMTP id wt1-20020a170906ee8100b009dc21c79ae5mr1560362ejb.26.1699453804546;
        Wed, 08 Nov 2023 06:30:04 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id w12-20020a170906130c00b0099bd86f9248sm1126776ejb.63.2023.11.08.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:30:03 -0800 (PST)
Date: Wed, 8 Nov 2023 15:30:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	michal.michalik@intel.com, milena.olech@intel.com,
	pabeni@redhat.com, kuba@kernel.org
Subject: Re: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Message-ID: <ZUubagu6B+vbfBqm@nanopsycho>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108103226.1168500-3-arkadiusz.kubalewski@intel.com>

Wed, Nov 08, 2023 at 11:32:25AM CET, arkadiusz.kubalewski@intel.com wrote:
>When a kernel module is unbound but the pin resources were not entirely
>freed (other kernel module instance have had kept the reference to that
>pin), and kernel module is again bound, the pin properties would not be
>updated (the properties are only assigned when memory for the pin is
>allocated), prop pointer still points to the kernel module memory of
>the kernel module which was deallocated on the unbind.
>
>If the pin dump is invoked in this state, the result is a kernel crash.
>Prevent the crash by storing persistent pin properties in dpll subsystem,
>copy the content from the kernel module when pin is allocated, instead of
>using memory of the kernel module.
>
>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/dpll/dpll_core.c    |  4 ++--
> drivers/dpll/dpll_core.h    |  4 ++--
> drivers/dpll/dpll_netlink.c | 28 ++++++++++++++--------------
> 3 files changed, 18 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 3568149b9562..4077b562ba3b 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -442,7 +442,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
> 		ret = -EINVAL;
> 		goto err;
> 	}
>-	pin->prop = prop;
>+	memcpy(&pin->prop, prop, sizeof(pin->prop));

Odd, you don't care about the pointer within this structure?


> 	refcount_set(&pin->refcount, 1);
> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>@@ -634,7 +634,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
> 	unsigned long i, stop;
> 	int ret;
> 
>-	if (WARN_ON(parent->prop->type != DPLL_PIN_TYPE_MUX))
>+	if (WARN_ON(parent->prop.type != DPLL_PIN_TYPE_MUX))
> 		return -EINVAL;
> 
> 	if (WARN_ON(!ops) ||
>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>index 5585873c5c1b..717f715015c7 100644
>--- a/drivers/dpll/dpll_core.h
>+++ b/drivers/dpll/dpll_core.h
>@@ -44,7 +44,7 @@ struct dpll_device {
>  * @module:		module of creator
>  * @dpll_refs:		hold referencees to dplls pin was registered with
>  * @parent_refs:	hold references to parent pins pin was registered with
>- * @prop:		pointer to pin properties given by registerer
>+ * @prop:		pin properties copied from the registerer
>  * @rclk_dev_name:	holds name of device when pin can recover clock from it
>  * @refcount:		refcount
>  **/
>@@ -55,7 +55,7 @@ struct dpll_pin {
> 	struct module *module;
> 	struct xarray dpll_refs;
> 	struct xarray parent_refs;
>-	const struct dpll_pin_properties *prop;
>+	struct dpll_pin_properties prop;
> 	refcount_t refcount;
> };
> 
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 93fc6c4b8a78..963bbbbe6660 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -278,17 +278,17 @@ dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
> 	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY, sizeof(freq), &freq,
> 			  DPLL_A_PIN_PAD))
> 		return -EMSGSIZE;
>-	for (fs = 0; fs < pin->prop->freq_supported_num; fs++) {
>+	for (fs = 0; fs < pin->prop.freq_supported_num; fs++) {
> 		nest = nla_nest_start(msg, DPLL_A_PIN_FREQUENCY_SUPPORTED);
> 		if (!nest)
> 			return -EMSGSIZE;
>-		freq = pin->prop->freq_supported[fs].min;
>+		freq = pin->prop.freq_supported[fs].min;
> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN, sizeof(freq),
> 				  &freq, DPLL_A_PIN_PAD)) {
> 			nla_nest_cancel(msg, nest);
> 			return -EMSGSIZE;
> 		}
>-		freq = pin->prop->freq_supported[fs].max;
>+		freq = pin->prop.freq_supported[fs].max;
> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX, sizeof(freq),
> 				  &freq, DPLL_A_PIN_PAD)) {
> 			nla_nest_cancel(msg, nest);
>@@ -304,9 +304,9 @@ static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)
> {
> 	int fs;
> 
>-	for (fs = 0; fs < pin->prop->freq_supported_num; fs++)
>-		if (freq >= pin->prop->freq_supported[fs].min &&
>-		    freq <= pin->prop->freq_supported[fs].max)
>+	for (fs = 0; fs < pin->prop.freq_supported_num; fs++)
>+		if (freq >= pin->prop.freq_supported[fs].min &&
>+		    freq <= pin->prop.freq_supported[fs].max)
> 			return true;
> 	return false;
> }
>@@ -403,7 +403,7 @@ static int
> dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
> 		     struct netlink_ext_ack *extack)
> {
>-	const struct dpll_pin_properties *prop = pin->prop;
>+	const struct dpll_pin_properties *prop = &pin->prop;
> 	struct dpll_pin_ref *ref;
> 	int ret;
> 
>@@ -696,7 +696,7 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
> 	int ret;
> 
> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>-	      pin->prop->capabilities)) {
>+	      pin->prop.capabilities)) {
> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
> 		return -EOPNOTSUPP;
> 	}
>@@ -732,7 +732,7 @@ dpll_pin_state_set(struct dpll_device *dpll, struct dpll_pin *pin,
> 	int ret;
> 
> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>-	      pin->prop->capabilities)) {
>+	      pin->prop.capabilities)) {
> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
> 		return -EOPNOTSUPP;
> 	}
>@@ -759,7 +759,7 @@ dpll_pin_prio_set(struct dpll_device *dpll, struct dpll_pin *pin,
> 	int ret;
> 
> 	if (!(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE &
>-	      pin->prop->capabilities)) {
>+	      pin->prop.capabilities)) {
> 		NL_SET_ERR_MSG(extack, "prio changing is not allowed");
> 		return -EOPNOTSUPP;
> 	}
>@@ -787,7 +787,7 @@ dpll_pin_direction_set(struct dpll_pin *pin, struct dpll_device *dpll,
> 	int ret;
> 
> 	if (!(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE &
>-	      pin->prop->capabilities)) {
>+	      pin->prop.capabilities)) {
> 		NL_SET_ERR_MSG(extack, "direction changing is not allowed");
> 		return -EOPNOTSUPP;
> 	}
>@@ -817,8 +817,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
> 	int ret;
> 
> 	phase_adj = nla_get_s32(phase_adj_attr);
>-	if (phase_adj > pin->prop->phase_range.max ||
>-	    phase_adj < pin->prop->phase_range.min) {
>+	if (phase_adj > pin->prop.phase_range.max ||
>+	    phase_adj < pin->prop.phase_range.min) {
> 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
> 				    "phase adjust value not supported");
> 		return -EINVAL;
>@@ -999,7 +999,7 @@ dpll_pin_find(u64 clock_id, struct nlattr *mod_name_attr,
> 	unsigned long i;
> 
> 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
>-		prop = pin->prop;
>+		prop = &pin->prop;
> 		cid_match = clock_id ? pin->clock_id == clock_id : true;
> 		mod_match = mod_name_attr && module_name(pin->module) ?
> 			!nla_strcmp(mod_name_attr,
>-- 
>2.38.1
>

