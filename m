Return-Path: <netdev+bounces-34328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3637C7A3346
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 00:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A5A281963
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 22:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FB81BDEF;
	Sat, 16 Sep 2023 22:46:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35AD1102
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 22:46:31 +0000 (UTC)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B844CD5
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 15:46:29 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1ad17b9fcd8so5204533fac.0
        for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 15:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694904388; x=1695509188;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDqDFKt22vTyovtCZWANFsO5nNiwiMzMNFzNzYfo0Os=;
        b=t6f0Es1LlQgx4JWaoGq9bsSGOo0EGnJ2XC0Qi7Nvi3APFzSzsOieccOUFAOj+iluVf
         z3K1otsGfKylpEpDjhPMjxGPxOzOtVCDlWlx78gr5FgRSR2GACTRCJvuWvhfDCxYZ3xY
         X8F98I3gC4wK7L4vsyytO391Zodx8Lhg5uocY/wmH15LZrXGP9a4qOId/9AeJVnrvSUB
         j7nTR/jJUiqGJ6o04pPMllbEXEDCLcXZtnwLTSzjb7XOgWtangufqV6IYO/EBZ0nFozN
         zlCRnUnJN1kreSNkeaypmGu8hBvTa2z4CQ83Et7TlePJG6ThVC6x2oRoqzrrZjyrRh3a
         JjHQ==
X-Gm-Message-State: AOJu0YziFMgDNiTPdyYOR9Lq8UfchQkhx2EhZ1IES4Xzou81HxsEjERq
	qe+6bL04KzBnIHGlAnzwcMdY8VG66xcwFbRtpd30CocwNeOT
X-Google-Smtp-Source: AGHT+IGFt2/DGjfuD8g7w+zltENZ+tJGOW79oCyv49p0OKQfhDgbLtstLWHD8wZfqIVCeXLT3TMuamCtQy1cHE/sONREKAZOrt3P
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5b2e:b0:1d5:9c14:99c8 with SMTP id
 ds46-20020a0568705b2e00b001d59c1499c8mr1933940oab.10.1694904388474; Sat, 16
 Sep 2023 15:46:28 -0700 (PDT)
Date: Sat, 16 Sep 2023 15:46:28 -0700
In-Reply-To: <000000000000997319060049b1e4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000df89060581ae9e@google.com>
Subject: Re: [syzbot] [net?] [wireless?] INFO: task hung in
 cfg80211_event_work (2)
From: syzbot <syzbot+85f0eb24e10cec9b8a10@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, davem@davemloft.net, edumazet@google.com, 
	johannes@sipsolutions.net, kerneljasonxing@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1411bef8680000
start commit:   727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1611bef8680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1211bef8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c13b5305ee70d27
dashboard link: https://syzkaller.appspot.com/bug?extid=85f0eb24e10cec9b8a10
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15913b90680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156720a8680000

Reported-by: syzbot+85f0eb24e10cec9b8a10@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

