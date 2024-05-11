Return-Path: <netdev+bounces-95644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ADC8C2EC2
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F92C283269
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6EC12E5B;
	Sat, 11 May 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn07Hq5V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0372512B77;
	Sat, 11 May 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392829; cv=none; b=CV5V2gAA9gHHkOkoWdAocO3EL21Wvh5zc6E2HFX6p1g/Nj+7w8sgO4exd74Crs9dZVEkeLp+m9Snu9RxlOFISeuzMr5/sk5BZY9LH/vIAMO8mZVzO3r2cJMBr27TwPnQNR6vDRdgiGc0G5k2Qtdb5ozCj6nFEDz04UGCQQPSTHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392829; c=relaxed/simple;
	bh=BgsBAK0JY+nmfeUonGKRUV4Z9iF896Efa6TsEWvZ5xg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lc8aQQUoA2h+YJsFm0M6SwmrSsK8NQOAolEUaYroWmv0EQjgh7WvHEFKjnCPHSV/MHM+fQhO18rQszIzBYpspCRTAWUsls3d620twxwkRT39/b7cRrwnQMNBRUgLqTsvWVQHJjAGrIDLd+iS/ojk6+VnvmUUlWzaczRXTxkUefU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn07Hq5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BF9EC2BD10;
	Sat, 11 May 2024 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715392828;
	bh=BgsBAK0JY+nmfeUonGKRUV4Z9iF896Efa6TsEWvZ5xg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gn07Hq5Vshl41f2Qu/7VZ9ai4U62FwlOTMUwGqSR1ymd3/nyI81HzB6/GLBM2P/Op
	 4uBcZ7s7+D+skH+6tZyscceHWv5+04S7CuZyMYRigz9ILVvlZnN5DnuEBp3n4aaBzY
	 PwQ15iAHn55/wKSp6PJFV0EKx8pSwH5cSZ+IupKfOwl6lQuVjqf0PcziavTiGbO8hB
	 M86LrYDztxMUzPPa9oje+/vDaLR4eepsMsegbjw3IdDWHIJtNnI+ZyPU1duw+Aru0A
	 MxvtD/Tq8kYXQCew1jBxnG1Qn7307See8D84eCo/tk2qzsc8Q/AyeqJflcFrbTRnf0
	 iO0nQ0hb67jaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A9BDE7C112;
	Sat, 11 May 2024 02:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] net: ethernet: mediatek: split tx and rx fields in
 mtk_soc_data struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539282849.14416.4543219653688344298.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:00:28 +0000
References: <70a799b1f060ec2f57883e88ccb420ac0fb0abb5.1715164770.git.daniel@makrotopia.org>
In-Reply-To: <70a799b1f060ec2f57883e88ccb420ac0fb0abb5.1715164770.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 8 May 2024 11:43:34 +0100 you wrote:
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> Split tx and rx fields in mtk_soc_data struct. This is a preliminary
> patch to roll back to ADMAv1 for MT7986 and MT7981 SoC in order to fix a
> hw hang if the device receives a corrupted packet when using ADMAv2.0.
> 
> Fixes: 197c9e9b17b1 ("net: ethernet: mtk_eth_soc: introduce support for mt7986 chipset")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [v3,1/2] net: ethernet: mediatek: split tx and rx fields in mtk_soc_data struct
    https://git.kernel.org/netdev/net/c/ecb51fa37ee2
  - [v3,2/2] net: ethernet: mediatek: use ADMAv1 instead of ADMAv2.0 on MT7981 and MT7986
    https://git.kernel.org/netdev/net/c/5e69ff84f3e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



