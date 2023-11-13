Return-Path: <netdev+bounces-47385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5DF7E9F7E
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 16:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B44280DD1
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E72D21110;
	Mon, 13 Nov 2023 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf1mkFkB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831CC21102
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:05:22 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B891A6
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 07:05:19 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a29c7eefso6272587e87.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 07:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699887918; x=1700492718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2cFpgrmBOJSQqYgxwp7txbVebSwdERiEW01UxRU6VE=;
        b=Lf1mkFkBwYk53UBaIO+jJep1TvnsgYv/QAVKmb0cpduxXBoY1X/3mVIPXFOSIPSjxA
         dEzj8T+MVKRv3Pq5pBYIHqWU2kMvk60yPTWuUsIXk7K5IOQ2PBihlHsfVws8v8KRvjZv
         Ia2hoq70fmNeQC7U8OrguIXmzQAZu9jP28G/j09OwiT4dW63045n5/LWYtvXIdlpgUot
         oJQGRSj16DIwV9TYfwta0Q8zvkkTv5ndrv5G8H2BWKeyZJRPoS/at85uIBtidWlXsL0c
         1/ZBm0R0FTxkU5Ph/fH3/tD+xOe3ClzO9nqeQjZdzGyt1lFoYokk42l0rK8CNZuSViSO
         Q8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699887918; x=1700492718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2cFpgrmBOJSQqYgxwp7txbVebSwdERiEW01UxRU6VE=;
        b=Ci/eLY1BGUqxE9yoWSjxaKxEt76zFzEoTGzwwSSrN9/ok0FAiWJSztE+T/n0UZagqv
         ssMPUMG7HOPtCsOX+xEPkwMjFhzZYzDkGtMIuHacNG2EdmGbyz5KP7rQWu+D/Kt5sAAq
         Hc5Q5QZbk2PfimZ/FFT6myGHw0NfRgyZNlbWfo1MLM9kON7dDPLFqqTWy1YoMU7X28NP
         B+AYL3RTU9Exxcv/Q2E5I7w3Bo0TS1TMIyc+O0kUhxJMKlpZWre+sz+qKJSYSF+Kb0ly
         vSZnlg0D5Yk24J9wyWcZOevVupXOCES1SRxzD+9OxmEpIk6ZBXfKjuL1VQVmajwLY/a7
         vpQw==
X-Gm-Message-State: AOJu0Yz3GJ2xFCEhAa0Za3W7hIoMvx/1Dufo8tE5DisyCSsMo+Q9oA+K
	yU3N6g81ctUxSeGGCoa/3pA=
X-Google-Smtp-Source: AGHT+IGXgbe9Z6Uqy5O33JEBFa5OETdKRDXdcwW1oEfFHKAVvrduDpwkk7A5osUQBHe9mMy08WZYxg==
X-Received: by 2002:a05:6512:360f:b0:509:5d4b:742f with SMTP id f15-20020a056512360f00b005095d4b742fmr3970694lfs.20.1699887917543;
        Mon, 13 Nov 2023 07:05:17 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b00507b1da672bsm1002162lfc.174.2023.11.13.07.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 07:05:16 -0800 (PST)
Date: Mon, 13 Nov 2023 18:05:13 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, loongarch@lists.linux.dev, 
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v5 3/9] net: stmmac: Add Loongson DWGMAC definitions
Message-ID: <gxods3yclaqkrud6jxhvcjm67vfp5zmuoxjlr6llcddny7zwsr@473g74uk36xn>
References: <cover.1699533745.git.siyanteng@loongson.cn>
 <87011adcd39f20250edc09ee5d31bda01ded98b5.1699533745.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87011adcd39f20250edc09ee5d31bda01ded98b5.1699533745.git.siyanteng@loongson.cn>

On Fri, Nov 10, 2023 at 05:25:42PM +0800, Yanteng Si wrote:
> Loongson platforms use a DWGMAC which supports multi-channel.
> 
> There are two types of Loongson DWGMAC. The first type shares the same
> register definitions and has similar logic as dwmac1000. The second type
> uses several different register definitions.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 63 ++++++++++++++++---
>  .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 57 ++++++++++++++++-
>  .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 39 ++++++------
>  drivers/net/ethernet/stmicro/stmmac/hwif.c    |  3 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +
>  6 files changed, 133 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index e3f650e88f82..e01584fe9efa 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -34,6 +34,7 @@
>  #define DWMAC_CORE_5_00		0x50
>  #define DWMAC_CORE_5_10		0x51
>  #define DWMAC_CORE_5_20		0x52

> +#define DWGMAC_CORE_1_00	0x10

Name is ambiguous. All of the DWMAC_CORE_* macro above also refer to
the DW GMACs. Moreover generic DW MAC IP-core v1 I guess never existed
in a way the driver expects it. So IMO it would be better for you to
drop this and just add a new flag to the plat_stmmacenet_data
structure (extended_desc or has_lson/STMMAC_FLAG_HAS_LSON).

* One more time took a look at the plat_stmmacenet_data structure and
* scared of the mess it has evolved to.

>  #define DWXGMAC_CORE_2_10	0x21
>  #define DWXGMAC_CORE_2_20	0x22
>  #define DWXLGMAC_CORE_2_00	0x20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> index ce0e6ca6f3a2..234d30c5a836 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -12,7 +12,8 @@
>    Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>  *******************************************************************************/
>  
> -#include <asm/io.h>
> +#include <linux/io.h>
> +#include "stmmac.h"
>  #include "dwmac1000.h"
>  #include "dwmac_dma.h"
>  
> @@ -111,13 +112,58 @@ static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
>  }
>  

> +static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
> +				     void __iomem *ioaddr,
> +				     struct stmmac_dma_cfg *dma_cfg, u32 chan)
> +{
> +	u32 value;
> +	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
> +	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
> +
> +	if (!(priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN))
> +		return;

Use dma_cfg->multi_msi_en in a way it's done in the DW GMAC v4*
module. Also note this flag isn't something that should block all the
DMA-channel-specific setups. It's intended to activate the per-channel
IRQs instead of raising the generic MAC IRQ for all the events.

> +
> +	/* common channel control register config */
> +	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
> +
> +	/* Set the DMA PBL (Programmable Burst Length) mode.
> +	 *
> +	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
> +	 * post 3.5 mode bit acts as 8*PBL.
> +	 */
> +	if (dma_cfg->pblx8)
> +		value |= DMA_BUS_MODE_MAXPBL;
> +	value |= DMA_BUS_MODE_USP;
> +	value &= ~(DMA_BUS_MODE_PBL_MASK | DMA_BUS_MODE_RPBL_MASK);
> +	value |= (txpbl << DMA_BUS_MODE_PBL_SHIFT);
> +	value |= (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
> +
> +	/* Set the Fixed burst mode */
> +	if (dma_cfg->fixed_burst)
> +		value |= DMA_BUS_MODE_FB;
> +
> +	/* Mixed Burst has no effect when fb is set */
> +	if (dma_cfg->mixed_burst)
> +		value |= DMA_BUS_MODE_MB;
> +
> +	value |= DMA_BUS_MODE_ATDS;
> +
> +	if (dma_cfg->aal)
> +		value |= DMA_BUS_MODE_AAL;
> +
> +	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
> +
> +	/* Mask interrupts by writing to CSR7 */
> +	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_CHAN_INTR_ENA(chan));
> +}

This is just a multi-channel copy of the dwmac1000_dma_init(). Please
factor out all the channel-specific setups to the
dwmac1000_dma_init_channel() method and all the generic setups (if
any) to the  dwmac1000_dma_init() function.

> +
>  static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
>  				  void __iomem *ioaddr,
>  				  struct stmmac_dma_cfg *dma_cfg,
>  				  dma_addr_t dma_rx_phy, u32 chan)
>  {
>  	/* RX descriptor base address list must be written into DMA CSR3 */
> -	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR);
> +	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_CHAN_RCV_BASE_ADDR(chan));
>  }
>  
>  static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
> @@ -126,7 +172,7 @@ static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
>  				  dma_addr_t dma_tx_phy, u32 chan)
>  {
>  	/* TX descriptor base address list must be written into DMA CSR4 */
> -	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_TX_BASE_ADDR);
> +	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_CHAN_TX_BASE_ADDR(chan));
>  }
>  
>  static u32 dwmac1000_configure_fc(u32 csr6, int rxfifosz)
> @@ -154,7 +200,7 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>  					    void __iomem *ioaddr, int mode,
>  					    u32 channel, int fifosz, u8 qmode)
>  {
> -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
> +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
>  
>  	if (mode == SF_DMA_MODE) {
>  		pr_debug("GMAC: enable RX store and forward mode\n");
> @@ -176,14 +222,14 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>  	/* Configure flow control based on rx fifo size */
>  	csr6 = dwmac1000_configure_fc(csr6, fifosz);
>  
> -	writel(csr6, ioaddr + DMA_CONTROL);
> +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
>  }
>  
>  static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
>  					    void __iomem *ioaddr, int mode,
>  					    u32 channel, int fifosz, u8 qmode)
>  {
> -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
> +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
>  
>  	if (mode == SF_DMA_MODE) {
>  		pr_debug("GMAC: enable TX store and forward mode\n");
> @@ -210,7 +256,7 @@ static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
>  			csr6 |= DMA_CONTROL_TTC_256;
>  	}
>  
> -	writel(csr6, ioaddr + DMA_CONTROL);
> +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
>  }
>  
>  static void dwmac1000_dump_dma_regs(struct stmmac_priv *priv,
> @@ -273,12 +319,13 @@ static int dwmac1000_get_hw_feature(struct stmmac_priv *priv,
>  static void dwmac1000_rx_watchdog(struct stmmac_priv *priv,
>  				  void __iomem *ioaddr, u32 riwt, u32 queue)
>  {
> -	writel(riwt, ioaddr + DMA_RX_WATCHDOG);
> +	writel(riwt, ioaddr + DMA_CHAN_RX_WATCHDOG(queue));
>  }
>  
>  const struct stmmac_dma_ops dwmac1000_dma_ops = {
>  	.reset = dwmac_dma_reset,
>  	.init = dwmac1000_dma_init,
> +	.init_chan = dwmac1000_dma_init_channel,
>  	.init_rx_chan = dwmac1000_dma_init_rx,
>  	.init_tx_chan = dwmac1000_dma_init_tx,
>  	.axi = dwmac1000_dma_axi,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> index 77141391bd2f..90464e1c9649 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> @@ -76,8 +76,15 @@
>  #define DMA_INTR_ENA_RIE 0x00000040	/* Receive Interrupt */
>  #define DMA_INTR_ENA_ERE 0x00004000	/* Early Receive */
>  

> +#define DMA_INTR_ENA_NIE_LOONGSON 0x00060000	/* Loongson Normal Summary */
> +
> +#ifdef	CONFIG_DWMAC_LOONGSON
> +#define DMA_INTR_NORMAL	(DMA_INTR_ENA_NIE_LOONGSON | DMA_INTR_ENA_NIE | \

Emm, I don't understand this:
DMA_INTR_ENA_NIE          = 0x00010000
DMA_INTR_ENA_NIE_LOONGSON = 0x00060000
What are these additional NIE flags and why do you call them also NIE?

> +			DMA_INTR_ENA_RIE | DMA_INTR_ENA_TIE)
> +#else
>  #define DMA_INTR_NORMAL	(DMA_INTR_ENA_NIE | DMA_INTR_ENA_RIE | \
>  			DMA_INTR_ENA_TIE)
> +#endif
>  
>  /* DMA Abnormal interrupt */
>  #define DMA_INTR_ENA_AIE 0x00008000	/* Abnormal Summary */
> @@ -91,8 +98,15 @@
>  #define DMA_INTR_ENA_TJE 0x00000008	/* Transmit Jabber */
>  #define DMA_INTR_ENA_TSE 0x00000002	/* Transmit Stopped */
>  

> +#define DMA_INTR_ENA_AIE_LOONGSON 0x00018000	/* Loongson Abnormal Summary */
> +
> +#ifdef	CONFIG_DWMAC_LOONGSON
> +#define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE_LOONGSON | DMA_INTR_ENA_AIE | \

Similarly I don't understand this.
DMA_INTR_ENA_AIE          = 0x00008000
DMA_INTR_ENA_AIE_LOONGSON = 0x00018000
so it's Loongson-specific needs normal DMA_INTR_ENA_AIE and some
additional flag enabled. What is the meaning of that flag?

> +				DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE)
> +#else
>  #define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
>  				DMA_INTR_ENA_UNE)
> +#endif
>  
>  /* DMA default interrupt mask */
>  #define DMA_INTR_DEFAULT_MASK	(DMA_INTR_NORMAL | DMA_INTR_ABNORMAL)
> @@ -128,9 +142,29 @@
>  #define DMA_STATUS_TI	0x00000001	/* Transmit Interrupt */
>  #define DMA_CONTROL_FTF		0x00100000	/* Flush transmit FIFO */
>  
> -#define DMA_STATUS_MSK_COMMON		(DMA_STATUS_NIS | \
> -					 DMA_STATUS_AIS | \
> -					 DMA_STATUS_FBI)

> +#define DMA_STATUS_TX_NIS_LOONGSON		0x00040000	/* Normal Tx Interrupt Summary */
> +#define DMA_STATUS_RX_NIS_LOONGSON		0x00020000	/* Normal Rx Interrupt Summary */
> +#define DMA_STATUS_TX_AIS_LOONGSON		0x00010000	/* Abnormal Tx Interrupt Summary */
> +#define DMA_STATUS_RX_AIS_LOONGSON		0x00008000	/* Abnormal Rx Interrupt Summary */
> +#define DMA_STATUS_TX_FBI_LOONGSON		0x00002000	/* Fatal Tx Bus Error Interrupt */
> +#define DMA_STATUS_RX_FBI_LOONGSON		0x00001000	/* Fatal Rx Bus Error Interrupt */
> +
> +#ifdef	CONFIG_DWMAC_LOONGSON
> +#define DMA_NOR_INTR_STATUS	    (DMA_STATUS_TX_NIS_LOONGSON | DMA_STATUS_RX_NIS_LOONGSON)
> +#define DMA_ABNOR_INTR_STATUS	    (DMA_STATUS_TX_AIS_LOONGSON | DMA_STATUS_RX_AIS_LOONGSON)
> +#define DMA_FB_INTR_STATUS	    (DMA_STATUS_TX_FBI_LOONGSON | DMA_STATUS_RX_FBI_LOONGSON)
> +#else
> +#define DMA_NOR_INTR_STATUS	    DMA_STATUS_NIS
> +#define DMA_ABNOR_INTR_STATUS	    DMA_STATUS_AIS
> +#define DMA_FB_INTR_STATUS	    DMA_STATUS_FBI
> +#endif

In addition to what said Andrew, this looks incorrect since the
Loongson flags intersect the generic status flags. So it seems like
at least the statistics handling or the
show_rx_process_state()/show_tx_process_state() won't work correctly.

-Serge(y)

> +
> +#define DMA_INTR_STATUS		    (DMA_STATUS_GPI | \
> +					 DMA_STATUS_GMI | \
> +					 DMA_STATUS_GLI)
> +#define DMA_STATUS_MSK_COMMON		(DMA_NOR_INTR_STATUS | \
> +					 DMA_ABNOR_INTR_STATUS | \
> +					 DMA_FB_INTR_STATUS)
>  
>  #define DMA_STATUS_MSK_RX		(DMA_STATUS_ERI | \
>  					 DMA_STATUS_RWT | \
> @@ -148,6 +182,9 @@
>  					 DMA_STATUS_TI | \
>  					 DMA_STATUS_MSK_COMMON)
>  
> +/* Following DMA defines are chanels oriented */
> +#define DMA_CHAN_OFFSET			0x100
> +
>  #define NUM_DWMAC100_DMA_REGS	9
>  #define NUM_DWMAC1000_DMA_REGS	23
>  #define NUM_DWMAC4_DMA_REGS	27
> @@ -170,4 +207,18 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			struct stmmac_extra_stats *x, u32 chan, u32 dir);
>  int dwmac_dma_reset(struct stmmac_priv *priv, void __iomem *ioaddr);
>  
> +static inline u32 dma_chan_base_addr(u32 base, u32 chan)
> +{
> +	return base + chan * DMA_CHAN_OFFSET;
> +}
> +
> +#define DMA_CHAN_XMT_POLL_DEMAND(chan)	dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan)
> +#define DMA_CHAN_INTR_ENA(chan)		dma_chan_base_addr(DMA_INTR_ENA, chan)
> +#define DMA_CHAN_CONTROL(chan)		dma_chan_base_addr(DMA_CONTROL, chan)
> +#define DMA_CHAN_STATUS(chan)		dma_chan_base_addr(DMA_STATUS, chan)
> +#define DMA_CHAN_BUS_MODE(chan)		dma_chan_base_addr(DMA_BUS_MODE, chan)
> +#define DMA_CHAN_RCV_BASE_ADDR(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)
> +#define DMA_CHAN_TX_BASE_ADDR(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)
> +#define DMA_CHAN_RX_WATCHDOG(chan)	dma_chan_base_addr(DMA_RX_WATCHDOG, chan)
> +
>  #endif /* __DWMAC_DMA_H__ */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> index 0cb337ffb7ac..c36aec97bbb5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> @@ -31,63 +31,63 @@ int dwmac_dma_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
>  void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
>  				   void __iomem *ioaddr, u32 chan)
>  {
> -	writel(1, ioaddr + DMA_XMT_POLL_DEMAND);
> +	writel(1, ioaddr + DMA_CHAN_XMT_POLL_DEMAND(chan));
>  }
>  
>  void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			  u32 chan, bool rx, bool tx)
>  {
> -	u32 value = readl(ioaddr + DMA_INTR_ENA);
> +	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
>  
>  	if (rx)
>  		value |= DMA_INTR_DEFAULT_RX;
>  	if (tx)
>  		value |= DMA_INTR_DEFAULT_TX;
>  
> -	writel(value, ioaddr + DMA_INTR_ENA);
> +	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
>  }
>  
>  void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			   u32 chan, bool rx, bool tx)
>  {
> -	u32 value = readl(ioaddr + DMA_INTR_ENA);
> +	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
>  
>  	if (rx)
>  		value &= ~DMA_INTR_DEFAULT_RX;
>  	if (tx)
>  		value &= ~DMA_INTR_DEFAULT_TX;
>  
> -	writel(value, ioaddr + DMA_INTR_ENA);
> +	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
>  }
>  
>  void dwmac_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			u32 chan)
>  {
> -	u32 value = readl(ioaddr + DMA_CONTROL);
> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>  	value |= DMA_CONTROL_ST;
> -	writel(value, ioaddr + DMA_CONTROL);
> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>  }
>  
>  void dwmac_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
>  {
> -	u32 value = readl(ioaddr + DMA_CONTROL);
> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>  	value &= ~DMA_CONTROL_ST;
> -	writel(value, ioaddr + DMA_CONTROL);
> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>  }
>  
>  void dwmac_dma_start_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			u32 chan)
>  {
> -	u32 value = readl(ioaddr + DMA_CONTROL);
> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>  	value |= DMA_CONTROL_SR;
> -	writel(value, ioaddr + DMA_CONTROL);
> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>  }
>  
>  void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
>  {
> -	u32 value = readl(ioaddr + DMA_CONTROL);
> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>  	value &= ~DMA_CONTROL_SR;
> -	writel(value, ioaddr + DMA_CONTROL);
> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>  }
>  
>  #ifdef DWMAC_DMA_DEBUG
> @@ -167,7 +167,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
>  	int ret = 0;
>  	/* read the status register (CSR5) */
> -	u32 intr_status = readl(ioaddr + DMA_STATUS);
> +	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
>  
>  #ifdef DWMAC_DMA_DEBUG
>  	/* Enable it to monitor DMA rx/tx status in case of critical problems */
> @@ -182,7 +182,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  		intr_status &= DMA_STATUS_MSK_TX;
>  
>  	/* ABNORMAL interrupts */
> -	if (unlikely(intr_status & DMA_STATUS_AIS)) {
> +	if (unlikely(intr_status & DMA_ABNOR_INTR_STATUS)) {
>  		if (unlikely(intr_status & DMA_STATUS_UNF)) {
>  			ret = tx_hard_error_bump_tc;
>  			x->tx_undeflow_irq++;
> @@ -205,13 +205,13 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			x->tx_process_stopped_irq++;
>  			ret = tx_hard_error;
>  		}
> -		if (unlikely(intr_status & DMA_STATUS_FBI)) {
> +		if (unlikely(intr_status & DMA_FB_INTR_STATUS)) {
>  			x->fatal_bus_error_irq++;
>  			ret = tx_hard_error;
>  		}
>  	}
>  	/* TX/RX NORMAL interrupts */
> -	if (likely(intr_status & DMA_STATUS_NIS)) {
> +	if (likely(intr_status & DMA_NOR_INTR_STATUS)) {
>  		if (likely(intr_status & DMA_STATUS_RI)) {
>  			u32 value = readl(ioaddr + DMA_INTR_ENA);
>  			/* to schedule NAPI on real RIE event. */
> @@ -232,12 +232,11 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			x->rx_early_irq++;
>  	}
>  	/* Optional hardware blocks, interrupts should be disabled */
> -	if (unlikely(intr_status &
> -		     (DMA_STATUS_GPI | DMA_STATUS_GMI | DMA_STATUS_GLI)))
> +	if (unlikely(intr_status & DMA_INTR_STATUS))
>  		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
>  
>  	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
> -	writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
>  
>  	return ret;
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 93cead5613e3..e5e7ac03459d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -58,7 +58,8 @@ static int stmmac_dwmac1_quirks(struct stmmac_priv *priv)
>  		dev_info(priv->device, "Enhanced/Alternate descriptors\n");
>  
>  		/* GMAC older than 3.50 has no extended descriptors */
> -		if (priv->synopsys_id >= DWMAC_CORE_3_50) {
> +		if (priv->synopsys_id >= DWMAC_CORE_3_50 ||
> +		    priv->synopsys_id == DWGMAC_CORE_1_00) {
>  			dev_info(priv->device, "Enabled extended descriptors\n");
>  			priv->extend_desc = 1;
>  		} else {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7371713c116d..aafc75fa14a0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7062,6 +7062,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>  	/* dwmac-sun8i only work in chain mode */
>  	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I)
>  		chain_mode = 1;
> +
>  	priv->chain_mode = chain_mode;
>  
>  	/* Initialize HW Interface */
> @@ -7142,6 +7143,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>  	 * riwt_off field from the platform.
>  	 */
>  	if (((priv->synopsys_id >= DWMAC_CORE_3_50) ||
> +		(priv->synopsys_id == DWGMAC_CORE_1_00) ||
>  	    (priv->plat->has_xgmac)) && (!priv->plat->riwt_off)) {
>  		priv->use_riwt = 1;
>  		dev_info(priv->device,
> -- 
> 2.31.4
> 

