Return-Path: <netdev+bounces-23208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFCD76B537
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE942818CD
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9295214FF;
	Tue,  1 Aug 2023 12:53:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE63111E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 12:53:57 +0000 (UTC)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42291FE5
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 05:53:54 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a7292a2a72so4574497b6e.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 05:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690894434; x=1691499234;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kl63Gzb61Dydiu/7gl5BZvq7Fhlv/XlBdavmlXqdJ5s=;
        b=HjHecENLu8D5IJUYgqbbyDAd6x1vArb5W79j5sFQH/IrmqdO8drGJtLyKHthLRMqbH
         /uIBC26cgl5jTjJRC3uM1lKKredcfSW/L8p2dZYlDkJDRwHxg4vD76n62JqErNH+hSB4
         n7oz8OlJi31TqR6IVHNRU+72IHeuLCL0D+AvuthRWFihWcEpHWwfcswVsV9Fwwazsmuz
         CVlh+Gp4tXQlqI55Br7w6zJmsajbaRbRwrg9PRPRuDBryJJIvYcDz1gZm4MwdOE0R74W
         ucyxO7PArg4uoO2icw/pqcm4aOxKZOPq65lmPfE6NtHzx3ThtaCnfZVxuKw9SsbcOjp8
         uVYw==
X-Gm-Message-State: ABy/qLaae+KWnpULgfKYozIvzjWOWufx4+4iXqQuKKJBklbAv4ApCbw5
	0aDctK8Khjkc0V/16dUg6Z1ZYkgnldyvpNK3SXtn1VEU39Hd
X-Google-Smtp-Source: APBJJlF3HUFaj3eoA8O4FcQaoYxY1IIGdKgTFUPzZiN4aLgBhuTBtJFeHII4iY1B9an2OEVtt28SEhCWcQZ+/lN8AJK3D0iBdNF3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:19a3:b0:3a4:2943:8f7 with SMTP id
 bj35-20020a05680819a300b003a4294308f7mr23752541oib.5.1690894434138; Tue, 01
 Aug 2023 05:53:54 -0700 (PDT)
Date: Tue, 01 Aug 2023 05:53:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001981210601dc0aa5@google.com>
Subject: [syzbot] Monthly bluetooth report (Aug 2023)
From: syzbot <syzbot+list513be271df212c03ceba@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 1 new issues were detected and 1 were fixed.
In total, 23 issues are still open and 54 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 8070    Yes   possible deadlock in rfcomm_sk_state_change
                  https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2> 4315    Yes   WARNING in hci_conn_timeout
                  https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<3> 1974    Yes   possible deadlock in rfcomm_dlc_exists
                  https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<4> 875     Yes   BUG: sleeping function called from invalid context in hci_cmd_sync_submit
                  https://syzkaller.appspot.com/bug?extid=e7be5be00de0c3c2d782
<5> 151     Yes   WARNING in call_timer_fn
                  https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<6> 84      No    possible deadlock in hci_unregister_dev
                  https://syzkaller.appspot.com/bug?extid=c933391d8e4089f1f53e
<7> 51      No    possible deadlock in discov_off
                  https://syzkaller.appspot.com/bug?extid=f047480b1e906b46a3f4
<8> 4       No    KASAN: slab-use-after-free Write in sco_conn_del
                  https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

