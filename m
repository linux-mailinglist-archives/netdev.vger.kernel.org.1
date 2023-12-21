Return-Path: <netdev+bounces-59582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C3D81B73C
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 14:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F83628203D
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150D174087;
	Thu, 21 Dec 2023 13:21:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757A8745CC
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.252])
	by gateway (Coremail) with SMTP id _____8DxVPDgO4RliHkDAA--.17725S3;
	Thu, 21 Dec 2023 21:21:36 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.252])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxneTeO4RljtQDAA--.20176S3;
	Thu, 21 Dec 2023 21:21:35 +0800 (CST)
Message-ID: <76902cda-3dd1-4245-bd6d-ee3090235005@loongson.cn>
Date: Thu, 21 Dec 2023 21:21:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/9] net: stmmac: Pass stmmac_priv and chan in
 some callbacks
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <8414049581ed11a2466dc75e0e1f2ef4be7d0fd9.1702990507.git.siyanteng@loongson.cn>
 <zjyo2kibcrgirfc5pcvbeqbq2dmhpjkilvq3zwsmugee2gc3cf@e7dhxkrr3ha2>
 <8eacd500-b092-4031-91d1-f2edccf18d21@loongson.cn>
 <grfyq7hezxecs3q6lcqhpukc223pfh6cdyrsoddwelli76667d@47njoehuvkqo>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <grfyq7hezxecs3q6lcqhpukc223pfh6cdyrsoddwelli76667d@47njoehuvkqo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxneTeO4RljtQDAA--.20176S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3ZrWkCr4DCr4fWw1rZFWUtrc_yoW8Gr17Ao
	WfAFnxGayagw15uryvkw1kJryaqwnxXw18CrW7Cw4v9ayIya1Yy342q34fXay7JF1xWrW7
	Za48JFWqvF47KF1Dl-sFpf9Il3svdjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7BMNUUUUU=


在 2023/12/21 20:53, Serge Semin 写道:
> On Thu, Dec 21, 2023 at 07:50:08PM +0800, Yanteng Si wrote:
>> 在 2023/12/21 02:18, Serge Semin 写道:
>>> Hi Yanteng
>>>
>>> On Tue, Dec 19, 2023 at 10:17:04PM +0800, Yanteng Si wrote:
>>>> Loongson GMAC and GNET have some special features. To prepare for that,
>>>> pass stmmac_priv and chan to more callbacks, and adjust the callbacks
>>>> accordingly.
>>>>
>>>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>>>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>>>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>>>> ---
>>>>    drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c   |  2 +-
>>>>    drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c |  2 +-
>>>>    drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c  |  2 +-
>>>>    drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c    |  2 +-
>>>>    drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h     |  3 ++-
>>>>    drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c     |  3 ++-
>>>>    drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c  |  2 +-
>>>>    drivers/net/ethernet/stmicro/stmmac/hwif.h          | 11 ++++++-----
>>>>    drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   |  6 +++---
>>>>    9 files changed, 18 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>>>> index 137741b94122..7cdfa0bdb93a 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>>>> @@ -395,7 +395,7 @@ static void sun8i_dwmac_dma_start_tx(struct stmmac_priv *priv,
>>>>    	writel(v, ioaddr + EMAC_TX_CTL1);
>>>>    }
>>>> -static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
>>>> +static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
>>> As Simon correctly noted this prototype is incomplete. Although AFAICS
>>> you never use a pointer to stmmac_priv in this method. So I guess you
>>> could fix the callback prototype instead.
>>>
>>>>    {
>>>>    	u32 v;
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>>>> index daf79cdbd3ec..5e80d3eec9db 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>>>> @@ -70,7 +70,7 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
>>>>    	writel(value, ioaddr + DMA_AXI_BUS_MODE);
>>>>    }
>>>> -static void dwmac1000_dma_init(void __iomem *ioaddr,
>>>> +static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    			       struct stmmac_dma_cfg *dma_cfg, int atds)
>>>>    {
>>>>    	u32 value = readl(ioaddr + DMA_BUS_MODE);
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
>>>> index dea270f60cc3..105e7d4d798f 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
>>>> @@ -18,7 +18,7 @@
>>>>    #include "dwmac100.h"
>>>>    #include "dwmac_dma.h"
>>>> -static void dwmac100_dma_init(void __iomem *ioaddr,
>>>> +static void dwmac100_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    			      struct stmmac_dma_cfg *dma_cfg, int atds)
>>>>    {
>>>>    	/* Enable Application Access by writing to DMA CSR0 */
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>>>> index 84d3a8551b03..dc54c4e793fd 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>>>> @@ -152,7 +152,7 @@ static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
>>>>    	       ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
>>>>    }
>>>> -static void dwmac4_dma_init(void __iomem *ioaddr,
>>>> +static void dwmac4_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    			    struct stmmac_dma_cfg *dma_cfg, int atds)
>>>>    {
>>>>    	u32 value = readl(ioaddr + DMA_SYS_BUS_MODE);
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>>>> index 72672391675f..e7aef136824b 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>>>> @@ -152,7 +152,8 @@
>>>>    #define NUM_DWMAC1000_DMA_REGS	23
>>>>    #define NUM_DWMAC4_DMA_REGS	27
>>>> -void dwmac_enable_dma_transmission(void __iomem *ioaddr);
>>>> +void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
>>>> +				   void __iomem *ioaddr, u32 chan);
>>>>    void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    			  u32 chan, bool rx, bool tx);
>>>>    void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>>>> index 7907d62d3437..2f0df16fb7e4 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>>>> @@ -28,7 +28,8 @@ int dwmac_dma_reset(void __iomem *ioaddr)
>>>>    }
>>>>    /* CSR1 enables the transmit DMA to check for new descriptor */
>>>> -void dwmac_enable_dma_transmission(void __iomem *ioaddr)
>>>> +void dwmac_enable_dma_transmission(struct stmmac_priv *priv,
>>>> +				   void __iomem *ioaddr, u32 chan)
>>>>    {
>>>>    	writel(1, ioaddr + DMA_XMT_POLL_DEMAND);
>>>>    }
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
>>>> index 3cde695fec91..a06f9573876f 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
>>>> @@ -19,7 +19,7 @@ static int dwxgmac2_dma_reset(void __iomem *ioaddr)
>>>>    				  !(value & XGMAC_SWR), 0, 100000);
>>>>    }
>>>> -static void dwxgmac2_dma_init(void __iomem *ioaddr,
>>>> +static void dwxgmac2_dma_init(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    			      struct stmmac_dma_cfg *dma_cfg, int atds)
>>>>    {
>>>>    	u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
>>>> index 7be04b54738b..a44aa3671fb8 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
>>>> @@ -175,8 +175,8 @@ struct dma_features;
>>>>    struct stmmac_dma_ops {
>>>>    	/* DMA core initialization */
>>>>    	int (*reset)(void __iomem *ioaddr);
>>>> -	void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg,
>>>> -		     int atds);
>>>> +	void (*init)(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>> +		     struct stmmac_dma_cfg *dma_cfg, int atds);
>>> There is a good chance this change is also unnecessary. I'll post my
>>> comment about that to Patch 4/9.
>>>
>>>>    	void (*init_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    			  struct stmmac_dma_cfg *dma_cfg, u32 chan);
>>>>    	void (*init_rx_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>> @@ -198,7 +198,8 @@ struct stmmac_dma_ops {
>>>>    	/* To track extra statistic (if supported) */
>>>>    	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
>>>>    				  void __iomem *ioaddr);
>>>> -	void (*enable_dma_transmission) (void __iomem *ioaddr);
>>>> +	void (*enable_dma_transmission)(struct stmmac_priv *priv,
>>>> +					void __iomem *ioaddr, u32 chan);
>>> Why do you need the pointer to the stmmac_priv structure instance
>>> here? I failed to find a place you using it in the subsequent patches.
>> it's here：
>>
>> @@ -70,7 +70,7 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct
>> stmmac_axi *axi)
>>       writel(value, ioaddr + DMA_AXI_BUS_MODE);
>>   }
>>
>
>> -static void dwmac1000_dma_init(void __iomem *ioaddr,
>> +static void dwmac1000_dma_init(struct stmmac_priv *priv, void __iomem
> Em, my comment was about enable_dma_transmission() ! I don't see you
> using the stmmac_priv pointer in any updates for that method.

Oh! I see.

you're right, it will be removed.

>
>> *ioaddr,
>>                      struct stmmac_dma_cfg *dma_cfg, int atds)
>>   {
>>       u32 value = readl(ioaddr + DMA_BUS_MODE);
>>
>> @@ -118,7 +118,10 @@ static void dwmac1000_dma_init(struct stmmac_priv
>> *priv, void __iomem *ioaddr,
>>
>>       u32 dma_intr_mask;
>>
>>       /* Mask interrupts by writing to CSR7 */
>> -    dma_intr_mask = DMA_INTR_DEFAULT_MASK;
>> +    if (priv->plat->flags & STMMAC_FLAG_HAS_LGMAC)
>> +        dma_intr_mask = DMA_INTR_DEFAULT_MASK_LOONGSON;
>> +    else
>> +        dma_intr_mask = DMA_INTR_DEFAULT_MASK;
>>
>>       dma_config(ioaddr + DMA_BUS_MODE, ioaddr + DMA_INTR_ENA,
>>
>>                 dma_cfg, dma_intr_mask, atds);
>>
>>
>> Thank you for all your comments, I need some time to understand. :)
> Don't hesitate to ask should any question arise in my comments regard.

Ok, I will.


Thanks,

Yanteng

>
> -Serge(y)
>
>>
>> Thanks,
>>
>> Yanteng
>>
>>> * Sigh, just a general note in case if somebody would wish to make
>>> * things a bit more optimised and less complicated. The purpose of the
>>> * enable_dma_transmission() callback is to re-activate the DMA-engine
>>> * - exit from suspension and start poll-demanding the DMA descriptors.
>>> * In QoS GMAC and XGMAC the same is done by updating the Tx tail
>>> * pointer.  It's implemented in stmmac_set_tx_tail_ptr(). So basically
>>> * both stmmac_enable_dma_transmission() and stmmac_set_tx_tail_ptr()
>>> * should be almost always called side-by-side. Alas the current
>>> * generic driver part doesn't do that. If it did in a some common way
>>> * you wouldn't have needed the enable_dma_transmission() update
>>> * because it would have already been updated to accept the
>>> * channel/queue parameter.
>>>
>>> -Serge(y)
>>>
>>>>    	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>>    			       u32 chan, bool rx, bool tx);
>>>>    	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
>>>> @@ -240,7 +241,7 @@ struct stmmac_dma_ops {
>>>>    };
>>>>    #define stmmac_dma_init(__priv, __args...) \
>>>> -	stmmac_do_void_callback(__priv, dma, init, __args)
>>>> +	stmmac_do_void_callback(__priv, dma, init, __priv, __args)
>>>>    #define stmmac_init_chan(__priv, __args...) \
>>>>    	stmmac_do_void_callback(__priv, dma, init_chan, __priv, __args)
>>>>    #define stmmac_init_rx_chan(__priv, __args...) \
>>>> @@ -258,7 +259,7 @@ struct stmmac_dma_ops {
>>>>    #define stmmac_dma_diagnostic_fr(__priv, __args...) \
>>>>    	stmmac_do_void_callback(__priv, dma, dma_diagnostic_fr, __args)
>>>>    #define stmmac_enable_dma_transmission(__priv, __args...) \
>>>> -	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __args)
>>>> +	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __priv, __args)
>>>>    #define stmmac_enable_dma_irq(__priv, __args...) \
>>>>    	stmmac_do_void_callback(__priv, dma, enable_dma_irq, __priv, __args)
>>>>    #define stmmac_disable_dma_irq(__priv, __args...) \
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>> index 47de466e432c..d868eb8dafc5 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>> @@ -2558,7 +2558,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>>>>    				       true, priv->mode, true, true,
>>>>    				       xdp_desc.len);
>>>> -		stmmac_enable_dma_transmission(priv, priv->ioaddr);
>>>> +		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>>>>    		xsk_tx_metadata_to_compl(meta,
>>>>    					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
>>>> @@ -4679,7 +4679,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>>>>    	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
>>>> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
>>>> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>>>>    	stmmac_flush_tx_descriptors(priv, queue);
>>>>    	stmmac_tx_timer_arm(priv, queue);
>>>> @@ -4899,7 +4899,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>>>>    		u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
>>>>    	}
>>>> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
>>>> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>>>>    	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
>>>>    	tx_q->cur_tx = entry;
>>>> -- 
>>>> 2.31.4
>>>>


