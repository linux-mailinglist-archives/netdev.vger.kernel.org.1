Return-Path: <netdev+bounces-42535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68077CF39C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88A61C208A5
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A0F168A3;
	Thu, 19 Oct 2023 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH5YXUvF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BDA16416
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 09:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A988C433C9;
	Thu, 19 Oct 2023 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697706624;
	bh=Ebub719cRz9G5ACNsmDwbxaKVkRnz5JEOIBNJDMXBA8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NH5YXUvFrRWaZ2D+vykw34JsWFGdgzdgBFdmrdsOkJ/7vgNwqKuRdUna3jxCLdWfM
	 c0TCEAurZcBgBtTV91z4sJoVQ3Cc1hOgbne7exSLOUnPuCyQLp+eYYRUCgf5BcHUWa
	 MhE6OZSxPXtE8zSelO6WqCL8S538G2Qo+u2B0Lpodumu+pF7EyomOGjwZGXVZkGtFg
	 VjkFYe4WsWg/k9gEnGEy/OU/0z2916DotNZz0Ue5G4zaMqINaA2+A6vYxGiogcpHM3
	 W5SeCJhIi9JK1FWib/1iTfzkxjPalG6YRR5oXs5MZIsIA7AuVXUSF9BO/xvGIzU2+K
	 RBeGFKh3YQCpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D81AC73FE1;
	Thu, 19 Oct 2023 09:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] rswitch: Add PM ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169770662444.23024.10068818834489019175.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 09:10:24 +0000
References: <20231017113402.849735-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20231017113402.849735-1-yoshihiro.shimoda.uh@renesas.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 17 Oct 2023 20:34:00 +0900 you wrote:
> This patch is based on the latest net-next.git / next branch.
> After applied this patch with the following patches, the system can
> enter/exit Suspend to Idle without any error:
> https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?h=next&id=aa4c0bbf820ddb9dd8105a403aa12df57b9e5129
> https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?h=next&id=1a5361189b7acac15b9b086b2300a11b7aa84c06
> 
> Changes from v2:
> https://lore.kernel.org/all/20231013121936.364678-1-yoshihiro.shimoda.uh@renesas.com/
>  - Based on the latest net-next.git / main branch.
>  - Change the subject in the patch 1/2.
>  - Fix a condition to avoid endless loop in the patch 1/2.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] rswitch: Use unsigned int for port related array index
    https://git.kernel.org/netdev/net-next/c/1bf55630694e
  - [net-next,v3,2/2] rswitch: Add PM ops
    https://git.kernel.org/netdev/net-next/c/35b78409e1c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



