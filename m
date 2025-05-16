Return-Path: <netdev+bounces-191216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E06BDABA658
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC23D1BC0861
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894BD283142;
	Fri, 16 May 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2WQGSLT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655428313C
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437011; cv=none; b=UtoAYI782NciAZRaJ7OAyQyR3NG5yOaGjy2eKDBrN3xjwk8vTKAJZkxhjTJhGvgMdiPJfFdV7IUnlD/tkmX6ErDp6hveNFfyT6oHK90k8fOH+vAoMYUN3yrJA+krHrBk/tKG6YT3JcwdQLhafxmEV3xRdDPUIwtvwaz9RzFO79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437011; c=relaxed/simple;
	bh=bufjGSeO0XItofQbEUHtxxWQjHDaD81n4jcpv3STAjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pj4VD12QrWVBM5E876fEE5s1Q6cLQC3ddkv5Ou7oiMlfVS77G9y/aG1Z6AzD2b+7qqGT+xkDnSYAsl9PMo1CmFOFjaFnDxDOTdwdC3tUm2tf6lD5hsMu0Ah7l1rxG9kVqbI9gbUKdYi6JzXtASpEvddWiOf6vIE6Cix/l2gOnL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2WQGSLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFD9C4CEE4;
	Fri, 16 May 2025 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747437011;
	bh=bufjGSeO0XItofQbEUHtxxWQjHDaD81n4jcpv3STAjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P2WQGSLTJgG2OpLYQzyjjIqXjs9g1DC2bDVQmSFd15I/HNHxJ7/QnkoEbRPOYkKS+
	 +muRW2uSvGdqz7US3RQ2MXy1vkHbdAR1MeKHGV/AtecSmGnw7/VYg3Wt1ti6/l2+SL
	 qs/3ijpoQvLEAOhBJWJUBNz01z2UGMGjNj2dP+E9X+3rPTUyERNPEbk+fWjkI3fGXY
	 t7JdFUcE/7TLpRRGUn1KXFScY+Ug+FAdSC0sCZD66vzF+973He6wBWrjrwiXNxyWsI
	 bspLzrW7HCJW4Gz7LJEtLaFlG/mtT3fGT+LGybXoT/zhRk/jB0UwVTZ7pQ5eOSzixY
	 dgoTWMPYWkgaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C1E3806659;
	Fri, 16 May 2025 23:10:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: fixed_phy: remove
 fixed_phy_register_with_gpiod
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743704774.4089123.3025889017416247577.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 23:10:47 +0000
References: <ccbeef28-65ae-4e28-b1db-816c44338dee@gmail.com>
In-Reply-To: <ccbeef28-65ae-4e28-b1db-816c44338dee@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com,
 edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 May 2025 20:54:29 +0200 you wrote:
> Since its introduction 6 yrs ago this functions has never had a user.
> So remove it.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/fixed_phy.c | 32 +++++++-------------------------
>  include/linux/phy_fixed.h   | 14 --------------
>  2 files changed, 7 insertions(+), 39 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: fixed_phy: remove fixed_phy_register_with_gpiod
    https://git.kernel.org/netdev/net-next/c/7b151e4efdde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



