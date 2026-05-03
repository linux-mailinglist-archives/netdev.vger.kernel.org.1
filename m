Return-Path: <netdev+bounces-283498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NawbN5WS9mkpWgIAu9opvQ
	(envelope-from <netdev+bounces-283498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 02:11:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 787BA4B3C03
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 02:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5923430022DA
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 00:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEE040DFCB;
	Sun,  3 May 2026 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLSUQbgj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A747625
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767057; cv=none; b=Dzrbdi4UdgL2p/eaoZ5W00ZaJHzfFX66J9PIkDVZJImp2tMGEz0rVUMdQ5MOwSD+S8+XGsX7mcEcz35h6yokz8VvWK/t6shFDJ/1fVJbnm9Fs5kFZWNeIZyyLoPhwLyeBkA4CD3FrxdlbdtHlsqFwXh7tsrUuZ6lupXfoAa4IMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767057; c=relaxed/simple;
	bh=K0NOUkrcjL1BJFiZTDWTXtF5xjkbdbTHd5NgTgAeV24=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OJmSALuybCJufcS5v0yVHDSZuILJMmry70G29RX3x5qm3YgaOZF6gi7A3+LvIVXMe2Uiej01tjQfhB7XCESOcSw9EPNatQPHTtG7xZIgV88iWaGpAQpred0yBJQ/Ao4yN7HErPRmygayga4vj3c0YEGm+akOb0ZYAd5gQvuChX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLSUQbgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28077C19425;
	Sun,  3 May 2026 00:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777767057;
	bh=K0NOUkrcjL1BJFiZTDWTXtF5xjkbdbTHd5NgTgAeV24=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RLSUQbgjbmoFFm9YnlVlPFpWyNKskoJcU4WeVoYcL5hAr0+Q1gEj5P3k8RuuozNnw
	 PELlvt9do89HAsPvzofwWQVeYbk9E+zgGcGOYi0qtE6kHZ3uRBX3UhycOdjenTMCK/
	 TqdAfHDbFUjZrdmf78zvJPk5BGLi9HE5f+HLLJADGzIp89d+fnYH6FYkbPxW5b62w9
	 gzN/wVaTDFnrtyBCt19R26e5INIc7M9jd7MnrtzO6UQ/bcsUbk8LnB91CZGFv576Mk
	 djPZV4mNCG/W80v184sk0dnaD3Ku55JwquVNrJawyXExHZ4ToLp+baYB3jvfbsA6/b
	 zOefqkRY02IAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEA8380CFE5;
	Sun,  3 May 2026 00:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net/sched: sch_cake: annotate data-races in
 cake_dump_class_stats (series)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177776700930.3968668.15253436699791066420.git-patchwork-notify@kernel.org>
Date: Sun, 03 May 2026 00:10:09 +0000
References: <20260430061610.3503483-1-edumazet@google.com>
In-Reply-To: <20260430061610.3503483-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, toke@toke.dk, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 787BA4B3C03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,toke.dk,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-283498-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 06:16:08 +0000 you wrote:
> cake_dump_class_stats() runs without qdisc spinlock being held.
> 
> In this series (of two), I add READ_ONCE()/WRITE_ONCE() annotations for:
> 
> - flow->head
> - flow->dropped
> - b->backlogs[]
> - flow->deficit
> - flow->cvars.dropping
> - flow->cvars.count
> - flow->cvars.p_drop
> - flow->cvars.blue_timer
> - flow->cvars.drop_next
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: sch_cake: annotate data-races in cake_dump_class_stats (I)
    https://git.kernel.org/netdev/net/c/046111a1a35a
  - [net,2/2] net/sched: sch_cake: annotate data-races in cake_dump_class_stats (II)
    https://git.kernel.org/netdev/net/c/67dc6c56b871

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



