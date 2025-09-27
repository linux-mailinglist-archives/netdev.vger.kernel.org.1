Return-Path: <netdev+bounces-226830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D6BBA5794
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 03:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3801616E643
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40911EF09B;
	Sat, 27 Sep 2025 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8i+GMPz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941FE1EB5F8;
	Sat, 27 Sep 2025 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935424; cv=none; b=SH84lyDVte2z45kXCBqfXBzt9np0MW+BNuir/9vWpHLtm05ecDG/DwleNtEM6NNhcL0JziXxrE2+71kW35phTZUGxzcgLN5CfMC7avT6iHm0OUmnf6ShPwIIUnwkzFazYHxhLnFg1cr8tLm9ECBwTkksWEoIApgZzCydb1RzZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935424; c=relaxed/simple;
	bh=GUwVFfySz5WyrOJ7pHhh26Vly+OiYPT6API8uH/GhC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XrhPqqSLwdfy7s//ejbS8pRnn4Kp57YBG2XUQyG7bewZAlrODdGBtkHtoOOnpACX2ZzqQuEiqx+F/h4x1brH3DKgpENMeX2Y2mT8nxHsdRF/SApb8bR9QRAQUPrkPlQHTGBoFMqDE6lqce9cM0eLSD1nR7X3H58UVNnywMQQVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8i+GMPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A5DC4CEF4;
	Sat, 27 Sep 2025 01:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758935424;
	bh=GUwVFfySz5WyrOJ7pHhh26Vly+OiYPT6API8uH/GhC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t8i+GMPz/VpE1+mOX6kNJAylMJKHheDJtqCTXVq+77PWYdhYTSal8P7FiQj7alxbq
	 nzCTm+7IW34smPW1beJepitw1jTtI03717npd1VOq+mMw7TJTP9oIv59qBsh7p+4Yo
	 /WFyrddh2pka1OzwhPPZB8EjxVftPjZTiw/LMQid459Oyx8LyDtwIsuK2kpvZeiuqp
	 BOic+iQihQBpJ0an6AlX2Pg9mLQAix9IF8Bmi6UB/uJnqA4ninqQ9RzFsyNPf5d861
	 zSWlnsUm5PnW+ACbyht187m5Ln8vVR+WK1is/MF0HpXT3s/KiPWrgehmtnb91E9sNa
	 qOU/79tCIfn0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EC239D0C3F;
	Sat, 27 Sep 2025 01:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: micrel: Fix lan8814_config_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175893541925.113130.170871174102747689.git-patchwork-notify@kernel.org>
Date: Sat, 27 Sep 2025 01:10:19 +0000
References: <20250925064702.3906950-1-horatiu.vultur@microchip.com>
In-Reply-To: <20250925064702.3906950-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 08:47:02 +0200 you wrote:
> The blamed commit introduced the function lanphy_modify_page_reg which
> as name suggests it, it modifies the registers. In the same commit we
> have started to use this function inside the drivers. The problem is
> that in the function lan8814_config_init we passed the wrong page number
> when disabling the aneg towards host side. We passed extended page number
> 4(LAN8814_PAGE_COMMON_REGS) instead of extended page
> 5(LAN8814_PAGE_PORT_REGS)
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: micrel: Fix lan8814_config_init
    https://git.kernel.org/netdev/net-next/c/bf91f4bc9c1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



