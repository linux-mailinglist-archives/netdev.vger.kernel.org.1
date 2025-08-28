Return-Path: <netdev+bounces-217527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C04B38FB6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E1A16C422
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDAA1519B4;
	Thu, 28 Aug 2025 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKmwfu7E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2C86347
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340407; cv=none; b=E04KhzDPCKe1AITaoTh6X1ovk+XRY6iHhRKh5qp6X+rPCk9eqMDOWBl8h8L3uR0kUHsPktQUfKHw2KEuhl0TbL0x8LNvrknHI+8osvgC1NjHkAM7r3pXR2ArDMfPXIHhvE4nQ1yOwSGOniS5KFNTs9bxD9K7aTF6e+YJ8OOyHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340407; c=relaxed/simple;
	bh=aHeD1aY+qybOF2MyfLbGundw1HAEI2tqJvxtmi3Qw/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V9QiDqMQQDK5/c8jIVKSxJA/6oGWDPWwubuKZClFv1dKXmLnjwO5UTjK7kS/XBrGbsaCfa0A3/RUVMKMvjzCg9z31ekcsNQrdYFz5mr/Ja0STE2hCCH0WXs6IvUVZ2jmpu23+uo1RhrC+VOifEIkJ3Eqqi5QkwHatHgX3Wb5CO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKmwfu7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75385C4CEEB;
	Thu, 28 Aug 2025 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756340406;
	bh=aHeD1aY+qybOF2MyfLbGundw1HAEI2tqJvxtmi3Qw/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LKmwfu7EHjfehihErSqcf5xhSZpGelriAcJqReGjZEWRHMG0ukUwzBfpAiGFjK5X/
	 woBVjMzQfva3EJQlyJAhKs+I3r4lDVdFeI0LP8ET2UXapzFdn8C0Y9yMS/5cUxQEsE
	 Zq/bqUdNiZyDXczcSxbSOlOCYXP+NfeZTX9pcLqkQOrPaX91xvo49vfSLNa6kSQfi3
	 5tREyjUtNSWv5mNH36Kbh7CcSSQ+8qzpAQXF2LSR2Xew55M07wlwiFqk8FrhNQPITM
	 DnLjDkPF5H/mbRi/WRq0nMgJGbtCzxnwMbC6oNItJpnuYKduwI84k/naMrj8n4dfDk
	 6D+oPjXxtuOfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFC9383BF76;
	Thu, 28 Aug 2025 00:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: rk: remove incorrect _DLY_DISABLE
 bit
 definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634041376.884225.299755705945387138.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 00:20:13 +0000
References: <20250826102219.49656-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250826102219.49656-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: david.wu@rock-chips.com, jonas@kwiboo.se, rmk+kernel@armlinux.org.uk,
 mcoquelin.stm32@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Aug 2025 03:22:15 -0700 you wrote:
> The RK3328 GMAC clock delay macros define enable/disable controls for
> TX and RX clock delay. While the TX definitions are correct, the
> RXCLK_DLY_DISABLE macro incorrectly clears bit 0.
> 
> The macros RK3328_GMAC_TXCLK_DLY_DISABLE and
> RK3328_GMAC_RXCLK_DLY_DISABLE are not referenced anywhere
> in the driver code. Remove them to clean up unused definitions.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: rk: remove incorrect _DLY_DISABLE bit definition
    https://git.kernel.org/netdev/net-next/c/705609dedea1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



