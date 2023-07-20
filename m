Return-Path: <netdev+bounces-19337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5973675A50B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1AE1C212AF
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224C1C05;
	Thu, 20 Jul 2023 04:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83C20F8
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81328C433CA;
	Thu, 20 Jul 2023 04:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689826821;
	bh=zrcWXvlGwF0/Gsyotaj6bAKjRzyfWdgaY8YfW205qtw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kBDyWnEX5LUI3u9/GVS37fs2MtVK4he5svjAiu96vw+SOyJfmlG/rsTi92KPZLDoW
	 OLUFmcNeUl3+VCcufonriYQKNYci4Uf8b0Of3CO3AGtebrNF0yFe7dEfza9tX0Dm4H
	 hgBokhuMz5EjoaQBK30dudEbKonD2SGiKBxSmmOWxb2QK5Tb1RPDQf5QErzb3AGkjf
	 GMVQiZ1RRpXnbEolur9yd3mjtrhUGYTozIXg7gjPArAMHB0JCio1IJeFTWFPDnCfY+
	 O/V1GrPCppri3mzDgANlB7daHectf9EOIm4ykxKykkSJPfyrt/Ccaq/wEqqa2kDGdH
	 JH/Rzpez7Ybmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62AC9E22AE2;
	Thu, 20 Jul 2023 04:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: always mtk_get_ib1_pkt_type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168982682139.14645.4950996915143284587.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 04:20:21 +0000
References: <c0ae03d0182f4d27b874cbdf0059bc972c317f3c.1689727134.git.daniel@makrotopia.org>
In-Reply-To: <c0ae03d0182f4d27b874cbdf0059bc972c317f3c.1689727134.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sujuan.chen@mediatek.com, Bo.Jiao@mediatek.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jul 2023 01:39:36 +0100 you wrote:
> entries and bind debugfs files would display wrong data on NETSYS_V2 and
> later because instead of using mtk_get_ib1_pkt_type the driver would use
> MTK_FOE_IB1_PACKET_TYPE which corresponds to NETSYS_V1(.x) SoCs.
> Use mtk_get_ib1_pkt_type so entries and bind records display correctly.
> 
> Fixes: 03a3180e5c09e ("net: ethernet: mtk_eth_soc: introduce flow offloading support for mt7986")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_eth_soc: always mtk_get_ib1_pkt_type
    https://git.kernel.org/netdev/net/c/9f9d4c1a2e82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



