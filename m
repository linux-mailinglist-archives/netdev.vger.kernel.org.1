Return-Path: <netdev+bounces-264137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DH0J1roqGmKygAAu9opvQ
	(envelope-from <netdev+bounces-264137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:20:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0135920A269
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D56730143F4
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EF91DDA18;
	Thu,  5 Mar 2026 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGA2VRu1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA181A01BE
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677206; cv=none; b=f8LOFuI3nF8K4ucKGPCC/5A+kooeEbtqwBv/QTNWnRDQ8M9QbCxc286X1xqRv4rGKiMfimqNanruQditbzDZnD/FrbVGHmORV7HMQMp8kP4BMMmPbCnu2xq1og/kM/rZMiiiWRWndBMd3Wja3kbtqonOYKlMw4b+I/s/Cm3xRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677206; c=relaxed/simple;
	bh=9UO8lt9v7GGpMmP6oi4Pe0/s9d/c1+g3VeidezzGfmA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uku62iegN/i4A1QT/o11i+H8U+/r1rZXftqJvdKlE3A/xas6QV9v8a6WeKJtp9yhhHl9ylMr5ySOIbm7ub2HXGpOyKFxdGnZLlVXRn/sWEUehj/tHtG85f5AZyi5a+Hlk+OFOq7aofD6ZQrx+cfhRqbmKdPXZQOyKNoH0Y08Yek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGA2VRu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CED9C4CEF7;
	Thu,  5 Mar 2026 02:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772677206;
	bh=9UO8lt9v7GGpMmP6oi4Pe0/s9d/c1+g3VeidezzGfmA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VGA2VRu1fIxEm+FzUDIf0QmSZCkr0tN8l/kPnKW7Fy3RJ3ouio+vI04Isyy0eVcCG
	 8GoEXWnj73I6cfp5qy/h68KmettQVEK6BQb2dJuuWarmwXu3RO8aA+ffcALjRnwQuO
	 f3cfjFlvShNgocZdv1iaJCjjtAae0n4AxeqthnL9yOps2nyGLVMEIG8mx3AgS+2Y/d
	 GAoYe71fHMMyRqXzXBTCZSVPTlPQyemTrJhrA/KLzQM0WEG5IJmiDmi9dnKadDuZs4
	 F19OQ5Kkq++fmTBxVMhsWYz8cwuAaUTCkGw6Fyzigi5cGJF+IquFaR8hBmv/T2VsFH
	 k9yNLub4ZooOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030D93808200;
	Thu,  5 Mar 2026 02:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net_sched: sch_fq: clear q->band_pkt_count[] in
 fq_reset()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267720655.2482446.15302187063401500356.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 02:20:06 +0000
References: <20260304015640.961780-1-edumazet@google.com>
In-Reply-To: <20260304015640.961780-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, pkaligineedi@google.com, willemb@google.com
X-Rspamd-Queue-Id: 0135920A269
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-264137-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 01:56:40 +0000 you wrote:
> When/if a NIC resets, queues are deactivated by dev_deactivate_many(),
> then reactivated when the reset operation completes.
> 
> fq_reset() removes all the skbs from various queues.
> 
> If we do not clear q->band_pkt_count[], these counters keep growing
> and can eventually reach sch->limit, preventing new packets to be queued.
> 
> [...]

Here is the summary with links:
  - [net] net_sched: sch_fq: clear q->band_pkt_count[] in fq_reset()
    https://git.kernel.org/netdev/net/c/a4c2b8be2e53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



