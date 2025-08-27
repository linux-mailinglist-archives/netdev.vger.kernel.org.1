Return-Path: <netdev+bounces-217107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C027B37626
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8C2360CDC
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07961C5D77;
	Wed, 27 Aug 2025 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdOZGNqI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF8F30CD93
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756255208; cv=none; b=uYYtDU5DlPsUOnil1k6YugLOmF/8eFgnqpfF8kGMLpzJJCt18S70hvFB6hJmJr5Qd9XO5M945ZRE7foQ+vA/05oXTKmKMMyLc9BJhVXKQ75tGmIClLP2iggyKPjeW5qxiGYU2KX8p3E3m/8+QD20odsLM1nQDsDuP/mqLjbOvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756255208; c=relaxed/simple;
	bh=rOWd0dad/JaZgS9UaS6gp7tqvB0WK7HHN/V7LN1DzOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MiMImmAyV67WfvTkwBAzfeFGoKRevVoY3cVTJNEpt9KhBnh95X30qa2fFKDWJ4g2vtP++GdghrsEbEoZeVQ0g3FlqAyYUF6G7aTm97WDqbYa5CxlCzPJVC2jWCrgkDAQRNgmTmlg5lO+rLdnmzkEWn2GS+Sox4hhnz9u0VEcVOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdOZGNqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07D5C4CEF1;
	Wed, 27 Aug 2025 00:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756255208;
	bh=rOWd0dad/JaZgS9UaS6gp7tqvB0WK7HHN/V7LN1DzOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TdOZGNqIQLOXj0+uDLvXJg4L3Zx0KgmU2Y+eUPmTHGAsGUQFEQHrAnsvvPSTZ/r7Y
	 P1JUdW3ZKlpOQrCPvQ+8YZQUA1hQ3xdFYtKWiM4GAiUMgl1Y7K4WBvvbtSlVHV/XoA
	 3yT5fpu32oDQiYQ12CpGo+N8DV64CXsnI32k8bPRLqbrmBN2RlopYnJ8nL99uyL0is
	 I0kYHLj+W2SzTB4jIrqkUgi++11E+p6Ic8bgLpUPy0r2V3/i8jlgrEQzzFsCe7Wsse
	 HV5Mc8GhvIXE1bfNnLodM4ESfDHC7dM3xn+5dNULlba7P1axowmVYygSWu1KHLB6gL
	 yHQAoZ8s0Y/7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DEF383BF70;
	Wed, 27 Aug 2025 00:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: fixed_phy: let fixed_phy_unregister
 free
 the phy_device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625521599.151180.8772997408710007776.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 00:40:15 +0000
References: <ad8dda9a-10ed-4060-916b-3f13bdbb899d@gmail.com>
In-Reply-To: <ad8dda9a-10ed-4060-916b-3f13bdbb899d@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: olteanv@gmail.com, andrew@lunn.ch, andrew+netdev@lunn.ch,
 linux@armlinux.org.uk, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 23 Aug 2025 23:25:05 +0200 you wrote:
> fixed_phy_register() creates and registers the phy_device. To be
> symmetric, we should not only unregister, but also free the phy_device
> in fixed_phy_unregister(). This allows to simplify code in users.
> 
> Note wrt of_phy_deregister_fixed_link():
> put_device(&phydev->mdio.dev) and phy_device_free(phydev) are identical.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: fixed_phy: let fixed_phy_unregister free the phy_device
    https://git.kernel.org/netdev/net-next/c/a0f849c1cc6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



