Return-Path: <netdev+bounces-240187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EED37C7114A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 21:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64ADC4E1773
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D05A2248A4;
	Wed, 19 Nov 2025 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esopco5f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E3381AF;
	Wed, 19 Nov 2025 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763585441; cv=none; b=l/gINe1BuRgT46ahacH6kBLKGJH2IX166z1wcOADQUONVsDFkfb0fhOvBWRYnDR4gkoHLlwmg1vrJL4Lu62+sRU9g/v2um14zHbVbpaYKkjFw/rO+YBdQiF1bCzhR119cDqVMd676Nd5rV3E/+um1zPlTJidGzqkwx/ShU53X/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763585441; c=relaxed/simple;
	bh=J2c1fjwa+yt9uPbX5uPXfsUp62Oz63qt6jFCL56S860=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sUloc7hx48AaGkfXEy2Zf2KfZLJ63kua1ecfZUkyq1dGDh/efMvZbP//RjP1HH+AXd5lCnk65ccBBfi06Uf0uZg0dqDh6AHWgdlTVfXtPkFpWo5iV65uR5/hnxYJGSALOO84rCPOpSzd+o2tO09OGKXTgQmfe5DMiOUV7zDMTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esopco5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2513C4CEF5;
	Wed, 19 Nov 2025 20:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763585440;
	bh=J2c1fjwa+yt9uPbX5uPXfsUp62Oz63qt6jFCL56S860=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=esopco5fr4IjgrTIY121iPqaJDfMrcq7Yg6blqNVOMZ1AUrd5JCDWtrhFdB5dwG4n
	 O2OX+2vfIIanACqEiN8a+sG4SduVM1zf9/YzqWsR+UoVY5fD0GM1t92FG/Wibl050d
	 uXJWRE9cZLaFhmRY+qkmi1hpIqV0ls9jcJCjqr3POth4REJXAVytEoUdrfia15COZC
	 h79ew/+z9q+rLh+jXZCIYrH2C5jZqRs/K7LvjgX4UJz/SHq0nvCjcEcNykR/v+OfIn
	 fFpLt/Y65B0YxN7nzH+ygc8pla0f3rNT5/2DyOjTQESdoQoH483HZS2vA9cLA+8y6w
	 6s0j8LCnSaCoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF7439EF94E;
	Wed, 19 Nov 2025 20:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: phylink: add missing supported link modes for
 the
 fixed-link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176358540651.954142.2378639100953364508.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 20:50:06 +0000
References: <20251117102943.1862680-1-wei.fang@nxp.com>
In-Reply-To: <20251117102943.1862680-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 eric@nelint.com, maxime.chevallier@bootlin.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Nov 2025 18:29:43 +0800 you wrote:
> Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
> initialized, so these link modes will not work for the fixed-link. This
> leads to a TCP performance degradation issue observed on the i.MX943
> platform.
> 
> The switch CPU port of i.MX943 is connected to an ENETC MAC, this link
> is a fixed link and the link speed is 2.5Gbps. And one of the switch
> user ports is the RGMII interface, and its link speed is 1Gbps. If the
> flow-control of the fixed link is not enabled, we can easily observe
> the iperf performance of TCP packets is very low. Because the inbound
> rate on the CPU port is greater than the outbound rate on the user port,
> the switch is prone to congestion, leading to the loss of some TCP
> packets and requiring multiple retransmissions.
> 
> [...]

Here is the summary with links:
  - [v3,net] net: phylink: add missing supported link modes for the fixed-link
    https://git.kernel.org/netdev/net/c/e31a11be41cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



