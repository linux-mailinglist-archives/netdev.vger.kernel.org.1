Return-Path: <netdev+bounces-298852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cH7pFMerLGpnVAQAu9opvQ
	(envelope-from <netdev+bounces-298852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:00:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5545D67D604
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:00:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Euke2X+S;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298852-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298852-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A33EA30D0007
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4A5235358;
	Sat, 13 Jun 2026 01:00:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8CF266B46
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:00:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312433; cv=none; b=UF89kSZSr/CHoteT2cptDN01nJ+/me+05QtKgo75c3YoZBryhqTIrUnALAJ7hfE0f9Os9x4om2bAMO64W7c7sqbIJXjiA7r6rwbUXPL6M5i0Cdo9E4z0gQU8RScZ3ZOu5cNB/sZ2qwF0EXOqs/KVW+uv18URE4t7EJr0isvHlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312433; c=relaxed/simple;
	bh=7yLtn/sHt+SRrikGiRqCkR9L97ZRwqdmB4AJdsmaPyk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NqspiA112dIaZ4LhcXA9cCM6huHtasWr/gYpno/VUkIxBFsO2GK9Qvw2NqCwvnlHtvg1SdWpLBizxcuTxS5mGDNXtvQ87Uex06lpNJN7ZU3jsc7Et+lfMuUCQEJT2kKpRS9jX6KQdU0AJBcHUWQZDUVxIDLH3eUBEHTiMDc5dBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Euke2X+S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4647E1F000E9;
	Sat, 13 Jun 2026 01:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781312431;
	bh=vDC3gdx1kG07b3DzyK33N8EzugMHq7voHog/GHFVPmQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Euke2X+S8lVL1Zj8C73eOPQVTRpC4LIC7JeBp4/LLIX1H0Yd9lgBGKV4TDsYP/2LO
	 mc7vuU3/m/cApRv9QpoxGJcMeBR7bv+ggBz1lTO/XeC7NQ//lPg1SewERUKYTsdXn1
	 5JiDvLxD7rKKu7cdppbUXKs4UiaMaCCRjPlBlkJQAkiHkqtI61CeTV0tQ56p2O1kpf
	 RPY0HifWbc04wV6swI17lPNmGN4DlvATcmgd5cEuRwXItImhxGErwypF1k6GISItbH
	 DqFuxiEDUK+4TAUlUSHKn0njcHYFtFRwkqFS51wMpExKjMutF6GiQmybXm3T2SfilU
	 TRkzac15vU0Cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19C4F39E9607;
	Sat, 13 Jun 2026 01:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ptp: ocp: add shutdown callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131242763.1315131.2792194546022295371.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:00:27 +0000
References: <20260611190333.787132-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20260611190333.787132-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 pabeni@redhat.com, kuba@kernel.org, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298852-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vadim.fedorenko@linux.dev,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:pabeni@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5545D67D604

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 19:03:33 +0000 you wrote:
> The shutdown callback was never implemented for this driver, but it's
> needed because .remove() callback is never called during kexec/reboot
> process. That leaves HW with some interrupts enabled and may cause
> spurious interrupt while booting into a new kernel during with kexec.
> If it happens that I2C interrupt fires during kexec, the whole I2C bus
> is disabled leaving TimeCard with no devlink communication. The same
> happens if timestampers were enabled, leaving the card without
> timestamper interrupts until full reboot cycle.
> 
> [...]

Here is the summary with links:
  - [net-next] ptp: ocp: add shutdown callback
    https://git.kernel.org/netdev/net-next/c/f6f955cbf9d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



