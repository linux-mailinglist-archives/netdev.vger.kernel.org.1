Return-Path: <netdev+bounces-263039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBfXFlxopmljPQAAu9opvQ
	(envelope-from <netdev+bounces-263039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:49:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E751E9101
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9339230E43AD
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 04:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93C4374E57;
	Tue,  3 Mar 2026 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJ+REdOO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968AF2FC874
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772513220; cv=none; b=euJor0QrxADN2MjncniLzyCj4+CkVOtMXMowiVk5WHOv0DUfG0yb6QD1eY1zVfiIXSmfHMu/LdeP/zWdabHGYN86uZqLXhS2dKalOl0xrS2gY6JmNS48/Eds2f080LSOH2B9/UMVlVHoa4sY3mMemg7Ving+1t70gUHjnuFeO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772513220; c=relaxed/simple;
	bh=CS1WrxtxU/kHPZfcygHyRAiSv8ol2PAZ5jWVio9L/AA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VNHPafMJCwGpVfHiSN9OmrCDhY2SK8r4bAthKO+drPNus2e+43xFNNeH2WgXPypQnFU4pE9VdQBjtu/236/88Y+JpDIie4OGlwpoeuLYPH7pzkn1vmrnmXl8XCqLNiEB4rHs7R+szCuv4yVQDgmjmLLxZooC1/3ort5vXPPBJi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJ+REdOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5320EC116C6;
	Tue,  3 Mar 2026 04:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772513220;
	bh=CS1WrxtxU/kHPZfcygHyRAiSv8ol2PAZ5jWVio9L/AA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BJ+REdOOU26G9ad9XcSeLSyblI4tigLc+DZn3j7z+pMBYsenlvPMIK9+3oDHDWk/w
	 6YfN9+LuTCM4keU1xpH4oshl1rKyelnlWDjbuRiU1umFFpgFFObh1sIbEwrDyiaDVI
	 erP/IBYCcGTsdvoyQvsPZ4L02f2kQZeT1Khe2hDkBPhYZk+v6x7r2u1n8bJb9jGtGb
	 OF1DGnRBmcvwOQEB4WK4Se1NpENTd0bxefIJygYrEzh6hXCSF7mXPk00rraRZie0Zp
	 9ZrLuZOLy9NfGW5RuD73zgwSFxminkIcm+h5dnphQDXo2aHvZBLuqEqoyNuAjnJKse
	 lYkVaS/IyrD3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DCB3809A80;
	Tue,  3 Mar 2026 04:47:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14] net: stmmac: further cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177251322154.625663.1785427574755264345.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 04:47:01 +0000
References: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
In-Reply-To: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
X-Rspamd-Queue-Id: B3E751E9101
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263039-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Feb 2026 09:52:38 +0000 you wrote:
> Hi,
> 
> Yet another bunch of patches cleaning up the stmmac driver.
> 
> We start off by cleaning up the formatting for stmmac_mac_finish(). Then
> remove a plat_dat->port_node which is redundant, followed by several
> descriptor methods that aren't called.
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] net: stmmac: clean up formatting in stmmac_mac_finish()
    https://git.kernel.org/netdev/net-next/c/940ec40dd299
  - [net-next,02/14] net: stmmac: remove plat_dat->port_node
    https://git.kernel.org/netdev/net-next/c/44a2ec96d374
  - [net-next,03/14] net: stmmac: remove .get_tx_owner()
    https://git.kernel.org/netdev/net-next/c/d48ba98bbc82
  - [net-next,04/14] net: stmmac: remove .get_tx_ls()
    https://git.kernel.org/netdev/net-next/c/1fe444bdc583
  - [net-next,05/14] net: stmmac: remove .get_tx_len()
    https://git.kernel.org/netdev/net-next/c/19f2d59c3c3a
  - [net-next,06/14] net: stmmac: remove dwmac4 DMA_CHAN_INTR_DEFAULT_[TR]X*
    https://git.kernel.org/netdev/net-next/c/d1925291231e
  - [net-next,07/14] net: stmmac: remove dwmac410_(enable|disable)_dma_irq
    https://git.kernel.org/netdev/net-next/c/0e7cb34d0f6c
  - [net-next,08/14] net: stmmac: remove mac->xlgmac
    https://git.kernel.org/netdev/net-next/c/70bafb53b305
  - [net-next,09/14] net: stmmac: make extend_desc boolean
    https://git.kernel.org/netdev/net-next/c/ecb037f58da7
  - [net-next,10/14] net: stmmac: make chain_mode a boolean
    https://git.kernel.org/netdev/net-next/c/a2a3832ad76d
  - [net-next,11/14] net: stmmac: make dma_cfg mixed/fixed burst boolean
    https://git.kernel.org/netdev/net-next/c/1558705afbb2
  - [net-next,12/14] net: stmmac: move initialisation of dma_cfg->atds
    https://git.kernel.org/netdev/net-next/c/0835bc72510f
  - [net-next,13/14] net: stmmac: simplify atds initialisation
    https://git.kernel.org/netdev/net-next/c/93cde989bd28
  - [net-next,14/14] net: stmmac: move DMA configuration validation to driver probe
    https://git.kernel.org/netdev/net-next/c/07a8531d4427

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



