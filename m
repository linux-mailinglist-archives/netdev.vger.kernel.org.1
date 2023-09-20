Return-Path: <netdev+bounces-35348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD377A8FA6
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 00:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14405B20AF1
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 22:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7B3F4AD;
	Wed, 20 Sep 2023 22:54:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3623CF
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 22:54:48 +0000 (UTC)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D766E0
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 15:54:46 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6c22d8a0cecso479472a34.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 15:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695250485; x=1695855285;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2g79bcICkCCHdQM90cMC4akmu6VrqB/gBv3hd+fNQRM=;
        b=Ddhi3lY8LMsFArptFgorY3bPjawrbGFeVyzCEfqIl90HJws3prjxZ7PUno+4Nt8mSv
         Gz9x78SRq3T1/r/DOC96x+owJA6n86gemJTmIhl/rfvID6tMNwm1rsR90Y+QTKRnN1gs
         eqq89zSpl00MiZJ6h7xPP/9sV/3n40694F5QqLH0OhdZdE+hP24s6tm0w7q1HyXkaOsZ
         BvZJVAmVBxmmLhLhkq5dOHt1Og6HXpwgVgw/VEd/Aej+Don9I87Awp7/Bd/d4JUyZSgg
         SkCBkDeX7iVihFcthg2GDaPpb4azv6B+nES5F4jw03x2ovg4/S4KQJGMIF4kYAwS38Ch
         KEzA==
X-Gm-Message-State: AOJu0Ywq3S0S7Iot7+T6SURFhaz4Yn3Cbg/I+YtpzmeE/gE7NwhF+iBb
	yddpv07bXrdPMj/aK1wwtxgkRA/ty1Q8ZCXScbBYt8w59k8G
X-Google-Smtp-Source: AGHT+IEikjJmvx8UO8IMdN6a+9RMgVvnMxyC7pr1mrFDzf2WyUEBC1kduMH0LqlxWiVKOiNJ+Pk+swZS+bvkmRPzA6YhkYbkeqDB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a1e:b0:3a7:9a19:332b with SMTP id
 bk30-20020a0568081a1e00b003a79a19332bmr1845061oib.7.1695250485411; Wed, 20
 Sep 2023 15:54:45 -0700 (PDT)
Date: Wed, 20 Sep 2023 15:54:45 -0700
In-Reply-To: <000000000000a91cfe05fe5161f2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd0b980605d242ed@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in __hci_cmd_sync_sk
From: syzbot <syzbot+c715e1bd8dfbcb1ab176@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	iulia.tanasescu@nxp.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit 2e846cd83f6285f4fee49389954b1b1215f5e504
Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Date:   Tue May 30 14:21:59 2023 +0000

    Bluetooth: ISO: Add support for connecting multiple BISes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15636364680000
start commit:   1f6ce8392d6f Add linux-next specific files for 20230613
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17636364680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13636364680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d103d5f9125e9fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=c715e1bd8dfbcb1ab176
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11287563280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14395963280000

Reported-by: syzbot+c715e1bd8dfbcb1ab176@syzkaller.appspotmail.com
Fixes: 2e846cd83f62 ("Bluetooth: ISO: Add support for connecting multiple BISes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

