Return-Path: <netdev+bounces-255312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO/UDg1gfWn3RgIAu9opvQ
	(envelope-from <netdev+bounces-255312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:51:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B190EC01E6
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6D5430465C9
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBCC321434;
	Sat, 31 Jan 2026 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX4SYWdy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B919317715;
	Sat, 31 Jan 2026 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824215; cv=none; b=NfQ1kROxZwR0DBOY+dhZokktqrgLRn04Ak7LyVpNLSNvbgpzx8CuF0VBchG2WW6KoAIKYV31K0N8IUyo9wYPbLYeVmEaHm8Ud7TnsFVVbHxlEZWlFDnktgY0HmkGcgiNlfjeXv7lKAuLVS+vqFTPQR5YhoMpJkoAS48jt2qCq2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824215; c=relaxed/simple;
	bh=KveGONG7UJdElvqV315bWlMz8AD27Y9PZLI+Vh0KgjU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IwMNSVtzOOZJDbpjIFcgN/jv5st10i6Us3Zg62OKmzFIxqTMnkJjTDAuV+RTKXGFRfjQw9Ua8AvD9QNODyabcPHc9talUqGpiMDF7A6UpaleNHw8+GPyyZj6gbtElQ1uIIzV3eIZYxEwKKPZ5eMS8v/7j7vMVDh2Ip+umwFvMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX4SYWdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249B2C116D0;
	Sat, 31 Jan 2026 01:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769824215;
	bh=KveGONG7UJdElvqV315bWlMz8AD27Y9PZLI+Vh0KgjU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GX4SYWdycMxo+2vTLOeR/ZBoTMWGL8AgvbwdETbXxJVMdby1l6Dl/yDEby0l+bAq9
	 9c6Q3Ki4B+bTUnQbsrudX3kJlBk7gdDK6na9gXWgC1zrDWUW1D8AI/xuaO62XKAHNz
	 7KBl252hzYi7jCPIyLfasU49uL767ZC6Z4XMBFGqjlwJeCKovdwCkF4QZXfgLvw6ZD
	 D/mcX2MYw6EilRtyq7BbVr626UBsoRRvZTRjwOMFTTTQq0bay74A5d7p/9ms1wP+5m
	 xCmKiBfwRLNb5F0zTpAInNgI6E6+gWD86d68SAQ6+GF/qJ1X8ABgRJC3WNeCF52EYt
	 aYEQDXnTXp2bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BC98380CFFB;
	Sat, 31 Jan 2026 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: spelling corrections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176982420710.3961929.13739265763800349219.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 01:50:07 +0000
References: <20260129-stmmac-spell-v1-1-c7df9a96e482@kernel.org>
In-Reply-To: <20260129-stmmac-spell-v1-1-c7df9a96e482@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, wens@kernel.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-sunxi@lists.linux.dev
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,pengutronix.de,sholland.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-255312-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B190EC01E6
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Jan 2026 17:35:03 +0000 you wrote:
> Correct spelling as flagged by codespell.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c        |  4 ++--
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c      |  4 ++--
>  drivers/net/ethernet/stmicro/stmmac/dwmac1000.h        |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c    |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/enh_desc.c         |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/mmc_core.c         |  4 ++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c      | 10 +++++-----
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c      |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c |  2 +-
>  10 files changed, 17 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [net-next] net: stmmac: spelling corrections
    https://git.kernel.org/netdev/net-next/c/96e1c895b5ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



