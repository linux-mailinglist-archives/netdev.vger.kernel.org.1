Return-Path: <netdev+bounces-35212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2E17A79F2
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DBC1C20AD3
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A029A15ACC;
	Wed, 20 Sep 2023 11:01:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009A15AF0
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 11:01:15 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AE1DC
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 04:01:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52c4d3ff424so8393264a12.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695207672; x=1695812472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFCnzCVFLsbuhvtZ9EHw9SNjPT4ld8559k/OSp8m+oI=;
        b=0znRomiutZ2eIGc65iJ/S7ilbpslzEmVEOOVmqie/ulpkTpD0kFFdccUKxRqJL4+rt
         LXxHLipcu0e5avdRoEAkO/2pU7tZt1N9CpYQwpj6CzSO9peXSehnNNrNovnT/yapd3tu
         7DAPbecOOwVyZWkKMoGXvc5+WQDUls9Q0AsV51/MALOvqp0CH2jqa28xWb/aXGjM5ZvF
         cTWnUBfv7+CdLZ/aADHKKE3z2z7R9swELk8P4bEPaEY7TXMie/gIVPFAdQOt7QCkgGpK
         n8HsqASiz7S2caHNhmVjX4IjkDFviRLf3b30onCvrubo6wQTR7Ku2Y+PLlTKUW7NJkMI
         ZUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695207672; x=1695812472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFCnzCVFLsbuhvtZ9EHw9SNjPT4ld8559k/OSp8m+oI=;
        b=iCiYO40Bzinv7cz31JMxcfdDSVoLH3xBk0Kfvwgd21vOUW/hIZd7lIsdTsOqeSdoG6
         Uop9G7VPQOytJxmQnCMCs1C0s4F8dlAcBwXn58lbONrShlIA1f9X4eMIKkShenQF94T+
         +urHejv0ihVcpUgO/UzxExLvZYQtXplBGj8q14S2od0R1yuIIOjMzkCn36bz7ywlXKkJ
         IKrISkm6tnynozADwtQBEbVnL6ajJzu2A+PXXTwYJAFAFOhiA+neFAa2IavwlXRQd1S/
         kxegZlxDQnr/z/UahgQmuRP+AZMazu0zxUv+4/eqtTIRNXF/kSZdpsobyw5/hEkh+vXY
         vXEQ==
X-Gm-Message-State: AOJu0YzNdcvEyiGXC9Vewh6w5TES3qOfJkrhq6fNW1XJVg/z4dSvT+Li
	koUfkh8GF/Rv+F1qmGUOCwAbfg==
X-Google-Smtp-Source: AGHT+IG3UkUHhXRFKHx1etLPK3jZZNjDhVAwE4UIfgjnZzVOtLR39Gca5U0GPsI8uvAEiDai68jh1Q==
X-Received: by 2002:a17:907:a087:b0:9aa:186:959a with SMTP id hu7-20020a170907a08700b009aa0186959amr1644862ejc.31.1695207672595;
        Wed, 20 Sep 2023 04:01:12 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id o2-20020a1709062e8200b009ad8338aafasm9320070eji.13.2023.09.20.04.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 04:01:12 -0700 (PDT)
Message-ID: <e1c0f5ac-a0bc-dc2c-0638-c580498670e4@blackwall.org>
Date: Wed, 20 Sep 2023 14:01:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 6/6] selftests: forwarding:
 bridge_fdb_learning_limit: Add a new selftest
Content-Language: en-US
To: Johannes Nixdorf <jnixdorf-oss@avm.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>,
 Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-6-39f0293807b8@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-6-39f0293807b8@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/19/23 11:12, Johannes Nixdorf wrote:
> Add a suite covering the fdb_n_learned and fdb_max_learned bridge
> features, touching all special cases in accounting at least once.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   tools/testing/selftests/net/forwarding/Makefile    |   3 +-
>   .../net/forwarding/bridge_fdb_learning_limit.sh    | 283 +++++++++++++++++++++
>   2 files changed, 285 insertions(+), 1 deletion(-)
> 

Always nice to see new tests. Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



