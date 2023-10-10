Return-Path: <netdev+bounces-39472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8CD7BF669
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177DE1C20B18
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3774A156C0;
	Tue, 10 Oct 2023 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRPm4PmD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E01FCF
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9079DC433D9;
	Tue, 10 Oct 2023 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696927826;
	bh=BWYz99hPfOyV0YYy1JV3gaQkQ3l1oiI/vIyh35+qab0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sRPm4PmDPvy5hdYY0p1OlEV0Jk52dUl9+w4gwy+zywmyDd7Y9XX9ymxsKlJqU8CZc
	 OUm8rHfLKf9j7otgLFR86hLH3Yq+Zfh9q40EzeCtP+UNghaxIhBR7D2SwLRCTAR3gU
	 vEVxDKfQV/8/vY30GHYBe9/UCaJ0rvh5mo5o4fi+jhXiguZvfNFUfdN0xLFlat0BDu
	 JLco5/m3Y9KwLlz4qQdOlBOAFDTpDkb1LMg/V7l2lhf64bnJ1LKdIY6gL7BapjGNw/
	 00lYWrf7+0XCkBzbDNUIraq1HWfsmjQ3MQTwaUaiMXYnKzqzhQnld3jpRdhU6G9x2Y
	 S5mZ6T2jkU23g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 686C0C595C5;
	Tue, 10 Oct 2023 08:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v7 0/4] Add update_pn flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169692782642.27521.12623155757527966309.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 08:50:26 +0000
References: <20231005180636.672791-1-radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <20231005180636.672791-1-radu-nicolae.pirea@oss.nxp.com>
To: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, borisp@nvidia.com,
 saeedm@nvidia.com, leon@kernel.org, sd@queasysnail.net, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, richardcochran@gmail.com,
 sebastian.tobuschat@oss.nxp.com, phaddad@nvidia.com, ehakim@nvidia.com,
 raeds@nvidia.com, atenart@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  5 Oct 2023 21:06:32 +0300 you wrote:
> Patches extracted from
> https://lore.kernel.org/all/20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com/
> Update_pn flag will let the offloaded MACsec implementations to know when
> the PN is updated.
> 
> Radu P.
> 
> [...]

Here is the summary with links:
  - [net,v7,1/4] net: macsec: indicate next pn update when offloading
    https://git.kernel.org/netdev/net/c/0412cc846a1e
  - [net,v7,2/4] octeontx2-pf: mcs: update PN only when update_pn is true
    https://git.kernel.org/netdev/net/c/4dcf38ae3ca1
  - [net,v7,3/4] net: phy: mscc: macsec: reject PN update requests
    https://git.kernel.org/netdev/net/c/e0a8c918daa5
  - [net,v7,4/4] net/mlx5e: macsec: use update_pn flag instead of PN comparation
    https://git.kernel.org/netdev/net/c/fde2f2d7f23d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



