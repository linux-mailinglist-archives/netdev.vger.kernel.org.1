Return-Path: <netdev+bounces-281562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP7dEBwC8GnYNAEAu9opvQ
	(envelope-from <netdev+bounces-281562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:41:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C047C37F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72AC03010EC4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B554B13635E;
	Tue, 28 Apr 2026 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svl00xlX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1D1BC2A
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777336857; cv=none; b=T5YAWRG/n67ywfskAj8Ak5gbVPviOcdZySnACSdxJVPtWtj3714YXE+whxnasGuQy+jAWyfH0Am8YqbzuNhZRf7isELthoEvwRfqweh/0GOldxhMof0f0EFBIgG6knUM9oNEMC+YspL2PCXooo+DJndi3eKKZUcZkiOMwEKlGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777336857; c=relaxed/simple;
	bh=bwvdaIaqMPcKBGc9y3qmWVbeLgFs6UCPYy+IKrZ1nqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jq4PEwYFzY2HEyMebmuhOi/9/JVpTd4lejlO6rLpNkoSroZwhn0fAnTYKFEVlWi4nsYfX+FATnOBfI7CESlACIXHY23gAkYfaz6X1MI1f/zWGIHLnD09FGeSBeoNSOGz//mgn0ClS9KBtV0md+K/WFgQhOikNdbMHY0wbKkE++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svl00xlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E4AC19425;
	Tue, 28 Apr 2026 00:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777336857;
	bh=bwvdaIaqMPcKBGc9y3qmWVbeLgFs6UCPYy+IKrZ1nqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Svl00xlXjZGvPs/nHP86aatIXhOO8FXsyt0Bb07S8/NBH8RG4j8gRerpZlM6yBnLf
	 wGequqVLuvScSMYtIF0ZsixjOkzlhtkf1K8w1FIbQlteGGrdbqxDZM2fRm0uFeJaHs
	 3LZiNQPorZLwp9Ocn8vn3R2wWBKE/l2pxBdiNrH+XCRG3dkZ55mMV7zj4bzWVWuJvy
	 LW66yJs5RvB5WK5bvAiQybLmCUGYPfM4jQgTzB+eH6R8GNDs79F79SH0DGV48ojNKo
	 pB+edsmKx6qVEjGM+CR/W9TWSegDNrbjfKNaCkSUsLECjvsMslvgrzjBbGc9n2f65i
	 15QNPsUDN3DYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E6638119DB;
	Tue, 28 Apr 2026 00:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 net 0/6] netem: bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733681455.174583.13249817958251162504.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 00:40:14 +0000
References: <20260418032027.900913-1-stephen@networkplumber.org>
In-Reply-To: <20260418032027.900913-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
 horms@kernel.org
X-Rspamd-Queue-Id: B38C047C37F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281562-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Apr 2026 20:19:38 -0700 you wrote:
> These bugs were found when doing AI-assisted review of sch_netem.c
> during investigation of the packet duplication recursion problem
> addressed in Jamal's series.
> 
> The fixes cover:
> 
>  - probability gaps in the 4-state Markov loss model
>  - queue limit not accounting for reordered packets
>  - PRNG reseeded on every tc change, breaking reproducibility
>  - slot configuration not validated (inverted ranges, negative
>    delays, negative limits)
>  - slot delay arithmetic overflow for ranges above ~2.1 seconds
>  - negative latency and jitter wrapping to huge time_to_send
>    values via u64 arithmetic
> 
> [...]

Here is the summary with links:
  - [net,v8,1/6] net/sched: netem: fix probability gaps in 4-state loss model
    https://git.kernel.org/netdev/net/c/732b463449fd
  - [net,v8,2/6] net/sched: netem: fix queue limit check to include reordered packets
    https://git.kernel.org/netdev/net/c/4185701fcce6
  - [net,v8,3/6] net/sched: netem: only reseed PRNG when seed is explicitly provided
    https://git.kernel.org/netdev/net/c/986afaf80994
  - [net,v8,4/6] net/sched: netem: validate slot configuration
    https://git.kernel.org/netdev/net/c/01801c359a74
  - [net,v8,5/6] net/sched: netem: fix slot delay calculation overflow
    https://git.kernel.org/netdev/net/c/51e94e1e2fef
  - [net,v8,6/6] net/sched: netem: check for negative latency and jitter
    https://git.kernel.org/netdev/net/c/90be9fedb218

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



