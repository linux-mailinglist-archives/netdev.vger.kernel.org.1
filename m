Return-Path: <netdev+bounces-199290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5444BADFACE
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 03:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0189E17D42E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 01:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE431A3166;
	Thu, 19 Jun 2025 01:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlvUFta1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A31A1A23B0
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750297180; cv=none; b=VdtF25nzU55AAS9Gk9/zN4SEVuUBUiHOQxlejMxlPIbZXm1ouqDW2vh2BngUOcK2Fb68pwka/gShhArYfLEhywUhs6nhkgedOMD2cjukrxisRXJ/zvutJnGhdolokSAz29pq4JJM0LowG6fDs5XBaowbG50XkUp0r9xX2EIrUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750297180; c=relaxed/simple;
	bh=ch07Ws9nljttuYK0V+4rlwe5olAyan5Px11gn8XjKlc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BRe6fER1cNpFxvbtfvrVN2YyIdzms+cT4m7EIVJA/YNysYbBTWtbjhtziWmLSa0se34KIfrdOT8cvlxuCuGb5X0zqrDfGjE+efbqwPyu88HrrrWjeVZcKxCnsmvrjYUCzJ8X6XyDiUzAiUSGtfNddjNGoqj6Aou2sFEtxmMadb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlvUFta1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B47CC4CEF2;
	Thu, 19 Jun 2025 01:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750297179;
	bh=ch07Ws9nljttuYK0V+4rlwe5olAyan5Px11gn8XjKlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IlvUFta1IkG0PT+uH/g/R7uaki2q0wi89tqZ/ZXGQE7sNswm2J0Z6iLg3KYe0zaqx
	 FsYN8PgjnSR9lXcgeIVGNv4JweWPnka/hc2/iNgtz4zr9aW2coC37IU0X+13msTGeB
	 FBwKCl3t4WZNS8ZcmtIdulo9iBY3tTwDsMYDonWahengtU1qGuI26WyvEo3Z6Zugcd
	 UtgY6MBng5slTm/iR9jCVp9vVadOnQRnM1GypMWlUQIPtX2mJGOWCnZENicHLAG0Gd
	 /wWPH3K6vNlK5+j6Gwcsk35kFLvy99mA7w8UVzsQiialvAoeYC/PC7zsxypHZUPLkl
	 1wTDK/q5+gsmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF443806649;
	Thu, 19 Jun 2025 01:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dpaa_eth: don't use fixed_phy_change_carrier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175029720774.316257.17005885367881566209.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 01:40:07 +0000
References: <7eb189b3-d5fd-4be6-8517-a66671a4e4e3@gmail.com>
In-Reply-To: <7eb189b3-d5fd-4be6-8517-a66671a4e4e3@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 madalin.bucur@nxp.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 joakim.tjernlund@infinera.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 23:24:05 +0200 you wrote:
> This effectively reverts 6e8b0ff1ba4c ("dpaa_eth: Add change_carrier()
> for Fixed PHYs"). Usage of fixed_phy_change_carrier() requires that
> fixed_phy_register() has been called before, directly or indirectly.
> And that's not the case in this driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] dpaa_eth: don't use fixed_phy_change_carrier
    https://git.kernel.org/netdev/net-next/c/d8155c1df5c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



