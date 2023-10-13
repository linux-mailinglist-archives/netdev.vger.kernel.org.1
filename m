Return-Path: <netdev+bounces-40589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1EE7C7C47
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 05:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52628B208A5
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACFC17EB;
	Fri, 13 Oct 2023 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A117C1
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 03:44:30 +0000 (UTC)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA83C0
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 20:44:28 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b2b1aa7e35so135231b6e.0
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 20:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697168668; x=1697773468;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mt5lwhC39izgTZ2VYtKVLxhKrOpgc+bFz9LIFDekYx8=;
        b=flBMYfn0nTieyUP8gG1psbBuCmTeBsu+inp+70R5moFi6eTRFnjulkGAwBGNCTcAIy
         OH7AHqWTukIiZk+WA4bKkhSupUpvOX2tbMuXQp3trh83rXSzIXSSqchC0Ath+0mHNVDt
         OcciHwnzKxi7hHjsTd90lJkNSyC02qLyLj4VXFBrSr5m9Ccd8Mkw15gEeFy2afsE/x0o
         a9GRRbNqnFGUGtO6o9Yy5sZ2H7ojpWOElWA7xlej6IdDFAFzk5OW3Iw0XdDSALdfnLGz
         uvbmokwoIByRYPlIWTyyqzZv+q5Xy+Ioz9gh6ZfiXsdpWcVKdnfkKZU6yyjFrm1bEurP
         PwaA==
X-Gm-Message-State: AOJu0YyswrAcABKCP/AAyne4tgXV9Ht13MhiNRJHE0koI6HlPXYxm9Ul
	gk8OLnzcGROznTXTlxi4AwgwDWRGAkFxsFTXYoHRd4LYvmIT
X-Google-Smtp-Source: AGHT+IELbRThAdn5Z7PxEQ2q784CB31g7j9A0PV98zUl+RW8YJASygLBqKQpFkzypV3y11u9UGbDuQ3MD7vzMK6PCLZl/FkwCOeL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:152a:b0:3ad:fd08:30a3 with SMTP id
 u42-20020a056808152a00b003adfd0830a3mr13193875oiw.11.1697168667943; Thu, 12
 Oct 2023 20:44:27 -0700 (PDT)
Date: Thu, 12 Oct 2023 20:44:27 -0700
In-Reply-To: <000000000000648bb80600bccb40@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093a958060790df91@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in wait4 (4)
From: syzbot <syzbot+8ee0140c3f5eab8a8d4f@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit 8542f1712074f070ae90b64e6082d10d8e912e32
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Mon Oct 2 10:04:45 2023 +0000

    ovl: fix file reference leak when submitting aio

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=131df329680000
start commit:   9d23aac8a85f Merge branch 'net-sched-fixes-for-sch_qfq'
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a211c03cef60366
dashboard link: https://syzkaller.appspot.com/bug?extid=8ee0140c3f5eab8a8d4f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1014d574a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173e5deca80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ovl: fix file reference leak when submitting aio

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

