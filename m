Return-Path: <netdev+bounces-265990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI9OBwz1r2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:40:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FA9249807
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D015B30D1C37
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B97C37187B;
	Tue, 10 Mar 2026 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOekHYta"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F03290C0;
	Tue, 10 Mar 2026 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139209; cv=none; b=VO2wKHDuzrLnjYKlKDnqn5OaEMPSG5TQUpzIO0C5jK+wCztehIOLyVs7s7g0ejZBSJb3BMf2qY6cfaUkUBOfK8Sjd3Dja2gf1j8b7Ie58pQAB8cqfXKVcYldLI+XRsmU8CHyY7tFLx+7F0vyOVW+13nIrGlcIenR2V3ClEQnLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139209; c=relaxed/simple;
	bh=UH7EoqtxolXSpxH/gV9zb6ggqXklVND9HqeFweQV0P4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jl1mBdze2/FnKSN4v8sHHIA7fB1PlLjMJyWfjEzBnJSpxcYCUsCETY14K3fhk9FnKd2842oPYyUmMxjPMYh9uxIXHQoyR2DofZFFPF1HbhgsQHjMiSU15kIsYS7hJft1ZZ1cyK/xg2xYiJRcArFwcCDxW7pAvFrnOmfL5uGNhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOekHYta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CC8C19423;
	Tue, 10 Mar 2026 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139208;
	bh=UH7EoqtxolXSpxH/gV9zb6ggqXklVND9HqeFweQV0P4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SOekHYta9L5N1IK7CA0whIk78ldZHStcuAbW2Mgtni6yYFrh5r7p3gXOnEU5oEKz9
	 cBtn/TVg32AomFuQm+Hc2lKyhIq0mY4VeTJK3SejbFFtbjQb51eqGB/rmOBtXe2XdL
	 yVooBsj2vSx6Uz6GPkw4IxpCSlqfUbcnqMtcGs4ZS4t+8GeeGxM0Kikq7bPn0GVwPd
	 8VuiL5rheyxWGZvgHCzOhqtBsbS/wqtF9rCT5ldPvSgB2uNfNsydaq221M56OGbv0o
	 5mdjumgc4pZt9cCUxcqzqk7fyJoOkKJBpw8mNxhVW0cHx5X81HOGJlKxXpUD3ojcR/
	 JxJ+c8FzMeTHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0ED3808200;
	Tue, 10 Mar 2026 10:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bonding: fix type confusion in
 bond_setup_by_slave()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177313920555.2183148.12190533111152447018.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 10:40:05 +0000
References: <20260306021508.222062-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260306021508.222062-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, jiayuan.chen@shopee.com,
 edumazet@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, jeff@garzik.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 71FA9249807
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265990-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Mar 2026 10:15:07 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> kernel BUG at net/core/skbuff.c:2306!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> RIP: 0010:pskb_expand_head+0xa08/0xfe0 net/core/skbuff.c:2306
> RSP: 0018:ffffc90004aff760 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff88807e3c8780 RCX: ffffffff89593e0e
> RDX: ffff88807b7c4900 RSI: ffffffff89594747 RDI: ffff88807b7c4900
> RBP: 0000000000000820 R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000961a63e0 R11: 0000000000000000 R12: ffff88807e3c8780
> R13: 00000000961a6560 R14: dffffc0000000000 R15: 00000000961a63e0
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe1a0ed8df0 CR3: 000000002d816000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  ipgre_header+0xdd/0x540 net/ipv4/ip_gre.c:900
>  dev_hard_header include/linux/netdevice.h:3439 [inline]
>  packet_snd net/packet/af_packet.c:3028 [inline]
>  packet_sendmsg+0x3ae5/0x53c0 net/packet/af_packet.c:3108
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  ____sys_sendmsg+0xa54/0xc30 net/socket.c:2592
>  ___sys_sendmsg+0x190/0x1e0 net/socket.c:2646
>  __sys_sendmsg+0x170/0x220 net/socket.c:2678
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe1a0e6c1a9
> 
> [...]

Here is the summary with links:
  - [net,v2] bonding: fix type confusion in bond_setup_by_slave()
    https://git.kernel.org/netdev/net/c/950803f72547

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



