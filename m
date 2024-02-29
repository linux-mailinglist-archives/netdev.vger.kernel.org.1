Return-Path: <netdev+bounces-76009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF9186BF9C
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14817B23047
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 03:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E76A38382;
	Thu, 29 Feb 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QamPge5i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441B1381C4;
	Thu, 29 Feb 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178630; cv=none; b=ZiQHWqy8SsFcwqfalsEnAP/syg3GlNQhYgKMAiYCRmVn+Kcm5yNngQaoQiJI6Od+yDNOpB16x588ydLY+c21hsGyXqXthHgRpsL9KgxQA5UhiEwtDCRO3v2fzcZQaGTgf/1NefscFUgbq2MAc3ytNRjvkR4wSu+CV7pTDjIQ63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178630; c=relaxed/simple;
	bh=R/XDDaT0XYN7kI/ia3r+9CTqTTCsu37PME2E9ytVONE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IuphHEJKe2jWFbTABKr+gqBvRlEDI94NrtOAq4DgTDv5Ov5vQPkW8KAZEPJcXdkeE//NNSZKI+frkWveW+9EaZDMKlIjvHyqBRaVO9WyOUte3Hrw6qpS9Jg6E6X9H3MCCfM2RwbT/QJMJeupCGBsyWLAxb/xeEMjGoXa98GQPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QamPge5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE583C43601;
	Thu, 29 Feb 2024 03:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709178629;
	bh=R/XDDaT0XYN7kI/ia3r+9CTqTTCsu37PME2E9ytVONE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QamPge5iX9N/ajLoY+PL83Wm+M/X0GvpAxNIe8Zj5x8Z0hhPS1yC9yIZ86GHc1jJl
	 MyeHAefVf1nWZcTOAZ0aVbwG2hdmy/Zm221xe0Qwm+tUZZxIJ+KjDGaXMp57PwhzL9
	 bWNzwwoG+0Z/6+N7fGKuE+gG+YdreDrCtcdt5mLc5AadbbDdTzvTMiXUU45nq8cVu7
	 7BBc1Rwol7yhzGzUiZZPo4vp0+yZrXwZfL+7EibxMbkaxGTpXlZ6xp4AGF+ESOf5eA
	 Ys0xW8RR2uvDTaKLcZl0m8cbK7V3NFszcJmczdVhinO+dvShjla8ZWI3aD38XrLRhM
	 RtvgWkySW0uAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2C00D84BBA;
	Thu, 29 Feb 2024 03:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: dp83826: disable WOL at init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170917862966.28712.14517758466659690303.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 03:50:29 +0000
References: <20240226162339.696461-1-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20240226162339.696461-1-catalin.popescu@leica-geosystems.com>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Feb 2024 17:23:39 +0100 you wrote:
> Commit d1d77120bc28 ("net: phy: dp83826: support TX data voltage tuning")
> introduced a regression in that WOL is not disabled by default for DP83826.
> WOL should normally be enabled through ethtool.
> 
> Fixes: d1d77120bc28 ("net: phy: dp83826: support TX data voltage tuning")
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: dp83826: disable WOL at init
    https://git.kernel.org/netdev/net-next/c/e83ddcea6549

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



