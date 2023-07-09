Return-Path: <netdev+bounces-16234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47E374C074
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 04:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658631C20915
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 02:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BF715BC;
	Sun,  9 Jul 2023 02:49:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180BEECA
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 02:49:20 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE957E44
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 19:49:19 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b8ad356f6fso36876455ad.3
        for <netdev@vger.kernel.org>; Sat, 08 Jul 2023 19:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688870959; x=1691462959;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t48dt0gbHoYlD6zQ7nPtF/7kcwYP/QK/Spyg3zZplME=;
        b=CdZu77JT/eE5l74yE6asdmWLJ2Zq66DxN8SMe5mB8q3uRxdfYHM/G8nfCfyLMBFLKN
         Q946WCq8F40J1Lp5ZZW6kazqwIqbP0Zkaoyn2h0cXXUU4C1UcVF7llG/1QpoA6CRb+u3
         lPpJu1iwHIKxLVkqNoxnq4P7Z7+I/j6S2cyg8yvgx62/fsQQLkMrhMLOFnMxi/CpWxmc
         12H3OseNrgTLDNd1RtTrJzsFbRDtBnJJ8F8rdx5Ses/p208QxtR8qEMFWwIA5JzTWH1L
         SRcRq+vEpMY+iCpyCFD2aE8QPEJUXaD7i4uFZ6NyFtYXUF3jCBfpVQ+frfNDx0jLsE1k
         Bsow==
X-Gm-Message-State: ABy/qLYhiqCEj7Kr/y05gRyyhapnfqwbgNKq21gho01Q2eFu/KMWB7yl
	5b1VimDslXtqadg7aLf19hg74OigJRUD8ILDy8CBGJf0r7Jo
X-Google-Smtp-Source: APBJJlFJkrHvXVTRO6Vtonj5SuXcoJVj5y3+IwOSzRZo5PV3XTSrQZsZ+7qCQoXA6bVHCCkEvjM7TQxWW6qiRIEFhaIbbBR0ziYD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:2607:b0:1b8:a92f:2618 with SMTP id
 jd7-20020a170903260700b001b8a92f2618mr8197792plb.10.1688870959528; Sat, 08
 Jul 2023 19:49:19 -0700 (PDT)
Date: Sat, 08 Jul 2023 19:49:19 -0700
In-Reply-To: <0000000000006d817e05f85cd6a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d4169060004e98c@google.com>
Subject: Re: [syzbot] [nfc?] UBSAN: shift-out-of-bounds in nci_activate_target
From: syzbot <syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com>
To: anupnewsmail@gmail.com, bongsu.jeon@samsung.com, davem@davemloft.net, 
	edumazet@google.com, hdanton@sina.com, krzysztof.kozlowski@linaro.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-nfc@lists.01.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit e624e6c3e777fb3dfed036b9da4d433aee3608a5
Author: Bongsu Jeon <bongsu.jeon@samsung.com>
Date:   Wed Jan 27 13:08:28 2021 +0000

    nfc: Add a virtual nci device driver

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b7b56ca80000
start commit:   a452483508d7 Merge tag 's390-6.5-2' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11b7b56ca80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b7b56ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7df0cabaf5becfdc
dashboard link: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123fc664a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12003f4aa80000

Reported-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
Fixes: e624e6c3e777 ("nfc: Add a virtual nci device driver")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

