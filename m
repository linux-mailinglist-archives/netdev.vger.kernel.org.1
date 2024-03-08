Return-Path: <netdev+bounces-78578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C9E875D06
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C89C1C20CB0
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 04:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3222C1AD;
	Fri,  8 Mar 2024 04:05:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF292C1A5
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 04:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709870715; cv=none; b=brmPW69pImyra1ehHuelySNzH8QbND4hsvJZwkUIlaRKbA4CJp7M/RFCiZ9cxmVEfT/WuYC0Wlc3pnzXPLBd3sv0/1mncCdk9ZWGL7RYe8HGvuyxk1a43WuRCD6yMeX69KlmZf+06aJF1s+ucg8ZXTLgIYkVl7v3Mfd8GQb70aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709870715; c=relaxed/simple;
	bh=FzPQ65Rs9WFXN0hh2E4jgO2iw6oN7u8hnJOr1EUiuoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pF3D93UfWdJbpHSpZOYLsQstYy0ikzxOKw+BeAc5U0cKaL2Ll+EYb6tvmbRCG51MYybk3lxR1Ic+Xu2SE2spuSckOxe+lNaje15Vaew0Cn2w2Z8f2aQuxqNjVQbQh5ZzvVisMNyQ6gByhqOqmqZUmHYxDhrb/LLrRmGBT32Db/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8BxOPB1juplPysWAA--.55295S3;
	Fri, 08 Mar 2024 12:05:09 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c5xjupllO1QAA--.18428S3;
	Fri, 08 Mar 2024 12:05:05 +0800 (CST)
Message-ID: <8f5d08e4-3623-462f-8a90-1a61acec75e3@loongson.cn>
Date: Fri, 8 Mar 2024 12:05:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 05/11] net: stmmac: dwmac-loongson: Add
 Loongson-specific register definitions
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e7e265e2d9d2f9d18d4633d037305cef3c5a18ca.1706601050.git.siyanteng@loongson.cn>
 <2gemgo5ghmtp3pmbi2mkdh4ll7lfncnkqe7xrr3ke3dhjkjsas@m2mfy5zlsmca>
 <544951f8-e910-40cd-8cb7-6fafc00f0bf6@loongson.cn>
 <sa5yimnaij2ucthjeouvgjsqmt2o54ye6pd6se5362lycqppvw@vf7rmdhlq6xd>
 <8986e189-2099-4d27-bd7c-d9c098530f1b@loongson.cn>
 <elp4xrucwj6yexhbh2huoq4n4n4zrdtdditpdmt5ikfz5hffau@wdpaoabvnfpr>
 <63005488-ece8-4ef6-9e31-b1980c2fab61@loongson.cn>
 <xmlv2ry7gvyxwocnt73nvri367yzvg2ynrvpswexj7ppxsqahc@dhyhnzpb23ys>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <xmlv2ry7gvyxwocnt73nvri367yzvg2ynrvpswexj7ppxsqahc@dhyhnzpb23ys>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx_c5xjupllO1QAA--.18428S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3CryUWw17WFWUtr15JF1rKrX_yoW8CFWkGo
	W5Jrn7Jr48Jr18Jr48J34kJryjvw15Xr45ArW8Jr1DJr13tw1UZFWUJr1UJF4YkF1UGr1U
	Ary8JF1kZF43Xr1rl-sFpf9Il3svdjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf
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


在 2024/3/7 21:44, Serge Semin 写道:
> On Thu, Mar 07, 2024 at 09:15:50PM +0800, Yanteng Si wrote:
>> Hi Serge,
>>
>>
>> Sorry for keeping you waiting for so long.
>>
>> 在 2024/2/24 02:50, Serge Semin 写道:
>>> On Fri, Feb 23, 2024 at 04:16:07PM +0800, Yanteng Si wrote:
>>>> Hi Serge,
>>>>
>>>> 在 2024/2/22 21:59, Serge Semin 写道:
>>>>> On Thu, Feb 22, 2024 at 09:39:49PM +0800, Yanteng Si wrote:
>>>>>> 在 2024/2/6 02:17, Serge Semin 写道:
>>>>>>> On Tue, Jan 30, 2024 at 04:48:17PM +0800, Yanteng Si wrote:
>>>>>>>> There are two types of Loongson DWGMAC. The first type shares the same
>>>>>>>> register definitions and has similar logic as dwmac1000. The second type
>>>>>>>> uses several different register definitions, we think it is necessary to
>>>>>>>> distinguish rx and tx, so we split these bits into two.
>>>>>>>>
>>>>>>>> Simply put, we split some single bit fields into double bits fileds:
>>>>>>>>
>>>>>>>>          Name              Tx          Rx
>>>>>>>>
>>>>>>>> DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
>>>>>>>> DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
>>>>>>>> DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
>>>>>>>> DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
>>>>>>>> DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
>>>>>>>>
>>>>>>>> Therefore, when using, TX and RX must be set at the same time.
>>>>>>>>
>>>>>>>> How to use them:
>>>>>>>> 1. Create the Loongson GNET-specific
>>>>>>>> stmmac_dma_ops.dma_interrupt()
>>>>>>>> stmmac_dma_ops.init_chan()
>>>>>>>> methods in the dwmac-loongson.c driver. Adding all the
>>>>>>>> Loongson-specific macros
>>>>>>>>
>>>>>>>> 2. Create a Loongson GNET-specific platform setup method with the next
>>>>>>>> semantics:
>>>>>>>>        + allocate stmmac_dma_ops instance and initialize it with
>>>>>>>>          dwmac1000_dma_ops.
>>>>>>>>        + override the stmmac_dma_ops.{dma_interrupt, init_chan} with
>>>>>>>>          the pointers to the methods defined in 2.
>>>>>>>>        + allocate mac_device_info instance and initialize the
>>>>>>>>          mac_device_info.dma field with a pointer to the new
>>>>>>>>          stmmac_dma_ops instance.
>>>>>>>>        + initialize mac_device_info in a way it's done in
>>>>>>>>          dwmac1000_setup().
>>>>>>>>
>>>>>>>> 3. Initialize plat_stmmacenet_data.setup() with the pointer to the
>>>>>>>> method created in 2.
>>>>>>>>
>>>>>>>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>>>>>>>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>>>>>>>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>>>>>>>> ---
>>>>>>>>      .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 248 ++++++++++++++++++
>>>>>>>>      1 file changed, 248 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>>>>> index e7ce027cc14e..3b3578318cc1 100644
>>>>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>>>>> @@ -8,6 +8,193 @@
>>>>>>>>      #include <linux/device.h>
>>>>>>>>      #include <linux/of_irq.h>
>>>>>>>>      #include "stmmac.h"
>>>>>>>> +#include "dwmac_dma.h"
>>>>>>>> +#include "dwmac1000.h"
>>>>>>>> +
>>>>>>>> +#define DMA_INTR_ENA_NIE_TX_LOONGSON 0x00040000	/* Normal Loongson Tx Summary */
>>>>>>>> +#define DMA_INTR_ENA_NIE_RX_LOONGSON 0x00020000	/* Normal Loongson Rx Summary */
>>>>>>>> +#define DMA_INTR_NORMAL_LOONGSON	(DMA_INTR_ENA_NIE_TX_LOONGSON | \
>>>>>>>> +			 DMA_INTR_ENA_NIE_RX_LOONGSON | DMA_INTR_ENA_RIE | \
>>>>>>>> +			 DMA_INTR_ENA_TIE)
>>>>>>>> +
>>>>>>>> +#define DMA_INTR_ENA_AIE_TX_LOONGSON 0x00010000	/* Abnormal Loongson Tx Summary */
>>>>>>>> +#define DMA_INTR_ENA_AIE_RX_LOONGSON 0x00008000	/* Abnormal Loongson Rx Summary */
>>>>>>>> +
>>>>>>>> +#define DMA_INTR_ABNORMAL_LOONGSON	(DMA_INTR_ENA_AIE_TX_LOONGSON | \
>>>>>>>> +				DMA_INTR_ENA_AIE_RX_LOONGSON | DMA_INTR_ENA_FBE | \
>>>>>>>> +				DMA_INTR_ENA_UNE)
>>>>>>>> +
>>>>>>>> +#define DMA_INTR_DEFAULT_MASK_LOONGSON	(DMA_INTR_NORMAL_LOONGSON | DMA_INTR_ABNORMAL_LOONGSON)
>>>>>>>> +
>>>>>>>> +#define DMA_STATUS_NIS_TX_LOONGSON	0x00040000	/* Normal Loongson Tx Interrupt Summary */
>>>>>>>> +#define DMA_STATUS_NIS_RX_LOONGSON	0x00020000	/* Normal Loongson Rx Interrupt Summary */
>>>>>>>> +
>>>>>>>> +#define DMA_STATUS_AIS_TX_LOONGSON	0x00010000	/* Abnormal Loongson Tx Interrupt Summary */
>>>>>>>> +#define DMA_STATUS_AIS_RX_LOONGSON	0x00008000	/* Abnormal Loongson Rx Interrupt Summary */
>>>>>>>> +
>>>>>>>> +#define DMA_STATUS_FBI_TX_LOONGSON	0x00002000	/* Fatal Loongson Tx Bus Error Interrupt */
>>>>>>>> +#define DMA_STATUS_FBI_RX_LOONGSON	0x00001000	/* Fatal Loongson Rx Bus Error Interrupt */
>>>>>>>> +
>>>>>>>> +#define DMA_STATUS_MSK_COMMON_LOONGSON		(DMA_STATUS_NIS_TX_LOONGSON | \
>>>>>>>> +					 DMA_STATUS_NIS_RX_LOONGSON | DMA_STATUS_AIS_TX_LOONGSON | \
>>>>>>>> +					 DMA_STATUS_AIS_RX_LOONGSON | DMA_STATUS_FBI_TX_LOONGSON | \
>>>>>>>> +					 DMA_STATUS_FBI_RX_LOONGSON)
>>>>>>> Max 80 chars per line please.
>>>>>> OK,
>>>>>>>> +
>>>>>>>> +#define DMA_STATUS_MSK_RX_LOONGSON		(DMA_STATUS_ERI | \
>>>>>>>> +					 DMA_STATUS_RWT | \
>>>>>>>> +					 DMA_STATUS_RPS | \
>>>>>>>> +					 DMA_STATUS_RU | \
>>>>>>>> +					 DMA_STATUS_RI | \
>>>>>>>> +					 DMA_STATUS_OVF | \
>>>>>>>> +					 DMA_STATUS_MSK_COMMON_LOONGSON)
>>>>>>>> +
>>>>>>>> +#define DMA_STATUS_MSK_TX_LOONGSON		(DMA_STATUS_ETI | \
>>>>>>>> +					 DMA_STATUS_UNF | \
>>>>>>>> +					 DMA_STATUS_TJT | \
>>>>>>>> +					 DMA_STATUS_TU | \
>>>>>>>> +					 DMA_STATUS_TPS | \
>>>>>>>> +					 DMA_STATUS_TI | \
>>>>>>>> +					 DMA_STATUS_MSK_COMMON_LOONGSON)
>>>>>>>> +
>>>>>>>> +struct loongson_data {
>>>>>>>> +	struct device *dev;
>>>>>>>> +	u32 lgmac_version;
>>>>>>>> +	struct stmmac_dma_ops dwlgmac_dma_ops;
>>>>>>> Just figured out we can do without this field being added to the
>>>>>>> private data. See my note in the loongson_setup() method.
>>>>>>>
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static void dwlgmac_dma_init_channel(struct stmmac_priv *priv,
>>>>>>> The "dwlgmac_" prefix is confusing. There is the DW XLGMAC IP-core for
>>>>>>> which the "dwxlgmac_" is more appropriate and "x" is easy to miss
>>>>>>> should your version of the prefix is met. Consider changing it to
>>>>>>> something like "loongson_gnet_".
>>>>>> OK,
>>>>>>>> +				     void __iomem *ioaddr,
>>>>>>>> +				     struct stmmac_dma_cfg *dma_cfg, u32 chan)
>>>>>>>> +{
>>>>>>>> +	u32 value;
>>>>>>>> +	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
>>>>>>>> +	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
>>>>>>>> +
>>>>>>>> +	/* common channel control register config */
>>>>>>>> +	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
>>>>>>>> +
>>>>>>>> +	/* Set the DMA PBL (Programmable Burst Length) mode.
>>>>>>>> +	 *
>>>>>>>> +	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
>>>>>>>> +	 * post 3.5 mode bit acts as 8*PBL.
>>>>>>>> +	 */
>>>>>>>> +	if (dma_cfg->pblx8)
>>>>>>>> +		value |= DMA_BUS_MODE_MAXPBL;
>>>>>>>> +	value |= DMA_BUS_MODE_USP;
>>>>>>>> +	value &= ~(DMA_BUS_MODE_PBL_MASK | DMA_BUS_MODE_RPBL_MASK);
>>>>>>>> +	value |= (txpbl << DMA_BUS_MODE_PBL_SHIFT);
>>>>>>>> +	value |= (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
>>>>>>>> +
>>>>>>>> +	/* Set the Fixed burst mode */
>>>>>>>> +	if (dma_cfg->fixed_burst)
>>>>>>>> +		value |= DMA_BUS_MODE_FB;
>>>>>>>> +
>>>>>>>> +	/* Mixed Burst has no effect when fb is set */
>>>>>>>> +	if (dma_cfg->mixed_burst)
>>>>>>>> +		value |= DMA_BUS_MODE_MB;
>>>>>>>> +
>>>>>>>> +	value |= DMA_BUS_MODE_ATDS;
>>>>>>>> +
>>>>>>>> +	if (dma_cfg->aal)
>>>>>>>> +		value |= DMA_BUS_MODE_AAL;
>>>>>>>> +
>>>>>>>> +	writel(value, ioaddr + DMA_BUS_MODE);
>>>>>>>> +
>>>>>>>> +	/* Mask interrupts by writing to CSR7 */
>>>>>>>> +	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr + DMA_INTR_ENA);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int dwlgmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>>>> The same note as above.
>>>>>>>
>>>>>>>> +				 struct stmmac_extra_stats *x, u32 chan, u32 dir)
>>>>>>>> +{
>>>>>>>> +	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[chan];
>>>>>>>> +	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
>>>>>>>> +	int ret = 0;
>>>>>>>> +	/* read the status register (CSR5) */
>>>>>>>> +	u32 nor_intr_status;
>>>>>>>> +	u32 abnor_intr_status;
>>>>>>>> +	u32 fb_intr_status;
>>>>>>> Reverse xmas tree please.
>>>>>>>
>>>>>>>> +	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
>>>>>>> Please move the initialization into a separate statement.
>>>>>> OK,
>>>>>>>> +
>>>>>>>> +#ifdef DWMAC_DMA_DEBUG
>>>>>>>> +	/* Enable it to monitor DMA rx/tx status in case of critical problems */
>>>>>>>> +	pr_debug("%s: [CSR5: 0x%08x]\n", __func__, intr_status);
>>>>>>>> +	show_tx_process_state(intr_status);
>>>>>>>> +	show_rx_process_state(intr_status);
>>>>>>>> +#endif
>>>>>>> This will cause a build-error if DWMAC_DMA_DEBUG is defined. Just drop
>>>>>>> it.
>>>>>>> OK,
>>>>>>>> +
>>>>>>>> +	if (dir == DMA_DIR_RX)
>>>>>>>> +		intr_status &= DMA_STATUS_MSK_RX_LOONGSON;
>>>>>>>> +	else if (dir == DMA_DIR_TX)
>>>>>>>> +		intr_status &= DMA_STATUS_MSK_TX_LOONGSON;
>>>>>>>> +
>>>>>>>> +	nor_intr_status = intr_status & (DMA_STATUS_NIS_TX_LOONGSON |
>>>>>>>> +		DMA_STATUS_NIS_RX_LOONGSON);
>>>>>>>> +	abnor_intr_status = intr_status & (DMA_STATUS_AIS_TX_LOONGSON |
>>>>>>>> +		DMA_STATUS_AIS_RX_LOONGSON);
>>>>>>>> +	fb_intr_status = intr_status & (DMA_STATUS_FBI_TX_LOONGSON |
>>>>>>>> +		DMA_STATUS_FBI_RX_LOONGSON);
>>>>>>>> +
>>>>>>>> +	/* ABNORMAL interrupts */
>>>>>>>> +	if (unlikely(abnor_intr_status)) {
>>>>>>>> +		if (unlikely(intr_status & DMA_STATUS_UNF)) {
>>>>>>>> +			ret = tx_hard_error_bump_tc;
>>>>>>>> +			x->tx_undeflow_irq++;
>>>>>>>> +		}
>>>>>>>> +		if (unlikely(intr_status & DMA_STATUS_TJT))
>>>>>>>> +			x->tx_jabber_irq++;
>>>>>>>> +
>>>>>>>> +		if (unlikely(intr_status & DMA_STATUS_OVF))
>>>>>>>> +			x->rx_overflow_irq++;
>>>>>>>> +
>>>>>>>> +		if (unlikely(intr_status & DMA_STATUS_RU))
>>>>>>>> +			x->rx_buf_unav_irq++;
>>>>>>>> +		if (unlikely(intr_status & DMA_STATUS_RPS))
>>>>>>>> +			x->rx_process_stopped_irq++;
>>>>>>>> +		if (unlikely(intr_status & DMA_STATUS_RWT))
>>>>>>>> +			x->rx_watchdog_irq++;
>>>>>>>> +		if (unlikely(intr_status & DMA_STATUS_ETI))
>>>>>>>> +			x->tx_early_irq++;
>>>>>>>> +		if (unlikely(intr_status & DMA_STATUS_TPS)) {
>>>>>>>> +			x->tx_process_stopped_irq++;
>>>>>>>> +			ret = tx_hard_error;
>>>>>>>> +		}
>>>>>>>> +		if (unlikely(intr_status & fb_intr_status)) {
>>>>>>>> +			x->fatal_bus_error_irq++;
>>>>>>>> +			ret = tx_hard_error;
>>>>>>>> +		}
>>>>>>>> +	}
>>>>>>>> +	/* TX/RX NORMAL interrupts */
>>>>>>>> +	if (likely(nor_intr_status)) {
>>>>>>>> +		if (likely(intr_status & DMA_STATUS_RI)) {
>>>>>>>> +			u32 value = readl(ioaddr + DMA_INTR_ENA);
>>>>>>>> +			/* to schedule NAPI on real RIE event. */
>>>>>>>> +			if (likely(value & DMA_INTR_ENA_RIE)) {
>>>>>>>> +				u64_stats_update_begin(&rxq_stats->syncp);
>>>>>>>> +				rxq_stats->rx_normal_irq_n++;
>>>>>>>> +				u64_stats_update_end(&rxq_stats->syncp);
>>>>>>>> +				ret |= handle_rx;
>>>>>>>> +			}
>>>>>>>> +		}
>>>>>>>> +		if (likely(intr_status & DMA_STATUS_TI)) {
>>>>>>>> +			u64_stats_update_begin(&txq_stats->syncp);
>>>>>>>> +			txq_stats->tx_normal_irq_n++;
>>>>>>>> +			u64_stats_update_end(&txq_stats->syncp);
>>>>>>>> +			ret |= handle_tx;
>>>>>>>> +		}
>>>>>>>> +		if (unlikely(intr_status & DMA_STATUS_ERI))
>>>>>>>> +			x->rx_early_irq++;
>>>>>>>> +	}
>>>>>>>> +	/* Optional hardware blocks, interrupts should be disabled */
>>>>>>>> +	if (unlikely(intr_status &
>>>>>>>> +		     (DMA_STATUS_GPI | DMA_STATUS_GMI | DMA_STATUS_GLI)))
>>>>>>>> +		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
>>>>>>>> +
>>>>>>>> +	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
>>>>>>>> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
>>>>>>>> +
>>>>>>>> +	return ret;
>>>>>>>> +}
>>>>>>>>      struct stmmac_pci_info {
>>>>>>>>      	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
>>>>>>>> @@ -121,6 +308,48 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>>>>>>>>      	.config = loongson_gmac_config,
>>>>>>>>      };
>>>>>>>> +static struct mac_device_info *loongson_setup(void *apriv)
>>>>>>> Consider using the GNET-specific prefix, like "loongson_gnet_".
>>>>>>>
>>>>>>>> +{
>>>>>>>> +	struct stmmac_priv *priv = apriv;
>>>>>>>> +	struct mac_device_info *mac;
>>>>>>>> +	struct loongson_data *ld;
>>>>>>>> +
>>>>>>>> +	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
>>>>>>>> +	if (!mac)
>>>>>>>> +		return NULL;
>>>>>>> What about devm_kzalloc()-ing the stmmac_dma_ops instance here and
>>>>>>> initializing it as it's done in the probe method? Thus ...
>>>>>>>
>>>>>>>> +
>>>>>>>> +	ld = priv->plat->bsp_priv;
>>>>>>>> +	mac->dma = &ld->dwlgmac_dma_ops;
>>>>>>> ... this can be replaced with:
>>>>>>>
>>>>>>> 	mac->dma = devm_kzalloc(priv->device, sizeof(*mac->dma), GFP_KERNEL);
>>>>>>> 	if (!mac->dma)
>>>>>>> 		return -ENOMEM;
>>>>>> Great, but It seems that we cannot return an int value here.
>>>>> Just
>>>>> 		return NULL;
>>>> OK,
>>>>> then.
>>>>>
>>>>>>> 	*mac->dma = dwmac1000_dma_ops;
>>>>>>> 	mac->dma->init_chan = loongson_gnet_dma_init_channel;
>>>>>>> 	mac->dma->dma_interrupt = loongson_gnet_dma_interrupt;
>>>> It seems that we still cannot do this because：
>>>> structmac_device_info{
>>>> ...
>>>> conststructstmmac_mmc_ops*mmc;
>>>> ...
>>>> }
>>>> some errors output:
>>>> error: assignment of read-only location '*mac->dma'
>>>> error: assignment of member 'init_chan' in read-only object
>>>> ...
>>> No, we can. Just use a temporary non-const pointer to stmmac_dma_ops:
>>>
>>> +static struct mac_device_info *loongson_gnet_setup(void *apriv)
>>> +{
>>> +	struct stmmac_priv *priv = apriv;
>>> +	struct mac_device_info *mac;
>>> +	struct stmmac_dma_ops *dma;
>>> +	struct loongson_data *ld;
>>> +
>>> +	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
>>> +	if (!mac)
>>> +		return NULL;
>>> +
>>> +	dma = devm_kzalloc(priv->device, sizeof(*dma), GFP_KERNEL);
>>> +	if (!mac->dma)
>> We have already modified it according to this comment. By the way, this
>> should be "if (!mac)",
> if (!dma)

Yes, you are right！

Thanks,

Yanteng

>
> -Serge(y)
>
>> otherwise the following part of the code will not work:
>>
>>> +		return NULL;
>>> +
>>> +	*dma = dwmac1000_dma_ops;
>>> +	dma->init_chan = loongson_gnet_dma_init_channel;
>>> +	dma->dma_interrupt = loongson_gnet_dma_interrupt;
>>> +	mac->dma = dma;
>>> +
>>> +	...
>> Tomorrow I will continue to modify other patches based on your comment.
>>
>> Thanks,
>>
>> Yanteng
>>
>>> -Serge(y)
>>>
>>>> Thanks,
>>>> Yanteng
>>>>>>>> +
>>>>>>>> +	/* Pre-initialize the respective "mac" fields as it's done in
>>>>>>>> +	 * dwmac1000_setup()
>>>>>>>> +	 */
>>>>>>>> +	priv->dev->priv_flags |= IFF_UNICAST_FLT;
>>>>>>>> +	mac->pcsr = priv->ioaddr;
>>>>>>>> +	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
>>>>>>>> +	mac->unicast_filter_entries = priv->plat->unicast_filter_entries;
>>>>>>>> +	mac->mcast_bits_log2 = 0;
>>>>>>>> +
>>>>>>>> +	if (mac->multicast_filter_bins)
>>>>>>>> +		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>>>>>>>> +
>>>>>>>> +	mac->link.duplex = GMAC_CONTROL_DM;
>>>>>>>> +	mac->link.speed10 = GMAC_CONTROL_PS;
>>>>>>>> +	mac->link.speed100 = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
>>>>>>>> +	mac->link.speed1000 = 0;
>>>>>>>> +	mac->link.speed_mask = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
>>>>>>>> +	mac->mii.addr = GMAC_MII_ADDR;
>>>>>>>> +	mac->mii.data = GMAC_MII_DATA;
>>>>>>>> +	mac->mii.addr_shift = 11;
>>>>>>>> +	mac->mii.addr_mask = 0x0000F800;
>>>>>>>> +	mac->mii.reg_shift = 6;
>>>>>>>> +	mac->mii.reg_mask = 0x000007C0;
>>>>>>>> +	mac->mii.clk_csr_shift = 2;
>>>>>>>> +	mac->mii.clk_csr_mask = GENMASK(5, 2);
>>>>>>>> +
>>>>>>>> +	return mac;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      static int loongson_dwmac_probe(struct pci_dev *pdev,
>>>>>>>>      				const struct pci_device_id *id)
>>>>>>>>      {
>>>>>>>> @@ -129,6 +358,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>>>>>>>      	struct stmmac_pci_info *info;
>>>>>>>>      	struct stmmac_resources res;
>>>>>>>>      	struct device_node *np;
>>>>>>>> +	struct loongson_data *ld;
>>>>>>> reverse xmas tree order please.
>>>>>>>
>>>>>>>>      	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>>>>>>>>      	if (!plat)
>>>>>>>> @@ -145,6 +375,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>>>>>>>      	if (!plat->dma_cfg)
>>>>>>>>      		return -ENOMEM;
>>>>>>>> +	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
>>>>>>>> +	if (!ld)
>>>>>>>> +		return -ENOMEM;
>>>>>>>> +
>>>>>>>>      	np = dev_of_node(&pdev->dev);
>>>>>>>>      	plat->mdio_node = of_get_child_by_name(np, "mdio");
>>>>>>>>      	if (plat->mdio_node) {
>>>>>>>> @@ -197,6 +431,20 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>>>>>>>      	if (ret)
>>>>>>>>      		goto err_disable_device;
>>>>>>>> +	ld->dev = &pdev->dev;
>>>>>>>> +	ld->lgmac_version = readl(res.addr + GMAC_VERSION) & 0xff;
>>>>>>> AFAICS the lgmac_version is unused in out of the probe() method
>>>>>>> context. What about locally defining it?
>>>>>> OK,
>>>>>>>> +
>>>>>>>> +	/* Activate loongson custom ip */
>>>>>>>> +	if (ld->lgmac_version < DWMAC_CORE_3_50) {
>>>>>>> Please define a new macro for the GNET MAC.
>>>>>> OK.
>>>>>>>> +		ld->dwlgmac_dma_ops = dwmac1000_dma_ops;
>>>>>>>> +		ld->dwlgmac_dma_ops.init_chan = dwlgmac_dma_init_channel;
>>>>>>>> +		ld->dwlgmac_dma_ops.dma_interrupt = dwlgmac_dma_interrupt;
>>>>>>> See my comment in the loongson_setup() method.
>>>>>> This will introduce a compilation warning:
>>>>>>
>>>>>> warning: returning 'int' from a function with return type 'struct
>>>>>> mac_device_info *' makes pointer from integer without a cast
>>>>>> [-Wint-conversion]
>>>>>>      418 |                 return -ENOMEM;
>>>>> stmmac_hwif_init() expects priv->plat->setup(priv) returning NULL
>>>>> if something wrong. As I suggested above just return NULL then if
>>>>> mac_device_info couldn't be allocated.
>>>>>
>>>>> -Serge(y)
>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Yanteng
>>>>>>
>>>>>>> -Serge(y)
>>>>>>>
>>>>>>>> +
>>>>>>>> +		plat->setup = loongson_setup;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	plat->bsp_priv = ld;
>>>>>>>> +
>>>>>>>>      	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>>>>>>>>      	if (ret)
>>>>>>>>      		goto err_disable_device;
>>>>>>>> -- 
>>>>>>>> 2.31.4
>>>>>>>>


