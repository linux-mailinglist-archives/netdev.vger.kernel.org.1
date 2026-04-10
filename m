Return-Path: <netdev+bounces-277223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAgnID9q2GkhdAgAu9opvQ
	(envelope-from <netdev+bounces-277223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:10:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D57E3D1BA9
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DECF301DA64
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E604C3126A0;
	Fri, 10 Apr 2026 03:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxmLEJpI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8430FF32
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 03:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775790649; cv=none; b=Bal72drwn4yEfjlOpKf9WG7RywdfFLeHJ9QFQPG2zEvgJsSj1kBX7vlhmFT/jNb9IJ3CGDdrI5SNhrKXbckOPK/wjoCBC1+Kksg+KnJ9yLLgUF5uxya7xl1As2OC5z5XEfz4zayXIhiUrmQwN02xti6Hzw/Mq/UhIypVpzEAWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775790649; c=relaxed/simple;
	bh=yhjXwJuwYdYM0qVC/7t3QnplFB0hQQMyiHueGsBAoVk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u2QtwhU0uhB8+xwjGaHP98lQPGnBETfv7Kh9CJkVSHhN8eT39XqJ+sCEygsVS/BwnQsZCRpYBMujFwD6vDosAG8TF4wrlCaId9nP1MG8Qd+6NGeLnevCL/Tp/3gcQ4e/X5703moEEd8JEvdICwqIImA8L9sdaWrmquWvx0knLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxmLEJpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A873C4CEF7;
	Fri, 10 Apr 2026 03:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775790649;
	bh=yhjXwJuwYdYM0qVC/7t3QnplFB0hQQMyiHueGsBAoVk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CxmLEJpIiteEu1huzAHOWbE4rlqxtAXu33vpYtf5bkFh44ZrCEgio8RqvAIVPXTJo
	 IkJWi1r/kgneKFjSaz9krGGGStvzvMVtZG7qve+/ZI5aox60Jk+NgE3hgjloHSWR7A
	 D9C25bGoP4ceYcrF8/+gvzvDatLW7yf80W01tKqpdOlsIT+1MC4TukKuhJKDxt65RS
	 Tj67n8mdIkUIywxDz6UKtPtWGjdv0vFhjgMATj4mzhhtx6dTX4bhUrl4zYiXVNkoN1
	 oZ5L3pYEDg3RNk6YBxAMJJLWAznG5VAcWQ9mJq/bj/f4BzO5h0syk0kzNxk8euJSBU
	 JzNSaGLLaclDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9CE93809A22;
	Fri, 10 Apr 2026 03:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ipv6: move IFA_F_PERMANENT percpu allocation
 in
 process scope
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177579062429.1844106.9948363425307404329.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 03:10:24 +0000
References: 
 <46a7a030727e236af2dc7752994cd4f04f4a91d2.1775658924.git.pabeni@redhat.com>
In-Reply-To: 
 <46a7a030727e236af2dc7752994cd4f04f4a91d2.1775658924.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-277223-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D57E3D1BA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 16:36:49 +0200 you wrote:
> Observed at boot time:
> 
>  CPU: 43 UID: 0 PID: 3595 Comm: (t-daemon) Not tainted 6.12.0 #1
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x4e/0x70
>   pcpu_alloc_noprof.cold+0x1f/0x4b
>   fib_nh_common_init+0x4c/0x110
>   fib6_nh_init+0x387/0x740
>   ip6_route_info_create+0x46d/0x640
>   addrconf_f6i_alloc+0x13b/0x180
>   addrconf_permanent_addr+0xd0/0x220
>   addrconf_notify+0x93/0x540
>   notifier_call_chain+0x5a/0xd0
>   __dev_notify_flags+0x5c/0xf0
>   dev_change_flags+0x54/0x70
>   do_setlink+0x36c/0xce0
>   rtnl_setlink+0x11f/0x1d0
>   rtnetlink_rcv_msg+0x142/0x3f0
>   netlink_rcv_skb+0x50/0x100
>   netlink_unicast+0x242/0x390
>   netlink_sendmsg+0x21b/0x470
>   __sys_sendto+0x1dc/0x1f0
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0x7d/0x160
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7f5c3852f127
>  Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 80 3d 85 ef 0c 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 71 c3 55 48 83 ec 30 44 89 4c 24 2c 4c 89 44
>  RSP: 002b:00007ffe86caf4c8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
>  RAX: ffffffffffffffda RBX: 0000556c5cd93210 RCX: 00007f5c3852f127
>  RDX: 0000000000000020 RSI: 0000556c5cd938b0 RDI: 0000000000000003
>  RBP: 00007ffe86caf5a0 R08: 00007ffe86caf4e0 R09: 0000000000000080
>  R10: 0000000000000000 R11: 0000000000000202 R12: 0000556c5cd932d0
>  R13: 00000000021d05d1 R14: 00000000021d05d1 R15: 0000000000000001
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ipv6: move IFA_F_PERMANENT percpu allocation in process scope
    https://git.kernel.org/netdev/net-next/c/8e6405f8218b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



