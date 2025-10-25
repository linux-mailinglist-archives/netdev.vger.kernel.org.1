Return-Path: <netdev+bounces-232921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1F4C09EE9
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 21:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6287F3A94BD
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED302FBE03;
	Sat, 25 Oct 2025 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OtQu4SgJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823021C1F0C;
	Sat, 25 Oct 2025 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418903; cv=none; b=Xx8dETFQbJhBJ0nqC2Vfau3O5f77f0LQVJ85p+vnYpzqgH20Im/VroDOhY7pX3IYS98obHBr3+2xFWdMbkb3W6szw10KmSFvXWqsnMAnYzGlt75mK8V85Ark5RDGCHWIrOsxv9373uWRybp8ZMybjFv4tV16l80u6/W6OKL36W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418903; c=relaxed/simple;
	bh=hNbVZXep2YBK5Q7cJJO3VrBuF2XsUBotW/LD6SQAKE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awA9cteLNmGr3NYaEGbW23VXOFzZKXqha5BS3gUvEzeR1Cka0e6pOhdKJXZOuXj4IpnMKS5bbQHVUsnPTcqlCEQdNoVXbSc7ScW3FTvqjO0eZgXckqKBDqIZyageHuPMQGm5Y7TQqEtakjbX4zZGn2NuVleCwxvUrETxGZ2oJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OtQu4SgJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8yH6ltlgzcuD/G8TQM1TvHZqwPvMaP2kB7b6YbsIeio=; b=OtQu4SgJx7r1gzbQ8ofAl/iAwM
	a3+yIOqMqAG77NWC0AZiqlrmXXqGuATnfkKhhuW+My5goCOkogktz02edZ5kMwpLjC52Zy5ArwexM
	L8H6ooolBNM8/3Z1H8mUO87ucqsJ6/O4uNaodHBctzYYR1JvxdJSlrNONCUQcXoh7eDwGc0EqbW6w
	AiNuPhnSRMM0IJogIY1CyPC3LjL+IDlG6Lw0hX/ZQy7eh8SI6Er5n4p87hA/3+gikWI1hitQCfDXJ
	G8EQaeGYfoNof8tQ+nfQD+VeZqYKOJmaNYhxIDWWhzNtV/lpFkzjs79rwv7os0e2b+j4BKnCAM9Ka
	nQVtfIww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57248)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCjVs-000000000K7-0V3V;
	Sat, 25 Oct 2025 20:01:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCjVp-000000003uC-1NV9;
	Sat, 25 Oct 2025 20:01:13 +0100
Date: Sat, 25 Oct 2025 20:01:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>, kernel@pengutronix.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Teoh Ji Sheng <ji.sheng.teoh@intel.com>
Subject: Re: [PATCH v5 02/10] net: stmmac: Use interrupt mode INTM=1 for per
 channel irq
Message-ID: <aP0eebM6ek-1fnA-@shell.armlinux.org.uk>
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
 <20251024-v6-12-topic-socfpga-agilex5-v5-2-4c4a51159eeb@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-v6-12-topic-socfpga-agilex5-v5-2-4c4a51159eeb@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 24, 2025 at 01:49:54PM +0200, Steffen Trumtrar wrote:
> From: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> 
> commit 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=1
> for multi-MSI") is introduced for platform that uses MSI.
> 
> Similar approach is taken to enable per channel interrupt
> that uses shared peripheral interrupt (SPI), so only per channel
> TX and RX intr (TI/RI) are handled by TX/RX ISR without calling
> common interrupt ISR.
> 
> TX/RX NORMAL interrupts check is now decoupled, since NIS bit
> is not asserted for any TI/RI events when INTM=1.
> 
> Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h       |  3 +++
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c   | 10 +++++++++-
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c    | 20 ++++++++++++++++++++
>  include/linux/stmmac.h                               |  2 ++
>  4 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 0d408ee17f337..64b533207e4a6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -326,6 +326,9 @@
>  /* DMA Registers */
>  #define XGMAC_DMA_MODE			0x00003000
>  #define XGMAC_SWR			BIT(0)
> +#define DMA_MODE_INTM_MASK		GENMASK(13, 12)
> +#define DMA_MODE_INTM_SHIFT		12
> +#define DMA_MODE_INTM_MODE1		0x1
>  #define XGMAC_DMA_SYSBUS_MODE		0x00003004
>  #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
>  #define XGMAC_WR_OSR_LMT_SHIFT		24
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index 4d6bb995d8d84..1e9ee1f10f0ef 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -31,6 +31,13 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
>  		value |= XGMAC_EAME;
>  
>  	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> +
> +	if (dma_cfg->multi_irq_en) {
> +		value = readl(ioaddr + XGMAC_DMA_MODE);
> +		value &= ~DMA_MODE_INTM_MASK;
> +		value |= (DMA_MODE_INTM_MODE1 << DMA_MODE_INTM_SHIFT);

No need for these parens. What is on the right hand side of |= is its
own expression and can't be interpreted any other way.

> +		writel(value, ioaddr + XGMAC_DMA_MODE);
> +	}
>  }
>  
>  static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
> @@ -359,13 +366,14 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
>  		}
>  	}
>  
> -	/* TX/RX NORMAL interrupts */
> +	/* RX NORMAL interrupts */
>  	if (likely(intr_status & XGMAC_RI)) {
>  		u64_stats_update_begin(&stats->syncp);
>  		u64_stats_inc(&stats->rx_normal_irq_n[chan]);
>  		u64_stats_update_end(&stats->syncp);
>  		ret |= handle_rx;
>  	}
> +	/* TX NORMAL interrupts */
>  	if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
>  		u64_stats_update_begin(&stats->syncp);
>  		u64_stats_inc(&stats->tx_normal_irq_n[chan]);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 27bcaae07a7f2..cfa82b8e04b94 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -607,6 +607,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  	dma_cfg->fixed_burst = of_property_read_bool(np, "snps,fixed-burst");
>  	dma_cfg->mixed_burst = of_property_read_bool(np, "snps,mixed-burst");
>  
> +	dma_cfg->multi_irq_en = of_property_read_bool(np, "snps,multi-irq-en");
> +
>  	plat->force_thresh_dma_mode = of_property_read_bool(np, "snps,force_thresh_dma_mode");
>  	if (plat->force_thresh_dma_mode && plat->force_sf_dma_mode) {
>  		plat->force_sf_dma_mode = 0;
> @@ -737,6 +739,8 @@ EXPORT_SYMBOL_GPL(stmmac_pltfr_find_clk);
>  int stmmac_get_platform_resources(struct platform_device *pdev,
>  				  struct stmmac_resources *stmmac_res)
>  {
> +	char irq_name[11];
> +	int i;
>  	memset(stmmac_res, 0, sizeof(*stmmac_res));

We normally want to see a blank line between local variable declarations
and code.

>  
>  	/* Get IRQ information early to have an ability to ask for deferred
> @@ -746,6 +750,22 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>  	if (stmmac_res->irq < 0)
>  		return stmmac_res->irq;
>  
> +	/* For RX Channel */
> +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> +		sprintf(irq_name, "%s%d", "macirq_rx", i);
> +		stmmac_res->rx_irq[i] = platform_get_irq_byname(pdev, irq_name);
> +		if (stmmac_res->rx_irq[i] < 0)
> +			break;
> +	}
> +
> +	/* For TX Channel */
> +	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
> +		sprintf(irq_name, "%s%d", "macirq_tx", i);
> +		stmmac_res->tx_irq[i] = platform_get_irq_byname(pdev, irq_name);
> +			if (stmmac_res->tx_irq[i] < 0)
> +				break;
> +	}
> +

It looks like multi-irq is a dwxgmac2 thing, should this be conditional
on (a) multi_irq_en being set, and (b) should parsing multi_irq_en be
conditional on dwxgmac2, (c) should the binding only allow
snps,multi-irq-en if a dwxgmac2 compatible is indicated?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

