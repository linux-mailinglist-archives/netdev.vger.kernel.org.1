Return-Path: <netdev+bounces-31316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1687878CFB4
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 00:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC951C20A6A
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 22:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82DE6FBA;
	Tue, 29 Aug 2023 22:57:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4976AAC
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 22:57:27 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BDF1BE
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 15:57:26 -0700 (PDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2717f4ba116so4032402a91.0
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 15:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693349846; x=1693954646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAx6PSOlRe1SoOmdVLTfSTqRq8XYYm/GJtA05ydLXZQ=;
        b=F0p/cBFPoS8suy81xIc/A/C3BemzjfwUwB3TbrSo1jBGHQgFb8cBNVjliU2gyChd1g
         EJr2O94GuuMDKn6EAoPRu5zSsp6U9oWYwvMGGBKX53DnhUAuZn5S0OWh8XPAVEXH3wM0
         nt9M2Ll2KDGVEYIM/nPGu5gA0yPGyehetasSSQi0FJAjYjQuG55JTNVp+758iSotFi6A
         63OAZ48geaEtci7YBXJxU0chUdyGMHRLYzM2JOsY5xbq1RqB7nzgvXcOdvuBrKnKjmv9
         KTBxWpUU2AGuu9/2BF5wsqj7IpG0nPAhIY13df6VgM6PW/AZ+/iYX72VTFpF4/1jKi14
         cMpg==
X-Gm-Message-State: AOJu0YwM+ot6ClZ3b0FhLOywScjnWli6z8RpAhmKPQlaQ2WhMGaEJD71
	Oy73eXAkaDpFAT9Yep9gqkyu/odn1+YQrUBuHEjcMiA/Nbe6
X-Google-Smtp-Source: AGHT+IEzdCowiZmXUDDhkbYINfZE/r+09JEfRrBJG3TV1PZiXW7dTgVeIl0Jj6WsJu8Hs/EFNhtwmwBtC0shQ2WpNjmc8DS1vxGs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c908:b0:268:5c5d:25cf with SMTP id
 v8-20020a17090ac90800b002685c5d25cfmr153388pjt.4.1693349845961; Tue, 29 Aug
 2023 15:57:25 -0700 (PDT)
Date: Tue, 29 Aug 2023 15:57:25 -0700
In-Reply-To: <00000000000017ad3f06040bf394@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c97a4060417bcaf@google.com>
Subject: Re: [syzbot] [net] INFO: rcu detected stall in sys_close (5)
From: syzbot <syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com>
To: brauner@kernel.org, davem@davemloft.net, edumazet@google.com, 
	eric.dumazet@gmail.com, gautamramk@gmail.com, hdanton@sina.com, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, lesliemonis@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mohitbhasi1998@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdp.sachin@gmail.com, syzkaller-bugs@googlegroups.com, tahiliani@nitk.edu.in, 
	viro@zeniv.linux.org.uk, vsaicharan1998@gmail.com, xiyou.wangcong@gmail.com
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101bb718680000
start commit:   727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121bb718680000
console output: https://syzkaller.appspot.com/x/log.txt?x=141bb718680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45047a5b8c295201
dashboard link: https://syzkaller.appspot.com/bug?extid=e46fbd5289363464bc13
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14780797a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c1fc9fa80000

Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

