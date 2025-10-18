Return-Path: <netdev+bounces-230631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A46BEC115
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A52974FAACE
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3942A1CF;
	Sat, 18 Oct 2025 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWCSq/ig"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559EF30BF68;
	Sat, 18 Oct 2025 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745634; cv=none; b=EjVr7CaMLY//UEEMVtuNLII5iKhAZCdaYP11Nq2+CWn8lXbG7u2dPHvyafLqpjSyBFFxQw01tfLGMS3b8YqO8eny+F4iTRG/tJzXOTE/NecvVQzYPMGZHNO3t6LnoV9wmqKGHIhABm4ITsEew8C+hWFmoce8vgsN7vrn2O6Oq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745634; c=relaxed/simple;
	bh=SX2waLHCJsjUlJYLVqz+0/2jdzLvDmSy0u8o++hWC6Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cWvMiHltyY2J6LvAqfbO344FxnnX4d/f+hDaoFG1tRuBGuKAlJvhBsgWN1XTas3nE/OQOfKe5RTYoMh3+A4iwevDHK+E00ZdWZ9sg2Kn2+SChB3CjbkvtO2SrXt5oJQIWncAVKEpMdN0ThVdytByQde5ObsYOlGk+nYxkeJlNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWCSq/ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34797C4CEF9;
	Sat, 18 Oct 2025 00:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760745634;
	bh=SX2waLHCJsjUlJYLVqz+0/2jdzLvDmSy0u8o++hWC6Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uWCSq/ig9odTOtUoM0V4ftPfeqkPoQqxCSWNv0/SGgnIlAPrEAImH0iWMDHI7GxHw
	 Vzwh+IsEw+sLaRTZVF1iJ8Y10EfzXTWiF3gLV3JKx9rQooI33DLIP15+MS8UeqjXTq
	 b1nfW2eaOBpH54Q9D/aMvG1Kqqm+MEAJG5UOESEp5qw6U88DZ6MPFIX+9VZQ9bt2AL
	 pkVDattXs5cukAvwzxWHKRj1sxf6Y1CxUsUMWFImSQJxIpDkcTDRUlV3HJ6feQCJ8W
	 mviIL2Nx+AOZAGU4M2ZLeWCmIwM09FCZXpIOyG2uV+g8W2s/g5i3WLtXyy9rXHNlrX
	 Vi1/A49MJsyPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB10D39EFA61;
	Sat, 18 Oct 2025 00:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: realtek: fix rtl8221b-vm-cg name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176074561750.2830883.15942603292071819937.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 00:00:17 +0000
References: <20251016192325.2306757-1-olek2@wp.pl>
In-Reply-To: <20251016192325.2306757-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michael@fossekall.de, daniel@makrotopia.org, rmk+kernel@armlinux.org.uk,
 kabel@kernel.org, ericwouds@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 21:22:52 +0200 you wrote:
> When splitting the RTL8221B-VM-CG into C22 and C45 variants, the name was
> accidentally changed to RTL8221B-VN-CG. This patch brings back the previous
> part number.
> 
> Fixes: ad5ce743a6b0 ("net: phy: realtek: Add driver instances for rtl8221b via Clause 45")
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> 
> [...]

Here is the summary with links:
  - [net] net: phy: realtek: fix rtl8221b-vm-cg name
    https://git.kernel.org/netdev/net/c/ffff5c8fc2af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



