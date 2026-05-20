Return-Path: <netdev+bounces-289687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEF3ArMODWpxswUAu9opvQ
	(envelope-from <netdev+bounces-289687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:30:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8CF5868BE
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C586301227C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD652DF137;
	Wed, 20 May 2026 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5B8zQvz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49D2DCF6C
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240599; cv=none; b=bBggLyRADP5enwR8wUpPg6RtVnk0r1oTZjYgsV7PgtYBL/kz1l8+vN5IRK17CcHsM/AFwYhulTVHL9dBtilWRfHrCIvDjzRTb60yS/UHZQZv9a85opKYoLcgolC177P14kpuunJJ3xYrxjyHQNO7J7yDdCtyJIHUOt2udO95bLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240599; c=relaxed/simple;
	bh=sM1L1zx+i2ahd/cTMDH9+znC4xMTO3u/lXS6BOMeSBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vCwYGSciyxeApcYENOeb6cPaW+fh5x/AgQrVDUvImg2Tny8vldAu5csnaBD8aemY0hY9HRDTiL5rRqJu6geKZaEL8Kw419VFn9YmCDTLBlYsIDVyjdUEv27kJFGsMnZQoOz7yYhjcuzMjEeupCqeMaKusZm0L+zBkL6vgSHXdrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5B8zQvz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846071F000E9;
	Wed, 20 May 2026 01:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779240598;
	bh=jszwEy24nLcTVgF3m5AFIH/l9o58q+amtk0RnAFl0DY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l5B8zQvzlECZ2ERhen3wNV1X03DG0ukqKYw5UIO1KAiA37ppkfBphvmUUKeLXDGJq
	 GOYcvTHW66fbzXNZVaFJjKRWx76OpsVSrV4WLBU/Z/tOIAIdfJ1lNNnNZwLqlBRYdf
	 Si3cAsr3CbjYfwNmRG+HylhNDvsqqxt5BBcX+93RBJdJJe+noXCWsrceAVMOwEep1B
	 bzPx+gj5PbA7qM07TOMAXJ+07P3ujRJ8DfSQyaIkB7oO3n2T4VnBZviui2bPsLOeyh
	 j2jo0MB1EB8Waly9jiOKtuu5o144l/fy5zYOlWDrxDPh4j/TPrOhxBqF9rUvusVD2Q
	 lVchhj+4EojDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939B4383BF53;
	Wed, 20 May 2026 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] bridge: mcast: Fix a possible use-after-free when
 removing a bridge port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924060914.2943546.7719678973905052337.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 01:30:09 +0000
References: <20260517121122.188333-1-idosch@nvidia.com>
In-Reply-To: <20260517121122.188333-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, horms@kernel.org, dsahern@kernel.org,
 yongwang@nvidia.com, aroulin@nvidia.com, petrm@nvidia.com, tglx@kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289687-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9F8CF5868BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 17 May 2026 15:11:20 +0300 you wrote:
> Patch #1 fixes a possible use-after-free when removing a bridge port.
> 
> Patch #2 adds a test case that triggers the problem.
> 
> In net-next we can:
> 
> 1. Add DEBUG_NET_WARN_ON_ONCE() when a port multicast context is
> de-initialized while enabled.
> 
> [...]

Here is the summary with links:
  - [net,1/2] bridge: mcast: Fix a possible use-after-free when removing a bridge port
    https://git.kernel.org/netdev/net/c/4df78ff02629
  - [net,2/2] selftests: bridge_vlan_mcast: Test toggling of multicast snooping
    https://git.kernel.org/netdev/net/c/ae743a8ca8db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



