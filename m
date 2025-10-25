Return-Path: <netdev+bounces-232748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B92C08896
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 04:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2323C1A661B5
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 02:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D261F23EA89;
	Sat, 25 Oct 2025 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQyXSBVN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582A1AB6F1;
	Sat, 25 Oct 2025 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761358258; cv=none; b=YgKLbGYW1QsxpVhjciRqRO7EzSPFHGHsn6ztyzazZy8ssKoWPYmigqjuhV1WAMoIfVJ+9MxGG8x0rmI7DhtYuzUZkcVhu9iYguao6Nc8NKgjLwrLCkotajUI54jckg+JOSuegN0zXR7qhQBf31OZFJqLHf+Lz2/vR4B17h44spw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761358258; c=relaxed/simple;
	bh=T+Ll2yJOvJipZ1CY2YovdDE7zLS7U/JxGi1g5MOaDY0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xfpt91SzJRcTFSAkUL1Mq+DBla/IBfbxX7qbxY8lMHxEFIcNUG9jPd4G6D1n4n687ZkDvPih0OfRhG6kF4+NZwPB7rvRylRE3jzKnaEYBMaR4j5Ogen3Bjs5IWQpHH184NM5NYCMYKAvy2+L1YdOyKcNrZjwzEMrz5+HKZnmJxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQyXSBVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218BDC4CEF1;
	Sat, 25 Oct 2025 02:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761358258;
	bh=T+Ll2yJOvJipZ1CY2YovdDE7zLS7U/JxGi1g5MOaDY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GQyXSBVNQ2gsh3VbvCWUJkxOtGBi2PvK5Uw2J8I/7Q6gYDbzftF5Mmb8R2ZuiO2iP
	 VmrhQUjxJ/GIuekc0+02OscV0BXaDpJPGZYM1OuYI/SDhVjIPRwB04P/hQ5rMpDLPi
	 owxEMYdolKhPn/Rk9WQBnzcpVK1AaugLKzTgxeCNkTO5l47JMbYd1u0s1/YZ+QpoFg
	 UTdtjIkbgebSFZqfzlK/jGhowr2zh3ICOPFavSd8aVnPU0gKRoK/A5R0adJyZhhDmF
	 WSXDevQpnjo4FSklWCyeBR/Yife6fP1EzCiAT1/0LG30ABaaa54dOqfDYuajcVf4IF
	 RYXIZDIbLPtTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEA0380AA59;
	Sat, 25 Oct 2025 02:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] net: add phylink managed WoL and convert
 stmmac
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176135823749.4124588.15892332311706478682.git-patchwork-notify@kernel.org>
Date: Sat, 25 Oct 2025 02:10:37 +0000
References: <aPnyW54J80h9DmhB@shell.armlinux.org.uk>
In-Reply-To: <aPnyW54J80h9DmhB@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, florian.fainelli@broadcom.com,
 gatien.chevallier@foss.st.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, christophe.roullier@foss.st.com, conor+dt@kernel.org,
 davem@davemloft.net, devicetree@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 robh@kernel.org, horms@kernel.org, Tristram.Ha@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 10:16:11 +0100 you wrote:
> Hi,
> 
> This series is implementing the thoughts of Andrew, Florian and myself
> to improve the quality of Wake-on-Lan (WoL) implementations.
> 
> This changes nothing for MAC drivers that do not wish to participate in
> this, but if they do, then they gain the benefit of phylink configuring
> WoL at the point closest to the media as possible.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] net: phy: add phy_can_wakeup()
    https://git.kernel.org/netdev/net-next/c/330ce8ffc184
  - [net-next,v2,2/6] net: phy: add phy_may_wakeup()
    https://git.kernel.org/netdev/net-next/c/b344bfacf1de
  - [net-next,v2,3/6] net: phylink: add phylink managed MAC Wake-on-Lan support
    https://git.kernel.org/netdev/net-next/c/b79fbd86c849
  - [net-next,v2,4/6] net: phylink: add phylink managed wake-on-lan PHY speed control
    https://git.kernel.org/netdev/net-next/c/dc1a2a9ce5b2
  - [net-next,v2,5/6] net: stmmac: convert to phylink-managed Wake-on-Lan
    https://git.kernel.org/netdev/net-next/c/6911308d7d11
  - [net-next,v2,6/6] net: stmmac: convert to phylink managed WoL PHY speed
    https://git.kernel.org/netdev/net-next/c/d65cb2e27e6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



