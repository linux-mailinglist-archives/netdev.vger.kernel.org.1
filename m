Return-Path: <netdev+bounces-253982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEn7AxkMeWnyugEAu9opvQ
	(envelope-from <netdev+bounces-253982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:03:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A69F299907
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D10F300D0CC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517FF329E5D;
	Tue, 27 Jan 2026 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj6gRbXe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED932936B
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540417; cv=none; b=VYnvjiOYq/2PtwI2598LsiG4aODtL/Qsv4RRjWeen8ROTp4Ueoh+w5fzIfrIXM+YHcunhg/rF8oOyPu5niQ/zNLc0CQ0Y7/nlCHmA/P8mODnwICLla1mD/Zd4AraHZbjgjsmXrwJnJeb5Ls7D9frekW2orFE+df1NKjUeq6/QU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540417; c=relaxed/simple;
	bh=c1tXqNRpIYOMWP0VFHYLgja6KaJDZeX2rziUlYI6lDE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kHd49ejJZnGg7sxaETMfwTSXdHgbvz8xKqSlbQYiLoXoz1iVp6ZxrJ2GkxLpNhdQyiBuQRZ3lV9nJuPOTnDSN8M4LhOUxnwuDRmIUdwqMqBiqi4n1JtXA5GGg0nd6PU0id/vJDaaabQea0gcQDHoxEfcRG6f+9ropTq30ZEYF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj6gRbXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9F7C19422;
	Tue, 27 Jan 2026 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769540416;
	bh=c1tXqNRpIYOMWP0VFHYLgja6KaJDZeX2rziUlYI6lDE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kj6gRbXeAmfTn/JBCTT62O3iJ8jjNV0u8rFD8iC71YBpUat13frCXksenXJKLoz9g
	 hRhUOkDar/NaTyShKpK5y49wYwlmswiVzimXTkUkX5BvROrEvODNBWyT44vKUuJoh5
	 4xsX19vKoY4Apd9ByWqlwUnrBiocX76se2AxxVl/tBsiGItUtvkfm7s6xUQQRcLRrv
	 Xj1bcXD04XTPLQDHbimStBP3TSOIaSlVwE0rY+24QkxvKPJYoQbcWv/Yz64lyAvfoa
	 yDajGi5xBggK1h2IdV6VK6+43VhcO/MZfUQBYpm4oVAkd9TuOH9RPallLkOa+sRhpH
	 3PgF9cTXkY3IQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8C95380AA58;
	Tue, 27 Jan 2026 19:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/22] net: stmmac: rk: simplify per-SoC
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176954041060.1365394.14963614525906963591.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 19:00:10 +0000
References: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
In-Reply-To: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, heiko@sntech.de, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253982-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A69F299907
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jan 2026 11:44:11 +0000 you wrote:
> [Please note: due to google's spam filtering, I can no longer send
> patch series to @gmail.com addresses, and thus, to save being spammed
> with failed deliveries, I'm dropping such addresses from my patch
> series. Stop giving google so much power, use other email services.]
> 
> dwmac-rk has an excessive variability between each individual SoCs
> which makes this file extremely large.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/22] net: stmmac: rk: avoid phy_power_on()
    https://git.kernel.org/netdev/net-next/c/a0094edaf492
  - [net-next,v2,02/22] net: stmmac: rk: get rid of rk_phy_power_ctl()
    https://git.kernel.org/netdev/net-next/c/af6eaf701897
  - [net-next,v2,03/22] net: stmmac: rk: convert rk3328 to use bsp_priv->id
    https://git.kernel.org/netdev/net-next/c/cdb5fdfcf396
  - [net-next,v2,04/22] net: stmmac: rk: group MACPHY register offset and fields together
    https://git.kernel.org/netdev/net-next/c/a7ad67e9745d
  - [net-next,v2,05/22] net: stmmac: rk: add GMAC_CLK_xx constants, simplify RGMII definitions
    (no matching commit)
  - [net-next,v2,06/22] net: stmmac: rk: add SoC specific ->init() method
    (no matching commit)
  - [net-next,v2,07/22] net: stmmac: rk: convert to mask-based interface mode configuration
    (no matching commit)
  - [net-next,v2,08/22] net: stmmac: rk: convert rk3588 to mask-based interface mode config
    (no matching commit)
  - [net-next,v2,09/22] net: stmmac: rk: move speed GRF register offset to private data
    (no matching commit)
  - [net-next,v2,10/22] net: stmmac: rk: convert rk3588 to rk_set_reg_speed()
    (no matching commit)
  - [net-next,v2,11/22] net: stmmac: rk: remove rk3528 RMII clock initialisation
    (no matching commit)
  - [net-next,v2,12/22] net: stmmac: rk: use rk_encode_wm16() for RGMII clocks
    (no matching commit)
  - [net-next,v2,13/22] net: stmmac: rk: use rk_encode_wm16() for RMII speed
    (no matching commit)
  - [net-next,v2,14/22] net: stmmac: rk: use rk_encode_wm16() for RMII clock
    (no matching commit)
  - [net-next,v2,15/22] net: stmmac: rk: remove need for ->set_speed() method
    (no matching commit)
  - [net-next,v2,16/22] net: stmmac: rk: convert px30
    (no matching commit)
  - [net-next,v2,17/22] net: stmmac: rk: introduce flags indicating support for RGMII/RMII
    (no matching commit)
  - [net-next,v2,18/22] net: stmmac: rk: replace empty set_to_rmii() with supports_rmii
    (no matching commit)
  - [net-next,v2,19/22] net: stmmac: rk: rk3328: gmac2phy only supports RMII
    (no matching commit)
  - [net-next,v2,20/22] net: stmmac: rk: rk3528: gmac0 only supports RMII
    (no matching commit)
  - [net-next,v2,21/22] net: stmmac: rk: use rk_encode_wm16() for clock selection
    (no matching commit)
  - [net-next,v2,22/22] net: stmmac: rk: rk3506, rk3528 and kk3588 have rmii_mode in clock register
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



