Return-Path: <netdev+bounces-14950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238CE744870
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 12:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DF228123A
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4DA5699;
	Sat,  1 Jul 2023 10:15:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622893FDD
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 10:15:06 +0000 (UTC)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB7E2D46
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 03:15:01 -0700 (PDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-262d296873aso3241902a91.1
        for <netdev@vger.kernel.org>; Sat, 01 Jul 2023 03:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688206501; x=1690798501;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=diYwR8St8wT/i4D42MCVrfW4HzrpsotIwwPSjUegdyU=;
        b=cKpvWyutp1jD/gjK72PC5AUR/iofOOBcvnXV6c+rgCTzEuxV/5E8iuQ/2qYXU3q5wR
         rRy4H5xs1rPUtOLmhSpxEQmlWvSS868It/ttzclfuvPX3f5beJm9dkF5BVJPQvt2ndD/
         OOoynhQxFwuxRsdG0rdSBergfka9xQiV+xqm2A/W3nM8WWrei+CB/EoF/apSoZAZrDa2
         9RGd7FXIxgpI/DBvJ80MkpLiS0UI1JWVUMD9EL4wmiQSBrpDQVjfkLAclYv/p0xVC6d1
         AnqD14/QxVcHySGwALEWqMGWUAven7hGlXp/xRGeNzQjXTitUoHBWJ3NKzt+JkmNiYlN
         qOrw==
X-Gm-Message-State: ABy/qLawDcZcNB31XKItDyANZSf1VjJ1NJA0+K3wofLTLfdrKmACWt4F
	8FbE5nhpteyIop2QCQ/jGxPoaU2DZLun1uiO/SCdyiYObP/5
X-Google-Smtp-Source: APBJJlEF5a3l1q7Wnrn+Ygt2UYSCsqfnQ8ezPqLr8UHxZeYV97v5qZaRe7f38JRnFSGZ63a8P8cKE3iXGLlQaD1gk2cabNkj/en5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90b:104d:b0:263:3437:a0b0 with SMTP id
 gq13-20020a17090b104d00b002633437a0b0mr3469094pjb.3.1688206500959; Sat, 01
 Jul 2023 03:15:00 -0700 (PDT)
Date: Sat, 01 Jul 2023 03:15:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc19d705ff6a34b0@google.com>
Subject: [syzbot] Monthly bluetooth report (Jun 2023)
From: syzbot <syzbot+list7e4ace863c2ed3815e4c@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 2 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 53 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7085    Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  3793    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<3>  1152    Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<4>  1055    Yes   INFO: task can't die in __lock_sock
                   https://syzkaller.appspot.com/bug?extid=7d51f807c81b190a127d
<5>  95      Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<6>  42      Yes   WARNING: ODEBUG bug in put_device
                   https://syzkaller.appspot.com/bug?extid=a9290936c6e87b3dc3c2
<7>  4       Yes   general protection fault in hci_uart_tty_ioctl
                   https://syzkaller.appspot.com/bug?extid=c19afa60d78984711078
<8>  3       Yes   general protection fault in l2cap_chan_timeout (3)
                   https://syzkaller.appspot.com/bug?extid=f0908ddc8b64b86e81f2
<9>  2       No    KASAN: slab-use-after-free Write in sco_conn_del
                   https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
<10> 1       No    WARNING: refcount bug in sco_sock_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=c689847e27e0fa3e7a5d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

