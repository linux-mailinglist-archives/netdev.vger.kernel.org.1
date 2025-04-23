Return-Path: <netdev+bounces-184955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B53C5A97C9B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 04:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8121B611B6
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 02:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8100263F3F;
	Wed, 23 Apr 2025 02:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxgRkm7i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F200263F28;
	Wed, 23 Apr 2025 02:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745374191; cv=none; b=VhCPoaZqQTrG0vwHMlwucEH230ZKlcNoDQqoostFThT5VtaoZS4yItR9qZRzw0K1z0ecYUqkH87D99F6l6d4ceToyV+A85QaNY2mYOmmFdHuTDGs5GQCfcEBygvl5g1ILOQ8E/4OuLVwcSkiFz6V0NuGxEX45GW3oMpZleqDMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745374191; c=relaxed/simple;
	bh=9Eq6F5rNFpCaMiyqHi+sGGOWlrMFXjbKYuY+wV7w51U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AvMykOJZMnWHfeJp4BCwVyevY/j2O8Px3yIni2q611q6NVeyVz5rM3Kz2P5wZZE6HsIXaFbVSqjdT5eWs8+r4IJBvDVYHyNOak0bSVsnJ7r0DyIGRwFidU4Hh60eMAPz2Y3N/F7EP7pIZztxvy92VEj5tznWJ3yls9uZnkqUEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxgRkm7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073F4C4CEEC;
	Wed, 23 Apr 2025 02:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745374191;
	bh=9Eq6F5rNFpCaMiyqHi+sGGOWlrMFXjbKYuY+wV7w51U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AxgRkm7iSqpy2pItlu4TMsQH/qP9CltUAWA/2h/JIakeTqGhgWgXBEJwc/zGJaNvk
	 ZEGz6jcQIp3+0y+iX+iJ2KtQJo3MHUT57yENhZfSs8e+tA1yNBJ/NIrUPqEWU8G+Wo
	 omx4oYNbHSpKd5Vcc1Dy2r6OMjnzpCGabMcKrd63otAeeCHX5YYdSQUP5TtZQ4IswQ
	 Scm/0/lBcvGD99vpdnEsCYnvpznAkA3pgjLLx783lz27Zq9glqSwiDId6q2lURu8VB
	 +xV5ZbMCyos9DVbug3tIc6+PpY3Rr2QIapcmWZarklSAMkah0zK4/89MDufe5Bx32p
	 Er9YAkN85jcQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF33380CEF4;
	Wed, 23 Apr 2025 02:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ethernet: mtk_eth_soc: net: revise NETSYSv3
 hardware  configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174537422950.2115098.6975575929534366973.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 02:10:29 +0000
References: <b71f8fd9d4bb69c646c4d558f9331dd965068606.1744907886.git.daniel@makrotopia.org>
In-Reply-To: <b71f8fd9d4bb69c646c4d558f9331dd965068606.1744907886.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 17:41:07 +0100 you wrote:
> From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> 
> Change hardware configuration for the NETSYSv3.
>  - Enable PSE dummy page mechanism for the GDM1/2/3
>  - Enable PSE drop mechanism when the WDMA Rx ring full
>  - Enable PSE no-drop mechanism for packets from the WDMA Tx
>  - Correct PSE free drop threshold
>  - Correct PSE CDMA high threshold
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ethernet: mtk_eth_soc: net: revise NETSYSv3 hardware configuration
    https://git.kernel.org/netdev/net/c/491ef1117c56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



