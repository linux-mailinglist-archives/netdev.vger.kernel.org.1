Return-Path: <netdev+bounces-239312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9857EC66CD8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C03E0354276
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAEF2FF665;
	Tue, 18 Nov 2025 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXOunEyg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC02FF660
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428246; cv=none; b=iZGdvpWtzrlLBQJxy4qVMljzVDxyakkke9lCdi3s6OSIUsedRizahGfn/Sph6HvIgYkFANWrXbgnNPZy/X70dHj/aqq7KvzDlzZgjVcbPZP8i5fMyJ3x9nBRGeP0aE9Qn99nCzYlCKq7/LoFMTBLfggeaMZ2ewMe5By1WiWfeHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428246; c=relaxed/simple;
	bh=cdgUYS/4VIJhThN3s2zbdVbIg6MLl1gnF7h3+2ELwEc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=REygLfDTcrR5BmfzON19GC0zX1brBMMlQeUmEiwR/AI1XF2FHzE5d3z728xqK1Zv+A05vo+3ai/KiU/RKJuFR2Dvo1FjZ4sJMivzwH0gDwr3lnDk84RMf3W5zvTiJFJBGKTePGCCjupZn8q4PPWVwPs69pYUQYqURWX6/DeR60w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXOunEyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8813C4AF09;
	Tue, 18 Nov 2025 01:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763428245;
	bh=cdgUYS/4VIJhThN3s2zbdVbIg6MLl1gnF7h3+2ELwEc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JXOunEygBcAfLUSA2xHPuutTSkqCNZcQcmK5iKYV1nxM111ycI1QmdSx1E72o34Oh
	 LQILO8nMQaJPq2J2FejKX7/BoQBqYG9J23SAZXn1FONvVJCFNS9vhPN2HQzAGh/SNI
	 sgmSzhf54ywBJMYKRtseWxbEqqyDOlJT8jE+LrAyIXvzhWzSGxAyWhnh7189q7JEVi
	 xuiKzcQIPWi69WzMokAxrOUQuATnVDpTlbn1reAS05KZoTFmqp7Sg1kOU5vYms5xre
	 l8bzXux+ge/7YlJNSLqGTstzK6vzj3dwkP5G4PFccTDEzG5g/bUD9J3aPDMdUQN0dH
	 TYVmdRP5TwOoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343983809A18;
	Tue, 18 Nov 2025 01:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: fixed_phy: remove setting
 supported/advertised modes from fixed_phy_register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176342821174.3535669.6092583047597642085.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 01:10:11 +0000
References: <3abaa3c5-fbb9-4052-9346-6cb096a25878@gmail.com>
In-Reply-To: <3abaa3c5-fbb9-4052-9346-6cb096a25878@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 22:06:13 +0100 you wrote:
> This code was added with 34b31da486a5 ("phy: fixed_phy: Set supported
> speed in phydev") 10 yrs ago. The commit message of this change
> mentions a use case involving callback adjust_link of struct
> dsa_switch_driver. This struct doesn't exist any longer, and in general
> usage of the legacy fixed PHY has been removed from DSA with the switch
> to phylink.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: fixed_phy: remove setting supported/advertised modes from fixed_phy_register
    https://git.kernel.org/netdev/net-next/c/5860bb1ce0dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



