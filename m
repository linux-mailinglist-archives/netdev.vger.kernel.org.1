Return-Path: <netdev+bounces-55717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32C280C0B9
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 06:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9DC280C03
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 05:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8FC1CAB9;
	Mon, 11 Dec 2023 05:37:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03BFE3
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 21:37:07 -0800 (PST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-590b580ae39so2264734eaf.3
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 21:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702273027; x=1702877827;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJbhLWpc9OcAqNfWslnsCcj4qPU1N90g91QqdKjuBf8=;
        b=T26NPrf8XfxdcFHsnFmYlfVkTnW9dZw3hwQ5OSiH+u00nGxeL750nxR5WZxs6jV0i4
         +tNs/9GFq4B+fSj1DJQcNM0B/FFAlka6pwOiGxxIusj1f3UmzjvsRG0yChaJEhhS7r2S
         XdA0DLmCBR6UxA+XiRe4BKS8m3VZeoSjQkuCtpYmNMi+M+KmgmvBPgz9blyEzs4g/0a2
         NLi5mu4vAzaEJtKB5nA6YypAvKVOMZnsvdIp7gCOHjKrQxPltz7BjoE1VTotF7xnDi5J
         FdePxQxuuFvAjCuQwF9CKiMlik98hp3aTU+/DfUEFWl/1dZI1oJjlZSN9wGAc0/J5TvV
         adtQ==
X-Gm-Message-State: AOJu0YzkbJsM3LPNpFqODdGluurOfuV0U9+Fm20j4SZN5A1RMQcUA0R9
	8mDnM3aL21KTq25XTMg2mikYtVeMW5AK/Pil/LyN7LdtYSxS
X-Google-Smtp-Source: AGHT+IF0QKBJHNms6LBgAbPwdjaDNpi+9qFHPWR90i5Swotv9xAtzPKQBk0NY3XZAQo+zgWzoWm3AGQ20nIPV55fiqKeJNgwSrc3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:3146:0:b0:590:7a45:da4c with SMTP id
 v6-20020a4a3146000000b005907a45da4cmr2707681oog.1.1702273027022; Sun, 10 Dec
 2023 21:37:07 -0800 (PST)
Date: Sun, 10 Dec 2023 21:37:06 -0800
In-Reply-To: <000000000000ffc87a06086172a0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000162818060c3553cc@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in ptp_release
From: syzbot <syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com>
To: davem@davemloft.net, eadavis@qq.com, hdanton@sina.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, reibax@gmail.com, 
	richardcochran@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 1bea2c3e6df8caf45d18384abfb707f47e9ff993
Author: Edward Adam Davis <eadavis@qq.com>
Date:   Tue Nov 7 08:00:41 2023 +0000

    ptp: fix corrupted list in ptp_open

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=145ba76ce80000
start commit:   6bc986ab839c Merge tag 'nfs-for-6.7-1' of git://git.linux-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ffa1cec3b40f3ce
dashboard link: https://syzkaller.appspot.com/bug?extid=8a676a50d4eee2f21539
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cc14a8e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ade40f680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ptp: fix corrupted list in ptp_open

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

