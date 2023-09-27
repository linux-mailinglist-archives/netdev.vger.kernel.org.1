Return-Path: <netdev+bounces-36558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BAA7B064D
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 16:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AC6DF282120
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B138F99;
	Wed, 27 Sep 2023 14:12:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316C1F61C
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 14:12:24 +0000 (UTC)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19A1FC
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 07:12:22 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1dd96cab3e9so3206675fac.0
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 07:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695823942; x=1696428742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5+JvUZEOKzPf2ex0W9pSMvC1OvUezS3byGKI63FJl0=;
        b=d1KT2gEQRK4KYWm6ESQt9ntPS4uTNrDstCV0ntE5z9+eOC3aOk2uwXtgEtMLOwdb5l
         wM6R/Ni6ZLC77ndz/MWP0QRVpjZS5hWYoFRHtmcxn7zGM9VJi2NYhaolK0gm7bhrkfrq
         Ia5T4RuAihdW6s11YUs6JdHvngnNX/vNJLem3nDxe7ToPR4OPPomJ67iTF3kLPuv7IUw
         nMhiWgwXpg6eHfZC9Nw3+xtp8+lKMwKx1bp/DOUu/m4oUmdNz9odOHYptjnw9hEzz5Gy
         Akmky8HcTKdeFHRiTR12N4xNni/Es1CKxWfRu5wLjy74ZrpNOL709R3sq/KrN4X4B1Ju
         EiGQ==
X-Gm-Message-State: AOJu0Yxa7Ly3Ytm1T3tAea3AZ/cA+D7R1wg8B62olxA2eEm867iVjkqi
	f3Fofdi/hv7cjqlKftfkaF6q5IhnD4IQncQcyMDuKWbrJuH6
X-Google-Smtp-Source: AGHT+IEXT9cv/7otRKCHIMyXe4a6OuyJUAPxPGuY/5OBjjcTazh1xGVVg8YXZdg52Yezvlv1nQK+3H0kUU4kY2hV/Fo/BtkLW7aV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a88d:b0:1bf:a06f:ce6f with SMTP id
 eb13-20020a056870a88d00b001bfa06fce6fmr748507oab.9.1695823942234; Wed, 27 Sep
 2023 07:12:22 -0700 (PDT)
Date: Wed, 27 Sep 2023 07:12:22 -0700
In-Reply-To: <00000000000029708206031ad94a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adbe11060657c7b6@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in toggle_allocation_gate
From: syzbot <syzbot+52d2f6feb48dc7328968@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net, 
	hdanton@sina.com, hpa@zytor.com, jhs@mojatatu.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	pctammela@mojatatu.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	victor@mojatatu.com, vladimir.oltean@nxp.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit da71714e359b64bd7aab3bd56ec53f307f058133
Author: Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue Aug 22 10:12:31 2023 +0000

    net/sched: fix a qdisc modification with ambiguous command request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15dd4876680000
start commit:   950fe35831af Merge branch 'ipv6-expired-routes'
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe63ad15dded26b6
dashboard link: https://syzkaller.appspot.com/bug?extid=52d2f6feb48dc7328968
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d34703a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a9a040680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: fix a qdisc modification with ambiguous command request

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

