Return-Path: <netdev+bounces-152830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C35949F5DB7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 05:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F997A1440
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC1314A4C1;
	Wed, 18 Dec 2024 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwxEgtcM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FA8146D57;
	Wed, 18 Dec 2024 04:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734495015; cv=none; b=r0vntD7mOrE55KxZ0swvzQFdbAL5WTEUgPv02njenKFO9UJ4GuIahQqANqsT+1LCpq51yjZ7nUGhJ4kqlctqQH4D5fjxo87fDmWNtcU4uuL4ZRHAfvMh4pRlpEdmLmJp7OgOxS6M8AsOdYhj8UgAjhe1VSEhOrPq0iKG5H0MA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734495015; c=relaxed/simple;
	bh=KAl13n8HQ94z5cQMCjy1pw/iGkTBRO8nMbyS+lZU+AE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bOLceUcI0x7EOpAbzN2LtGwmOcxtng9BuZcZdBdQm65sOQqn2nu8r4cZR2gZOvWB5ReZhOgkcwIfQ0mvgOwf8mr9IITFs6QQeaIzCHSeOmgwIX41LKraHUsP/RFeI5gf1Byp2hgePiU5RAzD/7ASRqsv+NrV6jMj2gUYI/2jghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwxEgtcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D75EC4CECE;
	Wed, 18 Dec 2024 04:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734495015;
	bh=KAl13n8HQ94z5cQMCjy1pw/iGkTBRO8nMbyS+lZU+AE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dwxEgtcMpEbgVAqlSO5vXkohnG9onYKPmYeMbvimpbFoLveej87G0sj7gPxnmQYyi
	 eX7obxQp95IQPBxQpvxoGTxZnq0ZtuCsBy6TL2Oad5Tjfsgu7an4hiKjXSXjWQo4Eo
	 g81GuARzkZjReDfmgcDEZS3U4ml5Eb2RR1iEs4Hif4jsf19wqtoVekYIsQ5Tm+uL+3
	 Coggl9gQjy1cUzYoYopodrSPp9dnqV/WlOmeZVZIlBMrpmLSoIhcHcM1StNCycbiLl
	 LJFPFSONGvx5iO+gWh7hYm+U6u4Mhxlut5qDlHbHEBBtwDm6d/SZRuoR+nxf4xV1ru
	 1fhfGDGJaSk/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECEFF3806657;
	Wed, 18 Dec 2024 04:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/6] lan78xx: Preparations for PHYlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173449503275.1173615.15384763618371407824.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 04:10:32 +0000
References: <20241216120941.1690908-1-o.rempel@pengutronix.de>
In-Reply-To: <20241216120941.1690908-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, andrew+netdev@lunn.ch,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, phil@raspberrypi.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 13:09:35 +0100 you wrote:
> This patch set is a third part of the preparatory work for migrating
> the lan78xx USB Ethernet driver to the PHYlink framework. During
> extensive testing, I observed that resetting the USB adapter can lead to
> various read/write errors. While the errors themselves are acceptable,
> they generate excessive log messages, resulting in significant log spam.
> This set improves error handling to reduce logging noise by addressing
> errors directly and returning early when necessary.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/6] net: usb: lan78xx: Add error handling to lan78xx_get_regs
    https://git.kernel.org/netdev/net-next/c/30c63abaee90
  - [net-next,v1,2/6] net: usb: lan78xx: Use ETIMEDOUT instead of ETIME in lan78xx_stop_hw
    https://git.kernel.org/netdev/net-next/c/18bdefe62439
  - [net-next,v1,3/6] net: usb: lan78xx: Use action-specific label in lan78xx_mac_reset
    https://git.kernel.org/netdev/net-next/c/7433d022b915
  - [net-next,v1,4/6] net: usb: lan78xx: rename phy_mutex to mdiobus_mutex
    https://git.kernel.org/netdev/net-next/c/3a59437ed907
  - [net-next,v1,5/6] net: usb: lan78xx: remove PHY register access from ethtool get_regs
    https://git.kernel.org/netdev/net-next/c/d09de7ebd4ab
  - [net-next,v1,6/6] net: usb: lan78xx: Improve error handling in WoL operations
    https://git.kernel.org/netdev/net-next/c/01e2f4d55bda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



