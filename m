Return-Path: <netdev+bounces-193581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7106AC499A
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 09:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400D57A80A1
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 07:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C7D1FCCF8;
	Tue, 27 May 2025 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE9LR/+N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB704188006;
	Tue, 27 May 2025 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748332194; cv=none; b=rXd2arKZPRuh1ihS2DJqyGnpM/s9MhOMJ29yp6rM1rRhKiicCmm8F9RIFCUkuGFpfbvx7TkT+B0qBw778Eh4t5OACPng0zdHuGaY3Fp5nE16n73+LhjjksYZezOSjNOc9vrPj/33h9gTOVdfjaocQ99TQsARfsxp24gZpVyeiY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748332194; c=relaxed/simple;
	bh=xkp/jXM98jjNLV620o/xBB0Pl/QLonfXdyCBdc3sttg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SfpwvUar1UZMCpQ6XpdBFMVo8Lah0ESzayvkKYettzgDCoVsaaYgaWlqJSshgOCjWsQm+37RHB2Y/wUjsP/cKmE3eu4cBYqv9tucqrLt2UVKcS7t8jHCYrohvZ3h8b1pXubvxgVxH7uSz4eZVCLaToJM/Ced0QJMkQ7I60z3FDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE9LR/+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6684EC4CEE9;
	Tue, 27 May 2025 07:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748332193;
	bh=xkp/jXM98jjNLV620o/xBB0Pl/QLonfXdyCBdc3sttg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YE9LR/+NN76JNg+hLNwVMa+U8pLQRAqN+i9emqnOeZIC4NJx0A8Giwi1yOUnzxkHp
	 SG3QPzUb4NmCwnReZ4BUsQG5LE0tk/hADiuNiFWj+qZ6vIlmG/9CE/CvIuErfTi8uy
	 Ts89EdqmTvhXEa72b3ry1P+1LXfgEuuaR1GjFMttv0mPCGP1/dt209M9N+u6c/qfB+
	 NQgtwr9NKcA9s3wTUcKbK2PZhAmXZGc1Wna/UJGKDyQDeY3+GZiAC7dSu/2odasJuY
	 11nZtta2hTG1sR0qV3avkxkc00RCrP7vywtUlaVlJGs4UP+SOMpUIJ7qd8HSdMcrtt
	 vvcdAwJJK3IYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD76380AAE2;
	Tue, 27 May 2025 07:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6] net: phy: add driver for MaxLinear MxL86110 PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174833222775.1200122.10594083499311236690.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 07:50:27 +0000
References: <20250521212821.593057-1-stefano.radaelli21@gmail.com>
In-Reply-To: <20250521212821.593057-1-stefano.radaelli21@gmail.com>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lxu@maxlinear.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 23:28:15 +0200 you wrote:
> From: Stefano Radaelli <stefano.radaelli21@gmail.com>
> 
> Add support for the MaxLinear MxL86110 Gigabit Ethernet PHY, a low-power,
> cost-optimized transceiver supporting 10/100/1000 Mbps over twisted-pair
> copper, compliant with IEEE 802.3.
> 
> The driver implements basic features such as:
> - Device initialization
> - RGMII interface timing configuration
> - Wake-on-LAN support
> - LED initialization and control via /sys/class/leds
> 
> [...]

Here is the summary with links:
  - [net-next,v6] net: phy: add driver for MaxLinear MxL86110 PHY
    https://git.kernel.org/netdev/net-next/c/b2908a989c59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



