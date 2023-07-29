Return-Path: <netdev+bounces-22496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C840C767B5D
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 03:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE6B1C2193F
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 01:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D73581A;
	Sat, 29 Jul 2023 01:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE75A31
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F688C433D9;
	Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690595421;
	bh=1Sh5/9xp6DddNN4KhSxvSnUfb5Iep7xLeylU3QWYXeo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XzXdtSe8Xe888DEc0wHGPS9P263OENXVeWfLvP+OLcbV54XZl9FCZNhmOTUEZg0Oc
	 tG/pqvHSpWOLpR2Kbk0WP5n+/Rw3zUORefrHCwbYXUnPpLZc+Hg4Z9VpdyCuSrftxD
	 JC8f1/Q/fePHNvtbBYWZRZMCCYMKJ3Z4DuCdJd3Fj6atLPQMgTuq7rlA2v//gnHA1k
	 ihjvR1jjI47AkrBkGtuwGa3ZbKJOvI7/TIpFPllvY3XMQyuG1aaxMPmejnicn1I+mC
	 7Wk3WCpwPy4dGBziqWZOdK2NhgxHdV7yvPYNJQ4tQFJ/g3bp4yJIpesTN9pSVLuFu8
	 fCmQbpzEpNcQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 229FFE1CF31;
	Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: enable nft hw
 flowtable_offload for MT7988 SoC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169059542113.13127.8969896072159084068.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jul 2023 01:50:21 +0000
References: <5e86341b0220a49620dadc02d77970de5ded9efc.1690441576.git.lorenzo@kernel.org>
In-Reply-To: <5e86341b0220a49620dadc02d77970de5ded9efc.1690441576.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, john@phrozen.org,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lorenzo.bianconi@redhat.com, daniel@makrotopia.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jul 2023 09:07:28 +0200 you wrote:
> Enable hw Packet Process Engine (PPE) for MT7988 SoC.
> 
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c |  3 +++
>  drivers/net/ethernet/mediatek/mtk_ppe.c     | 19 +++++++++++++++----
>  drivers/net/ethernet/mediatek/mtk_ppe.h     | 19 ++++++++++++++++++-
>  3 files changed, 36 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net: ethernet: mtk_eth_soc: enable nft hw flowtable_offload for MT7988 SoC
    https://git.kernel.org/netdev/net-next/c/88efedf517e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



