Return-Path: <netdev+bounces-249302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4AFD16899
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50FA4300CB5A
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBF334B1BE;
	Tue, 13 Jan 2026 03:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oae5OM2X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7534AB09
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 03:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275822; cv=none; b=AYUGstOin3T+NSPorQHtSqi/IuZgmLhvCGqv96OqkC7xG4gLAWBrVTc7vYS2IS9+I76Ho7XYqKFBc9ixHVQWfaSVCkhNw2CtWKi94vkko4jUUaszFAR+L9Mv37Z76Vp3fzHKXKAsfU6DZ+jYVPDTT+Bh8/iiIfU5bZXavCu2ebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275822; c=relaxed/simple;
	bh=1x0HV4CNdWNSF88xgwpmrzDRD5SQUGzjfVFk6VnyTH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gpd2PY3xK23ln5ORzSvFG14pEnpme0wEefDgBF6ZPvdOR5iTAtBfmf3uoAbVa2mQoemyI2usy5ZFU44irr+qsMTdav9nsJJT51TtPgSt9LW0d71O5orbn9lj4P/fClapv0++maQAbBjIbqqYXXZXnUHlaioLUI77ASCBrfdzqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oae5OM2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D9CC16AAE;
	Tue, 13 Jan 2026 03:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768275822;
	bh=1x0HV4CNdWNSF88xgwpmrzDRD5SQUGzjfVFk6VnyTH4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oae5OM2XV2Fs0m81Zf2oWR3PoGCMRnlvt4bkQwoXeyFUrfdKKjJwhmvCU1dg3EUpf
	 /uGiWbthMfLHmkHWEEA6773EQOJG58wsrWLvmzE/dBM7wfh9UiQuVe3NjGIqzcs+Xz
	 M+ExGVgbhDhIKWag221NXTrLaKROj/J9+/qh3XRGqjgZeEiI2k7GTPGI8aBNMPV+zl
	 IUM1FI8a/k7q/VruSlUdb9cHWmLzlAU7IFg3+R5UvZtjEAQ8ElTcZvez9EVVSdI9T3
	 WPWwseXUp6Y0x+NSl0QoC0/zZbZ6kGVDr1OO29M8Dd8KF0viRRvuPKqbYF0qs9fP+U
	 KMsafm3RZOPxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A37380CFE5;
	Tue, 13 Jan 2026 03:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: stmmac: pcs: clean up pcs interrupt
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827561577.1661897.15750852366703896309.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 03:40:15 +0000
References: <aWOiOfDQkMXDwtPp@shell.armlinux.org.uk>
In-Reply-To: <aWOiOfDQkMXDwtPp@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Jan 2026 13:14:33 +0000 you wrote:
> Hi,
> 
> Clean up the stmmac PCS interrupt handling:
> 
> - Avoid promotion to unsigned long from unsigned int by defining PCS
>   register bits/fields using u32 macros.
> - Pass struct stmmac_priv into the host_irq_status MAC core method.
> - Move the existing PCS interrupt handler (dwmac_pcs_isr) into
>   stmmac_pcs.c, change it's arguments, use dev_info() rather than
>   pr_info()
> - arrange to call phylink_pcs_change() on link state changes.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: stmmac: use BIT_U32() and GENMASK_U32() for PCS registers
    https://git.kernel.org/netdev/net-next/c/a2745a99ca4e
  - [net-next,2/5] net: stmmac: move and rename dwmac_pcs_isr()
    https://git.kernel.org/netdev/net-next/c/879070eb4cf7
  - [net-next,3/5] net: stmmac: pass struct stmmac_priv to host_irq_status() method
    https://git.kernel.org/netdev/net-next/c/aa9061269215
  - [net-next,4/5] net: stmmac: change arguments to PCS handler and use dev_info()
    https://git.kernel.org/netdev/net-next/c/52f37fd9f4dc
  - [net-next,5/5] net: stmmac: report PCS link changes to phylink
    https://git.kernel.org/netdev/net-next/c/ce24299b5b77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



