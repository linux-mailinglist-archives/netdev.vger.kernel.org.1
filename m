Return-Path: <netdev+bounces-63224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F38782BE16
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 11:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918C31F21ADE
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58485C8F9;
	Fri, 12 Jan 2024 10:08:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E557877
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.108.41])
	by gateway (Coremail) with SMTP id _____8Cx67qvD6Fl04UEAA--.4869S3;
	Fri, 12 Jan 2024 18:08:47 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.108.41])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxfNyrD6Fl++4TAA--.51887S3;
	Fri, 12 Jan 2024 18:08:44 +0800 (CST)
Message-ID: <111ca569-f6a9-4090-be0f-8754ca1ac913@loongson.cn>
Date: Fri, 12 Jan 2024 18:08:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 5/9] net: stmmac: Add Loongson-specific
 register definitions
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <bbc826f622b501bc490e838644c9c502185a78df.1702990507.git.siyanteng@loongson.cn>
 <t25ka7blbx2d2d654s5swbtvecip73yd5wpdqiy3xijjmswvni@bxf4dh56x4zl>
 <dc30d3f5-6ebe-4804-ae7d-2834bea22cc4@loongson.cn>
 <hv5y6tcxenqz626tqm54ur7qxd4sjp5zyavshxvqgulfrdrqyj@nlvttdtpl7uc>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <hv5y6tcxenqz626tqm54ur7qxd4sjp5zyavshxvqgulfrdrqyj@nlvttdtpl7uc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxfNyrD6Fl++4TAA--.51887S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfZrykAw4xGFy7ZF45Cry5Jrc_yoW8uFWkGo
	Z8GFn3tayrKw18ur4kG3sYqryavwn8Zw43JFWxG34DZ39avw1UCFWrJ34fZFW3tFy8KF98
	C34xJFyDZFWaqrn5l-sFpf9Il3svdjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=


在 2024/1/1 20:26, Serge Semin 写道:
> On Mon, Jan 01, 2024 at 04:31:48PM +0800, Yanteng Si wrote:
>> 在 2023/12/21 10:14, Serge Semin 写道:
>>> On Tue, Dec 19, 2023 at 10:26:45PM +0800, Yanteng Si wrote:
>>>> There are two types of Loongson DWGMAC. The first type shares the same
>>>> register definitions and has similar logic as dwmac1000. The second type
>>>> uses several different register definitions, we think it is necessary to
>>>> distinguish rx and tx, so we split these bits into two.
>>>>
>>>> Simply put, we split some single bit fields into double bits fileds:
>>>>
>>>>        Name              Tx          Rx
>>>>
>>>> DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
>>>> DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
>>>> DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
>>>> DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
>>>> DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
>>>>
>>>> Therefore, when using, TX and RX must be set at the same time.
>>> Thanks for the updated patch. It looks much clearer now. Thanks to
>>> that I came up with a better and less invasive solution. See my last
>>> comment for details.
>>>
>>>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>>>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>>>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>>>> ---
>>>>    drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>>>>    .../ethernet/stmicro/stmmac/dwmac-loongson.c  |  2 ++
>>>>    .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 10 ++++--
>>>>    .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 35 +++++++++++++++++++
>>>>    .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 35 +++++++++++++++----
>>>>    drivers/net/ethernet/stmicro/stmmac/hwif.c    |  3 +-
>>>>    .../net/ethernet/stmicro/stmmac/stmmac_main.c |  1 +
>>>>    include/linux/stmmac.h                        |  1 +
>>>>    8 files changed, 78 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
>>>> index 721c1f8e892f..48ab21243b26 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
>>>> @@ -34,6 +34,7 @@
>>>>    #define DWMAC_CORE_5_00		0x50
>>>>    #define DWMAC_CORE_5_10		0x51
>>>>    #define DWMAC_CORE_5_20		0x52
>>>> +#define DWLGMAC_CORE_1_00	0x10
>>> This doesn't look correct because these IDs have been defined for the
>>> Synopsys IP-core enumerations. Loongson GNET is definitely based on
>>> some DW GMAC v3.x IP-core, but instead of updating the USERVER field
>>> vendor just overwrote the GMAC_VERSION.SNPSVER field. From that
>>> perspective the correct solution would be to override the
>>> priv->synopsys_id field with a correct IP-core version (0x37?). See my
>>> last comment for details of how to do that.
>> See my last reply.
>>>>    #define DWXGMAC_CORE_2_10	0x21
>>>>    #define DWXGMAC_CORE_2_20	0x22
>>>>    #define DWXLGMAC_CORE_2_00	0x20
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>> index 0d79104d7fd3..fb7506bbc21b 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>> @@ -101,6 +101,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>>>    		plat->mdio_bus_data->needs_reset = true;
>>>>    	}
>>>> +	plat->flags |= STMMAC_FLAG_HAS_LGMAC;
>>>> +
>>> If what I suggest in the last comment is implemented this will be
>>> unnecessary.
>>>
>>>>    	/* Enable pci device */
>>>>    	ret = pci_enable_device(pdev);
>>>>    	if (ret) {
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>>>> index 0fb48e683970..a01fe6b7540a 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>>> None of the generic parts (dwmac1000_dma.c, dwmac_dma.h, dwmac_lib.c)
>>> will need to be modified if you implement what I suggest in the last
>>> comment.
>>>
>>>> @@ -118,7 +118,10 @@ static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>>> See my comment to patch 4/9. This method can be fully dropped in favor
>>> of having the dwmac1000_dma_init_channel() function implemented.
>>>
>>>>    	u32 dma_intr_mask;
>>>>    	/* Mask interrupts by writing to CSR7 */
>>>> -	dma_intr_mask = DMA_INTR_DEFAULT_MASK;
>>>> +	if (priv->plat->flags & STMMAC_FLAG_HAS_LGMAC)
>>>> +		dma_intr_mask = DMA_INTR_DEFAULT_MASK_LOONGSON;
>>>> +	else
>>>> +		dma_intr_mask = DMA_INTR_DEFAULT_MASK;
>>>>    	dma_config(ioaddr + DMA_BUS_MODE, ioaddr + DMA_INTR_ENA,
>>>>    			  dma_cfg, dma_intr_mask, atds);
>>>> @@ -130,7 +133,10 @@ static void dwmac1000_dma_init_channel(struct stmmac_priv *priv, void __iomem *i
>>>>    	u32 dma_intr_mask;
>>>>    	/* Mask interrupts by writing to CSR7 */
>>>> -	dma_intr_mask = DMA_INTR_DEFAULT_MASK;
>>>> +	if (priv->plat->flags & STMMAC_FLAG_HAS_LGMAC)
>>>> +		dma_intr_mask = DMA_INTR_DEFAULT_MASK_LOONGSON;
>>>> +	else
>>>> +		dma_intr_mask = DMA_INTR_DEFAULT_MASK;
>>>>    	if (dma_cfg->multi_msi_en)
>>>>    		dma_config(ioaddr + DMA_CHAN_BUS_MODE(chan),
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>>>> index 395d5e4c3922..7d33798c0e72 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>>>> @@ -70,16 +70,23 @@
>>>>    #define DMA_CONTROL_SR		0x00000002	/* Start/Stop Receive */
>>>>    /* DMA Normal interrupt */
>>>> +#define DMA_INTR_ENA_NIE_TX_LOONGSON 0x00040000	/* Normal Loongson Tx Summary */
>>>> +#define DMA_INTR_ENA_NIE_RX_LOONGSON 0x00020000	/* Normal Loongson Rx Summary */
>>>>    #define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
>>>>    #define DMA_INTR_ENA_TIE 0x00000001	/* Transmit Interrupt */
>>>>    #define DMA_INTR_ENA_TUE 0x00000004	/* Transmit Buffer Unavailable */
>>>>    #define DMA_INTR_ENA_RIE 0x00000040	/* Receive Interrupt */
>>>>    #define DMA_INTR_ENA_ERE 0x00004000	/* Early Receive */
>>>> +#define DMA_INTR_NORMAL_LOONGSON	(DMA_INTR_ENA_NIE_TX_LOONGSON | \
>>>> +			 DMA_INTR_ENA_NIE_RX_LOONGSON | DMA_INTR_ENA_RIE | \
>>>> +			 DMA_INTR_ENA_TIE)
>>>>    #define DMA_INTR_NORMAL	(DMA_INTR_ENA_NIE | DMA_INTR_ENA_RIE | \
>>>>    			DMA_INTR_ENA_TIE)
>>>>    /* DMA Abnormal interrupt */
>>>> +#define DMA_INTR_ENA_AIE_TX_LOONGSON 0x00010000	/* Abnormal Loongson Tx Summary */
>>>> +#define DMA_INTR_ENA_AIE_RX_LOONGSON 0x00008000	/* Abnormal Loongson Rx Summary */
>>>>    #define DMA_INTR_ENA_AIE 0x00008000	/* Abnormal Summary */
>>>>    #define DMA_INTR_ENA_FBE 0x00002000	/* Fatal Bus Error */
>>>>    #define DMA_INTR_ENA_ETE 0x00000400	/* Early Transmit */
>>>> @@ -91,10 +98,14 @@
>>>>    #define DMA_INTR_ENA_TJE 0x00000008	/* Transmit Jabber */
>>>>    #define DMA_INTR_ENA_TSE 0x00000002	/* Transmit Stopped */
>>>> +#define DMA_INTR_ABNORMAL_LOONGSON	(DMA_INTR_ENA_AIE_TX_LOONGSON | \
>>>> +				DMA_INTR_ENA_AIE_RX_LOONGSON | DMA_INTR_ENA_FBE | \
>>>> +				DMA_INTR_ENA_UNE)
>>>>    #define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
>>>>    				DMA_INTR_ENA_UNE)
>>>>    /* DMA default interrupt mask */
>>>> +#define DMA_INTR_DEFAULT_MASK_LOONGSON	(DMA_INTR_NORMAL_LOONGSON | DMA_INTR_ABNORMAL_LOONGSON)
>>>>    #define DMA_INTR_DEFAULT_MASK	(DMA_INTR_NORMAL | DMA_INTR_ABNORMAL)
>>>>    #define DMA_INTR_DEFAULT_RX	(DMA_INTR_ENA_RIE)
>>>>    #define DMA_INTR_DEFAULT_TX	(DMA_INTR_ENA_TIE)
>>>> @@ -111,9 +122,15 @@
>>>>    #define DMA_STATUS_TS_SHIFT	20
>>>>    #define DMA_STATUS_RS_MASK	0x000e0000	/* Receive Process State */
>>>>    #define DMA_STATUS_RS_SHIFT	17
>>>> +#define DMA_STATUS_NIS_TX_LOONGSON	0x00040000	/* Normal Loongson Tx Interrupt Summary */
>>>> +#define DMA_STATUS_NIS_RX_LOONGSON	0x00020000	/* Normal Loongson Rx Interrupt Summary */
>>>>    #define DMA_STATUS_NIS	0x00010000	/* Normal Interrupt Summary */
>>>> +#define DMA_STATUS_AIS_TX_LOONGSON	0x00010000	/* Abnormal Loongson Tx Interrupt Summary */
>>>> +#define DMA_STATUS_AIS_RX_LOONGSON	0x00008000	/* Abnormal Loongson Rx Interrupt Summary */
>>>>    #define DMA_STATUS_AIS	0x00008000	/* Abnormal Interrupt Summary */
>>>>    #define DMA_STATUS_ERI	0x00004000	/* Early Receive Interrupt */
>>>> +#define DMA_STATUS_FBI_TX_LOONGSON	0x00002000	/* Fatal Loongson Tx Bus Error Interrupt */
>>>> +#define DMA_STATUS_FBI_RX_LOONGSON	0x00001000	/* Fatal Loongson Rx Bus Error Interrupt */
>>>>    #define DMA_STATUS_FBI	0x00002000	/* Fatal Bus Error Interrupt */
>>>>    #define DMA_STATUS_ETI	0x00000400	/* Early Transmit Interrupt */
>>>>    #define DMA_STATUS_RWT	0x00000200	/* Receive Watchdog Timeout */
>>>> @@ -128,10 +145,21 @@
>>>>    #define DMA_STATUS_TI	0x00000001	/* Transmit Interrupt */
>>>>    #define DMA_CONTROL_FTF		0x00100000	/* Flush transmit FIFO */
>>>> +#define DMA_STATUS_MSK_COMMON_LOONGSON		(DMA_STATUS_NIS_TX_LOONGSON | \
>>>> +					 DMA_STATUS_NIS_RX_LOONGSON | DMA_STATUS_AIS_TX_LOONGSON | \
>>>> +					 DMA_STATUS_AIS_RX_LOONGSON | DMA_STATUS_FBI_TX_LOONGSON | \
>>>> +					 DMA_STATUS_FBI_RX_LOONGSON)
>>>>    #define DMA_STATUS_MSK_COMMON		(DMA_STATUS_NIS | \
>>>>    					 DMA_STATUS_AIS | \
>>>>    					 DMA_STATUS_FBI)
>>>> +#define DMA_STATUS_MSK_RX_LOONGSON		(DMA_STATUS_ERI | \
>>>> +					 DMA_STATUS_RWT | \
>>>> +					 DMA_STATUS_RPS | \
>>>> +					 DMA_STATUS_RU | \
>>>> +					 DMA_STATUS_RI | \
>>>> +					 DMA_STATUS_OVF | \
>>>> +					 DMA_STATUS_MSK_COMMON_LOONGSON)
>>>>    #define DMA_STATUS_MSK_RX		(DMA_STATUS_ERI | \
>>>>    					 DMA_STATUS_RWT | \
>>>>    					 DMA_STATUS_RPS | \
>>>> @@ -140,6 +168,13 @@
>>>>    					 DMA_STATUS_OVF | \
>>>>    					 DMA_STATUS_MSK_COMMON)
>>>> +#define DMA_STATUS_MSK_TX_LOONGSON		(DMA_STATUS_ETI | \
>>>> +					 DMA_STATUS_UNF | \
>>>> +					 DMA_STATUS_TJT | \
>>>> +					 DMA_STATUS_TU | \
>>>> +					 DMA_STATUS_TPS | \
>>>> +					 DMA_STATUS_TI | \
>>>> +					 DMA_STATUS_MSK_COMMON_LOONGSON)
>>>>    #define DMA_STATUS_MSK_TX		(DMA_STATUS_ETI | \
>>>>    					 DMA_STATUS_UNF | \
>>>>    					 DMA_STATUS_TJT | \
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>>>> index 968801c694e9..a6e2ab4d0f4a 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>>>> @@ -167,6 +167,9 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
>>>>    	int ret = 0;
>>>>    	/* read the status register (CSR5) */
>>>> +	u32 nor_intr_status;
>>>> +	u32 abnor_intr_status;
>>>> +	u32 fb_intr_status;
>>>>    	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
>>>>    #ifdef DWMAC_DMA_DEBUG
>>>> @@ -176,13 +179,31 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    	show_rx_process_state(intr_status);
>>>>    #endif
>>>> -	if (dir == DMA_DIR_RX)
>>>> -		intr_status &= DMA_STATUS_MSK_RX;
>>>> -	else if (dir == DMA_DIR_TX)
>>>> -		intr_status &= DMA_STATUS_MSK_TX;
>>>> +	if (priv->plat->flags & STMMAC_FLAG_HAS_LGMAC) {
>>>> +		if (dir == DMA_DIR_RX)
>>>> +			intr_status &= DMA_STATUS_MSK_RX_LOONGSON;
>>>> +		else if (dir == DMA_DIR_TX)
>>>> +			intr_status &= DMA_STATUS_MSK_TX_LOONGSON;
>>>> +
>>>> +		nor_intr_status = intr_status & \
>>>> +			(DMA_STATUS_NIS_TX_LOONGSON | DMA_STATUS_NIS_RX_LOONGSON);
>>>> +		abnor_intr_status = intr_status & \
>>>> +			(DMA_STATUS_AIS_TX_LOONGSON | DMA_STATUS_AIS_RX_LOONGSON);
>>>> +		fb_intr_status = intr_status & \
>>>> +			(DMA_STATUS_FBI_TX_LOONGSON | DMA_STATUS_FBI_RX_LOONGSON);
>>>> +	} else {
>>>> +		if (dir == DMA_DIR_RX)
>>>> +			intr_status &= DMA_STATUS_MSK_RX;
>>>> +		else if (dir == DMA_DIR_TX)
>>>> +			intr_status &= DMA_STATUS_MSK_TX;
>>>> +
>>>> +		nor_intr_status = intr_status & DMA_STATUS_NIS;
>>>> +		abnor_intr_status = intr_status & DMA_STATUS_AIS;
>>>> +		fb_intr_status = intr_status & DMA_STATUS_FBI;
>>>> +	}
>>>>    	/* ABNORMAL interrupts */
>>>> -	if (unlikely(intr_status & DMA_STATUS_AIS)) {
>>>> +	if (unlikely(abnor_intr_status)) {
>>>>    		if (unlikely(intr_status & DMA_STATUS_UNF)) {
>>>>    			ret = tx_hard_error_bump_tc;
>>>>    			x->tx_undeflow_irq++;
>>>> @@ -205,13 +226,13 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    			x->tx_process_stopped_irq++;
>>>>    			ret = tx_hard_error;
>>>>    		}
>>>> -		if (unlikely(intr_status & DMA_STATUS_FBI)) {
>>>> +		if (unlikely(intr_status & fb_intr_status)) {
>>>>    			x->fatal_bus_error_irq++;
>>>>    			ret = tx_hard_error;
>>>>    		}
>>>>    	}
>>>>    	/* TX/RX NORMAL interrupts */
>>>> -	if (likely(intr_status & DMA_STATUS_NIS)) {
>>>> +	if (likely(nor_intr_status)) {
>>>>    		if (likely(intr_status & DMA_STATUS_RI)) {
>>>>    			u32 value = readl(ioaddr + DMA_INTR_ENA);
>>>>    			/* to schedule NAPI on real RIE event. */
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
>>>> index 1bd34b2a47e8..3724cf698de6 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
>>>> @@ -59,7 +59,8 @@ static int stmmac_dwmac1_quirks(struct stmmac_priv *priv)
>>>>    		dev_info(priv->device, "Enhanced/Alternate descriptors\n");
>>>>    		/* GMAC older than 3.50 has no extended descriptors */
>>>> -		if (priv->synopsys_id >= DWMAC_CORE_3_50) {
>>>> +		if (priv->synopsys_id >= DWMAC_CORE_3_50 ||
>>>> +		    priv->synopsys_id == DWLGMAC_CORE_1_00) {
>>> This could be left as is if the priv->synopsys_id field is overwritten
>>> with a correct value (see my last comment).
>>>
>>>>    			dev_info(priv->device, "Enabled extended descriptors\n");
>>>>    			priv->extend_desc = 1;
>>>>    		} else {
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>> index d868eb8dafc5..9764d2ab7e46 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>> @@ -7218,6 +7218,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>>>>    	 * riwt_off field from the platform.
>>>>    	 */
>>>>    	if (((priv->synopsys_id >= DWMAC_CORE_3_50) ||
>>>> +		(priv->synopsys_id == DWLGMAC_CORE_1_00) ||
>>> the same comment here.
>>>
>>>>    	    (priv->plat->has_xgmac)) && (!priv->plat->riwt_off)) {
>>>>    		priv->use_riwt = 1;
>>>>    		dev_info(priv->device,
>>>> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
>>>> index dee5ad6e48c5..f07f79d50b06 100644
>>>> --- a/include/linux/stmmac.h
>>>> +++ b/include/linux/stmmac.h
>>>> @@ -221,6 +221,7 @@ struct dwmac4_addrs {
>>>>    #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
>>>>    #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
>>>>    #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
>>>> +#define STMMAC_FLAG_HAS_LGMAC			BIT(13)
>>> Seeing the patch in the current state would overcomplicate the generic
>>> code and the only functions you need to update are
>>> dwmac_dma_interrupt()
>>> dwmac1000_dma_init_channel()
>>> you can have these methods re-defined with all the Loongson GNET
>>> specifics in the low-level platform driver (dwmac-loongson.c). After
>>> that you can just override the mac_device_info.dma pointer with a
>>> fixed stmmac_dma_ops descriptor. Here is what should be done for that:
>>>
>>> 1. Keep the Patch 4/9 with my comments fixed. First it will be partly
>>> useful for your GNET device. Second in general it's a correct
>>> implementation of the normal DW GMAC v3.x multi-channels feature and
>>> will be useful for the DW GMACs with that feature enabled.
>> OK.
>>> 2. Create the Loongson GNET-specific
>>> stmmac_dma_ops.dma_interrupt()
>>> stmmac_dma_ops.init_chan()
>>> methods in the dwmac-loongson.c driver. Don't forget to move all the
>>> Loongson-specific macros from dwmac_dma.h to dwmac-loongson.c.
>> It's easy.
>>> 3. Create a Loongson GNET-specific platform setup method with the next
>>> semantics:
>>>      + allocate stmmac_dma_ops instance and initialize it with
>>>        dwmac1000_dma_ops.
>> Do this in dwmac1000-dma.c? Because this seems impossible to achieve in
>> dwmac-loongson.c：
>>
>>
>> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:606:47: error:
>> initializer element is not constant
>>    606 | const struct stmmac_dma_ops dwlgmac_dma_ops = dwmac1000_dma_ops;
>>>      + override the stmmac_dma_ops.{dma_interrupt, init_chan} with
>>>        the pointers to the methods defined in 2.
>> Likewise, where should I do this?
>>
>> Sorry. I seem to have misinterpreted your meaning again.
> No worries. Here is what I meant:
>
> 1. Declare the private Loongson GMAC data like this:
> struct loongson_data {
> 	struct stmmac_dma_ops dma_ops;
> };
> 2. Allocate the memory for the data in the framework of the Loongson
> GMAC device probe() method:
> loongson_dwmac_probe()
> {
> 	...
> 	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> 	if (!ld)
> 		return -ENOMEM;
> 	...
> 	ld->dma_ops = dwmac1000_dma_ops;
> 	ld->dma_ops.init_chan = loongson_gnat_dma_init_chan;
> 	ld->dma_ops.dma_interrupt = loongson_gnat_dma_interrupt;
> 	...
> 	plat->bsp_priv = ld;
> }
> 3. Define the Loongson-specific plat_stmmacenet_data.setup() method,
> which would re-init the stmmac_priv->synopsys_id with a correct value,
> allocate the DW *MAC hardware descriptor and pre-initialize it 'dma'
> field:
> static struct mac_device_info loongson_gnet_setup(void *apriv)
> {
> 	struct stmmac_priv *priv = apriv;
> 	struct mac_device_info *mac;
> 	struct loongson_data *ld;
>
> 	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
> 	if (!mac)
> 		return NULL;
>
> 	priv->synopsys_id = 0x37; // or whatever is a real version of your IP
>
> 	ld = priv->plat->bsp_priv;
> 	mac->dma = &ld->dma_ops;
>
> 	dwmac1000_setup(); // Or Pre-initialize the respective "mac" fields as it's done in dwmac1000_setup()
>
> 	return mac;
> }
> 4. Make sure the plat_stmmacenet_data->setup field is initialized with
> the Loongson GNAT-specific setup() method:
> static int loongson_gnet_data(struct pci_dev *pdev,
>                                struct plat_stmmacenet_data *plat)
> {
> 	...
> 	plat->setup = loongson_gnet_setup;
> 	...
> }
>
> That shall do what I described in by previous message.
>
> Note another platform which gets to define its own setup() method
> Sun8i:
> drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> although since it fully redefines the DMA-ops descriptor the only
> common part with your case is that it needs to have the setup() method
> too.

This method is great! I have been constantly modifying the code and 
experimenting

in the past two weeks, but we have too many types of hardware, and some 
of them

are not working now. I am analyzing the reasons, so I still need some 
time. :)


Thanks,

Yanteng

>
>>
>>
>>>      + allocate mac_device_info instance and initialize the
>>>        mac_device_info.dma field with a pointer to the new
>>>        stmmac_dma_ops instance.
>>>      + call dwmac1000_setup() or initialize mac_device_info in a way
>>>        it's done in dwmac1000_setup() (the later might be better so you
>>>        wouldn't need to export the dwmac1000_setup() function).
>>>      + override stmmac_priv.synopsys_id with a correct value.
>>>
>>> 4. Initialize plat_stmmacenet_data.setup() with the pointer to the
>>> method created in 3.
>>>
>>> If I didn't miss something stmmac_hwif_init() will call the
>>> platform-specific setup method right after fetching the SNPSVER field
>>> value. Your setup method will allocate mac_device_info structure then,
>>> will pre-initialize the GNET-specific DMA ops field and fix the
>>> Synopsys ID with a proper value (as described in 3 above). The rest of
>>> the ops descriptors will be initialized in the loop afterwards based
>>> on the specified device ID.
>> This doesn't seem to work because our device looks something like this:
> Please see my note above.
>
>> device     pci id   reversion    core version
>> LS7A        0x13       0x00       0x35/0x37
>> LS7A        0x13       0x01       0x35/0x37
>> LS2K        0x13       0x00       0x10
>> LS2K        0x13       0x01       0x10
> Not sure what you meant by providing this table to me and justifying
> that something wouldn't work. But it would have been much useful to
> provide a detailed description of what platforms and devices the
> current dwmac-loongson.c driver supports and what support you are
> trying to add. Cover-letter is a suitable place for it.
>
> In anyway the DW GMAC IP-core can't be 0x10. Seeing your device is
> having the multi-channels support it must have a version closer to
> 0x37 (the highest IP-core version is 3.73a). Please reach the hardware
> engineers to clarify what actual DW GMAC IP-core has been utilized in
> your case.
>
> -Serge(y)
>
>>
>> Thanks,
>>
>> Yanteng
>>
>>> -Serge(y)
>>>
>>>>    struct plat_stmmacenet_data {
>>>>    	int bus_id;
>>>> -- 
>>>> 2.31.4
>>>>


