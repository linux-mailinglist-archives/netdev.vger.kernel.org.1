Return-Path: <netdev+bounces-264157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +utCKr/xqGnDzQAAu9opvQ
	(envelope-from <netdev+bounces-264157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:00:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CDF20A609
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2C0130297A7
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 03:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F892701DC;
	Thu,  5 Mar 2026 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKQSdhPx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6123EA99;
	Thu,  5 Mar 2026 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679611; cv=none; b=iEy6dIG1P7t07pJ6Wlc2nZMDCvbNovss3sUlZ0HUjtsnUqyUVh/s7WaGxIIjgzfoL8bu5Df7z0P4a9P5doorEV1lBrGlLjexH1otp4yquaewSPMunEQ8PSZBIw9G3vL4kTL4vv9N4dLHUs7foHR19GrLQQecDTPVWkDWcJLCAmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679611; c=relaxed/simple;
	bh=bi1pYv3Bgq+ShmDzGX+GwIzVgs550SZNCxuwrCsn5Zw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fkfqNfCrWEpfQ/UjuqeHewKipiFcFofhr2k2S8oAvhRArzhdE+UGZLQdbsqIA8wMR5lh/oLtiMj21KXegyufpZMAuB3XlWJAxCAtB3nrczwkB7HhM3G5RV/U4ucTANOmDjDhSAuFdNYIfrQ7HOwokL9NQmx+DQrQVbeBDbzZ96o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKQSdhPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ABCC4CEF7;
	Thu,  5 Mar 2026 03:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772679611;
	bh=bi1pYv3Bgq+ShmDzGX+GwIzVgs550SZNCxuwrCsn5Zw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XKQSdhPxdqmBP2Ac+rDlVNGMBaCuZAwx7jzg/ZotPWi2eFf9gQYQCBKOmRJNUmWXq
	 g2U3tIzsNRK/2t8mrOCj9AMSueyYC+TWq28yY6D5DRjm6G8g8wvVbEVwDNnh/eYdko
	 l6o1U8khaB+tVZFlxUUjbn7R6VmKaS+2kPuRlLB1XbhXJXPYGGo8xSb1tXkSuYE5E6
	 Gth30+xotWb1C0xZB033o2BMfBcPRaQqCXYvsXgQxl7RnMzyIN8jnK1weviP5OKWC+
	 TR7MoX4WFI0qQPC8ecCF5x5mzjTJ837zeu4wONFRbHyUYqkyZ/TF531sf1BSAkAqoW
	 m/e+V7xwe49xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D543808200;
	Thu,  5 Mar 2026 03:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/4] net: stmmac: Fix VLAN handling when interface
 is
 down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267961155.2494418.12039829007710678123.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 03:00:11 +0000
References: <20260303145828.7845-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260303145828.7845-1-ovidiu.panait.rb@renesas.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, linux@armlinux.org.uk,
 rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
 boon.khai.ng@altera.com, rohan.g.thomas@altera.com, vladimir.oltean@nxp.com,
 hayashi.kunihiko@socionext.com, boon.leong.ong@intel.com,
 kim.tatt.chuah@intel.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 01CDF20A609
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264157-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,altera.com,nxp.com,socionext.com,intel.com,vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Mar 2026 14:58:24 +0000 you wrote:
> VLAN register accesses on the MAC side require the PHY RX clock to be
> active. When the network interface is down, the PHY is suspended and
> the RX clock is unavailable, causing VLAN operations to fail with
> timeouts.
> 
> The VLAN core automatically removes VID 0 after the interface goes down
> and re-adds it when it comes back up, so these timeouts happen during
> normal interface down/up:
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] net: stmmac: Fix error handling in VLAN add and delete paths
    https://git.kernel.org/netdev/net/c/35dfedce442c
  - [net,v3,2/4] net: stmmac: Improve double VLAN handling
    https://git.kernel.org/netdev/net/c/e38200e361cb
  - [net,v3,3/4] net: stmmac: Fix VLAN HW state restore
    https://git.kernel.org/netdev/net/c/bd7ad51253a7
  - [net,v3,4/4] net: stmmac: Defer VLAN HW configuration when interface is down
    https://git.kernel.org/netdev/net/c/2cd70e3968f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



