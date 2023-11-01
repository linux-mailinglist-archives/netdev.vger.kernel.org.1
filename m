Return-Path: <netdev+bounces-45598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ABE7DE805
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 23:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE571C209F5
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 22:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5711B27B;
	Wed,  1 Nov 2023 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08101640B
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 22:21:09 +0000 (UTC)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEB311D
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 15:21:04 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1ef4f8d294eso734901fac.1
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 15:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698877264; x=1699482064;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWNK5rAhhP9EKmlHOfAbxlqIxZE8TUcPdTdYmSWehRY=;
        b=ZyzSjzDHorcII4W1mKNGOSFqzSC04Wq/rlqW7JJdJ/BXDBaEHnfpf8JdZEFnhlL0Sr
         4CnpwVt+TBOTCSdILKpRCiAXlKSz7TqQoGgMLrPAbcjIQU6Y7QJ4pydMvJtdMIIYIJRB
         +lFklMu/4mIqbVLjvYBJiwvn8xSs7Y7tcsGn5dPt84pFiRNORs+qaaws421f7flRMPWW
         Zk8ZKEykSAZcrtYXmuXXSVT7tkoGaQQd7UgK5ICW7S9eAFiIP7nHSfj/I282MNORV9gr
         A01PB+gcPwvXJ7FCegSzpdSwVdUbbxi4MdEoDVJJ/ypBPqW9aJXPoKxERFsTeUGivvhM
         TzvQ==
X-Gm-Message-State: AOJu0Yzgkm33ns8hGtl/iKEeggp8oczjlsZCpewtAsDBAL/3DhqHxFBt
	UTyBplRPATmhoSlwGXx73bLzMPKrDfMCjuczjVMULUWuyoa/
X-Google-Smtp-Source: AGHT+IH2wTJ4HmzhxXTucKEBfV2iL5v7+phh6V0Xl9g/QR6TCjYT6jQ72RdDgWQhYCmbN3tQSngqCbQMM4C6fsGDTe/sHHuIiyTL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:8094:b0:1ef:9ee0:3378 with SMTP id
 q20-20020a056870809400b001ef9ee03378mr6285788oab.0.1698877263989; Wed, 01 Nov
 2023 15:21:03 -0700 (PDT)
Date: Wed, 01 Nov 2023 15:21:03 -0700
In-Reply-To: <000000000000ffc87a06086172a0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6502306091eafb8@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in ptp_release
From: syzbot <syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com>
To: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	reibax@gmail.com, richardcochran@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 8f5de6fb245326704f37d91780b9a10253a8a100
Author: Xabier Marquiegui <reibax@gmail.com>
Date:   Wed Oct 11 22:39:55 2023 +0000

    ptp: support multiple timestamp event readers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1019f36f680000
start commit:   89ed67ef126c Merge tag 'net-next-6.7' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1219f36f680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1419f36f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e3b1d98cf5a2cca
dashboard link: https://syzkaller.appspot.com/bug?extid=8a676a50d4eee2f21539
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dd173b680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce0840e80000

Reported-by: syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com
Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

