Return-Path: <netdev+bounces-47387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4204D7E9FBA
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 16:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FE81F217F6
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D732135D;
	Mon, 13 Nov 2023 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po/f9ni5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64B2111C
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:16:54 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2ECA4
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 07:16:49 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso6453986e87.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 07:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699888608; x=1700493408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODtohJi+oqugtzRpgh+SsTgBSls7jnphzzpmH1WaUyk=;
        b=Po/f9ni5jcoqjHrGPV6WIZcCblenVeCT47juOg8lodjZ72plRFA1b5QBg6oGdxbM6f
         ip3Pclkl0CbaNEFYrt2kFh8wn1zYi01bG4kQgTH1c0HJy+i/jMoMU4dQpMSLO/cwWJmG
         H+tPa9nXd64OPEiAQ9Sz47X9TAzMzvHlkLZoDC7RynNtgxYZdtY1nsJrgHhr9mFB1fff
         k4tAOQux1H84ZQTupuDhIaJd3RjecxWzLD0VJaaJG2CmsBZLIjgzBAf2LPKvPWtYvQiU
         zIxUVZsOvx/CUxr2ITM7F/H7Dtf5J/H3SzEW0vKBh2ACG2JIhTQoefHaVFaQbvU+4y24
         TNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699888608; x=1700493408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODtohJi+oqugtzRpgh+SsTgBSls7jnphzzpmH1WaUyk=;
        b=wzoXJYC5OAFPsGnl1Aelsmgppufu5TZ15182excmg/0YLao8QXPxzyysDiQ5/LRqmd
         XpW3TTFhplU6fXDcZ7BpUgMHaJbpkZBZZxm+nTxP+0oI7ONhludZuf5OhxHz808/OGma
         Vx9651PskUMYHXYlRV4F60RDvmLioF4/9xDTD4hCLUkGUvYw3E21F/keecozenzXcUJf
         vjAh9kkzH5rJ/r7hlUlFMvLhe1c2psRfAiSyHXO22NP5lcdxFLi9tav+5LVmNXqZZ7Vw
         2HzIzKUJFmgS0jkqRSYzuIkgDmqU5T0WbjWmgWdgAnpiSzwZw+Lu/DYtouxAfB//5IiG
         kEEg==
X-Gm-Message-State: AOJu0Yyquax2SvX+iVTXE1oJ9vRp+8V55A/ZK2lpH+PyX+d5uSVN7fM0
	Pw9EJh8onyYAHjf7S9lb0W0=
X-Google-Smtp-Source: AGHT+IEI4msBs2H15qWci18ol5loxYJYyZr797Y3UvcBxmaLoAuO9iNGAoIq5WYY7oIpMdpHp2rIHw==
X-Received: by 2002:a19:2d4b:0:b0:507:9787:6776 with SMTP id t11-20020a192d4b000000b0050797876776mr4986066lft.5.1699888607079;
        Mon, 13 Nov 2023 07:16:47 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id be20-20020a056512251400b00507f0d2b32bsm1004285lfb.249.2023.11.13.07.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 07:16:45 -0800 (PST)
Date: Mon, 13 Nov 2023 18:16:43 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, loongarch@lists.linux.dev, 
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v5 1/9] net: stmmac: Pass stmmac_priv and chan in some
 callbacks
Message-ID: <tpivulfth7btcmwej5ymyvvjzanlbmkvarzzdsivkmnp7omgmy@vuf33qnmcepf>
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <5d1a11cc016c88c0e8b33489d020c6b6358e2dc7.1699533745.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d1a11cc016c88c0e8b33489d020c6b6358e2dc7.1699533745.git.siyanteng@loongson.cn>

On Fri, Nov 10, 2023 at 05:23:18PM +0800, Yanteng Si wrote:
> Loongson GMAC and GNET have some special features. To prepare for that,
> pass stmmac_priv and chan to more callbacks, and adjust the callbacks
> accordingly.

I might have missed something, but I failed to see why you need the
most of these changes. At the very least your implementation doesn't
require the prototypes being converted to accepting the stmmac_priv
pointer. Please drop all of such redundant changes and leave only the
required one. AFAICS based on the further patches the only required
are the channel ID arguments.

-Serge(y)

> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  .../net/ethernet/stmicro/stmmac/chain_mode.c  |  5 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 22 +++---
>  .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  9 ++-
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  8 ++-
>  .../ethernet/stmicro/stmmac/dwmac100_core.c   |  9 ++-
>  .../ethernet/stmicro/stmmac/dwmac100_dma.c    |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 11 +--
>  .../ethernet/stmicro/stmmac/dwmac4_descs.c    | 17 ++---
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  8 ++-
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  5 +-
>  .../net/ethernet/stmicro/stmmac/dwmac_lib.c   |  5 +-
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 11 +--
>  .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  | 17 ++---
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 10 +--
>  .../net/ethernet/stmicro/stmmac/enh_desc.c    | 17 ++---
>  drivers/net/ethernet/stmicro/stmmac/hwif.c    |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    | 71 ++++++++++---------
>  .../net/ethernet/stmicro/stmmac/norm_desc.c   | 17 ++---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  6 +-
>  21 files changed, 146 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> index fb55efd52240..a95866871f3e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> @@ -95,8 +95,9 @@ static unsigned int is_jumbo_frm(int len, int enh_desc)
>  	return ret;
>  }
>  
> -static void init_dma_chain(void *des, dma_addr_t phy_addr,
> -				  unsigned int size, unsigned int extend_desc)
> +static void init_dma_chain(struct stmmac_priv *priv, void *des,
> +			   dma_addr_t phy_addr, unsigned int size,
> +			   unsigned int extend_desc)
>  {
>  	/*
>  	 * In chained mode the des3 points to the next element in the ring.
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 137741b94122..2d3f0848cacb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -283,7 +283,7 @@ static const struct emac_variant emac_variant_h6 = {
>  /* sun8i_dwmac_dma_reset() - reset the EMAC
>   * Called from stmmac via stmmac_dma_ops->reset
>   */
> -static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
> +static int sun8i_dwmac_dma_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
>  {
>  	writel(0, ioaddr + EMAC_RX_CTL1);
>  	writel(0, ioaddr + EMAC_TX_CTL1);
> @@ -298,7 +298,7 @@ static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
>  /* sun8i_dwmac_dma_init() - initialize the EMAC
>   * Called from stmmac via stmmac_dma_ops->init
>   */
> -static void sun8i_dwmac_dma_init(void __iomem *ioaddr,
> +static void sun8i_dwmac_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>  				 struct stmmac_dma_cfg *dma_cfg, int atds)
>  {
>  	writel(EMAC_RX_INT | EMAC_TX_INT, ioaddr + EMAC_INT_EN);
> @@ -395,7 +395,8 @@ static void sun8i_dwmac_dma_start_tx(struct stmmac_priv *priv,
>  	writel(v, ioaddr + EMAC_TX_CTL1);
>  }
>  
> -static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
> +static void sun8i_dwmac_enable_dma_transmission(struct stmmac_priv *priv,
> +						void __iomem *ioaddr, u32 chan)
>  {
>  	u32 v;
>  
> @@ -643,7 +644,8 @@ static void sun8i_dwmac_set_mac(void __iomem *ioaddr, bool enable)
>   * All slot > 0 need to be enabled with MAC_ADDR_TYPE_DST
>   * If addr is NULL, clear the slot
>   */
> -static void sun8i_dwmac_set_umac_addr(struct mac_device_info *hw,
> +static void sun8i_dwmac_set_umac_addr(struct stmmac_priv *priv,
> +				      struct mac_device_info *hw,
>  				      const unsigned char *addr,
>  				      unsigned int reg_n)
>  {
> @@ -664,7 +666,8 @@ static void sun8i_dwmac_set_umac_addr(struct mac_device_info *hw,
>  	}
>  }
>  
> -static void sun8i_dwmac_get_umac_addr(struct mac_device_info *hw,
> +static void sun8i_dwmac_get_umac_addr(struct stmmac_priv *priv,
> +				      struct mac_device_info *hw,
>  				      unsigned char *addr,
>  				      unsigned int reg_n)
>  {
> @@ -687,7 +690,8 @@ static int sun8i_dwmac_rx_ipc_enable(struct mac_device_info *hw)
>  	return 1;
>  }
>  
> -static void sun8i_dwmac_set_filter(struct mac_device_info *hw,
> +static void sun8i_dwmac_set_filter(struct stmmac_priv *priv,
> +				   struct mac_device_info *hw,
>  				   struct net_device *dev)
>  {
>  	void __iomem *ioaddr = hw->pcsr;
> @@ -705,13 +709,13 @@ static void sun8i_dwmac_set_filter(struct mac_device_info *hw,
>  	} else if (macaddrs <= hw->unicast_filter_entries) {
>  		if (!netdev_mc_empty(dev)) {
>  			netdev_for_each_mc_addr(ha, dev) {
> -				sun8i_dwmac_set_umac_addr(hw, ha->addr, i);
> +				sun8i_dwmac_set_umac_addr(priv, hw, ha->addr, i);
>  				i++;
>  			}
>  		}
>  		if (!netdev_uc_empty(dev)) {
>  			netdev_for_each_uc_addr(ha, dev) {
> -				sun8i_dwmac_set_umac_addr(hw, ha->addr, i);
> +				sun8i_dwmac_set_umac_addr(priv, hw, ha->addr, i);
>  				i++;
>  			}
>  		}
> @@ -723,7 +727,7 @@ static void sun8i_dwmac_set_filter(struct mac_device_info *hw,
>  
>  	/* Disable unused address filter slots */
>  	while (i < hw->unicast_filter_entries)
> -		sun8i_dwmac_set_umac_addr(hw, NULL, i++);
> +		sun8i_dwmac_set_umac_addr(priv, hw, NULL, i++);
>  
>  	writel(v, ioaddr + EMAC_RX_FRM_FLT);
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> index 3927609abc44..b52793edf62f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> @@ -94,7 +94,8 @@ static void dwmac1000_dump_regs(struct mac_device_info *hw, u32 *reg_space)
>  		reg_space[i] = readl(ioaddr + i * 4);
>  }
>  
> -static void dwmac1000_set_umac_addr(struct mac_device_info *hw,
> +static void dwmac1000_set_umac_addr(struct stmmac_priv *priv,
> +				    struct mac_device_info *hw,
>  				    const unsigned char *addr,
>  				    unsigned int reg_n)
>  {
> @@ -103,7 +104,8 @@ static void dwmac1000_set_umac_addr(struct mac_device_info *hw,
>  			    GMAC_ADDR_LOW(reg_n));
>  }
>  
> -static void dwmac1000_get_umac_addr(struct mac_device_info *hw,
> +static void dwmac1000_get_umac_addr(struct stmmac_priv *priv,
> +				    struct mac_device_info *hw,
>  				    unsigned char *addr,
>  				    unsigned int reg_n)
>  {
> @@ -137,7 +139,8 @@ static void dwmac1000_set_mchash(void __iomem *ioaddr, u32 *mcfilterbits,
>  		       ioaddr + GMAC_EXTHASH_BASE + regs * 4);
>  }
>  
> -static void dwmac1000_set_filter(struct mac_device_info *hw,
> +static void dwmac1000_set_filter(struct stmmac_priv *priv,
> +				 struct mac_device_info *hw,
>  				 struct net_device *dev)
>  {
>  	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> index daf79cdbd3ec..ce0e6ca6f3a2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -16,7 +16,8 @@
>  #include "dwmac1000.h"
>  #include "dwmac_dma.h"
>  
> -static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
> +static void dwmac1000_dma_axi(struct stmmac_priv *priv, void __iomem *ioaddr,
> +			      struct stmmac_axi *axi)
>  {
>  	u32 value = readl(ioaddr + DMA_AXI_BUS_MODE);
>  	int i;
> @@ -70,7 +71,7 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
>  	writel(value, ioaddr + DMA_AXI_BUS_MODE);
>  }
>  
> -static void dwmac1000_dma_init(void __iomem *ioaddr,
> +static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			       struct stmmac_dma_cfg *dma_cfg, int atds)
>  {
>  	u32 value = readl(ioaddr + DMA_BUS_MODE);
> @@ -223,7 +224,8 @@ static void dwmac1000_dump_dma_regs(struct stmmac_priv *priv,
>  				readl(ioaddr + DMA_BUS_MODE + i * 4);
>  }
>  
> -static int dwmac1000_get_hw_feature(void __iomem *ioaddr,
> +static int dwmac1000_get_hw_feature(struct stmmac_priv *priv,
> +				    void __iomem *ioaddr,
>  				    struct dma_features *dma_cap)
>  {
>  	u32 hw_cap = readl(ioaddr + DMA_HW_FEATURE);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
> index a6e8d7bd9588..c03623edeb75 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
> @@ -59,7 +59,8 @@ static int dwmac100_irq_status(struct mac_device_info *hw,
>  	return 0;
>  }
>  
> -static void dwmac100_set_umac_addr(struct mac_device_info *hw,
> +static void dwmac100_set_umac_addr(struct stmmac_priv *priv,
> +				   struct mac_device_info *hw,
>  				   const unsigned char *addr,
>  				   unsigned int reg_n)
>  {
> @@ -67,7 +68,8 @@ static void dwmac100_set_umac_addr(struct mac_device_info *hw,
>  	stmmac_set_mac_addr(ioaddr, addr, MAC_ADDR_HIGH, MAC_ADDR_LOW);
>  }
>  
> -static void dwmac100_get_umac_addr(struct mac_device_info *hw,
> +static void dwmac100_get_umac_addr(struct stmmac_priv *priv,
> +				   struct mac_device_info *hw,
>  				   unsigned char *addr,
>  				   unsigned int reg_n)
>  {
> @@ -75,7 +77,8 @@ static void dwmac100_get_umac_addr(struct mac_device_info *hw,
>  	stmmac_get_mac_addr(ioaddr, addr, MAC_ADDR_HIGH, MAC_ADDR_LOW);
>  }
>  
> -static void dwmac100_set_filter(struct mac_device_info *hw,
> +static void dwmac100_set_filter(struct stmmac_priv *priv,
> +				struct mac_device_info *hw,
>  				struct net_device *dev)
>  {
>  	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> index dea270f60cc3..105e7d4d798f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
> @@ -18,7 +18,7 @@
>  #include "dwmac100.h"
>  #include "dwmac_dma.h"
>  
> -static void dwmac100_dma_init(void __iomem *ioaddr,
> +static void dwmac100_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			      struct stmmac_dma_cfg *dma_cfg, int atds)
>  {
>  	/* Enable Application Access by writing to DMA CSR0 */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index c6ff1fa0e04d..5e9b393ad7b3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> @@ -335,7 +335,8 @@ static void dwmac4_pmt(struct mac_device_info *hw, unsigned long mode)
>  	writel(pmt, ioaddr + GMAC_PMT);
>  }
>  
> -static void dwmac4_set_umac_addr(struct mac_device_info *hw,
> +static void dwmac4_set_umac_addr(struct stmmac_priv *priv,
> +				 struct mac_device_info *hw,
>  				 const unsigned char *addr, unsigned int reg_n)
>  {
>  	void __iomem *ioaddr = hw->pcsr;
> @@ -344,7 +345,8 @@ static void dwmac4_set_umac_addr(struct mac_device_info *hw,
>  				   GMAC_ADDR_LOW(reg_n));
>  }
>  
> -static void dwmac4_get_umac_addr(struct mac_device_info *hw,
> +static void dwmac4_get_umac_addr(struct stmmac_priv *priv,
> +				 struct mac_device_info *hw,
>  				 unsigned char *addr, unsigned int reg_n)
>  {
>  	void __iomem *ioaddr = hw->pcsr;
> @@ -593,7 +595,8 @@ static void dwmac4_restore_hw_vlan_rx_fltr(struct net_device *dev,
>  	}
>  }
>  
> -static void dwmac4_set_filter(struct mac_device_info *hw,
> +static void dwmac4_set_filter(struct stmmac_priv *priv,
> +			      struct mac_device_info *hw,
>  			      struct net_device *dev)
>  {
>  	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
> @@ -669,7 +672,7 @@ static void dwmac4_set_filter(struct mac_device_info *hw,
>  		int reg = 1;
>  
>  		netdev_for_each_uc_addr(ha, dev) {
> -			dwmac4_set_umac_addr(hw, ha->addr, reg);
> +			dwmac4_set_umac_addr(priv, hw, ha->addr, reg);
>  			reg++;
>  		}
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> index 89a14084c611..bd3084efc808 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> @@ -169,7 +169,7 @@ static int dwmac4_wrback_get_rx_status(struct stmmac_extra_stats *x,
>  	return ret;
>  }
>  
> -static int dwmac4_rd_get_tx_len(struct dma_desc *p)
> +static int dwmac4_rd_get_tx_len(struct stmmac_priv *priv, struct dma_desc *p)
>  {
>  	return (le32_to_cpu(p->des2) & TDES2_BUFFER1_SIZE_MASK);
>  }
> @@ -290,8 +290,8 @@ static int dwmac4_wrback_get_rx_timestamp_status(void *desc, void *next_desc,
>  	return 0;
>  }
>  
> -static void dwmac4_rd_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
> -				   int mode, int end, int bfsize)
> +static void dwmac4_rd_init_rx_desc(struct stmmac_priv *priv, struct dma_desc *p,
> +				   int disable_rx_ic, int mode, int end, int bfsize)
>  {
>  	dwmac4_set_rx_owner(p, disable_rx_ic);
>  }
> @@ -304,9 +304,9 @@ static void dwmac4_rd_init_tx_desc(struct dma_desc *p, int mode, int end)
>  	p->des3 = 0;
>  }
>  
> -static void dwmac4_rd_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
> -				      bool csum_flag, int mode, bool tx_own,
> -				      bool ls, unsigned int tot_pkt_len)
> +static void dwmac4_rd_prepare_tx_desc(struct stmmac_priv *priv, struct dma_desc *p,
> +				      int is_fs, int len, bool csum_flag, int mode,
> +				      bool tx_own, bool ls, unsigned int tot_pkt_len)
>  {
>  	unsigned int tdes3 = le32_to_cpu(p->des3);
>  
> @@ -456,13 +456,14 @@ static void dwmac4_set_mss_ctxt(struct dma_desc *p, unsigned int mss)
>  	p->des3 = cpu_to_le32(TDES3_CONTEXT_TYPE | TDES3_CTXT_TCMSSV);
>  }
>  
> -static void dwmac4_set_addr(struct dma_desc *p, dma_addr_t addr)
> +static void dwmac4_set_addr(struct stmmac_priv *priv, struct dma_desc *p,
> +			    dma_addr_t addr)
>  {
>  	p->des0 = cpu_to_le32(lower_32_bits(addr));
>  	p->des1 = cpu_to_le32(upper_32_bits(addr));
>  }
>  
> -static void dwmac4_clear(struct dma_desc *p)
> +static void dwmac4_clear(struct stmmac_priv *priv, struct dma_desc *p)
>  {
>  	p->des0 = 0;
>  	p->des1 = 0;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index 84d3a8551b03..97dad00dc850 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -15,7 +15,8 @@
>  #include "dwmac4_dma.h"
>  #include "stmmac.h"
>  
> -static void dwmac4_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
> +static void dwmac4_dma_axi(struct stmmac_priv *priv, void __iomem *ioaddr,
> +			   struct stmmac_axi *axi)
>  {
>  	u32 value = readl(ioaddr + DMA_SYS_BUS_MODE);
>  	int i;
> @@ -152,7 +153,7 @@ static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
>  	       ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
>  }
>  
> -static void dwmac4_dma_init(void __iomem *ioaddr,
> +static void dwmac4_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			    struct stmmac_dma_cfg *dma_cfg, int atds)
>  {
>  	u32 value = readl(ioaddr + DMA_SYS_BUS_MODE);
> @@ -374,7 +375,8 @@ static void dwmac4_dma_tx_chan_op_mode(struct stmmac_priv *priv,
>  	writel(mtl_tx_op, ioaddr +  MTL_CHAN_TX_OP_MODE(dwmac4_addrs, channel));
>  }
>  
> -static int dwmac4_get_hw_feature(void __iomem *ioaddr,
> +static int dwmac4_get_hw_feature(struct stmmac_priv *priv,
> +				 void __iomem *ioaddr,
>  				 struct dma_features *dma_cap)
>  {
>  	u32 hw_cap = readl(ioaddr + GMAC_HW_FEATURE0);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> index 358e7dcb6a9a..aaab5ab38373 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> @@ -231,7 +231,7 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
>  #define DMA_CHAN0_DBG_STAT_RPS		GENMASK(11, 8)
>  #define DMA_CHAN0_DBG_STAT_RPS_SHIFT	8
>  
> -int dwmac4_dma_reset(void __iomem *ioaddr);
> +int dwmac4_dma_reset(struct stmmac_priv *priv, void __iomem *ioaddr);
>  void dwmac4_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			   u32 chan, bool rx, bool tx);
>  void dwmac410_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
> index 9470d3fd2ded..1191f0c1d7f1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
> @@ -13,7 +13,7 @@
>  #include "dwmac4.h"
>  #include "stmmac.h"
>  
> -int dwmac4_dma_reset(void __iomem *ioaddr)
> +int dwmac4_dma_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
>  {
>  	u32 value = readl(ioaddr + DMA_BUS_MODE);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> index 72672391675f..77141391bd2f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> @@ -152,7 +152,8 @@
>  #define NUM_DWMAC1000_DMA_REGS	23
>  #define NUM_DWMAC4_DMA_REGS	27
>  
> -void dwmac_enable_dma_transmission(void __iomem *ioaddr);
> +void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
> +				   void __iomem *ioaddr, u32 chan);
>  void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			  u32 chan, bool rx, bool tx);
>  void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -167,6 +168,6 @@ void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
>  		       u32 chan);
>  int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			struct stmmac_extra_stats *x, u32 chan, u32 dir);
> -int dwmac_dma_reset(void __iomem *ioaddr);
> +int dwmac_dma_reset(struct stmmac_priv *priv, void __iomem *ioaddr);
>  
>  #endif /* __DWMAC_DMA_H__ */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> index 7907d62d3437..0cb337ffb7ac 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> @@ -14,7 +14,7 @@
>  
>  #define GMAC_HI_REG_AE		0x80000000
>  
> -int dwmac_dma_reset(void __iomem *ioaddr)
> +int dwmac_dma_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
>  {
>  	u32 value = readl(ioaddr + DMA_BUS_MODE);
>  
> @@ -28,7 +28,8 @@ int dwmac_dma_reset(void __iomem *ioaddr)
>  }
>  
>  /* CSR1 enables the transmit DMA to check for new descriptor */
> -void dwmac_enable_dma_transmission(void __iomem *ioaddr)
> +void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
> +				   void __iomem *ioaddr, u32 chan)
>  {
>  	writel(1, ioaddr + DMA_XMT_POLL_DEMAND);
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 453e88b75be0..a993591e05bd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -375,7 +375,8 @@ static void dwxgmac2_pmt(struct mac_device_info *hw, unsigned long mode)
>  	writel(val, ioaddr + XGMAC_PMT);
>  }
>  
> -static void dwxgmac2_set_umac_addr(struct mac_device_info *hw,
> +static void dwxgmac2_set_umac_addr(struct stmmac_priv *priv,
> +				   struct mac_device_info *hw,
>  				   const unsigned char *addr,
>  				   unsigned int reg_n)
>  {
> @@ -389,7 +390,8 @@ static void dwxgmac2_set_umac_addr(struct mac_device_info *hw,
>  	writel(value, ioaddr + XGMAC_ADDRx_LOW(reg_n));
>  }
>  
> -static void dwxgmac2_get_umac_addr(struct mac_device_info *hw,
> +static void dwxgmac2_get_umac_addr(struct stmmac_priv *priv,
> +				   struct mac_device_info *hw,
>  				   unsigned char *addr, unsigned int reg_n)
>  {
>  	void __iomem *ioaddr = hw->pcsr;
> @@ -478,7 +480,8 @@ static void dwxgmac2_set_mchash(void __iomem *ioaddr, u32 *mcfilterbits,
>  		writel(mcfilterbits[regs], ioaddr + XGMAC_HASH_TABLE(regs));
>  }
>  
> -static void dwxgmac2_set_filter(struct mac_device_info *hw,
> +static void dwxgmac2_set_filter(struct stmmac_priv *priv,
> +				struct mac_device_info *hw,
>  				struct net_device *dev)
>  {
>  	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
> @@ -523,7 +526,7 @@ static void dwxgmac2_set_filter(struct mac_device_info *hw,
>  		int reg = 1;
>  
>  		netdev_for_each_uc_addr(ha, dev) {
> -			dwxgmac2_set_umac_addr(hw, ha->addr, reg);
> +			dwxgmac2_set_umac_addr(priv, hw, ha->addr, reg);
>  			reg++;
>  		}
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> index fc82862a612c..cefcbabab2c0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> @@ -39,7 +39,7 @@ static int dwxgmac2_get_rx_status(struct stmmac_extra_stats *x,
>  	return good_frame;
>  }
>  
> -static int dwxgmac2_get_tx_len(struct dma_desc *p)
> +static int dwxgmac2_get_tx_len(struct stmmac_priv *priv, struct dma_desc *p)
>  {
>  	return (le32_to_cpu(p->des2) & XGMAC_TDES2_B1L);
>  }
> @@ -126,8 +126,8 @@ static int dwxgmac2_get_rx_timestamp_status(void *desc, void *next_desc,
>  	return !ret;
>  }
>  
> -static void dwxgmac2_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
> -				  int mode, int end, int bfsize)
> +static void dwxgmac2_init_rx_desc(struct stmmac_priv *priv, struct dma_desc *p,
> +				  int disable_rx_ic, int mode, int end, int bfsize)
>  {
>  	dwxgmac2_set_rx_owner(p, disable_rx_ic);
>  }
> @@ -140,9 +140,9 @@ static void dwxgmac2_init_tx_desc(struct dma_desc *p, int mode, int end)
>  	p->des3 = 0;
>  }
>  
> -static void dwxgmac2_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
> -				     bool csum_flag, int mode, bool tx_own,
> -				     bool ls, unsigned int tot_pkt_len)
> +static void dwxgmac2_prepare_tx_desc(struct stmmac_priv *priv, struct dma_desc *p,
> +				     int is_fs, int len, bool csum_flag, int mode,
> +				     bool tx_own, bool ls, unsigned int tot_pkt_len)
>  {
>  	unsigned int tdes3 = le32_to_cpu(p->des3);
>  
> @@ -239,13 +239,14 @@ static void dwxgmac2_set_mss(struct dma_desc *p, unsigned int mss)
>  	p->des3 = cpu_to_le32(XGMAC_TDES3_CTXT | XGMAC_TDES3_TCMSSV);
>  }
>  
> -static void dwxgmac2_set_addr(struct dma_desc *p, dma_addr_t addr)
> +static void dwxgmac2_set_addr(struct stmmac_priv *priv, struct dma_desc *p,
> +			      dma_addr_t addr)
>  {
>  	p->des0 = cpu_to_le32(lower_32_bits(addr));
>  	p->des1 = cpu_to_le32(upper_32_bits(addr));
>  }
>  
> -static void dwxgmac2_clear(struct dma_desc *p)
> +static void dwxgmac2_clear(struct stmmac_priv *priv, struct dma_desc *p)
>  {
>  	p->des0 = 0;
>  	p->des1 = 0;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index 3cde695fec91..4d1dc6d7eacb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -8,7 +8,7 @@
>  #include "stmmac.h"
>  #include "dwxgmac2.h"
>  
> -static int dwxgmac2_dma_reset(void __iomem *ioaddr)
> +static int dwxgmac2_dma_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
>  {
>  	u32 value = readl(ioaddr + XGMAC_DMA_MODE);
>  
> @@ -19,7 +19,7 @@ static int dwxgmac2_dma_reset(void __iomem *ioaddr)
>  				  !(value & XGMAC_SWR), 0, 100000);
>  }
>  
> -static void dwxgmac2_dma_init(void __iomem *ioaddr,
> +static void dwxgmac2_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			      struct stmmac_dma_cfg *dma_cfg, int atds)
>  {
>  	u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
> @@ -81,7 +81,8 @@ static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
>  	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
>  }
>  
> -static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
> +static void dwxgmac2_dma_axi(struct stmmac_priv *priv, void __iomem *ioaddr,
> +			     struct stmmac_axi *axi)
>  {
>  	u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
>  	int i;
> @@ -386,7 +387,8 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
>  	return ret;
>  }
>  
> -static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
> +static int dwxgmac2_get_hw_feature(struct stmmac_priv *priv,
> +				   void __iomem *ioaddr,
>  				   struct dma_features *dma_cap)
>  {
>  	u32 hw_cap;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> index 937b7a0466fc..43ae8c7defe1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> @@ -76,7 +76,7 @@ static int enh_desc_get_tx_status(struct stmmac_extra_stats *x,
>  	return ret;
>  }
>  
> -static int enh_desc_get_tx_len(struct dma_desc *p)
> +static int enh_desc_get_tx_len(struct stmmac_priv *priv, struct dma_desc *p)
>  {
>  	return (le32_to_cpu(p->des1) & ETDES1_BUFFER1_SIZE_MASK);
>  }
> @@ -249,8 +249,8 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
>  	return ret;
>  }
>  
> -static void enh_desc_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
> -				  int mode, int end, int bfsize)
> +static void enh_desc_init_rx_desc(struct stmmac_priv *priv, struct dma_desc *p,
> +				  int disable_rx_ic, int mode, int end, int bfsize)
>  {
>  	int bfsize1;
>  
> @@ -308,9 +308,9 @@ static void enh_desc_release_tx_desc(struct dma_desc *p, int mode)
>  		enh_desc_end_tx_desc_on_ring(p, ter);
>  }
>  
> -static void enh_desc_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
> -				     bool csum_flag, int mode, bool tx_own,
> -				     bool ls, unsigned int tot_pkt_len)
> +static void enh_desc_prepare_tx_desc(struct stmmac_priv *priv, struct dma_desc *p,
> +				     int is_fs, int len, bool csum_flag, int mode,
> +				     bool tx_own, bool ls, unsigned int tot_pkt_len)
>  {
>  	unsigned int tdes0 = le32_to_cpu(p->des0);
>  
> @@ -435,12 +435,13 @@ static void enh_desc_display_ring(void *head, unsigned int size, bool rx,
>  	pr_info("\n");
>  }
>  
> -static void enh_desc_set_addr(struct dma_desc *p, dma_addr_t addr)
> +static void enh_desc_set_addr(struct stmmac_priv *priv, struct dma_desc *p,
> +			      dma_addr_t addr)
>  {
>  	p->des2 = cpu_to_le32(addr);
>  }
>  
> -static void enh_desc_clear(struct dma_desc *p)
> +static void enh_desc_clear(struct stmmac_priv *priv, struct dma_desc *p)
>  {
>  	p->des2 = 0;
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index b8ba8f2d8041..93cead5613e3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -97,7 +97,7 @@ int stmmac_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
>  	if (plat && plat->fix_soc_reset)
>  		return plat->fix_soc_reset(plat, ioaddr);
>  
> -	return stmmac_do_callback(priv, dma, reset, ioaddr);
> +	return stmmac_do_callback(priv, dma, reset, priv, ioaddr);
>  }
>  
>  static const struct stmmac_hwif_entry {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index b95d3e137813..fd63713fcaa1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -35,14 +35,14 @@ struct dma_edesc;
>  /* Descriptors helpers */
>  struct stmmac_desc_ops {
>  	/* DMA RX descriptor ring initialization */
> -	void (*init_rx_desc)(struct dma_desc *p, int disable_rx_ic, int mode,
> -			int end, int bfsize);
> +	void (*init_rx_desc)(struct stmmac_priv *priv, struct dma_desc *p,
> +			int disable_rx_ic, int mode, int end, int bfsize);
>  	/* DMA TX descriptor ring initialization */
>  	void (*init_tx_desc)(struct dma_desc *p, int mode, int end);
>  	/* Invoked by the xmit function to prepare the tx descriptor */
> -	void (*prepare_tx_desc)(struct dma_desc *p, int is_fs, int len,
> -			bool csum_flag, int mode, bool tx_own, bool ls,
> -			unsigned int tot_pkt_len);
> +	void (*prepare_tx_desc)(struct stmmac_priv *priv, struct dma_desc *p,
> +			int is_fs, int len, bool csum_flag, int mode,
> +			bool tx_own, bool ls, unsigned int tot_pkt_len);
>  	void (*prepare_tso_tx_desc)(struct dma_desc *p, int is_fs, int len1,
>  			int len2, bool tx_own, bool ls, unsigned int tcphdrlen,
>  			unsigned int tcppayloadlen);
> @@ -60,7 +60,7 @@ struct stmmac_desc_ops {
>  	int (*tx_status)(struct stmmac_extra_stats *x,
>  			 struct dma_desc *p, void __iomem *ioaddr);
>  	/* Get the buffer size from the descriptor */
> -	int (*get_tx_len)(struct dma_desc *p);
> +	int (*get_tx_len)(struct stmmac_priv *priv, struct dma_desc *p);
>  	/* Handle extra events on specific interrupts hw dependent */
>  	void (*set_rx_owner)(struct dma_desc *p, int disable_rx_ic);
>  	/* Get the receive frame size */
> @@ -84,9 +84,10 @@ struct stmmac_desc_ops {
>  	/* set MSS via context descriptor */
>  	void (*set_mss)(struct dma_desc *p, unsigned int mss);
>  	/* set descriptor skbuff address */
> -	void (*set_addr)(struct dma_desc *p, dma_addr_t addr);
> +	void (*set_addr)(struct stmmac_priv *priv, struct dma_desc *p,
> +			dma_addr_t addr);
>  	/* clear descriptor */
> -	void (*clear)(struct dma_desc *p);
> +	void (*clear)(struct stmmac_priv *priv, struct dma_desc *p);
>  	/* RSS */
>  	int (*get_rx_hash)(struct dma_desc *p, u32 *hash,
>  			   enum pkt_hash_types *type);
> @@ -100,11 +101,11 @@ struct stmmac_desc_ops {
>  };
>  
>  #define stmmac_init_rx_desc(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, desc, init_rx_desc, __args)
> +	stmmac_do_void_callback(__priv, desc, init_rx_desc, __priv, __args)
>  #define stmmac_init_tx_desc(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, desc, init_tx_desc, __args)
>  #define stmmac_prepare_tx_desc(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, desc, prepare_tx_desc, __args)
> +	stmmac_do_void_callback(__priv, desc, prepare_tx_desc, __priv, __args)
>  #define stmmac_prepare_tso_tx_desc(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, desc, prepare_tso_tx_desc, __args)
>  #define stmmac_set_tx_owner(__priv, __args...) \
> @@ -120,7 +121,7 @@ struct stmmac_desc_ops {
>  #define stmmac_tx_status(__priv, __args...) \
>  	stmmac_do_callback(__priv, desc, tx_status, __args)
>  #define stmmac_get_tx_len(__priv, __args...) \
> -	stmmac_do_callback(__priv, desc, get_tx_len, __args)
> +	stmmac_do_callback(__priv, desc, get_tx_len, __priv, __args)
>  #define stmmac_set_rx_owner(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, desc, set_rx_owner, __args)
>  #define stmmac_get_rx_frame_len(__priv, __args...) \
> @@ -142,9 +143,9 @@ struct stmmac_desc_ops {
>  #define stmmac_set_mss(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, desc, set_mss, __args)
>  #define stmmac_set_desc_addr(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, desc, set_addr, __args)
> +	stmmac_do_void_callback(__priv, desc, set_addr, __priv, __args)
>  #define stmmac_clear_desc(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, desc, clear, __args)
> +	stmmac_do_void_callback(__priv, desc, clear, __priv, __args)
>  #define stmmac_get_rx_hash(__priv, __args...) \
>  	stmmac_do_callback(__priv, desc, get_rx_hash, __args)
>  #define stmmac_get_rx_header_len(__priv, __args...) \
> @@ -166,9 +167,9 @@ struct dma_features;
>  /* Specific DMA helpers */
>  struct stmmac_dma_ops {
>  	/* DMA core initialization */
> -	int (*reset)(void __iomem *ioaddr);
> -	void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg,
> -		     int atds);
> +	int (*reset)(struct stmmac_priv *priv, void __iomem *ioaddr);
> +	void (*init)(struct stmmac_priv *priv, void __iomem *ioaddr,
> +		     struct stmmac_dma_cfg *dma_cfg, int atds);
>  	void (*init_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			  struct stmmac_dma_cfg *dma_cfg, u32 chan);
>  	void (*init_rx_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -178,7 +179,8 @@ struct stmmac_dma_ops {
>  			     struct stmmac_dma_cfg *dma_cfg,
>  			     dma_addr_t phy, u32 chan);
>  	/* Configure the AXI Bus Mode Register */
> -	void (*axi)(void __iomem *ioaddr, struct stmmac_axi *axi);
> +	void (*axi)(struct stmmac_priv *priv, void __iomem *ioaddr,
> +		    struct stmmac_axi *axi);
>  	/* Dump DMA registers */
>  	void (*dump_regs)(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			  u32 *reg_space);
> @@ -190,7 +192,8 @@ struct stmmac_dma_ops {
>  	/* To track extra statistic (if supported) */
>  	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
>  				  void __iomem *ioaddr);
> -	void (*enable_dma_transmission) (void __iomem *ioaddr);
> +	void (*enable_dma_transmission)(struct stmmac_priv *priv,
> +					void __iomem *ioaddr, u32 chan);
>  	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			       u32 chan, bool rx, bool tx);
>  	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -206,7 +209,7 @@ struct stmmac_dma_ops {
>  	int (*dma_interrupt)(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			     struct stmmac_extra_stats *x, u32 chan, u32 dir);
>  	/* If supported then get the optional core features */
> -	int (*get_hw_feature)(void __iomem *ioaddr,
> +	int (*get_hw_feature)(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			      struct dma_features *dma_cap);
>  	/* Program the HW RX Watchdog */
>  	void (*rx_watchdog)(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -232,7 +235,7 @@ struct stmmac_dma_ops {
>  };
>  
>  #define stmmac_dma_init(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, dma, init, __args)
> +	stmmac_do_void_callback(__priv, dma, init, __priv, __args)
>  #define stmmac_init_chan(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, dma, init_chan, __priv, __args)
>  #define stmmac_init_rx_chan(__priv, __args...) \
> @@ -240,7 +243,7 @@ struct stmmac_dma_ops {
>  #define stmmac_init_tx_chan(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, dma, init_tx_chan, __priv, __args)
>  #define stmmac_axi(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, dma, axi, __args)
> +	stmmac_do_void_callback(__priv, dma, axi, __priv, __args)
>  #define stmmac_dump_dma_regs(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, dma, dump_regs, __priv, __args)
>  #define stmmac_dma_rx_mode(__priv, __args...) \
> @@ -250,7 +253,7 @@ struct stmmac_dma_ops {
>  #define stmmac_dma_diagnostic_fr(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, dma, dma_diagnostic_fr, __args)
>  #define stmmac_enable_dma_transmission(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __args)
> +	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __priv, __args)
>  #define stmmac_enable_dma_irq(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, dma, enable_dma_irq, __priv, __args)
>  #define stmmac_disable_dma_irq(__priv, __args...) \
> @@ -266,7 +269,7 @@ struct stmmac_dma_ops {
>  #define stmmac_dma_interrupt_status(__priv, __args...) \
>  	stmmac_do_callback(__priv, dma, dma_interrupt, __priv, __args)
>  #define stmmac_get_hw_feature(__priv, __args...) \
> -	stmmac_do_callback(__priv, dma, get_hw_feature, __args)
> +	stmmac_do_callback(__priv, dma, get_hw_feature, __priv, __args)
>  #define stmmac_rx_watchdog(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, dma, rx_watchdog, __priv, __args)
>  #define stmmac_set_tx_ring_len(__priv, __args...) \
> @@ -338,17 +341,21 @@ struct stmmac_ops {
>  	int (*host_mtl_irq_status)(struct stmmac_priv *priv,
>  				   struct mac_device_info *hw, u32 chan);
>  	/* Multicast filter setting */
> -	void (*set_filter)(struct mac_device_info *hw, struct net_device *dev);
> +	void (*set_filter)(struct stmmac_priv *priv, struct mac_device_info *hw,
> +			   struct net_device *dev);
>  	/* Flow control setting */
>  	void (*flow_ctrl)(struct mac_device_info *hw, unsigned int duplex,
>  			  unsigned int fc, unsigned int pause_time, u32 tx_cnt);
>  	/* Set power management mode (e.g. magic frame) */
>  	void (*pmt)(struct mac_device_info *hw, unsigned long mode);
>  	/* Set/Get Unicast MAC addresses */
> -	void (*set_umac_addr)(struct mac_device_info *hw,
> +	void (*set_umac_addr)(struct stmmac_priv *priv,
> +			      struct mac_device_info *hw,
>  			      const unsigned char *addr,
>  			      unsigned int reg_n);
> -	void (*get_umac_addr)(struct mac_device_info *hw, unsigned char *addr,
> +	void (*get_umac_addr)(struct stmmac_priv *priv,
> +			      struct mac_device_info *hw,
> +			      unsigned char *addr,
>  			      unsigned int reg_n);
>  	void (*set_eee_mode)(struct mac_device_info *hw,
>  			     bool en_tx_lpi_clockgating);
> @@ -452,15 +459,15 @@ struct stmmac_ops {
>  #define stmmac_host_mtl_irq_status(__priv, __args...) \
>  	stmmac_do_callback(__priv, mac, host_mtl_irq_status, __priv, __args)
>  #define stmmac_set_filter(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, mac, set_filter, __args)
> +	stmmac_do_void_callback(__priv, mac, set_filter, __priv, __args)
>  #define stmmac_flow_ctrl(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, mac, flow_ctrl, __args)
>  #define stmmac_pmt(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, mac, pmt, __args)
>  #define stmmac_set_umac_addr(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, mac, set_umac_addr, __args)
> +	stmmac_do_void_callback(__priv, mac, set_umac_addr, __priv, __args)
>  #define stmmac_get_umac_addr(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, mac, get_umac_addr, __args)
> +	stmmac_do_void_callback(__priv, mac, get_umac_addr, __priv, __args)
>  #define stmmac_set_eee_mode(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, mac, set_eee_mode, __args)
>  #define stmmac_reset_eee_mode(__priv, __args...) \
> @@ -563,8 +570,8 @@ struct stmmac_rx_queue;
>  
>  /* Helpers to manage the descriptors for chain and ring modes */
>  struct stmmac_mode_ops {
> -	void (*init) (void *des, dma_addr_t phy_addr, unsigned int size,
> -		      unsigned int extend_desc);
> +	void (*init)(struct stmmac_priv *priv, void *des, dma_addr_t phy_addr,
> +		      unsigned int size, unsigned int extend_desc);
>  	unsigned int (*is_jumbo_frm) (int len, int ehn_desc);
>  	int (*jumbo_frm)(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
>  			 int csum);
> @@ -575,7 +582,7 @@ struct stmmac_mode_ops {
>  };
>  
>  #define stmmac_mode_init(__priv, __args...) \
> -	stmmac_do_void_callback(__priv, mode, init, __args)
> +	stmmac_do_void_callback(__priv, mode, init, __priv, __args)
>  #define stmmac_is_jumbo_frm(__priv, __args...) \
>  	stmmac_do_callback(__priv, mode, is_jumbo_frm, __args)
>  #define stmmac_jumbo_frm(__priv, __args...) \
> diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
> index 68a7cfcb1d8f..5fb3103db5cd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
> @@ -57,7 +57,7 @@ static int ndesc_get_tx_status(struct stmmac_extra_stats *x,
>  	return ret;
>  }
>  
> -static int ndesc_get_tx_len(struct dma_desc *p)
> +static int ndesc_get_tx_len(struct stmmac_priv *priv, struct dma_desc *p)
>  {
>  	return (le32_to_cpu(p->des1) & RDES1_BUFFER1_SIZE_MASK);
>  }
> @@ -115,8 +115,8 @@ static int ndesc_get_rx_status(struct stmmac_extra_stats *x,
>  	return ret;
>  }
>  
> -static void ndesc_init_rx_desc(struct dma_desc *p, int disable_rx_ic, int mode,
> -			       int end, int bfsize)
> +static void ndesc_init_rx_desc(struct stmmac_priv *priv, struct dma_desc *p,
> +			       int disable_rx_ic, int mode, int end, int bfsize)
>  {
>  	int bfsize1;
>  
> @@ -174,9 +174,9 @@ static void ndesc_release_tx_desc(struct dma_desc *p, int mode)
>  		ndesc_end_tx_desc_on_ring(p, ter);
>  }
>  
> -static void ndesc_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
> -				  bool csum_flag, int mode, bool tx_own,
> -				  bool ls, unsigned int tot_pkt_len)
> +static void ndesc_prepare_tx_desc(struct stmmac_priv *priv, struct dma_desc *p,
> +				  int is_fs, int len, bool csum_flag, int mode,
> +				  bool tx_own, bool ls, unsigned int tot_pkt_len)
>  {
>  	unsigned int tdes1 = le32_to_cpu(p->des1);
>  
> @@ -285,12 +285,13 @@ static void ndesc_display_ring(void *head, unsigned int size, bool rx,
>  	pr_info("\n");
>  }
>  
> -static void ndesc_set_addr(struct dma_desc *p, dma_addr_t addr)
> +static void ndesc_set_addr(struct stmmac_priv *priv, struct dma_desc *p,
> +			   dma_addr_t addr)
>  {
>  	p->des2 = cpu_to_le32(addr);
>  }
>  
> -static void ndesc_clear(struct dma_desc *p)
> +static void ndesc_clear(struct stmmac_priv *priv, struct dma_desc *p)
>  {
>  	p->des2 = 0;
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3e50fd53a617..132d4f679b95 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2509,7 +2509,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  				       true, priv->mode, true, true,
>  				       xdp_desc.len);
>  
> -		stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
>  		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
>  		entry = tx_q->cur_tx;
> @@ -4615,7 +4615,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
>  
> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
>  	stmmac_flush_tx_descriptors(priv, queue);
>  	stmmac_tx_timer_arm(priv, queue);
> @@ -4835,7 +4835,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  		u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
>  	}
>  
> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
>  	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
>  	tx_q->cur_tx = entry;
> -- 
> 2.31.4
> 

