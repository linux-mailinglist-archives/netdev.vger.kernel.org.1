Return-Path: <netdev+bounces-149735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612619E6F7F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2242A18831E2
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AFA201269;
	Fri,  6 Dec 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QceMpiHA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1093036126;
	Fri,  6 Dec 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493019; cv=none; b=q2FA0ad1acjiBaSACyOEdWvSwBtAwpSDxt24EqEaqgwAjqFGGfc37/Qyutlvxqh3WNuaKJI5gfsxkZAn7qvfskokRU6tosBwVaiZnbbgvgYkc8/GWDnRVNy0yYHU8xrS5mIbP8DrmAPM0a+JLmMs53u6oVfH1F9Q8LsQjHs54Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493019; c=relaxed/simple;
	bh=wlRY6k7NolzfAGAka37pQ5kdxPVTKWbmUW1+NF1SLrg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HGqebJJtClYBO0axEQK2xMc6sSAfV3DI2oUsfLi58EyXeohYChZv9UWJ4MUz2bQ34i/U7OCSz2rl5Dk9xMQqr5HGTofAvhCiGU32DauBEvRbXAtGPKlsO4TV3Jxh7Ii0pu8Q669xASSaUN8hXobpoAanYOdk8+k36ldh6skQ098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QceMpiHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC49C4CED1;
	Fri,  6 Dec 2024 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733493018;
	bh=wlRY6k7NolzfAGAka37pQ5kdxPVTKWbmUW1+NF1SLrg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QceMpiHAFZR8JJiyeg7s5mwGm3WcHP4x9gLp/aBN/WHFssHLGfpXWX1ZS+A3Os4tE
	 N4LyQpVlyR+1GZYL1mhH3XF/groDzF5/75iLGYZD7pCuswXx7Abmj7X00fUjnvaDTL
	 0YYYw17HguZoT8GZj5/JtyiEtLHKxZRn1uu8Pp04+zHqbX7OQoFLTM2mBSLmxtFitG
	 KMr2J/yFrRCzNeWPxmhKgTSeE91d6oXQIm7xVsbnl9UZo4pRgqhVsFP28FxKzyT5oZ
	 XCDxZjzER94yKF2Vowt4LQdzcqUMY8bkaL1XV+ERvp1Dp+jvxwmvGL9pqJX0vdZL76
	 DnSz6bVnAtiJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE076380A954;
	Fri,  6 Dec 2024 13:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/10] net: freescale: ucc_geth: Phylink
 conversion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173349303350.2342394.11250822704225305865.git-patchwork-notify@kernel.org>
Date: Fri, 06 Dec 2024 13:50:33 +0000
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, christophe.leroy@csgroup.eu,
 hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, horms@kernel.org, herve.codina@bootlin.com,
 u.kleine-koenig@baylibre.com, linuxppc-dev@lists.ozlabs.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  3 Dec 2024 13:43:11 +0100 you wrote:
> Hello everyone,
> 
> This is V3 of the phylink conversion for ucc_geth.
> 
> The main changes in this V3 are related to error handling in the patches
> 1 and 10 to report an error when the deprecated "interface" property is
> found in DT. Doing so, I found and addressed some issues with the jump
> labels in the error paths, impacting patches 1 and 10.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/10] net: freescale: ucc_geth: Drop support for the "interface" DT property
    https://git.kernel.org/netdev/net-next/c/3e42bb998c6d
  - [net-next,v3,02/10] net: freescale: ucc_geth: split adjust_link for phylink conversion
    https://git.kernel.org/netdev/net-next/c/1e59fd163100
  - [net-next,v3,03/10] net: freescale: ucc_geth: Use netdev->phydev to access the PHY
    https://git.kernel.org/netdev/net-next/c/43068024cc2a
  - [net-next,v3,04/10] net: freescale: ucc_geth: Fix WOL configuration
    https://git.kernel.org/netdev/net-next/c/d2adc441a19a
  - [net-next,v3,05/10] net: freescale: ucc_geth: Use the correct type to store WoL opts
    https://git.kernel.org/netdev/net-next/c/420d56e4de52
  - [net-next,v3,06/10] net: freescale: ucc_geth: Simplify frame length check
    https://git.kernel.org/netdev/net-next/c/270ec339126a
  - [net-next,v3,07/10] net: freescale: ucc_geth: Hardcode the preamble length to 7 bytes
    https://git.kernel.org/netdev/net-next/c/dba25f75383f
  - [net-next,v3,08/10] net: freescale: ucc_geth: Move the serdes configuration around
    https://git.kernel.org/netdev/net-next/c/efc52055b756
  - [net-next,v3,09/10] net: freescale: ucc_geth: Introduce a helper to check Reduced modes
    https://git.kernel.org/netdev/net-next/c/02d4a6498b30
  - [net-next,v3,10/10] net: freescale: ucc_geth: phylink conversion
    https://git.kernel.org/netdev/net-next/c/53036aa8d031

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



