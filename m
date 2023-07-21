Return-Path: <netdev+bounces-19749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D1275C064
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 09:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C02E2821AB
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 07:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3D13D84;
	Fri, 21 Jul 2023 07:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57432102
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C6EDC433C7;
	Fri, 21 Jul 2023 07:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689925822;
	bh=4jM3kjnz5BSyhDguLZJATh6NY3feZ2xWZ+gP3oI9Fd0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PuTOu9Sq1C531lKOAonWo4TjDEaq0RqBqmATMBGSvF9hCNrXlcqiTWGJf7mdjwyiH
	 fQJcNuZM9s4CibXTY4Ya4Dlx4Qlm0sxLAwCDKvyz/7wEmy9xgdl+srLrrCRa9ws6zt
	 XaLDIS0yChQfLtR/rtnfhlU01FxDM2HaK4sZq4IfXzDoSdSpqaAsnIOQ8wtBSEuW/J
	 O7bc7cEsbdZdlw79w8rMg1D4jvWXRZO9A8hWhNd8XsooQUG0J/iTzRNySElj8JfEwp
	 CZgrF5dg1gOP5ZmT2pZ8XzuHJhYMTqB1NKkHDRgEPXnzXN9DMliPpPXb8XozwhRUHd
	 aWhJNS2voM66g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40E03E21EF5;
	Fri, 21 Jul 2023 07:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_ppe: add
 MTK_FOE_ENTRY_V{1,2}_SIZE macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168992582226.6754.13740375864071191093.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jul 2023 07:50:22 +0000
References: <725aa4b427e8ae2384ff1c8a32111fb24ceda231.1689762482.git.lorenzo@kernel.org>
In-Reply-To: <725aa4b427e8ae2384ff1c8a32111fb24ceda231.1689762482.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name, john@phrozen.org,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo.bianconi@redhat.com, daniel@makrotopia.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 19 Jul 2023 12:29:49 +0200 you wrote:
> Introduce MTK_FOE_ENTRY_V{1,2}_SIZE macros in order to make more
> explicit foe_entry size for different chipset revisions.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 10 +++++-----
>  drivers/net/ethernet/mediatek/mtk_ppe.h     |  3 +++
>  2 files changed, 8 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net: ethernet: mtk_ppe: add MTK_FOE_ENTRY_V{1,2}_SIZE macros
    https://git.kernel.org/netdev/net-next/c/a5dc694e16d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



