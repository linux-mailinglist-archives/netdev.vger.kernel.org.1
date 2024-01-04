Return-Path: <netdev+bounces-61579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BAF824528
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EDD1F21898
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B18D241FD;
	Thu,  4 Jan 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Q/RJu5t2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E06225CD
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e72e3d435so641948e87.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 07:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704382856; x=1704987656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wTUtodFNsmO8qw4uV6J4ESxCVIpKFtPGxmwm3ZF0uBU=;
        b=Q/RJu5t20UM/5i6TGwbjufsoWehefQPOXXh0ZzOnPXpIEpTvFEcX5KzTlUwwx4x2Oz
         I+Y7w/E3hiIc9EWxMrl0MiTcQ5M0ov4Oc8h4lL9LiAUwCdSeGhudTw0bRWQCYuuZZYsS
         A8r8x57APnt3PqJigl0s4mkNMGRKiAtW8MDG6dkY43d5L7z1LhugKa4pYSL4gW2UlaCQ
         DdsbyBtgwWoe9/VJil9Ktdegkfmf9aeMlbXzFqSqJ3GvTZ6+dp6HenhFqDMpwpRs9iP+
         gisx79l+JedkuD0FwWPJijkBRAJckmQYL4aiMIin+pAj2s1zNUXCdjz8M/EGT4Zg9BHD
         V7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704382856; x=1704987656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTUtodFNsmO8qw4uV6J4ESxCVIpKFtPGxmwm3ZF0uBU=;
        b=sVq1NqyFXI2hG+97e1hwXtlo7VOknM5BRcSIKJfroT1+TFwSv2cJLHQiqnACeKPwH/
         dfTyKAHgexgTqP/wkg/VRfvpa0y4av0KhZFny2i+NZ2gtIO96B8uUOUcE/v4Z7EK/QC7
         bIEonj9TCLceYfCzyigtCR3syW6nzjgAf7GQEd9miKnlIz0jEzSTnEd/XfiQhcZdJKGH
         cei0aDA6b+mTUIRlZszGEiNy7Or997yoiAOjYNDUd2aMipA5fPPTrHHzq4neAHTxG8oL
         eM+Azgtia20Uw/t4d9XjG+Fp6ox5Cg6ieZPAD2WjQtzqP+JlhxPpC2CcGZsJBvARqG3u
         wVWQ==
X-Gm-Message-State: AOJu0YxQBJIniBo7bEGcgRGYj6cVX79ZEYa+srC2fmCY+C1uaccgaDN4
	/jXRG7Ynbif5QiBCsgSoIlb2C6tVcKYLru0ufRW4c7wJVooaRg==
X-Google-Smtp-Source: AGHT+IEmdPlJrLD/YrdxIV/NL6XYw62LB5HmTIDReqNHFr4eCW8U/i7yhXsi21h5NAe8a8HavrsLEQ==
X-Received: by 2002:ac2:5e25:0:b0:50e:7596:214e with SMTP id o5-20020ac25e25000000b0050e7596214emr274130lfg.25.1704382856056;
        Thu, 04 Jan 2024 07:40:56 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q23-20020a170906771700b00a26f1f36708sm9952800ejm.78.2024.01.04.07.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:40:55 -0800 (PST)
Date: Thu, 4 Jan 2024 16:40:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	michal.michalik@intel.com, milena.olech@intel.com,
	pabeni@redhat.com, kuba@kernel.org, Jan Glaza <jan.glaza@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v2 2/4] dpll: fix pin dump crash for rebound module
Message-ID: <ZZbRhsldnlKQfoDb@nanopsycho>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
 <20240104111132.42730-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104111132.42730-3-arkadiusz.kubalewski@intel.com>

Thu, Jan 04, 2024 at 12:11:30PM CET, arkadiusz.kubalewski@intel.com wrote:
>When a kernel module is unbound but the pin resources were not entirely
>freed (other kernel module instance have had kept the reference to that

Wait, you talk about module, yet you mean pci instance of the same
module, don't you?


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
>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/dpll/dpll_core.c    | 29 ++++++++++++++++++++++++++---
> drivers/dpll/dpll_core.h    |  4 ++--
> drivers/dpll/dpll_netlink.c | 28 ++++++++++++++--------------
> 3 files changed, 42 insertions(+), 19 deletions(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 3568149b9562..0b469096ef79 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -429,6 +429,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
> 	       const struct dpll_pin_properties *prop)
> {
> 	struct dpll_pin *pin;
>+	size_t freq_size;
> 	int ret;
> 
> 	pin = kzalloc(sizeof(*pin), GFP_KERNEL);
>@@ -440,9 +441,22 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
> 	if (WARN_ON(prop->type < DPLL_PIN_TYPE_MUX ||
> 		    prop->type > DPLL_PIN_TYPE_MAX)) {
> 		ret = -EINVAL;
>-		goto err;
>+		goto pin_free;
> 	}
>-	pin->prop = prop;
>+	memcpy(&pin->prop, prop, sizeof(pin->prop));
>+	if (prop->freq_supported && prop->freq_supported_num) {
>+		freq_size = prop->freq_supported_num *
>+			    sizeof(*pin->prop.freq_supported);
>+		pin->prop.freq_supported = kmemdup(prop->freq_supported,
>+						   freq_size, GFP_KERNEL);
>+		if (!pin->prop.freq_supported) {
>+			ret = -ENOMEM;
>+			goto pin_free;
>+		}
>+	}
>+	pin->prop.board_label = kstrdup(prop->board_label, GFP_KERNEL);
>+	pin->prop.panel_label = kstrdup(prop->panel_label, GFP_KERNEL);
>+	pin->prop.package_label = kstrdup(prop->package_label, GFP_KERNEL);

Care to check the return values? Also don't kstrdup null pointers, does
not make much sense.

Could you perhaps move the prop dup/free to separate functions?


> 	refcount_set(&pin->refcount, 1);
> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>@@ -451,8 +465,13 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
> 		goto err;
> 	return pin;
> err:
>+	kfree(pin->prop.package_label);
>+	kfree(pin->prop.panel_label);
>+	kfree(pin->prop.board_label);
>+	kfree(pin->prop.freq_supported);
> 	xa_destroy(&pin->dpll_refs);
> 	xa_destroy(&pin->parent_refs);
>+pin_free:
> 	kfree(pin);
> 	return ERR_PTR(ret);
> }
>@@ -512,6 +531,10 @@ void dpll_pin_put(struct dpll_pin *pin)
> 		xa_destroy(&pin->dpll_refs);
> 		xa_destroy(&pin->parent_refs);
> 		xa_erase(&dpll_pin_xa, pin->id);
>+		kfree(pin->prop.board_label);
>+		kfree(pin->prop.panel_label);
>+		kfree(pin->prop.package_label);
>+		kfree(pin->prop.freq_supported);
> 		kfree(pin);
> 	}
> 	mutex_unlock(&dpll_lock);
>@@ -634,7 +657,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
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
>index b53478374a38..3ce9995013f1 100644
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
>@@ -398,7 +398,7 @@ static int
> dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
> 		     struct netlink_ext_ack *extack)
> {
>-	const struct dpll_pin_properties *prop = pin->prop;
>+	const struct dpll_pin_properties *prop = &pin->prop;
> 	struct dpll_pin_ref *ref;
> 	int ret;
> 
>@@ -691,7 +691,7 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
> 	int ret;
> 
> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>-	      pin->prop->capabilities)) {
>+	      pin->prop.capabilities)) {
> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
> 		return -EOPNOTSUPP;
> 	}
>@@ -727,7 +727,7 @@ dpll_pin_state_set(struct dpll_device *dpll, struct dpll_pin *pin,
> 	int ret;
> 
> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>-	      pin->prop->capabilities)) {
>+	      pin->prop.capabilities)) {
> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
> 		return -EOPNOTSUPP;
> 	}
>@@ -754,7 +754,7 @@ dpll_pin_prio_set(struct dpll_device *dpll, struct dpll_pin *pin,
> 	int ret;
> 
> 	if (!(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE &
>-	      pin->prop->capabilities)) {
>+	      pin->prop.capabilities)) {
> 		NL_SET_ERR_MSG(extack, "prio changing is not allowed");
> 		return -EOPNOTSUPP;
> 	}
>@@ -782,7 +782,7 @@ dpll_pin_direction_set(struct dpll_pin *pin, struct dpll_device *dpll,
> 	int ret;
> 
> 	if (!(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE &
>-	      pin->prop->capabilities)) {
>+	      pin->prop.capabilities)) {
> 		NL_SET_ERR_MSG(extack, "direction changing is not allowed");
> 		return -EOPNOTSUPP;
> 	}
>@@ -812,8 +812,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
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
>@@ -997,7 +997,7 @@ dpll_pin_find(u64 clock_id, struct nlattr *mod_name_attr,
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

