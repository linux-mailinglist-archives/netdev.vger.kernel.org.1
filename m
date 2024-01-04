Return-Path: <netdev+bounces-61565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94C9824498
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC2ECB256DA
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B61423750;
	Thu,  4 Jan 2024 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SklXaHer"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D943624209
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3374d309eebso437669f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 07:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704380672; x=1704985472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcPs1WUo4AIWim5hDDqVkTibShrA88cFxXNbytzOzfo=;
        b=SklXaHerihK4vMOWxjSKFphae7rDSIc844rWcecqtJRDBKEg2xvlyUc7fqoh/C9KpI
         J0PAN+qelK4Jk4L+mramLjdIIBwu1NXbcUTaDa16pF0vjOMykYPyTsfOfmJ9bsSc3IvI
         26w8F8TZyupp6sRv5CptTBOneTYdCaUcXQtVN2OLfnPxIdlxmbWCd835ReNJfokflm1V
         wssD98/A/pVx4HhzdC076BZXs1dkX2M+sLjlEXhzCvA5FWKo7j5WhR+WdAsTcki6TI2d
         NpGhuBnJSLB0WRhYQDarhaIzVQxKlcXCHEFls0YvtU0GdQpfkCEDgEImpvCsqRhLAPSb
         Khog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704380672; x=1704985472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcPs1WUo4AIWim5hDDqVkTibShrA88cFxXNbytzOzfo=;
        b=RqVdPBWAmSdN65bJPU+LhyIl0vKFpYOcJHp50nmfrC4BF7qfkDZ+i5THC+/9qrUDSd
         0x2kaHFJFFl3sOXHJukVDhH8pOz9sawwa6KnTuaNHou3qHioviCLHIuAUlPT6JI7QatV
         MzIaUhjKMzA9dc8Yo/Uvu/+xFaz7pOD6lYTEMhq39fHfGrycHBWFyABjlnCR3pvlYfdT
         XO90x5W6+VW9HV/zpMrb9/zGieapcYCrVURKV67aQksi/G6kU0fCV98uw86kwTgg3qef
         XuVfJbLT/2MbYBFEuLy5CrwIciJ7xhKCpTeUUrUbW+Q1p65QaWzEqanK0BbEUL9E0ttJ
         475Q==
X-Gm-Message-State: AOJu0YzH7RRvlNkj2qXXdx4CEjScbofjR3nWWsjH8Br4Q2N8IDzMIOi4
	FlbsI5J70X9qEY571EdBW4M4Z9g+wjHS1w==
X-Google-Smtp-Source: AGHT+IGPzjUTMwIRGwyZFG4cS9X9/+uqFWXGyBYL6nhsAXwcm87kJEAjZY4e3NyJWBLqHtV67kKnxw==
X-Received: by 2002:a05:6000:1374:b0:336:7ff4:8904 with SMTP id q20-20020a056000137400b003367ff48904mr458338wrz.129.1704380671977;
        Thu, 04 Jan 2024 07:04:31 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id dr15-20020a5d5f8f000000b003373ece28efsm10700629wrb.29.2024.01.04.07.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:04:31 -0800 (PST)
Date: Thu, 4 Jan 2024 16:04:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	michal.michalik@intel.com, milena.olech@intel.com,
	pabeni@redhat.com, kuba@kernel.org, Jan Glaza <jan.glaza@intel.com>
Subject: Re: [PATCH net v2 4/4] dpll: hide "zombie" pins for userspace
Message-ID: <ZZbI_gsQuugrJ7X9@nanopsycho>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
 <20240104111132.42730-5-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104111132.42730-5-arkadiusz.kubalewski@intel.com>

Thu, Jan 04, 2024 at 12:11:32PM CET, arkadiusz.kubalewski@intel.com wrote:
>If parent pin was unregistered but child pin was not, the userspace
>would see the "zombie" pins - the ones that were registered with
>parent pin (pins_pin_on_pin_register(..)).
>Technically those are not available - as there is no dpll device in the
>system. Do not dump those pins and prevent userspace from any
>interaction with them.

Ah, here it is :)


>
>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/dpll/dpll_netlink.c | 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)
>
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index f266db8da2f0..495dfc43c0be 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -949,6 +949,19 @@ dpll_pin_parent_pin_set(struct dpll_pin *pin, struct nlattr *parent_nest,
> 	return 0;
> }
> 
>+static bool dpll_pin_parents_registered(struct dpll_pin *pin)
>+{
>+	struct dpll_pin_ref *par_ref;
>+	struct dpll_pin *p;
>+	unsigned long i, j;
>+
>+	xa_for_each(&pin->parent_refs, i, par_ref)
>+		xa_for_each_marked(&dpll_pin_xa, j, p, DPLL_REGISTERED)
>+			if (par_ref->pin == p)
>+				return true;

		if (xa_get_mark(..))
			return true;
?


>+	return false;


As I wrote in the reply to the other patch, could you unify the "hide"
behaviour for unregistered parent pin/device?


>+}
>+
> static int
> dpll_pin_set_from_nlattr(struct dpll_pin *pin, struct genl_info *info)
> {
>@@ -1153,6 +1166,9 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> 
> 	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
> 				 ctx->idx) {
>+		if (!xa_empty(&pin->parent_refs) &&

This empty check is redundant, remove it.


>+		    !dpll_pin_parents_registered(pin))
>+			continue;
> 		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> 				  cb->nlh->nlmsg_seq,
> 				  &dpll_nl_family, NLM_F_MULTI,
>@@ -1179,6 +1195,10 @@ int dpll_nl_pin_set_doit(struct sk_buff *skb, struct genl_info *info)
> {
> 	struct dpll_pin *pin = info->user_ptr[0];
> 
>+	if (!xa_empty(&pin->parent_refs) &&

This empty check is redundant, remove it.


>+	    !dpll_pin_parents_registered(pin))
>+		return -ENODEV;
>+
> 	return dpll_pin_set_from_nlattr(pin, info);
> }
> 
>-- 
>2.38.1
>

