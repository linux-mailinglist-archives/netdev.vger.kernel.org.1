Return-Path: <netdev+bounces-249254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DA2D1647D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BC98301FF78
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA181D5CEA;
	Tue, 13 Jan 2026 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQEoT3ph"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B289243969
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768271436; cv=none; b=gp0FNq+UW/DVNHoBXj2/U9WOuMxKT+uIAGAUThAMwsgQFIXboX2EOnUwe9qS7rWUgMkJtH4MJ0E+A2Q4FxTtX0w0tP844Otks4ItalB4m1WFxJvMQlwZrbnsJ/LytI/0Gu4WdMGzzxu2XsIWjrvP2W2WiuHSKHZdV7abCghZXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768271436; c=relaxed/simple;
	bh=ykFPF5PfTurP6Wq683RO5rLVlwtTOfgUgkOw+O9Mh3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lV+dhAWMKCjGnom+j9E27bhVkirSILUvqAjv1P3OBKM7++B+NoRRTJO0nNqBI7bZQwrLxpWNDkdw9r8ZEjh1hgtKtyM2V+TY4zHjrB06vvuPvsWY6u8Ed2uSx4a2VRnh4whnZ2kbQmn8l9g7eYmRCPyC5/nkiTUqOfa/3ZwzV5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQEoT3ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EBDC116D0;
	Tue, 13 Jan 2026 02:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768271434;
	bh=ykFPF5PfTurP6Wq683RO5rLVlwtTOfgUgkOw+O9Mh3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fQEoT3phOQ5LmGcUFeuuh+77bkdrqi3yPAIXfuouf9aTd35aioNYUJOB/xkzG2C9Y
	 E9hW5kVxXBSln5dBfJ+MI+dM42D6JBTXzUB1Kc09yUvSDNAGtZd5OoQV4rUGAvujow
	 L6Ssbupn5SjChziAai1ZzkCGhFZixJ+2Y0Pi/p1C2jL6KDGs9uZVQJkrj88oQPaqew
	 CVRWKfRgpEarzi4qIL1A/4oYYN6YnNZCl8b4kcKrmCb9O+Oz0vuDvtRlznyrJMoAaM
	 2MPFgqWyZM6abDyMjHOmBsfyH83SfRRJDX1JV63vP5gdsEvpkeBaFPOXI5ZacMbbF6
	 JCNs/UinR0Txg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B96B380CFDE;
	Tue, 13 Jan 2026 02:27:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/9] net: stmmac: cleanups and low priority
 fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827122776.1606835.6977840080640500582.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 02:27:07 +0000
References: <aV_q2Kneinrk3Z-W@shell.armlinux.org.uk>
In-Reply-To: <aV_q2Kneinrk3Z-W@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Jan 2026 17:35:20 +0000 you wrote:
> Hi,
> 
> Further cleanups and a few low priority fixes:
> 
> - Remove duplicated register definitions from header files
> - Fix harmless wrong definition used for PTP message type in
>   descriptors
> - Fix norm_set_tx_desc_len_on_ring() off-by-one error (and make
>   enh_set_tx_desc_len_on_ring() follow a similar pattern.)
>   Document the buffer size limits. I believe we never call
>   norm_set_tx_desc_len_on_ring() with 2KiB lengths.
> - use u32 rather than unsigned int for 32-bit quantities in
>   descriptors
> - modernise: convert to use FIELD_PREP() rather than separate mask
>   and shift definitions.
> - Reorganise register and register field definitions: registers
>   defined in address offset order followed by their register field
>   definitions.
> - Remove lots of unused register definitions.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] net: stmmac: dwmac4: remove duplicated definitions
    https://git.kernel.org/netdev/net-next/c/1fd3b573713a
  - [net-next,v2,2/9] net: stmmac: dwmac4: fix RX FIFO fill statistics
    https://git.kernel.org/netdev/net-next/c/65b21a7d4de4
  - [net-next,v2,3/9] net: stmmac: dwmac4: fix PTP message type field extraction
    https://git.kernel.org/netdev/net-next/c/e91a7e45bf0b
  - [net-next,v2,4/9] net: stmmac: descs: fix buffer 1 off-by-one error
    https://git.kernel.org/netdev/net-next/c/ec3fde9eead0
  - [net-next,v2,5/9] net: stmmac: descs: use u32 for descriptors
    https://git.kernel.org/netdev/net-next/c/d3b8c9b39356
  - [net-next,v2,6/9] net: stmmac: descs: remove many xxx_SHIFT definitions
    https://git.kernel.org/netdev/net-next/c/670d10509f85
  - [net-next,v2,7/9] net: stmmac: cores: remove many xxx_SHIFT definitions
    https://git.kernel.org/netdev/net-next/c/8409495bf6c9
  - [net-next,v2,8/9] net: stmmac: arrange register fields after register offsets
    https://git.kernel.org/netdev/net-next/c/58bc0f0bfc1b
  - [net-next,v2,9/9] net: stmmac: remove unused definitions
    https://git.kernel.org/netdev/net-next/c/5a78fd3debad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



