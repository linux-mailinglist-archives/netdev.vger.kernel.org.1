Return-Path: <netdev+bounces-34927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0807A5F9E
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 12:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C78A1C20E25
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE3D15A6;
	Tue, 19 Sep 2023 10:32:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E691381
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:32:08 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450BAEA
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 03:32:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-404732a0700so55771945e9.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 03:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695119523; x=1695724323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+/5jFnz5ImgeLem+YBvV2ykpjv/frexXLOLEh9fUPo=;
        b=DJXtMQ8Hfkdi3aYfCuaUbkCywUgYIZkGGhzTD2L2uSdJ/Uh3o7wlVDcrd+BT0wVBfU
         f1q2BiLplUdIT8BkUMfgWxWWgg9nu2ZeizXv9HEMEwkmjrQDdu1FRmr1aFJlyVk4NmOK
         b2DCfWugwyX8eafMFdC5//F9ybjkFx6TsHcxICVazIysFUTK42DxnY13W6cP81kS8D2S
         HwOmXXyEzwGQ6JjBSlqRJmDY9JP0uwzXxkfI9HaKTJuXlLKTp6vXv8Ii3w24VQUDrJ87
         SBitu3a05Kstc3qpvJ+0CXlEwf/MVZYLep5B+Vo0Jvhlas1yXmQhyRCmgZuNNsSswkKE
         +ilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695119523; x=1695724323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+/5jFnz5ImgeLem+YBvV2ykpjv/frexXLOLEh9fUPo=;
        b=nQZlNLthNTXZ9JMNf6ngP9JMTdQHsq7HrPqMPL5FJ+TKbiO9ezggp4/nYqpkfVuyu0
         AaaJgs4yZbfR+wIHQBUGRtdS4mLXAwxDpgSsCb44BnMw2K6PmPYF/V+OqFaLtvwi8rfy
         6zccPH/0fU9d1KL6N1pUhjaKAlxLGw/3mjvTyCrb4vJGDxY3ZAD7XwsfMilnyM4ODpU4
         TsBZjffrt127+NZHxpgc+y+/tUsIPnnHvRm606fcXz18iu+xGgsfN7e2JXJF+43vxYFH
         S9Pd4Bl+0qH8iZyetKlAVVIlrr1PaYPF/aG4XRujgf3MOSKuZQeo3oVMnRC2WSu8YbZ/
         nDWQ==
X-Gm-Message-State: AOJu0YyLnprLC4yoiyvLrj+rx9HybbRgczM0cvVGKZRpi9gjMWfIdgWf
	VdPs7Y+3ziSva5kdPS+NdctRlpJo9nEeb/ZvkOtDAA==
X-Google-Smtp-Source: AGHT+IFjV9sZ1EI886LoWjsS4Lr8eOWpR0dth2ooPm3CC9E36z8sDhnFACxmrxaANw0LK9yQfIaITQ==
X-Received: by 2002:a1c:f701:0:b0:402:f5c4:2e5a with SMTP id v1-20020a1cf701000000b00402f5c42e5amr10835359wmh.37.1695119523413;
        Tue, 19 Sep 2023 03:32:03 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k11-20020a7bc40b000000b003fefca26c72sm14910391wmi.23.2023.09.19.03.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 03:32:02 -0700 (PDT)
Date: Tue, 19 Sep 2023 12:32:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, netdev@vger.kernel.org,
	syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com,
	syzbot+1c71587a1a09de7fbde3@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: team: get rid of team->lock in team module
Message-ID: <ZQl4oCdoeKWO8QqA@nanopsycho>
References: <20230916131115.488756-1-ap420073@gmail.com>
 <ZQXcOmtm1l36nUwV@nanopsycho>
 <d89e68db75f06c41c9b28584c1210ed31d27db2a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d89e68db75f06c41c9b28584c1210ed31d27db2a.camel@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Sep 19, 2023 at 09:40:53AM CEST, pabeni@redhat.com wrote:
>On Sat, 2023-09-16 at 18:47 +0200, Jiri Pirko wrote:
>> Sat, Sep 16, 2023 at 03:11:15PM CEST, ap420073@gmail.com wrote:
>> > The purpose of team->lock is to protect the private data of the team
>> > interface. But RTNL already protects it all well.
>> > The precise purpose of the team->lock is to reduce contention of
>> > RTNL due to GENL operations such as getting the team port list, and
>> > configuration dump.
>> > 
>> > team interface has used a dynamic lockdep key to avoid false-positive
>> > lockdep deadlock detection. Virtual interfaces such as team usually
>> > have their own lock for protecting private data.
>> > These interfaces can be nested.
>> > team0
>> >  |
>> > team1
>> > 
>> > Each interface's lock is actually different(team0->lock and team1->lock).
>> > So,
>> > mutex_lock(&team0->lock);
>> > mutex_lock(&team1->lock);
>> > mutex_unlock(&team1->lock);
>> > mutex_unlock(&team0->lock);
>> > The above case is absolutely safe. But lockdep warns about deadlock.
>> > Because the lockdep understands these two locks are same. This is a
>> > false-positive lockdep warning.
>> > 
>> > So, in order to avoid this problem, the team interfaces started to use
>> > dynamic lockdep key. The false-positive problem was fixed, but it
>> > introduced a new problem.
>> > 
>> > When the new team virtual interface is created, it registers a dynamic
>> > lockdep key(creates dynamic lockdep key) and uses it. But there is the
>> > limitation of the number of lockdep keys.
>> > So, If so many team interfaces are created, it consumes all lockdep keys.
>> > Then, the lockdep stops to work and warns about it.
>> 
>> What about fixing the lockdep instead? I bet this is not the only
>> occurence of this problem.
>
>I think/fear that solving the max key lockdep problem could be
>problematic hard and/or requiring an invasive change.

But it would solve this false warnings not only here but for many
others.


>
>Is there any real use-case requiring team devices being nested one to
>each other? If not, can we simply prevent such nesting in
>team_port_add()? I'm guessing that syzkaller can find more ways to
>exploit such complex setup.

I see no such usecase. However, if someone is using it this way now, we
should not break him.


>
>Cheers,
>
>Paolo
>

