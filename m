Return-Path: <netdev+bounces-201374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 621E0AE937D
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1EE57AE1E3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B872519F127;
	Thu, 26 Jun 2025 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE0ysjwc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB3419B5A7;
	Thu, 26 Jun 2025 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750898984; cv=none; b=nXO7MeecdpssUUOtrLj/+BX1VPD3LTc94D+PlIF44PS6WjRhK4lz//M/J2p7mTpETebUplUGAphHCl1u2KGVW1Auodq4rsrqIBKb+aZRit5BIYCGpWmACnlFs3myJGr2/avuhlxxcWzTOeds4i2P12/NVJYWw64Z09f6XBFwSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750898984; c=relaxed/simple;
	bh=zQ/WKh37K7fzz8JY/mNruuBN6IghQbDyCVIGhfVM5VM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I3VlFs7x0WjMAgviKD9T7dMrPsz9xWe0fdiew2JiItPxrGTKwidSbjxEzFacildCl2wP/6oYH4XAJesFjz01NsnSZS86oTLnt3zteFXNV+sbNSmaOuEOG9k1oYZF2Qctz9kY3WRtM6F8oyYUHKrorIY6OP19XpA+c3+IHnT/wqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE0ysjwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06479C4CEEA;
	Thu, 26 Jun 2025 00:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750898983;
	bh=zQ/WKh37K7fzz8JY/mNruuBN6IghQbDyCVIGhfVM5VM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BE0ysjwcFcmWuJagFBKM7OvRC2VNIBW0u2LJv5WksKXCbCEcAa0B43jwrG0HxE8Y4
	 NrNn1HttYOisMbIw5q2T2cMluxaPpAZoe7iEBKrXVWOrAWBKxLlKq9tKkr8AVSJE4K
	 KmMKOQMZprNrYxnt2teC3MxBTE7+y/ZtSDKHa4tyCytgyf/tC3lvwNJRMP+ISXZs+F
	 U/M7J8b8s0IDmy6NrzzRsp1Y5KpH4MWzfZDcptz/MeiqiuGW0U5locoDE5jSS4ArRk
	 yh6yGeJJxFzdOS7ZPP2RWAy+n8frRaBDrJGur4iqvetZGRuc+0zvabRbuRhnDiAdKc
	 Sdpa9/aCQunGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDCB3A40FCB;
	Thu, 26 Jun 2025 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: add error handling to
 rtl8211f_get_wol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089900924.676531.5814198063792212147.git-patchwork-notify@kernel.org>
Date: Thu, 26 Jun 2025 00:50:09 +0000
References: <20250624-realtek_fixes-v1-1-02a0b7c369bc@kuka.com>
In-Reply-To: <20250624-realtek_fixes-v1-1-02a0b7c369bc@kuka.com>
To: Daniel Braunwarth <daniel.braunwarth@kuka.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jonathanh@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Jun 2025 16:17:33 +0200 you wrote:
> From: Daniel Braunwarth <daniel.braunwarth@kuka.com>
> 
> We should check if the WOL settings was successfully read from the PHY.
> 
> In case this fails we cannot just use the error code and proceed.
> 
> Signed-off-by: Daniel Braunwarth <daniel.braunwarth@kuka.com>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/baaa083b-9a69-460f-ab35-2a7cb3246ffd@nvidia.com
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: realtek: add error handling to rtl8211f_get_wol
    https://git.kernel.org/netdev/net-next/c/a9b24b3583ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



