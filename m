Return-Path: <netdev+bounces-36462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D3A7AFDB8
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 10:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C461A28320C
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 08:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB041D52F;
	Wed, 27 Sep 2023 08:11:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266F1D68A
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:10:56 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282AC1AE
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 01:10:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so10395461f8f.1
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 01:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695802252; x=1696407052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBmOuCvdW9NVL1Xq7Sds9uqW+w+rqXLS8qDFF1herE8=;
        b=wplplTF1qcvKMbJrwn1Up67yl4q8GxN9VnoEY272AHk86WK/sOU4wbRm4Y9FAogAoQ
         eImV/fbNYtpo2HL0K7yxzJyKyTPKeDaTCSCf4AQrkEzFyA2RuPy3u76vQ8fIfB8Z0Iuf
         /t5SQ3aQmPr61OTfAYiTa2RZQOs7+WJf8p+VfuMaIrVh6VglkS7o0pbKgUkjKz7+pjxL
         rmbL/QW49h5uqH2X8F3ooS6BuGhYhXvf/UmJaR0maQ99yYEFX0tM0csmjJkNSY58EKB6
         RIXGd79Xxyp+k+NPsDDPZey3GRYQHx9/IRCUCUc8qxNFdAeh3POlzRgwQtOE9rRu6qYb
         CMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695802252; x=1696407052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBmOuCvdW9NVL1Xq7Sds9uqW+w+rqXLS8qDFF1herE8=;
        b=npUZc7riv6gN8deoRbjHA2YVAm4m+Lfdv51nFj2ZX1hrXeRLkE0PwNOqXZ71J0qwPK
         GsZ9gA9X2sR8WB7HibAbC33SLcTk+XzGFsk+jpwEc007jT9I9aWz3AGvjSJUM/xQzr5l
         OBuOfQCoJfygk0G9/bBJ+tBQzRmIVRxlUPXDXX5zywNbvhCqll7lm/6yB0D6quKfmEoD
         ulxG3N0zcK3bA7OGAhtdgIe/umr/ieEvdrWwHP8it69IrXFWmtVBnEHIMG4Tb1gcGrDK
         sON3eeuMBbp+u6e1NPtM6zC7Ty6f5VEsy4stasqbUeM85MnlkHWrT+g8so6f/6KHlKrV
         FTJQ==
X-Gm-Message-State: AOJu0YwqNMAuZs1G9gKmTxqUiKWRwX9IeLebXw9SOAWQBA6U6C0wI/nk
	UShvlbqH1NsflrDJGIsSV+pe0g==
X-Google-Smtp-Source: AGHT+IEKTsuknU2uuQEZaxLZtK8OwodOqhENja8RJX6uJxZpy29yQQXcdMSM3cppVDtiu8cEn9yLww==
X-Received: by 2002:adf:fe49:0:b0:314:350a:6912 with SMTP id m9-20020adffe49000000b00314350a6912mr1190372wrs.36.1695802252428;
        Wed, 27 Sep 2023 01:10:52 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id m16-20020a056000009000b0031c71693449sm16622619wrx.1.2023.09.27.01.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 01:10:52 -0700 (PDT)
Message-ID: <3dccacd8-4249-87f8-690c-6083374dc9d1@blackwall.org>
Date: Wed, 27 Sep 2023 11:10:50 +0300
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
To: Trent Lloyd <trent.lloyd@canonical.com>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230927075713.1253681-1-trent.lloyd@canonical.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230927075713.1253681-1-trent.lloyd@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/27/23 10:57, Trent Lloyd wrote:
> Commit 804b854d374e ("net: bridge: disable bridge MTU auto tuning if it
> was set manually") disabled auto-tuning of the bridge MTU when the MTU
> was explicitly set by the user, however that would only happen when the
> MTU was set after creation. This commit ensures auto-tuning is also
> disabled when the MTU is set during bridge creation.
> 
> Currently when the br_netdev_ops br_change_mtu function is called, the
> flag BROPT_MTU_SET_BY_USER is set. However this function is only called
> when the MTU is changed after interface creation and is not called if
> the MTU is specified during creation with IFLA_MTU (br_dev_newlink).
> 
> br_change_mtu also does not get called if the MTU is set to the same
> value it currently has, which makes it difficult to work around this
> issue (especially for the default MTU of 1500) as you have to first
> change the MTU to some other value and then back to the desired value.
> 

Yep, I think I also described this in the commit message of my patch.

> Add new selftests to ensure the bridge MTU is handled correctly:
>   - Bridge created with user-specified MTU (1500)
>   - Bridge created with user-specified MTU (2000)
>   - Bridge created without user-specified MTU
>   - Bridge created with user-specified MTU set after creation (2000)
> 
> Regression risk: Any workload which erroneously specified an MTU during
> creation but accidentally relied upon auto-tuning to a different value
> may be broken by this change.
> 

Hmm, you're right. There's a risk of regression. Also it acts 
differently when set to 1500 as you've mentioned. I think they should 
act the same, also bridge's fake rtable RTAX_MTU is not set.

> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2034099
> Fixes: 804b854d374e ("net: bridge: disable bridge MTU auto tuning if it was set manually")
> Signed-off-by: Trent Lloyd <trent.lloyd@canonical.com>
> ---


