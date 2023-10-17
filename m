Return-Path: <netdev+bounces-41828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B417CBF9A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CAC1C209D2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543F23F4DC;
	Tue, 17 Oct 2023 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="bzqn/uIQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FBC3D96B
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:39:46 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E0EA2
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:39:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so57823015e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535583; x=1698140383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9b1MDtLvKqx9bNjQ/6246B2wK6SMJnM1Kn0KcrlX1s=;
        b=bzqn/uIQ/142w7zikIn6IXvyOtRuq4Cj+u4O2By5sUxgmFfeTahI6utL5FLJl9nxBP
         Z/RkJIuM8CdWMVfqC94PGQ0AUMgw06wX6EezXHRfYmMLRcVn+lsWlzZ82dLuQJ3wVUq0
         bB7/Orobw+x9IZdkmtDWvZiay+DRqVkU/cqZtBcrpOOgkCJyMOOu8DJMwiP0fvYxv5CA
         04HJibq7Rgn6xW0ljoFHrNneya2FkgjImyNpmrKrepxc1AUeEfXeZzzZGySnN1rU8JIa
         bOv7xgu1otr+BcbIrS0S3KoRChH7KOrFwscDTECqCrsPZHVmDE+DwU/qftgBMj8u2mIF
         0S6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535583; x=1698140383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9b1MDtLvKqx9bNjQ/6246B2wK6SMJnM1Kn0KcrlX1s=;
        b=PdYK5cY5TSgNDn2ZgJkYpuVlvDvR9JImhxqrmveiVQk00w8NUpl6CyoeOscc22M+zW
         x3bBpFPkwj8LbFii3oJdVyaankM4cceZ0GHyGuTgWCU+myHaHg22LmTSyRdbuyVLl7jU
         8g949fxQqyXKHGm9kHSOyyJ2RHfsQTlvDq+mY7DBz7MrNI663KF+sthLzMxLybf0z5KU
         D2QxgSLymHboB4hcqwrxVIMCEg3VJRmRB4fNoEkwHHi9Mjf90PvpDsxhRtUYCm4wcU0O
         574klEwpLj35akWGxuZIwTnw2qR5EYtZaFU1NyfCxv39FakexTCYzimrfWFknBOicSSG
         cVnA==
X-Gm-Message-State: AOJu0Ywfedi266ohwvbC0PM5sLpD5oCaKck5rM1TgynZKUCqeSXqkh0s
	DE/X5mSIg/2RwEt2z1FVgsnbzw==
X-Google-Smtp-Source: AGHT+IE8G/EZYBV8c/bxnMG//tD6fsu/nJX/ETrx5aywShCnxwwhi6sJy1uh1L2PpdTLNjyaWmznyA==
X-Received: by 2002:adf:e908:0:b0:31f:f99c:6009 with SMTP id f8-20020adfe908000000b0031ff99c6009mr1542980wrm.22.1697535583479;
        Tue, 17 Oct 2023 02:39:43 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d5686000000b0032d96dd703bsm1271246wrv.70.2023.10.17.02.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:39:42 -0700 (PDT)
Message-ID: <9bea117d-980c-0240-b7f8-eee6429180e8@blackwall.org>
Date: Tue, 17 Oct 2023 12:39:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2-next 7/8] bridge: fdb: support match on
 [no]router flag in flush command
Content-Language: en-US
To: Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, mlxsw@nvidia.com,
 roopa@nvidia.com
References: <20231017070227.3560105-1-amcohen@nvidia.com>
 <20231017070227.3560105-8-amcohen@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231017070227.3560105-8-amcohen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 10:02, Amit Cohen wrote:
> Extend "fdb flush" command to match entries with or without (if "no" is
> prepended) router flag.
> 
> Examples:
> $ bridge fdb flush dev vx10 router
> This will delete all fdb entries pointing to vx10 with router flag.
> 
> $ bridge fdb flush dev vx10 norouter
> This will delete all fdb entries pointing to vx10, except the ones with
> router flag.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> ---
>   bridge/fdb.c      | 8 +++++++-
>   man/man8/bridge.8 | 9 ++++++++-
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



