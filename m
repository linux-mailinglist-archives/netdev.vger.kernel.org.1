Return-Path: <netdev+bounces-40993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCB37C94AC
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 15:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9D4B20B29
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFE6125B1;
	Sat, 14 Oct 2023 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA5BE42
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 13:07:31 +0000 (UTC)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C37EBF
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 06:07:30 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1bf00f8cf77so4118574fac.0
        for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 06:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697288849; x=1697893649;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/6ceZHQviZHWBwoxE7adPRErfGv6u0OyUKTGWcI8bI=;
        b=ZJmO2/aKxcNh2P2RNeSZlS3FmDB5hWvsPGUnYUJtv8HZXnVs878QGcs3fiGC7dYZiM
         XkmRtquReVoSOJajHcAINFgt8twn5gYfGE0b+h2Z2lX8Ov9jN+1EspKFHs67+lhsCQV0
         MYJ2hNi5bfe+4BscJGMs/VJj/rbgII0ao3AkLjCXXOgxi6noIPBV5i28pgAJfJyAPLRM
         ZzvC0fNpd/iOpO6TbbZp2pBu7by3el4xan8yqWGYVSGKe7x1Nfcdbd1S/xtLqhnp5VsB
         kkJAzr25l2PBcM/16pQibsL0cgff2yxWE4eIZxE0OCzLJS3WtoI44H9mMv5/Wl3Dc7f5
         7a5w==
X-Gm-Message-State: AOJu0YxlQEjOwjcNQ16Q38dm/pURl39GAIMBV4bUXiktcyDzQagITC56
	ESmGCSfSIQ9GVWZy3ClzSWdbk1thtyDIMK4hotfhKezE3JK6
X-Google-Smtp-Source: AGHT+IEVCXmtDm4/SgXnVdwVBjmB+6iLQnnDacoQ6B2a0YxsIaEpL48b/OQOJ6nt9o5XmKqieSHSUI18COA2sWNw0RWueMJ/nlKJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d782:b0:1e9:6b2f:5ad7 with SMTP id
 bd2-20020a056870d78200b001e96b2f5ad7mr4590286oab.1.1697288848970; Sat, 14 Oct
 2023 06:07:28 -0700 (PDT)
Date: Sat, 14 Oct 2023 06:07:28 -0700
In-Reply-To: <000000000000ea44c905ffd26705@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec9cb90607acdac9@google.com>
Subject: Re: [syzbot] [batman?] INFO: rcu detected stall in rtnl_newlink (3)
From: syzbot <syzbot+afb3084a933aa2bdacc6@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, 
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org, 
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, 
	vinicius.gomes@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit e739718444f7bf2fa3d70d101761ad83056ca628
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Sat Jul 29 00:07:05 2023 +0000

    net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b26a4d680000
start commit:   d528014517f2 Revert ".gitignore: ignore *.cover and *.mbx"
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d576750da57ebbb5
dashboard link: https://syzkaller.appspot.com/bug?extid=afb3084a933aa2bdacc6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15849d08a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13184990a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

