Return-Path: <netdev+bounces-20591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9C7602E4
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 01:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A881C20CEE
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7112B67;
	Mon, 24 Jul 2023 23:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02812B65
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68B1C433C7;
	Mon, 24 Jul 2023 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690239626;
	bh=0gLqL+skDZyctyEo4XytA7Z78FygL1xuVREEMkFKdSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V9ZMTQWTDr69DqPhmCHg0Q5D5JNpks3fKkPvZjBfR72bXRLolOpcqpds0YGO+c8uC
	 L94c8N1csZFQGlQs06lg18PenCAvfJo794gW/uD4cBTdOGztzI4sKdN3hDFdkKVHhE
	 4M73DHrhwMOQepwfymJNAgO2SwaRy3SzYfnXmpj9MJUcDJ1ojX9pymGwoO7ed3oKN1
	 gSxENlM/QD3BPsHlAdNnv/brc+GyrKiAFcEOC5Ga8ReThNgJ/ZTDo5r7WDT8crlEeO
	 R+Gp9QYD0VlPXaLn6ruSxCe7D/cSGophyzs8wCDKe+0RkGThw4VX74tXurmLJO7Cky
	 cxWe4qzjMlo0Q==
Date: Mon, 24 Jul 2023 16:00:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, Sean Wang
 <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, =?UTF-8?B?QmrDuHJu?= Mork
 <bjorn@mork.no>, Greg Ungerer <gerg@kernel.org>, Florian Fainelli
 <f.fainelli@gmail.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v5 0/9] net: ethernet: mtk_eth_soc: add basic
 support for MT7988 SoC
Message-ID: <20230724160024.427b2bef@kernel.org>
In-Reply-To: <cover.1690148927.git.daniel@makrotopia.org>
References: <cover.1690148927.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Jul 2023 22:57:08 +0100 Daniel Golle wrote:
> The series should not conflict with Russell's recently submitted series
> "Remove legacy phylink behaviour", hence the order of them being
> picked into net-next doesn't matter.

Not sure what the exact conflict is, but:

Failed to apply patch:
Applying: dt-bindings: net: mediatek,net: add missing mediatek,mt7621-eth
Applying: dt-bindings: net: mediatek,net: add mt7988-eth binding
Applying: net: ethernet: mtk_eth_soc: add version in mtk_soc_data
Applying: net: ethernet: mtk_eth_soc: increase MAX_DEVS to 3
Applying: net: ethernet: mtk_eth_soc: rely on MTK_MAX_DEVS and remove MTK_MAC_COUNT
Applying: net: ethernet: mtk_eth_soc: add NETSYS_V3 version support
Applying: net: ethernet: mtk_eth_soc: convert caps in mtk_soc_data struct to u64
Applying: net: ethernet: mtk_eth_soc: convert clock bitmap to u64
Applying: net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC
error: sha1 information is lacking or useless (drivers/net/ethernet/mediatek/mtk_eth_soc.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Patch failed at 0009 net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
-- 
pw-bot: cr

