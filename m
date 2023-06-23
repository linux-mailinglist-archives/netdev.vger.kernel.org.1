Return-Path: <netdev+bounces-13473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3812973BBA6
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692EB1C2122B
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF12C2C7;
	Fri, 23 Jun 2023 15:29:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18FCC8C6
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:29:24 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956091FE3
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 08:29:22 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-76c6c1b16d2so49479239f.1
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 08:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687534162; x=1690126162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBrsp/L8LBbY13kpCjVb8ARrn73n9NBhpEUWG/fTsCo=;
        b=QnTUptRUNfgb1hymsK3T/tLgSvgaPnMoPUtqATG91328rdEpxtHv4j7ZShNLlb/0EP
         ygEwSudatskj19gERJp4hKORyhUhjfA5ZRO4v9LAUaYLpnX2C86qm6OjAb/0gIQ/TM15
         7KaUr/ThOYFdMlHefStucxc/KSfw/zjZ0SDQEUGwXkDP1x4+C7QDMcHFDZsOlzUWzPtR
         xfl7BQsaoxgoYfpvbbaoaxAIcrthAY9BRN1Tm7DLxvlB3Rsd/pHPLXNyIHuOPueUlExj
         ztq1CAkAGTtT0ehJB74WKIdaWPd20F+XW2uPNAXNHCbC6FRsFts2MOcn+T7aL0XXDp6g
         04Eg==
X-Gm-Message-State: AC+VfDw64j1N9jvfBEFzOsHNJbiBOk+ivZHp4FP3zoVi8zfLQwLv399S
	YBpE3jpH2jvBh2ZzQpRtz9VSMHJW7iMFBSxz0bptDDzuAMbc
X-Google-Smtp-Source: ACHHUZ5s4AxZGy5IkdfIF5CHenFw6Jv1FrcGeoKc+TSkvorT6RmNJB+KZsAlt7cYmNfsYhwRWXrGY0pg01T/p+aODwSow+udbhCe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd41:0:b0:341:d428:7bcd with SMTP id
 v1-20020a92cd41000000b00341d4287bcdmr8114863ilq.1.1687534161912; Fri, 23 Jun
 2023 08:29:21 -0700 (PDT)
Date: Fri, 23 Jun 2023 08:29:21 -0700
In-Reply-To: <2370718.1687532181@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000446b0805fecdaaf4@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_async_update
From: syzbot <syzbot+0bc501b7bf9e1bc09958@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0bc501b7bf9e1bc09958@syzkaller.appspotmail.com

Tested on:

commit:         faaa5fd3 dt-bindings: net: altr,tse: Fix error in "com..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=14f7e723280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78c5a35ccd7ceb0
dashboard link: https://syzkaller.appspot.com/bug?extid=0bc501b7bf9e1bc09958
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

