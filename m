Return-Path: <netdev+bounces-291018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBDBK+kNEWpJgwYAu9opvQ
	(envelope-from <netdev+bounces-291018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:16:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAB95BC840
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A469C303E2CB
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F6C2ED16D;
	Sat, 23 May 2026 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGbmrqvZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69D2D0C92;
	Sat, 23 May 2026 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502211; cv=none; b=ZSH4XWOA0pe52IdpAwyWhgQH2LpL+eRv7kehL3fc7Ti2/M4JJYzhad9ww3T38PGJ9T+ECMictQE0itLCSC96/pjXNn++isVXqUhPNUMcKc5uy+tmRcZquH2wOVmwpGxt7dqSn7q0sN3eTyqSMEw0lvMReSu6r1tk0CIaaABMhcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502211; c=relaxed/simple;
	bh=nnVA24FSv+gpIlRFxPmXV8ZoJRHwoLx3Y1IQWa/cCkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ln85NzO1Np8CAJqF2U7xR/zKzM+jie432kkQm9uFuNbmSdQeMzYaVxvQTwzBVfSV/VuGU1ltw4Znzp3uHMjSjlsStIpAEG0IGPt9EZBDuvKcSzSKF4SmN1yR6AKYKRLHIdf843MRgPFmuqNytjhH/A+HK3OyvqrkQ7Ril217sY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGbmrqvZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3771F000E9;
	Sat, 23 May 2026 02:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779502210;
	bh=cwexbUW3atHUuxBiUTlgNTLA4iU2dMsS2Z3tlktdEkw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AGbmrqvZq0KQ3s2Ie4j2kB90prZL3N03hQSfe1OoTO22Mf7ZlSbgGv4h0X4vUdEbn
	 T0ec8aMAYvPgztM5AqSeANeEEc9zjeRvxuXbeoC8IlqBAfJyTqMaupzhruVcTUNFbE
	 T6ycbfwJEE6j2birU9uBpwHES89adh3U/9TWXMyuKtHNMF1vgh5Ky/V//w/xbEkq5L
	 LkSZ8uwdIK5xe9gvZ1uMqBkh0yZ5n7QFBKk4AH9kuBvExxxw3XR5AYFeHXMprLWcaG
	 1PZeFZ3vIfxbFuIh+4Xq8li1fa+2qNVluwtHss/ecDjeIeEvNyGeTiqtSzK/0b4O36
	 DomDH7DvOVI/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A123808205;
	Sat, 23 May 2026 02:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/8] net: dsa: microchip: Remove unnecessary
 ksz_dev_ops callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177950221889.1443443.5198644261821848371.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 02:10:18 +0000
References: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
In-Reply-To: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
To: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, richardcochran@gmail.com,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, tristram.ha@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,se.com,bootlin.com,vger.kernel.org,nxp.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-291018-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0FAB95BC840
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 08:12:35 +0200 you wrote:
> Hi all,
> 
> This series continues the rework of the KSZ driver initiated by a previous
> series (see [1]), following the discussion we had here [2].
> 
> The KSZ driver got way too convoluted over time because it uses a common
> framework to handle more than 20 switches split in 5 families (see below
> table)
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/8] net: dsa: microchip: don't reset on shutdown or driver removal
    https://git.kernel.org/netdev/net-next/c/5fe0b938bde7
  - [net-next,v3,2/8] net: dsa: microchip: bypass dev_ops->setup() and teardown() for lan937x
    https://git.kernel.org/netdev/net-next/c/dfc5c56829b9
  - [net-next,v3,3/8] net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz9477
    https://git.kernel.org/netdev/net-next/c/7c494a10f937
  - [net-next,v3,4/8] net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz8
    https://git.kernel.org/netdev/net-next/c/4c54f910eefd
  - [net-next,v3,5/8] net: dsa: microchip: remove dev_ops->setup() and teardown()
    https://git.kernel.org/netdev/net-next/c/df478153cb2d
  - [net-next,v3,6/8] net: dsa: microchip: bypass dev_ops for port_setup()
    https://git.kernel.org/netdev/net-next/c/aa6902098914
  - [net-next,v3,7/8] net: dsa: microchip: call DSA's phy_{read/write} to do mdio {read/write}
    https://git.kernel.org/netdev/net-next/c/932fc72b9849
  - [net-next,v3,8/8] net: dsa: microchip: bypass dev_ops for phy_read()/phy_write()
    https://git.kernel.org/netdev/net-next/c/2b0c672543cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



