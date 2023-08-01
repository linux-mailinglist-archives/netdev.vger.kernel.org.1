Return-Path: <netdev+bounces-23209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B68B76B53A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7611C20908
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2EC21512;
	Tue,  1 Aug 2023 12:53:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D79111E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 12:53:58 +0000 (UTC)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7D41FFA
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 05:53:55 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b9c744df27so8281210a34.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 05:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690894434; x=1691499234;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXkmaYf5tXy5j50g7sEW2BuzKwkNesay0LWlLWoEmWk=;
        b=SdFRLQwXMexJ6X4OPnu428J2U9x8qZjJEGCm3SAcqwEBOt3CpV0ivuBC1wBPa5ECcM
         2P01/EZzOwgKmGI5e1b/GYRfLAkyPC6LnDHTGL3vXuzVxscdyPtP7sISTrhKB6ekstmQ
         A4tgHe9BEjgC04mHlkW9ABTt5FEqlnjla609J2MLa74sc5lfyZTl5fEIdLVrGlcHXMIU
         DKgNUGNwvCId4Sj+l4jhhi3Y081tg5LyyndB52uEscPnN9D1x+cF0ngb5gk30uV/ZCwz
         C1+qqL0EnQ/2tFAMSl1raxZO155wxhjxLo4YbYotKV/zXslnHTUcDpTUF8Ygw5ohetEH
         eBdA==
X-Gm-Message-State: ABy/qLYOPYzTcFiWxTm416Fc/Sx0IfDbTAiXSc+M8RPR+SPzwVRCprHH
	u0R6eg2RwbVwyydbW7W8AC7mBmahk9zT0RP+z0uL74rk5DZ+
X-Google-Smtp-Source: APBJJlFx+S8TUW9amn8723Qny6AA88PAtaox80E2FpGvz9wNeR2k2mOPGDFhOOgVXvE3PyZTEXy97vPy+RQPhyTV1Z3eGBsED8em
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1605:b0:6b9:1768:b318 with SMTP id
 g5-20020a056830160500b006b91768b318mr14062019otr.5.1690894434536; Tue, 01 Aug
 2023 05:53:54 -0700 (PDT)
Date: Tue, 01 Aug 2023 05:53:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f92630601dc0a7f@google.com>
Subject: [syzbot] Monthly net report (Jul 2023)
From: syzbot <syzbot+listd327a02095ed68308eae@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 8 new issues were detected and 2 were fixed.
In total, 86 issues are still open and 1285 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6491    Yes   WARNING in dev_watchdog (2)
                   https://syzkaller.appspot.com/bug?extid=d55372214aff0faa1f1f
<2>  3755    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<3>  1446    Yes   KMSAN: uninit-value in __skb_checksum_complete (5)
                   https://syzkaller.appspot.com/bug?extid=b024befb3ca7990fea37
<4>  868     Yes   possible deadlock in __dev_queue_xmit (3)
                   https://syzkaller.appspot.com/bug?extid=3b165dac15094065651e
<5>  846     Yes   INFO: task hung in switchdev_deferred_process_work (2)
                   https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
<6>  552     Yes   INFO: task hung in rtnetlink_rcv_msg
                   https://syzkaller.appspot.com/bug?extid=8218a8a0ff60c19b8eae
<7>  528     Yes   KMSAN: uninit-value in IP6_ECN_decapsulate
                   https://syzkaller.appspot.com/bug?extid=bf7e6250c7ce248f3ec9
<8>  529     No    KMSAN: uninit-value in __hw_addr_add_ex
                   https://syzkaller.appspot.com/bug?extid=cec7816c907e0923fdcc
<9>  364     Yes   BUG: MAX_LOCKDEP_ENTRIES too low! (3)
                   https://syzkaller.appspot.com/bug?extid=b04c9ffbbd2f303d00d9
<10> 348     Yes   INFO: rcu detected stall in corrupted (4)
                   https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

