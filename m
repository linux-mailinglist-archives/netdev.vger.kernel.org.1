Return-Path: <netdev+bounces-61460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A229823E22
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 10:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A86CB23710
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66F21EA95;
	Thu,  4 Jan 2024 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjvwFVQ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5D20300
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e3485f0e1so1731985e9.3
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 01:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704359111; x=1704963911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=++LDUtqtcgNqAUbPqsM1/YhDdQdkRk5z9jJzPFJe1Eg=;
        b=MjvwFVQ2s5n6lzyYzGGT/t0qem6+DsFFRGx8AHEDm5eZOMPoNixx9kHbmEs8u0L0w7
         jAOoIb1+zxNrMMMg9g4S9t0/Hsn0YtHz5JBMnw7fca4I17OkzQzw/FEi25M9DVkVMAn2
         eWNUYlfiRknXtqPhx7qKeDWfQnxbKhGGmcXvjUJNBARSNEllnfRCMK11Ij1e6dQHN1ea
         aPri3FdnM89Dv/Yhjc0NBghctVmqK+tYoP7+xcCHnbG1LsCRc2ilzz4boo29EAwpO6bZ
         HEVG9vC+9sbJbI4KTs9aoyBieNK7GiuY7MqHEFdBiDoultmUmFKRg6cyHf+TsHAhgdEk
         K7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704359111; x=1704963911;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++LDUtqtcgNqAUbPqsM1/YhDdQdkRk5z9jJzPFJe1Eg=;
        b=FjkvkkfiI/32BvNZO6vQqt2YjMoh3e02+AJl+Z1qS4wqXmzPAIJnbM96YIgMGiQup3
         oKRc8HMaORcXNJgaHsXpamJE3/VmwsS6SLuufh1mOd4hL5E/ZScGbmqPzhfSMWAMw3Kn
         ss3fCK/j3cmRX8YHAPDHWBXO6M8rAqYWzfBojINXmWltaGYYhLnwSXWEmZL6sIHP+WxE
         LDL9mGwn5ntEgVMAXOr5Ettdo2zm5xQxRNEu+2RmzDIzHqRpkPZhR7pwnUusJhdDbEpq
         aPufZ40CUFSibWCLj6zXTAHS64IjPOLaReXzScMFiDG24iMFpmcCo7XWv7WGQnEmyXb0
         zYXA==
X-Gm-Message-State: AOJu0YymQhkfZwNfPs3FCP7tw+ae4hDN2hkZX0yX3SRAY35EqAGE2sSu
	nos5q81brun0NHJP/K/cjok=
X-Google-Smtp-Source: AGHT+IGwYBcvgqIuEe4uBR/prAP59zmGIzrSNAqXtRF4FkZkhR/LlRHimqnVyZhuIZV162KRdWbN4w==
X-Received: by 2002:a05:600c:3481:b0:40d:8bc6:b153 with SMTP id a1-20020a05600c348100b0040d8bc6b153mr171006wmq.110.1704359110931;
        Thu, 04 Jan 2024 01:05:10 -0800 (PST)
Received: from ?IPV6:2a01:c22:6ffe:b000:fccf:dfd2:e760:65c? (dynamic-2a01-0c22-6ffe-b000-fccf-dfd2-e760-065c.c22.pool.telefonica.de. [2a01:c22:6ffe:b000:fccf:dfd2:e760:65c])
        by smtp.googlemail.com with ESMTPSA id l35-20020a05600c1d2300b0040d5e53d7c3sm5020331wms.23.2024.01.04.01.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 01:05:10 -0800 (PST)
Message-ID: <9bcfb259-1249-4efc-b581-056fb0a1c144@gmail.com>
Date: Thu, 4 Jan 2024 10:05:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>, Marc MERLIN <marc@merlins.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231206084448.53b48c49@kernel.org> <ZZU3OaybyLfrAa/0@linux.intel.com>
 <20240103153405.6b19492a@kernel.org> <ZZZrbUPUCTtDcUFU@linux.intel.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ZZZrbUPUCTtDcUFU@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04.01.2024 09:25, Stanislaw Gruszka wrote:
> On Wed, Jan 03, 2024 at 03:34:05PM -0800, Jakub Kicinski wrote:
>> On Wed, 3 Jan 2024 11:30:17 +0100 Stanislaw Gruszka wrote:
>>>> I was really, really hoping that this would serve as a motivation
>>>> for Intel to sort out the igb/igc implementation. The flow AFAICT
>>>> is ndo_open() starts the NIC, the calls pm_sus, which shuts the NIC
>>>> back down immediately (!?) then it schedules a link check from a work  
>>>
>>> It's not like that. pm_runtime_put() in igc_open() does not disable device.
>>> It calls runtime_idle callback which check if there is link and if is
>>> not, schedule device suspend in 5 second, otherwise device stays running.
>>
>> Hm, I missed the 5 sec delay there. Next question for me is - how does
>> it not deadlock in the open?
>>
>> igc_open()
>>   __igc_open(resuming=false)
>>     if (!resuming)
>>       pm_runtime_get_sync(&pdev->dev);
>>
>> igc_resume()
>>   rtnl_lock()
> 
> If device was not suspended, pm_runtime_get_sync() will increase
> dev->power.usage_count counter and cancel pending rpm suspend
> request if any. There is race condition though, more about that
> below.
> 
> If device was suspended, we could not get to igc_open() since it
> was marked as detached and fail netif_device_present() check in
> __dev_open(). That was the behaviour before bd869245a3dc.
> 
> There is small race window between with igc_open() and scheduled
> runtime suspend, if at the same time dev_open() is done and
> dev->power.suspend_timer expire:
> 
> open:					pm_suspend_timer_fh:
> 
> rtnl_lock()
> 					rpm_suspend()
> 					  igc_runtime_suspend()
> 					   __igc_shutdown()
> 					     rtnl_lock()
> 
> __igc_open()
>   pm_runtime_get_sync():
>     waits for rpm suspend callback done
> 
> This needs to be addressed, but it's not that this can happen
> all the time. To trigger this someone has to remove the
> cable and exactly after 5 seconds do ip link set up. 
> 
For me the main question is the following. In igc_resume() you have

	rtnl_lock();
	if (!err && netif_running(netdev))
		err = __igc_open(netdev, true);

	if (!err)
		netif_device_attach(netdev);
	rtnl_unlock();

Why is the global rtnl_lock() needed here? The netdev is in detached
state what protects from e.g. userspace activity, see all the
netif_device_present() checks in net core.

> Regards
> Stanislaw


