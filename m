Return-Path: <netdev+bounces-273437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DRPOA8ry2n8EQYAu9opvQ
	(envelope-from <netdev+bounces-273437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 04:01:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE4A3633C5
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 04:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7518B302AE27
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F2426E706;
	Tue, 31 Mar 2026 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJ21FhyG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB3192B75;
	Tue, 31 Mar 2026 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922422; cv=none; b=E5Tlt7Xz/OH7swtg3Ew/pu7cc6eoKpiI9eRIrc/t5+7T2KFl5gKjqi/tWO6dVFLVDQJouE6rfA4Z+K5iwerH3pSNibM5ec7MpIaXT2FxbDf3w6qfAo50toMMrvYRwpwpaRUTXUbPiO4fmt77nJtdRhaSFZPOw7LUl6C8se2oL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922422; c=relaxed/simple;
	bh=+5jjSJHEn37i/yEgwa3lh3t5HW15dgu7YIUh1RVLGyY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E+bqi2R4+4mEZIzBvKfmcofDu308P+BD7eiGEML1aDycMcuK6xKn21sl6YGmx8wZ7Itb5ReBu5asOWip9Wa1l9Rm7kN+qgKlhxE8CLmVTNoQH0nmVGpYthtE34yXOBVx6TBLbRgzbexGVs+F5xqSH7PBsb1dBDihBUxmqmAMZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJ21FhyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E1AC4CEF7;
	Tue, 31 Mar 2026 02:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774922422;
	bh=+5jjSJHEn37i/yEgwa3lh3t5HW15dgu7YIUh1RVLGyY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rJ21FhyGxiP1RQpwME28EVmDAvHYdGE1pX9VrEOSCNj/qUPZFH1yC8snI6l2Nr/gw
	 hULQa+t1BOWucMC8rB951YMW4dHkyLmAOaIiju+c9nlEdkV7X2ttu8FZu+iMxHsj0e
	 gLEDKJyuBvsEU2jdBvzUknjaAIB2T9dEP+yIIQpzDcT+o7E+ItlXwCwpmeCpVzfv0w
	 ognmq4Xet0GWpMu/Xsxb14IjcUZ7ZThLotwqF6WAxymUCjImvPpjRnyTGwocC84Ip7
	 kieJeAiTPt+V3H8vG9CReG5cHAdfHrN8MJUc8jdpkXnL63veNls08lLZtQQh/3PgKU
	 cqJ9G5MEK0zZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF39392FF99;
	Tue, 31 Mar 2026 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] FDDI: defxx: Rate-limit memory allocation errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177492240604.2055536.1918723401028996049.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 02:00:06 +0000
References: <alpine.DEB.2.21.2603291236590.60268@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2603291236590.60268@angie.orcam.me.uk>
To: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273437-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DE4A3633C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Mar 2026 13:32:25 +0100 (BST) you wrote:
> Prevent the system from becoming unstable or unusable due to a flood of
> memory allocation error messages under memory pressure, e.g.:
> 
> [...]
> fddi0: Could not allocate receive buffer.  Dropping packet.
> fddi0: Could not allocate receive buffer.  Dropping packet.
> fddi0: Could not allocate receive buffer.  Dropping packet.
> fddi0: Could not allocate receive buffer.  Dropping packet.
> rcu: INFO: rcu_sched self-detected stall on CPU
> rcu: 	0-...!: (332 ticks this GP) idle=255c/1/0x40000000 softirq=16420123/16420123 fqs=0
> rcu: 	(t=2103 jiffies g=35680089 q=4 ncpus=1)
> rcu: rcu_sched kthread timer wakeup didn't happen for 2102 jiffies! g35680089 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
> rcu: 	Possible timer handling issue on cpu=0 timer-softirq=12779658
> rcu: rcu_sched kthread starved for 2103 jiffies! g35680089 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
> rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_sched       state:I stack:0     pid:14    tgid:14    ppid:2      flags:0x00004000
> Call Trace:
>  __schedule+0x258/0x580
>  schedule+0x19/0xa0
>  schedule_timeout+0x4a/0xb0
>  ? hrtimers_cpu_dying+0x1b0/0x1b0
>  rcu_gp_fqs_loop+0xb1/0x450
>  rcu_gp_kthread+0x9d/0x130
>  kthread+0xb2/0xe0
>  ? rcu_gp_init+0x4a0/0x4a0
>  ? kthread_park+0x90/0x90
>  ret_from_fork+0x2d/0x50
>  ? kthread_park+0x90/0x90
>  ret_from_fork_asm+0x12/0x20
>  entry_INT80_32+0x10d/0x10d
> CPU: 0 UID: 500 PID: 21895 Comm: 31370.exe Not tainted 6.13.0-dirty #2
> 
> [...]

Here is the summary with links:
  - [net-next] FDDI: defxx: Rate-limit memory allocation errors
    https://git.kernel.org/netdev/net-next/c/7fae6616704a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



