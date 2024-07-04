Return-Path: <netdev+bounces-109195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A129274D5
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D63E1F21D2F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CA41AC427;
	Thu,  4 Jul 2024 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX9eWGI2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293521AC421;
	Thu,  4 Jul 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092030; cv=none; b=uES8vxXgNMHLRTK6tDGsfN1eDzMFslsw7AQyiFlquJyNQyxwHiFbIJlvUNbfuGBDknSVbdGIJdNihxGRisqOxI6n3zm3U/yU9E2eNMU8dl3BihKArURg2BM+kl4fwwbvPOYYZicCSmQE3w4TF7jCMNyA1sB1szdvYsPAa8Zs62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092030; c=relaxed/simple;
	bh=EhCoaFwEkiegtcqe+W0O4xpQtuOVXuQDkSN57k8gW/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UB5W6lgDrp5SSJBfL1Zd+hnBv+HzMHIqOGiSFA+qJ6Br0Cx0u9kWfs+SJl8d8MoX2MgO50RCW2Gcp99ccvxc+RN9illZVNvtl8J5FIBm3DqEe5z87UPoxCrDAbj8l/qD5SlUW1PrRYAq6qbXCCIDhEV/HXxZ+XiEIJp2NBzdXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX9eWGI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CBF9C4AF0E;
	Thu,  4 Jul 2024 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720092029;
	bh=EhCoaFwEkiegtcqe+W0O4xpQtuOVXuQDkSN57k8gW/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EX9eWGI2ulFz2AsYgzbHDJ+5G/mOxy8RsAvmxTZXq6MvcANXbg7tyKkoEQB37e0Gy
	 MxeutuOZIxLuDdg64Ltrdt7DT2uAMRwtfUo9TXZi+DkXYkDYetoFGVM4ndbtid/ADv
	 7HplmlqHyFy7Fwe+wVh2MhGvuGux5hq2tqWiAGs2s9jxfo0IyjhkvBoGCN61+6kjwK
	 fSWJV/WqLYXtrQHLMTeWBw8920lwi1ECu6LT6W30i/zIJzHM0iQGNYvujYfYA6Av9H
	 Tbu4Aj8AAFIk5bHdSbDYCym4DKGVsyLgPU1en2DuTmcSZhg7bNXaxRGKh2nvI0pT9C
	 YgCJcHq7MADpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A00EC43331;
	Thu,  4 Jul 2024 11:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: dsa: microchip: lan937x: Add error
 handling in lan937x_setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172009202956.20152.9731254807352198496.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 11:20:29 +0000
References: <20240703083820.3152100-1-o.rempel@pengutronix.de>
In-Reply-To: <20240703083820.3152100-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  3 Jul 2024 10:38:20 +0200 you wrote:
> Introduce error handling for lan937x_cfg function calls in lan937x_setup.
> This change ensures that if any lan937x_cfg or ksz_rmw32 calls fails, the
> function will return the appropriate error code.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/dsa/microchip/lan937x_main.c | 27 +++++++++++++++---------
>  1 file changed, 17 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [net-next,v1,1/1] net: dsa: microchip: lan937x: Add error handling in lan937x_setup
    https://git.kernel.org/netdev/net-next/c/aa77b1128016

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



