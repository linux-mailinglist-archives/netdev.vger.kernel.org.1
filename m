Return-Path: <netdev+bounces-61336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E6F823742
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 22:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A122D28794E
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 21:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242921D6BC;
	Wed,  3 Jan 2024 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="3f7b8KLQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5231DA21
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28bcc273833so8906005a91.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 13:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1704318530; x=1704923330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJO/ReneTQmtZaxfoyQCQTUAhMBIeXTA4hnc2FghT+4=;
        b=3f7b8KLQJg7hKDkODbb7hB5N+wlG0akuwiN2ba0dmcg61I/ONvLT4Ffy0n/QSqN4y5
         ucN79qV17SaSx2oxSgctoF6x72oP9wUpPsb2Hyij8SQdCvAgwim4s5vxVrOffVvZqL/S
         hf5uAug8yMpKlde9HjESY67y6XFT4wop6KS5ALG5Zy1fg9DPPq7WuHFUdlCmXVo/ATOH
         lBbKMnIOKLtswC8gnoYU5xi7EnOGpOK889+oNd2WKjIHceUAWxm1uldwB9sSKS2s+Z6L
         Q2fa8mpk/ixPY7coQyHBmnEYt5CmcB5PhbPegXOsAcFRbIkKbF5EJwTLYgQC/U79uFRr
         4BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704318530; x=1704923330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJO/ReneTQmtZaxfoyQCQTUAhMBIeXTA4hnc2FghT+4=;
        b=nMJh1QC9/RbkmtwJ/HPK2GTwVW5Ot26ZOtLksQTPUGTz59J95jX8OHvLwMSEPa0cCD
         Jsn/33rPU24/wu/K7RdTyd1/MPaxMdtxGb0ehwYPQBN1ba3nueu2NtLXZePDNr5jmrz/
         96VsOw5Tt3aPs1ItDzETihMC0baRB2Q9kxgntIqfWVsy96m9SjBqpcR/vimfB90+Axiy
         gv0r5WRrHvJBEEuu06uS2q7I/rW59k6xyQO2DcnCT0SwGpW9lRNCuNQ4N/fqkZvYZl1Q
         o/FVNF6e49GOXE3pY7CPJQV+zQ1Rxo7u7u42fKONlcJBu9gTE26aXabow8coXKDqWJNx
         vJBQ==
X-Gm-Message-State: AOJu0YykywGAUy1XNGWSQy59XJ1iIfd9/HzT2oS77/CWaTPan8xQ5Y9N
	UKAR1eINcGKJ85kLgfy0iITlEs+PzrdzCcFYq68vpca0NnLRTLRh
X-Google-Smtp-Source: AGHT+IEIpJSWByDGJfx9lIYVu2OTwUiljtrgMkaLrQ/9kWA0AiGkov+EEZlC6hS9SpNKcl2hw74N4g==
X-Received: by 2002:a17:90a:c68b:b0:28c:ab21:6a9 with SMTP id n11-20020a17090ac68b00b0028cab2106a9mr5109354pjt.1.1704318529808;
        Wed, 03 Jan 2024 13:48:49 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:a:897:c73b:17c6:3432? ([2620:10d:c090:500::4:9b01])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a134200b0028ae54d988esm2290373pjf.48.2024.01.03.13.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 13:48:49 -0800 (PST)
Message-ID: <5002405d-55ab-4f55-9558-d05e6e54117e@davidwei.uk>
Date: Wed, 3 Jan 2024 13:48:47 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/5] netdevsim: maintain a list of probed
 netdevsims
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231228014633.3256862-1-dw@davidwei.uk>
 <20231228014633.3256862-2-dw@davidwei.uk> <ZZPtsfyHfDyuqfxM@nanopsycho>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZZPtsfyHfDyuqfxM@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-02 03:04, Jiri Pirko wrote:
> Thu, Dec 28, 2023 at 02:46:29AM CET, dw@davidwei.uk wrote:
>> In this patch I added a linked list nsim_dev_list of probed nsim_devs,
>> added during nsim_drv_probe() and removed during nsim_drv_remove(). A
>> mutex nsim_dev_list_lock protects the list.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>> drivers/net/netdevsim/dev.c       | 19 +++++++++++++++++++
>> drivers/net/netdevsim/netdevsim.h |  1 +
>> 2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>> index b4d3b9cde8bd..8d477aa99f94 100644
>> --- a/drivers/net/netdevsim/dev.c
>> +++ b/drivers/net/netdevsim/dev.c
>> @@ -35,6 +35,9 @@
>>
>> #include "netdevsim.h"
>>
>> +static LIST_HEAD(nsim_dev_list);
>> +static DEFINE_MUTEX(nsim_dev_list_lock);
>> +
>> static unsigned int
>> nsim_dev_port_index(enum nsim_dev_port_type type, unsigned int port_index)
>> {
>> @@ -1607,6 +1610,11 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>>
>> 	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_LEGACY;
>> 	devl_unlock(devlink);
>> +
>> +	mutex_lock(&nsim_dev_list_lock);
>> +	list_add(&nsim_dev->list, &nsim_dev_list);
>> +	mutex_unlock(&nsim_dev_list_lock);
>> +
>> 	return 0;
>>
>> err_hwstats_exit:
>> @@ -1668,8 +1676,19 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
>> {
>> 	struct nsim_dev *nsim_dev = dev_get_drvdata(&nsim_bus_dev->dev);
>> 	struct devlink *devlink = priv_to_devlink(nsim_dev);
>> +	struct nsim_dev *pos, *tmp;
>> +
>> +	mutex_lock(&nsim_dev_list_lock);
>> +	list_for_each_entry_safe(pos, tmp, &nsim_dev_list, list) {
>> +		if (pos == nsim_dev) {
>> +			list_del(&nsim_dev->list);
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&nsim_dev_list_lock);
> 
> This is just:
> 	mutex_lock(&nsim_dev_list_lock);
> 	list_del(&nsim_dev->list);
> 	mutex_unlock(&nsim_dev_list_lock);
> 
> The loop is not good for anything.

Thanks, will fix this.

> 
> 
> 
>>
>> 	devl_lock(devlink);
>> +
> 
> Remove this leftover line addition.

Ditto.

> 
> 
>> 	nsim_dev_reload_destroy(nsim_dev);
>>
>> 	nsim_bpf_dev_exit(nsim_dev);
>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>> index 028c825b86db..babb61d7790b 100644
>> --- a/drivers/net/netdevsim/netdevsim.h
>> +++ b/drivers/net/netdevsim/netdevsim.h
>> @@ -277,6 +277,7 @@ struct nsim_vf_config {
>>
>> struct nsim_dev {
>> 	struct nsim_bus_dev *nsim_bus_dev;
>> +	struct list_head list;
>> 	struct nsim_fib_data *fib_data;
>> 	struct nsim_trap_data *trap_data;
>> 	struct dentry *ddir;
>> -- 
>> 2.39.3
>>

