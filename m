Return-Path: <netdev+bounces-32198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4277936F1
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 10:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C601C209D1
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E8ED8;
	Wed,  6 Sep 2023 08:12:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2852EC7
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 08:12:23 +0000 (UTC)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBCD137
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 01:12:22 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-573d44762e4so2138269a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 01:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693987941; x=1694592741;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82QbnuFy0EG0LHvViiB2pXG0FDTbEfXV795Uy9CoPro=;
        b=l6HjRVKAj8lddhTfeBbB7i2GJi9DPJ2cgB+r/eIhCwGbpMvJzGTDCfP1SEoQfWU/H6
         bEqwhs4zkmEak+NnXneYu6aLHG2ewr2CwA2Pl2JO7VY3IrjBL+XRYVeVc94H5i6lCBsz
         XeWcGhzsx9bM+7u6T1QC4S9+hLNE0fll/uzYovm3zSmaYv1Ka+CubnQw6nDJY48qEU4t
         2U+65IypUQmro+3ac1TfDcUMTOoaOH7IS1VzLt7cEPR7SgM91wPM1gPCfiThQqXA1FwI
         uPI+8xuaNnfPFFlPJ3M4Q1VnYr3t3DTlPy8tZiLTgbnO0X1d1G6di9xcL8wCfTKJ4OlA
         ALSw==
X-Gm-Message-State: AOJu0YzBULC44ewrqczcC6F79RXWF1gX57YNT96gDo920EFH/ZWJvY9b
	tTyMadm1jlCUVFEO+MqjLxfvV9jfN4CFtWeA/lydRq1CxLva
X-Google-Smtp-Source: AGHT+IFNGU5TT6CxawjWlseoIlyLhWlP63rGBeA4IMzVD5wYi5s962I+x/MChTRS4Q06+DoQtmBfanYwykGUTiRMfXs9ldC5c0aR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:d48d:b0:1c1:3ba1:b635 with SMTP id
 c13-20020a170902d48d00b001c13ba1b635mr5477345plg.4.1693987941534; Wed, 06 Sep
 2023 01:12:21 -0700 (PDT)
Date: Wed, 06 Sep 2023 01:12:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008253550604ac4d36@google.com>
Subject: [syzbot] Monthly nfc report (Sep 2023)
From: syzbot <syzbot+listb569d2a8a4e132119665@syzkaller.appspotmail.com>
To: krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 13 issues are still open and 17 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 585     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                  https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<2> 116     Yes   BUG: corrupted list in nfc_llcp_unregister_device
                  https://syzkaller.appspot.com/bug?extid=81232c4a81a886e2b580
<3> 106     Yes   BUG: corrupted list in nfc_llcp_register_device
                  https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
<4> 80      Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<5> 16      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<6> 5       Yes   UBSAN: shift-out-of-bounds in nci_activate_target
                  https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
<7> 2       Yes   memory leak in skb_copy (2)
                  https://syzkaller.appspot.com/bug?extid=6eb09d75211863f15e3e
<8> 1       Yes   memory leak in virtual_ncidev_write (2)
                  https://syzkaller.appspot.com/bug?extid=6b7c68d9c21e4ee4251b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

