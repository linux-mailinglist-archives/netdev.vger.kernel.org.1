Return-Path: <netdev+bounces-211497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65558B196EB
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 02:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABEC1892DB3
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 00:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A07023B0;
	Mon,  4 Aug 2025 00:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVliPse+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76E29A1;
	Mon,  4 Aug 2025 00:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754265963; cv=none; b=gff4aJG5pqaTV33zrTiiqWoOBIVoXMR9L2FKjPs0W2vVKFo/XfN1PqkfjDNgEhfkfH9d44lL7h9aseza4dWh3hdvJqe91FjFRMb2lnYyJzrnufkQDfb55V7eLShBLmvI3NyvsNfGO0VGuATaeG1Fj3K/aEuBteHFMJA0/ofJbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754265963; c=relaxed/simple;
	bh=DSq/YM1UGCph6sQ2aZV7hob4axkz1/tMxmyrRx+A1cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOAcvB9bwU3vnj8pLdN4d9rjw5wFIVfGeGe1HqIXRrOPlyfKO8iB+Td13TUY9tL8KseWnY8JTKyY/yfAM34wTE4nSEFMfmOLuUCy3AwyRlG2sgPOmvJiRiOe9PD14ApEkzjwRIx+p08eFayfoun1toShwepKmdR828I15SY3Zpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVliPse+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92FFC4CEEB;
	Mon,  4 Aug 2025 00:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754265962;
	bh=DSq/YM1UGCph6sQ2aZV7hob4axkz1/tMxmyrRx+A1cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVliPse+jMfFpof+J59UfX16HwoSeFFCIdabyYa4bvsNIpbwD8Z6WcX04nUUg5L6/
	 9PqMaF0yk+vEocBQm1Na0skwQOTHRwLEWD9zWeRfQUxSd8/kpJJKuHVRWUryFoiyR/
	 pYdqJqBTH2tzBEnVjrjmdkOLsp33TOpLjIybr7z3U+pS1YE+cxeSZoZtolR2pB8uaY
	 eg2FsG6sWI0CRQB+bop6N6MrBBBySRTRwdgO2DWRtiGHVegcIKV3HR6XGmiRssEGkS
	 FjUkImkuspm9ymmvlqRT4ujHWzz/Rz/LBV8IQGxR4DyIdztoISq0J03iMHB8YT3def
	 4cScPtsgmQ17Q==
Date: Sun, 3 Aug 2025 17:06:01 -0700
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, nux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: thead: Enable TX clock before MAC
 initialization
Message-ID: <aI/5aS064VKfLTJT@x1>
References: <20250801094507.54011-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801094507.54011-1-ziyao@disroot.org>

On Fri, Aug 01, 2025 at 09:45:07AM +0000, Yao Zi wrote:
> The clk_tx_i clock must be supplied to the MAC for successful
> initialization. On TH1520 SoC, the clock is provided by an internal
> divider configured through GMAC_PLLCLK_DIV register when using RGMII
> interface. However, currently we don't setup the divider before
> initialization of the MAC, resulting in DMA reset failures if the
> bootloader/firmware doesn't enable the divider,
> 
> [    7.839601] thead-dwmac ffe7060000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> [    7.938338] thead-dwmac ffe7060000.ethernet eth0: PHY [stmmac-0:02] driver [RTL8211F Gigabit Ethernet] (irq=POLL)
> [    8.160746] thead-dwmac ffe7060000.ethernet eth0: Failed to reset the dma
> [    8.170118] thead-dwmac ffe7060000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
> [    8.179384] thead-dwmac ffe7060000.ethernet eth0: __stmmac_open: Hw setup failed
> 
> Let's simply write GMAC_PLLCLK_DIV_EN to GMAC_PLLCLK_DIV to enable the
> divider before MAC initialization. The rate doesn't matter, which we
> could reclock properly according to the link speed later after link is
> up.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
> ---
> 
> Note that the DMA reset failures cannot be reproduced with the vendor
> U-Boot, which always enables the divider, regardless whether the port is
> used[1].

Thanks for sending this fix. I do now have a 16GB RAM LPi4a so I'll try
to get the mainline u-boot on there in order to test.

Thanks,
Drew

