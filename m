Return-Path: <netdev+bounces-218039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D01B3AEC1
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA273BC2AE
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E852DEA90;
	Fri, 29 Aug 2025 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIW41zWE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF302DF6EA
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425614; cv=none; b=XgvTDnrtiqWdgb7a0zHI+EehDBdn38K3AbXmwBojAeflZaLcr4EIMvCOTHsTrPzqlzks0vKHeZeybNSV0KN5AhxLgCknMyqoOM3FPB9/yP6YwEMM+Jw4SN/soAq4APdSIV8Khcvu3dbEyPU+P4GvTGX5A466mBnCDvbEdBnL9Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425614; c=relaxed/simple;
	bh=EZzCIKy2lXRxIz8FZaNB0OLBRJoxff+kx2U+S4qIdmA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cBu1VjMZtpBjzjCEDCCWYWcLTo4jH/BYJCAvHUfQdleZvGZLiHyfemFmerHtRLtGJb7OuJ0/v8hcQARRPBWoWHW2NyqIKM620IyTZU+tJWPtqswRPTglM/fdYuZshu5ytQOq4acE9GdkRqtH5UlwJ2F5e0vsYi8Y0TswiFzKFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIW41zWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1BDC4CEEB;
	Fri, 29 Aug 2025 00:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756425614;
	bh=EZzCIKy2lXRxIz8FZaNB0OLBRJoxff+kx2U+S4qIdmA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aIW41zWEoKT/siuAPM8ufcYo6WlT/agjyfb8P83/trEt+RZwPidbMkL91TG0Veu3p
	 MdtCxCoR+f+6iasNAqxbgllbK+Twhn+jrFri/f5g5jEVT1Kaw6sbRK5fcO9WkmAF9y
	 txY4YAyo7ND8NFCxFhoLe6zzsn53taqmOJvFKwzNGbjGXpRdz0p/ghFJK5XaVWQasL
	 ItH0U3zl6N1FKe9lrym3jPEsCJzQQI1NACSxzuqAanND0sANqBJnowNGliALwn3ZGw
	 bGE9NRrm6nT0KyZ55hH271Ld7PIsM8gJBcMzqn3VHgQTMgjbaK7As7REXL7uKmsySL
	 q7ZCCLvjLNmbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC4F383BF75;
	Fri, 29 Aug 2025 00:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: mdio: use netdev_priv() directly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175642562124.1653564.9988378849956987814.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 00:00:21 +0000
References: <E1urBj2-000000002as-0pod@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1urBj2-000000002as-0pod@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Aug 2025 09:41:48 +0100 you wrote:
> netdev_priv() is an inline function, taking a struct net_device
> pointer. When passing in the MII bus->priv, which is a void pointer,
> there is no need to go via a local ndev variable to type it first.
> 
> Thus, instead of:
> 
> 	struct net_device *ndev = bus->priv;
> 	struct stmmac_priv *priv;
> ...
> 	priv = netdev_priv(ndev);
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: mdio: use netdev_priv() directly
    https://git.kernel.org/netdev/net-next/c/bafdd920a060

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



