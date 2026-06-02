Return-Path: <netdev+bounces-294428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ue6IHVBOH2rcjwAAu9opvQ
	(envelope-from <netdev+bounces-294428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:42:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1B3632262
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:42:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kNmI7Uw7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294428-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294428-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06E0730097E6
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 21:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAA83A5E7D;
	Tue,  2 Jun 2026 21:40:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812639769A;
	Tue,  2 Jun 2026 21:40:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436407; cv=none; b=IkpDJQANdEBHDcvP2pV7ZActHKSfriMdBDMZlAL0MweN8i59VdEynP/um+AdLnMVGvuMPKoUZZdcJxyV9Kcxra3R3bnibh6tUlULNMCELA7UrqoYzqbjA0H4e0gN5Iqe/7FFyVZBmMnIK8FHNB+lXTnHQYm6nAGRAJRCWt4QxU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436407; c=relaxed/simple;
	bh=drRcfTEP6v34Qt21HTuSvDh9HgTn/mn5QSJ/Q7XAGiI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CnNpspO3oe7k/tVisKD/2R0Ft2iGJPrmNyWUU+PxtnFW8hbW8QLCqWa1HlGEa9durf/+zdm7KFhVaLGjFm/+Z8c/3TBLaJsQYVwKfG8M6T2ATFiQrd8QgZ70lwKHsQuAxDCn4ZC4D9AOgt9qkbe24C7Hy8FC+xmR2bQF8NDa8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNmI7Uw7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893451F00893;
	Tue,  2 Jun 2026 21:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780436405;
	bh=2TcMdj3gXVUNUWo+rvBAbp4z/UxTQFpKbJrWyXnZerc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kNmI7Uw7rTVEBzCtj32powMLa54ZBpbKQ8SSjgm6Xdu1JxOU9eRk8cd4jxhj7ee+T
	 59sQHLse0VD13Rx547ZZVMip3mNBaSNflbaHsQBqXttFDb41ucNyj4yUZqZyKV/BJg
	 Bq7eUWyI3weHXWFoChjKrfQqsRR5/cRRTiFxdLskdfVVJPQDdsAw9TTt7Fmv7MW4pb
	 XNcigldGy6v4w62xTFrXgUubKWWZIfDvSZ+HJEIZ3bIcnNpGEEd2fyys6hWfooClMj
	 8mdsqVn1TyI04WzD9W//rkvNncTh0xoRnPAbHcbFzyripMp3HeGJoDKs34KWv60bvS
	 KUG456hlmd7dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938D73811A76;
	Tue,  2 Jun 2026 21:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: fec: fix pinctrl default state restore order on
 resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178043640715.1060922.6991366535769176295.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 21:40:07 +0000
References: 
 <20260529-b4-fec-resume-pinctrl-order-v3-1-6eda0f592fca@vaisala.com>
In-Reply-To: 
 <20260529-b4-fec-resume-pinctrl-order-v3-1-6eda0f592fca@vaisala.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, B38611@freescale.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294428-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:tapio.reijonen@vaisala.com,m:wei.fang@nxp.com,m:frank.li@nxp.com,m:shenwei.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:B38611@freescale.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA1B3632262

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 06:18:57 +0000 you wrote:
> In fec_resume(), fec_enet_clk_enable() is called before
> pinctrl_pm_select_default_state() in the non-WoL path, inverting the
> ordering used in fec_suspend() which correctly switches to the sleep
> pinctrl state before disabling clocks.
> 
> For PHYs with the PHY_RST_AFTER_CLK_EN flag (e.g. TI DP83848 or
> SMSC LAN87xx), fec_enet_clk_enable() triggers a hardware reset pulse
> via the phy-reset GPIO. With the GPIO pin still in sleep pinctrl state
> at that point, the GPIO write has no physical effect and the PHY never
> receives the required reset after clock enable, leading to unreliable
> link establishment after system resume.
> 
> [...]

Here is the summary with links:
  - [v3] net: fec: fix pinctrl default state restore order on resume
    https://git.kernel.org/netdev/net/c/b455410146bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



