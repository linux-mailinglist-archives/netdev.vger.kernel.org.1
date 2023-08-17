Return-Path: <netdev+bounces-28379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2777F40D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBDE281E4F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F301512B7D;
	Thu, 17 Aug 2023 10:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC412B7A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 10:07:44 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4102D61
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P5M5Z06zfN4qTYiE3IHnPFu/3qnQFk9Eq4f88wCaOJY=; b=0uTNtezhZEBnSrGa8TleMZPN8Y
	iJRvYwA/qtKt4gtC9togK7nqLiyvIq4RIDtcI6PnGds61P5I2adxo6bia8fIjsps2QzDi3FIw2w1E
	CrcA/qRO5NWrkE91ce9el6Md//MvM+sCFDVDR1qdorXvPB9FK5Z2gsYIYMnqomKZfGb7mQVxZ2OA9
	ZU+MoxuN2jCESw+Sc5Hi3vnR1I+DQBsJV2ljj3xBwuztHa6EIC1IZOvfjV/yaOSWnNZnfC/t3RT8N
	z2wCZgotHMGrqLkoHJQJCl7NqACQhykmt91MHDVSKoZye7muVWazbbpqhSxQyZBmiYr9SCWQli6oo
	5YyTHMug==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48774)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qWZuO-0003zG-0u;
	Thu, 17 Aug 2023 11:07:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qWZuI-0000VX-Ok; Thu, 17 Aug 2023 11:07:10 +0100
Date: Thu, 17 Aug 2023 11:07:10 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lars.povlsen@microchip.com,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, horatiu.vultur@microchip.com,
	simon.horman@corigine.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 2/2] net: stmmac: Use helper function
 IS_ERR_OR_NULL()
Message-ID: <ZN3xTiaIGPzfmEjY@shell.armlinux.org.uk>
References: <20230817071941.346590-1-ruanjinjie@huawei.com>
 <20230817071941.346590-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817071941.346590-3-ruanjinjie@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 03:19:41PM +0800, Ruan Jinjie wrote:
> Use IS_ERR_OR_NULL() instead of open-coding it
> to simplify the code.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 733b5e900817..fe2452a70d23 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1165,7 +1165,7 @@ static int stmmac_init_phy(struct net_device *dev)
>  	/* Some DT bindings do not set-up the PHY handle. Let's try to
>  	 * manually parse it
>  	 */
> -	if (!phy_fwnode || IS_ERR(phy_fwnode)) {
> +	if (IS_ERR_OR_NULL(phy_fwnode)) {
>  		int addr = priv->plat->phy_addr;
>  		struct phy_device *phydev;

Up to the stmmac maintainers, but I have never been a fan of
"IS_ERR_OR_NULL" because it leads to programming errors such as
those I pointed out in your changes to I2C drivers. I would
much rather see IS_ERR_OR_NULL removed from the kernel entirely.
That is my personal opinion.

In this case, it doesn't matter because we're not returning the
phy_fwnode error, we're detecting it and taking some alternative
action - but given my inherent dislike of IS_ERR_OR_NULL, I
prefer the original.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

