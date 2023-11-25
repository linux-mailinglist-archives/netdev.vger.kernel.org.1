Return-Path: <netdev+bounces-51068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5B67F8E24
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 20:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24C32814A0
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 19:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC412FE00;
	Sat, 25 Nov 2023 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13B1A3
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 11:45:04 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b3876e18cbso94284139f.3
        for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 11:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700941504; x=1701546304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zFOfzzm7+x12sXeVeQwqDu3dzGCDPPPB+fZft3ol3s=;
        b=k9h/0UjoFzrLhlL4XPjVJOFgNqbgECxFPlsQYVAduAGUOb5hIOg0MM9YrnSmRMV3OL
         iY78sjaypFnuW7/OjoQpuyEjr7sxP+xA6fc3pqzqv5zntBtuYa7bFHum2ovkzz15s+d3
         iMVUStPevjeUt9+MSVHH4RoIIu3kgjykdMMfhSZbOxeokSd72GaTe0AYfT1NkSsPmBis
         MmRANfuFWXfxutM19F1eMqIqn+vzo2x3GT/1riuqGHVgCDKSfe3S0YGMJrtEH1azdNva
         gSbwO245DGsf2q6se5ksa5tppx1VA/PEpzT1YBQZIoD+5L0Rc3Oi5abFGsl8FNwwEdE/
         ytYg==
X-Gm-Message-State: AOJu0YwV7LTokZJ7L56fzoepjhxlKJMLKSh5OgGNSCLC/8nWsd3fdySB
	vz5Gvho2ARdvhh3qUGN1s7kmw5pkasycHpFUT3FLIRtvrnJF
X-Google-Smtp-Source: AGHT+IGy/jille76tRuHatrHMaPg0FZSslMdhHqT9yNBrbiA2KEi3FhpZSL3dovGyPgee+Yiv11zFDwqux9IItC/LYzdXYPE19or
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:9919:0:b0:792:f7c:b139 with SMTP id
 t25-20020a5e9919000000b007920f7cb139mr339557ioj.1.1700941504253; Sat, 25 Nov
 2023 11:45:04 -0800 (PST)
Date: Sat, 25 Nov 2023 11:45:04 -0800
In-Reply-To: <18c07e01a4c.220c832d175971.1254981088507972317@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002518c5060aff4e27@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From: syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To: code@siddh.me, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com

Tested on:

commit:         8872a44d lock
git tree:       https://github.com/siddhpant/linux.git lock
console output: https://syzkaller.appspot.com/x/log.txt?x=168d9a08e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e6a76f6c7029ca2
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

