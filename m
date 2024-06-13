Return-Path: <netdev+bounces-103026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 523AE905FDF
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2CF7B213D3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 01:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76E0AD5B;
	Thu, 13 Jun 2024 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIV9YnqU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4D20E3;
	Thu, 13 Jun 2024 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240431; cv=none; b=NQ+gSfnIXbHGpv5D0buFtfBC++ChymIF6dWTQVvAV42JzCLFGoHc2c68YUK4B2lnH2hpuSik2T0B7XYIi99UDKh22hkDLIjIdeQyVGp0UhOUFNMeus5qtatnxDgyJuYWFZy6WOhyae5gV7xRm6FliXF/xjhjkS11QQ0mS58lrqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240431; c=relaxed/simple;
	bh=A90udtY5N2r40p7F+o+B46r7+DdZME9ofup2TjtLCow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QSm0ghOguSggbLlta3Dy4Ylf7hLZlwnp7MW33rYfXnu0mcULs2EIYIMRL6UrEYHipL1YSNnEw6zv/ZGcO0UTp8+NEOkcgxH3h9QCOGr97vNwgwKb+dDLaVcZO6wq5jNbW1BL17xY7cE2Vg3b2evq16DqPrL9LuCSPerdS72SDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIV9YnqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51F7CC4AF54;
	Thu, 13 Jun 2024 01:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718240431;
	bh=A90udtY5N2r40p7F+o+B46r7+DdZME9ofup2TjtLCow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cIV9YnqU0Fetft+Iy7/EqPcRFVN5LthTleLM43LfB6NqCWVVR7AENsWDgUYeG78pN
	 v4Dk9iQoywLI0WfkVlzStU4Xmt03+6viYsWaiDa32FzBi+SoksJcFfxHE+YFav9tS0
	 Inh/67YRR2tirdiNV+1snTGe9eis941fvfkNm6ewKMcQhDgPxspNlLHdoi/Xbm1Q4h
	 AwP8kWs1V0QN0gkDRm3Cprqs+oENyZd4tMTNNvbdh77s82r25ZiBZS9m4zpWQKLDEa
	 +lsHWG6LtFp+GEtv7kFLekOpT4XjAepYAiFyCOPiGNjm8HJK/XL+NXUvJ51+VyReKc
	 E+tzQjqHYHMJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 452EEC43613;
	Thu, 13 Jun 2024 01:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6] net: ethernet: mtk_eth_soc: ppe: add support for
 multiple PPEs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171824043128.29237.10490597706474690291.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 01:00:31 +0000
References: <20240607082155.20021-1-eladwf@gmail.com>
In-Reply-To: <20240607082155.20021-1-eladwf@gmail.com>
To: Elad Yifee <eladwf@gmail.com>
Cc: daniel@makrotopia.org, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Jun 2024 11:21:50 +0300 you wrote:
> Add the missing pieces to allow multiple PPEs units, one for each GMAC.
> mtk_gdm_config has been modified to work on targted mac ID,
> the inner loop moved outside of the function to allow unrelated
> operations like setting the MAC's PPE index.
> Introduce a sanity check in flow_offload_replace to account for
> non-MTK ingress devices.
> Additional field 'ppe_idx' was added to struct mtk_mac in order
> to keep track on the assigned PPE unit.
> 
> [...]

Here is the summary with links:
  - [net-next,v6] net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs
    https://git.kernel.org/netdev/net-next/c/dee4dd10c79a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



