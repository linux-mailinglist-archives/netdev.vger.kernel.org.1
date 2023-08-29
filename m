Return-Path: <netdev+bounces-31297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E6078CB43
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 19:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267FD281230
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011AD18002;
	Tue, 29 Aug 2023 17:30:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E844A17FE6
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 17:30:00 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7B7E54
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:29:32 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c097e8a175so47943415ad.3
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693330105; x=1693934905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUCzNcqELyYZpjVuIL+b142F4z8AIUx6kMc8IJwMClE=;
        b=IVHEq9PorDih2VhVw50bzJHmxaxnc3ExIFJUnDfpVsir6E3c76WGCEXl1WUjE4ZcMN
         ALs74j1hzDijJKDkNfAIJqWNMyaDCn0m/UL9WstVS4jjMXebsjB/wMbROpDFHinVzQ5m
         oZI42xfb39jVAJXEWjb8mpMOZYgmKp2F9vsVbhdThsliVyv6CHs/i6C4h5hqus8zbp28
         /b0uOSEzFjGFGW9K4dJpRbCZa909IbdZQ7XT3XmXOzPaTnbMqUTyS444IiPOXAbeDMCQ
         wUItO7DvMqVK0fkxeD7QkXq9t4gG8YczijE5z1anxZXSAHRlOIUTdCEAXKK+uizlsuus
         TxyA==
X-Gm-Message-State: AOJu0YzMe6dj0pPGuj+z/hqGSNEzDXCRQU8gCckE8heDZHINs/PSuvq/
	K9b2BqaAIvvqpyQlgw6QUowlAyZSgqqlyDDT7hc7C535vGOs
X-Google-Smtp-Source: AGHT+IF1/hCSfQfodVtXb8zKn8Kpjt6GZWqcrlbm+l6JvWJTL1C8JmfHHuXYfw95FdrNR+Nkr3vh8iphOEem0N1y2sDyweQVqFV6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:e550:b0:1c2:584:51ce with SMTP id
 n16-20020a170902e55000b001c2058451cemr460387plf.7.1693330105183; Tue, 29 Aug
 2023 10:28:25 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:28:25 -0700
In-Reply-To: <000000000000c329d505fed78c74@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068345606041323fc@google.com>
Subject: Re: [syzbot] [input?] INFO: task hung in uhid_char_release
From: syzbot <syzbot+8fe2d362af0e1cba8735@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, akrowiak@linux.ibm.com, 
	benjamin.tissoires@redhat.com, clg@redhat.com, davem@davemloft.net, 
	david.rheinsberg@gmail.com, edumazet@google.com, jikos@kernel.org, 
	kuba@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mjrosato@linux.ibm.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit bf48961f6f48e3b7eb80c3e179207e9f4e4cd660
Author: Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue May 30 22:35:37 2023 +0000

    s390/vfio-ap: realize the VFIO_DEVICE_SET_IRQS ioctl

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155eba2fa80000
start commit:   bde7f150276b Merge tag 'pm-6.5-rc2' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=175eba2fa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=135eba2fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0f369ef5fb88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=8fe2d362af0e1cba8735
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124711b6a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178c5a92a80000

Reported-by: syzbot+8fe2d362af0e1cba8735@syzkaller.appspotmail.com
Fixes: bf48961f6f48 ("s390/vfio-ap: realize the VFIO_DEVICE_SET_IRQS ioctl")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

