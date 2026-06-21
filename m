Return-Path: <netdev+bounces-300917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2RSWKzxfOGqIbgcAu9opvQ
	(envelope-from <netdev+bounces-300917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:01:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1164B6ABAF3
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:01:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="KY4+6B/M";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300917-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300917-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A01BE3018757
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA466372B2F;
	Sun, 21 Jun 2026 22:01:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C022A80D;
	Sun, 21 Jun 2026 22:01:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079270; cv=none; b=hZyMTo3KbTlCxY3YW9LSM9vytiFYgOvzNm/Srfg5VV5CipiV7RmBa/OLxOaPbpO3Gpsdecmj5RgmRkqGbPbl+2sjU+Vd+7neGNtbcgdBYVzpnQ5VoawGBJ6GnTYYUwxnlJP9MFb6Eo4titRw+b+IuZJgmhPhrRuBMYmykZV2xtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079270; c=relaxed/simple;
	bh=HvIGwda8vyy9Q97Lm6Lw9D30Ik/vpNIlmYqlGEITw6o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MJKgD//p+R8hHZxB4/3WGw/2PcqlOIxhQlJplRA6KyZCdIdPULsE+DqFNAdgXdD2bffjIfv2GBmgRPWBkrA2aou3gtkwwuajRK07UmDhNmwG1IWOfrn29DF0H0vkpq730amAQMRZvub5XsYUnm+iglVgnDxmtQBfBRYpyN78syc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY4+6B/M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B111F000E9;
	Sun, 21 Jun 2026 22:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079269;
	bh=YRRWCj87TyN8d0ZgqWmknPC0bthOKmsmdaqp3IcegKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KY4+6B/Mmuk3c5QmAvWKUbkP8gI2raGFdR/WMWzS3mgHwUwyryYE/9VCon+2HUzom
	 vP+OGpZounVUk5/Vc4OJZ5f+i15230tQ+1bt5o/XdVByTgCHOB6taBKpfSkq66stN/
	 iCEeIpnSKaHT50rMiXZKVFS7/4vZfCfsTtkedSRW2lz9UW99x0VHq0SO6/OK+ZGN29
	 8x5vyQ09uKpSc1rxgTsDnjxx6eDEe8jkHzmrufnTDRKjkVN0GMoyEvohsRQZM9bwJL
	 aIJXJd/rNmLDVJqwYx/hcPKQg7vtqC0ce3Nvu2g6Ow4yYeUwQFRJ255fAfk5jRw5nx
	 8Vi0SK4JcS+1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BB13AAA6EA;
	Sun, 21 Jun 2026 22:01:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] octeontx2-af: mcs: Fix unsupported secy stats read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178207926061.516339.13325997406884773959.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:01:00 +0000
References: <1781636420-19816-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1781636420-19816-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
 bbhushan2@marvell.com, rkannoth@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300917-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:rkannoth@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1164B6ABAF3

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 00:30:18 +0530 you wrote:
> From: Geetha sowjanya <gakula@marvell.com>
> 
> Secy control stats counter doesn't exist for CNF10KB platform.
> Skip reading this respective register for CNF10KB silicon while
> fetching secy stats.
> 
> Fixes: 9312150af8da ("octeontx2-af: cn10k: mcs: Support for stats collection")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-af: mcs: Fix unsupported secy stats read
    https://git.kernel.org/netdev/net/c/d4b7440f7316

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



