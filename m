Return-Path: <netdev+bounces-170248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABDEA47F9D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD2516BD4D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64FE22FE08;
	Thu, 27 Feb 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUdi2pHs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06422F17B;
	Thu, 27 Feb 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663598; cv=none; b=H1HQvmZwD5/sjywlkzywZLTNuuI4WoFONwMqqY6eQZvSCa5tbcfcRECMxpg4mZZ1BUeHMLRmnsBzSGNVRdYnwwErzSldpRVfeqQejvodUEsXssT5km3bkEiNBSZQnuR7ALN8/3fjCA5AYg1xJ709nLY68TGniE/rb4L5OOI672o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663598; c=relaxed/simple;
	bh=cHUQXYpMECA1CrjD2oF3utlXd4IOvTws7zBps4QG/YU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N+3wEdFoWNlsJ8LVZDEA85rKRIBrYT1fKuST7YprvAbCguEpaZp3CTkyPKdwSVgYCghMa99T/ey6QR6vpx17Bb5svagDKihD7PLT/sAKbnNPQR1Zr88nkBgXj6LTFIXIfXrYKLzrvloIUL1eHfU77TCShHapYo9ayjdKn3FQre4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUdi2pHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E04C4CEDD;
	Thu, 27 Feb 2025 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663598;
	bh=cHUQXYpMECA1CrjD2oF3utlXd4IOvTws7zBps4QG/YU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IUdi2pHsnjtC3+oCFGu6yr3FYLbI3gp7NuuthL2YRkCo7aVzirJzZhkujCiXeQETp
	 9XTt5Rgej4zUn5LYmcH6/guD1uS4xm0ggMl0rwSO5v6ybcuf0hMgM/54K3NGl+EVRx
	 qmbKwkeclEETmkS5opO3f10HRN8zOd7RGgNHbgWAUx00KW78XxQXFIM5+VqIE4GSl6
	 R3/rrDP0JOZW51rh273W9yDcHM+uF2/gz3evgGulQP066tiHOCMPoqh/NQCv/Q1lZQ
	 HUP3/dt9ej9u0nKc1kRzz3nBMTIc82I+7XlRwpuPaBMkUL+bLHnKC7VvRGSA/Ajj4K
	 ts9cEsAGnJDJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C61380AA7F;
	Thu, 27 Feb 2025 13:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] net: ethernet: mtk_ppe_offload: Allow QinQ,
 double ETH_P_8021Q only
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174066363025.1432096.10317097850381047661.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 13:40:30 +0000
References: <20250225201509.20843-1-ericwouds@gmail.com>
In-Reply-To: <20250225201509.20843-1-ericwouds@gmail.com>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, frank-w@public-files.de,
 daniel@makrotopia.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Feb 2025 21:15:09 +0100 you wrote:
> mtk_foe_entry_set_vlan() in mtk_ppe.c already supports double vlan
> tagging, but mtk_flow_offload_replace() in mtk_ppe_offload.c only allows
> for 1 vlan tag, optionally in combination with pppoe and dsa tags.
> 
> However, mtk_foe_entry_set_vlan() only allows for setting the vlan id.
> The protocol cannot be set, it is always ETH_P_8021Q, for inner and outer
> tag. This patch adds QinQ support to mtk_flow_offload_replace(), only in
> the case that both inner and outer tags are ETH_P_8021Q.
> 
> [...]

Here is the summary with links:
  - [v4,net-next] net: ethernet: mtk_ppe_offload: Allow QinQ, double ETH_P_8021Q only
    https://git.kernel.org/netdev/net-next/c/7fe0353606d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



