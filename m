Return-Path: <netdev+bounces-221915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2309BB52583
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE3AF4E03EC
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415E1A8412;
	Thu, 11 Sep 2025 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR8pWo3J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6A2AD22
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757553006; cv=none; b=QXphrfbwN1FtCIqwGLX9v2tGqPNN98qlK+L/yVmnlisAzffmwzHp1CP05OETLHKeOz0vRlhuPPZRmvH2WbNTR5AGixxaXGER2ozJRhLWBsKzNwbMZDHP4zDmqsRfztiQG0qaqWPNY8aF7Gom2PqnBJsla8kmHOIZmGz+V72RRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757553006; c=relaxed/simple;
	bh=MVGxfRakQnPxyH3uyjRFiBz07temXygvvaFLoRNylVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XME70I33A/+DiAaC/Q7NH3zpVgOrH5evm7BMVITeFZzqqDXmAAxxSJ5wIU7/FScuGsFIu1B4NmEAc14CKl4GMuRv5GT6zL94tgmO+Lf2h+is3AtLckRfF8KBkOhYH0Yd/sWg1FosrjDV6srSuBEMsOz40qNpQmn40iLgrq1PC78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR8pWo3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83677C4CEEB;
	Thu, 11 Sep 2025 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757553005;
	bh=MVGxfRakQnPxyH3uyjRFiBz07temXygvvaFLoRNylVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KR8pWo3JR3b3F+aXwXyH2fVJl5W6keyReuBUyj2196B0cEit46XXGgkoJlGkE2EGj
	 qGWFr2glITXyI0/GNojAltsc5NXDcJwHcOjp8EM1MjWCd7cLU93sHbA84wIyLGMDCX
	 0QJRw3BIFaT73mgaGtehKMzLj/BRCw4VAlHCUSTuRNnmbhTUSq3wele7+ogUGXiJem
	 8TR+9z9YME5oaLBYfd7zfw3jVx2rBZxSvsmjLhfAkbmnfeQkmaPN+yQtW9Ybjwth0o
	 9vUCt+HT5fKQ37eSJ4giiOuxpow5/hyBJQJjh5K9FZ+k5Eno0kebMcalRcxqVP39wu
	 aXgpEcOe7svng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 85E48383BF69;
	Thu, 11 Sep 2025 01:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos: use PHY WoL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175755300850.1617124.3396751776402491049.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 01:10:08 +0000
References: <E1uw0ff-00000004IQJ-3AMp@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uw0ff-00000004IQJ-3AMp@rmk-PC.armlinux.org.uk>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 09 Sep 2025 16:54:15 +0100 you wrote:
> Mark Tegra platforms to use PHY's wake-on-Lan capabilities rather than
> the stmmac wake-on-Lan.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> This is the last patch that is needed to WoL on the Jetson Xavier NX
> to be functional - the only patch that hasn't been through netdev
> is the DT patch that's being merged through a different route. Once
> all patches come together (in other words, at the next -rc1), then
> WoL will be functional on this platform.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: dwc-qos: use PHY WoL
    https://git.kernel.org/netdev/net-next/c/724b22d38a83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



