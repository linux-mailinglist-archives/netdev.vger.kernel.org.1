Return-Path: <netdev+bounces-295333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9cw+EWWqIWqFKwEAu9opvQ
	(envelope-from <netdev+bounces-295333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:40:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30347641EE0
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:40:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ccEOlVZ6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295333-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295333-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1FCD30FAF57
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7B847DFA2;
	Thu,  4 Jun 2026 16:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F9480946
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 16:20:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590023; cv=none; b=PVEVZNSCArZpB67NVKY97xaVTcqqt/VEkDQRNo6r1lgTNqoL6HNYudZQ6dMqLCKf00woKQnT/VZ1P9f1cLd0PFtaZ3pJDZu499+A1kJtvUWAwcsrlmTMXhg3a/1Fus8bHrRVorWL8ljL/YT4sr5mxMruxep11W1DdeXerNiDAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590023; c=relaxed/simple;
	bh=NhOYS5M9wbprkqVwoAauvCLAFAciNkwuDezF8z9wcXE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jNI13alFRIYac755E0xLfuJDpIrhHAbUSvw71rmHsEJUQydMxHoX2jGyI294aqXwxUwjO1yVq2kfmxPiHuXmQC+4g96XFLPHw145T7Js5XKb0TtQFkz3NVNiGFtXIuJgRVJ4T8C9ntOBakLQ5pbIWdp9PiCX9JRRpa8kz6pElo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccEOlVZ6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFEE1F00893;
	Thu,  4 Jun 2026 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780590020;
	bh=ZsmWTSXFoK1uQJIVgzeXjGea6fgt/mfuQncsTENa+1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ccEOlVZ6BbXudgVtIEo6Ivp8d7DAuQJ9zikzB/NPU2K/fAH8c3zi8ZquuiAznRnw/
	 nZMLRfdhIrF+WHlRfBhzR0q8P2qGlES69+RlnBdbsqqcWbqVdRacyvaOKCt1FA3uGm
	 ZTQrQaIBg5Ik3pdZ03/ZK7sqT9V8/0diOiBdMd6V5aakyD2HvJ7HP9W5FSJFha0ra6
	 zb0zpzq4+a2MYbnPLH9GeHSlR1+nGqPWMkP/CHXXVwPrMNZLMiq63AtqB68n/fEGTs
	 D2QcYAK4z4CuVOQmukvMCSxRVBVh/VFSP+GwshFPMvi6VsypigifkCCHIiHhgOL13D
	 USExLGGbX4YRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568E039309B7;
	Thu,  4 Jun 2026 16:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: annotate data-races arcound churn variables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178059002089.2502005.2403817673330222849.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:20:20 +0000
References: <20260603123514.388226-1-edumazet@google.com>
In-Reply-To: <20260603123514.388226-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, liuhangbin@gmail.com,
 jv@jvosburgh.net, andrew+netdev@lunn.ch
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,jvosburgh.net,lunn.ch];
	TAGGED_FROM(0.00)[bounces-295333-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:liuhangbin@gmail.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:ericdumazet@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30347641EE0

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 12:35:14 +0000 you wrote:
> These fields are updated asynchronously by the bonding state machine
> in ad_churn_machine() while holding bond->mode_lock.
> 
> bond_info_show_slave() and bond_fill_slave_info() read them without
> bond->mode_lock being held, we need to add READ_ONCE() and
> WRITE_ONCE() annotations.
> 
> [...]

Here is the summary with links:
  - [net] bonding: annotate data-races arcound churn variables
    https://git.kernel.org/netdev/net/c/b47ff80f280e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



