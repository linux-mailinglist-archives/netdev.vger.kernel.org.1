Return-Path: <netdev+bounces-31118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C759C78B8AC
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 21:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896C1280EEB
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E48A14267;
	Mon, 28 Aug 2023 19:47:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F401401A
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 19:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66336C433C7;
	Mon, 28 Aug 2023 19:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693252065;
	bh=C4Ir9bNWumGZzSRtNes2Jz5ys6JqBziIumxbHwsTdO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pt2TiriD50KKRwOmmP5NpsaQE/9Yosb+AWCBsHFkuvx1YnDtVcr5cC1cMTTps4Ug2
	 sxYBUqkIdoEo3hg9uQnrdU3hoDPs9s6hRQsaXt8wIa2SWNyIYhXFz6TWN9rx+zFqwe
	 rDOgPOSjJDW3u+aLPC30xtSXRzOa09okhBs/XxYAre2ExymejyBtKIiHl1lwst4jcJ
	 vfKYGIOf6HwZ4G0d0AyMkJI+vkqQwMkRFqmeBzUGBiLihfMoL/fLKlK7Wn7myHZKRZ
	 hno996IvnfHCxH8vK2twXukWv8fKEiA4R5PU29wnMwWM3/ZOPOU2hKk1uahpHBTfdV
	 w40ubq/+KxytQ==
Date: Mon, 28 Aug 2023 12:47:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, Sean Wang
 <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Russell King
 <linux@armlinux.org.uk>, Frank Wunderlich <frank-w@public-files.de>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: add paths and
 SerDes modes for MT7988
Message-ID: <20230828124743.4882a1a2@kernel.org>
In-Reply-To: <e6bb7c95c93e7ae91de998d2fd32580db2ce05c3.1693183332.git.daniel@makrotopia.org>
References: <e6bb7c95c93e7ae91de998d2fd32580db2ce05c3.1693183332.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Aug 2023 01:56:19 +0100 Daniel Golle wrote:
> MT7988 comes with a built-in 2.5G TP PHY as well as SerDes lanes to
> connect external PHYs or transceivers in USXGMII, 10GBase-R, 5GBase-R,
> 2500Base-X, 1000Base-X and Cisco SGMII interface modes.

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


