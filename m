Return-Path: <netdev+bounces-197291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE6AD8052
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13EB1E2E15
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A1D1EF375;
	Fri, 13 Jun 2025 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCqleTZl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67711EF094
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749778214; cv=none; b=QgDqFHHGg16swD8UaSxuAJtrQivemxH4iYMwht6TBNZlOEFHzGkKusZYT0jvw915swwpedtxIGGFjGwbEuUsiZcR9ZaWCOx3SzsPPyW9Yf4b2j+lt8rzM1RGjbimKzPj6FA4XzfMfFmUWrzgWnZEru/XAVfbe6AA4J5iMqNySBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749778214; c=relaxed/simple;
	bh=LwlHzb+USFDtajhvveyMVwhm1rIFRJbRy+1lG/kXcKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gGX3RgIA8emA6l3Z1GBObqDk4MCl8w4e8XzsV3wCviR6ESH/xFELXVnMmdTVRtN1RoXFsM1W1J/JbsmZQCAQKIKwuUY3SnOS7WBRYI6++NrvWfBs4QFwCiJuQ1fyxuDb6qrjNbenKGiGR499KD/vInebao9hSkhFEVvZwNkZFkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCqleTZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CF1C4CEEA;
	Fri, 13 Jun 2025 01:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749778214;
	bh=LwlHzb+USFDtajhvveyMVwhm1rIFRJbRy+1lG/kXcKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QCqleTZl3XOevnqHF7lXPbnFvVwzjC0fhvOiN540pkr2sl6qduD8MGXv6XGIIgx8D
	 Pn3Zj0wlgw2SNebkLnSr0+idfklcj59ZyRwXlVBhkqZ/gYWQBVXqGtCyUCgSEE0cnD
	 LD7L788k1kGRIeJdi2qBXTO3p77HgOzwAB6TOM7C1lb0xVNcysyk+o/M7I/RDHCu6Y
	 0LQCSgdPIPivC9a76G721uuEwPTWYHUg3AfyIKtbEfWGDDhXCyKTFdvR/0Gx/SalHJ
	 MkQ2xcw5cuaemk5aXpR5+0uJEKrjqI5HmvlguWVyUoxlUJmN8WrRL/C230MG0ScbYW
	 40dWeqePlldNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AC639EFFCF;
	Fri, 13 Jun 2025 01:30:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: move definition of genphy_c45_driver
 to
 phy_device.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174977824399.179245.10924086959131059040.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 01:30:43 +0000
References: <ead3ab17-22d0-4cd3-901c-3d493ab851e6@gmail.com>
In-Reply-To: <ead3ab17-22d0-4cd3-901c-3d493ab851e6@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 23:34:53 +0200 you wrote:
> genphy_c45_read_status() is exported, so we can move definition of
> genphy_c45_driver to phy_device.c and make it static. This helps
> to clean up phy.h a little.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/phy-c45.c    | 7 -------
>  drivers/net/phy/phy_device.c | 7 +++++++
>  include/linux/phy.h          | 3 ---
>  3 files changed, 7 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: move definition of genphy_c45_driver to phy_device.c
    https://git.kernel.org/netdev/net-next/c/00ee2537255e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



