Return-Path: <netdev+bounces-14040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C9373EA75
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 20:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACFA1C20621
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 18:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5A810973;
	Mon, 26 Jun 2023 18:49:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092A46B6
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 18:49:56 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B8D10DB
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 11:49:53 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-778d823038bso255893139f.3
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 11:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687805392; x=1690397392;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IuXXxOMOQsKpH0IiTxt7W05d750a7OWAfC/BfXgyHFU=;
        b=OvAJTNWS1jVTpV0hJWQiSkIz7g231xlBPeIrJwc5OYsSzLS9dt+Imti3JIeNxkUdfB
         wbYs5dwydMqar1bLXKi97KLQ91PHh30sf1punqHlohI1tfxEUvX0OUIfMgL3lvLqqRUn
         c068DjIpDS/9MnJsKRoxs9qqsT164P/ZhD7cXpkoKzGnG1Ls9BU3UVuW1tIw2rCO1lQH
         q8M5WT2BVt0SY1REtrdbm1Z5SrUHoLeGvub6nwQfGMPmZH5CWS0uN1KlqScnETnrSypE
         Hc9EW0VvbohLrq3Uj0OglsTzFHTkhyrsS2FlVasSoO3HrSUCWxMFK01Ts4HPNLSKp9MG
         RVNA==
X-Gm-Message-State: AC+VfDxtanxNT6hXsFMooFAKMxndDnTC/b63avBvjwIM/ZwWPBz6CVts
	PWNhciEbvxqlnVLw4I7iLVfDgB+0YVCrkz8q8pNmVXf2epmj
X-Google-Smtp-Source: ACHHUZ4jNMF2H4NMBFXcMoi3KjwvDlE7FzKi0KvJYnVZN7j0pe3t0HHmF8KlJKQ+186eCZmTGXCCgL0fL+geiRaEYiIdq8lPswZ4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:7113:0:b0:780:d446:a209 with SMTP id
 q19-20020a6b7113000000b00780d446a209mr4307414iog.2.1687805392498; Mon, 26 Jun
 2023 11:49:52 -0700 (PDT)
Date: Mon, 26 Jun 2023 11:49:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000deb56005ff0cd0cc@google.com>
Subject: [syzbot] Monthly wireless report (Jun 2023)
From: syzbot <syzbot+list6f49fd7432bc9a1abef8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 0 were fixed.
In total, 33 issues are still open and 106 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7542    Yes   KMSAN: uninit-value in hwsim_cloned_frame_received_nl
                   https://syzkaller.appspot.com/bug?extid=b2645b5bf1512b81fa22
<2>  5766    Yes   WARNING in ieee80211_bss_info_change_notify
                   https://syzkaller.appspot.com/bug?extid=09d1cd2f71e6dd3bfd2c
<3>  4308    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<4>  4188    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  1163    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<6>  1136    No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<7>  806     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<8>  669     Yes   WARNING in __rate_control_send_low
                   https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
<9>  640     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<10> 416     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

