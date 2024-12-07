Return-Path: <netdev+bounces-149876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ACB9E7DED
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 03:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD80188934F
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 02:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BD554648;
	Sat,  7 Dec 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dx9Ig/O4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44645038
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536827; cv=none; b=iXy57ZW0MEp2Jv29EcmsIoAKCySvnQL3HOK8q3gSVlIvmSyGnprws3fYCOC+pTVg8z0qg87nWY9YKHFma/SsTDvL+yP/ZqIbzwkv/Tf9Vf7CeO/509Wsd47AZlDr3StFkqLQ/Bime2fvmf7bQgXiBgHsjT5bql2EcGl6Z8MsGvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536827; c=relaxed/simple;
	bh=cxN9EEvzqZMJhAK2tvEyllKqWDypq5j7JWM9sAaKZ6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dMXHJb1tNKzIsjF8K6O2M1uafhxcpsccZJs17pW1AwJ76AwV1XrlqYnp6Xt0Ie7nMH2ZsN9cQ8g2ErH4bnQhiDbyo8lADnHfiSHEFOjuoD9L1W+5C2A3cevzhcQlWM3iZ71BYQUf7wHVumfYr0rb7G5XSmyA6lEHxFmmxDtXL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dx9Ig/O4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363DBC4CEDC;
	Sat,  7 Dec 2024 02:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733536827;
	bh=cxN9EEvzqZMJhAK2tvEyllKqWDypq5j7JWM9sAaKZ6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dx9Ig/O4CntKVowBiCO41xLh2GXvnS6oX7+sxImPNqa0xwyWuLqCrDDnqbctK83sI
	 1HkfzvhWnvNJ1kznqY34vR8QiW4Zfytvf6f08oZKMtB0h7LU2vWAZ3RIng9EpO3OjN
	 NAfVXK7TQ53wWjIJ1ZHKucLqYP85RfiOvLbWRS4qrVhwEAifJb7k/8B8fs8OihQTvO
	 awcq+RRay/cO2meMqmberb/fOP32G6ZLLxcl8ZuxMW5IHvwYGZnCfqgMdyIw1giLeC
	 vEYLPNbh6MDdCtOXRuqUXgaESnJ7RjGuN8zwcU65BMpy0Go0ux9jEmn9K4NmWu4iFD
	 SdPsnfQ96klNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E9E380A95C;
	Sat,  7 Dec 2024 02:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: phylib EEE cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173353684199.2872036.4694943106487090426.git-patchwork-notify@kernel.org>
Date: Sat, 07 Dec 2024 02:00:41 +0000
References: <Z1GDZlFyF2fsFa3S@shell.armlinux.org.uk>
In-Reply-To: <Z1GDZlFyF2fsFa3S@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Dec 2024 10:41:42 +0000 you wrote:
> Hi,
> 
> Clean up phylib's EEE support. Patches previously posted as RFC as part
> of the phylink EEE series.
> 
> Patch 1 changes the Marvell driver to use the state we store in
> struct phy_device, rather than manually calling
> phydev->eee_cfg.eee_enabled.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: phy: marvell: use phydev->eee_cfg.eee_enabled
    https://git.kernel.org/netdev/net-next/c/bac3d0f21c5a
  - [net-next,2/4] net: phy: avoid genphy_c45_ethtool_get_eee() setting eee_enabled
    https://git.kernel.org/netdev/net-next/c/92f7acb825ec
  - [net-next,3/4] net: phy: remove genphy_c45_eee_is_active()'s is_enabled arg
    https://git.kernel.org/netdev/net-next/c/8f1c716090a7
  - [net-next,4/4] net: phy: update phy_ethtool_get_eee() documentation
    https://git.kernel.org/netdev/net-next/c/f899c594e138

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



