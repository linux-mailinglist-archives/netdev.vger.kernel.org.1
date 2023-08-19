Return-Path: <netdev+bounces-29066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514587818D5
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 12:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDCE1C2095F
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E56F4429;
	Sat, 19 Aug 2023 10:39:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316011C17
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 10:39:53 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F87626081
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:25:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso2149358a12.3
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1692437117; x=1693041917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qp+p88acw4RYdUK5z2c5JXRcScXCLt4N2yRM056qyZI=;
        b=VRR5HDmZ87vfAsOdbfbSMy3DH2tEGsp2n37sFPGHgHf6WJE6uIG4yAWcDCPiimPf9Y
         g5xXFg7TPYdKcb5jl7DplAamSO61UWaTu/PSgQ4Oc2VdSKqhz5y2imgL1SGTUGce7DhW
         YkIld5h6JkxGQ4xBy1o2SvHqcy982wGk0ZNtngsGuIVTuMB1IhHThiyKJ8YI4Fw7NuxC
         fPhsJzKOHsmaIq+vUlkq7v+ZjfFG+h3uvMucYasHduWlSim2hBKkjMQ96TYQvhUFxhvK
         8TzlZGlFBzKsohUfKrApwHBiQoo7Mh+s9wU2IPUg9P5FV8yqsBs/mPXujg2UV4whPYLv
         PgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692437117; x=1693041917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qp+p88acw4RYdUK5z2c5JXRcScXCLt4N2yRM056qyZI=;
        b=U1FOh+fZoSeOg2YN82IVt1rEdJsc/glxkVrLi3fMdpHG41QDN0+ou6FxXPohbSPiDz
         /Ca4DlMZ9LFaMzJCqnmWLFnncw7AGbyLt33xUWDqCDoAQzZtFqFxFiIvnd9LWiwUUhk/
         8E9lWwQ4+BnASCxnZ2aUewtrSxhF5I2jbccRdua9u2zZxmqnYL4G4AymJF8n9OMd+zvw
         Tv7TAulAQaYRXk0rQTnd4MjP0plANEr8QpSz51xiUNcGa/+SzqTFpu4Ylzyo3epc6dI/
         xZ8qcXx08ZQZ923jnPd5rcefzKQz6kQ1AvT1o9AkZSv1eE9JVnAD9wrpCr3VhBTK1/2A
         /HSQ==
X-Gm-Message-State: AOJu0Yz5LX1EdOiYjY80RrcV3FUZ2qBUj/lPZe+t7+dhBvuLC7Q6M6li
	/CfmcwBKRVjlCG7W+rqqMm2hZQ==
X-Google-Smtp-Source: AGHT+IEXf4Cdoa+8NauX37PHYq+yLXIhUdj4BWAkAzLxSuxit4Crlmzvd6GPituu3hkr9P+D2ExGow==
X-Received: by 2002:aa7:db4a:0:b0:525:501d:9bd3 with SMTP id n10-20020aa7db4a000000b00525501d9bd3mr992991edt.32.1692437117544;
        Sat, 19 Aug 2023 02:25:17 -0700 (PDT)
Received: from [192.168.1.2] (handbookness.lineup.volia.net. [93.73.104.44])
        by smtp.gmail.com with ESMTPSA id w9-20020a056402070900b00525683f9b2fsm2214842edx.5.2023.08.19.02.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 02:25:17 -0700 (PDT)
Message-ID: <df28eac7-ee6e-431c-acee-36a1c29a4ae0@blackwall.org>
Date: Sat, 19 Aug 2023 12:25:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] net: bridge: Fix refcnt issues in dev_ioctl
Content-Language: en-US
To: Ziqi Zhao <astrajoan@yahoo.com>, arnd@arndb.de,
 bridge@lists.linux-foundation.org, davem@davemloft.net, edumazet@google.com,
 f.fainelli@gmail.com, ivan.orlov0322@gmail.com, keescook@chromium.org,
 kuba@kernel.org, hkallweit1@gmail.com, mudongliangabcd@gmail.com,
 nikolay@nvidia.com, pabeni@redhat.com, roopa@nvidia.com,
 skhan@linuxfoundation.org,
 syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
 vladimir.oltean@nxp.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <00000000000051197705fdbc7e54@google.com>
 <20230819081057.330728-1-astrajoan@yahoo.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230819081057.330728-1-astrajoan@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ziqi,
On 8/19/23 11:10, Ziqi Zhao wrote:
> In the bug reported by Syzbot, certain bridge devices would have a
> leaked reference created by race conditions in dev_ioctl, specifically,
> under SIOCBRADDIF or SIOCBRDELIF operations. The reference leak would

How would it leak a reference, could you elaborate?
The reference is always taken and always released after the call.

> be shown in the periodic unregister_netdevice call, which throws a
> warning and cause Syzbot to report a crash. Upon inspection of the

If you reproduced it, is the device later removed or is it really stuck?

> logic in dev_ioctl, it seems the reference was introduced to ensure
> proper access to the bridge device after rtnl_unlock. and the latter
> function is necessary to maintain the following lock order in any
> bridge related ioctl calls:
> 
> 1) br_ioctl_mutex => 2) rtnl_lock
> 
> Conceptually, though, br_ioctl_mutex could be considered more specific
> than rtnl_lock given their usages, hence swapping their order would be
> a reasonable proposal. This patch changes all related call sites to
> maintain the reversed order of the two locks:
> 
> 1) rtnl_lock => 2) br_ioctl_mutex
> 
> By doing so, the extra reference introduced in dev_ioctl is no longer
> needed, and hence the reference leak bug is now resolved.

IIRC there was no bug, it was a false-positive. The reference is held a 
bit longer but then released, so the device is deleted later.
I might be remembering wrong, but I think I briefly looked into this 
when it was reported. If that's not the case I'd be interested to see
a new report/trace because the bug might be somewhere else.

> 
> Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
> Fixes: ad2f99aedf8f ("net: bridge: move bridge ioctls out of .ndo_do_ioctl")
> Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
> ---
>   net/bridge/br_ioctl.c | 4 ----
>   net/core/dev_ioctl.c  | 8 +-------
>   net/socket.c          | 2 ++
>   3 files changed, 3 insertions(+), 11 deletions(-)
> 

Thanks,
  Nik



