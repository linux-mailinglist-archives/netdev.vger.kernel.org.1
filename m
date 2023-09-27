Return-Path: <netdev+bounces-36480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9007AFEAD
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 10:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 017CA28436F
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B8F23B7;
	Wed, 27 Sep 2023 08:35:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6895F7E5
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:35:03 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80F3CE0
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 01:35:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so1047985e9.0
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 01:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695803699; x=1696408499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6EzRH8HpBFbjaPAR694gwUNSGbvhoAReDe5zSrIsMYc=;
        b=KmBhERYxNja03evkVTIwrf3H+zWoAIWfShVsFLB8O3LHVpn+QsMnv0ilaAbaZacSfm
         cfUHsIEAIO2FPRJwdjGYkFaqsfGyoMts3bHIsFU48IPwIUTNmU2tseM8qUWU9eY4+kdq
         8V1A690j8lMoSEav6P6nM28+spVIJ1whoUljlkN9HAe1N0afh4hHB3EGvQdkMhSVqMW1
         RjKUhaBkLIAOkkzVP/SMqanPkYp7r/Hlz5o4ZGR/T8Q+LRsI7vaS0S9H9UAOwU6OqZve
         jwa+BUMeazmBHnJ/tHg8OAEaOQ6DDDMpHdKSpxs5xorki9QbCMEm3qgzxyUERVMooD0N
         qy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695803699; x=1696408499;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EzRH8HpBFbjaPAR694gwUNSGbvhoAReDe5zSrIsMYc=;
        b=Wj3SH/IhGvvtbSJ3sxxqiN/q7OaEL9PnFUPRT6xlJIP/ME5v88Bx6zeDT0/koHUv3U
         Fc+j0A9xi9Qa4SQgDwid2r5hf+FTO+FXH3qdmwJJczMKb+fvLCYw+jfq/lOikKjxiE+H
         bhqYqL7F5f/pRb9AKjLTeyS8kfFrZnp/gj6uFkt3b7XN0OyDQcpQh0t6ZoCl++hNyiT/
         j9eXeThhwCcCTd7KV261jG1L6Q4kGrTXeyMuvQH7bW8ytyAylznNATCWeOwKtccdHPSS
         w2ekHc90m4neoM+EdsPwgwkd0Z8vaKvoMx/mCK24s0Wy2fbdlUK6aS7wl2t0r5GAVtEi
         sL2Q==
X-Gm-Message-State: AOJu0YzXu+LgivMxwg+vTGFXdSaozxRYtl+TSjGupfGHBLmRjX9+r/Xt
	NH1ZpxlibB/QkU3RrvrVmja0bQ==
X-Google-Smtp-Source: AGHT+IFuym5R8Qhlx0EFOvWxJLW34MZWMA5h5QfqPC2FB+6Of5cJKCozwBEzMLcTtleEgixAGH9LwQ==
X-Received: by 2002:a05:600c:365a:b0:405:36d7:4579 with SMTP id y26-20020a05600c365a00b0040536d74579mr1220226wmq.28.1695803699132;
        Wed, 27 Sep 2023 01:34:59 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc40c000000b003fc04d13242sm20153631wmi.0.2023.09.27.01.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 01:34:58 -0700 (PDT)
Message-ID: <9ac9b0bf-88e9-5156-a01c-507ae331dd9e@blackwall.org>
Date: Wed, 27 Sep 2023 11:34:57 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] bridge: MTU auto tuning ignores IFLA_MTU on NEWLINK
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Trent Lloyd <trent.lloyd@canonical.com>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230927075713.1253681-1-trent.lloyd@canonical.com>
 <3dccacd8-4249-87f8-690c-6083374dc9d1@blackwall.org>
In-Reply-To: <3dccacd8-4249-87f8-690c-6083374dc9d1@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/27/23 11:10, Nikolay Aleksandrov wrote:
> On 9/27/23 10:57, Trent Lloyd wrote:
>> Commit 804b854d374e ("net: bridge: disable bridge MTU auto tuning if it
>> was set manually") disabled auto-tuning of the bridge MTU when the MTU
>> was explicitly set by the user, however that would only happen when the
>> MTU was set after creation. This commit ensures auto-tuning is also
>> disabled when the MTU is set during bridge creation.
>>
>> Currently when the br_netdev_ops br_change_mtu function is called, the
>> flag BROPT_MTU_SET_BY_USER is set. However this function is only called
>> when the MTU is changed after interface creation and is not called if
>> the MTU is specified during creation with IFLA_MTU (br_dev_newlink).
>>
>> br_change_mtu also does not get called if the MTU is set to the same
>> value it currently has, which makes it difficult to work around this
>> issue (especially for the default MTU of 1500) as you have to first
>> change the MTU to some other value and then back to the desired value.
>>
> 
> Yep, I think I also described this in the commit message of my patch.
> 
>> Add new selftests to ensure the bridge MTU is handled correctly:
>>   - Bridge created with user-specified MTU (1500)
>>   - Bridge created with user-specified MTU (2000)
>>   - Bridge created without user-specified MTU
>>   - Bridge created with user-specified MTU set after creation (2000)
>>
>> Regression risk: Any workload which erroneously specified an MTU during
>> creation but accidentally relied upon auto-tuning to a different value
>> may be broken by this change.
>>
> 
> Hmm, you're right. There's a risk of regression. Also it acts 
> differently when set to 1500 as you've mentioned. I think they should 
> act the same, also bridge's fake rtable RTAX_MTU is not set.
> 

The last part about RTAX_MTU is probably a separate issue. :)

>> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2034099
>> Fixes: 804b854d374e ("net: bridge: disable bridge MTU auto tuning if 
>> it was set manually")
>> Signed-off-by: Trent Lloyd <trent.lloyd@canonical.com>
>> ---
> 


