Return-Path: <netdev+bounces-34370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0FF7A3F23
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 03:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8B82812E1
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 01:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FED1119;
	Mon, 18 Sep 2023 01:16:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84510620
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 01:16:33 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB846126
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 18:16:31 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-577a98f78b2so2818503a12.3
        for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 18:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694999791; x=1695604591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=588EBNhdj+2aJdpJxClb2GumVUmDqi8OHhk47ZxwVMc=;
        b=i7OmO4vTMc+h8uY7RZaUMYlhyKfYcgf0GHKAZjTbHrf0HNAlKD+nlY1OhGe/P9GIHl
         5txjWgyVjDUlg2252jJVvdQd15B1SDpuOuE/fcjsgKvn6f0YmbLl/gzTl76Wobqti/ha
         XzecroeNWiW/TFJjCc+4GYvs62jmoHyeTh8odz0NbN9eYLu05MVJeFjZvmORy6eh6Bju
         H1L898vEV20lqQopyjzfgqXE/mQWJoWN4jHlFzAKlx2vQF/6YQ644Wwn5jO4KFgVfa+C
         Fye97nsr7WuvQZnwqL0E+6cwCoD8Jw4EgxdS28wIDcG+8PhFI2z1bxQgAnk01RwQKGIi
         xA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694999791; x=1695604591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=588EBNhdj+2aJdpJxClb2GumVUmDqi8OHhk47ZxwVMc=;
        b=ijC+Hr1mhTerUych/NFHDQFWdRSmHJGFmFan6+N8eUEzuIg5rvDU1ouVKUapO527GL
         ewgPqQCVTwxTqqAxCt9PzkGm3eQAlpxI8ZNJmJuvocuBqJ9gB1HMIDrD0OfiGUNqOoly
         3XaTH3CMUjoY94RQK9mvXw3uDKsOfCaEkV8vO3O4Dz5Q7TTWNtM+7eUAMjuxbz8gLj2h
         QMPtQvD/B6MdVbvHZQ+V1rArv26L2TnAbnSjrCKBczAfH9zR7UDhwcdhFziEFxUd1rek
         KEC6U8XkcnsoOGq2nhHEsb3PhUINQzisfEtixii9Vl5M8ia8ly1q75mJVHqt61DkUP46
         Io3A==
X-Gm-Message-State: AOJu0Yzh5Up7ytbK4tlpxWG09h5KkwJQ9uxIbu9isMAAOB5az528kgl8
	khE4acjfW5R5T/WbNhB12hs=
X-Google-Smtp-Source: AGHT+IGRsEBjGFSHFB2GIVNxUnJNH/dKO3G4/rAM2ZyMkboA9tGHLB9WSHPwoy2HsgL5Duo5LAfx8w==
X-Received: by 2002:a17:90b:1887:b0:274:566a:3477 with SMTP id mn7-20020a17090b188700b00274566a3477mr5202446pjb.39.1694999790929;
        Sun, 17 Sep 2023 18:16:30 -0700 (PDT)
Received: from [192.168.123.100] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id n7-20020a17090a2fc700b00267d9f4d340sm1396981pjm.44.2023.09.17.18.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 18:16:30 -0700 (PDT)
Message-ID: <a8aac295-6021-f13b-fd26-311462d0a930@gmail.com>
Date: Mon, 18 Sep 2023 10:16:26 +0900
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
From: Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <ZQXcOmtm1l36nUwV@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023. 9. 17. 오전 1:47, Jiri Pirko wrote:

Hi Jiri,
Thank you so much for your review!

 > Sat, Sep 16, 2023 at 03:11:15PM CEST, ap420073@gmail.com wrote:
 >> The purpose of team->lock is to protect the private data of the team
 >> interface. But RTNL already protects it all well.
 >> The precise purpose of the team->lock is to reduce contention of
 >> RTNL due to GENL operations such as getting the team port list, and
 >> configuration dump.
 >>
 >> team interface has used a dynamic lockdep key to avoid false-positive
 >> lockdep deadlock detection. Virtual interfaces such as team usually
 >> have their own lock for protecting private data.
 >> These interfaces can be nested.
 >> team0
 >>   |
 >> team1
 >>
 >> Each interface's lock is actually different(team0->lock and 
team1->lock).
 >> So,
 >> mutex_lock(&team0->lock);
 >> mutex_lock(&team1->lock);
 >> mutex_unlock(&team1->lock);
 >> mutex_unlock(&team0->lock);
 >> The above case is absolutely safe. But lockdep warns about deadlock.
 >> Because the lockdep understands these two locks are same. This is a
 >> false-positive lockdep warning.
 >>
 >> So, in order to avoid this problem, the team interfaces started to use
 >> dynamic lockdep key. The false-positive problem was fixed, but it
 >> introduced a new problem.
 >>
 >> When the new team virtual interface is created, it registers a dynamic
 >> lockdep key(creates dynamic lockdep key) and uses it. But there is the
 >> limitation of the number of lockdep keys.
 >> So, If so many team interfaces are created, it consumes all lockdep 
keys.
 >> Then, the lockdep stops to work and warns about it.
 >
 > What about fixing the lockdep instead? I bet this is not the only
 > occurence of this problem.

There were many similar patches for fixing lockdep false-positive problem.
But, I didn't consider fixing lockdep because I thought the limitation 
of lockdep key was normal.
So, I still think stopping working due to exceeding lockdep keys is not 
a problem of the lockdep itself.

 >
 >
 >>
 >> So, in order to fix this issue, It just removes team->lock and uses
 >> RTNL instead.
 >>
 >> The previous approach to fix this issue was to use the subclass lockdep
 >> key instead of the dynamic lockdep key. It requires RTNL before 
acquiring
 >> a nested lock because the subclass variable(dev->nested_lock) is
 >> protected by RTNL.
 >> However, the coverage of team->lock is too wide so sometimes it should
 >> use a subclass variable before initialization.
 >> So, it can't work well in the port initialization and unregister logic.
 >>
 >> This approach is just removing the team->lock clearly.
 >> So there is no special locking scenario in the team module.
 >> Also, It may convert RTNL to RCU for the read-most operations such as
 >> GENL dump but not yet adopted.
 >>
 >> Reproducer:
 >>    for i in {0..1000}
 >>    do
 >>            ip link add team$i type team
 >>            ip link add dummy$i master team$i type dummy
 >>            ip link set dummy$i up
 >>            ip link set team$i up
 >>    done
 >>

Thanks a lot!
Taehee Yoo

