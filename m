Return-Path: <netdev+bounces-105923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4455913926
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 11:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8662928137B
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 09:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EAC7F492;
	Sun, 23 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGyfsw0d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734AC7E59A
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719133830; cv=none; b=rGuAU9Sz3/XLljO6ayz3P9u8nqYAIpvzSOrQ/lYzej0cTStr9fXiB5MU5GBeCCwPSOQkFrUgDZPEwelf0DvnrE/bG0byRJlLXjdK3HftuSNWWeffCAZA5OSvL0PpweqDdUJKUfPWWCx/OkcQjx8imCaXH4Aynr2Txp/IrXfizMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719133830; c=relaxed/simple;
	bh=CoC8Eo3PIEG8szgjxv6CgqAMxt55AOf+AK6Zv66R9wQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DOIeAmBa3AsOD8CN5vE7vG6ac6N+Zhf+qOEujMILk299CG61oaSCMRm/PxZXe5Rs2vJjEKfLD6Kcbsx8qZpCgB2N2WetYAIRWSG92W9k+kvj1ZVgPtNSg3IPgzp5fq0Gb8dX+/GmTV36tG69ruh5LaiIsvVmI1Mkm/WclLXJZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGyfsw0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF71AC4AF07;
	Sun, 23 Jun 2024 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719133830;
	bh=CoC8Eo3PIEG8szgjxv6CgqAMxt55AOf+AK6Zv66R9wQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lGyfsw0dS6O7bJC7QikO48e04YOWuqw0c3aUaxU+faCvo7eDbqO8p87GAk6ndvld0
	 9Qin101AsGK4Q/E99LwiN+celIHyz2Pnxsx3r2uVUBYFlZgi8FshNEewmvxjwk3/rh
	 JocCYFOFAQOkOa2C5EZr/nsN5Z0l8NDrmm/vpbAyivC+WCnHxpBiABsGx/JdhPXpGj
	 FBV8n0W1AOzjngENRNaEWwnmV2MSQkz87jQhcTiOG6BhVx+KSbY7U7FLf4T+oN7N1h
	 NY+CrT/8onBzVKjR7p1CqmIfd2CineFfgqha/7leKnZt2zkkRBtG6hQJGWd5DWpv5Y
	 PX9GkUrTijSrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE75DE7C4CA;
	Sun, 23 Jun 2024 09:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v7 0/3] Handle new Microchip KSZ 9897 Errata
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171913382990.30896.12292977521606094402.git-patchwork-notify@kernel.org>
Date: Sun, 23 Jun 2024 09:10:29 +0000
References: <20240621144322.545908-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240621144322.545908-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, horms@kernel.org, Tristram.Ha@microchip.com,
 Arun.Ramadoss@microchip.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 21 Jun 2024 16:43:19 +0200 you wrote:
> These patches implement some suggested workarounds from the Microchip KSZ 9897
> Errata [1].
> 
> [1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/KSZ9897R-Errata-DS80000758.pdf
> 
> ---
> v7:
>  - use dev_crit_once instead of dev_crit_ratelimited
>  - add a comment to help users understand the consequences of half-duplex errors
> v6: https://lore.kernel.org/netdev/20240614094642.122464-1-enguerrand.de-ribaucourt@savoirfairelinux.com/
>  - remove KSZ9897 phy_id workaround (was a configuration issue)
>  - use macros for checking link down in monitoring function
>  - check if VLAN is enabled before monitoring resources
> v5: https://lore.kernel.org/all/20240604092304.314636-1-enguerrand.de-ribaucourt@savoirfairelinux.com/
>  - use macros for bitfields
>  - rewrap comments
>  - check ksz_pread* return values
>  - fix spelling mistakes
>  - remove KSZ9477 suspend/resume deletion patch
> v4: https://lore.kernel.org/all/20240531142430.678198-1-enguerrand.de-ribaucourt@savoirfairelinux.com/
>  - Rebase on net/main
>  - Add Fixes: tags to the patches
>  - reverse x-mas tree order
>  - use pseudo phy_id instead of match_phy_device
> v3: https://lore.kernel.org/all/20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com/

Here is the summary with links:
  - [net,v7,1/3] net: phy: micrel: add Microchip KSZ 9477 to the device table
    https://git.kernel.org/netdev/net/c/54a4e5c16382
  - [net,v7,2/3] net: dsa: microchip: use collision based back pressure mode
    https://git.kernel.org/netdev/net/c/d963c95bc984
  - [net,v7,3/3] net: dsa: microchip: monitor potential faults in half-duplex mode
    https://git.kernel.org/netdev/net/c/bf1bff11e497

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



