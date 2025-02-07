Return-Path: <netdev+bounces-164191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C73A2CDDF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D837169FB1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F78F1ACEAB;
	Fri,  7 Feb 2025 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT6w/IUs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE71A00D1
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959010; cv=none; b=hnzObrSjzd300c+k9jD3+wbRGCk2q3DL+WlVKfj6twubYFAT2AcCjW8CB7ekVkslhIBuwKFAbEBx+Stce8s5xvC2Z/IrmHt0nBJcbZCr2Q432OY9jl/AW1w+f/P7GnZtnlrJTKRwyO2mBK4zkmljSFNvGz53Odg1fI32r0Grx6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959010; c=relaxed/simple;
	bh=Rb6tOrngBKFH/uFi5jXEWLdvU2cKpJWevMKs0KTRLUs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xj2AWY96xW29CG9pEaXq6NdwQghCkMP0xPo/8rJ6dqs53yR2A0jg9ySEGlut4Bc7z54a7kFAi+yys6B2Eisxzg0vkGyauMp9rZAwpoMjhJH4BRqiUYy2HIw260zMOOXixeZI2uI2igU+4Ll+aKVWLfwOdysaN1ESdBarjSUQ6qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT6w/IUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB72FC4CED6;
	Fri,  7 Feb 2025 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738959009;
	bh=Rb6tOrngBKFH/uFi5jXEWLdvU2cKpJWevMKs0KTRLUs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jT6w/IUsDCfqAGE1rHixJpsbEIHsyac3G88pcgDVqhXoqbFDrA1nkLKZ8ExpVE13r
	 Li6qq/Y7u12Tes8DnkPUqsTKQKfzQJjQjNcszTkWnjRwbZLiYwtJoCDpEVrqix/+KY
	 MhzZzvc2bBkQtNCqstWeFWeZvK3MdmsnjjrfBUZ0Bnm5B1ClGLh9tpFfCoh9Tw1MYL
	 /2QXkBfzA90nL66vXWQEyegL2bRju/KvIfgjaITLMhptU4uAgsFmKoqBpuUFrTzrjb
	 AH9oPm3OAsKj43AdhK0j2BTCkeB7v22MA+0z+VYugZP0tXkmbl+EtpN9486RKWgCk3
	 yhKI1qqmAYuFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEAA380AAF4;
	Fri,  7 Feb 2025 20:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/14] net: stmmac: yet more EEE updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173895903778.2367164.15308538342588355637.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 20:10:37 +0000
References: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
In-Reply-To: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 5 Feb 2025 13:39:38 +0000 you wrote:
> Hi,
> 
> Continuing on with the STMMAC EEE cleanups from last cycle, this series
> further cleans up the EEE code, and fixes a problem with the existing
> implementation - disabling EEE doesn't immediately disable LPI
> signalling until the next packet is transmitted. It likely also fixes
> a potential race condition when trying to disable LPI vs the software
> timer.
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] net: stmmac: delete software timer before disabling LPI
    https://git.kernel.org/netdev/net-next/c/a923378ab0c4
  - [net-next,02/14] net: stmmac: ensure LPI is disabled when disabling EEE
    https://git.kernel.org/netdev/net-next/c/64c9936330cc
  - [net-next,03/14] net: stmmac: dwmac4: ensure LPIATE is cleared
    https://git.kernel.org/netdev/net-next/c/6e9c71ee65eb
  - [net-next,04/14] net: stmmac: split stmmac_init_eee() and move to phylink methods
    https://git.kernel.org/netdev/net-next/c/cc3f4d5508c8
  - [net-next,05/14] net: stmmac: remove priv->dma_cap.eee test in tx_lpi methods
    https://git.kernel.org/netdev/net-next/c/4abd57687355
  - [net-next,06/14] net: stmmac: remove unnecessary priv->eee_active tests
    https://git.kernel.org/netdev/net-next/c/2cc8e6d30895
  - [net-next,07/14] net: stmmac: remove unnecessary priv->eee_enabled tests
    https://git.kernel.org/netdev/net-next/c/faafe39c77fb
  - [net-next,08/14] net: stmmac: clear priv->tx_path_in_lpi_mode when disabling LPI
    https://git.kernel.org/netdev/net-next/c/54f85e5221c3
  - [net-next,09/14] net: stmmac: remove unnecessary LPI disable when enabling LPI
    https://git.kernel.org/netdev/net-next/c/9b6649a81075
  - [net-next,10/14] net: stmmac: use common LPI_CTRL_STATUS bit definitions
    https://git.kernel.org/netdev/net-next/c/6e37877d222d
  - [net-next,11/14] net: stmmac: add new MAC method set_lpi_mode()
    https://git.kernel.org/netdev/net-next/c/395c92c0fe3e
  - [net-next,12/14] net: stmmac: dwmac4: clear LPI_CTRL_STATUS_LPITCSE too
    https://git.kernel.org/netdev/net-next/c/a323ed92e40e
  - [net-next,13/14] net: stmmac: use stmmac_set_lpi_mode()
    https://git.kernel.org/netdev/net-next/c/305a0f68cfbf
  - [net-next,14/14] net: stmmac: remove old EEE methods
    https://git.kernel.org/netdev/net-next/c/62b0a039cac2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



