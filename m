Return-Path: <netdev+bounces-36018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D87067AC7A2
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 12:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 41E461F23A4F
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 10:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7183D63F;
	Sun, 24 Sep 2023 10:59:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC710F4
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 10:59:20 +0000 (UTC)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CC0107
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 03:59:18 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1bf2e81ce63so9892874fac.1
        for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 03:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695553157; x=1696157957;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jlk+O3J+o0kkp1OKytTuo5mn2nF+ogupL5uOl8zcGuA=;
        b=Ju06olCrIgfVm2Wuom7ZQBTHItms/5pvUdqcO51NJKbuM2KtkzuoXoD6TE05se0TVV
         wadu6gYGBQ5SGDWCjRhv/xct/yQQM/eFsErZRh0xSW808aspLJWXrcENJIx+wdKYRVcQ
         MW31+lnStHisHUcWmzP+vkgAcNGqjBdUQmaAnvcavJkPbKh7FE0ZjDLeoniKWUpPL7qK
         zX/JnW8bN/DiveEEL79cGLfuOr1hEaBPiACTjghV/tffUbePX7qsbQYhLHjD51WQwCpN
         2uO5GEXe7zhWq+REQVUwJKgLgx+nRvJu+4mDaILQOnlHxRc8Pfyh26/uj17nz7EltgiG
         lpKw==
X-Gm-Message-State: AOJu0YzQFGwr2Bm4K3RJZUVjDY8aWvbm6wNdJGqEsA16dJOWSsNTS/9K
	678iHjcS/WuSVtq1GNCPxjCtm5WglpDkAgaHyF5vOtWz+9um
X-Google-Smtp-Source: AGHT+IGp8vx1D9jMEB/i7wblpIR1qbSKkkYzRnZBs6mxLXQ6LjSZuwUrXWRzpxMUsQ4CTqUu0G4qMtnatkOXoDUjowcVzPeX9afh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:9a93:b0:1d6:a9da:847 with SMTP id
 hp19-20020a0568709a9300b001d6a9da0847mr2947177oab.0.1695553157625; Sun, 24
 Sep 2023 03:59:17 -0700 (PDT)
Date: Sun, 24 Sep 2023 03:59:17 -0700
In-Reply-To: <0000000000000c439a05daa527cb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a87e66060618bb7e@google.com>
Subject: Re: [syzbot] [netfilter?] INFO: rcu detected stall in gc_worker (3)
From: syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, coreteam@netfilter.org, davem@davemloft.net, 
	dvyukov@google.com, edumazet@google.com, fw@strlen.de, gautamramk@gmail.com, 
	hdanton@sina.com, jhs@mojatatu.com, jiri@resnulli.us, kadlec@netfilter.org, 
	kuba@kernel.org, lesliemonis@gmail.com, linux-kernel@vger.kernel.org, 
	mohitbhasi1998@gmail.com, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	paulmck@kernel.org, sdp.sachin@gmail.com, syzkaller-bugs@googlegroups.com, 
	tahiliani@nitk.edu.in, tglx@linutronix.de, vsaicharan1998@gmail.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit ec97ecf1ebe485a17cd8395a5f35e6b80b57665a
Author: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
Date:   Wed Jan 22 18:22:33 2020 +0000

    net: sched: add Flow Queue PIE packet scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15c5748e680000
start commit:   d4a7ce642100 igc: Fix Kernel Panic during ndo_tx_timeout c..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17c5748e680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13c5748e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b9a3cf8f44c6da
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1504b511a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137bf931a80000

Reported-by: syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com
Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

