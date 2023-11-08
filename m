Return-Path: <netdev+bounces-46652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA87E59B4
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 16:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8871FB20C75
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC030322;
	Wed,  8 Nov 2023 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aKfYXL+f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933ED4C7F
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 15:08:46 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B551BE5
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 07:08:45 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a6190af24aso1088218666b.0
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699456124; x=1700060924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20noXmNraMuNIbsacYWC++j7zo4NVQhLYKhuMZttxuQ=;
        b=aKfYXL+fI0FAdF3YnM+A5CrQT7q7Gc+UPwWtDMsmi8gTFHphVSVxeX9KbnLudQy/FU
         teSIGagVO3Y/VNEIxzhipB02YY1pEmVgXoGbJMfVJVdDhFCKXVLoF+HPt1i0ZJexWQuH
         xyW3DGPYbOKWswDhaR376Zp0rmGRxM0lvwAdlWN1fm9RoQuBr/cQIQNVJbQtrcZYxBbn
         W5baI6ikH/whWcOpid0Vu8S+E8TncXJ17rGvcs1/6Qzw6tlXmYznZKhe8lnjM32UFV9j
         jVLCIVNAHH/GDQE5joolrtnluiW+lz/c/JmxReop1SJ3SDQxWyqJm+Bg3kMqPQe1IQ2D
         x+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699456124; x=1700060924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20noXmNraMuNIbsacYWC++j7zo4NVQhLYKhuMZttxuQ=;
        b=WEhtJZZMsdbxYIrsyhNRaoBhd9JkZ5C9zvE7O/hk1sHUHB3FHFn4WPujPjQy4VDeoE
         L5OiwX2bMuCLXE87wqBAULet0jmLKYHuvkoQ35EZJTgjEVheTSDD0a2uJXGnFpY2xqHf
         mj/lhSNhjKDh3ZrePLDpk8LJLwIIOseJrTSFIeN4EmNd+t/n8s7+i3IeQ7GJpY4sokqw
         PB6WJijUoTP5n2TSzu6POeE+lmggLh1v+WUNWy15ErD8xw2INWMV+4ivMgDAqDtjtccz
         oHWQF9tmpbupP6Sz4JaxAle9LHxr9BoyWFgXF574Ch5P82+YErFfzd4sKCcquLdVYeHq
         KuXQ==
X-Gm-Message-State: AOJu0Ywp1+tGe4Q75Wv/g9JjG2UtqEmQtavn9xEUSnvhUbg1kH8p0C4B
	4gJ3YIZxKxmDVS53KM8TntQvxw==
X-Google-Smtp-Source: AGHT+IGQC4jNTGjKgNptF6KTUMjR7qIHUFbsjdJJO4g8I7yNk34TOtMQLvsfqU/MHY8NVg1lEAFOVw==
X-Received: by 2002:a17:907:78c:b0:9e0:4910:166b with SMTP id xd12-20020a170907078c00b009e04910166bmr1776366ejb.52.1699456124302;
        Wed, 08 Nov 2023 07:08:44 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u19-20020a170906069300b009a168ab6ee2sm1159395ejb.164.2023.11.08.07.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:08:43 -0800 (PST)
Date: Wed, 8 Nov 2023 16:08:42 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	michal.michalik@intel.com, milena.olech@intel.com,
	pabeni@redhat.com, kuba@kernel.org
Subject: Re: [PATCH net 1/3] dpll: fix pin dump crash after module unbind
Message-ID: <ZUukeokxH2NVvmpe@nanopsycho>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108103226.1168500-2-arkadiusz.kubalewski@intel.com>

Wed, Nov 08, 2023 at 11:32:24AM CET, arkadiusz.kubalewski@intel.com wrote:
>Disallow dump of unregistered parent pins, it is possible when parent
>pin and dpll device registerer kernel module instance unbinds, and
>other kernel module instances of the same dpll device have pins
>registered with the parent pin. The user can invoke a pin-dump but as
>the parent was unregistered, thus shall not be accessed by the
>userspace, prevent that by checking if parent pin is still registered.
>
>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/dpll/dpll_netlink.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index a6dc3997bf5c..93fc6c4b8a78 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -328,6 +328,13 @@ dpll_msg_add_pin_parents(struct sk_buff *msg, struct dpll_pin *pin,
> 		void *parent_priv;
> 
> 		ppin = ref->pin;
>+		/*
>+		 * dump parent only if it is registered, thus prevent crash on
>+		 * pin dump called when driver which registered the pin unbinds
>+		 * and different instance registered pin on that parent pin

Read this sentence like 10 times, still don't get what you mean.
Shouldn't comments be easy to understand?


>+		 */
>+		if (!xa_get_mark(&dpll_pin_xa, ppin->id, DPLL_REGISTERED))
>+			continue;
> 		parent_priv = dpll_pin_on_dpll_priv(dpll_ref->dpll, ppin);
> 		ret = ops->state_on_pin_get(pin,
> 					    dpll_pin_on_pin_priv(ppin, pin),
>-- 
>2.38.1
>

