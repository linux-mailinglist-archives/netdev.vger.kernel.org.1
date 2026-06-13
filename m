Return-Path: <netdev+bounces-298931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U8yvHyQcLWrdbgQAu9opvQ
	(envelope-from <netdev+bounces-298931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:00:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D4F67E2FB
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:00:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S6kd7MIJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298931-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298931-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CC2F300F442
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AEF3AD512;
	Sat, 13 Jun 2026 09:00:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AEA3AD52E;
	Sat, 13 Jun 2026 09:00:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781341211; cv=none; b=Ulm1FIyNboEfC7Z6r7l5OnVGx6jTnSEzl2Rg1fNPM2DxiRkBvLsq0F5hNn9u6RsTVA2GUo6bxjotIlrbARkCFwL24/ybWafkiZfDbVdKKj+lLYvSvfgVxJJKRwKuOsZks76Bow+V5s9Rm79oNk/Q1HKYwHqKNupreZtuGmO7PrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781341211; c=relaxed/simple;
	bh=TjaYOgF3wr8ZhOE+5WZgHdlDnkPKF41xWLjlfnvrJEI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R3zSK2x7yZT9tye5WPTIwLP0njll63gHBxNHXAcF0gXKonAwT/YYC+8GvARV5u9t5Ze+oTcyW/RGokoMAAruxJnQhGwFkoryP2WNjW8BGt28qq8S0mGNsDxpHWFsoWKDmUo5lJn1SGR/4vldJ7HiMF19Z+N+MbR/NrMtXjypDiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6kd7MIJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01F41F000E9;
	Sat, 13 Jun 2026 09:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781341208;
	bh=f3EVXaidWBUDBukOfSvwu19nYqgtoWvs1fRjIR5kA3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S6kd7MIJmG8gTopL6j0WlEFnHWaWCJCNPN+wbc1IYxBuhIlB2Zs202F7h8EbTjeAP
	 VuWHP95nn4d3cWJpvHKf2K1xLNnUw5APnSbTm3Is43Om/fXuF9hy3Es05VhCbuInKk
	 BvYe2Mz/dl58dByFiQz/5ULNqwP3ytWmI7IjHRHRi7zFjEgu93A9siIfmahGlYx+YU
	 786TPi65oxSLkW6M2Tiw5LXSlzd401RvfvGreY76yuAGKq5RXAHHuvjt+uHbioRteS
	 NTl2p3pYXXz81rIsUcOlrkNUgz/fF+IPbhAQF6Rn634t/1Y/5pkzuAzJWLefAvwbql
	 A1RNN51wBPEdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568DB39EDE30;
	Sat, 13 Jun 2026 09:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] octeontx2-af: npc: Fix size of entry2cntr_map
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178134120489.1430056.8164436490843173619.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 09:00:04 +0000
References: <20260610022344.969774-1-rkannoth@marvell.com>
In-Reply-To: <20260610022344.969774-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, naveenm@marvell.com,
 netdev@vger.kernel.org, sbhatta@marvell.com, sgoutham@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298931-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:naveenm@marvell.com,m:netdev@vger.kernel.org,m:sbhatta@marvell.com,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03D4F67E2FB

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 10 Jun 2026 07:53:44 +0530 you wrote:
> KASAN prints below splat. This is caused by allocating counter for
> reserved mcam entry for cpt 2nd pass entry. But mcam->entry2cntr_map
> is not allocated for reserved entries.
> 
> BUG: KASAN: slab-out-of-bounds in npc_map_mcam_entry_and_cntr+0xb0/0x1a0
> Write of size 2 at addr ffff0001033e7ffe by task kworker/0:1/14
> 
> [...]

Here is the summary with links:
  - [v2,net] octeontx2-af: npc: Fix size of entry2cntr_map
    https://git.kernel.org/netdev/net/c/f9cd6fabe0e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



