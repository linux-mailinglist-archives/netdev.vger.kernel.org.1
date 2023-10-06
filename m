Return-Path: <netdev+bounces-38581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C261E7BB7D4
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EB61C20A16
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C1C17725;
	Fri,  6 Oct 2023 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SknQr1HI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B21D557
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:38:12 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF290CE
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 05:38:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so3612766a12.3
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 05:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696595889; x=1697200689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYiSCW3dJ1barhenWUxHLxtb/rbkGFc35GP5tPgXmVQ=;
        b=SknQr1HIJb/t6thWrM+etXRLDzI8a2uwqVP0fPTXRzkqcBEU8z6e+tAnDQ2AqLla5g
         IrFO3LQDS4RYXbK5kmVtsYG88Tl1DRsYZfxwjnn8yIMKvDYqNbdiGAtnvXTlvhcLVV8R
         dTrDN2yCYK0m2PQK0rqDrMCsHGB66APF98bcml5mExhHMg1gJM/hVQVAvTbqmKEB1Smc
         p1tBmRQ1xW/c/GK4tBEHa/bF9POiEqZten8/1jvc2cnJWzmOz8Pw6akMij0/C1PP9v2k
         JXTNybZVGMtotkqUJwmuk1OybbOJ7Da4c9GGvRnbylfvp5B3GMiU7rkKtrwJHoyaXy2K
         55lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696595889; x=1697200689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYiSCW3dJ1barhenWUxHLxtb/rbkGFc35GP5tPgXmVQ=;
        b=GZ/bSijk5PPqJb2R24aH9quVYLCUau8jyj2XJHg+Bpf7bsAm8PlZHSQ0zTpBj7ibIU
         sPXfJOX74gwKjKp5wapmoM0RHfhexebcAP15Tql9KeXNP3SlBtmS9N7Op7Mo8MOpJ7dy
         QK7DGjBxYA6MjzhsRxQTF3mzuDD4WVJgZLnPm4KxFwv5ctaMXgDZaQso2xtcHl424wtr
         upIu9ByDkvC8J2yWVIHQjxj4ysGckaASfZMpO5dl7dYqLPT8bMfQSkCpb4+cCpsnGJ+E
         Z3mjRVFNNPaygGFcpMNS/iyokzHqCz6aAiURRb11sBVGrIb8fgX+Yx/BxaV8QjuchO+k
         3hhw==
X-Gm-Message-State: AOJu0Yzv+EC89h0jmj3Mx2ptzSwkj9GHPndLiji7ylSrnmR98OYWSJB/
	4vdblmrebg9MfJtkqG7ESwHcrg==
X-Google-Smtp-Source: AGHT+IE7Jhiqy/RANR7wJrqH8j8c0q3qgKa2GA2zbWSUUFnUk7SoMhtCfUlX+V7sPaU0O1+LNABaVw==
X-Received: by 2002:aa7:db46:0:b0:532:ac24:3081 with SMTP id n6-20020aa7db46000000b00532ac243081mr7263774edt.30.1696595889119;
        Fri, 06 Oct 2023 05:38:09 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h13-20020a50ed8d000000b005307e75d24dsm2536245edr.17.2023.10.06.05.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:38:07 -0700 (PDT)
Date: Fri, 6 Oct 2023 14:38:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v3 3/5] dpll: netlink/core: add support for
 pin-dpll signal phase offset/adjust
Message-ID: <ZR//rQ7WGmHeRBOP@nanopsycho>
References: <20231006114101.1608796-1-arkadiusz.kubalewski@intel.com>
 <20231006114101.1608796-4-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006114101.1608796-4-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Oct 06, 2023 at 01:40:59PM CEST, arkadiusz.kubalewski@intel.com wrote:
>Add callback ops for pin-dpll phase measurment.
>Add callback for pin signal phase adjustment.
>Add min and max phase adjustment values to pin proprties.
>Invoke callbacks in dpll_netlink.c when filling the pin details to
>provide user with phase related attribute values.
>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/dpll/dpll_netlink.c | 130 +++++++++++++++++++++++++++++++++++-
> include/linux/dpll.h        |  18 +++++
> 2 files changed, 147 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index e20daba6896a..97319a9e4667 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -212,6 +212,53 @@ dpll_msg_add_pin_direction(struct sk_buff *msg, struct dpll_pin *pin,
> 	return 0;
> }
> 
>+static int
>+dpll_msg_add_pin_phase_adjust(struct sk_buff *msg, struct dpll_pin *pin,
>+			      struct dpll_pin_ref *ref,
>+			      struct netlink_ext_ack *extack)
>+{
>+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>+	struct dpll_device *dpll = ref->dpll;
>+	s32 phase_adjust;
>+	int ret;
>+
>+	if (!ops->phase_adjust_get)
>+		return 0;
>+	ret = ops->phase_adjust_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
>+				    dpll, dpll_priv(dpll),
>+				    &phase_adjust, extack);
>+	if (ret)
>+		return ret;
>+	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST, phase_adjust))
>+		return -EMSGSIZE;
>+
>+	return 0;
>+}
>+
>+static int
>+dpll_msg_add_phase_offset(struct sk_buff *msg, struct dpll_pin *pin,
>+			  struct dpll_pin_ref *ref,
>+			  struct netlink_ext_ack *extack)
>+{
>+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>+	struct dpll_device *dpll = ref->dpll;
>+	s64 phase_offset;
>+	int ret;
>+
>+	if (!ops->phase_offset_get)
>+		return 0;
>+	ret = ops->phase_offset_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
>+				    dpll, dpll_priv(dpll), &phase_offset,
>+				    extack);
>+	if (ret)
>+		return ret;
>+	if (nla_put_64bit(msg, DPLL_A_PIN_PHASE_OFFSET, sizeof(phase_offset),
>+			  &phase_offset, DPLL_A_PIN_PAD))
>+		return -EMSGSIZE;
>+
>+	return 0;
>+}
>+
> static int
> dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
> 		      struct dpll_pin_ref *ref, struct netlink_ext_ack *extack)
>@@ -330,6 +377,9 @@ dpll_msg_add_pin_dplls(struct sk_buff *msg, struct dpll_pin *pin,
> 		if (ret)
> 			goto nest_cancel;
> 		ret = dpll_msg_add_pin_direction(msg, pin, ref, extack);
>+		if (ret)
>+			goto nest_cancel;
>+		ret = dpll_msg_add_phase_offset(msg, pin, ref, extack);
> 		if (ret)
> 			goto nest_cancel;
> 		nla_nest_end(msg, attr);
>@@ -377,6 +427,15 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
> 	if (nla_put_u32(msg, DPLL_A_PIN_CAPABILITIES, prop->capabilities))
> 		return -EMSGSIZE;
> 	ret = dpll_msg_add_pin_freq(msg, pin, ref, extack);
>+	if (ret)
>+		return ret;
>+	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST_MIN,
>+			prop->phase_range.min))
>+		return -EMSGSIZE;
>+	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST_MAX,
>+			prop->phase_range.max))
>+		return -EMSGSIZE;
>+	ret = dpll_msg_add_pin_phase_adjust(msg, pin, ref, extack);
> 	if (ret)
> 		return ret;
> 	if (xa_empty(&pin->parent_refs))
>@@ -416,7 +475,7 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
> 	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
> 		return -EMSGSIZE;
> 
>-	return ret;
>+	return 0;
> }
> 
> static int
>@@ -705,6 +764,70 @@ dpll_pin_direction_set(struct dpll_pin *pin, struct dpll_device *dpll,
> 	return 0;
> }
> 
>+static int
>+dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
>+		       struct netlink_ext_ack *extack)
>+{
>+	struct dpll_pin_ref *ref, *failed;
>+	const struct dpll_pin_ops *ops;
>+	s32 phase_adj, old_phase_adj;
>+	struct dpll_device *dpll;
>+	unsigned long i;
>+	int ret;
>+
>+	phase_adj = nla_get_s32(phase_adj_attr);
>+	if (phase_adj > pin->prop->phase_range.max ||
>+	    phase_adj < pin->prop->phase_range.min) {
>+		NL_SET_ERR_MSG(extack, "phase adjust value not supported");
>+		return -EINVAL;
>+	}
>+	xa_for_each(&pin->dpll_refs, i, ref) {
>+		ops = dpll_pin_ops(ref);
>+		if (!ops->phase_adjust_set || !ops->phase_adjust_get)

Extack msg.


>+			return -EOPNOTSUPP;
>+	}
>+	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
>+	ops = dpll_pin_ops(ref);
>+	dpll = ref->dpll;
>+	ret = ops->phase_adjust_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
>+				    dpll, dpll_priv(dpll), &old_phase_adj,
>+				    extack);
>+	if (ret) {
>+		NL_SET_ERR_MSG(extack, "unable to get old phase adjust value");
>+		return ret;
>+	}
>+	if (phase_adj == old_phase_adj)
>+		return 0;
>+	xa_for_each(&pin->dpll_refs, i, ref) {
>+		ops = dpll_pin_ops(ref);
>+		dpll = ref->dpll;
>+		ret = ops->phase_adjust_set(pin,
>+					    dpll_pin_on_dpll_priv(dpll, pin),
>+					    dpll, dpll_priv(dpll), phase_adj,
>+					    extack);
>+		if (ret) {
>+			failed = ref;

Extack msg.

>+			goto rollback;
>+		}
>+	}
>+	__dpll_pin_change_ntf(pin);
>+
>+	return 0;
>+
>+rollback:
>+	xa_for_each(&pin->dpll_refs, i, ref) {
>+		if (ref == failed)
>+			break;
>+		ops = dpll_pin_ops(ref);
>+		dpll = ref->dpll;
>+		if (ops->phase_adjust_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>+					  dpll, dpll_priv(dpll), old_phase_adj,
>+					  extack))
>+			NL_SET_ERR_MSG(extack, "set phase adjust rollback failed");
>+	}
>+	return ret;
>+}
>+
> static int
> dpll_pin_parent_device_set(struct dpll_pin *pin, struct nlattr *parent_nest,
> 			   struct netlink_ext_ack *extack)
>@@ -793,6 +916,11 @@ dpll_pin_set_from_nlattr(struct dpll_pin *pin, struct genl_info *info)
> 			if (ret)
> 				return ret;
> 			break;
>+		case DPLL_A_PIN_PHASE_ADJUST:
>+			ret = dpll_pin_phase_adj_set(pin, a, info->extack);
>+			if (ret)
>+				return ret;
>+			break;
> 		case DPLL_A_PIN_PARENT_DEVICE:
> 			ret = dpll_pin_parent_device_set(pin, a, info->extack);
> 			if (ret)
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index bbc480cd2932..578fc5fa3750 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -68,6 +68,18 @@ struct dpll_pin_ops {
> 	int (*prio_set)(const struct dpll_pin *pin, void *pin_priv,
> 			const struct dpll_device *dpll, void *dpll_priv,
> 			const u32 prio, struct netlink_ext_ack *extack);
>+	int (*phase_offset_get)(const struct dpll_pin *pin, void *pin_priv,
>+				const struct dpll_device *dpll, void *dpll_priv,
>+				s64 *phase_offset,
>+				struct netlink_ext_ack *extack);
>+	int (*phase_adjust_get)(const struct dpll_pin *pin, void *pin_priv,
>+				const struct dpll_device *dpll, void *dpll_priv,
>+				s32 *phase_adjust,
>+				struct netlink_ext_ack *extack);
>+	int (*phase_adjust_set)(const struct dpll_pin *pin, void *pin_priv,
>+				const struct dpll_device *dpll, void *dpll_priv,
>+				const s32 phase_adjust,
>+				struct netlink_ext_ack *extack);
> };
> 
> struct dpll_pin_frequency {
>@@ -91,6 +103,11 @@ struct dpll_pin_frequency {
> #define DPLL_PIN_FREQUENCY_DCF77 \
> 	DPLL_PIN_FREQUENCY(DPLL_PIN_FREQUENCY_77_5_KHZ)
> 
>+struct dpll_pin_phase_adjust_range {
>+	s32 min;
>+	s32 max;
>+};
>+
> struct dpll_pin_properties {
> 	const char *board_label;
> 	const char *panel_label;
>@@ -99,6 +116,7 @@ struct dpll_pin_properties {
> 	unsigned long capabilities;
> 	u32 freq_supported_num;
> 	struct dpll_pin_frequency *freq_supported;
>+	struct dpll_pin_phase_adjust_range phase_range;
> };
> 
> #if IS_ENABLED(CONFIG_DPLL)
>-- 
>2.38.1
>

