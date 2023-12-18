Return-Path: <netdev+bounces-58610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 484EE8177C3
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 17:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6A41C240BF
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F681E520;
	Mon, 18 Dec 2023 16:43:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51C1E4A5
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35f49926297so55789425ab.3
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 08:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917803; x=1703522603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEnH9DOn7htdFLxlz85xz/DnYEHpLVOwxdzfKYN97ZE=;
        b=IKDgACVAd3r96s4crH0BgP/+eR1eUbg6F4Na18EjraUe6+U4W2AyBgUOKwEYxYnmCA
         F2MfXByWEl1tDv26E2Sz7OVLQ9UXXDarstrcu0kVXwDY/p+rGv/0WtWGdOOQmyF1x2r1
         s8rFckXTDmt2M7VBv2uTfU6zOtLGce5YU67QdCZOrnZQ/SmFFAMaqPlhK7/teiC9mqzU
         skARCPXMU4qHPr+cU963H6ltxULP5SBJ1NiAE5ClNynqKg3BB5MeIpi1HRz9L1Eyosga
         dIs+7ydBDLDQUNcjYDebRP8mTH5FUc4ctDWfYNO2GPLsPlsCht6W8EPR6ynSAlplsWPd
         mZMA==
X-Gm-Message-State: AOJu0YzKGSG11X9b5zF2NYrrXYg4Znm+c03Npb0wniWEUenyX1cprVrq
	oitdqktwrJrhYm0Xmi54HZIbwjYjEd1/OSaP3joF6zsZ6V9T
X-Google-Smtp-Source: AGHT+IF4wvXEHfOc3ZSuANzi4m1bDvhjZf71Zka5lYRnL4qoOZz98UZyuXVBY4Vn79HA0t8E0W2CAZ+Cjrxd2RVUVEhZVH+Guf8E
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:338d:b0:35f:b2f8:6ca3 with SMTP id
 bn13-20020a056e02338d00b0035fb2f86ca3mr250224ilb.2.1702917803210; Mon, 18 Dec
 2023 08:43:23 -0800 (PST)
Date: Mon, 18 Dec 2023 08:43:23 -0800
In-Reply-To: <000000000000ab8015060ad3f9bc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be00ba060ccb7291@google.com>
Subject: Re: [syzbot] go runtime error
From: syzbot <syzbot+b8bbc03ee7bf80fc9f78@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    610a689d2a57 Merge branch 'rtnl-rcu'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12ded821e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df5e944701db1d04
dashboard link: https://syzkaller.appspot.com/bug?extid=b8bbc03ee7bf80fc9f78
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16da084ee80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1698c13981a/disk-610a689d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21213e55dd47/vmlinux-610a689d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f85e89cca69/bzImage-610a689d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8bbc03ee7bf80fc9f78@syzkaller.appspotmail.com

fatal error: Connection to 10.128.1.63 closed by remote host.


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

