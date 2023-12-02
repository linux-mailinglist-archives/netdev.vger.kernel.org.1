Return-Path: <netdev+bounces-53262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1238D801D6B
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 15:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E1F1C208BC
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 14:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4D118C0F;
	Sat,  2 Dec 2023 14:56:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2B5106
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 06:56:05 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b6d023424bso2173559b6e.3
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 06:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701528964; x=1702133764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nu5xLdLOLeUMpry7HT1oxjIq+0DkqL24uDVpCnJXOHU=;
        b=k5NOfTqyNxFqdpF2apZxM8WW94P46xTYtbvmf8t3hW1f/L7mIq/gJBdkXrIWZrgv/l
         on30gZt6BnvfS4ulf8r6o2Fs00DYekW4efPgOpMGev4dN0dn5H2wupaw1daBjqCv1+/F
         gEaoODG5ljmjV2QWcPAIMcLtSejMVftThuGk2P0oj+wWBKkqaKjricim9O5IdDXGw/T8
         ZzH34WEmhjx/ZbVvXBxsEyqrQ9Pri01FaHABmjgZzdlLsov0S+NY8xoxMi+K6Ji4Ow5u
         EhfuCAb6Wrd4eaNN1nXUvOr9dhcOc7HUiXZII277fD6mM9nKTE+P29QFEa9NNeISncHn
         uPYg==
X-Gm-Message-State: AOJu0Yy++cgIdNaUNJEXY//tY1sziD5rVn5YoxqwNgbFUmdFbhdq8xhf
	50gzfjj6BMdDXrqw628ZFE/oqXwhabZKn6s7EzUFgE3i5n98
X-Google-Smtp-Source: AGHT+IHCaaicQHGkcJ9gewQxrg9Zx+K/8/06nvLqQ1tRUvyVjVoCAee8lRno5uUJ9zOPWaIEeG0tubhqY/SSq9LRkA2GZEvuUaK9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:189f:b0:3b8:9b14:756c with SMTP id
 bi31-20020a056808189f00b003b89b14756cmr699004oib.9.1701528964701; Sat, 02 Dec
 2023 06:56:04 -0800 (PST)
Date: Sat, 02 Dec 2023 06:56:04 -0800
In-Reply-To: <0642446f-ebd9-429a-a293-94840c765038@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008424e2060b881511@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From: syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To: code@siddh.me, davem@davemloft.net, edumazet@google.com, 
	krzysztof.kozlowski@linaro.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com

Tested on:

commit:         7453d7a6 nfp: ethtool: expose transmit SO_TIMESTAMPING..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=1632f254e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94286555cac4ea49
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d5552ce80000

Note: testing is done by a robot and is best-effort only.

