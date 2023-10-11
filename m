Return-Path: <netdev+bounces-39958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ED47C5015
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 12:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998C11C20C0E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790381DDC1;
	Wed, 11 Oct 2023 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qwilt.com header.i=@qwilt.com header.b="Q7SuWqr4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1DA354F6
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 10:28:20 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1D7B7
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:28:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5068dab8c00so5563226e87.0
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qwilt.com; s=google; t=1697020096; x=1697624896; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LXt+kkJM4ivnA2aUoZt1vwJ+WEOQ0Jp2FJBdjT+LTq8=;
        b=Q7SuWqr4J8+PS/Nngyr0avHMZZD+ZTRa74namrfYuLIwdIlMv8kGdGWhoVpoRe2xMg
         ef7DkZdR8XVhEzG/bgnYleqRDRDj8HDg3beWchYadS4s5B/BhU/MJs5pHhYeCAQLjPuN
         7vZxYKpLkGXU6xccgAa7GdJUV7g3nG52DOoY1lE0PZth8dWdhp0WhH5Ek5+FtWPrjnpN
         qW3P2N9PmSa4KVD8I0aC2QF9sS7h2rTexD5jcZ6axkFDS2a9UT8fJpn14yRhcSHANofj
         Xz5A+IAq4xvNlsOCsrxC33sXzhDgcoyKUyDbISksatbswj3P8YxqJDAolUwSrIV0pbGp
         exCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697020096; x=1697624896;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXt+kkJM4ivnA2aUoZt1vwJ+WEOQ0Jp2FJBdjT+LTq8=;
        b=NPflhVKDE9HTJCtVhe+PmeAMeB8Hf6GEZWRUM72XjoUFm24WHeG2ah9XGTQUK91Sae
         BS7EcB4z8jxWTw9Uhwokcc/KBUynyyb4DEdn1XQ7h/ZGqarr2OJFSYzX7TjD2+c1eybF
         LWyIzVCWf1eswRh3jSBm5IW6KkZQy78JOhOALTk7QGHnbU5tzCM9atVvd7slHoMkbsZG
         Ir7VjMtMYVq/XlNcI+UAscNVO4/Q2haUdgSjGqfWYZ/+18iI869+jRgshZYPmtJ6c+pg
         qypP1fJaxbDi7q3Zw/xNM/tmLHPbKk3MpGmwUE+es0s5Fi42SqIO0y5E7x2wo1CTzFt0
         eRfQ==
X-Gm-Message-State: AOJu0YwGppp4DzWFabo5xn6fwZ+UeF2Uf5ObQ3qwCd5lTC0c3JRgzwMj
	FHR4ZgnFN+AmoUPp62fuJl3hxcSTDqnHJIlG0P9fflyCbjB4LgsZaCvJxA==
X-Google-Smtp-Source: AGHT+IF4A+frwzLDocVxJX96qW6IUmXQYS+UiQh4eM6df7tU4zSfbkgU2eGapCr7Am4tiCZv6YRo4zWBHSe07UlBSl8=
X-Received: by 2002:a05:6512:1154:b0:505:6cc7:e0f7 with SMTP id
 m20-20020a056512115400b005056cc7e0f7mr21221997lfg.44.1697020096280; Wed, 11
 Oct 2023 03:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dmitry Kravkov <dmitryk@qwilt.com>
Date: Wed, 11 Oct 2023 13:28:05 +0300
Message-ID: <CAAvCjhiqtTBYNfgVHtOashJZuArY3mz2=938ip=5i4u_7wd85A@mail.gmail.com>
Subject: kernel BUG at net/ipv4/tcp_output.c:2642 with kernel 5.19.0-rc2 and newer
To: netdev@vger.kernel.org, edumazet@google.com, 
	"Slava (Ice) Sheremet" <slavas@qwilt.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

In our try to upgrade from 5.10 to 6.1 kernel we noticed stable crash
in kernel that bisected to this commit:

commit 849b425cd091e1804af964b771761cfbefbafb43
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Jun 14 10:17:34 2022 -0700

    tcp: fix possible freeze in tx path under memory pressure

    Blamed commit only dealt with applications issuing small writes.

    Issue here is that we allow to force memory schedule for the sk_buff
    allocation, but we have no guarantee that sendmsg() is able to
    copy some payload in it.

    In this patch, I make sure the socket can use up to tcp_wmem[0] bytes.

    For example, if we consider tcp_wmem[0] = 4096 (default on x86),
    and initial skb->truesize being 1280, tcp_sendmsg() is able to
    copy up to 2816 bytes under memory pressure.

    Before this patch a sendmsg() sending more than 2816 bytes
    would either block forever (if persistent memory pressure),
    or return -EAGAIN.

    For bigger MTU networks, it is advised to increase tcp_wmem[0]
    to avoid sending too small packets.

    v2: deal with zero copy paths.

    Fixes: 8e4d980ac215 ("tcp: fix behavior for epoll edge trigger")
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
    Reviewed-by: Wei Wang <weiwan@google.com>
    Reviewed-by: Shakeel Butt <shakeelb@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

This happens in a pretty stressful situation when two 100Gb (E810 or
ConnectX6) ports transmit above 150Gbps that most of the data is read
from disks. So it appears that the system is constantly in a memory
deficit. Apparently reverting the patch in 6.1.38 kernel eliminates
the crash and system appears stable at delivering 180Gbps

[ 2445.532318] ------------[ cut here ]------------
[ 2445.532323] kernel BUG at net/ipv4/tcp_output.c:2642!
[ 2445.532334] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 2445.550934] CPU: 61 PID: 109767 Comm: nginx Tainted: G S         OE
    5.19.0-rc2+ #21
[ 2445.560127] ------------[ cut here ]------------
[ 2445.560565] Hardware name: Cisco Systems Inc
UCSC-C220-M6N/UCSC-C220-M6N, BIOS C220M6.4.2.1g.0.1121212157
11/21/2021
[ 2445.560571] RIP: 0010:tcp_write_xmit+0x70b/0x830
[ 2445.561221] kernel BUG at net/ipv4/tcp_output.c:2642!
[ 2445.561821] Code: 84 0b fc ff ff 0f b7 43 32 41 39 c6 0f 84 fe fb
ff ff 8b 43 70 41 39 c6 0f 82 ff 00 00 00 c7 43 30 01 00 00 00 e9 e6
fb ff ff <0f> 0b 8b 74 24 20 8b 85 dc 05 00 00 44 89 ea 01 c8 2b 43 28
41 39
[ 2445.561828] RSP: 0000:ffffc110ed647dc0 EFLAGS: 00010246
[ 2445.561832] RAX: 0000000000000000 RBX: ffff9fe1f8081a00 RCX: 00000000000005a8
[ 2445.561833] RDX: 000000000000043a RSI: 000002389172f8f4 RDI: 000000000000febf
[ 2445.561835] RBP: ffff9fe5f864e900 R08: 0000000000000000 R09: 0000000000000100
[ 2445.561836] R10: ffffffff9be060d0 R11: 000000000000000e R12: ffff9fe5f864e901
[ 2445.561837] R13: 0000000000000001 R14: 00000000000005a8 R15: 0000000000000000
[ 2445.561839] FS:  00007f342530c840(0000) GS:ffff9ffa7f940000(0000)
knlGS:0000000000000000
[ 2445.561842] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2445.561844] CR2: 00007f20ca4ed830 CR3: 00000045d976e005 CR4: 0000000000770ee0
[ 2445.561846] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2445.561847] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2445.561849] PKRU: 55555554
[ 2445.561853] Call Trace:
[ 2445.561858]  <TASK>
[ 2445.564202] ------------[ cut here ]------------
[ 2445.568007]  ? tcp_tasklet_func+0x120/0x120
[ 2445.569107] kernel BUG at net/ipv4/tcp_output.c:2642!
[ 2445.569608]  tcp_tsq_handler+0x7c/0xa0
[ 2445.569627]  tcp_pace_kick+0x19/0x60
[ 2445.569632]  __run_hrtimer+0x5c/0x1d0
[ 2445.572264] ------------[ cut here ]------------
[ 2445.574287] ------------[ cut here ]------------
[ 2445.574292] kernel BUG at net/ipv4/tcp_output.c:2642!
[ 2445.582581]  __hrtimer_run_queues+0x7d/0xe0
--
--

-- 
--

Dmitry Kravkov     Software  Engineer
Qwilt | Mobile: +972-54-4839923 | dmitryk@qwilt.com

