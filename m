Return-Path: <netdev+bounces-44924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C147DA3F6
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 01:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A86C1C21040
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E011E405E7;
	Fri, 27 Oct 2023 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI4ClUQZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0FE3B794
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 23:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CC94C433C9;
	Fri, 27 Oct 2023 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698448224;
	bh=oGAQr0kUPva3WFPGl1S5GoMtJcUApkO6sLUDwXbAZXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XI4ClUQZQdam50fw5Qi23xJJ0U/mYc4ILcpo9DKIns0iKBd6girqioTvla/TBiXpe
	 sb8KpZhMQX1K3CT/3hhfMNQfTuEQjPcgzIH2+PqHcMg5Ihja5n6UosiH4yuK3/3g0q
	 umhix0j+bqbAUv5eEWAH/97O1JLYvwZKScCNZisaB2xDiJCFdrOdWw4Xj5eIlXiPvn
	 fZmluJ5HacZ/+53r+DH9fLwhtVz6b310LwtBjC51YEhla4m/rVEMvs0BLgnUQXLtA1
	 BiZt1tfzIeqHPM2MGM1jMSx7+2kLhEe7zz1f1eJcZt3wWCKDdKSOTg0a2f/EB4y4rd
	 a3PFg8cRepiag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F4020C41620;
	Fri, 27 Oct 2023 23:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3] net: pcs: xpcs: Add 2500BASE-X case in get state
 for XPCS drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169844822399.29460.5135009526527266388.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 23:10:23 +0000
References: <20231027044306.291250-1-Raju.Lakkaraju@microchip.com>
In-Reply-To: <20231027044306.291250-1-Raju.Lakkaraju@microchip.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch, Jose.Abreu@synopsys.com,
 linux@armlinux.org.uk, fancer.lancer@gmail.com, UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Oct 2023 10:13:06 +0530 you wrote:
> Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
>  drivers/net/pcs/pcs-xpcs.c | 29 +++++++++++++++++++++++++++++
>  drivers/net/pcs/pcs-xpcs.h |  2 ++
>  2 files changed, 31 insertions(+)

Here is the summary with links:
  - [net-next,V3] net: pcs: xpcs: Add 2500BASE-X case in get state for XPCS drivers
    https://git.kernel.org/netdev/net-next/c/f1c73396133c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



