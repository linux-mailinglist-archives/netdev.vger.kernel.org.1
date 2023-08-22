Return-Path: <netdev+bounces-29582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5FD783E0D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 12:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF77281013
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 10:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752738479;
	Tue, 22 Aug 2023 10:40:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE779C2
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 10:40:50 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE536FB
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:40:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so11087064a12.0
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1692700847; x=1693305647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EtkRY1jmYwwZKGUT6GKi2lYbs/rnolItz7yunjkfTUE=;
        b=vRqJyMPwpBjcl3tf+EYFWQTPiMQZEvD7T6FvKLjABWSOeGSosWuDdjxcvTGKHDmeAt
         Q1oYCxFJBgQBK8pxgazV1n7AlbQ1AP5g3j9REhoJoT2vD0iLM52qYXTZMFj10/vD4MVe
         HY4AQzOMvAjZR/nE8MWjpx72nHJzAxy0Oa2XBOqKRU7XjxmcYfkuHwzUxbv0k/f61RhQ
         r34ZEJnvFi0OwC2hxjTOLj8HiCVdsfe2HHB1xeOzshBeiD7wQRZED/mIGbs6rbHQAMhz
         AHVFSbytRMvaaC45Hr+PGVuLlEPLzd2/7a/9EzHagqYjb3IxPxAMsOn+sIf+pkL9C3V4
         ljBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692700847; x=1693305647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtkRY1jmYwwZKGUT6GKi2lYbs/rnolItz7yunjkfTUE=;
        b=TyrhW1jRiA3E+vGj67xhnRbzeDvfz/Ej9cI6lv5VZC4mdXgk5eO+prjj/WsPj/S2zi
         3f5qcE/1J3UPxrlrB2tvYRgEPgC2z8lNlfT8Lg+0kkF3Ifgs92QcyN5scm7kkqOZCIqk
         55FtjraYv58frRGsyLXXUVshSyJl1ASln5Ef2GmkFRpKG8Ytb38F06l5ms+peBPhnESG
         Z7EQK6/Sl4NNw3zjLvk8CWb9xjTobo9bv7OL0pMvauik40594NzdSLWpQs3xyPt4cGHE
         8PTkR1ow+mTI61K0JVovlKbcI8RYGJ8vt1xKCZAm8NN6wDEptvbEIRimG1jOY+Qh+QQx
         Nezg==
X-Gm-Message-State: AOJu0YxlaaXah/BIoxTRLTs/Caj8BEIcXlCOtZlU8jmOC0seRDayiFRi
	5FEU5SJ/y+S0Hp2SYGh4ee+PMQ==
X-Google-Smtp-Source: AGHT+IGejXQyuL6OmLUot7fp4FTAfapXJLUoNfcjAlSAoXH1hauFGBP5F41yvVrVMpRMtc6ydrKTug==
X-Received: by 2002:a17:907:7da3:b0:982:a022:a540 with SMTP id oz35-20020a1709077da300b00982a022a540mr10182356ejc.11.1692700847182;
        Tue, 22 Aug 2023 03:40:47 -0700 (PDT)
Received: from [192.168.1.2] (handbookness.lineup.volia.net. [93.73.104.44])
        by smtp.gmail.com with ESMTPSA id n12-20020a170906688c00b00982be08a9besm8162023ejr.172.2023.08.22.03.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 03:40:46 -0700 (PDT)
Message-ID: <c81340d8-25f3-4014-b881-5afe01b56f6b@blackwall.org>
Date: Tue, 22 Aug 2023 13:40:45 +0300
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
To: Ziqi Zhao <astrajoan@yahoo.com>
Cc: arnd@arndb.de, bridge@lists.linux-foundation.org, davem@davemloft.net,
 edumazet@google.com, f.fainelli@gmail.com, ivan.orlov0322@gmail.com,
 keescook@chromium.org, kuba@kernel.org, hkallweit1@gmail.com,
 mudongliangabcd@gmail.com, nikolay@nvidia.com, pabeni@redhat.com,
 roopa@nvidia.com, skhan@linuxfoundation.org,
 syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
 vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000051197705fdbc7e54@google.com>
 <20230819081057.330728-1-astrajoan@yahoo.com>
 <df28eac7-ee6e-431c-acee-36a1c29a4ae0@blackwall.org>
 <20230819225048.dxxzv47fo64g24qx@Astras-Ubuntu>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230819225048.dxxzv47fo64g24qx@Astras-Ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/20/23 01:50, Ziqi Zhao wrote:
> On Sat, Aug 19, 2023 at 12:25:15PM +0300, Nikolay Aleksandrov wrote:
> Hi Nik,
> 
> Thank you so much for reviewing the patch and getting back to me!
> 
>> IIRC there was no bug, it was a false-positive. The reference is held a bit
>> longer but then released, so the device is deleted later.
> 
>> If you reproduced it, is the device later removed or is it really stuck?
> 
> I ran the reproducer again without the patch and it seems you are
> correct. It was trying to create a very short-lived bridge, then delete
> it immediately in the next call. The device in question "wpan4" never
> showed up when I polled with `ip link` in the VM, so I'd say it did not
> get stuck.
> 
>> How would it leak a reference, could you elaborate?
>> The reference is always taken and always released after the call.
> 
> This was where I got a bit confused too. The system had a timeout of
> 140 seconds for the unregister_netdevice check. If the bridge in
> question was created and deleted repeatedly, the warning would indeed
> not be an actual reference leak. But how could its reference show up
> after 140 seconds if the bridge's creation and deletion were all within
> a couple of milliseconds?
> 
> So I let the system run for a bit longer with the reproducer, and after
> ~200 seconds, the kernel crashed and complained that some tasks had
> been waiting for too long (more than 143 seconds) trying to get hold of
> the br_ioctl_mutex. This was also quite strange to me, since on the
> surface it definitely looked like a deadlock, but the strict locking
> order as I described previously should prevent any deadlocks from
> happening.
> 
> Anyways, I decided to test switching up the lock order, since both the
> refcnt warning and the task stall seemed closely related to the above
> mentioned locks. When I ran the reproducer again after the patch, both
> the warning and the stall issue went away. So I guess the patch is
> still relevant in preventing bugs in some extreme cases -- although the
> scenario created by the reproducer would probably never happen in real
> usages?
> 

Thank you for testing, but we really need to understand what is going on 
and why the device isn't getting deleted for so long. Currently I don't 
have the time to debug it properly (I'll be able to next week at the 
earliest). We can't apply the patch based only on tests without 
understanding the underlying issue. I'd look into what
the reproducer is doing exactly and also check the system state while 
the deadlock has happened. Also you can list the currently held locks 
(if CONFIG_LOCKDEP is enabled) via magic sysrq + d for example. See 
which process is holding them, what are their priorities and so on.
Try to build some theory of how a deadlock might happen and then go
about proving it. Does the 8021q module have the same problem? It uses
similar code to set its hook.

> Please let me know whether you have any thoughts on how the above
> issues were triggered, and what other information I could gather to
> further demystify this bug. Thank you again for your help!
> 
> Best regards,
> Ziqi


