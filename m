Return-Path: <netdev+bounces-21726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9215764747
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7AB281FFA
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 06:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21E7BA43;
	Thu, 27 Jul 2023 06:53:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A43C16
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 06:53:43 +0000 (UTC)
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C0326B8
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:53:41 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-56768da274aso1136408eaf.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690440821; x=1691045621;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/jtX+SLT8ZNWdrA+Z3ciysS69lKVgG1Od2heohuNHA=;
        b=N0cChNbsZvLh9qfWHwpOoss/Jo0iw1FwTVkKHllKc77is8v14K0xHeOfd2ZOtftJ5F
         enBCPvU3thlnl8HkGlDII72Isu8aZkKpEzQpQTzfb8VHIXtin9qnlSyK5vn9SpL77rd4
         G1sgQLVdwMl1/Agm84Du/UZ18IxAzgIu84h4/cvsBPMHN+8+T2A3GF6mjospWAhCjlCi
         gVotny8b8EAu35Qrisd9tfu5olrM0mbZHRPpRe27xpkc5cogA/Te3vthHDjkxXJt12rk
         eLJtab8yStxuNYTN+18e29yZ2n7aoznjYFPkLB55k6rkd8FSes8hXL3zsRSGm7F/K4h7
         WKxw==
X-Gm-Message-State: ABy/qLZxSpjkHPNR9Trrl6q+p9Bn2R2+5WEREmhQinCjHFtx0AZAadED
	wrPND/5Xo+tuKL4oJ0+HmiuhcHsbsJgP1Smm3jwMj7Jx8bKk
X-Google-Smtp-Source: APBJJlF2na5TM7DdbhtaIyNBRisOAh+2TTguu02KW7Ut5goTUpZr7zOGmkRcViS7vt1DCKrpF/5rGE47zyv/84Dex0FgO494eVpn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:21a0:b0:3a1:e58d:aae0 with SMTP id
 be32-20020a05680821a000b003a1e58daae0mr4375306oib.3.1690440820847; Wed, 26
 Jul 2023 23:53:40 -0700 (PDT)
Date: Wed, 26 Jul 2023 23:53:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3fa6a0601726caf@google.com>
Subject: [syzbot] Monthly wireless report (Jul 2023)
From: syzbot <syzbot+list84f2b8b519927d59bce1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 5 new issues were detected and 0 were fixed.
In total, 37 issues are still open and 106 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7904    Yes   KMSAN: uninit-value in hwsim_cloned_frame_received_nl
                   https://syzkaller.appspot.com/bug?extid=b2645b5bf1512b81fa22
<2>  6500    Yes   WARNING in ieee80211_bss_info_change_notify
                   https://syzkaller.appspot.com/bug?extid=09d1cd2f71e6dd3bfd2c
<3>  4787    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<4>  4223    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  1571    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<6>  1361    No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<7>  808     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<8>  737     Yes   WARNING in __rate_control_send_low
                   https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
<9>  666     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<10> 475     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
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

