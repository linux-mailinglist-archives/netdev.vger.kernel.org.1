Return-Path: <netdev+bounces-20114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE375DAA4
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 09:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43165282429
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 07:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081FE14F61;
	Sat, 22 Jul 2023 07:38:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFF5125A0
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 07:38:25 +0000 (UTC)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458012708
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 00:38:24 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5666806ccfaso6111193eaf.1
        for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 00:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690011503; x=1690616303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BFg2LH8Kt+Y3c9UeEmRjI3v36opiod0X7a7OqprL1w=;
        b=kCnYNIaS6xm/B43Hm9btAbU6X62IxMsC1Z5ukD6nLe8wUEXalJ3PLRqCBkUzpi8n4T
         4ulvWZa/D5q1kZD5XFy43NY6OSfkYsoYiXNb1IVSXMwAv4xYgnsNBesUz1WrI3fizmrA
         gHHwhi+PqfYvlxk3lug/eDgohZGxNGoFaa+vDTEcMoQBwkNESgkBF618BjuNkA1Bu1Il
         GQo43LWsvPCpWjjdVaaJeQ/OpOYb2yLrf62KHwg101Ay8q+rXahYQjA66axBwhJyg8cV
         uMkl7Netf7mVhywQOFvLpEYH0EPmVL7cyiFrJW/LJEZKCM9A6GjilYYqXnc5LNhOr2lW
         TkcQ==
X-Gm-Message-State: ABy/qLazf6B/6hm2YkgKC8EhJGp3bg3/xcYIuA3EsGEp9fpq9NFjHY5y
	PnVYrXOthZu5xs8MRLutXrSgrBjLXRvT8dThssur1GU41CIp
X-Google-Smtp-Source: APBJJlFeQ9rTgJVx5HyLmSJpNlRbWCk+M1T+morzZu/Q46jYvl0lP3UogNHWfrcfn3SNh8HkfE4neXOsFzAXAlas+4IBfWvkE0lB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3097:b0:3a4:8ecb:1878 with SMTP id
 bl23-20020a056808309700b003a48ecb1878mr9381158oib.1.1690011503647; Sat, 22
 Jul 2023 00:38:23 -0700 (PDT)
Date: Sat, 22 Jul 2023 00:38:23 -0700
In-Reply-To: <0000000000004386940600eca80d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057611806010e77fa@google.com>
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in ingress_destroy
From: syzbot <syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com>
To: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, hdanton@sina.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit e420bed025071a623d2720a92bc2245c84757ecb
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Wed Jul 19 14:08:52 2023 +0000

    bpf: Add fd-based tcx multi-prog infra with link support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1568abf4a80000
start commit:   03b123debcbc tcp: tcp_enter_quickack_mode() should be static
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1768abf4a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1368abf4a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32e3dcc11fd0d297
dashboard link: https://syzkaller.appspot.com/bug?extid=bdcf141f362ef83335cf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bf2bf4a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12741e9aa80000

Reported-by: syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com
Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

