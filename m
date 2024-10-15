Return-Path: <netdev+bounces-135394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E72399DB27
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 03:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4947B21744
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530A1153BF7;
	Tue, 15 Oct 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hcqc9zXW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED971537DA;
	Tue, 15 Oct 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954633; cv=none; b=OJ2jHpS3QEWc0SP/1uhZ5XiWB/qus/KOAWtZQICAr1sy45mc7ISY+tq9yYwAUXMbr9yvJE1hIzBRTEyxgbuZnukp6AvcAnP4NXJLYSrDcGCTUuMMWdrFTDoCIjPzNUxoAmYEZW03PTH2K8/EiYYUTyMD+jvMRjN8wUveFQO/LbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954633; c=relaxed/simple;
	bh=UOJbWPQWmTdSA81rRftszQfoSPKSv3GWQ0BhskXRA1Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dRUYbzI5qokLKf9deTGIe02nUSTsDlHSf8xzqBwlyTtI16mk5+L1vWsz/LHvjNUulaXEdgj5ysXbjgGbTDUHEQ+Esng3+LVR+slxMe7kWN4HBI5pHALDVQi9opMtS4x1jlNkMmuHuLgs2DHu7x/ArCwfzPQl+XVds7ilC65lVSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hcqc9zXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BCAC4CEC6;
	Tue, 15 Oct 2024 01:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728954632;
	bh=UOJbWPQWmTdSA81rRftszQfoSPKSv3GWQ0BhskXRA1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hcqc9zXWMU9uInhPEYS18uZ18agL7FETCOaPCOiNIvw2HOxui9j/HJQXDlxgLyhvc
	 7P7YHkfk2qIe/vYDYq4JNKy/qpc2bk9LJgCobv/+idYbJdwS0brsGYZtF2/M+ag1x8
	 cLMNv+X7ueeSFXWrTKpv5sMWwrfrfOqcCpJViPYGKiE3XdIWaMhtQia7qUHl9Wc3Y1
	 WDBQuE/6nf8WpF+BCm953upU5QeW4QZCXVCPmCMl8h214KsupcF1e7ylGKn5Nk27EC
	 KwstXL5YPECB9NaHjgjJOZ0IFKareUYpP/Ak1CDpEcog4HH8TXjCCJWb/3Hj4FglXc
	 WjGVbjL7od4bQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF983822E4C;
	Tue, 15 Oct 2024 01:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mtk_eth_soc: use ethtool_puts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172895463776.686374.17879317591216862359.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 01:10:37 +0000
References: <20241011200225.7403-1-rosenp@gmail.com>
In-Reply-To: <20241011200225.7403-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Oct 2024 13:02:25 -0700 you wrote:
> Allows simplifying get_strings and avoids manual pointer manipulation.
> 
> Tested on Belkin RT1800.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Here is the summary with links:
  - net: mtk_eth_soc: use ethtool_puts
    https://git.kernel.org/netdev/net-next/c/2a22bead433e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



