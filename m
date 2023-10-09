Return-Path: <netdev+bounces-39073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782177BDCAC
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33317281480
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7DAEACD;
	Mon,  9 Oct 2023 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F7E555
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 12:45:53 +0000 (UTC)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F9EAF
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 05:45:49 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1dce198f501so6865696fac.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 05:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696855549; x=1697460349;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3Btd45HSYspg37UVz5kf8AKflQJwBEWvOLEPH9XD0o=;
        b=ZsdClScpRNNvEZXrhL/HJzXoQAMB+uaX/cshCNgR7Z2sLFmgS97eOJX/MGFb6WkfJa
         n8Tmjel36Lcrc5/fIkaxLBHw2DcHd9IQsbXwlSNk+pdXW10WYC0nFoiFoMhAcQBN40VZ
         M30PJy+rEGbt82MWw+an3U4y2aZhbY1Qt4F85vhP62eY96ilCyX2gQhF47OMQ/z5sIuQ
         lrjOmsWQStj+14S6L93iLlteAUvxywLSyGcMQRbOIUbFP9yBzjtkN1pUvrx8ILSDd8G3
         MgsKTXV42XfTwxis7ATy6N3nhdh9CczS+xW5EGFC0yc1Y6C5k7jAcl4NKIg4sOENV6Ce
         iq4A==
X-Gm-Message-State: AOJu0Yy4cRmIm5ZpwZaVBzCoU99mDXdtC9iGIwhb5igTXglHHS6T/Tc5
	/qYbnnPHkLcOUFV8izEvl9Wx8r3rjRMtY7QAhG7ycdLrGzuH
X-Google-Smtp-Source: AGHT+IE6FHnOu20DiUtKUYMYBmU50TghxkobyRWf9WXCIwBq42uvssdaK8QAMd/BaHmp+cJDPTB/TAS9hgn9XRdZsXLFS3FjdGD0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a890:b0:1dd:7381:df7 with SMTP id
 eb16-20020a056870a89000b001dd73810df7mr5849236oab.5.1696855549158; Mon, 09
 Oct 2023 05:45:49 -0700 (PDT)
Date: Mon, 09 Oct 2023 05:45:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e2d84060747f87e@google.com>
Subject: [syzbot] Monthly nfc report (Oct 2023)
From: syzbot <syzbot+liste98df0070b1287198a66@syzkaller.appspotmail.com>
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

During the period, 0 new issues were detected and 1 were fixed.
In total, 11 issues are still open and 17 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 650     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                  https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<2> 442     Yes   BUG: MAX_LOCKDEP_KEYS too low! (2)
                  https://syzkaller.appspot.com/bug?extid=a70a6358abd2c3f9550f
<3> 122     Yes   BUG: corrupted list in nfc_llcp_unregister_device
                  https://syzkaller.appspot.com/bug?extid=81232c4a81a886e2b580
<4> 92      Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<5> 18      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<6> 6       Yes   UBSAN: shift-out-of-bounds in nci_activate_target
                  https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

