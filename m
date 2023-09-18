Return-Path: <netdev+bounces-34446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAB87A435C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E972822F1
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 07:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8430711CBD;
	Mon, 18 Sep 2023 07:44:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07982111A1
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 07:44:42 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18A7E52
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 00:42:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c43fe0c0bfso14352615ad.1
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 00:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695022937; x=1695627737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hKYocey+6ljIdptxAs95A1TcTySiYPe7OwqA1YhMFY=;
        b=BDqSGsT25ItUdjTt34+3ft/4qI5KIRlObVaX5umIPgAnbXgd9gaDjXR9bEciat060F
         sWRd9QPcXFrLGTE8TQClSuFpXob6mKf7JG/oPoCPRaEm+xSynngPe5/8Wbk0KrYlXJ8s
         sgTPEhIBW1FG9G4vA/SBGhYTbnLpL2QsTWp/3I490DmYeurUVQj45E7dyCYm/DV6kChS
         GmuMZSID0wSIeVpmv9Pcaahc5NHfTwpLiqgAINj05AgVafTslWPnfl/I9Es14qGfYXf3
         oAT1YCYZ/8+qSe6Ube/e9EAfTUgpjox9vPsbZUdzugXZ76c/ccCebqNZ44wfLlPnPpds
         98qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695022937; x=1695627737;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0hKYocey+6ljIdptxAs95A1TcTySiYPe7OwqA1YhMFY=;
        b=FjvYW79p8u2y/Ps2N0ny0tO3+36PWAsIpB31mcHOSlvrg/YUKpHiIck+7tSO0JAe/4
         En6y9k4WfjvE+icaeWKdFLCRpACAcG7gelEVddxy9SscQ/qcJJFvChkDeV3jJp6nD/8E
         m30icvm4/fB4yWx8B0YLw1x6TdPFuhzOfe5gKVe6NZ4ynuEbhOoC1i8UVq0heMbTs7B/
         X4DdnZ3MKZqzl/4lczBPJBRCOG4YoYifzHZkhsbFoAIxCYphyY2nhiWUBC+1qy27dng0
         x6g1DAa1LSDsJW5KuwK9GRM2YszMF9WKp/Lseof0PxKMzVfkvy9Q0c5t4jvZ64eakaHh
         vm+w==
X-Gm-Message-State: AOJu0Yzw7AiJ9MtymMiKFrp+eOqjakuWRSs5ktnznc8G/D48BuGznAM+
	Rq58dWLIBKmW6aFrpXTnPJQ=
X-Google-Smtp-Source: AGHT+IGqGLOZW5vuMg2uPwuo6Z3az0TlDRq/bV1XLo1Nwy0G1f41+NY4ytKtebYGcoTSPQ35V1Pd7w==
X-Received: by 2002:a17:902:c106:b0:1c3:b3c7:d67f with SMTP id 6-20020a170902c10600b001c3b3c7d67fmr6861840pli.47.1695022937246;
        Mon, 18 Sep 2023 00:42:17 -0700 (PDT)
Received: from [192.168.123.100] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902bd9500b001c1f016015esm7694707pls.84.2023.09.18.00.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 00:42:16 -0700 (PDT)
Message-ID: <9ac76b6a-d490-f633-ba90-f0851f5a3b6f@gmail.com>
Date: Mon, 18 Sep 2023 16:42:12 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net v2] net: team: get rid of team->lock in team module
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org,
 syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com,
 syzbot+1c71587a1a09de7fbde3@syzkaller.appspotmail.com
References: <20230916131115.488756-1-ap420073@gmail.com>
 <ZQXcOmtm1l36nUwV@nanopsycho>
 <a8aac295-6021-f13b-fd26-311462d0a930@gmail.com>
 <ZQf5/f7jFvvCJBSw@nanopsycho>
From: Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <ZQf5/f7jFvvCJBSw@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023. 9. 18. 오후 4:19, Jiri Pirko wrote:
 > Mon, Sep 18, 2023 at 03:16:26AM CEST, ap420073@gmail.com wrote:
 >>
 >>
 >> On 2023. 9. 17. 오전 1:47, Jiri Pirko wrote:
 >>
 >> Hi Jiri,
 >> Thank you so much for your review!
 >>
 >>> Sat, Sep 16, 2023 at 03:11:15PM CEST, ap420073@gmail.com wrote:
 >>>> The purpose of team->lock is to protect the private data of the team
 >>>> interface. But RTNL already protects it all well.
 >>>> The precise purpose of the team->lock is to reduce contention of
 >>>> RTNL due to GENL operations such as getting the team port list, and
 >>>> configuration dump.
 >>>>
 >>>> team interface has used a dynamic lockdep key to avoid false-positive
 >>>> lockdep deadlock detection. Virtual interfaces such as team usually
 >>>> have their own lock for protecting private data.
 >>>> These interfaces can be nested.
 >>>> team0
 >>>>    |
 >>>> team1
 >>>>
 >>>> Each interface's lock is actually different(team0->lock and 
team1->lock).
 >>>> So,
 >>>> mutex_lock(&team0->lock);
 >>>> mutex_lock(&team1->lock);
 >>>> mutex_unlock(&team1->lock);
 >>>> mutex_unlock(&team0->lock);
 >>>> The above case is absolutely safe. But lockdep warns about deadlock.
 >>>> Because the lockdep understands these two locks are same. This is a
 >>>> false-positive lockdep warning.
 >>>>
 >>>> So, in order to avoid this problem, the team interfaces started to use
 >>>> dynamic lockdep key. The false-positive problem was fixed, but it
 >>>> introduced a new problem.
 >>>>
 >>>> When the new team virtual interface is created, it registers a dynamic
 >>>> lockdep key(creates dynamic lockdep key) and uses it. But there is the
 >>>> limitation of the number of lockdep keys.
 >>>> So, If so many team interfaces are created, it consumes all 
lockdep keys.
 >>>> Then, the lockdep stops to work and warns about it.
 >>>
 >>> What about fixing the lockdep instead? I bet this is not the only
 >>> occurence of this problem.
 >>
 >> There were many similar patches for fixing lockdep false-positive 
problem.
 >> But, I didn't consider fixing lockdep because I thought the 
limitation of
 >> lockdep key was normal.
 >> So, I still think stopping working due to exceeding lockdep keys is 
not a
 >> problem of the lockdep itself.
 >
 > Lockdep is a diagnostic tool. The fact the tool is not working properly
 > does not mean we need to change the code the tool is working with. Fix
 > the tool.

I agree with you.
Fixing the lockdep side looks more correct way.
I will dig some way to fix this problem on the lockdep side.

Thank you so much!
Taehee Yoo

 >
 >
 >>
 >>>
 >>>
 >>>>
 >>>> So, in order to fix this issue, It just removes team->lock and uses
 >>>> RTNL instead.
 >>>>
 >>>> The previous approach to fix this issue was to use the subclass 
lockdep
 >>>> key instead of the dynamic lockdep key. It requires RTNL before 
acquiring
 >>>> a nested lock because the subclass variable(dev->nested_lock) is
 >>>> protected by RTNL.
 >>>> However, the coverage of team->lock is too wide so sometimes it should
 >>>> use a subclass variable before initialization.
 >>>> So, it can't work well in the port initialization and unregister 
logic.
 >>>>
 >>>> This approach is just removing the team->lock clearly.
 >>>> So there is no special locking scenario in the team module.
 >>>> Also, It may convert RTNL to RCU for the read-most operations such as
 >>>> GENL dump but not yet adopted.
 >>>>
 >>>> Reproducer:
 >>>>     for i in {0..1000}
 >>>>     do
 >>>>             ip link add team$i type team
 >>>>             ip link add dummy$i master team$i type dummy
 >>>>             ip link set dummy$i up
 >>>>             ip link set team$i up
 >>>>     done
 >>>>
 >>
 >> Thanks a lot!
 >> Taehee Yoo

