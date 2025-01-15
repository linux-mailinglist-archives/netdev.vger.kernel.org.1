Return-Path: <netdev+bounces-158650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F494A12DB5
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A84616644E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F601DC070;
	Wed, 15 Jan 2025 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhU99fOh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5621DC07D
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976622; cv=none; b=EvMM2lwEF3pgYGJO1DYz0RTM0cMARE16b2gQdO9UoVGYc8a4WxhPpWw+hQ6lKdjdDNr3XCrxo9pv+ugWJcEZSuwdtcwJwuR/XcLpvCpYFP/OMqDv709CEBA398uYaDJzXj1rJJwXJDfhuO2e7qCPCXFmqLYbM3EXgaRwFTss6Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976622; c=relaxed/simple;
	bh=SWZgTtfnHFkUgSXbcTUa40e+iKkScS9pCu+BgpGGjr8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MOo+oVnkmkTldEcjBwJje6ZzgZF6n2nFWVVhQBCfcBuAF5nAB13dPmDTHl8M7+lYi4424VC0y+E8yWWaq4YQ+chQq2dbuH0NKFYAhze2VITiRa0jreExGGq6uxkRdnAuxbMTtmwP8YQwkOmF+x8AwlHWbhELipgqdvRZyOJ/1iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhU99fOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DD5C4CED1;
	Wed, 15 Jan 2025 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736976622;
	bh=SWZgTtfnHFkUgSXbcTUa40e+iKkScS9pCu+BgpGGjr8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DhU99fOhOM89UNJTj2QjKCKvOnPmcc1A1Co/9ElFMbtw4PMuxB9vq9qbVHXwySavY
	 v+gD58V9O34JUeS8iKKh6cpfhMulUIg1FmPbKxb7ympwYlSgBMwiAChP1UOfyTWBdH
	 XctBD5CqussKOZMbsAqmtQ6kRuTMX384bC4LS6Yc9p8d2hmVceskahjzylBbe6R5oM
	 SF3eKTblOmHD/avfSdYgsmk1k38u0bzHK9LcSc7tH47gFZ5jAXtM8dXvs90ELdFV95
	 Y7Y+tpHwYq8ll3Gp3tjPUGUXaFccUzPZDbbfyZ4QHQJ2oTDDzu09QNvEwTr1BBmUdI
	 daks4KBGhHLlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B42380AA5F;
	Wed, 15 Jan 2025 21:30:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: bcm: asp2: fix fallout from phylib EEE
 changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173697664478.885620.15826412311433862044.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 21:30:44 +0000
References: <Z4aV3RmSZJ1WS3oR@shell.armlinux.org.uk>
In-Reply-To: <Z4aV3RmSZJ1WS3oR@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, florian.fainelli@broadcom.com, kuba@kernel.org,
 justin.chen@broadcom.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jan 2025 16:50:37 +0000 you wrote:
> Hi,
> 
> This series addresses the fallout from the phylib changes in the
> Broadcom ASP2 driver.
> 
> The first patch uses phylib's copy of the LPI timer setting, which
> means the driver no longer has to track this. It will be set in
> hardware each time the adjust_link function is called when the link
> is up, and will be read at initialisation time to set the current
> value.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: bcm: asp2: fix LPI timer handling
    https://git.kernel.org/netdev/net-next/c/54033f551219
  - [net-next,2/3] net: bcm: asp2: remove tx_lpi_enabled
    https://git.kernel.org/netdev/net-next/c/df8017e8a19d
  - [net-next,3/3] net: bcm: asp2: convert to phylib managed EEE
    https://git.kernel.org/netdev/net-next/c/21f56ad1b211

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



