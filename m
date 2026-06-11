Return-Path: <netdev+bounces-298387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OpxqOp43K2rD4QMAu9opvQ
	(envelope-from <netdev+bounces-298387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:33:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C556675A53
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:33:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=f95h+ajN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298387-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298387-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC8F5331E59E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D53C43D50D;
	Thu, 11 Jun 2026 22:30:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94D63CDBC0
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 22:30:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217034; cv=none; b=ahniGLwQ4O87kq7XDNqsU0MuJqB36rt6pkyBeby9+grmsel9WI2J6C6bA9j1PIeGcM3hKLjb0VJyz1xqffXXT8HcQxK8KzoplEVE9BHg7DMMS2gycZ35/Esy7VPtVv07pfli9tzjH0IuHOHAXRtEzcXu0QNR9Ga52s0dAhFtLkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217034; c=relaxed/simple;
	bh=jBqoSpW7+0NhvOMqR/GomQMJswaD59B4Vt5XhZoNHDE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EwLrY4l8jZyTLBzsvhMD0ZT4Ccdqiyg7e5n5TvHOYCgux1yOOGXDPC4lgGWRZQn0Mli4tPzvAg/sK73DflxkQQbGvSi/dJFPKvsyKQzNtMQpGOyXhApGx5K9lzMsuRVm2q5rcjBEsQqZh67M+MaXvfJZkqV0BTziJr6kQuX6aWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f95h+ajN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F911F000E9;
	Thu, 11 Jun 2026 22:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781217028;
	bh=4Wcf7phm+5zW58xmIIN/R67av8KlnEeqYbMlrcD2Tak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f95h+ajNjZNo3xEEyX/XOHSgtZiNH1s3cW8bi5v/dxt0yK41xMPvPqdphnnpp3GgZ
	 T+YfHUNKqpeXhX5DHKRw2BSUsTtW9Z5neIc2FD9A6YFfvl+c0EdcyHLKIbrIjoXvqt
	 1kdDdZDrCyJt+rtRjHOoTE1UaLZm9lVoFqcnNAPvrA/n646jwJLSOQBwovIxpnNrqQ
	 ykC0amak0VYg5ryWYNzOegXveEVd7HugQV7XThGM2o/vcrUR8yaZHx9a9yAuZrMkcE
	 giF+WVrDuNr3mqPSjfaJW8OGcRe/W3xntK3178+rSVCLq6hjdNAeMM646bykuVsfKI
	 OugrplI8toxRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569053930FAD;
	Thu, 11 Jun 2026 22:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fec: remove reference to nonexistent
 CONFIG_GILBARCONAP
 option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121702588.389578.15203265198914114198.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:30:25 +0000
References: <20260609045200.32606-1-enelsonmoore@gmail.com>
In-Reply-To: <20260609045200.32606-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, wei.fang@nxp.com, frank.li@nxp.com,
 shenwei.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298387-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:netdev@vger.kernel.org,m:wei.fang@nxp.com,m:frank.li@nxp.com,m:shenwei.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C556675A53

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 21:52:00 -0700 you wrote:
> The CONFIG_GILBARCONAP option has never been defined by the kernel, but
> is referred to by drivers/net/ethernet/freescale/fec_main.c. Remove this
> reference to eliminate dead code.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> [...]

Here is the summary with links:
  - net: fec: remove reference to nonexistent CONFIG_GILBARCONAP option
    https://git.kernel.org/netdev/net-next/c/f8142f5578b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



