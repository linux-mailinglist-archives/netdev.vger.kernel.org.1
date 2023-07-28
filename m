Return-Path: <netdev+bounces-22152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79B576645D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0580F1C217FB
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 06:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B32BE40;
	Fri, 28 Jul 2023 06:38:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7992F35
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 06:38:39 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD39D3C24
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 23:38:08 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36S6aWo4108548;
	Fri, 28 Jul 2023 01:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1690526192;
	bh=Xa3mV8uDoKOc/m3VZ//d94y15mSePbo/tXuV/Va/m7c=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=blQGGynYQzzeYtcVVoZ6HWXFCQ5vlm5B/2O0JcDTu/w1fUd8rbuXxJLORzl0Px9Dk
	 EXB9xdZv3GDzJMB2iFh4YsqRggap8ji3qr1mDqTJlfVxEkohy/ZCx+wBfRhtDpN1F8
	 4zlaOl5B3Hj8Ht115/2wvYZN7ChS4mBeF5jmA/4A=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36S6aWuL013351
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jul 2023 01:36:32 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 01:36:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 01:36:32 -0500
Received: from [172.24.227.83] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36S6aSKi075959;
	Fri, 28 Jul 2023 01:36:28 -0500
Message-ID: <81d9887c-cd0a-cb90-957e-eeaa2ae94967@ti.com>
Date: Fri, 28 Jul 2023 12:06:27 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/10] net: stmmac: Add Loongson HWIF entry
Content-Language: en-US
To: Feiyang Chen <chenfeiyang@loongson.cn>, <andrew@lunn.ch>,
        <hkallweit1@gmail.com>, <peppe.cavallaro@st.com>,
        <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
        <chenhuacai@loongson.cn>
CC: <linux@armlinux.org.uk>, <dongbiao@loongson.cn>,
        <loongson-kernel@lists.loongnix.cn>, <netdev@vger.kernel.org>,
        <loongarch@lists.linux.dev>, <chris.chenfeiyang@gmail.com>
References: <cover.1690439335.git.chenfeiyang@loongson.cn>
 <7cae63ede2792cb2a7189f251b282aecbb0945b1.1690439335.git.chenfeiyang@loongson.cn>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <7cae63ede2792cb2a7189f251b282aecbb0945b1.1690439335.git.chenfeiyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/27/23 12:48 PM, Feiyang Chen wrote:
> Add a new entry to HWIF table for Loongson.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  |  3 ++
>  .../ethernet/stmicro/stmmac/dwmac1000_dma.c   |  6 +++
>  drivers/net/ethernet/stmicro/stmmac/hwif.c    | 48 ++++++++++++++++++-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++----
>  include/linux/stmmac.h                        |  1 +
>  5 files changed, 73 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index 16e67c18b6f7..267f9a7913ac 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -29,11 +29,13 @@
>  /* Synopsys Core versions */
>  #define	DWMAC_CORE_3_40		0x34
>  #define	DWMAC_CORE_3_50		0x35
> +#define	DWMAC_CORE_3_70		0x37
>  #define	DWMAC_CORE_4_00		0x40
>  #define DWMAC_CORE_4_10		0x41
>  #define DWMAC_CORE_5_00		0x50
>  #define DWMAC_CORE_5_10		0x51
>  #define DWMAC_CORE_5_20		0x52
> +#define DWLGMAC_CORE_1_00	0x10
>  #define DWXGMAC_CORE_2_10	0x21
>  #define DWXLGMAC_CORE_2_00	0x20
>  
> @@ -547,6 +549,7 @@ int dwmac1000_setup(struct stmmac_priv *priv);
>  int dwmac4_setup(struct stmmac_priv *priv);
>  int dwxgmac2_setup(struct stmmac_priv *priv);
>  int dwxlgmac2_setup(struct stmmac_priv *priv);
> +int dwmac_loongson_setup(struct stmmac_priv *priv);
>  
>  void stmmac_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
>  			 unsigned int high, unsigned int low);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> index 7aa450d6a81a..5da5f111d7e0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -172,6 +172,12 @@ static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
>  		       chan * DMA_CHAN_OFFSET);
>  		writel(upper_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR_HI +
>  		       chan * DMA_CHAN_OFFSET);
> +		if (priv->plat->has_lgmac) {
> +			writel(upper_32_bits(dma_rx_phy),
> +			       ioaddr + DMA_RCV_BASE_ADDR_SHADOW1);
> +			writel(upper_32_bits(dma_rx_phy),
> +			       ioaddr + DMA_RCV_BASE_ADDR_SHADOW2);
> +		}
>  	} else {
>  		/* RX descriptor base address list must be written into DMA CSR3 */
>  		writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR +
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index b8ba8f2d8041..b376ac4f80d5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -58,7 +58,8 @@ static int stmmac_dwmac1_quirks(struct stmmac_priv *priv)
>  		dev_info(priv->device, "Enhanced/Alternate descriptors\n");
>  
>  		/* GMAC older than 3.50 has no extended descriptors */
> -		if (priv->synopsys_id >= DWMAC_CORE_3_50) {
> +		if (priv->synopsys_id >= DWMAC_CORE_3_50 ||
> +		    priv->plat->has_lgmac) {>  			dev_info(priv->device, "Enabled extended descriptors\n");
>  			priv->extend_desc = 1;
>  		} else {
> @@ -104,6 +105,7 @@ static const struct stmmac_hwif_entry {
>  	bool gmac;
>  	bool gmac4;
>  	bool xgmac;
> +	bool lgmac;

Similar to Andrew's comment on dwmac_is_loongson, can lgmac also be
renamed to some other name? 

I believe the 'gmac' and 'xgmac' refer to 1Gbps and 10Gbps which sounds generic,
while 'lgmac' sounds vendor specific. 

>  	u32 min_id;
>  	u32 dev_id;
>  	const struct stmmac_regs_off regs;


[...]

> +	}, {
> +		.gmac = true,
> +		.gmac4 = false,
> +		.xgmac = false,
> +		.lgmac = true,
> +		.min_id = DWLGMAC_CORE_1_00,
> +		.regs = {
> +			.ptp_off = PTP_GMAC3_X_OFFSET,
> +			.mmc_off = MMC_GMAC3_X_OFFSET,
> +		},
> +		.desc = NULL,
> +		.dma = &dwmac1000_dma_ops,
> +		.mac = &dwmac1000_ops,
> +		.hwtimestamp = &stmmac_ptp,
> +		.mode = NULL,
> +		.tc = NULL,
> +		.setup = dwmac_loongson_setup,
> +		.quirks = stmmac_dwmac1_quirks,
> +	}, {
> +		.gmac = true,
> +		.gmac4 = false,
> +		.xgmac = false,
> +		.lgmac = true,
> +		.min_id = DWMAC_CORE_3_50,
> +		.regs = {
> +			.ptp_off = PTP_GMAC3_X_OFFSET,
> +			.mmc_off = MMC_GMAC3_X_OFFSET,
> +		},
> +		.desc = NULL,
> +		.dma = &dwmac1000_dma_ops,
> +		.mac = &dwmac1000_ops,
> +		.hwtimestamp = &stmmac_ptp,
> +		.mode = NULL,
> +		.tc = NULL,
> +		.setup = dwmac1000_setup,
> +		.quirks = stmmac_dwmac1_quirks,
>  	},
>  };
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index e8619853b6d6..829de274e75d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3505,17 +3505,21 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	enum request_irq_err irq_err;
> +	unsigned long flags = 0;
>  	cpumask_t cpu_mask;
>  	int irq_idx = 0;
>  	char *int_name;
>  	int ret;
>  	int i;
>  
> +	if (priv->plat->has_lgmac)
> +		flags |= IRQF_TRIGGER_RISING;

How about introducing a struct member such as "irq_flags"?

> +
>  	/* For common interrupt */
>  	int_name = priv->int_name_mac;
>  	sprintf(int_name, "%s:%s", dev->name, "mac");
>  	ret = request_irq(dev->irq, stmmac_mac_interrupt,
> -			  0, int_name, dev);
> +			  flags, int_name, dev);

[...]

> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 46bccc34814d..e21076f57205 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -344,5 +344,6 @@ struct plat_stmmacenet_data {
>  	bool has_integrated_pcs;
>  	const struct dwmac_regs *dwmac_regs;
>  	bool dwmac_is_loongson;
> +	int has_lgmac;
>  };
>  #endif

-- 
Regards,
Ravi

