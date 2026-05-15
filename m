Return-Path: <netdev+bounces-288123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCn4NUBnBmrOjQIAu9opvQ
	(envelope-from <netdev+bounces-288123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:22:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F799547F7A
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF4BD304BF32
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A3C202C29;
	Fri, 15 May 2026 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/7EEjSv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08520297C
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804478; cv=none; b=r61SfER6dQrDBp+0vcmaGZd6QLoQfaaw/L0e/tXEn/dOb+2M0CaqtcoKLJ+3Pmy5/U47XDZHAs3F44rDrlfwStsPh0dtfJT83HyMF58QRaXWPvaak1t+OJ625uey9Ubmznri6Xfl2j2YaS8Ap6aNMA5923L/SaU8SG5U7qwMs3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804478; c=relaxed/simple;
	bh=nb4FiqZJBnImGOG9/gEjUlNq5dYB7k+I+TJzlXSp/z0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wgw11zrEoxz4PiEgT/a+TKNzih68/o5O34tdLn+7+FXUt1G2xATLQ6VlbhurbBJCPJKYNSwoFK6Hc4mYAk7gNOYJeA0LRXYCwHFNse/6QU0kCEqPNf6zBGFfP1JPfuUXYWxbO4RbU7arz0FEHQB+x1+p5SjBAbRmYdkpfxYEWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/7EEjSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7988C2BCB3;
	Fri, 15 May 2026 00:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804478;
	bh=nb4FiqZJBnImGOG9/gEjUlNq5dYB7k+I+TJzlXSp/z0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V/7EEjSv9S4/WDyDKz76efpNutR5uu5u5kGezkBr0eD3LQ0qBAHMRuIwjm8MemxK6
	 t6oT5w+rIRNv9W+rkYI4FMPKJJgUbIikZiMv/ABgkGXpC2KfoKFSw0lDG7o9/PXUb3
	 6fPLZJs9UR4H3xsOnoRBJF2cstM3iAe30+0L9IicguSCZWl0d7AI6fKsoXQLWXwmPt
	 +LvxWiOVsglXkPAehWwojpufLavYH2Aflxpyc3JWEjGyfsy+57uPakNzo2ttb53OdV
	 46yp/nKeWKiwYpE6z0i8Z2riLQ8aWH77nasy/xF1anNdBFrB8I5714oE0dyMKCoxaM
	 sA0trpEERHNaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DE139E4DB3;
	Fri, 15 May 2026 00:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net/sched: changes around
 qdisc_qstats_qlen_backlog()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880442228.134878.3806192923623585975.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 00:20:22 +0000
References: <20260513080853.1383975-1-edumazet@google.com>
In-Reply-To: <20260513080853.1383975-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, jiri@resnulli.us, idosch@nvidia.com,
 dsahern@kernel.org, toke@toke.dk, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 6F799547F7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288123-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,nvidia.com,toke.dk,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 08:08:50 +0000 you wrote:
> First patch makes clear qdisc_qstats_qlen_backlog() runs locklessly.
> 
> Second patch changes ioam6 to not acquire qdisc spinlock anymore.
> 
> Third pach adds missing READ_ONCE()/WRITE_ONCE() annotations in hfsc.
> 
> htb still needs fixes, I will take care of them separately.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net/sched: qdisc_qstats_qlen_backlog() runs locklessly
    https://git.kernel.org/netdev/net-next/c/72a1795999df
  - [net-next,2/3] net: ioam6: no longer acquire qdisc spinlock while calling qdisc_qstats_qlen_backlog()
    https://git.kernel.org/netdev/net-next/c/d3f3c8a4d1f6
  - [net-next,3/3] net/sched: sch_hfsc: annotate data-races in hfsc_dump_class_stats()
    https://git.kernel.org/netdev/net-next/c/e300c7d470ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



