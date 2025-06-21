Return-Path: <netdev+bounces-199983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34059AE29C7
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFDF175D53
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ED0216E23;
	Sat, 21 Jun 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6LSQLbP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9882036FF;
	Sat, 21 Jun 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750519180; cv=none; b=sxqYMGi9XUvPMKxweWYg96osdau9XgkFSNTZ+gDdPiqf0VGWvVYrQavAQXJlLBI6XRbhC1mY5fP+nLtep/s+GJE0JVePh0xGQQSN2aLgVU39FH83QeytvuKezrRNBeEPd6R77MiEjAMH+qtImBKdHsviP867dSUId4V64HclnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750519180; c=relaxed/simple;
	bh=NUoh38uATli7F617RTVUNNksneLgpeAkF5iLzKe0WLQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sOGfG+yjexD3LVxgrZAadW+u0/cqjNBZg+g5JyDcVL4L6V9Z1mnLy5bDHufn85DD5VkwEmRNuxE5FChkS1bXK5NQXkkHY7NyiJbEkzF+tnbYEdSG18Nq8zv3lo3Rd8hOPSawvlS6QKQRqnAJ/D5ThjvL4Vs0PT0A/lRgQGCwLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6LSQLbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D858C4CEE7;
	Sat, 21 Jun 2025 15:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750519180;
	bh=NUoh38uATli7F617RTVUNNksneLgpeAkF5iLzKe0WLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L6LSQLbPgouhy9Udih3S6ASuObVfTCO7gVrSRIL8wtk1yFzf+A/7qhQP4JuzTkIHm
	 HG9LSKNBzPmqgtiywqYzkiojcTI8MLV8Gbfy4ZL8JWslyNfMyahjLm/rv1gydhsvHN
	 DNxdG2A+grdBkWeiAw8rA6m45fct95PRHo6yyToLPKNuu7WZxf/dlh9cOrTo+ymPLy
	 jRaQs+wcxxOmBlDaJWGL3eNMB6wQd+b26ZzVSIO4xvu1nlAhUbycMJMpZ6HyXfBK8h
	 Lgx6lw3K11p+08GxP7jrUKsvPxFLfrhep6+zNque0gzPgYwXu+WxHsAyDKFIvIgTY0
	 YSw53WilY+QmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB06638111DD;
	Sat, 21 Jun 2025 15:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: pse-pd: Fix ethnl_pse_send_ntf() stub
 parameter
 type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175051920775.1881425.6913266452611460719.git-patchwork-notify@kernel.org>
Date: Sat, 21 Jun 2025 15:20:07 +0000
References: <20250620091641.2098028-1-kory.maincent@bootlin.com>
In-Reply-To: <20250620091641.2098028-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 o.rempel@pengutronix.de, lkp@intel.com, thomas.petazzoni@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Jun 2025 11:16:41 +0200 you wrote:
> The ethnl_pse_send_ntf() stub function has incorrect parameter type when
> CONFIG_ETHTOOL_NETLINK is disabled. The function should take a net_device
> pointer instead of phy_device pointer to match the actual implementation.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506200355.TqFiYUbN-lkp@intel.com/
> Fixes: fc0e6db30941 ("net: pse-pd: Add support for reporting events")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: pse-pd: Fix ethnl_pse_send_ntf() stub parameter type
    https://git.kernel.org/netdev/net-next/c/99aa0bbb082e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



