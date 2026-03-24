Return-Path: <netdev+bounces-271004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJATG1R1wmnqdAQAu9opvQ
	(envelope-from <netdev+bounces-271004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:28:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 271003074F5
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5203307BB72
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0AD382382;
	Tue, 24 Mar 2026 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/hgYGwP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EFF3EDACA
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351225; cv=none; b=qF1Gs70Tu4Jrr/jg1o9mOAvoBgVTw/bUh3dgr0Ezm3ImoJ2cYETzD0/reoTVFdS7zXxMyIFb/R4P9urYjIU8/oi2Kg1YVNeOYgiauJnWnM8+tqGaFqLbNZTWzTvkxz4QqtMTDawHflpfhyVGN7HbqRpUAXWJn6i2y2BmLoa5QWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351225; c=relaxed/simple;
	bh=/VGB9nDd+/GqixMK/Q1YavpbNhgLz5r5U6tvuEB+cXY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=owD8xxOdwrYM8Fm7B2hB3L/cw/2lsIXZlIrHaV6GHnUZCB7u22zAbSGSkiuY/1uRchSAbaWkWNvYn03x7QCtf7+kdj2o2Z82VVAn4UHO0xCI4AlZx5jbv2pyJCxGj4Dl1BzI6qvOwICWpMctcgR6zdz2F89wmmmGDYjL+0fxlh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/hgYGwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EFAC19424;
	Tue, 24 Mar 2026 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774351225;
	bh=/VGB9nDd+/GqixMK/Q1YavpbNhgLz5r5U6tvuEB+cXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l/hgYGwPIylBRr2b7EK+ZSRcvcDiOQEreu0KBHfd+RJFFiPiQ0w8YDUyOePjCxDRi
	 hKmfDCq57RRCm4s8eBPIfQ4j2o6O1YqxmPGABv5cg178ckxxyYG7IJ2XnGKKYFpZyW
	 Qfo7s+2pH5TAjHr7CqAM4GKDe3zPUVpUORp6peyu0sA4y6W54URZCCjk27IovDdBAB
	 jK3BmoajfAu1505VN89k1ESTMTl1ffMr381p7NN5MgCMG3oK/KoqUAoiIBWqP0mj1j
	 zIA64jnsZX1rmfuOB/BfR4SVvY8ffIBuxSkhW3gWr7tBXphL3CTY1p4BmIOxmg4ckB
	 wUZ4cqU71qtjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FECB3808200;
	Tue, 24 Mar 2026 11:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: stmmac: cleanup stmmac_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177435121274.629137.16512237981909489281.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 11:20:12 +0000
References: <ab15_JvLGFtUH_3x@shell.armlinux.org.uk>
In-Reply-To: <ab15_JvLGFtUH_3x@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271004-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 271003074F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 20 Mar 2026 16:46:52 +0000 you wrote:
> This series continues on from part 2 of the descriptor cleanups, making
> stmmac_xmit() more readable.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 103 +++++++++++-----------
>  1 file changed, 52 insertions(+), 51 deletions(-)

Here is the summary with links:
  - [net-next,1/6] net: stmmac: move stmmac_xmit() skb head handling
    https://git.kernel.org/netdev/net-next/c/fcbf106189aa
  - [net-next,2/6] net: stmmac: move first xmit descriptor SARC and TBS config
    https://git.kernel.org/netdev/net-next/c/cafacdc48a74
  - [net-next,3/6] net: stmmac: move stmmac_xmit() first entry index code
    https://git.kernel.org/netdev/net-next/c/7b8683115034
  - [net-next,4/6] net: stmmac: move stmmac_xmit() initial variable init
    https://git.kernel.org/netdev/net-next/c/2e3bfeb1bc0c
  - [net-next,5/6] net: stmmac: use first_desc for TBS
    https://git.kernel.org/netdev/net-next/c/557ccd54ba14
  - [net-next,6/6] net: stmmac: elminate tbs_desc in stmmac_xmit()
    https://git.kernel.org/netdev/net-next/c/cd1f306e2815

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



