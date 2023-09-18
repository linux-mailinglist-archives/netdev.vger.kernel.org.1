Return-Path: <netdev+bounces-34423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539A57A4226
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C4F28144F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 07:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194F748F;
	Mon, 18 Sep 2023 07:19:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57843C2C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 07:19:45 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B77E3
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 00:19:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-530196c780dso4652583a12.1
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 00:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695021567; x=1695626367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XYw4/Rssy0Bv4MFOyEv3VJfo0wg1Hulx8U0KczmVFRg=;
        b=15rJT0BDq/oiugaEb1nkOBADOQQMmDecqIeNGOk1Dm0UH2/tVIvoEFxt3mfAFZ+APN
         DDdO3D+gFbDIBVSYhEk3J/iHpcXGsxUAarvs2qwL9MapjMMYjGVujyQdmlFVYiDhNEy4
         LVCUsnY0XQN05n20lFstxBeFCUcF2F68zI0s2r6wUi9Eb9dpPiL4q6MSA1g+JqAMgGvO
         qF5OhP8dz8Dfgk7jrZR7/a1njox4xm2z1KwdD0hvc+Wl2JinfUPGvDPZ37K1SRcoFjW0
         mN68rBw2/gIAYxScCm9jBO3H8KiikczIzpHiOUFO0mFtKGhgx5tbUKh7mRTNQUsLWB/N
         Souw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695021567; x=1695626367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYw4/Rssy0Bv4MFOyEv3VJfo0wg1Hulx8U0KczmVFRg=;
        b=DBufjibLJu8uCR7d8q5Aue3K2UfazxB9dmWcMiZiT1at1mhXZpryV54fo1Jw9+NFey
         akSFOr+mwEz0IipUzLNy/751o9W1sDIOgKRPvKn0quTOJhENqNLvnSjbZfuGsnDW8URU
         8Y+mxniAYKSGEGtSg+hp0WnnlN2PECmaWQVaTnOBzo0tpI1y5Uh1qrVtHh1AxLWX18Ii
         Eiobtp2n2cnYMNuAzgwvON7oAiRvPBkl/8cL81YY/z5W6LKilKxLKOW6nGQsWpH7341X
         uckgMwfuVND2fGqzDewSU/PchwdfzoCH6mYz2jhnTs9T+ND+BuoLer624+J6bAIOa0er
         aQsg==
X-Gm-Message-State: AOJu0Yy/AIuy7JTu6WZGsRSa/dBkvf/gDsN+mNsi513RQ8Tv+CpjFRzR
	z8Fh0oKIrhBqfTD/rygbK6YzGg==
X-Google-Smtp-Source: AGHT+IHLpUUbBcKxS17us8YLoLPfIRJLcPrkmr18w6zorqii4BplOtVAyXLn3RKSuiQVcNjqYl6vJQ==
X-Received: by 2002:a17:906:cc0b:b0:9a9:e5a8:3dd8 with SMTP id ml11-20020a170906cc0b00b009a9e5a83dd8mr6720320ejb.9.1695021567558;
        Mon, 18 Sep 2023 00:19:27 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id va13-20020a17090711cd00b0097404f4a124sm6078154ejb.2.2023.09.18.00.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 00:19:26 -0700 (PDT)
Date: Mon, 18 Sep 2023 09:19:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com,
	syzbot+1c71587a1a09de7fbde3@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: team: get rid of team->lock in team module
Message-ID: <ZQf5/f7jFvvCJBSw@nanopsycho>
References: <20230916131115.488756-1-ap420073@gmail.com>
 <ZQXcOmtm1l36nUwV@nanopsycho>
 <a8aac295-6021-f13b-fd26-311462d0a930@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8aac295-6021-f13b-fd26-311462d0a930@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Sep 18, 2023 at 03:16:26AM CEST, ap420073@gmail.com wrote:
>
>
>On 2023. 9. 17. 오전 1:47, Jiri Pirko wrote:
>
>Hi Jiri,
>Thank you so much for your review!
>
>> Sat, Sep 16, 2023 at 03:11:15PM CEST, ap420073@gmail.com wrote:
>>> The purpose of team->lock is to protect the private data of the team
>>> interface. But RTNL already protects it all well.
>>> The precise purpose of the team->lock is to reduce contention of
>>> RTNL due to GENL operations such as getting the team port list, and
>>> configuration dump.
>>>
>>> team interface has used a dynamic lockdep key to avoid false-positive
>>> lockdep deadlock detection. Virtual interfaces such as team usually
>>> have their own lock for protecting private data.
>>> These interfaces can be nested.
>>> team0
>>>   |
>>> team1
>>>
>>> Each interface's lock is actually different(team0->lock and team1->lock).
>>> So,
>>> mutex_lock(&team0->lock);
>>> mutex_lock(&team1->lock);
>>> mutex_unlock(&team1->lock);
>>> mutex_unlock(&team0->lock);
>>> The above case is absolutely safe. But lockdep warns about deadlock.
>>> Because the lockdep understands these two locks are same. This is a
>>> false-positive lockdep warning.
>>>
>>> So, in order to avoid this problem, the team interfaces started to use
>>> dynamic lockdep key. The false-positive problem was fixed, but it
>>> introduced a new problem.
>>>
>>> When the new team virtual interface is created, it registers a dynamic
>>> lockdep key(creates dynamic lockdep key) and uses it. But there is the
>>> limitation of the number of lockdep keys.
>>> So, If so many team interfaces are created, it consumes all lockdep keys.
>>> Then, the lockdep stops to work and warns about it.
>>
>> What about fixing the lockdep instead? I bet this is not the only
>> occurence of this problem.
>
>There were many similar patches for fixing lockdep false-positive problem.
>But, I didn't consider fixing lockdep because I thought the limitation of
>lockdep key was normal.
>So, I still think stopping working due to exceeding lockdep keys is not a
>problem of the lockdep itself.

Lockdep is a diagnostic tool. The fact the tool is not working properly
does not mean we need to change the code the tool is working with. Fix
the tool.


>
>>
>>
>>>
>>> So, in order to fix this issue, It just removes team->lock and uses
>>> RTNL instead.
>>>
>>> The previous approach to fix this issue was to use the subclass lockdep
>>> key instead of the dynamic lockdep key. It requires RTNL before acquiring
>>> a nested lock because the subclass variable(dev->nested_lock) is
>>> protected by RTNL.
>>> However, the coverage of team->lock is too wide so sometimes it should
>>> use a subclass variable before initialization.
>>> So, it can't work well in the port initialization and unregister logic.
>>>
>>> This approach is just removing the team->lock clearly.
>>> So there is no special locking scenario in the team module.
>>> Also, It may convert RTNL to RCU for the read-most operations such as
>>> GENL dump but not yet adopted.
>>>
>>> Reproducer:
>>>    for i in {0..1000}
>>>    do
>>>            ip link add team$i type team
>>>            ip link add dummy$i master team$i type dummy
>>>            ip link set dummy$i up
>>>            ip link set team$i up
>>>    done
>>>
>
>Thanks a lot!
>Taehee Yoo

