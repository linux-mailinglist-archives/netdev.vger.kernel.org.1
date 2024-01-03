Return-Path: <netdev+bounces-61157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2160E822B92
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 11:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C231F285429
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 10:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9E318C3B;
	Wed,  3 Jan 2024 10:47:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F018E14
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35ff8e2aa19so137774405ab.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 02:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704278841; x=1704883641;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/q3fX7yfr4+OxT/fgvLyZ0FBGYrlGsDU4PTbrFMXMU=;
        b=S/x6xfIhX7ok3QMv+WxvJMOh5isfFGph46h4rSkJnoebHk6HvZaxEWa4W68VBTWqdr
         slrSHeI/TUnC1sVls6pd0Gew6UCo617dojL5ZL328katRUQqpm8KATQK9OQ1U9+pN+xk
         PcPGVp9yL3nd/ZtKrRMRKYDJcNjaufhT8yF2y+zsN17LUaF38QJkmPQ2YmeYudVGAqEG
         /WHTp14MoLrln2RY97ARaaSUAE3+EIVP/rIIVZHw8iLKkLJExy8OW1ucigI3jLXasEN4
         Liv6oXdH0y/uI+dJUJ5uFsH7tXwlL4nD8oAW4tfmqttVp9J4seF5LkGZcMKy9nl4d9N9
         UvOw==
X-Gm-Message-State: AOJu0YwBEcpyVzdkPqAoMOEBZk0qro8NuEi+5FGk8GLQJejH3l2T5Flf
	n1FA/AEY8Pqt3WrW6MybGeGCu9F+R9ldnW53rKvhvDQuNOzd
X-Google-Smtp-Source: AGHT+IF+FHvBiFwTjzjx9Sl+fixAoS3nuebFzJcxhwO8WYaTRSv/XaTiDQiVzT4ZY+vs8TKQ/L+uZlA6cALEF5IwX/UhPcRY/XBS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2d:b0:35f:f683:f817 with SMTP id
 g13-20020a056e021a2d00b0035ff683f817mr2185154ile.5.1704278840869; Wed, 03 Jan
 2024 02:47:20 -0800 (PST)
Date: Wed, 03 Jan 2024 02:47:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8ad89060e0856f8@google.com>
Subject: [syzbot] Monthly wireless report (Jan 2024)
From: syzbot <syzbot+list2ced74a42cd2d7138cf6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 0 new issues were detected and 0 were fixed.
In total, 30 issues are still open and 119 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6261    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  4378    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  3715    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<4>  2836    No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<5>  842     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<6>  744     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<7>  507     Yes   WARNING in ieee80211_bss_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=dd4779978217b1973180
<8>  65      Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
<9>  46      Yes   WARNING in carl9170_usb_submit_cmd_urb/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1
<10> 38      Yes   WARNING in ar5523_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=1bc2c2afd44f820a669f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

