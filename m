Return-Path: <netdev+bounces-176245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583BDA697DE
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56244283C4
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6F2206F31;
	Wed, 19 Mar 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogkry/uL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F501ACEAC
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408394; cv=none; b=QhHk7ygwPWwzT9d8i5tlH36G2gIJad7pInmw9Ip5lAhMQ+13JQVGULo/5NSFhuHw6npIntUNhSdh3YmuU+JODcO0PTBl9Goyxq24sqZHb8vP3LyDn2E22bAeUBeiyWdfvNTij03YA/Eqq2T3e2wuQoShRJe7XP88AcQzSra7f9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408394; c=relaxed/simple;
	bh=1uv1URa/oRq4i2/FSY/Z0hXKn2aDIlpZ/PJX3KA9iqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EpM0onCWrM0zJRzHE0if7SWP+61Z6nq9AuTa437TiqCDYLHeV9gezj9C6sKwozUuhAhWoTLGzG1lsWA9U00OV47hVdeMSBx0a76eDVheLIwwUaZjlAevyhi5ihNjdJzZcZEU5vkORCJcmfOQpo24Npf/T0jvMbA9QgGxy5jAggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogkry/uL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540ACC4CEE9;
	Wed, 19 Mar 2025 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742408394;
	bh=1uv1URa/oRq4i2/FSY/Z0hXKn2aDIlpZ/PJX3KA9iqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ogkry/uLGFZPAuy9ejUxn3abPrdKF6wuiAYtx7Ke5zGAoP9cciScohsOPprgiOBHj
	 Mq2O9kLJliQOawhOYOX0HV4eHyeqyahRbkeBdvQRW/QrcYCNbMATJElWb1iEJhQ6De
	 Yc1hgyUQmpXnj7PlAexV3FvsN7LZ70bJHmRP7CzJUPB4/XLAI0s0XorSnA/fxgSRom
	 WYU+okgQyi/zJLo7oBxhHXo+ZcUUVvBLe9VsBXdTSaa2LQzettZzLnvnT24mLFwc+0
	 uj9+duZ2Xo6/NN2M94mFN2E+Lykvv7lArfUaBdIAfoB9eurJ9/C/uh8mK5oJU7lU7/
	 sblt3k6OiHOFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 369E1380CFFE;
	Wed, 19 Mar 2025 18:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: dwc-qos-eth: use devm_kzalloc() for AXI data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174240843003.1143902.13702964341385385111.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 18:20:30 +0000
References: <E1tsRyv-0064nU-O9@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tsRyv-0064nU-O9@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, jpinto@synopsys.com, larper@axis.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 19:43:09 +0000 you wrote:
> Everywhere else in the driver uses devm_kzalloc() when allocating the
> AXI data, so there is no kfree() of this structure. However,
> dwc-qos-eth uses kzalloc(), which leads to this memory being leaked.
> Switch to use devm_kzalloc().
> 
> Fixes: d8256121a91a ("stmmac: adding new glue driver dwmac-dwc-qos-eth")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: dwc-qos-eth: use devm_kzalloc() for AXI data
    https://git.kernel.org/netdev/net/c/c9cb135bc604

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



