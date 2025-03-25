Return-Path: <netdev+bounces-177610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C026A70BD6
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2826D17552A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D8826656B;
	Tue, 25 Mar 2025 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRCmBxxd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F97266EE7;
	Tue, 25 Mar 2025 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742936407; cv=none; b=d+BGgigmE7RomnLgHymDUopkB/a8KFmzmALWTRovRKjhzKRly5EIvAbeoqRf5uRJfURSRV4DzRivjNvljl0l9n/fSsGLq3BlFyvtDHhzBhd1j8bZcW1iH1ejlRdO/MvjT+Wz/GPnNpk0+/AaOkvteFgYfN3wpwV5Fq+g51zzllA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742936407; c=relaxed/simple;
	bh=nwYZ4xRXWP8OrnzOAXnqcuHW/wuIip4+FcULbWZfzT8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hAxOZMRtW6nBDSK6r0BK2VtodzOLSQKigksP7vLYfh+Em/v6rGg9gMqFHhOFkp9EDElXTGacN0zYeOfgjDeGd/biUi+47V9+vEfdlcnaoaEj3XGsyQDFzPVHepAcHLaNIYkBlhnzsP2QLlZhGI1zaGcuLy1VBHDszvC2HObAfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRCmBxxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B038FC4CEE4;
	Tue, 25 Mar 2025 21:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742936406;
	bh=nwYZ4xRXWP8OrnzOAXnqcuHW/wuIip4+FcULbWZfzT8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mRCmBxxdhKCQyF38pU9hkKhxkwdjfPSAVLqhgY0H7NfLFxq4K2T2f4Y+smfLWMWnk
	 56ybXmQOYMZb3iR58B9FC+2hbLJbrooATPTL61OSTb1uZ+DeStHYSwxBRhTGXrYD4l
	 3Y1iEa6GD4ekVo5qIW1jXUyii5TdgnnRllqLq5dodwmeoCD9xPWe+ZTf4obULRoVgd
	 +idU4Vh0e7cZ2dbLnNxR81suvBbdhSd/df8k4PaZ3u3+PZ1XiO9ECyAAXwoP00pvBB
	 S7vJE6HG0PKa1QrYYTrB6YVvoHxpA6K4TjuG6iLwF3pUnh1uOgvAZgSpSQgwkwt0/N
	 wDsDow/gPdM/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3456B380DBFC;
	Tue, 25 Mar 2025 21:00:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/7] net: tn40xx: add support for AQR105 based
 cards
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174293644280.727243.6471962658538147478.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 21:00:42 +0000
References: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
In-Reply-To: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 fujita.tomonori@gmail.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Mar 2025 11:45:51 +0100 you wrote:
> This patch series adds support to the Tehuti tn40xx driver for TN9510 cards
> which combine a TN4010 MAC with an Aquantia AQR105.
> It is an update of the patch series "net: tn40xx: add support for AQR105
> based cards", addressing review comments and generally cleaning up the series.
> 
> The patch was tested on a Tehuti TN9510 card (1fc9:4025:1fc9:3015).
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/7] net: phy: Add swnode support to mdiobus_scan
    https://git.kernel.org/netdev/net-next/c/43564f062bfe
  - [net-next,v7,2/7] net: phy: aquantia: add probe function to aqr105 for firmware loading
    https://git.kernel.org/netdev/net-next/c/74e4264efe47
  - [net-next,v7,3/7] net: phy: aquantia: search for firmware-name in fwnode
    https://git.kernel.org/netdev/net-next/c/5f27092328ce
  - [net-next,v7,4/7] net: phy: aquantia: add essential functions to aqr105 driver
    https://git.kernel.org/netdev/net-next/c/e31e67f58cf2
  - [net-next,v7,5/7] net: tn40xx: create swnode for mdio and aqr105 phy and add to mdiobus
    https://git.kernel.org/netdev/net-next/c/25b6a6d29d40
  - [net-next,v7,6/7] net: tn40xx: prepare tn40xx driver to find phy of the TN9510 card
    https://git.kernel.org/netdev/net-next/c/07cfe3a55756
  - [net-next,v7,7/7] net: tn40xx: add pci-id of the aqr105-based Tehuti TN4010 cards
    https://git.kernel.org/netdev/net-next/c/53377b5c2952

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



