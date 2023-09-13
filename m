Return-Path: <netdev+bounces-33534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E930979E69A
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F0A1C2120E
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7371E52E;
	Wed, 13 Sep 2023 11:24:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F801E519
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:24:26 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCFD1BD1
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 04:24:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401da71b85eso72675875e9.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 04:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694604264; x=1695209064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M2/yK96dINX5m6sSN6IIF8fso6AzghokRYKD3HSYW4=;
        b=gcG7+3hp14QcppGEJngfnU4VFbmCo2/r3w4nvnxcDisVJDow5YKm/0TWipA8/y3+H9
         oKGggXqEq80MR06d94hX6GnbekQmzJYCicPceZOebi+cM6PfJdBy46r3OoEocaRsSY5+
         Not3hZyJ0eCK1a4KDpa89VfERWgenUYw3ttmloPS8daCqeT7TlZ4nBcT54oHsgr5l/gC
         jMFDxpGbZblILGA8pgZgFy5dkeAEDpAQsA4DN8U4gdaZGGmnISz4UxWB3jFynM6EAPHO
         RXVPUz4AvHEImO/uZXdmv5ibyycecHFfRATao2AmLyRyCVgpQujLh36DCetgkrnmIaIq
         vuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694604264; x=1695209064;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3M2/yK96dINX5m6sSN6IIF8fso6AzghokRYKD3HSYW4=;
        b=aXva5qBTQseraW6d80gZBj30nWSWSYRSPtUBf7OEeOHY832upAFgjbcQRCZbYit8JG
         +J/RfjRVkObwy5sGA7b+32zQgQQzy1wen7+F701l9L9uaPzXms+JtJbRJzeTkggUcqlG
         CvXNkpH3pUNvfJlSKKWuN3nl2eozsKERexI0Vh78TLl5QpNVseIL8yCjLmSDPUnc1cBw
         ekBYLpfS1p2h1t3lhO3MMl1LcqSzr8oOzXh6H72QGVx/FFh5IxmVoXWD62F1NOAS8JQ9
         Al/12B5B8bt5/uzJ5mcPJvxwEyZUrDcZ6yq5C7iCA/SEwZQ031u3ihV/0MRnoQtrJrOU
         BezA==
X-Gm-Message-State: AOJu0YyyRdx8Tpic1uZEq37wU6G9CUvbBSTJlS0abgME6budCSU/8OXy
	6x8yKl7obc+giG8RGyw4BR4=
X-Google-Smtp-Source: AGHT+IFI5sfk+8O2z+/TFhtcvp04us0ohukTRzqsXWyIB6vyHIzEQH/RaCAgF2e7kMqdD5AQRILNCg==
X-Received: by 2002:a05:600c:21d8:b0:402:f557:2e46 with SMTP id x24-20020a05600c21d800b00402f5572e46mr1928501wmj.1.1694604264149;
        Wed, 13 Sep 2023 04:24:24 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c021800b003fefe70ec9csm1771793wmi.10.2023.09.13.04.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:24:23 -0700 (PDT)
Subject: Re: [RFC PATCH v3 net-next 6/7] net: ethtool: add a mutex protecting
 RSS contexts
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
 jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 saeedm@nvidia.com, leon@kernel.org
References: <cover.1694443665.git.ecree.xilinx@gmail.com>
 <b9bdb464a3fcfcfa7ab01b1cf5e0e312c04752f5.1694443665.git.ecree.xilinx@gmail.com>
 <ZQCUeTrMpmxhlW9C@shell.armlinux.org.uk>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <11bdf0aa-25aa-05b4-e40b-8d108cdc9424@gmail.com>
Date: Wed, 13 Sep 2023 12:24:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZQCUeTrMpmxhlW9C@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 12/09/2023 17:40, Russell King (Oracle) wrote:
> On Tue, Sep 12, 2023 at 03:21:41PM +0100, edward.cree@amd.com wrote:
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index f12767466427..2acb4d8cd4c7 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -10054,6 +10054,7 @@ int register_netdevice(struct net_device *dev)
>>  	idr_init_base(&dev->ethtool->rss_ctx, 1);
>>  
>>  	spin_lock_init(&dev->addr_list_lock);
>> +	mutex_init(&dev->ethtool->rss_lock);
> 
> Is there a reason to split this from the idr (eventually xarray)
> initialisation above? Surely initialisations for a feature (rss)
> should all be grouped together?

No real reason; I just thought "put locks together" made sense, but
 I guess "put rss stuff together" makes more, can change it.

-e

