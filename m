Return-Path: <netdev+bounces-59828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1813881C270
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 01:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90DD282E82
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 00:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D639B;
	Fri, 22 Dec 2023 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="LSNioXbk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A271A1361
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-203fb334415so767188fac.2
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 16:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703206176; x=1703810976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KztYCLSHX2cUkReOoydzBk2HLho2b0EL2eVABLYNEww=;
        b=LSNioXbkuXznMxGLDkRtt0PFtnAsoQ88NWoTWTMdEMfSDIoVhcrTS1ygzV4o1oKBn/
         vWpK2w2RLn3EcIzErvaBsImEuSwaUwXISXRyjEHPeW5ZfMqgHiYgArH9G1TWo2mh+Yj/
         GW9EXkCGlg2/vOs5ElOUdkhxeRva/hkZNiRyaMYqc0gG49wZwnbp6QeoqYojLy+lJYrf
         2+ExdBSuVOQEVSSm4k9YbCF7q99Atxk1ImKcrW1nFLTSqPsyfCtagaJae0IrWkDjwU0l
         gVUUf71nboWVR/XlThWOcIWpVHqH53japdHAdj6vQTSLyG76HfCP2NZz3XmwYaMk8vZj
         UpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703206176; x=1703810976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KztYCLSHX2cUkReOoydzBk2HLho2b0EL2eVABLYNEww=;
        b=M4u0OKlh7n5lKObhthjLEG2cYyal0Y/83Z8/5QBZ7UmDgi/ofwO02xOlQ5W/LYyTOt
         ymDHXrMYfUm4GGSSZtNmcWMO5vuHuVLm3K2OlovZol0mA24+gymSAB6yRGwJv3kafycx
         6rtaA80zGqO2X9c2FhKfPT0a2MixSeN5BMQV1is6PkX9AoSg86AClRfv4m55BdvUM7Sy
         4cPMFoxzZ6hbfzcc6ZZOIednvIMcQ5mWkKfrReXK4UFLDnOhGIekySRCprnpLA7ajErP
         59r1mWSEvF+7vLvU9tDUwXaahTIdCivjmIx3HeV9TprGg6qjAXaaD2r/5jAySSLghYF1
         UE6w==
X-Gm-Message-State: AOJu0Yzue1e4/tEY5pro7X9CDF7Cod4nSNDXnN2BEvqmStomUaZruob+
	VeWYFobLlIW/GBM8aZtPgotYvciVZpTxbS98lPo8JZnDL+SIVg==
X-Google-Smtp-Source: AGHT+IH8z86yi+xsPjQuPtGJoEaS/TLp4HJqk6HmOy7U5Z05JVxKLuY6U7KkXg4xZQSmwvcXai59iA==
X-Received: by 2002:a05:6870:cc8b:b0:1fb:d30:c160 with SMTP id ot11-20020a056870cc8b00b001fb0d30c160mr870915oab.3.1703206176621;
        Thu, 21 Dec 2023 16:49:36 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c1::14f8? ([2620:10d:c090:400::4:865e])
        by smtp.gmail.com with ESMTPSA id 9-20020a056a00072900b006ce7e75cfa7sm2165026pfm.57.2023.12.21.16.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 16:49:36 -0800 (PST)
Message-ID: <2fa47ece-a8ee-4b16-93f7-801927b9b199@davidwei.uk>
Date: Thu, 21 Dec 2023 16:49:35 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/5] netdevsim: maintain a list of probed
 netdevsims
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20231220014747.1508581-1-dw@davidwei.uk>
 <20231220014747.1508581-2-dw@davidwei.uk>
 <20231220164050.GN882741@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20231220164050.GN882741@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-20 08:40, Simon Horman wrote:
> On Tue, Dec 19, 2023 at 05:47:43PM -0800, David Wei wrote:
>> This patch adds a linked list nsim_dev_list of probed netdevsims, added
>> during nsim_drv_probe() and removed during nsim_drv_remove(). A mutex
>> nsim_dev_list_lock protects the list.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  drivers/net/netdevsim/dev.c       | 17 +++++++++++++++++
>>  drivers/net/netdevsim/netdevsim.h |  1 +
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>> index b4d3b9cde8bd..e30a12130e07 100644
>> --- a/drivers/net/netdevsim/dev.c
>> +++ b/drivers/net/netdevsim/dev.c
>> @@ -35,6 +35,9 @@
>>  
>>  #include "netdevsim.h"
>>  
>> +static LIST_HEAD(nsim_dev_list);
>> +static DEFINE_MUTEX(nsim_dev_list_lock);
>> +
>>  static unsigned int
>>  nsim_dev_port_index(enum nsim_dev_port_type type, unsigned int port_index)
>>  {
>> @@ -1531,6 +1534,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>>  				 nsim_bus_dev->initial_net, &nsim_bus_dev->dev);
>>  	if (!devlink)
>>  		return -ENOMEM;
>> +	mutex_lock(&nsim_dev_list_lock);
>>  	devl_lock(devlink);
>>  	nsim_dev = devlink_priv(devlink);
>>  	nsim_dev->nsim_bus_dev = nsim_bus_dev;
>> @@ -1544,6 +1548,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>>  	spin_lock_init(&nsim_dev->fa_cookie_lock);
>>  
>>  	dev_set_drvdata(&nsim_bus_dev->dev, nsim_dev);
>> +	list_add(&nsim_dev->list, &nsim_dev_list);
>>  
>>  	nsim_dev->vfconfigs = kcalloc(nsim_bus_dev->max_vfs,
>>  				      sizeof(struct nsim_vf_config),
>> @@ -1607,6 +1612,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>>  
>>  	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_LEGACY;
>>  	devl_unlock(devlink);
>> +	mutex_unlock(&nsim_dev_list_lock);
>>  	return 0;
>>  
> 
> Hi David,
> 
> I see Jiri has asked about the scope and type of this lock.
> And updates to address those questions may obviate my observation.
> But it is that mutex_unlock(&nsim_dev_list_lock); needs to
> be added to the unwind ladder:
> 
> 	...
> err_devlink_unlock:
> 	devl_unlock(devlink);
> 	mutex_unlock(&nsim_dev_list_lock);
> 	...
> 
> ...
> 
> Flagged by Smatch.

Hi Simon, thanks for flagging this and I will address it in the next
version.


