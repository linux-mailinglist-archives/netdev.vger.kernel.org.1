Return-Path: <netdev+bounces-301495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ekmGFd//OmpnOAgAu9opvQ
	(envelope-from <netdev+bounces-301495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:51:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A4D6BA4F3
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:51:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bPXKYyds;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301495-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301495-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A261B3070D30
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7D73B14B6;
	Tue, 23 Jun 2026 21:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A213B83E3
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 21:50:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251429; cv=none; b=c62qSZJ4wXkZ+jmLbVEZvLp3l5gaKqd/afxai+n4b0bSElb7t4zDCaKw1N591bzUcE6HtbCv5ZMHFPx9R23+wsSQeeDLciBq2q17zXfbWTw4BuCTkcHI8ValdnSZkcZ2Cx/1l6aHYgL6AFjwwWxv1qe+sDaANCjRtiS4dTSovxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251429; c=relaxed/simple;
	bh=27mDXKHzwA5jaPNNiruOJY25oHKdh+cATyqTUAy+X+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XoUIfkUclArBSoyeF6PMduXfx8nxj47bxThH6R8y35/CtNwb3Y5+cdQ3qd/M4Ki5mMqlR17YR5hLKC8EWGue8W0s/jbgE4KOBzJz2diUq6Uca9S2a4jufyNMOSHKnbYNTvnDjhtOaSQeFBeKnH/X8omiONQHV2ddukpiD68RAEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPXKYyds; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2101F000E9;
	Tue, 23 Jun 2026 21:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782251428;
	bh=4fAKDFStunawYfR+vJ71JAKmRG4aqqliOYj5RDHTR0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bPXKYydsOh1cGeTvECjVQGF5o+3Zn2YsakLb2ITWP9ZoToCfw8LDerovGz8F0zt3x
	 8Xt0ZJIKt06w8RrKXhag8d1X1yMxmza7idZ8ho7a/o2c+t6IYm607U5X5NDGE9jx/C
	 6UKjZO5AwbYZywFHxv/gXNAcCV+3dZI1EVz8OzSeMCigJqNUIZnb6yvlCD+fuiOTyV
	 X6PkQPQ5VLOKL/gxQdzaa0n+W4nOYuWXjecuVMMswAx1z22aajKr/Lyvv4p8ef5v4b
	 pj4eorO3rXOZ3LHrlXn7udPuAZA9fKOu22KpasgtHX+CyXjphorPaQufv8dEvceHDE
	 cOWgByEMNoN7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93918393101D;
	Tue, 23 Jun 2026 21:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] veth: fix NAPI leak in XDP enable error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178225141707.2433118.6555336369645285304.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 21:50:17 +0000
References: <20260622111825.88337-1-edumazet@google.com>
In-Reply-To: <20260622111825.88337-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, groeck@google.com,
 bjorn.topel@intel.com, daniel@iogearbox.net, ilias.apalodimas@linaro.org,
 mst@redhat.com, tariqt@nvidia.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,google.com,intel.com,iogearbox.net,linaro.org,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301495-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:groeck@google.com,m:bjorn.topel@intel.com,m:daniel@iogearbox.net,m:ilias.apalodimas@linaro.org,m:mst@redhat.com,m:tariqt@nvidia.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98A4D6BA4F3

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jun 2026 11:18:25 +0000 you wrote:
> During XDP enablement in veth, if xdp_rxq_info_reg() or
> xdp_rxq_info_reg_mem_model() fails, the driver rolls back the changes.
> 
> However, the rollback loop:
> 	for (i--; i >= start; i--) {
> 
> decrements the loop index 'i' before the first iteration. This
> correctly skips unregistering the rxq for the failed index 'i' (as
> registration failed or was already cleaned up), but it also
> erroneously skips calling netif_napi_deli() for rq[i].xdp_napi.
> 
> [...]

Here is the summary with links:
  - [net] veth: fix NAPI leak in XDP enable error path
    https://git.kernel.org/netdev/net/c/6739027cb72d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



