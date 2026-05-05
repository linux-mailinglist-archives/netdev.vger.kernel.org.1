Return-Path: <netdev+bounces-284176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLoFKN5Y+Wk68AIAu9opvQ
	(envelope-from <netdev+bounces-284176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:41:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2A74C60C9
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E17F302F278
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A6C3A6B74;
	Tue,  5 May 2026 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQJeyo6k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F03A641F;
	Tue,  5 May 2026 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948861; cv=none; b=KbuTRvAFLODWXWfOOaSnbTIU75sVXBOQ+Q9m85XjVrpSHHrJ32nM5pHKLBSao75/v1Djl9dOLlVdglgMr7Q2znVzIlOagpVfVdXma9QpT74y5jZvPo7KhtiZmZSyf1w1TTs/5pCMzFBANgsWkANP+ji6HqMZ7dWKDlOSscBOKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948861; c=relaxed/simple;
	bh=ddU8USgzjzQyVZN71U7F/arM8/K2SIdvmClFGkdxcMk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ilVh6v/+fuZ4VOd2pNTP2gh2LJuhqZqxbTzR490nl3VMXUGRTMGCiYnQbRO/JY5uJ2YYVR9mYyWxw7TKVjt4o1ftZX+/3aSm1HRxhtIFhdBH16ZZir+8ajWkgOlrvzi9lpVJ7aQYSVbRzU8rIZfVfo7eFICIYN2SzXMOkQ8xmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQJeyo6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06164C2BCB8;
	Tue,  5 May 2026 02:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948861;
	bh=ddU8USgzjzQyVZN71U7F/arM8/K2SIdvmClFGkdxcMk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VQJeyo6k6QXy5XPxqDOOZW240PDY8mh5WHJ/6vKUobp8ijj4r2E1sp6EhiZd+2SFn
	 pDHsljLFMHZrIVN9af0K2seKULF8Rp9tPuDlVnIa8OTgG6JnbMEXnpW/vowQtc2YTU
	 RCQ6BbIp2r3UxOJ/jTIxn4g4cAS/NiBdw5m3Rmu6vRKuQcJmKJZNwC6agaoSwCvZao
	 juFbYlaJKSsxOBlB8skgAQ9IoT+SHLmVlwU7bN4pxGlx4AH8/o/tMrTU3CkFr+tWkM
	 QN8G07wjzqp231nBUYTtfsovTMCyWQpXX2X1M2NNAWwpRiNTaLyiLI0AiL+bWCCPsK
	 +rdyRFB26lSrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D3039301A2;
	Tue,  5 May 2026 02:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] net: dsa: mt7530: fix .get_stats64 sleeping in
 atomic
 context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794881154.1397274.8560598975981620800.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:40:11 +0000
References: 
 <6940b913da2c29156f0feff74b678d3c526ee84c.1777719253.git.daniel@makrotopia.org>
In-Reply-To: 
 <6940b913da2c29156f0feff74b678d3c526ee84c.1777719253.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: chester.a.unal@arinc9.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux@armlinux.org.uk, ansuelsmth@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
X-Rspamd-Queue-Id: 1F2A74C60C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-284176-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 2 May 2026 11:55:02 +0100 you wrote:
> The .get_stats64 callback runs in atomic context, but on
> MDIO-connected switches every register read acquires the MDIO bus
> mutex, which can sleep:
> [   12.645973] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:609
> [   12.654442] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 759, name: grep
> [   12.663377] preempt_count: 0, expected: 0
> [   12.667410] RCU nest depth: 1, expected: 0
> [   12.671511] INFO: lockdep is turned off.
> [   12.675441] CPU: 0 UID: 0 PID: 759 Comm: grep Tainted: G S      W           7.0.0+ #0 PREEMPT
> [   12.675453] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
> [   12.675456] Hardware name: Bananapi BPI-R64 (DT)
> [   12.675459] Call trace:
> [   12.675462]  show_stack+0x14/0x1c (C)
> [   12.675477]  dump_stack_lvl+0x68/0x8c
> [   12.675487]  dump_stack+0x14/0x1c
> [   12.675495]  __might_resched+0x14c/0x220
> [   12.675504]  __might_sleep+0x44/0x80
> [   12.675511]  __mutex_lock+0x50/0xb10
> [   12.675523]  mutex_lock_nested+0x20/0x30
> [   12.675532]  mt7530_get_stats64+0x40/0x2ac
> [   12.675542]  dsa_user_get_stats64+0x2c/0x40
> [   12.675553]  dev_get_stats+0x44/0x1e0
> [   12.675564]  dev_seq_printf_stats+0x24/0xe0
> [   12.675575]  dev_seq_show+0x14/0x3c
> [   12.675583]  seq_read_iter+0x37c/0x480
> [   12.675595]  seq_read+0xd0/0xec
> [   12.675605]  proc_reg_read+0x94/0xe4
> [   12.675615]  vfs_read+0x98/0x29c
> [   12.675625]  ksys_read+0x54/0xdc
> [   12.675633]  __arm64_sys_read+0x18/0x20
> [   12.675642]  invoke_syscall.constprop.0+0x54/0xec
> [   12.675653]  do_el0_svc+0x3c/0xb4
> [   12.675662]  el0_svc+0x38/0x200
> [   12.675670]  el0t_64_sync_handler+0x98/0xdc
> [   12.675679]  el0t_64_sync+0x158/0x15c
> 
> [...]

Here is the summary with links:
  - [net,v6] net: dsa: mt7530: fix .get_stats64 sleeping in atomic context
    https://git.kernel.org/netdev/net/c/07d995873960

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



