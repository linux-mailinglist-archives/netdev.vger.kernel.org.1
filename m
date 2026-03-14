Return-Path: <netdev+bounces-267758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eeK2CRKGtWm81QAAu9opvQ
	(envelope-from <netdev+bounces-267758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:00:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3B828DC12
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC9203011113
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F28314D37;
	Sat, 14 Mar 2026 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAzfEjDl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05502347DD
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504015; cv=none; b=Kk3SX6SwBDhswKMSyzhC8iJX5y0emTCpDgj33J6/FvYko3Ls3fNzIq+tcdFb89+0shP8cFKvRWO+0bQcpRsk1S24yK15F3+YHJcnAwjPHs79g/3kTilFgjBr0/DqvF2JWA9NTs35cE5DmHH88Vg63/McjuTDS7vKxjJXLCzIJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504015; c=relaxed/simple;
	bh=P+5gY91NAYCFnuFppeN3Uj6RfpICg2V6hK72MUu3mqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z3vjqnkGjBF82BNQpM/yW6UpML11FCHGjGDkMAKKWDkcC6IxMRxwSS0ieufOS4TdK+d+ywycw+ChPXkADCANJ17QfdtWkL0he4oTciOIrSXrjDjfXLAuD/oUlKIBR4QSiq1pgrd/b6Se05Fy2fi1inDdEFvB2M6yymBLnEqTCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAzfEjDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88826C116C6;
	Sat, 14 Mar 2026 16:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773504014;
	bh=P+5gY91NAYCFnuFppeN3Uj6RfpICg2V6hK72MUu3mqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OAzfEjDlFSN5RVBRKb5DNcUOhM9+GivgWLW2ASACVMUgHGjYvXpRs8Y1vWBXHl7u2
	 ChKIg7eR5lspUDSsKEFCP7qY+jx9LjJ0W+5O+Vsa0ooNdoYOWBvtrkwflO6FK9QZM9
	 mel6fbmA4TjeGtr+oXq90B+q8rsV6Pg8QheEcxWvC37S06Oau5uDG1957ti6WQbSw8
	 WSHZrp9fFNlYvZRu4xMN/e/cEQaxS9h823xIuTPWPE9RSLeZomO2uT1YG1wMgpozD1
	 c38Zgs4tFo+yi/Ur0+4DTcQcSGDNJ0b8xLifCma95PsTOvh+efgMM+Y4BWhfpDWEWu
	 GxWJ/pCt084IQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02ED03808200;
	Sat, 14 Mar 2026 16:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: add SKB_DROP_REASON_RECURSION_LIMIT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177350400879.1721007.15343462408844304021.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 16:00:08 +0000
References: <20260312201824.203093-1-edumazet@google.com>
In-Reply-To: <20260312201824.203093-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-267758-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A3B828DC12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 20:18:22 +0000 you wrote:
> Add a new drop reason : SKB_DROP_REASON_RECURSION_LIMIT
> 
> Used for packets dropped in a too deep virtual device chain,
> from tunnels and __dev_queue_xmit()
> 
> __dev_queue_xmit() can also return SKB_DROP_REASON_DEV_READY
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: dropreason: add SKB_DROP_REASON_RECURSION_LIMIT
    https://git.kernel.org/netdev/net-next/c/d15d3de94a47
  - [net-next,2/2] net: plumb drop reasons to __dev_queue_xmit()
    https://git.kernel.org/netdev/net-next/c/045f977dd4eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



