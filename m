Return-Path: <netdev+bounces-115060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B46D945030
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5B71C22D2D
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAFF1B32BA;
	Thu,  1 Aug 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9ZLEHG+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253A113D2B7;
	Thu,  1 Aug 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528634; cv=none; b=MYzsYqmXbzTTznfrObzibmuaT3gFDwIy/bxvB46CrvwMH7xV3XhCoEznArQuO3moX/goGoVteh+vrVio140Ig/Tcwtw17ZT35GETMF0wiA9xWuv+Vw4lge80ewAEpvioT8gCE6G4CTK/KSYTZXttDeVQOcjpz4kcw9rvX4GhSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528634; c=relaxed/simple;
	bh=SKNVY1pGpUiuxHoYtnVcTNVtUPGQji5HRvtNZEn9TR0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pCskuTyrSfwliO1bZWO1nwa4vxfHaLRjt48ZmhencXykrjm21DBDQx9I/2yX51B0B5BM2g3AzhUAzYayY5xNWJkGjYsTwmSXUmtonOZNPWkcHq+GFWb1rEW4jDo0pFYJQD90nVvmRCCQO33QyK36MQMk2hTXC9pYqmfJ9lg7qQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9ZLEHG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B19BCC4AF0E;
	Thu,  1 Aug 2024 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722528633;
	bh=SKNVY1pGpUiuxHoYtnVcTNVtUPGQji5HRvtNZEn9TR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E9ZLEHG+nKAzwqcbL3U/mEhcOfJ2msFQGubiZHw2K/cIMgIV8i4SLzmFV05DK2w56
	 ql8gnZMmVo+7xAO6xt4mu7o75wN9w6bGtNNWNeauOf4ILfKcBj/H/T6lHIU4kC5Kc+
	 Lbz1R/237laOyuCR+ONiNAIpxT6G2EcSO/fFEvm0tjNOZtbkR0+PMuFB0BxToGCda6
	 qUEXgHkaX2b02l6sJKCuclZJ9GclS+bUZEmOwtykTrCejamaQYPkuElBzZcwflCZxG
	 /Dt3RiLF2/8nkyTYiyzSfvoyG7VoCpmBSY5pPdxhzA3b9RfLc+xDtLxmlybqIOmRGM
	 d3rd707HnI6CA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C92FC3274E;
	Thu,  1 Aug 2024 16:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: ethernet: mtk_eth_soc: drop clocks unused
 by Ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172252863363.25785.16861658663358543639.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 16:10:33 +0000
References: <b5faaf69b5c6e3e155c64af03706c3c423c6a1c9.1722335682.git.daniel@makrotopia.org>
In-Reply-To: <b5faaf69b5c6e3e155c64af03706c3c423c6a1c9.1722335682.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, andrew@lunn.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jul 2024 11:36:42 +0100 you wrote:
> Clocks for SerDes and PHY are going to be handled by standalone drivers
> for each of those hardware components. Drop them from the Ethernet driver.
> 
> The clocks which are being removed for this patch are responsible for
> the for the SerDes PCS and PHYs used for the 2nd and 3rd MAC which are
> anyway not yet supported. Hence backwards compatibility is not an issue.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: ethernet: mtk_eth_soc: drop clocks unused by Ethernet driver
    https://git.kernel.org/netdev/net-next/c/887b1d1adb2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



