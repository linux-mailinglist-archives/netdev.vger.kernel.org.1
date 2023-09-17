Return-Path: <netdev+bounces-34329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB237A33BD
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 06:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07451C208E1
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 04:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5F1373;
	Sun, 17 Sep 2023 04:59:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CAE136F
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 04:59:46 +0000 (UTC)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AC9195
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 21:59:44 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1c8f953e111so5904446fac.1
        for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 21:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694926784; x=1695531584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhjs5oB6nHi9MI2ElOnnGkx1j5k5OVubLeOM7LmB94I=;
        b=CZL9Q6hS6EnIEDm8ZyUg2yewKVroyKDyRMoLmmcVloJfexdk8ESmcC2ZS7mfMLYHyZ
         urWG1HkZIL3wcNJH1Jb+zgGS3xFNdHP5lvTmLIhTgKd7xXxpC3RKxC9Wr5jVXFcNCqFM
         ANGTRXwd2EEZTItI3225d4mYY73Rl5/McEEf8USic00wpkqe43GZQohAnihxgfYMBWBH
         XNZ7u7GqqwXHleWhvu7BPMbjjSINTgV486JU0OljB60sWEHYXX5OL2ankrdeSFtIHrGo
         IbiPZrTUE1yNitFLutobyTzzunDLsjEsbesDhFxCfRackgi5oh2dxv+sugCZ0s8r+fZB
         85Sg==
X-Gm-Message-State: AOJu0YwC8au+CWBHSgnjhFZRR6fTt5hUU6QWzeHbBkYduLGxRQV38+zM
	2rBOeEfvEjZd7o0wzYgn6kbv2AR6jO3sRc71pon5FJUFXMtM
X-Google-Smtp-Source: AGHT+IEnRt6ieGV5LcPDf5SE4daLegAon37/uUhaCG0SHEvQeQTLeUYVwdxbjdY19HkbVtDc5f8aY7qAsAB0BGRIQuCivmzo2vje
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5155:b0:1d0:ce36:3f0f with SMTP id
 z21-20020a056870515500b001d0ce363f0fmr2193610oak.10.1694926784344; Sat, 16
 Sep 2023 21:59:44 -0700 (PDT)
Date: Sat, 16 Sep 2023 21:59:44 -0700
In-Reply-To: <00000000000011da7605ffa4d289@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6b834060586e462@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_cmd_sync_submit
From: syzbot <syzbot+e7be5be00de0c3c2d782@syzkaller.appspotmail.com>
To: atul.droid@gmail.com, davem@davemloft.net, edumazet@google.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	rauji.raut@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit a13f316e90fdb1fb6df6582e845aa9b3270f3581
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Tue Jun 27 00:25:06 2023 +0000

    Bluetooth: hci_conn: Consolidate code for aborting connections

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10885e54680000
start commit:   bd6c11bc43c4 Merge tag 'net-next-6.6' of git://git.kernel...
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12885e54680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14885e54680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=e7be5be00de0c3c2d782
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bd8168680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f4d048680000

Reported-by: syzbot+e7be5be00de0c3c2d782@syzkaller.appspotmail.com
Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

