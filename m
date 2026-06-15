Return-Path: <netdev+bounces-299649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d/NwIBCEMGosUAUAu9opvQ
	(envelope-from <netdev+bounces-299649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:00:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C868A83F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:00:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XqUfBKr3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299649-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299649-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB08330892F4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490723B71C0;
	Mon, 15 Jun 2026 23:00:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370343B6C09
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 23:00:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781564415; cv=none; b=T1/XZq+tHFV7Q9+nDjPlLJ2LawkVXt/Ckjj5ypigbGRif5SccJfElCnyjx25l0edzoDbapUWU7EwYmwgA3epXUXyeJmNkq+hzfLDLYqjdz7WXkd5TsVYpiRIFj1Zk6T8s50w4jukcaAqJpBlTGyu0UvTWpD6A8KPNOEZWrtJi5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781564415; c=relaxed/simple;
	bh=ujmiFKaHgZjOSPypW/I6YvEci0DrKup8vct6xIeMOMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t7niZqNXxeM6l2x46r6EuJoWz46TObF/wCdI/GWOV1mhiYzzCYhM3ZNIRjS0OwIYfO6/iR3H0R98ffWSBXce7sxHbZn6vax/lWyBINWLJF+a29GGzQod2XWrDj8WF4PnqNoojJHvX3wK0sWUijPHpYDZOsDTmHtQATJxGOHSj6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqUfBKr3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8B71F000E9;
	Mon, 15 Jun 2026 23:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781564414;
	bh=2loO3nUot9hrudi+28RkSsyElCtJRPUuRb8vLweVC4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XqUfBKr3fhhIWXrTvhdy/f0lAg3kBl5RtITob6+G0bTxX0nNh2bF6COVJKUY0ThTK
	 y7g3O/YGHa76eYg02BEpzGm0XJf4K8A+hJtz/BooEN8EutaUczxJcmya+vYOklLEqb
	 KcGKHWZ9ZK3/JDE36T7I1ChdHCFM8rvasd+eTsC84OgdyI+h70eSnTC5TjKZIKlR4s
	 0NuE0rbhIw2Pz+gkvg0k8IeiRIhI6PNPhkUEXMNgmQKmB6sTiMNI+ubwfox6ml/4e6
	 EsBzuWaHWOIyRalqds06+6lXaMYmGG4+uZXl9ws6ODFPaRtupjd4K5TV3nHppUE3Sn
	 WHzBBsz2tvlxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569A83839A08;
	Mon, 15 Jun 2026 23:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: airoha: Fix MODULE_LICENSE to match SPDX
 GPL-2.0-only
 identifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156440888.329386.11011872053824456703.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 23:00:08 +0000
References: <6a2ded59.63d39acb.391892.7632@mx.google.com>
In-Reply-To: <6a2ded59.63d39acb.391892.7632@mx.google.com>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
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
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299649-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E93C868A83F

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jun 2026 07:52:39 +0800 you wrote:
> Both airoha_eth.c and airoha_npu.c declare SPDX-License-Identifier:
> GPL-2.0-only but use MODULE_LICENSE("GPL"), which the kernel module
> loader interprets as GPL-2.0+ (any GPL version). This mismatch causes
> license compliance tools (FOSSology, ScanCode, etc.) to misidentify
> the effective license as more permissive than intended.
> 
> Replace MODULE_LICENSE("GPL") with MODULE_LICENSE("GPL v2") to
> align with the GPL-2.0-only SPDX identifier. Per include/linux/module.h,
> "GPL v2" maps to GPL-2.0-only, matching the source files' declared
> license.
> 
> [...]

Here is the summary with links:
  - net: airoha: Fix MODULE_LICENSE to match SPDX GPL-2.0-only identifier
    https://git.kernel.org/netdev/net-next/c/b0d62ed16424

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



