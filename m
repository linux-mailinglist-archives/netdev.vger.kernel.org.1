Return-Path: <netdev+bounces-216578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F305CB3498C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D16268054C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444F030AACA;
	Mon, 25 Aug 2025 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdAhf7AJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BA23093A5;
	Mon, 25 Aug 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144818; cv=none; b=H4DHU+SKWHna847L4tyy9W/742+EUm2dDV+SmL/WldjvpkNz43ylBWOJcpmPBJYkMLWyrz0XuImx5Si7YjzlHPi6cuBoUS4VJdVPgBB21lkYjlkxT71YuaNcfoWPFgKcOFSTYVDiR9r6+Ap2aCGz2tFqhdXSdnLltQa4Pr+pEi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144818; c=relaxed/simple;
	bh=obyM1xzkFe5F0W6yYqjYXYmxkGX84FAAujl2Dt7+mzw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=erRDPAj7EjmnVHb1ZLlqEWqxwUpGNuKvqGrS2PZ6EnChwoSgyeLlpyt5w89s5WkL7c1X4aOUcsAKbh6uxGn/ghYTiC5Hp27+0lxH2vMUxeMOESuU0SXR0dC+vV/WpRnJCYOsPZ4AT4G+lumRQo459EcCyTcgXclEfRuhMMT+ElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdAhf7AJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB91C4CEED;
	Mon, 25 Aug 2025 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756144816;
	bh=obyM1xzkFe5F0W6yYqjYXYmxkGX84FAAujl2Dt7+mzw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WdAhf7AJHdpC2cuNW6mm4vKBN+Znx4teixhfMBViAc0EdfC8PJDF0xxnelbtShqgl
	 1yXLaj4PDK6zAfhp50cL2dyAHs9pm3H2q79cmNYJcMELVzuKlW4blOPYahOacK03pp
	 it+wLucijznfjuREXENxWP+4GRSDAi7CZLsL+gnnolsOSyGv0akHvvF17+/lFTDMLS
	 wcUhUmgYBrnbyMIgvhz0G4U4M3dofpzVnAvO4TZ7iWiN7CrpraWnD9kJuN3mwKVt+E
	 srZP0RMbjh6nqAERYOXDMMoVgRxvArgyf1JIKGBMQekGjnXQCJxE0kx9J8K7COx+gg
	 h8TGMoN32t6/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE36D383BF70;
	Mon, 25 Aug 2025 18:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] Aquantia PHY driver consolidation - part 1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175614482452.3508254.15723019808056627426.git-patchwork-notify@kernel.org>
Date: Mon, 25 Aug 2025 18:00:24 +0000
References: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, daniel@makrotopia.org,
 linux-kernel@vger.kernel.org, nikita.yoush@cogentembedded.com,
 bartosz.golaszewski@linaro.org, robimarko@gmail.com, frut3k7@gmail.com,
 sean.anderson@seco.com, jonathanh@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Aug 2025 18:20:07 +0300 you wrote:
> This started out as an effort to add some new features hinging on the
> VEND1_GLOBAL_CFG_* registers, but I quickly started to notice that the
> Aquantia PHY driver has a large code base, but individual PHYs only
> implement arbitrary subsets of it.
> 
> The table below lists the PHYs known to me to have the
> VEND1_GLOBAL_CFG_* registers.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] net: phy: aquantia: rename AQR412 to AQR412C and add real AQR412
    https://git.kernel.org/netdev/net-next/c/7cd3597b8f6f
  - [net-next,02/15] net: phy: aquantia: merge aqr113c_fill_interface_modes() into aqr107_fill_interface_modes()
    https://git.kernel.org/netdev/net-next/c/a31b1c1591e8
  - [net-next,03/15] net: phy: aquantia: reorder AQR113C PMD Global Transmit Disable bit clearing with supported_interfaces
    https://git.kernel.org/netdev/net-next/c/5433fbc3adcd
  - [net-next,04/15] net: phy: aquantia: rename some aqr107 functions according to generation
    https://git.kernel.org/netdev/net-next/c/9731bcf202e6
  - [net-next,05/15] net: phy: aquantia: fill supported_interfaces for all aqr_gen2_config_init() callers
    https://git.kernel.org/netdev/net-next/c/ab1dfcb5bce1
  - [net-next,06/15] net: phy: aquantia: save a local shadow of GLOBAL_CFG register values
    https://git.kernel.org/netdev/net-next/c/08048ba4285e
  - [net-next,07/15] net: phy: aquantia: remove handling for get_rate_matching(PHY_INTERFACE_MODE_NA)
    https://git.kernel.org/netdev/net-next/c/6fa022088b60
  - [net-next,08/15] net: phy: aquantia: use cached GLOBAL_CFG registers in aqr107_read_rate()
    https://git.kernel.org/netdev/net-next/c/832b63c70ef0
  - [net-next,09/15] net: phy: aquantia: merge and rename aqr105_read_status() and aqr107_read_status()
    https://git.kernel.org/netdev/net-next/c/c03c97e55f62
  - [net-next,10/15] net: phy: aquantia: call aqr_gen2_fill_interface_modes() for AQCS109
    https://git.kernel.org/netdev/net-next/c/02a7f5a92545
  - [net-next,11/15] net: phy: aquantia: call aqr_gen3_config_init() for AQR112 and AQR412(C)
    https://git.kernel.org/netdev/net-next/c/2d9503217520
  - [net-next,12/15] net: phy: aquantia: reimplement aqcs109_config_init() as aqr_gen2_config_init()
    https://git.kernel.org/netdev/net-next/c/ed1106f7f926
  - [net-next,13/15] net: phy: aquantia: rename aqr113c_config_init() to aqr_gen4_config_init()
    https://git.kernel.org/netdev/net-next/c/3c904dd67f50
  - [net-next,14/15] net: phy: aquantia: promote AQR813 and AQR114C to aqr_gen4_config_init()
    https://git.kernel.org/netdev/net-next/c/9dfe80a8157b
  - [net-next,15/15] net: phy: aquantia: add support for AQR115
    https://git.kernel.org/netdev/net-next/c/fb4b9f13718c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



