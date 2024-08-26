Return-Path: <netdev+bounces-121965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5951295F68E
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3B4B20BA4
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C0E1940BC;
	Mon, 26 Aug 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C27Fqemf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD118D64D;
	Mon, 26 Aug 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689829; cv=none; b=pNratOAyp3s54ZgrSvWcIb1lM2pgw707p/SkcxRFU1fdHho5hnH06loKe9gwydoOrlkm0SBiJo8s9z3nudrcMgO+2Dfzc+u6qrZwnz69KmO2G3s7iTEpQLtbj8gEHfqdAv48F+ojhst9lpGpjIIGkYfSNtYbvzlV5tgggOjLokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689829; c=relaxed/simple;
	bh=hMSS1NQUv3rq3iiHWer48wy6u0fy4DvevMs0Z/b+pfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=moJHaey9LEo/8RGD/YP12xR7EiYRFoeIVU0Pv3aq9V2TcNCmmE/wD8rTMxQl32wzpLDWUfkrStRtrQ1eDNaSC2PLfU9y2ki3527TUijk5CjVV/JgKD9d/pTR/vTlhrZe1yED2WVEKZWCSHKtbRLbaCRx6cWivZqNKSfU7r8h/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C27Fqemf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8356C52FC2;
	Mon, 26 Aug 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724689829;
	bh=hMSS1NQUv3rq3iiHWer48wy6u0fy4DvevMs0Z/b+pfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C27FqemfnduCR4Na2FYpzqJPe/yIFilRBEdWTYB8FS67V+LOR1vKMQfvA02KwnjOV
	 43tSKhXUT5DqQAvl9PH6h34VrRMiynJivtaip0CTOeZLlinj9zj6pr+TE/VCQ3oxIg
	 Mamqjaewrc0wejfkCyPY6FL+INXoXxtZf53HkrHfFAwTHycbSSLmd5oOEGKNRxX8mg
	 UUrnxQXdfj7UGyMb53XTVjtBq4AWTWglChAgwLafdyVPFvtbxM7uugwe0cIPxoQxph
	 LM7BUHg+e0WnwnSbc+al0QzwcbUmar1wseCRwHDXZpO/9zNJm8BvOlUHIc86XIBfme
	 ab8qbrHH0i//Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B593822D6D;
	Mon, 26 Aug 2024 16:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] Adds support for lan887x phy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172468982901.61541.17418473303281858587.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 16:30:29 +0000
References: <20240821055906.27717-1-Divya.Koppera@microchip.com>
In-Reply-To: <20240821055906.27717-1-Divya.Koppera@microchip.com>
To: Divya Koppera <Divya.Koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Aug 2024 11:29:04 +0530 you wrote:
> From: Divya Koppera <divya.koppera@microchip.com>
> 
> Adds support for lan887x phy and accept autoneg configuration in
> phy driver only when feature is enabled in supported list.
> 
> v2 -> v3
> https://lore.kernel.org/lkml/20240813181515.863208-1-divya.koppera@microchip.com
> Removed extra braces for linkmode_test_bit in phy library.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: phy: Add phy library support to check supported list when autoneg is enabled
    https://git.kernel.org/netdev/net-next/c/d4c897675a5a
  - [net-next,v3,2/2] net: phy: microchip_t1: Adds support for lan887x phy
    https://git.kernel.org/netdev/net-next/c/0941c8328234

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



