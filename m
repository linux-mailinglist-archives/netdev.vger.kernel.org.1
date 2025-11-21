Return-Path: <netdev+bounces-240617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 502F5C76F66
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E471C28E8C
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 02:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58D481AA8;
	Fri, 21 Nov 2025 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twk/p/gY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132636D514
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763691049; cv=none; b=FAYAPvaJ2fZUk8xuW1D+IptXbPzrK+cIcmBMpUNXzx1zo7Imjc1IpWJJR4KWJNXz7bI+Jkuc8h5zzYDklBRKJaIK4ScUiUKw/nKy0HQZqAVn8IakREkek27XLoB7hfJ/cihhm9zrZfw7kdqBsJNKhxiSWtp8dAKE/B1cBm0JW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763691049; c=relaxed/simple;
	bh=kvQa++p6gglRftEUktn9riubSNfwD3W32cZEi9pBAWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j4mCdB25T8/tjWTHxvDN4UbAXNq7jO5G8rJ6T4EsQkz6PgoXZY4Jz0jsJlvgdvSjBsJB3sGjX9RL1fSjFeVRimdjl5npA7HBXPTF6oKNFJnfj3isJ5ltP8vmNO3XxE79JXanRfi1TQEi9RbCHPOSFbNEtKIde32tbQk7FdHo5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twk/p/gY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F68C4CEF1;
	Fri, 21 Nov 2025 02:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763691049;
	bh=kvQa++p6gglRftEUktn9riubSNfwD3W32cZEi9pBAWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Twk/p/gYlYP/EAWT4XmRrWKgonGQLRZk4KA6jUI/fJ6FBAjFd3oAePormezFh4aqF
	 yYTovm5a3b3obx99AnDkhX+iIl6xdknkkqQJ4RDmVmFf1J+fbES1ATO2Uf/09y8oc/
	 /4PSNZf2OqOVJk005Vj7PyDkJ/ghko3Hu3cvkWTCjN7TC3EKD1yp9zgSkRAEOpHDvo
	 rK3dj3MFy/a2qMrFtB2aN2lX+KHvElo630SKk1mjt0JpbOJNCCmMZ+JqwcHmFuISu3
	 6LFZIl+eUCBIt0qVE1cp8I5KnMJipdNnJmFOAAzLfw5yhbHqmPn1GP63R3hQoF/3bK
	 WTYj4OE0xzPog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3553B3A41003;
	Fri, 21 Nov 2025 02:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: stmmac: simplify axi_blen handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369101402.1860510.18224805167286449640.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 02:10:14 +0000
References: <aR2aaDs6rqfu32B-@shell.armlinux.org.uk>
In-Reply-To: <aR2aaDs6rqfu32B-@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 10:22:32 +0000 you wrote:
> stmmac's axi_blen (burst length) handling is very verbose and
> unnecessary.
> 
> Firstly, the burst length register bitfield is the same across all
> dwmac cores, so we can use common definitions for these bits which
> platform glue can use.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: stmmac: dwc-qos-eth: simplify switch() in dwc_eth_dwmac_config_dt()
    https://git.kernel.org/netdev/net-next/c/f7ac9a0bbe3f
  - [net-next,2/6] net: stmmac: move common DMA AXI register bits to common.h
    https://git.kernel.org/netdev/net-next/c/8c696659f47a
  - [net-next,3/6] net: stmmac: provide common stmmac_axi_blen_to_mask()
    https://git.kernel.org/netdev/net-next/c/2704af20c8e5
  - [net-next,4/6] net: stmmac: move stmmac_axi_blen_to_mask() to stmmac_main.c
    https://git.kernel.org/netdev/net-next/c/6ff3310ca282
  - [net-next,5/6] net: stmmac: move stmmac_axi_blen_to_mask() to axi_blen init sites
    https://git.kernel.org/netdev/net-next/c/e676cc8561c8
  - [net-next,6/6] net: stmmac: remove axi_blen array
    https://git.kernel.org/netdev/net-next/c/efd3c8cc52bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



