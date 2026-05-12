Return-Path: <netdev+bounces-286910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOPWAFiHAmpXuAEAu9opvQ
	(envelope-from <netdev+bounces-286910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:50:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9178B518733
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E65E300888B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52B122E3E9;
	Tue, 12 May 2026 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4iblC+C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C5538332D
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550592; cv=none; b=S4XkdtcFvvLLsjDm/RN6W9w1i69uijjOGlU8oE2KwoKG26PgVwi1o0zOPDss/GL4E0NtHuGNCYJUZyuRNCKIgskVgKyWyYZWr9Cmx0Vq6bTkMtocsVburk2PVduQnSExFy0uIi6WcMWfXvHL9qTQiHCFdI/WELFEPEZbIYT2oqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550592; c=relaxed/simple;
	bh=NV5b6NwwkAgtoU2IWjWPEq7I92+SUwMmlcy+jw2pshM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nmu+EY1d8Dyj4lZBerL+v4yxoEMLiwZWFat0ryVLTMRQM7IE3fDvxCtFjM2rG8s93AIze34dbJcoVLawdHs4aQv4TgP/LkawSP0kUtsWD8Nm1TwarFkIshU4VJ5mHWVoInrGfbazgXfzntmgXSRh5D9h8n45cddNTNxNVNlFEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4iblC+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F099C2BCB0;
	Tue, 12 May 2026 01:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778550592;
	bh=NV5b6NwwkAgtoU2IWjWPEq7I92+SUwMmlcy+jw2pshM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j4iblC+CA2AuxcGn5ANir1mDOWf8x0S8pU8jfTyN6GGUP/fqIy1efplfxKRQvBaxa
	 pw84qK1NrgCiezYfEmoRR5Z9C0Z50mEt6BEqndCbc0STYEp4BHOpl0dyQZUw3Vuivq
	 Ze4bS316gr6TmH0g+7NjyJq9iJx51NEVFN9uRy7PQGot+AXw2jmrGOFOMFpSA/QCan
	 y5xTB3rFZHG+5MmHNGCgIo69ujiFzGepD988fyw7gJobItE0Hf4o7LyoxB+I5g7XwJ
	 CaRQAnt3HYgZsjFaPd08LfgOySgk8zbjRCJjn9nt0swLCfRQeXPSbr7XHZC8mK3pJq
	 HBwAyBfLUo47Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BB939308E9;
	Tue, 12 May 2026 01:49:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/8] net/sched: prepare lockless qdisc dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177855053848.2567715.10461030024726644862.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 01:48:58 +0000
References: <20260510091455.4039245-1-edumazet@google.com>
In-Reply-To: <20260510091455.4039245-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, victor@mojatatu.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 9178B518733
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-286910-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 10 May 2026 09:14:47 +0000 you wrote:
> Goal is to no longer acquire RTNL in qdisc dumps.
> 
> This series annotate data-races, and change mq and mq_prio to
> no longer acquire children qdisc spinlocks.
> 
> v2: addressed sashiko (and Victor Nogueira) feedback.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/8] net/sched: add READ_ONCE() in gnet_stats_add_queue[_cpu]
    https://git.kernel.org/netdev/net-next/c/a00073324266
  - [v2,net-next,2/8] net/sched: add qdisc_qlen_inc() and qdisc_qlen_dec()
    https://git.kernel.org/netdev/net-next/c/863cd7865201
  - [v2,net-next,3/8] net/sched: annotate data-races around sch->qstats.backlog
    https://git.kernel.org/netdev/net-next/c/0e5b05f44d81
  - [v2,net-next,4/8] net/sched: add qdisc_qlen_lockless() helper
    https://git.kernel.org/netdev/net-next/c/554e96a47a84
  - [v2,net-next,5/8] net/sched: add const qualifiers to gnet_stats helpers
    https://git.kernel.org/netdev/net-next/c/5b12bd5c474b
  - [v2,net-next,6/8] net/sched: mq: no longer acquire qdisc spinlocks in dump operations
    https://git.kernel.org/netdev/net-next/c/4f07179f4006
  - [v2,net-next,7/8] net/sched: mq_prio: no longer acquire qdisc spinlocks in mqprio_dump()
    https://git.kernel.org/netdev/net-next/c/bb19ce4c4333
  - [v2,net-next,8/8] net/sched: mq_prio: no longer acquire qdisc spinlocks in mqprio_dump_class_stats()
    https://git.kernel.org/netdev/net-next/c/881f7c5eff30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



