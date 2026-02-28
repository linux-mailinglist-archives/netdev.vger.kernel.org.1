Return-Path: <netdev+bounces-262052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JFQRLuJXomlm2AQAu9opvQ
	(envelope-from <netdev+bounces-262052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:50:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 420731C0068
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CC52305DD50
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6091A30C359;
	Sat, 28 Feb 2026 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t54Msq/k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC7D28D8DB
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772247006; cv=none; b=mfusaFJzEue6ma0wl+3p2Uf6CZp/ZZdg3lWcEFZg/yx0Ukp2G1T5qod1a4BH9zk3WaIAPWVzCBI6TGqPDCVs6Rfv61ZbdvzRfvwAQg26Mm+rlbJH98KLm+JbPgaJI5EoCy2k66qRuFPS8IHGFDUbMCMK1jeNEnMZfS+OZQNVnUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772247006; c=relaxed/simple;
	bh=KVp7lU8SjJBwtcmEmex/+KIOXDn2KEoPA7g12bcTjB0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uxI4gSjP25RLfRaaZSlhSRSw+WvL0DpVdhdyMN6KGQpqxZ0uc647eX4yhZiq3I9Zlh+nYtK/02LFXfgUWKqOEK1PTyZuUcV+kOgzKFzYDJfAyHdmFZfO9ygojvIBCKUx3BWGaf1DEweOLDjE7dl+UYAKvGqgRUdoaK6gkqRAvGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t54Msq/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAB4C116C6;
	Sat, 28 Feb 2026 02:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772247005;
	bh=KVp7lU8SjJBwtcmEmex/+KIOXDn2KEoPA7g12bcTjB0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t54Msq/kkweBj1DBa99tU7v1MCENA9G6K0hk0/Tmce7CGuBdiB4IYAGBvHgXzlJZ9
	 +7mjf7sV4dedc00zBedT0W+GmdB2dBRK19CIck97ipR4agMcnqsd+jH8Ku0tkbEOFa
	 CniV+xM+GAZzNmOy6grvgaSsni+NkEn2ErW7A6kTuAueBUV0MWibM+68K+hFY+4rnt
	 l/qfJ2HCwgMRMHXPg54bzRAddIkbGEV332QVQDszrZJ9wWysvvEq79Zm7igvxC1jBa
	 /EuuOg/kdG8ibmwdY0YvEu3lPqeZa3sOL8fH6quPAj6G0YdFR/Zwc0IyOVEoSG6DsF
	 fe4ht1Y+EFOIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0EF39EF96C;
	Sat, 28 Feb 2026 02:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: ethernet: mtk_eth_soc: avoid writing to ESW
 registers
 on MT7628
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224700905.2846847.10172519923546841962.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 02:50:09 +0000
References: <20260226154547.68553-1-joey@tinyisr.com>
In-Reply-To: <20260226154547.68553-1-joey@tinyisr.com>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
 lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262052-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 420731C0068
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 15:45:18 +0000 you wrote:
> The MT7628 has a fixed-link PHY and does not expose MAC control
> registers. Writes to these registers only corrupt the ESW VLAN
> configuration.
> 
> This patch explicitly registers no-op phylink_mac_ops for MT7628, as
> after removing the invalid register accesses, the existing
> phylink_mac_ops effectively become no-ops.
> 
> [...]

Here is the summary with links:
  - [v4] net: ethernet: mtk_eth_soc: avoid writing to ESW registers on MT7628
    https://git.kernel.org/netdev/net-next/c/9a04d3b2f070

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



