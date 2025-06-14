Return-Path: <netdev+bounces-197697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B49BAD9976
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 03:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84ACF189F5FD
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B5684D13;
	Sat, 14 Jun 2025 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OutCLZFA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9D17E792
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749864620; cv=none; b=pIql2f8p0/UJFgiE6bo5EAXupNygUTYzYVBPXFVkK3Rv5P3e/xmHVAVEHNCgY7fiEpUC5WQHUkrITe7hbJrV0ktMEbfhENQRd6LJtc/USgv58mVm2UA+V4OZGDEkYYXX5v8w1j0bMnsNxpDilJWI8+8IsVpjVRde7VQyr89Sw7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749864620; c=relaxed/simple;
	bh=RUubw4X8nuXzSGrx3hliAXeBFn3vuufywq3+oM5AWCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s/iRgRgT4YT1SnokhfTt8sFPHNJF0Uc5R+/aFsGylxT0g2KcCUBTRxcIRnZj3S1oB6qzLq0uQR4XK5bXvFns0xXU+ghzs8jvUYxDAlEkt3owvK61LcXrOg0pA9fQNGP50ibXZryAbQG7jkWFpiaMd9D4acPrqwZNhztZxcT2F9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OutCLZFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C711C4CEF1;
	Sat, 14 Jun 2025 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749864620;
	bh=RUubw4X8nuXzSGrx3hliAXeBFn3vuufywq3+oM5AWCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OutCLZFAL3EGCv2zpvVeyWm1gdKjTWkLytHfFlyFWpYZwaORQjvkhKsqs3QP1u93N
	 f7V1ALb9btnAq3WJvHTMKeEQ9qh8zGzDy7W09Ony+XEFj5qMCHJHdh5OQ+8AryEGzv
	 rwxnObgKd8UVxzdOoonVYakrXWlJNXRPCuj4KWDGnsa3e+PBIthIKsn9Tr8AujWDIr
	 XlhZIRzK1BhvsR/Np3f2cxj8LyESTJJ4ib3N4g11JmpekidiURyxjHuo1qx/ImUPZn
	 +J+pW0Ee1MU9etAvYl5lo7fK2qtvU6zbHDkG8rPMK6cv7SdFytWOrM52HxIqW8xB0j
	 OwJQgiwfejxbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACFF380AAD0;
	Sat, 14 Jun 2025 01:30:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: improve rgmii_clock() documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174986464949.950968.11468172383174661837.git-patchwork-notify@kernel.org>
Date: Sat, 14 Jun 2025 01:30:49 +0000
References: <E1uPjjk-0049pI-MD@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uPjjk-0049pI-MD@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Jun 2025 16:21:04 +0100 you wrote:
> Improve the rgmii_clock() documentation to indicate that it can also
> be used for MII, GMII and RMII modes as well as RGMII as the required
> clock rates are identical, but note that it won't error out for 1G
> speeds for MII and RMII.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: improve rgmii_clock() documentation
    https://git.kernel.org/netdev/net-next/c/91695b859263

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



