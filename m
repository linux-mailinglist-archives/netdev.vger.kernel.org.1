Return-Path: <netdev+bounces-74010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C64A85FA03
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CCBB2390B
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A682C134CC2;
	Thu, 22 Feb 2024 13:39:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81803A8E4
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609197; cv=none; b=VMyc94g8hmPcvgcUpBCNok/8Udp1mPO4O0NSd/PzlPRbB2VTgiP+LInMLDA8b0WJ9r3s7jWJBAzsLvcQSB40piXkZe5s77kwmzh76qgV73oGEwQdd8tTmXqsId4jpPYZaPoCSf+fcDCeymLRQQKDowsBJEjcTiQSkr6BglkrSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609197; c=relaxed/simple;
	bh=SY34Ve9BfSSciO0RpPUYBy/GNtPq8MvSi1VHjq5v8Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtfwtQSGsDy6ZnlhjaasYwnySvXie8JrUBr3niqchkdJ3qwS614EtEMdiFRYswkqTTc3o1eKh/sborf7vZP1N8lJetOdjs+mIplNbx90rYJSa4VPJBvCY9A7y8TbpF3GIJrTQ2mpbSPQEF3mQnvZ9WkpW0Ku18pIfUU9IEc//kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.193])
	by gateway (Coremail) with SMTP id _____8DxdfGoTtdl9D0QAA--.42388S3;
	Thu, 22 Feb 2024 21:39:52 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.193])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLs+lTtdlCt0+AA--.31291S3;
	Thu, 22 Feb 2024 21:39:50 +0800 (CST)
Message-ID: <544951f8-e910-40cd-8cb7-6fafc00f0bf6@loongson.cn>
Date: Thu, 22 Feb 2024 21:39:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 05/11] net: stmmac: dwmac-loongson: Add
 Loongson-specific register definitions
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e7e265e2d9d2f9d18d4633d037305cef3c5a18ca.1706601050.git.siyanteng@loongson.cn>
 <2gemgo5ghmtp3pmbi2mkdh4ll7lfncnkqe7xrr3ke3dhjkjsas@m2mfy5zlsmca>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <2gemgo5ghmtp3pmbi2mkdh4ll7lfncnkqe7xrr3ke3dhjkjsas@m2mfy5zlsmca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxLs+lTtdlCt0+AA--.31291S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3Aw4xJrWftFWkGw1xCFWUWrX_yoW8GFW3Jo
	Z8XFnavr4rGw18Grs7Kw1rJFW5Xw15Xw4ayFWfKw1DX39aya1DuFWfJw4fJFWayFyrKFyD
	Ca4rJa4kAFWSgws5l-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYh7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU2G-eUUUUU


在 2024/2/6 02:17, Serge Semin 写道:
> On Tue, Jan 30, 2024 at 04:48:17PM +0800, Yanteng Si wrote:
>> There are two types of Loongson DWGMAC. The first type shares the same
>> register definitions and has similar logic as dwmac1000. The second type
>> uses several different register definitions, we think it is necessary to
>> distinguish rx and tx, so we split these bits into two.
>>
>> Simply put, we split some single bit fields into double bits fileds:
>>
>>       Name              Tx          Rx
>>
>> DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
>> DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
>> DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
>> DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
>> DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
>>
>> Therefore, when using, TX and RX must be set at the same time.
>>
>> How to use them:
>> 1. Create the Loongson GNET-specific
>> stmmac_dma_ops.dma_interrupt()
>> stmmac_dma_ops.init_chan()
>> methods in the dwmac-loongson.c driver. Adding all the
>> Loongson-specific macros
>>
>> 2. Create a Loongson GNET-specific platform setup method with the next
>> semantics:
>>     + allocate stmmac_dma_ops instance and initialize it with
>>       dwmac1000_dma_ops.
>>     + override the stmmac_dma_ops.{dma_interrupt, init_chan} with
>>       the pointers to the methods defined in 2.
>>     + allocate mac_device_info instance and initialize the
>>       mac_device_info.dma field with a pointer to the new
>>       stmmac_dma_ops instance.
>>     + initialize mac_device_info in a way it's done in
>>       dwmac1000_setup().
>>
>> 3. Initialize plat_stmmacenet_data.setup() with the pointer to the
>> method created in 2.
>>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> ---
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 248 ++++++++++++++++++
>>   1 file changed, 248 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index e7ce027cc14e..3b3578318cc1 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -8,6 +8,193 @@
>>   #include <linux/device.h>
>>   #include <linux/of_irq.h>
>>   #include "stmmac.h"
>> +#include "dwmac_dma.h"
>> +#include "dwmac1000.h"
>> +
>> +#define DMA_INTR_ENA_NIE_TX_LOONGSON 0x00040000	/* Normal Loongson Tx Summary */
>> +#define DMA_INTR_ENA_NIE_RX_LOONGSON 0x00020000	/* Normal Loongson Rx Summary */
>> +#define DMA_INTR_NORMAL_LOONGSON	(DMA_INTR_ENA_NIE_TX_LOONGSON | \
>> +			 DMA_INTR_ENA_NIE_RX_LOONGSON | DMA_INTR_ENA_RIE | \
>> +			 DMA_INTR_ENA_TIE)
>> +
>> +#define DMA_INTR_ENA_AIE_TX_LOONGSON 0x00010000	/* Abnormal Loongson Tx Summary */
>> +#define DMA_INTR_ENA_AIE_RX_LOONGSON 0x00008000	/* Abnormal Loongson Rx Summary */
>> +
>> +#define DMA_INTR_ABNORMAL_LOONGSON	(DMA_INTR_ENA_AIE_TX_LOONGSON | \
>> +				DMA_INTR_ENA_AIE_RX_LOONGSON | DMA_INTR_ENA_FBE | \
>> +				DMA_INTR_ENA_UNE)
>> +
>> +#define DMA_INTR_DEFAULT_MASK_LOONGSON	(DMA_INTR_NORMAL_LOONGSON | DMA_INTR_ABNORMAL_LOONGSON)
>> +
>> +#define DMA_STATUS_NIS_TX_LOONGSON	0x00040000	/* Normal Loongson Tx Interrupt Summary */
>> +#define DMA_STATUS_NIS_RX_LOONGSON	0x00020000	/* Normal Loongson Rx Interrupt Summary */
>> +
>> +#define DMA_STATUS_AIS_TX_LOONGSON	0x00010000	/* Abnormal Loongson Tx Interrupt Summary */
>> +#define DMA_STATUS_AIS_RX_LOONGSON	0x00008000	/* Abnormal Loongson Rx Interrupt Summary */
>> +
>> +#define DMA_STATUS_FBI_TX_LOONGSON	0x00002000	/* Fatal Loongson Tx Bus Error Interrupt */
>> +#define DMA_STATUS_FBI_RX_LOONGSON	0x00001000	/* Fatal Loongson Rx Bus Error Interrupt */
>> +
>> +#define DMA_STATUS_MSK_COMMON_LOONGSON		(DMA_STATUS_NIS_TX_LOONGSON | \
>> +					 DMA_STATUS_NIS_RX_LOONGSON | DMA_STATUS_AIS_TX_LOONGSON | \
>> +					 DMA_STATUS_AIS_RX_LOONGSON | DMA_STATUS_FBI_TX_LOONGSON | \
>> +					 DMA_STATUS_FBI_RX_LOONGSON)
> Max 80 chars per line please.
OK,
>
>> +
>> +#define DMA_STATUS_MSK_RX_LOONGSON		(DMA_STATUS_ERI | \
>> +					 DMA_STATUS_RWT | \
>> +					 DMA_STATUS_RPS | \
>> +					 DMA_STATUS_RU | \
>> +					 DMA_STATUS_RI | \
>> +					 DMA_STATUS_OVF | \
>> +					 DMA_STATUS_MSK_COMMON_LOONGSON)
>> +
>> +#define DMA_STATUS_MSK_TX_LOONGSON		(DMA_STATUS_ETI | \
>> +					 DMA_STATUS_UNF | \
>> +					 DMA_STATUS_TJT | \
>> +					 DMA_STATUS_TU | \
>> +					 DMA_STATUS_TPS | \
>> +					 DMA_STATUS_TI | \
>> +					 DMA_STATUS_MSK_COMMON_LOONGSON)
>> +
>> +struct loongson_data {
>> +	struct device *dev;
>> +	u32 lgmac_version;
>> +	struct stmmac_dma_ops dwlgmac_dma_ops;
> Just figured out we can do without this field being added to the
> private data. See my note in the loongson_setup() method.
>
>> +};
>> +
>> +static void dwlgmac_dma_init_channel(struct stmmac_priv *priv,
> The "dwlgmac_" prefix is confusing. There is the DW XLGMAC IP-core for
> which the "dwxlgmac_" is more appropriate and "x" is easy to miss
> should your version of the prefix is met. Consider changing it to
> something like "loongson_gnet_".
OK,
>
>> +				     void __iomem *ioaddr,
>> +				     struct stmmac_dma_cfg *dma_cfg, u32 chan)
>> +{
>> +	u32 value;
>> +	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
>> +	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
>> +
>> +	/* common channel control register config */
>> +	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
>> +
>> +	/* Set the DMA PBL (Programmable Burst Length) mode.
>> +	 *
>> +	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
>> +	 * post 3.5 mode bit acts as 8*PBL.
>> +	 */
>> +	if (dma_cfg->pblx8)
>> +		value |= DMA_BUS_MODE_MAXPBL;
>> +	value |= DMA_BUS_MODE_USP;
>> +	value &= ~(DMA_BUS_MODE_PBL_MASK | DMA_BUS_MODE_RPBL_MASK);
>> +	value |= (txpbl << DMA_BUS_MODE_PBL_SHIFT);
>> +	value |= (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
>> +
>> +	/* Set the Fixed burst mode */
>> +	if (dma_cfg->fixed_burst)
>> +		value |= DMA_BUS_MODE_FB;
>> +
>> +	/* Mixed Burst has no effect when fb is set */
>> +	if (dma_cfg->mixed_burst)
>> +		value |= DMA_BUS_MODE_MB;
>> +
>> +	value |= DMA_BUS_MODE_ATDS;
>> +
>> +	if (dma_cfg->aal)
>> +		value |= DMA_BUS_MODE_AAL;
>> +
>> +	writel(value, ioaddr + DMA_BUS_MODE);
>> +
>> +	/* Mask interrupts by writing to CSR7 */
>> +	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr + DMA_INTR_ENA);
>> +}
>> +
>> +static int dwlgmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
> The same note as above.
>
>> +				 struct stmmac_extra_stats *x, u32 chan, u32 dir)
>> +{
>> +	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[chan];
>> +	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
>> +	int ret = 0;
>> +	/* read the status register (CSR5) */
>> +	u32 nor_intr_status;
>> +	u32 abnor_intr_status;
>> +	u32 fb_intr_status;
> Reverse xmas tree please.
>
>> +	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
> Please move the initialization into a separate statement.
OK,
>
>> +
>> +#ifdef DWMAC_DMA_DEBUG
>> +	/* Enable it to monitor DMA rx/tx status in case of critical problems */
>> +	pr_debug("%s: [CSR5: 0x%08x]\n", __func__, intr_status);
>> +	show_tx_process_state(intr_status);
>> +	show_rx_process_state(intr_status);
>> +#endif
> This will cause a build-error if DWMAC_DMA_DEBUG is defined. Just drop
> it.
> OK,
>> +
>> +	if (dir == DMA_DIR_RX)
>> +		intr_status &= DMA_STATUS_MSK_RX_LOONGSON;
>> +	else if (dir == DMA_DIR_TX)
>> +		intr_status &= DMA_STATUS_MSK_TX_LOONGSON;
>> +
>> +	nor_intr_status = intr_status & (DMA_STATUS_NIS_TX_LOONGSON |
>> +		DMA_STATUS_NIS_RX_LOONGSON);
>> +	abnor_intr_status = intr_status & (DMA_STATUS_AIS_TX_LOONGSON |
>> +		DMA_STATUS_AIS_RX_LOONGSON);
>> +	fb_intr_status = intr_status & (DMA_STATUS_FBI_TX_LOONGSON |
>> +		DMA_STATUS_FBI_RX_LOONGSON);
>> +
>> +	/* ABNORMAL interrupts */
>> +	if (unlikely(abnor_intr_status)) {
>> +		if (unlikely(intr_status & DMA_STATUS_UNF)) {
>> +			ret = tx_hard_error_bump_tc;
>> +			x->tx_undeflow_irq++;
>> +		}
>> +		if (unlikely(intr_status & DMA_STATUS_TJT))
>> +			x->tx_jabber_irq++;
>> +
>> +		if (unlikely(intr_status & DMA_STATUS_OVF))
>> +			x->rx_overflow_irq++;
>> +
>> +		if (unlikely(intr_status & DMA_STATUS_RU))
>> +			x->rx_buf_unav_irq++;
>> +		if (unlikely(intr_status & DMA_STATUS_RPS))
>> +			x->rx_process_stopped_irq++;
>> +		if (unlikely(intr_status & DMA_STATUS_RWT))
>> +			x->rx_watchdog_irq++;
>> +		if (unlikely(intr_status & DMA_STATUS_ETI))
>> +			x->tx_early_irq++;
>> +		if (unlikely(intr_status & DMA_STATUS_TPS)) {
>> +			x->tx_process_stopped_irq++;
>> +			ret = tx_hard_error;
>> +		}
>> +		if (unlikely(intr_status & fb_intr_status)) {
>> +			x->fatal_bus_error_irq++;
>> +			ret = tx_hard_error;
>> +		}
>> +	}
>> +	/* TX/RX NORMAL interrupts */
>> +	if (likely(nor_intr_status)) {
>> +		if (likely(intr_status & DMA_STATUS_RI)) {
>> +			u32 value = readl(ioaddr + DMA_INTR_ENA);
>> +			/* to schedule NAPI on real RIE event. */
>> +			if (likely(value & DMA_INTR_ENA_RIE)) {
>> +				u64_stats_update_begin(&rxq_stats->syncp);
>> +				rxq_stats->rx_normal_irq_n++;
>> +				u64_stats_update_end(&rxq_stats->syncp);
>> +				ret |= handle_rx;
>> +			}
>> +		}
>> +		if (likely(intr_status & DMA_STATUS_TI)) {
>> +			u64_stats_update_begin(&txq_stats->syncp);
>> +			txq_stats->tx_normal_irq_n++;
>> +			u64_stats_update_end(&txq_stats->syncp);
>> +			ret |= handle_tx;
>> +		}
>> +		if (unlikely(intr_status & DMA_STATUS_ERI))
>> +			x->rx_early_irq++;
>> +	}
>> +	/* Optional hardware blocks, interrupts should be disabled */
>> +	if (unlikely(intr_status &
>> +		     (DMA_STATUS_GPI | DMA_STATUS_GMI | DMA_STATUS_GLI)))
>> +		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
>> +
>> +	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
>> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
>> +
>> +	return ret;
>> +}
>>   
>>   struct stmmac_pci_info {
>>   	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
>> @@ -121,6 +308,48 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>>   	.config = loongson_gmac_config,
>>   };
>>   
>> +static struct mac_device_info *loongson_setup(void *apriv)
> Consider using the GNET-specific prefix, like "loongson_gnet_".
>
>> +{
>> +	struct stmmac_priv *priv = apriv;
>> +	struct mac_device_info *mac;
>> +	struct loongson_data *ld;
>> +
>> +	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
>> +	if (!mac)
>> +		return NULL;
> What about devm_kzalloc()-ing the stmmac_dma_ops instance here and
> initializing it as it's done in the probe method? Thus ...
>
>> +
>> +	ld = priv->plat->bsp_priv;
>> +	mac->dma = &ld->dwlgmac_dma_ops;
> ... this can be replaced with:
>
> 	mac->dma = devm_kzalloc(priv->device, sizeof(*mac->dma), GFP_KERNEL);
> 	if (!mac->dma)
> 		return -ENOMEM;
Great, but It seems that we cannot return an int value here.
>
> 	*mac->dma = dwmac1000_dma_ops;
> 	mac->dma->init_chan = loongson_gnet_dma_init_channel;
> 	mac->dma->dma_interrupt = loongson_gnet_dma_interrupt;
>
>> +
>> +	/* Pre-initialize the respective "mac" fields as it's done in
>> +	 * dwmac1000_setup()
>> +	 */
>> +	priv->dev->priv_flags |= IFF_UNICAST_FLT;
>> +	mac->pcsr = priv->ioaddr;
>> +	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
>> +	mac->unicast_filter_entries = priv->plat->unicast_filter_entries;
>> +	mac->mcast_bits_log2 = 0;
>> +
>> +	if (mac->multicast_filter_bins)
>> +		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>> +
>> +	mac->link.duplex = GMAC_CONTROL_DM;
>> +	mac->link.speed10 = GMAC_CONTROL_PS;
>> +	mac->link.speed100 = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
>> +	mac->link.speed1000 = 0;
>> +	mac->link.speed_mask = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
>> +	mac->mii.addr = GMAC_MII_ADDR;
>> +	mac->mii.data = GMAC_MII_DATA;
>> +	mac->mii.addr_shift = 11;
>> +	mac->mii.addr_mask = 0x0000F800;
>> +	mac->mii.reg_shift = 6;
>> +	mac->mii.reg_mask = 0x000007C0;
>> +	mac->mii.clk_csr_shift = 2;
>> +	mac->mii.clk_csr_mask = GENMASK(5, 2);
>> +
>> +	return mac;
>> +}
>> +
>>   static int loongson_dwmac_probe(struct pci_dev *pdev,
>>   				const struct pci_device_id *id)
>>   {
>> @@ -129,6 +358,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>   	struct stmmac_pci_info *info;
>>   	struct stmmac_resources res;
>>   	struct device_node *np;
>> +	struct loongson_data *ld;
> reverse xmas tree order please.
>
>>   
>>   	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>>   	if (!plat)
>> @@ -145,6 +375,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>   	if (!plat->dma_cfg)
>>   		return -ENOMEM;
>>   
>> +	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
>> +	if (!ld)
>> +		return -ENOMEM;
>> +
>>   	np = dev_of_node(&pdev->dev);
>>   	plat->mdio_node = of_get_child_by_name(np, "mdio");
>>   	if (plat->mdio_node) {
>> @@ -197,6 +431,20 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>   	if (ret)
>>   		goto err_disable_device;
>>   
>> +	ld->dev = &pdev->dev;
>> +	ld->lgmac_version = readl(res.addr + GMAC_VERSION) & 0xff;
> AFAICS the lgmac_version is unused in out of the probe() method
> context. What about locally defining it?
OK,
>
>> +
>> +	/* Activate loongson custom ip */
>> +	if (ld->lgmac_version < DWMAC_CORE_3_50) {
> Please define a new macro for the GNET MAC.
OK.
>
>> +		ld->dwlgmac_dma_ops = dwmac1000_dma_ops;
>> +		ld->dwlgmac_dma_ops.init_chan = dwlgmac_dma_init_channel;
>> +		ld->dwlgmac_dma_ops.dma_interrupt = dwlgmac_dma_interrupt;
> See my comment in the loongson_setup() method.

This will introduce a compilation warning:

warning: returning 'int' from a function with return type 'struct 
mac_device_info *' makes pointer from integer without a cast 
[-Wint-conversion]
   418 |                 return -ENOMEM;


Thanks,

Yanteng

>
> -Serge(y)
>
>> +
>> +		plat->setup = loongson_setup;
>> +	}
>> +
>> +	plat->bsp_priv = ld;
>> +
>>   	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>>   	if (ret)
>>   		goto err_disable_device;
>> -- 
>> 2.31.4
>>


