Return-Path: <netdev+bounces-50317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4547F55CB
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1900BB20E1E
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456D117C4;
	Thu, 23 Nov 2023 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F013191
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:17:06 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c27822f1b6so416390a12.2
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700702226; x=1701307026;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5oBx7EjQL2+FbBjMi5y16gf4kuvyAnZ3JgFtexzBUA=;
        b=G4h30BZ7Hpz7J+C1R3T1zp/0aqQM1bD/YZXiVxzKqFt/AJLdE1NRum3loRfma+N5+b
         r9+JpajKFQYF048WDedh51w/7STx6ZdJACV4B7pc9m+W+Kr7kdrcUPIJZR/sM4/j6zbr
         FgPt2BBSkKO4AIfZSwjbDsYCDuN92PDGTmTRR0l1EpTYQOjo6CAcUE9DZCfjFGM/MIjt
         qV6Ej1YEPQBqxmXeZBZsA3juqu06K8Q6Jb2T86zAXdgvUFZV1Nefuz9Wld6euWCQ1R8h
         FY0zNge4D7HzqUn1+x+0hUHYZEn+IqQEsM643plx0wtIOj2gKvkWzrI8WTgUogU9DYPx
         2g8A==
X-Gm-Message-State: AOJu0YzYEekyYT5+lBCKTwYDzZp5ByA0PclY64N8KzOMkHZbwR6GxO4B
	7yXGoGem0dyxkss15XDPnOdi644LE3FBazqPft/9J80rZHl/
X-Google-Smtp-Source: AGHT+IGXO5tqvvyFWeJuKfwoIvQQp80K0szbB+GMH4jb8p0owJcdFApPgUPNAO08rqecCguHLqOIIprIGXF+tKVG4F2v1Pote9Tj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:bf10:b0:280:cd15:9692 with SMTP id
 c16-20020a17090abf1000b00280cd159692mr916159pjs.6.1700702226078; Wed, 22 Nov
 2023 17:17:06 -0800 (PST)
Date: Wed, 22 Nov 2023 17:17:05 -0800
In-Reply-To: <20231123004834.58534-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000de140060ac798cb@google.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_incoming_options
From: syzbot <syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matthieu.baerts@tessares.net, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com

Tested on:

commit:         c2d5304e Merge tag 'platform-drivers-x86-v6.7-2' of gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16f3d6c8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e32016b84cf917ca
dashboard link: https://syzkaller.appspot.com/bug?extid=b834a6b2decad004cfa1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139ddc4f680000

Note: testing is done by a robot and is best-effort only.

