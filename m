Return-Path: <netdev+bounces-281568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPLbOrUE8GlmNQEAu9opvQ
	(envelope-from <netdev+bounces-281568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:52:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5545B47C3E6
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5B053050454
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C12264B0;
	Tue, 28 Apr 2026 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3wdXUh8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12722206A7
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337464; cv=none; b=B8gB7de7kvgDDk4+vS1gauwDPFviLbZGqtS8tb9F8/GdkrX6rFKAKTsFgMdOT+uZsr9O4IByVixbR8/M2sYChXPaPN5mt3mMB32YtF+MrGfBYdlDOPy6o5SueJDTw0GTRhtKcN6PiD9JQsun6z8P48qSjYcvKOYqpyxd2Eary8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337464; c=relaxed/simple;
	bh=nT2fXU5V588e8PuFB1HzM5ZgdAQ5m25W76Jl2UloGSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dDrmndugf+FeSXvBdtJzmyOc4Y1FDsGS056ian6Iy8DmnqqTc/K/f21a21TR4POIIY4go5ZKUC6KcTGQL8JYC52WXPqiIrVy2HHpEKuBWmhx/VClo+06A8lIUKWb/t3PeXXhcgbXCcNFW0+d0czFuGrZhDLPtHDR/ocGFzJX97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3wdXUh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D31AC2BCB8;
	Tue, 28 Apr 2026 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337464;
	bh=nT2fXU5V588e8PuFB1HzM5ZgdAQ5m25W76Jl2UloGSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S3wdXUh8gdQpkmHwtKjTA95ynht+TnZGqjoj130/bS9ag8h0HoFm0S3xiyqjO3l96
	 44zA9x67xLKKcYe8ChAkLxiJsuJm0Haw3lcZZAevV2Ha3e0cSHyVdosBpeNNU17cml
	 WUGek1A188dNuE+0gFcHQikNSllRPTTXsivDC/TDXdeTN/uaHx3SgtE+sMELkZIg7O
	 4AnMb2j5dXBF3IaH6e3G4hHFQlPoSxXidRrcj1pBoznn1yMBYmXLwPqLxv6Ubwvdcz
	 9eyPhJ7EeIRVUlXg5ecqRb/AdHVJIuSDsPkjVaHMM442cbPUfChalcY9XjwBEck8GP
	 cHZLs/IR6LDwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E5438119DB;
	Tue, 28 Apr 2026 00:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_choke: annotate data-races in
 choke_dump_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733742130.177472.4102345239012474776.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 00:50:21 +0000
References: <20260423062839.2524324-1-edumazet@google.com>
In-Reply-To: <20260423062839.2524324-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 5545B47C3E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281568-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Apr 2026 06:28:39 +0000 you wrote:
> choke_dump_stats() only runs with RTNL held.
> It reads fields that can be changed in qdisc fast path.
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_choke: annotate data-races in choke_dump_stats()
    https://git.kernel.org/netdev/net/c/d3aeb889dcbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



