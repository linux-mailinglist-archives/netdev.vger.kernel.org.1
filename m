Return-Path: <netdev+bounces-283334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAFiBddM9Wm9KAIAu9opvQ
	(envelope-from <netdev+bounces-283334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 03:01:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 816254B08A3
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 03:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 646653010490
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 01:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA4828689B;
	Sat,  2 May 2026 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQkm+rnd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F11DC9B5
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777683666; cv=none; b=N58MT34Wte1nSleJhM/jafLaBMANIyA6SDlVg8BHeghQ0qXkbwrdUEq0WfDB4+SJLEBbnDZlsGZl29F9kZLtv3tej6bM40BLxJI+sJ1wVzFD+5qkx7g0Y2J/AY4s1J7U4HJ+MTrU2aIP02jceldyDsM5NILDq8e4pk5uRPBrjAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777683666; c=relaxed/simple;
	bh=9/Z+RvWwcOqdRIvhWenRes9U+CpdbaJbYCGRVTmA2rw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tUFsZFwMjYtFIK4x1bSpBGj7Mamw6b4TIvGTBxqZm8JxiZZrMtA0C4dhw2daNToUJFBjSYqCqGupFLjrzaCFVIGHNSAajjveFmnYUkNsG7LGgo1yZvt/P4VJMFsjsFl+1cAbHesQtwN87qvi2pCHF5T0AA0XdERcKE8e2C0Hfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQkm+rnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E63C2BCB4;
	Sat,  2 May 2026 01:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777683666;
	bh=9/Z+RvWwcOqdRIvhWenRes9U+CpdbaJbYCGRVTmA2rw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VQkm+rnddWpJolUBJ6K6KlHSOJOwsxqIChjICwPegzprMcbOixCUVuS1abUwdca9v
	 aw0m8LK/KiYNt78ucH8f0CaD8YOqyS/cUWEFrkVh0sHHTQ9Ky/Yz6bgeKeX6CaCNPQ
	 QwW/Z9efXnzuRulZCgu3wWpkGlHsRVG2CmBuA5x7jZVBu1pqswEMm/9xkCNSpSFxF5
	 1C6lt8e57PAH8TyQi7LGCcxEsuavU7RAnqe5RbQQNkVrFi1QuYO4Fm/ub5j/NZM8QJ
	 4yokdOhk/jiNhcCw4x5x+ZCCdEU7A4UcF7Oox4kzd4EoR54O1ct6l4EpxYGvpyuX4E
	 B3jrAAco2yvyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1C4380CEF5;
	Sat,  2 May 2026 01:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] tcp: move some fastpath fields to
 appropriate
 groups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177768361928.3679774.13507449339047395599.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 01:00:19 +0000
References: <20260430100021.211139-1-edumazet@google.com>
In-Reply-To: <20260430100021.211139-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 816254B08A3
X-Rspamd-Action: no action
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-283334-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 10:00:16 +0000 you wrote:
> Move following fields to better groups to increase data locality.
> 
> - delivered
> - delivered_ce
> - segs_in
> - segs_out
> - first_tx_mstamp
> - delivered_mstamp
> - max_packets_out
> - cwnd_usage_seq
> - rate_delivered
> - rate_interval_us
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] tcp: move tp->delivered and tp->delivered_ce to tcp_sock_write_tx group
    https://git.kernel.org/netdev/net-next/c/9f810527a343
  - [net-next,2/5] tcp: move tp->segs_in and tp->segs_out to tcp_sock_write_txrx group
    https://git.kernel.org/netdev/net-next/c/2b28dd212a8a
  - [net-next,3/5] tcp: move tp->first_tx_mstamp and tp->delivered_mstamp to tcp_sock_write_tx
    https://git.kernel.org/netdev/net-next/c/07db42c4b3eb
  - [net-next,4/5] tcp: move tp->bytes_acked to tcp_sock_write_tx group
    https://git.kernel.org/netdev/net-next/c/dd033ec406b4
  - [net-next,5/5] tcp: move max_packets_out, cwnd_usage_seq, rate_delivered and rate_interval_us to tcp_sock_write_tx group
    https://git.kernel.org/netdev/net-next/c/affe6c27651a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



