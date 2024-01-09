Return-Path: <netdev+bounces-62740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B83CD828E57
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 21:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B85628962D
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 20:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3083D577;
	Tue,  9 Jan 2024 20:04:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30703D572
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fc70bd879so25305485ab.3
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 12:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704830644; x=1705435444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PkUQkauKqA5Tc/69Ts21dgm2IenD2ZL2Uz4ahbo5n8=;
        b=hZmCcRzuWUgNr/6gnZuh0dooelYMw5mxMdmnrb4u4MzhuMic8/bhki44X1cKB2LFuX
         whop3Ctx/0qef1wNCYttfdlLPHSyh0ch/VB6ypQLK0ot61GalJ8Vcwyth58HF+03WRdV
         AdWrxZ5MXgUN1Lw/Dj6UbfAssq4cpo8SyhCsVlnUzyttJmUPaVoSy+c/awsGONeyzDYw
         hsq++mWmUjpOGva/kyNw1W6uLV9dPy77tf3yGfBfLlPgI5dgAaKIlyQ5PGCiWxHP4y/t
         DVx0NVatoMm+HPHMyilTs7zon+C+usGkGRmkOLsMEq0+rkXAbzSyY2pb0BjvcSz+cUIU
         DixA==
X-Gm-Message-State: AOJu0Yz5hNC03a5O5fa24a+xaDrLeWRKvXqk0m+qjlQofjALgJy5Pu70
	IUAC8ntUrpkgrXQ7l+VHdeum47hEoHyU16ES69wB7vKrK1MV
X-Google-Smtp-Source: AGHT+IF6+4z2B/MyxbEaj12WXkpRqE3w7ehv/0PEh25BSD3sOMyxjEIxxW2EQn4FhG1dRjHE3FP7Ypsqx3e3wL7kWz7t95v90nQV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6b:b0:360:6243:433f with SMTP id
 w11-20020a056e021a6b00b003606243433fmr671695ilv.1.1704830643904; Tue, 09 Jan
 2024 12:04:03 -0800 (PST)
Date: Tue, 09 Jan 2024 12:04:03 -0800
In-Reply-To: <20240109193304.7pc27uzwm5dtudk6@skbuf>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eea95a060e88d051@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_changeupper
From: syzbot <syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lixiaoyan@google.com, netdev@vger.kernel.org, 
	olteanv@gmail.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com

Tested on:

commit:         a7fe0881 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11f5ed75e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f71e27f13422e1cd
dashboard link: https://syzkaller.appspot.com/bug?extid=d81bcd883824180500c8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125c2bf3e80000

Note: testing is done by a robot and is best-effort only.

