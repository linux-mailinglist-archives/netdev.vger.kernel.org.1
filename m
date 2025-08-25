Return-Path: <netdev+bounces-216491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5371B340EA
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5937B0A61
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3D0274FDE;
	Mon, 25 Aug 2025 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SCimNEDu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17D78F29;
	Mon, 25 Aug 2025 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129081; cv=none; b=MQXN9FXf3iDFprxJ9R+HqfAo4poQ3w8kkt71HiT9fQGYpWrpjLgKLm7MSiJQRobvB4wU/Wvr8Xki2uZzZkz5IqWcbXm4lpP6zfR0ezRUbyXRhCQGVqulnD0kTcty3xy7u+W01RnoTMMgmI8nuaXBZU2iEslYUrvWpsAFDCoqOts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129081; c=relaxed/simple;
	bh=uOCWHgBTGh/T8WTiTshAa6HbioDTVHtQOtkq6YuQYTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnVNTLF6LWXXrRjNntp1CeFbHMbr14sY0J+d460h83bCknlqnPIuopHJZnrQmS00/hLoD1Mg5MnEmkgwz4+iSax9mQ0tmHMyLWLF2aRSeqcArRAjunLHg5zm0BnWiF31KryyIMYSNv0Jxt8U4voTlmnrVozSqo1D39E/xbBltkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SCimNEDu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PVgYUvPT1vPM01I1nr9R+3H7BRFArSAfjzLQN6iJKvQ=; b=SCimNEDupFMkyQhB1L09lOvN6L
	2R2NcLUFXj3aX6q1C9zMzhUzbva/YBhfegk7MxjDN9oyQchc03Y+e3j+lu0irp5X2jaAcQNfcLzkw
	57qcs0A5jOaIq5wT7QANf9CQw6k4yxggPLKlR2yYU9Hywo3l9qD2g0f/WNHW+WeGYkILoDqzSx59i
	64jBpaJd1/A5X2fUoTAm8taxCXd+syedJ0xfiDBwokuWNqMVpiwgI0EQCCMmjCy8MeQ3DEWfab/9z
	P/l3yoCWe6alpUfHXrf9VaRE17B1xFYZ0brzJFjmu3wKvk3yrOAqMNfujbdN1WPD7tVxWtSF8RFUT
	iH3woFiQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53562)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uqXOF-000000006XF-25Id;
	Mon, 25 Aug 2025 14:37:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uqXO9-0000000089m-0a0b;
	Mon, 25 Aug 2025 14:37:33 +0100
Date: Mon, 25 Aug 2025 14:37:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Chaoyi Chen <kernel@airkyi.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net-next v3] net: ethernet: stmmac: dwmac-rk: Make the
 clk_phy could be used for external phy
Message-ID: <aKxnHFSrVeM7Be5A@shell.armlinux.org.uk>
References: <20250815023515.114-1-kernel@airkyi.com>
 <CGME20250825072312eucas1p2d4751199c0ea069c7938218be60e5e93@eucas1p2.samsung.com>
 <a30a8c97-6b96-45ba-bad7-8a40401babc2@samsung.com>
 <d0fe6d16-181f-4b38-9457-1099fb6419d0@rock-chips.com>
 <809848c9-2ffa-4743-adda-b8b714b404de@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <809848c9-2ffa-4743-adda-b8b714b404de@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Aug 25, 2025 at 12:53:37PM +0200, Marek Szyprowski wrote:
> On 25.08.2025 11:57, Chaoyi Chen wrote:
> > On 8/25/2025 3:23 PM, Marek Szyprowski wrote:
> >> On 15.08.2025 04:35, Chaoyi Chen wrote:
> >>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> >>>
> >>> For external phy, clk_phy should be optional, and some external phy
> >>> need the clock input from clk_phy. This patch adds support for setting
> >>> clk_phy for external phy.
> >>>
> >>> Signed-off-by: David Wu <david.wu@rock-chips.com>
> >>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> >>> ---
> >>>
> >>> Changes in v3:
> >>> - Link to V2: 
> >>> https://lore.kernel.org/netdev/20250812012127.197-1-kernel@airkyi.com/
> >>> - Rebase to net-next/main
> >>>
> >>> Changes in v2:
> >>> - Link to V1: 
> >>> https://lore.kernel.org/netdev/20250806011405.115-1-kernel@airkyi.com/
> >>> - Remove get clock frequency from DT prop
> >>>
> >>>    drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 11 +++++++----
> >>>    1 file changed, 7 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c 
> >>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> >>> index ac8288301994..5d921e62c2f5 100644
> >>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> >>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> >>> @@ -1412,12 +1412,15 @@ static int rk_gmac_clk_init(struct 
> >>> plat_stmmacenet_data *plat)
> >>>            clk_set_rate(plat->stmmac_clk, 50000000);
> >>>        }
> >>>    -    if (plat->phy_node && bsp_priv->integrated_phy) {
> >>> +    if (plat->phy_node) {
> >>>            bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
> >>>            ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> >>> -        if (ret)
> >>> -            return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
> >>> -        clk_set_rate(bsp_priv->clk_phy, 50000000);
> >>> +        /* If it is not integrated_phy, clk_phy is optional */
> >>> +        if (bsp_priv->integrated_phy) {
> >>> +            if (ret)
> >>> +                return dev_err_probe(dev, ret, "Cannot get PHY 
> >>> clock\n");
> >>> +            clk_set_rate(bsp_priv->clk_phy, 50000000);
> >>> +        }
> >
> > I think  we should set bsp_priv->clk_phy to NULL here if we failed to 
> > get the clock.
> >
> > Could you try this on your board? Thank you.
> 
> Right, the following change also fixes this issue:
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c 
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 9fc41207cc45..2d19d48be01f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1415,6 +1415,8 @@ static int rk_gmac_clk_init(struct 
> plat_stmmacenet_data *plat)
>          if (plat->phy_node) {
>                  bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
>                  ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> +               if (ret)
> +                       bsp_priv->clk_phy = NULL;

Or just:

		clk = of_clk_get(plat->phy_node, 0);
		if (clk == ERR_PTR(-EPROBE_DEFER))
			...
		else if (!IS_ERR)
			bsp_priv->clk_phy = clk;

I don't have a free terminal to work out what "..." should be.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

