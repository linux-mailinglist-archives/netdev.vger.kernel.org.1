Return-Path: <netdev+bounces-288713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rHjANg2XCWqXgwQAu9opvQ
	(envelope-from <netdev+bounces-288713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 12:23:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBFE560746
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 12:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 226B6300340B
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51E2E282B;
	Sun, 17 May 2026 10:23:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CCA33987
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779013385; cv=none; b=HPTttugOtqcCRXyhVItaCrDZqAjSlFjocJFqNLOw9tN1utQiJPJ7/OU2aEYn2iN8pDYaULzE6g5ZjUf+FjmOkEIvUxDB0+cNhcCfMeHb/KRlpjFrtsltcGD6Wx+NZ5r899RTJlGdZ3kfqeQ6LFW/Iww6+w4It1J3Agt5Bn6XG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779013385; c=relaxed/simple;
	bh=mj9YtOGBFCLAwR84LyZc2W3EIeUpfl7PXa5rDaE6sFk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=hubGJQRtfikUuo78xELsr7X++7/eapy4GPsic0aimv73iKT9KMAx/yjNFgZQ0+QhXsCw+q8aMyQFPKDNXQ3WWt6l1TNYKT8i+UswgCLDI1MR3czCdgwm/YYkg34oqDHRcc5rmliYb17XnSscRelP7dRQ0ivUq3nUUzssChtHJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64HAMcT6011120;
	Sun, 17 May 2026 19:22:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64HAMc7M011117
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 17 May 2026 19:22:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ae6348a3-9cff-4a65-8ad3-ceeca938d4d3@I-love.SAKURA.ne.jp>
Date: Sun, 17 May 2026 19:22:38 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: neighbour: reject neighbor creation on IFF_NOARP
 devices
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <98be20ee-c914-4c93-b4bd-d04ddcc349cf@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <98be20ee-c914-4c93-b4bd-d04ddcc349cf@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Rspamd-Queue-Id: AFBFE560746
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288713-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,I-love.SAKURA.ne.jp:mid]
X-Rspamd-Action: no action

Sorry, please ignore this patch, for it turned out that this analysis was wrong.

On 2026/05/16 0:05, Tetsuo Handa wrote:
> syzbot is reporting
> 
>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
> 
> problem.
> 
> I asked AI Mode in Google Search to analyze a log from my debug printk()
> patch in linux-next-20260508. It performed a meticulous trace of
> __dev_hold() and __dev_put() frequency, and identified that a reference
> acquired via ___neigh_create() remains unreleased at the end of the device
> unregistration timeline.
> 
>   Call trace for vcan0[24] +1 at
>        __dev_hold include/linux/netdevice.h:4470 [inline]
>        netdev_hold include/linux/netdevice.h:4513 [inline]
>        ___neigh_create+0xcb3/0x2360 net/core/neighbour.c:664
>        neigh_add+0xc51/0xf70 net/core/neighbour.c:2136
>        rtnetlink_rcv_msg+0x77e/0xbe0 net/core/rtnetlink.c:7005
>        netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2551
>        netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>        netlink_unicast+0x780/0x920 net/netlink/af_netlink.c:1345
>        netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
>        sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
> 
The reference that is leaking is [26].

Call trace for vcan0[26] +4 at
     __dev_hold include/linux/netdevice.h:4470 [inline]
     netdev_hold include/linux/netdevice.h:4513 [inline]
     dev_hold include/linux/netdevice.h:4536 [inline]
     j1939_priv_create net/can/j1939/main.c:140 [inline]
     j1939_netdev_start+0x36b/0xc10 net/can/j1939/main.c:268
     j1939_sk_bind+0x853/0xb30 net/can/j1939/socket.c:506
     __sys_bind_socket net/socket.c:1948 [inline]
     __sys_bind+0x2e9/0x410 net/socket.c:1979

Call trace for vcan0[28] -3 at
     __dev_put include/linux/netdevice.h:4456 [inline]
     netdev_put include/linux/netdevice.h:4523 [inline]
     dev_put include/linux/netdevice.h:4548 [inline]
     __j1939_priv_release net/can/j1939/main.c:166 [inline]
     kref_put include/linux/kref.h:65 [inline]
     j1939_priv_put+0x128/0x270 net/can/j1939/main.c:172
     j1939_sk_sock_destruct+0x52/0x90 net/can/j1939/socket.c:388
     __sk_destruct+0x8d/0x9d0 net/core/sock.c:2352
     rcu_do_batch kernel/rcu/tree.c:2617 [inline]
     rcu_core kernel/rcu/tree.c:2869 [inline]
     rcu_cpu_kthread+0x99e/0x1470 kernel/rcu/tree.c:2957
     smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
     kthread+0x388/0x470 kernel/kthread.c:436
     ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245


