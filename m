Return-Path: <netdev+bounces-46099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA247E1582
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 18:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C482B20D00
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1515915AF8;
	Sun,  5 Nov 2023 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B905A956
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 17:34:07 +0000 (UTC)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C486BCA
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 09:34:05 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b3f4ab1238so4565414b6e.3
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 09:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699205645; x=1699810445;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4FvxRKbvCfMpMcLXPYkRNT3NM+7m0oeXuj/bJJZmv8=;
        b=aKi4uciLKN4jqhjrGZEW5axDoqOzhITyllNCqs0TW27RcA1jxu/LCe8lkLHr0FmVFY
         2R2XYzZ+1MgxZ9mdly2c6EB3O1T3E/XmIoioQehns3CbE9+bDt+ZGw34K+4sEOQiVbE1
         +bsaElgROcVntZXM6jAPTx7AwXcVOd3bxS1BOz7ZANOrInmOwUfctmZz1vb55/sbkXPa
         ytSVWxilNC40ecoN8lsQJj8PV056WuMa6wx50HTirCR6h3LnflF982qkii7WydJas/un
         AkWrFqMTrVp44JHCT/mXVJiUPRGnX/8qtnwOkr/8Pih/s4qjQ0vvl99xrSII+fzUqbU5
         7BSg==
X-Gm-Message-State: AOJu0YyYe2sFUxC7Vc2Gzn9sz0C6flRxu+IBJZBsj2nlmxzIdKjskGlP
	GxHyrHX23EFLGNSGDmYoXAKs4JPFb43r2v+7RZVrH+bwjlWJ
X-Google-Smtp-Source: AGHT+IHQGKy6Mfra4sf1/Fnaf3EC/D55G0NP35y8t1SN8GFVyNI7t9d57uCYzqPBwHjaKdaF7v3yTC+yAH7PGthgD35bnMd/I7bL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3083:b0:3ad:aeed:7eeb with SMTP id
 bl3-20020a056808308300b003adaeed7eebmr10612059oib.6.1699205645177; Sun, 05
 Nov 2023 09:34:05 -0800 (PST)
Date: Sun, 05 Nov 2023 09:34:05 -0800
In-Reply-To: <0000000000006f759505ee84d8d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e197ef06096b2454@google.com>
Subject: Re: [syzbot] [nfc?] [net?] BUG: corrupted list in nfc_llcp_unregister_device
From: syzbot <syzbot+81232c4a81a886e2b580@syzkaller.appspotmail.com>
To: 309386628@qq.com, davem@davemloft.net, dominic.coppola@gatoradeadvert.com, 
	dvyukov@google.com, edumazet@google.com, hdanton@sina.com, 
	johan.hedberg@gmail.com, krzysztof.kozlowski@linaro.org, kuba@kernel.org, 
	linma@zju.edu.cn, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, zahiabdelmalak0@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

syzbot suspects this issue was fixed by commit:

commit b938790e70540bf4f2e653dcd74b232494d06c8f
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Fri Sep 15 20:24:47 2023 +0000

    Bluetooth: hci_codec: Fix leaking content of local_codecs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15cb8f17680000
start commit:   e1c04510f521 Merge tag 'pm-6.2-rc9' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe56f7d193926860
dashboard link: https://syzkaller.appspot.com/bug?extid=81232c4a81a886e2b580
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e90568c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: hci_codec: Fix leaking content of local_codecs

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

