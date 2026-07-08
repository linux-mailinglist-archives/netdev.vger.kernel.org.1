Return-Path: <netdev+bounces-305744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 03PgI3AiTmpjDwIAu9opvQ
	(envelope-from <netdev+bounces-305744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:12:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 255F372416E
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:12:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cQ7sce7o;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305744-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305744-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C0873004F04
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868638757B;
	Wed,  8 Jul 2026 10:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C92BB17;
	Wed,  8 Jul 2026 10:10:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505427; cv=none; b=nJZNXJbwWp+AIszDjQmpq1y/vvx3IfyDREDvw1jZvJwOs4+0UIthfJuIxBBc6PIX/PKw/A5FUCBxUk9qpV3NTHgEhsL0uBrzvynYzYwHv9KXtGf+hC6EkmH0xnOd+F3sTS0alEepoFyUj9lbjUa6J+9NBUzCjs7hSWKE9tIyhWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505427; c=relaxed/simple;
	bh=f08AC+yNRiUuBV4DJx2I3esPx7GBlrCdqRbNHej8wBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IcfeJVHR1cmJoJZukg/HOsKmdxFxtTXVWOs9uO9ihg1kARwh6egVtnG+yePttXQ25O+2ahiv+QneUy6k9f3X2AQWHhFv71dpRpKU8osrJi5C7nff8QbMmbaxNs9rb10SBl+SrW/WUV4mzvxoytd0thpNsuJLPBt6z+grr0iF6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ7sce7o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B77C1F000E9;
	Wed,  8 Jul 2026 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783505426;
	bh=3yEgUHaM5YPEQt6gJNCTpq3giBcRh5DuqpKaF6jFjbg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cQ7sce7o77fMFjsys+aDV1k0K/S7MdJeBX5cKTzrOruB92R6Ypts0Kh3/XIBrK98W
	 QsTrgwLHd4lPxb8UxxQx1fF5Qs/opaP39BaAFcX9WoKmiSCSTfVzoYedpYhYqTM2kv
	 wTwBd5gqL44i2NTlMGGhjzwYHafd9tnzm4KSk65nSUtSLJi4IlKyoiOEO7K6GwbQkl
	 h/U2NNv23crXRN76TpT6CbuoqQpdJmQYYQcTzGXLK1xsMkyi6A3pNwdFgD64c7NGSa
	 PrJZ+jJg/0wFu4q1EdujlyW95MmWUssSNwpgLANeRm6FfioxBL+KWIle0lgDCanVoe
	 jynG+zYqUriSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AD4392664B;
	Wed,  8 Jul 2026 10:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] octeontx2-pf: check DMAC extraction support before
 filtering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178350540539.2415816.15321558718099935107.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 10:10:05 +0000
References: <20260702033451.2969880-1-nshettyj@marvell.com>
In-Reply-To: <20260702033451.2969880-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 naveenm@marvell.com, tduszynski@marvell.com, sumang@marvell.com,
 hramamurthy@google.com, rkannoth@marvell.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305744-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:nshettyj@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:naveenm@marvell.com,m:tduszynski@marvell.com,m:sumang@marvell.com,m:hramamurthy@google.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 255F372416E

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 2 Jul 2026 09:04:51 +0530 you wrote:
> From: Suman Ghosh <sumang@marvell.com>
> 
> Currently, configuring a VF MAC address via the PF (e.g., 'ip link
> set <pf> vf 0 mac <mac>') blindly attempts to install a DMAC-based
> hardware filter. However, the hardware parser profile might not
> support DMAC extraction.
> 
> [...]

Here is the summary with links:
  - [net,v4] octeontx2-pf: check DMAC extraction support before filtering
    https://git.kernel.org/netdev/net/c/235acadd3105

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



