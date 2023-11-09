Return-Path: <netdev+bounces-46858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C197E6B1C
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 14:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62431C2086F
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88AE1C3B;
	Thu,  9 Nov 2023 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JFXZpVGS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388E11DA28
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 13:18:13 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F43258D
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 05:18:12 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso135389666b.0
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 05:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699535891; x=1700140691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vmhxi/YrdKvVK3w77/agFLvc4grfIsJeBk3pTwDwSeY=;
        b=JFXZpVGSrSHJD2uKpk++F97+CaNplRQNH124S+zt+64PqOOv3B1VY/FWiHp1QljEkM
         uktj6AhL00xm4Oif20JDnb4w4CpJNhlH67OnJNAOy+Fws1fgkLzj5a3MfaG5W2k+QAzD
         Ua0IM3y3hSmQTFvz08cMdRTtFXqLVa8a3apU0q7gMWAlACCS7fZA1OfHfNZIepMfYXqs
         k+IknYCOcRdjKj3hFaEg0Mcqp58mei+4AWy7fOGze7yTW1BlEhnj8coKaXK+R8X1DY0h
         0D1Zd6t/+pvCS7NDxpsq2faL9VKgJt5uY0TyZtNM4T5hjUxO6jNWlIYlRFacM3AMP6Ev
         Z6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699535891; x=1700140691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmhxi/YrdKvVK3w77/agFLvc4grfIsJeBk3pTwDwSeY=;
        b=LB2RXjAr14JCIBtcxAnoMxk3tHNoE1DKQdr4DHy7dGZL3ZEn75g1KzxqcyQx20LNn4
         RfFjfhzB8ATU36sUdVFLrxdQgDYVpITkVIjUSQx8Frq6+L8p1wd+HW7VoU9ZGfSIJyZ1
         n2RYiU2PJZeatA250V0SFqv3DoA0qqOutTTecxVkwOdt9DGnmKcNWA4HXcROx3UgSQ5M
         Hp4IbglER2kr8n/Sn9TMleTI9yU5SBGujy0WDwjXuyC0eC7COERYsy0mJOPEHQe9pMn2
         Yp8TKjJpgL/bI/DwNvs0asu6z9eeYwXvEhvALji3eOwkcOjiXrxrAwmes/rp57jzHtlb
         d2Zw==
X-Gm-Message-State: AOJu0YwJe0nc1qagM8iJb55UumimhSkQ46N7ajOrp+BmOZmTF6akj3BV
	DjIcNBYZT8lDtTcXQkSnSsjFzw==
X-Google-Smtp-Source: AGHT+IG4rpnnxbbYH8NodLxQ5kRS9kthccGaiWe9uzpKmX9IK9Z+wASlx885DOE10vKw6222NKTDKA==
X-Received: by 2002:a17:906:4fcc:b0:9ba:65e:7529 with SMTP id i12-20020a1709064fcc00b009ba065e7529mr4598001ejw.68.1699535890906;
        Thu, 09 Nov 2023 05:18:10 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id a17-20020a170906685100b009aa292a2df2sm2532785ejs.217.2023.11.09.05.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:18:10 -0800 (PST)
Date: Thu, 9 Nov 2023 14:18:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net 1/3] dpll: fix pin dump crash after module unbind
Message-ID: <ZUzcEdhmnBVdXsBD@nanopsycho>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-2-arkadiusz.kubalewski@intel.com>
 <ZUukeokxH2NVvmpe@nanopsycho>
 <DM6PR11MB46576110B45D806064F437C49BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46576110B45D806064F437C49BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>

Thu, Nov 09, 2023 at 10:49:49AM CET, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Wednesday, November 8, 2023 4:09 PM
>>
>>Wed, Nov 08, 2023 at 11:32:24AM CET, arkadiusz.kubalewski@intel.com wrote:
>>>Disallow dump of unregistered parent pins, it is possible when parent
>>>pin and dpll device registerer kernel module instance unbinds, and
>>>other kernel module instances of the same dpll device have pins
>>>registered with the parent pin. The user can invoke a pin-dump but as
>>>the parent was unregistered, thus shall not be accessed by the
>>>userspace, prevent that by checking if parent pin is still registered.
>>>
>>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>---
>>> drivers/dpll/dpll_netlink.c | 7 +++++++
>>> 1 file changed, 7 insertions(+)
>>>
>>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>>index a6dc3997bf5c..93fc6c4b8a78 100644
>>>--- a/drivers/dpll/dpll_netlink.c
>>>+++ b/drivers/dpll/dpll_netlink.c
>>>@@ -328,6 +328,13 @@ dpll_msg_add_pin_parents(struct sk_buff *msg, struct
>>dpll_pin *pin,
>>> 		void *parent_priv;
>>>
>>> 		ppin = ref->pin;
>>>+		/*
>>>+		 * dump parent only if it is registered, thus prevent crash on
>>>+		 * pin dump called when driver which registered the pin unbinds
>>>+		 * and different instance registered pin on that parent pin
>>
>>Read this sentence like 10 times, still don't get what you mean.
>>Shouldn't comments be easy to understand?
>>
>
>Hi,
>
>Hmm, wondering isn't it better to remove this comment at all?
>If you think it is needed I will rephrase it somehow..

I don't know if it is needed as I don't understand it :)
Just remove it.


>
>Thank you!
>Arkadiusz
>
>>
>>>+		 */
>>>+		if (!xa_get_mark(&dpll_pin_xa, ppin->id, DPLL_REGISTERED))
>>>+			continue;
>>> 		parent_priv = dpll_pin_on_dpll_priv(dpll_ref->dpll, ppin);
>>> 		ret = ops->state_on_pin_get(pin,
>>> 					    dpll_pin_on_pin_priv(ppin, pin),
>>>--
>>>2.38.1
>>>
>

