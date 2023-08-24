Return-Path: <netdev+bounces-30196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9A5786559
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 04:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E0528140B
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2345193;
	Thu, 24 Aug 2023 02:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7964A928
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 163D0C433CA;
	Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692844224;
	bh=9Xb37OSDJN57bJvKF/3cFqqWU91ZHJ/cqmbZ1guvma4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FC/V84pP4Kluj8GF5Bg5IHVBAJWd1OJdu1XutdSouErp7c4EsaiT5lBnMFBkivf5f
	 /ewPNVv9XoGBEzn4ZwrrXYesNAB9oY00GoKL2UohT+TDrY49CtDl/sK3TkNb15zibx
	 +qOxyyVE0kGU1MPXBZgWXX2B1cBNZXwh390fqAF1lmS6Pqc3iK+LoYCMp1xIuHeehI
	 ynCVw2Knv7xDCTxzma72q9ydJEsqRWGvtV+aYx7av2GuTr06HmaMbo867mgP7rj1tP
	 v1dsPn1JpgHJYEfbx5HIdgOBCDd47P9a977LLAN2ubgBygoONPWrsDQqHnohivzCJ1
	 PHuVEjRp3MxiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB4A7E4EAF6;
	Thu, 24 Aug 2023 02:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] net: ethernet: mtk_eth_soc: improve support
 for MT7988
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169284422395.2546.12287101492552231894.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 02:30:23 +0000
References: <cover.1692721443.git.daniel@makrotopia.org>
In-Reply-To: <cover.1692721443.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Aug 2023 17:30:56 +0100 you wrote:
> This series fixes and completes commit 445eb6448ed3b ("net: ethernet:
> mtk_eth_soc: add basic support for MT7988 SoC") and also adds support
> for using the in-SoC SRAM to previous MT7986 and MT7981 SoCs.
> 
> Changes since v2:
>  * fold changes to commit they were supposed to go into
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] net: ethernet: mtk_eth_soc: fix register definitions for MT7988
    https://git.kernel.org/netdev/net-next/c/cfb5677de5ba
  - [net-next,v3,2/4] net: ethernet: mtk_eth_soc: add reset bits for MT7988
    https://git.kernel.org/netdev/net-next/c/88c1e6efb7a5
  - [net-next,v3,3/4] net: ethernet: mtk_eth_soc: add support for in-SoC SRAM
    https://git.kernel.org/netdev/net-next/c/ebb1e4f9cf38
  - [net-next,v3,4/4] net: ethernet: mtk_eth_soc: support 36-bit DMA addressing on MT7988
    https://git.kernel.org/netdev/net-next/c/2d75891ebc09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



