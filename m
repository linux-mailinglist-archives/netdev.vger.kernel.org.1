Return-Path: <netdev+bounces-14564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3387426A2
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 14:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7F41C20A85
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E3723C4;
	Thu, 29 Jun 2023 12:39:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0B2565
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 12:39:00 +0000 (UTC)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B31730C4
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 05:38:59 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1b07f55975bso800883fac.1
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 05:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688042338; x=1690634338;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ri2JYlOaYtHZafIZo32KQWGFk/pE2ILLD0nllNwVvcY=;
        b=AXj9rZKhGcG3VkiGYu1Hd2H1DLq3mPqxZXPtULAdq+ccFi1r4vPGHvTzu51EWZAXHs
         /cCYATFKu7eF/Z2vVS7dpSEi19Yk9Xuez2Y2TKqJVwehVC77XQ5pW3GfthBNL1bbgvFN
         EIkL/YaU4fYuD9MirBBYW7jJ317SkGWWkaVVnw8+tTS9gt97joBLcr7Fvnr2420MBH0z
         fG/RTUkFs+blW8ViDBaUn/hu5Gb7xuQEU6tPz4GHFguw8JlVUVGaPhFLLoXx7zPqg0se
         t/wp75onqWXTdbF2bCepOADjhryIN9yoZtLrVrBJt/01oFAsSsYnN4ot96XXNnyVwCj1
         F8Jw==
X-Gm-Message-State: AC+VfDwHVFUHs2k0rQJBiP24LPTEvvzD++/KFB8IJPJegWErqScNJg1L
	2OBagN2bPPtL7pQvLSoqPz/9v09VjcwtQquNIQyJocAyiNzs
X-Google-Smtp-Source: ACHHUZ73ccHNHkmGrMMtxxSN3oXu2sgCguKlQYncB65UvJPrG+qPRGx7VoGLcr1d4BraqUGMopM6mznJ+zSjV7rFkTz1912DUf+B
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:ed8e:b0:1a9:85e9:9376 with SMTP id
 fz14-20020a056870ed8e00b001a985e99376mr4008056oab.0.1688042338607; Thu, 29
 Jun 2023 05:38:58 -0700 (PDT)
Date: Thu, 29 Jun 2023 05:38:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f56b8d05ff43fb21@google.com>
Subject: [syzbot] Monthly net report (Jun 2023)
From: syzbot <syzbot+list6f38086e094c5ae7bf42@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 8 new issues were detected and 15 were fixed.
In total, 78 issues are still open and 1279 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6422    Yes   WARNING in dev_watchdog (2)
                   https://syzkaller.appspot.com/bug?extid=d55372214aff0faa1f1f
<2>  3717    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<3>  838     Yes   INFO: task hung in switchdev_deferred_process_work (2)
                   https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
<4>  516     Yes   INFO: task hung in rtnetlink_rcv_msg
                   https://syzkaller.appspot.com/bug?extid=8218a8a0ff60c19b8eae
<5>  431     Yes   KMSAN: uninit-value in IP6_ECN_decapsulate
                   https://syzkaller.appspot.com/bug?extid=bf7e6250c7ce248f3ec9
<6>  424     No    KMSAN: uninit-value in __hw_addr_add_ex
                   https://syzkaller.appspot.com/bug?extid=cec7816c907e0923fdcc
<7>  326     Yes   WARNING in kcm_write_msgs
                   https://syzkaller.appspot.com/bug?extid=52624bdfbf2746d37d70
<8>  249     Yes   KASAN: slab-out-of-bounds Read in decode_session6
                   https://syzkaller.appspot.com/bug?extid=2bcc71839223ec82f056
<9>  193     Yes   general protection fault in scatterwalk_copychunks (4)
                   https://syzkaller.appspot.com/bug?extid=66e3ea42c4b176748b9c
<10> 172     Yes   BUG: corrupted list in p9_fd_cancelled (2)
                   https://syzkaller.appspot.com/bug?extid=1d26c4ed77bc6c5ed5e6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

