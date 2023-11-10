Return-Path: <netdev+bounces-47006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD8B7E7981
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 07:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10F31C20951
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 06:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E4515C5;
	Fri, 10 Nov 2023 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1k/w5r7o"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B75693
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 06:45:48 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6877D93
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 22:45:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so2902673a12.0
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 22:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699598743; x=1700203543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qypWoW7ZTH/tPG5/ROZ+kLsmZ0OczrCjify1t7H7Q08=;
        b=1k/w5r7ohVwB3tJMkTuKGKwV6p8fac7VwafO47+I6J/AXSRtrvfhYB/FgNV8KSerTA
         /QstEJVWmcEspm2tIi5dx2rltn7ysKXH3X6zJDYU2mXhdpSsU3NiRtv66y6OUj+MXSAd
         OeaWxp0RtcRiSASaSQBdOWqZ1lUHGgLBWGQXviAxzlUg6HA844wmL2t5vFyvoqtkPuaL
         1nxmxr/z3XergjYhAZ51iVSORWImjx/q1Ro4h5ji9vYfeSDBPXs5VRV3fAzkq7hfoZUB
         B683CBsjA3iIHB03whW6xCHkQHwjIbBQDQibEwup7/Uy7nU+rGK3/qDahnYHj7cgIurp
         4LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598743; x=1700203543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qypWoW7ZTH/tPG5/ROZ+kLsmZ0OczrCjify1t7H7Q08=;
        b=QSacFas/wkueKyWcYc+i1GWrFk7/xOBcQjyJMqV81Y30ICoNwl2EviBBdkSnBv1D1N
         OlBpArZf4Bs9gouHq2A+YeJChTkFxap4WQl6TBp8SxVC7ZsMSOIxWch4iaq9hSMcQyyK
         vdn7tmeqP8t3RTkvX39zv11CAqL/jprZE08iRXBqM2Y3dOT3mpBHa4NHspop5uJcb+4h
         RHsjgviroeLUV66mEIrGO/FaPXF3nIQZi1qA896z/VGpbyyQant6y3poDMiEhxrguEhR
         Lgg+KlvawR2e4q15HUzW9BB9I3TVmATGXFsvUCGOKcHwuDXxpYjZU6ybvuXP6qq3IGKs
         VSNw==
X-Gm-Message-State: AOJu0Yz7mW1MvxhZ0OEODwTvCmcRjUkqNfMfSjU5+KD46c1WwhZ2pPFJ
	i+hUk0vw2LAAJ7Q5rhrFKbwoww==
X-Google-Smtp-Source: AGHT+IHjrZB3N6aujTlh0lfS9Kz4oUd+/H9XRRjEPbdCwl+eS9CKebWE1fJuPLrIIYUqkPZFwUz9hQ==
X-Received: by 2002:a50:f612:0:b0:53e:3839:fc81 with SMTP id c18-20020a50f612000000b0053e3839fc81mr6014369edn.32.1699598743022;
        Thu, 09 Nov 2023 22:45:43 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h10-20020a50cdca000000b00540ea3a25e6sm755710edj.72.2023.11.09.22.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 22:45:42 -0800 (PST)
Date: Fri, 10 Nov 2023 07:45:41 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Message-ID: <ZU3RlSmInnoXufxf@nanopsycho>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-3-arkadiusz.kubalewski@intel.com>
 <ZUubagu6B+vbfBqm@nanopsycho>
 <DM6PR11MB465752FE337EB962B147EB579BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZUzcTBmSPxIs5iH3@nanopsycho>
 <DM6PR11MB46571D4C776B0B1888F943569BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU0fj5y9mAvVzXuf@nanopsycho>
 <DM6PR11MB4657DAC525E05B5DB72145119BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657DAC525E05B5DB72145119BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>

Fri, Nov 10, 2023 at 12:32:21AM CET, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Thursday, November 9, 2023 7:06 PM
>>
>>Thu, Nov 09, 2023 at 05:30:20PM CET, arkadiusz.kubalewski@intel.com wrote:
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Thursday, November 9, 2023 2:19 PM
>>>>
>>>>Thu, Nov 09, 2023 at 01:20:48PM CET, arkadiusz.kubalewski@intel.com
>>>>wrote:
>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>Sent: Wednesday, November 8, 2023 3:30 PM
>>>>>>
>>>>>>Wed, Nov 08, 2023 at 11:32:25AM CET, arkadiusz.kubalewski@intel.com
>>>>>>wrote:
>>>>>>>When a kernel module is unbound but the pin resources were not
>>>>>>>entirely
>>>>>>>freed (other kernel module instance have had kept the reference to
>>>>>>>that
>>>>>>>pin), and kernel module is again bound, the pin properties would not
>>>>>>>be
>>>>>>>updated (the properties are only assigned when memory for the pin is
>>>>>>>allocated), prop pointer still points to the kernel module memory of
>>>>>>>the kernel module which was deallocated on the unbind.
>>>>>>>
>>>>>>>If the pin dump is invoked in this state, the result is a kernel
>>>>>>>crash.
>>>>>>>Prevent the crash by storing persistent pin properties in dpll
>>>>>>>subsystem,
>>>>>>>copy the content from the kernel module when pin is allocated, instead
>>>>>>>of
>>>>>>>using memory of the kernel module.
>>>>>>>
>>>>>>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>>>>>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>>>>>>functions")
>>>>>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>>>>---
>>>>>>> drivers/dpll/dpll_core.c    |  4 ++--
>>>>>>> drivers/dpll/dpll_core.h    |  4 ++--
>>>>>>> drivers/dpll/dpll_netlink.c | 28 ++++++++++++++--------------
>>>>>>> 3 files changed, 18 insertions(+), 18 deletions(-)
>>>>>>>
>>>>>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>>>>>index 3568149b9562..4077b562ba3b 100644
>>>>>>>--- a/drivers/dpll/dpll_core.c
>>>>>>>+++ b/drivers/dpll/dpll_core.c
>>>>>>>@@ -442,7 +442,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>>>>>>>module *module,
>>>>>>> 		ret = -EINVAL;
>>>>>>> 		goto err;
>>>>>>> 	}
>>>>>>>-	pin->prop = prop;
>>>>>>>+	memcpy(&pin->prop, prop, sizeof(pin->prop));
>>>>>>
>>>>>>Odd, you don't care about the pointer within this structure?
>>>>>>
>>>>>
>>>>>Well, true. Need a fix.
>>>>>Wondering if copying idea is better than just assigning prop pointer on
>>>>>each call to dpll_pin_get(..) function (when pin already exists)?
>>>>
>>>>Not sure what do you mean. Examples please.
>>>>
>>>
>>>Sure,
>>>
>>>Basically this change:
>>>
>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>index ae884b92d68c..06b72d5877c3 100644
>>>--- a/drivers/dpll/dpll_core.c
>>>+++ b/drivers/dpll/dpll_core.c
>>>@@ -483,6 +483,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module
>>>*module,
>>>                    pos->pin_idx == pin_idx &&
>>>                    pos->module == module) {
>>>                        ret = pos;
>>>+                       pos->prop = prop;
>>>                        refcount_inc(&ret->refcount);
>>>                        break;
>>>                }
>>>
>>>would replace whole of this patch changes, although seems a bit hacky.
>>
>>Or event better, as I suggested in the other patch reply, resolve this
>>internally in the driver registering things only when they are valid.
>>Much better then to hack anything in dpll core.
>>
>
>This approach seemed to me hacky, that is why started with coping the
>data.
>It is not about registering, rather about unregistering on driver
>unbind, which brakes things, and currently cannot be recovered in
>described case.

Sure it can. PF0 unbind-> internal notification-> PF1 unregisters all
related object. Very clean and simple.


>
>Thank you!
>Arkadiusz
>
>>
>>>
>>>Thank you!
>>>Arkadiusz
>>>
>>>>
>>>>>
>>>>>Thank you!
>>>>>Arkadiusz
>>>>>
>>>>>>
>>>>>>> 	refcount_set(&pin->refcount, 1);
>>>>>>> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>>>>>>> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>>>>>>>@@ -634,7 +634,7 @@ int dpll_pin_on_pin_register(struct dpll_pin
>>>>>>>*parent,
>>>>>>>struct dpll_pin *pin,
>>>>>>> 	unsigned long i, stop;
>>>>>>> 	int ret;
>>>>>>>
>>>>>>>-	if (WARN_ON(parent->prop->type != DPLL_PIN_TYPE_MUX))
>>>>>>>+	if (WARN_ON(parent->prop.type != DPLL_PIN_TYPE_MUX))
>>>>>>> 		return -EINVAL;
>>>>>>>
>>>>>>> 	if (WARN_ON(!ops) ||
>>>>>>>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>>>>>>>index 5585873c5c1b..717f715015c7 100644
>>>>>>>--- a/drivers/dpll/dpll_core.h
>>>>>>>+++ b/drivers/dpll/dpll_core.h
>>>>>>>@@ -44,7 +44,7 @@ struct dpll_device {
>>>>>>>  * @module:		module of creator
>>>>>>>  * @dpll_refs:		hold referencees to dplls pin was registered
>>>>>>>with
>>>>>>>  * @parent_refs:	hold references to parent pins pin was registered
>>>>>>>with
>>>>>>>- * @prop:		pointer to pin properties given by registerer
>>>>>>>+ * @prop:		pin properties copied from the registerer
>>>>>>>  * @rclk_dev_name:	holds name of device when pin can recover
>>>>>>>clock
>>>>>>>from it
>>>>>>>  * @refcount:		refcount
>>>>>>>  **/
>>>>>>>@@ -55,7 +55,7 @@ struct dpll_pin {
>>>>>>> 	struct module *module;
>>>>>>> 	struct xarray dpll_refs;
>>>>>>> 	struct xarray parent_refs;
>>>>>>>-	const struct dpll_pin_properties *prop;
>>>>>>>+	struct dpll_pin_properties prop;
>>>>>>> 	refcount_t refcount;
>>>>>>> };
>>>>>>>
>>>>>>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>>>>>>index 93fc6c4b8a78..963bbbbe6660 100644
>>>>>>>--- a/drivers/dpll/dpll_netlink.c
>>>>>>>+++ b/drivers/dpll/dpll_netlink.c
>>>>>>>@@ -278,17 +278,17 @@ dpll_msg_add_pin_freq(struct sk_buff *msg,
>>>>>>>struct
>>>>>>>dpll_pin *pin,
>>>>>>> 	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY, sizeof(freq),
>>>>>>>&freq,
>>>>>>> 			  DPLL_A_PIN_PAD))
>>>>>>> 		return -EMSGSIZE;
>>>>>>>-	for (fs = 0; fs < pin->prop->freq_supported_num; fs++) {
>>>>>>>+	for (fs = 0; fs < pin->prop.freq_supported_num; fs++) {
>>>>>>> 		nest = nla_nest_start(msg,
>>>>>>>DPLL_A_PIN_FREQUENCY_SUPPORTED);
>>>>>>> 		if (!nest)
>>>>>>> 			return -EMSGSIZE;
>>>>>>>-		freq = pin->prop->freq_supported[fs].min;
>>>>>>>+		freq = pin->prop.freq_supported[fs].min;
>>>>>>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN,
>>>>>>>sizeof(freq),
>>>>>>> 				  &freq, DPLL_A_PIN_PAD)) {
>>>>>>> 			nla_nest_cancel(msg, nest);
>>>>>>> 			return -EMSGSIZE;
>>>>>>> 		}
>>>>>>>-		freq = pin->prop->freq_supported[fs].max;
>>>>>>>+		freq = pin->prop.freq_supported[fs].max;
>>>>>>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX,
>>>>>>>sizeof(freq),
>>>>>>> 				  &freq, DPLL_A_PIN_PAD)) {
>>>>>>> 			nla_nest_cancel(msg, nest);
>>>>>>>@@ -304,9 +304,9 @@ static bool dpll_pin_is_freq_supported(struct
>>>>>>>dpll_pin
>>>>>>>*pin, u32 freq)
>>>>>>> {
>>>>>>> 	int fs;
>>>>>>>
>>>>>>>-	for (fs = 0; fs < pin->prop->freq_supported_num; fs++)
>>>>>>>-		if (freq >= pin->prop->freq_supported[fs].min &&
>>>>>>>-		    freq <= pin->prop->freq_supported[fs].max)
>>>>>>>+	for (fs = 0; fs < pin->prop.freq_supported_num; fs++)
>>>>>>>+		if (freq >= pin->prop.freq_supported[fs].min &&
>>>>>>>+		    freq <= pin->prop.freq_supported[fs].max)
>>>>>>> 			return true;
>>>>>>> 	return false;
>>>>>>> }
>>>>>>>@@ -403,7 +403,7 @@ static int
>>>>>>> dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
>>>>>>> 		     struct netlink_ext_ack *extack)
>>>>>>> {
>>>>>>>-	const struct dpll_pin_properties *prop = pin->prop;
>>>>>>>+	const struct dpll_pin_properties *prop = &pin->prop;
>>>>>>> 	struct dpll_pin_ref *ref;
>>>>>>> 	int ret;
>>>>>>>
>>>>>>>@@ -696,7 +696,7 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin,
>>>>>>>u32
>>>>>>>parent_idx,
>>>>>>> 	int ret;
>>>>>>>
>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>>>>>>> 		return -EOPNOTSUPP;
>>>>>>> 	}
>>>>>>>@@ -732,7 +732,7 @@ dpll_pin_state_set(struct dpll_device *dpll,
>>>>>>>struct
>>>>>>>dpll_pin *pin,
>>>>>>> 	int ret;
>>>>>>>
>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>>>>>>> 		return -EOPNOTSUPP;
>>>>>>> 	}
>>>>>>>@@ -759,7 +759,7 @@ dpll_pin_prio_set(struct dpll_device *dpll, struct
>>>>>>>dpll_pin *pin,
>>>>>>> 	int ret;
>>>>>>>
>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE &
>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>> 		NL_SET_ERR_MSG(extack, "prio changing is not allowed");
>>>>>>> 		return -EOPNOTSUPP;
>>>>>>> 	}
>>>>>>>@@ -787,7 +787,7 @@ dpll_pin_direction_set(struct dpll_pin *pin,
>>>>>>>struct
>>>>>>>dpll_device *dpll,
>>>>>>> 	int ret;
>>>>>>>
>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE &
>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>> 		NL_SET_ERR_MSG(extack, "direction changing is not
>>>>>>>allowed");
>>>>>>> 		return -EOPNOTSUPP;
>>>>>>> 	}
>>>>>>>@@ -817,8 +817,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin,
>>>>>>>struct
>>>>>>>nlattr *phase_adj_attr,
>>>>>>> 	int ret;
>>>>>>>
>>>>>>> 	phase_adj = nla_get_s32(phase_adj_attr);
>>>>>>>-	if (phase_adj > pin->prop->phase_range.max ||
>>>>>>>-	    phase_adj < pin->prop->phase_range.min) {
>>>>>>>+	if (phase_adj > pin->prop.phase_range.max ||
>>>>>>>+	    phase_adj < pin->prop.phase_range.min) {
>>>>>>> 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
>>>>>>> 				    "phase adjust value not supported");
>>>>>>> 		return -EINVAL;
>>>>>>>@@ -999,7 +999,7 @@ dpll_pin_find(u64 clock_id, struct nlattr
>>>>>>>*mod_name_attr,
>>>>>>> 	unsigned long i;
>>>>>>>
>>>>>>> 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
>>>>>>>-		prop = pin->prop;
>>>>>>>+		prop = &pin->prop;
>>>>>>> 		cid_match = clock_id ? pin->clock_id == clock_id : true;
>>>>>>> 		mod_match = mod_name_attr && module_name(pin->module) ?
>>>>>>> 			!nla_strcmp(mod_name_attr,
>>>>>>>--
>>>>>>>2.38.1
>>>>>>>
>>>>>
>

