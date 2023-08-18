Return-Path: <netdev+bounces-28707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C120780521
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 06:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A696A281602
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 04:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2AE65E;
	Fri, 18 Aug 2023 04:39:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19AE624
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 04:39:38 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03E73AAC
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:39:36 -0700 (PDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bbb97d27d6so7181505ad.1
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692333576; x=1692938376;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvFwXjLMYeqdlXwre0HE3uWwxv+R86ki6i68P3Vs0+0=;
        b=BkwQtKp66ylSpGe/FOwOSLHBovXM3e5WZUFd3k2+TlLiJ5hq39e2N2gug0PQ+DWeqJ
         lBbSf3350C8vAwwnyHJ49rlex9hAQ80oG982bXUBiTPU119hTBDpMxsFIZqsu40F88Gs
         yTYADe0yfjRhYCo/Pa2ExX3G2tYOCEvEe6iorMzITnyM43rBqfhs15FFmGYhOZkIVDxo
         9ZfWOIsBAK8SqCxa+8NMRfM/Gv9Kk5I7TOd7H6BW6zosaT+wOuJkW8ZKl4mm9lA3SIL6
         tqZtZ+X+xZo2w6wSxDrHrqAWqMYZ9PwgkY2vW+akqxgdLaiGQbX913MxqkGSyAkVv5tb
         GmFA==
X-Gm-Message-State: AOJu0Yz/Y02mtDX3tTo3A02lHWCIg4wP+o1bqBHOIv5SGfgRgU96mM4Q
	I4EIxHgcML3mRshNV+n/eMt6ZAWgfazlXTQIm7QbH+mvhH6v
X-Google-Smtp-Source: AGHT+IEOWZ9TR7uxnnrr5o2vN1zMwhChrSWkI3uvdoJ384ju6Mbmly2riQQtj6/6k2K4DgTVbAMNubudY8qv1xdOJsYBGe16jePd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:da92:b0:1b9:e8e5:b0a4 with SMTP id
 j18-20020a170902da9200b001b9e8e5b0a4mr573998plx.8.1692333576338; Thu, 17 Aug
 2023 21:39:36 -0700 (PDT)
Date: Thu, 17 Aug 2023 21:39:36 -0700
In-Reply-To: <00000000000013b93805fbbadc50@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8c57a06032b1dd2@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_chan_del
From: syzbot <syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lrh2000@pku.edu.cn, luiz.dentz@gmail.com, 
	luiz.von.dentz@intel.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, pav@iki.fi, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit 45c37c4e9c9aab5bb1cf5778d8e5ebd9f9ad820a
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Aug 9 23:49:33 2023 +0000

    Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1331e265a80000
start commit:   47762f086974 Add linux-next specific files for 20230817
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10b1e265a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1731e265a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed03cf326b3ef94c
dashboard link: https://syzkaller.appspot.com/bug?extid=cf54c1da6574b6c1b049
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1125bc65a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ce8f03a80000

Reported-by: syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com
Fixes: 45c37c4e9c9a ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

