Return-Path: <netdev+bounces-215128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD0B2D262
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA1616FC8E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5977978F34;
	Wed, 20 Aug 2025 03:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+llDdLT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E796258ECA;
	Wed, 20 Aug 2025 03:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659472; cv=none; b=bB8Oah8V9lcrKOV0QQzZrrKV0NWQRKdFQ+5UA0EcLR81BXqXHw62TVDteLA33IQl/2+TKYCo5/SBFR8GhVJsgdfjzSqoV4IO29rRPW1posuPNFBeueyKeL9HtN2T5wqTpZx8gLZ+kn6JmPJlChV8OuAYYWauJJnL7JPqpHikP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659472; c=relaxed/simple;
	bh=ZXbPzsCnoV3pHvqoEjc/j9TNS55RZJmIdMgu3AvFEfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZVaTE5ZtXqvBvFneBX4f4ItVS/Wf38tS7dnSuEfmymx+RBCSaU0IZgUUJRNAg086cijuVjr35EU7q4xfwzj5DFjd9XCgFclv8aH68LWB/6PU3o5K61mrtCMFcAkoRGHEofyl4xjMfYoDiBFRvXMXzL+B5U5ny6ayDL46EjJd8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+llDdLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E92C19422;
	Wed, 20 Aug 2025 03:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755659472;
	bh=ZXbPzsCnoV3pHvqoEjc/j9TNS55RZJmIdMgu3AvFEfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T+llDdLTalm6xW3vNxZn89HySecQN9uqltlHWd6JksI70/9MMl2QfV4jH0AdEOPGg
	 IopXey1TNXZpasHaW3hpojbcwIo4CRZPwgy5UDOEQVFDvCogU+zdBavQuXC1hdbfdW
	 zcBUnwK2tfSu+45NMGPKKVtR0EIZ/zhqlvMtbBBsy22FpFXav+PqphAIYC2Esfb5yo
	 lS/lWAjnt34rK3MnEhAdr7UM22wb5S0huZiqpS9EayY1obRbJn1LY/+oDD8HFZYCbz
	 DAWdZUEc6T42tlgfbxir39pytghmjjlfZDkokSU3sMIV6QOtBO+D8dyjroeZwkGIcH
	 XKVOaaaddN5pQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4B383BF58;
	Wed, 20 Aug 2025 03:11:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] phy: mscc: Fix timestamping for vsc8584
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565948149.3753798.2163989907121852444.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 03:11:21 +0000
References: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
In-Reply-To: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, rmk+kernel@armlinux.org.uk,
 vladimir.oltean@nxp.com, rosenp@gmail.com, christophe.jaillet@wanadoo.fr,
 viro@zeniv.linux.org.uk, quentin.schulz@bootlin.com, atenart@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Aug 2025 10:10:29 +0200 you wrote:
> There was a problem when we received frames and the frames were
> timestamped. The driver is configured to store the nanosecond part of
> the timestmap in the ptp reserved bits and it would take the second part
> by reading the LTC. The problem is that when reading the LTC we are in
> atomic context and to read the second part will go over mdio bus which
> might sleep, so we get an error.
> The fix consists in actually put all the frames in a queue and start the
> aux work and in that work to read the LTC and then calculate the full
> received time.
> 
> [...]

Here is the summary with links:
  - [net,v4] phy: mscc: Fix timestamping for vsc8584
    https://git.kernel.org/netdev/net/c/bc1a59cff9f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



