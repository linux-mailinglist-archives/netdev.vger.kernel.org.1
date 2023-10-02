Return-Path: <netdev+bounces-37408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CA97B53AA
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9EA9C2832CB
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB618040;
	Mon,  2 Oct 2023 13:08:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6791C171A7
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 13:08:31 +0000 (UTC)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B96AD
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 06:08:29 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1dc580ed1e4so33828550fac.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 06:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252109; x=1696856909;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rorPIP5j5NnvLe/VG3SBvJuviukORjr0ptic0PGw4zI=;
        b=nPkNZGXesOinwUAe6xffgSUHl1NxlBmgqTwJn3vJYTAKiS6xowYp29FKilLXo457QW
         4FTlqfaSxLoszkWRkYlM4C1zfLzDwzlUv5mWpgvC+z2NPXY1LeAb/MCL1HqtvLMehftj
         WuXofYgPjTvtFIn1YLJhoU4b59r5fiMcsN0rS9C4rtTm2BvIufhjhr9EMuko20hCAg5b
         KXNJ9aDnmossf2kTOQSUFBdGfEqfNVh1xTUY6nv2VJHrgEVwEMSpaXmRwNfZmuki0Hg8
         jF4gmeWDH33AZDwxBU3mSQcCmO0z5U7ZZ6eEE0dZiPMEvXMU1OqkZrSzThWQFC1w6J9m
         2ZxA==
X-Gm-Message-State: AOJu0Yz+4XcPxNIPaR1IPeXKk4XrQbgCvtC01NrytGMrpz6EVYmGe2UO
	rD9FhkOD9X3spGUY3MzaPadKxp2SUycI2MQFf5MWmCumgoml
X-Google-Smtp-Source: AGHT+IH15olfXP89zOaUgPnZ+A3LWHTnmJnCU4ut1cZEZzpYg/G4sHkoNl3GWJ2A8/7WTnzttgIAQ3N4O8oSXKkeG9zcRAHK4fyE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5aad:b0:1c0:e7d3:3b2d with SMTP id
 dt45-20020a0568705aad00b001c0e7d33b2dmr4872328oab.7.1696252109232; Mon, 02
 Oct 2023 06:08:29 -0700 (PDT)
Date: Mon, 02 Oct 2023 06:08:29 -0700
In-Reply-To: <000000000000c4c9d405f2643e01@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ba21a0606bb78f9@google.com>
Subject: Re: [syzbot] [bridge?] possible deadlock in br_multicast_rcv (3)
From: syzbot <syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com>
To: amcohen@nvidia.com, axboe@fb.com, bridge@lists.linux-foundation.org, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, hch@lst.de, 
	hdanton@sina.com, idosch@nvidia.com, ivecera@redhat.com, jiri@resnulli.us, 
	kbusch@kernel.org, kuba@kernel.org, lengchao@huawei.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org, 
	roopa@nvidia.com, sagi@grimberg.me, syzkaller-bugs@googlegroups.com, 
	trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit 0ae3eb7b4611207e140e9772398b9f88b72d6839
Author: Amit Cohen <amcohen@nvidia.com>
Date:   Mon Feb 1 19:47:49 2021 +0000

    netdevsim: fib: Perform the route programming in a non-atomic context

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13afdae6680000
start commit:   2faac9a98f01 Merge tag 'keys-fixes-20230321' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=106fdae6680000
console output: https://syzkaller.appspot.com/x/log.txt?x=17afdae6680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aaa4b45720ca0519
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b7f1412c02134efa6d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14aea34ec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13001e91c80000

Reported-by: syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com
Fixes: 0ae3eb7b4611 ("netdevsim: fib: Perform the route programming in a non-atomic context")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

