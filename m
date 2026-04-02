Return-Path: <netdev+bounces-274318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB20DsLOzWnghgYAu9opvQ
	(envelope-from <netdev+bounces-274318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:04:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBE9382882
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95876310FF1C
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 02:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AA233DEC8;
	Thu,  2 Apr 2026 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M47Kjgd0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2333CE88
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095235; cv=none; b=g6s4zXthwHsmrwydU7CMDdjcoQEt5vpJlpS8Dm2uo2nvVA/RA2sGYDFMojrDUQ4kPp8+paV3A327mjRi49cJduXGbjt3RsmOMFCs5kBOruF+qq6sGaDCuN9ZlDLzBFiwcOkEz0jYrz9L0Q3LyXykFMQNvNuxy7E6EqrLVyHobYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095235; c=relaxed/simple;
	bh=YFP4cz+J0n3OPD5rfOTT33MkldmBzNcc6QJE6R5H3g8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SQfbuyu4CI2eEEpa6h98Is0StyPKShx9BEbIfGD56JBQtIlZY3qJrgKaP+VRh/A7X7pKIuAVS/C00w9VNgWXRjdnuHwzUTwwtyQ25whPPCmWFdCIL8DyQTu/fBO8BVOOcqBYLQtfpg6CdopWsbRsIjC0tkmEnjPC31y9exoKMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M47Kjgd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AEDC116C6;
	Thu,  2 Apr 2026 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775095234;
	bh=YFP4cz+J0n3OPD5rfOTT33MkldmBzNcc6QJE6R5H3g8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M47Kjgd0YDLfEHzQy5invGU8GFiQ8BA/o5JlhVcs3C1P6GOKEL6fmi+eEJPMsQJyV
	 B9eBBv6/lActwayMjtGrliG06gFfNKzll3J8zdNq1ZyqmCUVbWOo/0ahWRJ7orajDg
	 SXSC2uZHmQpv5cCGf+x68bDV1+qJzpAu9qsKSgpR6E5EHyLqnM7GEYgLwLUaSiSgcl
	 LyHcAyBge8EMspYok2cbo0NsCHOpY+s4E6ZRRdgilqfXNUir6Iefw5tAddJ6Fu3oyH
	 nBHP7OMCbA9t0aFctqD+gdIq24WZomgie+4N8UjfZm31CsVy2BPzGV6f9wT1Q/YGCo
	 KwOslGzljWVJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DBC3808203;
	Thu,  2 Apr 2026 02:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv6: move ip6_dst_hoplimit() to
 net/ipv6/ip6_output.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177509521753.3948497.7321062786779767457.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 02:00:17 +0000
References: <20260331174722.4128061-1-edumazet@google.com>
In-Reply-To: <20260331174722.4128061-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 fmancera@suse.de, kuniyu@google.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,suse.de,google.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-274318-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADBE9382882
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 31 Mar 2026 17:47:22 +0000 you wrote:
> Move ip6_dst_hoplimit() to net/ipv6/ip6_output.c so that compiler
> can (auto)inline it from ip6_xmit().
> 
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-11 (-11)
> Function                                     old     new   delta
> ip6_xmit                                    1684    1673     -11
> Total: Before=29655407, After=29655396, chg -0.00%
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv6: move ip6_dst_hoplimit() to net/ipv6/ip6_output.c
    https://git.kernel.org/netdev/net-next/c/63081dec9e37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



