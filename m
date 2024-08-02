Return-Path: <netdev+bounces-115449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B98946637
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF6DB217CB
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F7713AD37;
	Fri,  2 Aug 2024 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNc6WtxE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252DB1ABEB5
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722642033; cv=none; b=oYIi9tRcaaw1TuZK/P+JLaAzvPgvXV2oxo4TvNJylTpSe/FggENUKUFNxHnxVISa/mogTVHPsCS226Nzmg4CbV16tBLlPtp1KhuDyYPVOYJzFppvSp4aJEcXhTxUy+uVFCg78OKJRNwBfbxvcudITHjOiaXHVX5MnTThzuG0eOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722642033; c=relaxed/simple;
	bh=B6YhMxvMRJGxxwrCRJRhlQfkNl/ORSnS5aSCbKvdd0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s1YBpb0QF21z9cKPAAD3+FuRF0IlLmAoly0nbfdtjyUusnvDE2tAdzT2CFJ3XC/43GjgnQrNC+clW39YxcgYCg2fCscA9PlU5bd7rfuI0bHX1O39ADJnM8VNgPKX5sIm/xsqZa+xlTeQFeW8S9mp3LHh4aIPup+/nrpS0gZfXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNc6WtxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99EEBC32782;
	Fri,  2 Aug 2024 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722642032;
	bh=B6YhMxvMRJGxxwrCRJRhlQfkNl/ORSnS5aSCbKvdd0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sNc6WtxEdvKXc3/AP+G8OIus7twk3D40mj5/Hv+3rbI5D+6FO3UOkzRn/qeSmHES1
	 n3R+UoyH07ARmU6rsENkmJuWUOxtmX9OPEPRUkw3fI8f3fOg+BborcDetGDVJhPgMA
	 9OdQ/TyNefRIHBl7wgF62ZL6QrIalHPMRNEfSV17V67Lzx0ZBiY2wrC2agUMRsDm5E
	 wFGU13pWA0vgIAK7C9NqEuVqzfAPO8U/EH2ueNtReTP2iL/SwustjxlHQgc29eWlYL
	 rMB9quTbKcbK05SlkJ9TgOItYBYq8Pnhoix0X41Q9PUwkpZAxZpqSKYxYO2wdTtkkp
	 1wd+9E21h/xwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86894C43339;
	Fri,  2 Aug 2024 23:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/8] Add second QDMA support for EN7581 eth
 controller
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264203254.30831.3666511031487225310.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 23:40:32 +0000
References: <cover.1722522582.git.lorenzo@kernel.org>
In-Reply-To: <cover.1722522582.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
 angelogioacchino.delregno@collabora.com, benjamin.larsson@genexis.eu,
 rkannoth@marvell.com, sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Aug 2024 16:35:02 +0200 you wrote:
> EN7581 SoC supports two independent QDMA controllers to connect the
> Ethernet Frame Engine (FE) to the CPU. Introduce support for the second
> QDMA controller. This is a preliminary series to support multiple FE ports
> (e.g. connected to a second PHY controller).
> 
> Changes since v1:
> - squash patch 6/9 and 7/9
> - move some duplicated code from patch 2/9 in 1/9
> - cosmetics
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/8] net: airoha: Introduce airoha_qdma struct
    https://git.kernel.org/netdev/net-next/c/16874d1cf381
  - [v2,net-next,2/8] net: airoha: Move airoha_queues in airoha_qdma
    https://git.kernel.org/netdev/net-next/c/245c7bc86b19
  - [v2,net-next,3/8] net: airoha: Move irq_mask in airoha_qdma structure
    https://git.kernel.org/netdev/net-next/c/19e47fc2aeda
  - [v2,net-next,4/8] net: airoha: Add airoha_qdma pointer in airoha_tx_irq_queue/airoha_queue structures
    https://git.kernel.org/netdev/net-next/c/9a2500ab22f0
  - [v2,net-next,5/8] net: airoha: Use qdma pointer as private structure in airoha_irq_handler routine
    https://git.kernel.org/netdev/net-next/c/e3d6bfdfc0ae
  - [v2,net-next,6/8] net: airoha: Allow mapping IO region for multiple qdma controllers
    https://git.kernel.org/netdev/net-next/c/e618447cf492
  - [v2,net-next,7/8] net: airoha: Start all qdma NAPIs in airoha_probe()
    https://git.kernel.org/netdev/net-next/c/160231e34b8e
  - [v2,net-next,8/8] net: airoha: Link the gdm port to the selected qdma controller
    https://git.kernel.org/netdev/net-next/c/9304640f2f78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



