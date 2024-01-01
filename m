Return-Path: <netdev+bounces-60685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E516F82132B
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 07:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10B01C211D7
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 06:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07091376;
	Mon,  1 Jan 2024 06:58:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F001375
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.252])
	by gateway (Coremail) with SMTP id _____8Bxnut7YpJlHeYAAA--.3875S3;
	Mon, 01 Jan 2024 14:58:03 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.252])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxzuRiYpJlU_QTAA--.62365S3;
	Mon, 01 Jan 2024 14:58:01 +0800 (CST)
Message-ID: <4f97d720-cd7c-4fce-9b65-1f73073afdae@loongson.cn>
Date: Mon, 1 Jan 2024 14:57:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/9] net: stmmac: Add multi-channel supports
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <d329a3315a3f274bc64c229d645f81066eb5cefe.1702990507.git.siyanteng@loongson.cn>
 <vxcfrxtbfu4pya56m22icnizsyjzqqha5blzb7zpexqcur56uh@uv6vsjf77npa>
 <d0bec226-eb1b-4c27-a923-07fc582c4c39@loongson.cn>
 <fjsedubpv6jzv3h7kjkgy5stfjbgdqlicfbrhcglttjjp5w3u6@lqjqhjfv2nn4>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <fjsedubpv6jzv3h7kjkgy5stfjbgdqlicfbrhcglttjjp5w3u6@lqjqhjfv2nn4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxzuRiYpJlU_QTAA--.62365S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3CrW3JF1ktFWfZrWrZF17CFX_yoW8Ww17Zo
	WfJrn3Wr1Sgw18urn7K34vqryjqw15Xw45Cry8Wr4Dua92yayDArW0qrZ3Ja17JF4xC3W7
	Z348Xa1qvFWaqF15l-sFpf9Il3svdjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYl7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r1j6r4UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
	JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2023/12/30 19:25, Serge Semin 写道:
> Hi Yanteng
>
> On Fri, Dec 29, 2023 at 06:33:52PM +0800, Yanteng Si wrote:
>> 在 2023/12/21 06:36, Serge Semin 写道:
>>> On Tue, Dec 19, 2023 at 10:17:07PM +0800, Yanteng Si wrote:
>>>> Loongson platforms use a DWGMAC which supports multi-channel.
>>>>
>>>> Added dwmac1000_dma_init_channel() and init_chan(), factor out
>>>> all the channel-specific setups from dwmac1000_dma_init() to the
>>>> new function dma_config(), then distinguish dma initialization
>>>> and multi-channel initialization through different parameters.
>>>>
>>>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>>>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>>>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>>>> ---
>>>>    .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 55 ++++++++++++++-----
>>>>    .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 17 ++++++
>>>>    .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 30 +++++-----
>>>>    3 files changed, 74 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>>>> index 5e80d3eec9db..0fb48e683970 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>>>> @@ -12,7 +12,8 @@
>>>>      Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>>>>    *******************************************************************************/
>>>> -#include <asm/io.h>
>>>> +#include <linux/io.h>
>>>> +#include "stmmac.h"
>>>>    #include "dwmac1000.h"
>>>>    #include "dwmac_dma.h"
>>>> @@ -70,13 +71,16 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
>>>>    	writel(value, ioaddr + DMA_AXI_BUS_MODE);
>>>>    }
>>>> -static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>> -			       struct stmmac_dma_cfg *dma_cfg, int atds)
>>>> +static void dma_config(void __iomem *modeaddr, void __iomem *enaddr,
>>>> +					   struct stmmac_dma_cfg *dma_cfg, u32 dma_intr_mask,
>>>> +					   int atds)
>>> Please make sure the arguments are aligned with the function open
>>> parenthesis taking into account that tabs are of _8_ chars:
>>> Documentation/process/coding-style.rst.
>> OK.
>>>>    {
>>>> -	u32 value = readl(ioaddr + DMA_BUS_MODE);
>>>> +	u32 value;
>>>>    	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
>>>>    	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
>>>> +	value = readl(modeaddr);
>>>> +
>>>>    	/*
>>>>    	 * Set the DMA PBL (Programmable Burst Length) mode.
>>>>    	 *
>>>> @@ -104,10 +108,34 @@ static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    	if (dma_cfg->aal)
>>>>    		value |= DMA_BUS_MODE_AAL;
>>>> -	writel(value, ioaddr + DMA_BUS_MODE);
>>>> +	writel(value, modeaddr);
>>>> +	writel(dma_intr_mask, enaddr);
>>>> +}
>>>> +
>>>> +static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>> +							   struct stmmac_dma_cfg *dma_cfg, int atds)
>>>> +{
>>>> +	u32 dma_intr_mask;
>>>>    	/* Mask interrupts by writing to CSR7 */
>>>> -	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
>>>> +	dma_intr_mask = DMA_INTR_DEFAULT_MASK;
>>>> +
>>>> +	dma_config(ioaddr + DMA_BUS_MODE, ioaddr + DMA_INTR_ENA,
>>>> +			  dma_cfg, dma_intr_mask, atds);
>>>> +}
>>>> +
>>>> +static void dwmac1000_dma_init_channel(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>> +									   struct stmmac_dma_cfg *dma_cfg, u32 chan)
>>>> +{
>>>> +	u32 dma_intr_mask;
>>>> +
>>>> +	/* Mask interrupts by writing to CSR7 */
>>>> +	dma_intr_mask = DMA_INTR_DEFAULT_MASK;
>>>> +
>>>> +	if (dma_cfg->multi_msi_en)
>>>> +		dma_config(ioaddr + DMA_CHAN_BUS_MODE(chan),
>>>> +					ioaddr + DMA_CHAN_INTR_ENA(chan), dma_cfg,
>>> Why so complicated? stmmac_init_chan() is always supposed to be called
>>> in the same context as stmmac_dma_init() (stmmac_xdp_open() is wrong
>>> in not doing that). Seeing DW GMAC v3.x multi-channels feature is
>>> implemented as multiple sets of the same CSRs (except AV traffic
>>> control CSRs specific to channels 1 and higher which are left unused
>>> here anyway) you can just drop the stmmac_dma_ops.init() callback and
>>> convert dwmac1000_dma_init() to being dwmac1000_dma_init_channel()
>>> with no significant modifications:
>>>
>>> < you wouldn't need to have a separate dma_config() method.
>>> < you wouldn't need to check for the dma_cfg->multi_msi_en flag state
>>> since the stmmac_init_chan() method is called for as many times as
>>> there are channels available (at least 1 channel always exists).
>>> < just add atds argument.
>>> < just convert the method to using the chan-dependent CSR macros.
>> Yes, you are right.
>>
>>>> +					dma_intr_mask, dma_cfg->multi_msi_en);
>>>                                                                   ^
>>>                 +-------------------------------------------------+
>>> This is wrong + ATDS flag means Alternative Descriptor Size. This flag
>>> enables the 8 dword DMA-descriptors size with some DMA-desc fields
>>> semantics changed (see enh_desc.c and norm_desc.c). It's useful for
>>> PTP Timestamping, VLANs, AV feature, L3/L4 filtering, CSum offload
>>> Type 2 (if any of that available). It has nothing to do with the
>>> separate DMA IRQs. Just convert the stmmac_dma_ops.dma_init() callback
>>> to accepting the atds flag as an additional argument, use it here to
>>> activate the extended descriptor size and make sure the atds flag is
>>> passed to the stmmac_init_chan() method in the respective source code.
>> OK.
>>>>    }
>>>>    static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
>>>> @@ -116,7 +144,7 @@ static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
>>>>    				  dma_addr_t dma_rx_phy, u32 chan)
>>>>    {
>>>>    	/* RX descriptor base address list must be written into DMA CSR3 */
>>>> -	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR);
>>>> +	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_CHAN_RCV_BASE_ADDR(chan));
>>>>    }
>>>>    static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
>>>> @@ -125,7 +153,7 @@ static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
>>>>    				  dma_addr_t dma_tx_phy, u32 chan)
>>>>    {
>>>>    	/* TX descriptor base address list must be written into DMA CSR4 */
>>>> -	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_TX_BASE_ADDR);
>>>> +	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_CHAN_TX_BASE_ADDR(chan));
>>>>    }
>>>>    static u32 dwmac1000_configure_fc(u32 csr6, int rxfifosz)
>>>> @@ -153,7 +181,7 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>>>>    					    void __iomem *ioaddr, int mode,
>>>>    					    u32 channel, int fifosz, u8 qmode)
>>>>    {
>>>> -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
>>>> +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
>>>>    	if (mode == SF_DMA_MODE) {
>>>>    		pr_debug("GMAC: enable RX store and forward mode\n");
>>>> @@ -175,14 +203,14 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>>>>    	/* Configure flow control based on rx fifo size */
>>>>    	csr6 = dwmac1000_configure_fc(csr6, fifosz);
>>>> -	writel(csr6, ioaddr + DMA_CONTROL);
>>>> +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
>>>>    }
>>>>    static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
>>>>    					    void __iomem *ioaddr, int mode,
>>>>    					    u32 channel, int fifosz, u8 qmode)
>>>>    {
>>>> -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
>>>> +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
>>>>    	if (mode == SF_DMA_MODE) {
>>>>    		pr_debug("GMAC: enable TX store and forward mode\n");
>>>> @@ -209,7 +237,7 @@ static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
>>>>    			csr6 |= DMA_CONTROL_TTC_256;
>>>>    	}
>>>> -	writel(csr6, ioaddr + DMA_CONTROL);
>>>> +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
>>>>    }
>>>>    static void dwmac1000_dump_dma_regs(struct stmmac_priv *priv,
>>>> @@ -271,12 +299,13 @@ static int dwmac1000_get_hw_feature(void __iomem *ioaddr,
>>>>    static void dwmac1000_rx_watchdog(struct stmmac_priv *priv,
>>>>    				  void __iomem *ioaddr, u32 riwt, u32 queue)
>>>>    {
>>>> -	writel(riwt, ioaddr + DMA_RX_WATCHDOG);
>>>> +	writel(riwt, ioaddr + DMA_CHAN_RX_WATCHDOG(queue));
>>>>    }
>>>>    const struct stmmac_dma_ops dwmac1000_dma_ops = {
>>>>    	.reset = dwmac_dma_reset,
>>>>    	.init = dwmac1000_dma_init,
>>> This could be dropped. See my comment above.
>> OK,  I've tried this and it works.
>>>> +	.init_chan = dwmac1000_dma_init_channel,
>>>>    	.init_rx_chan = dwmac1000_dma_init_rx,
>>>>    	.init_tx_chan = dwmac1000_dma_init_tx,
>>>>    	.axi = dwmac1000_dma_axi,
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>>>> index e7aef136824b..395d5e4c3922 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>>>> @@ -148,6 +148,9 @@
>>>>    					 DMA_STATUS_TI | \
>>>>    					 DMA_STATUS_MSK_COMMON)
>>>> +/* Following DMA defines are chanels oriented */
>>> s/chanels/channels
>> OK!
>>>> +#define DMA_CHAN_OFFSET			0x100
>>> DMA_CHAN_BASE_OFFSET? to be looking the same as in DW QoS Eth GMAC
>>> v4.x/v5.x (dwmac4_dma.h).
>> OK
>>>> +
>>>>    #define NUM_DWMAC100_DMA_REGS	9
>>>>    #define NUM_DWMAC1000_DMA_REGS	23
>>>>    #define NUM_DWMAC4_DMA_REGS	27
>>>> @@ -170,4 +173,18 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    			struct stmmac_extra_stats *x, u32 chan, u32 dir);
>>>>    int dwmac_dma_reset(void __iomem *ioaddr);
>>>> +static inline u32 dma_chan_base_addr(u32 base, u32 chan)
>>>> +{
>>>> +	return base + chan * DMA_CHAN_OFFSET;
>>>> +}
>>>> +
>>>> +#define DMA_CHAN_XMT_POLL_DEMAND(chan)	dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan)
>>>> +#define DMA_CHAN_INTR_ENA(chan)		dma_chan_base_addr(DMA_INTR_ENA, chan)
>>>> +#define DMA_CHAN_CONTROL(chan)		dma_chan_base_addr(DMA_CONTROL, chan)
>>>> +#define DMA_CHAN_STATUS(chan)		dma_chan_base_addr(DMA_STATUS, chan)
>>>> +#define DMA_CHAN_BUS_MODE(chan)		dma_chan_base_addr(DMA_BUS_MODE, chan)
>>>> +#define DMA_CHAN_RCV_BASE_ADDR(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)
>>>> +#define DMA_CHAN_TX_BASE_ADDR(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)
>>>> +#define DMA_CHAN_RX_WATCHDOG(chan)	dma_chan_base_addr(DMA_RX_WATCHDOG, chan)
>>>> +
>>>>    #endif /* __DWMAC_DMA_H__ */
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>>>> index 2f0df16fb7e4..968801c694e9 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>>>> @@ -31,63 +31,63 @@ int dwmac_dma_reset(void __iomem *ioaddr)
>>>>    void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
>>>>    				   void __iomem *ioaddr, u32 chan)
>>>>    {
>>>> -	writel(1, ioaddr + DMA_XMT_POLL_DEMAND);
>>>> +	writel(1, ioaddr + DMA_CHAN_XMT_POLL_DEMAND(chan));
>>>>    }
>>>>    void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    			  u32 chan, bool rx, bool tx)
>>>>    {
>>>> -	u32 value = readl(ioaddr + DMA_INTR_ENA);
>>>> +	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
>>>>    	if (rx)
>>>>    		value |= DMA_INTR_DEFAULT_RX;
>>>>    	if (tx)
>>>>    		value |= DMA_INTR_DEFAULT_TX;
>>>> -	writel(value, ioaddr + DMA_INTR_ENA);
>>>> +	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
>>>>    }
>>>>    void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    			   u32 chan, bool rx, bool tx)
>>>>    {
>>>> -	u32 value = readl(ioaddr + DMA_INTR_ENA);
>>>> +	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
>>>>    	if (rx)
>>>>    		value &= ~DMA_INTR_DEFAULT_RX;
>>>>    	if (tx)
>>>>    		value &= ~DMA_INTR_DEFAULT_TX;
>>>> -	writel(value, ioaddr + DMA_INTR_ENA);
>>>> +	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
>>>>    }
>>>>    void dwmac_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    			u32 chan)
>>>>    {
>>>> -	u32 value = readl(ioaddr + DMA_CONTROL);
>>>> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>>>>    	value |= DMA_CONTROL_ST;
>>>> -	writel(value, ioaddr + DMA_CONTROL);
>>>> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>>>>    }
>>>>    void dwmac_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
>>>>    {
>>>> -	u32 value = readl(ioaddr + DMA_CONTROL);
>>>> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>>>>    	value &= ~DMA_CONTROL_ST;
>>>> -	writel(value, ioaddr + DMA_CONTROL);
>>>> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>>>>    }
>>>>    void dwmac_dma_start_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    			u32 chan)
>>>>    {
>>>> -	u32 value = readl(ioaddr + DMA_CONTROL);
>>>> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>>>>    	value |= DMA_CONTROL_SR;
>>>> -	writel(value, ioaddr + DMA_CONTROL);
>>>> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>>>>    }
>>>>    void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
>>>>    {
>>>> -	u32 value = readl(ioaddr + DMA_CONTROL);
>>>> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>>>>    	value &= ~DMA_CONTROL_SR;
>>>> -	writel(value, ioaddr + DMA_CONTROL);
>>>> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>>>>    }
>>>>    #ifdef DWMAC_DMA_DEBUG
>>>> @@ -167,7 +167,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
>>>>    	int ret = 0;
>>>>    	/* read the status register (CSR5) */
>>>> -	u32 intr_status = readl(ioaddr + DMA_STATUS);
>>>> +	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
>>>>    #ifdef DWMAC_DMA_DEBUG
>>>>    	/* Enable it to monitor DMA rx/tx status in case of critical problems */
>>>> @@ -237,7 +237,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
>>>>    	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
>>>> -	writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
>>>> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
>>> Em, please explain the mask change. Bits CSR5[17:28] are defined as RO
>> I'm not sure I can explain it, but it goes something like this：
>>
>> We moved these bits up because we split the reception and transmission of
>> interrupts.
>>
>> 28    Reserved
>> 27:25 EB
>> 24:22 TS
>> 21:19 RS
>> 18    NTIS
> I see. Thanks for clarification. Let's postpone the IRQ mask
> discussion for the next review round.
OK.
>
>>
>>> on a normal DW GMAC. Anyway it seems like the mask changes belongs to
>>> the patch 5/9.
>> Yes, I will try.
>>>
>>> Except the last comment, AFAICS this patch provides a generic DW GMAC
>>> v3.x multi-channel support. Despite of several issues noted above the
>>> change in general looks very good.
>> Thanks, the next version of this patch will only have changes related to
>> dma_chan_base_addr.
>>
>>
>> * dwmac1000_dma_init will be restored.
>>
>> * dwmac1000_dma_init_channel() will be moved to dwmac-loongson.c.
> No. That's not what I meant. I said that this patch looks _generic_
> enough to be applied (with my notes taken into account) in the common
> dwmac1000_dma.c code! It provides useful multi-DMA-channels support in
> a way it's implemented by the _generic_ DW GMAC v3.x IP-core. From
> that perspective the change will be useful for all users which DW
> GMACs support the multi-channels feature. Please fix the patch based
> on my notes and repost it as a part of your series. We'll figure out
> what to do with the IRQ mask on the next review round.

Em, I see.

In dwmac1000_dma.c:

1. Convert dwmac1000_dma_init() to being dwmac1000_dma_init_channel(); 
（No DMA_INTR_DEFAULT_MASK_LOONGSON）

2. Drop the stmmac_dma_ops.init() callback;

3. Leave other parts of the patch unchanged, such as DMA_CHAN_BASE_OFFSET;

In dwmac-loongson.c：

1. Create the Loongson GNET-specific stmmac_dma_ops.dma_interrupt() and stmmac_dma_ops.init_chan(); （With DMA_INTR_DEFAULT_MASK_LOONGSON）
2. Move all the Loongson-specific macros from dwmac_dma.h to here;
3. Follow your comments in Patch 5 to continue;

Right?


Thanks,
Yanteng

>
> -Serge(y)
>
>>
>> Thanks for your review!
>>
>>
>> Thanks,
>>
>> Yanteng
>>
>>> -Serge(y)
>>>
>>>>    	return ret;
>>>>    }
>>>> -- 
>>>> 2.31.4
>>>>


