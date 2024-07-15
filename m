Return-Path: <netdev+bounces-111412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FAE930D54
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 06:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7EC1C209DC
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 04:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6141836EF;
	Mon, 15 Jul 2024 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXTbyfUg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8DF1836E5;
	Mon, 15 Jul 2024 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721018433; cv=none; b=hzwPzVi7xk1Kwt07YhTL4GIQaqqQ/aZVYAkRpB4ajqaBfIPd90MF6sAOl8vPC5wPpj5Z7H0wVu3IjNIHK1BuONAkJGPlyOzVZxV+eNGSnE/YPuK7fb++rhUajC0o31UuixguhtRmO4AUhLZc/0Djg6gYla/laCmJAgXvnSiZwZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721018433; c=relaxed/simple;
	bh=dmcHE9ndX1XQrW6dt+HNV+1FYdKq3zZBQZjHINuynL8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f5zRbAQrvX2we7JGSMPcee68MJG989h689AZyovzh2fj9i7g+oe1qfyzJ/HPXKBAoinKTgXC0DaVBGU+XwTgjbeu0nXmNNUzF1fS+uDok1h68RyL/L0Ok7OBONkXLPdu05AaXoH1IiJ8GYwLvk2VMd7+A1dKkdQekQre6AU3D3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXTbyfUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D73EBC4AF10;
	Mon, 15 Jul 2024 04:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721018432;
	bh=dmcHE9ndX1XQrW6dt+HNV+1FYdKq3zZBQZjHINuynL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VXTbyfUgG4R8faRY7I2wOZZqEYVcAyWZ7ANXZ+xn4+nowoEfw2DQLLzjN8IzmDoq1
	 FP2PsduKzqOyybX84a6kdLvZ5mdfRxwX6vIPjRmz2RaJ5Yf+pnfgDNVbeTtGCm0c52
	 9YnbANeYnpBX9Aev2/A4a9BoQrmvSF6jNbRZ/wkZ/kdVxhK/BzgWXdOSRXFVar1+xB
	 R05g03qHn1WNLQS3lXrsIPl6zqkjlrEJUOEEVoDrAC7nc7t/ANUajwfT9+fq190fUI
	 7zdl5YnU4v4h1mNX0PYdu+h1lWXPD1x6sYkEOQeLiE4yaHytyJKwy7aCaob4EiJ0Zy
	 z5B5CFukaiBLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9E34C43612;
	Mon, 15 Jul 2024 04:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 0/4] net: phy: bcm5481x: add support for BroadR-Reach mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172101843281.2749.5906999097887026804.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 04:40:32 +0000
References: <20240712150709.3134474-1-kamilh@axis.com>
In-Reply-To: <20240712150709.3134474-1-kamilh@axis.com>
To: =?utf-8?b?S2FtaWwgSG9yw6FrICgyTikgPGthbWlsaEBheGlzLmNvbT4=?=@codeaurora.org
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 f.fainelli@gmail.com, kory.maincent@bootlin.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jul 2024 17:07:05 +0200 you wrote:
> PATCH 1 - Add the 10baseT1BRR_Full link mode
> 
> PATCH 2 - Add the definitions of LRE registers, necessary to use
>    BroadR-Reach modes on the BCM5481x PHY
> 
> PATCH 3 - Add brr-mode flag to switch between IEEE802.3 and BroadR-Reach
> 
> [...]

Here is the summary with links:
  - [v12,1/4] net: phy: bcm54811: New link mode for BroadR-Reach
    https://git.kernel.org/netdev/net-next/c/2c1583290b08
  - [v12,2/4] net: phy: bcm54811: Add LRE registers definitions
    https://git.kernel.org/netdev/net-next/c/ff253875ff3b
  - [v12,3/4] dt-bindings: ethernet-phy: add optional brr-mode flag
    https://git.kernel.org/netdev/net-next/c/775631d7845b
  - [v12,4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach link modes
    https://git.kernel.org/netdev/net-next/c/03ab6c244bb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



