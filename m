Return-Path: <netdev+bounces-108798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDF2925890
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D9728E88D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6520C16F914;
	Wed,  3 Jul 2024 10:27:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C82E15B0F4
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002475; cv=none; b=FZfGie/4OAh1auIumSYvlSk3YDuNCIXlsAOmUEW95cMrVWTJ7a1gGUT7h5Q344cUGXqLFH2kQJksS6gHvR/MJE0kulwDutjPiOXG14MvdRcBx5Kd4UiwUP/2ezvs3YTfMDUnm7wzynsDfOQdIcl2jzzp74R+dHjJ83lv6vZVj8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002475; c=relaxed/simple;
	bh=xE3bBQF7yXZ7qrMtxE/Q4rQHLKbNMqFHp2bRJOU6ixU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oX/vvjldrLkycY+3JZI2qK3xes3l8S3wnpKf1KaA7X5BcALm1afNWjHIuoSr3DZp44ndUg9X5D/lshHohJ/kAFc8gQQLQn2EjE5r5OuUk9Hkb7DhHVgHzZ2yLLc4fEwTX55eCERmXjLKTaQBy0kOwiSYlJQb87mA6lomIUECPew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.32])
	by gateway (Coremail) with SMTP id _____8CxLOukJ4Vm4nwAAA--.1447S3;
	Wed, 03 Jul 2024 18:27:48 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.32])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx68agJ4Vmy305AA--.2246S3;
	Wed, 03 Jul 2024 18:27:45 +0800 (CST)
Message-ID: <a4920a6f-21fe-494b-8106-b96764ce902b@loongson.cn>
Date: Wed, 3 Jul 2024 18:27:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 14/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <16ec5a0665bcce96757be140019d81b0fe5f6303.1716973237.git.siyanteng@loongson.cn>
 <ktvlui43g6q7ju3tmga7ut3rg2hkhnbxwfbjzr46jx4kjbubwk@l4gqqvhih5ug>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ktvlui43g6q7ju3tmga7ut3rg2hkhnbxwfbjzr46jx4kjbubwk@l4gqqvhih5ug>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx68agJ4Vmy305AA--.2246S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfCFWkCF47Zr43AF1UCF47Jrc_yoW5Ww1UZo
	Z3XFnayr4rKry8WFs7K3Z5Jry3XF1rXw4YyF4xCw4DXFsIqa1UuFWrJa1fJayFyFWrKFy8
	Aa4rJ3WvyFW2qws5l-sFpf9Il3svdjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYG7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==


在 2024/7/2 21:43, Serge Semin 写道:
>> [PATCH net-next v13 14/15] net: stmmac: dwmac-loongson: Add Loongson GNET support
> Seeing the multi-channels AV-feature can be found on the Loongson
> GMACs too we have to reconsider this patch logic by converting it to
> adding the multi-channels support for the Loongson GMAC device only.
> Everything Loongson GNET-specific should be moved to a new following
> up patch.
>
> So firstly please change this patch subject to:
> [PATCH net-next v14 13/15] net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support
>
> On Wed, May 29, 2024 at 06:21:09PM +0800, Yanteng Si wrote:
>> Aside with the Loongson GMAC controllers which can be normally found
>> on the LS2K1000 SoC and LS7A1000 chipset, Loongson released a new
>> version of the network controllers called Loongson GNET. It has
>> been synthesized into the new generation LS2K2000 SoC and LS7A2000
>> chipset with the next DW GMAC features enabled:
>>
>>    DW GMAC IP-core: v3.73a
>>    Speeds: 10/100/1000Mbps
>>    Duplex: Full (both versions), Half (LS2K2000 SoC only)
>>    DMA-descriptors type: enhanced
>>    L3/L4 filters availability: Y
>>    VLAN hash table filter: Y
>>    PHY-interface: GMII (PHY is integrated into the chips)
>>    Remote Wake-up support: Y
>>    Mac Management Counters (MMC): Y
>>    Number of additional MAC addresses: 5
>>    MAC Hash-based filter: Y
>>    Hash Table Size: 256
>>    AV feature: Y (LS2K2000 SoC only)
>>    DMA channels: 8 (LS2K2000 SoC), 1 (LS7A2000 chipset)
>>
>> The integrated PHY has a weird problem with switching from the low
>> speeds to 1000Mbps mode. The speedup procedure requires the PHY-link
>> re-negotiation. Besides the LS2K2000 GNET controller the next
>> peculiarities:
>> 1. Split up Tx and Rx DMA IRQ status/mask bits:
>>         Name              Tx          Rx
>>    DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
>>    DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
>>    DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
>>    DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
>>    DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
>> 2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER field.
>> It's 0x10 while it should have been 0x37 in accordance with the actual
>> DW GMAC IP-core version.
>>
>> Thus in order to have the Loongson GNET controllers supported let's
>> modify the Loongson DWMAC driver in accordance with all the
>> peculiarities described above:
>>
>> 1. Create the Loongson GNET-specific
>>     stmmac_dma_ops::dma_interrupt()
>>     stmmac_dma_ops::init_chan()
>>     callbacks due to the non-standard DMA IRQ CSR flags layout.
>> 2. Create the Loongson GNET-specific platform setup() method which
>> gets to initialize the DMA-ops with the dwmac1000_dma_ops instance
>> and overrides the callbacks described in 1, and overrides the custom
>> Synopsys ID with the real one in order to have the rest of the
>> HW-specific callbacks correctly detected by the driver core.
>> 3. Make sure the Loongson GNET-specific platform setup() method
>> enables the duplex modes supported by the controller.
>> 4. Provide the plat_stmmacenet_data::fix_mac_speed() callback which
>> will restart the link Auto-negotiation in case of the speed change.
> Please convert the commit log of this patch to containing the
> multi-channels feature description only. Like this (correct me if I am
> wrong in understanding some of the Loongson network controllers
> aspects):
>
> "The Loongson DWMAC driver currently supports the Loongson GMAC
> devices (based on the DW GMAC v3.50a/v3.73a IP-core) installed to the
> LS2K1000 SoC and LS7A1000 chipset. But recently a new generation
> LS2K2000 SoC was released with the new version of the Loongson GMAC
> synthesized in. The new controller is based on the DW GMAC v3.73a
> IP-core with the AV-feature enabled, which implies the multi
> DMA-channels support. The multi DMA-channels feature has the next
> vendor-specific peculiarities:
>
> 1. Split up Tx and Rx DMA IRQ status/mask bits:
>         Name              Tx          Rx
>    DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
>    DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
>    DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
>    DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
>    DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
> 2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER register
> field. It's 0x10 while it should have been 0x37 in accordance with
> the actual DW GMAC IP-core version.
> 3. There are eight DMA-channels available meanwhile the Synopsys DW
> GMAC IP-core supports up to three DMA-channels.
> 4. It's possible to have each DMA-channel IRQ independently delivered.
> The MSI IRQs must be utilized for that.
>
> Thus in order to have the multi-channels Loongson GMAC controllers
> supported let's modify the Loongson DWMAC driver in accordance with
> all the peculiarities described above:
>
> 1. Create the multi-channels Loongson GMAC-specific
>     stmmac_dma_ops::dma_interrupt()
>     stmmac_dma_ops::init_chan()
>     callbacks due to the non-standard DMA IRQ CSR flags layout.
> 2. Create the Loongson DWMAC-specific platform setup() method
> which gets to initialize the DMA-ops with the dwmac1000_dma_ops
> instance and overrides the callbacks described in 1. The method also
> overrides the custom Synopsys ID with the real one in order to have
> the rest of the HW-specific callbacks correctly detected by the driver
> core.
> 3. Make sure the platform setup() method enables the flow control and
> duplex modes supported by the controller.
> "
>
> Once again, please correct the text if I was wrong in understanding
> the way your devices work. Especially regarding the flow-control and
> half-duplex mode.
>
> ---
>
> The Loongson GNET-specific changes should be moved to the new patch
> applied after this one. The subject of the new patch should be the same
> as the former subject of this patch:
> [PATCH net-next v14 14/15] net: stmmac: dwmac-loongson: Add Loongson GNET support
> but of course the commit log shall be different. Like this:
>
> "The new generation Loongson LS2K2000 SoC and LS7A2000 chipset are
> equipped with the network controllers called Loongson GNET. It's the
> single and multi DMA-channels Loongson GMAC but with a PHY attached.
> Here is the summary of the DW GMAC features the controller has:
>
>     DW GMAC IP-core: v3.73a
>     Speeds: 10/100/1000Mbps
>     Duplex: Full (both versions), Half (LS2K2000 GNET only)
>     DMA-descriptors type: enhanced
>     L3/L4 filters availability: Y
>     VLAN hash table filter: Y
>     PHY-interface: GMII (PHY is integrated into the chips)
>     Remote Wake-up support: Y
>     Mac Management Counters (MMC): Y
>     Number of additional MAC addresses: 5
>     MAC Hash-based filter: Y
>     Hash Table Size: 256
>     AV feature: Y (LS2K2000 GNET only)
>     DMA channels: 8 (LS2K2000 GNET), 1 (LS7A2000 GNET)
>
> Let's update the Loongson DWMAC driver to supporting the new Loongson
> GNET controller. The change is mainly trivial: the driver shall be
> bound to the PCIe device with DID 0x7a13, and the device-specific
> setup() method shall be called for it. The only peculiarity concerns
> the integrated PHY speed change procedure. The PHY has a weird problem
> with switching from the low speeds to 1000Mbps mode. The speedup
> procedure requires the PHY-link re-negotiation. So the suggested
> change provide the device-specific fix_mac_speed() method to overcome
> the problem."
OK.
>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 390 +++++++++++++++++-
>>   2 files changed, 387 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
>> index 9cd62b2110a1..aed6ae80cc7c 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
>> @@ -29,6 +29,7 @@
>>   /* Synopsys Core versions */
>>   #define	DWMAC_CORE_3_40		0x34
>>   #define	DWMAC_CORE_3_50		0x35
>> +#define	DWMAC_CORE_3_70		0x37
>>   #define	DWMAC_CORE_4_00		0x40
>>   #define DWMAC_CORE_4_10		0x41
>>   #define DWMAC_CORE_5_00		0x50
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index 45dcc35b7955..559215e3fe41 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -8,8 +8,71 @@
>>   #include <linux/device.h>
>>   #include <linux/of_irq.h>
>>   #include "stmmac.h"
>> +#include "dwmac_dma.h"
>> +#include "dwmac1000.h"
>> +
>> +/* Normal Loongson Tx Summary */
>> +#define DMA_INTR_ENA_NIE_TX_LOONGSON	0x00040000
>> +/* Normal Loongson Rx Summary */
>> +#define DMA_INTR_ENA_NIE_RX_LOONGSON	0x00020000
>> +
>> +#define DMA_INTR_NORMAL_LOONGSON	(DMA_INTR_ENA_NIE_TX_LOONGSON | \
>> +					 DMA_INTR_ENA_NIE_RX_LOONGSON | \
>> +					 DMA_INTR_ENA_RIE | DMA_INTR_ENA_TIE)
>> +
>> +/* Abnormal Loongson Tx Summary */
>> +#define DMA_INTR_ENA_AIE_TX_LOONGSON	0x00010000
>> +/* Abnormal Loongson Rx Summary */
>> +#define DMA_INTR_ENA_AIE_RX_LOONGSON	0x00008000
>> +
>> +#define DMA_INTR_ABNORMAL_LOONGSON	(DMA_INTR_ENA_AIE_TX_LOONGSON | \
>> +					 DMA_INTR_ENA_AIE_RX_LOONGSON | \
>> +					 DMA_INTR_ENA_FBE | DMA_INTR_ENA_UNE)
>> +
>> +#define DMA_INTR_DEFAULT_MASK_LOONGSON	(DMA_INTR_NORMAL_LOONGSON | \
>> +					 DMA_INTR_ABNORMAL_LOONGSON)
>> +
>> +/* Normal Loongson Tx Interrupt Summary */
>> +#define DMA_STATUS_NIS_TX_LOONGSON	0x00040000
>> +/* Normal Loongson Rx Interrupt Summary */
>> +#define DMA_STATUS_NIS_RX_LOONGSON	0x00020000
>> +
>> +/* Abnormal Loongson Tx Interrupt Summary */
>> +#define DMA_STATUS_AIS_TX_LOONGSON	0x00010000
>> +/* Abnormal Loongson Rx Interrupt Summary */
>> +#define DMA_STATUS_AIS_RX_LOONGSON	0x00008000
>> +
>> +/* Fatal Loongson Tx Bus Error Interrupt */
>> +#define DMA_STATUS_FBI_TX_LOONGSON	0x00002000
>> +/* Fatal Loongson Rx Bus Error Interrupt */
>> +#define DMA_STATUS_FBI_RX_LOONGSON	0x00001000
>> +
>> +#define DMA_STATUS_MSK_COMMON_LOONGSON	(DMA_STATUS_NIS_TX_LOONGSON | \
>> +					 DMA_STATUS_NIS_RX_LOONGSON | \
>> +					 DMA_STATUS_AIS_TX_LOONGSON | \
>> +					 DMA_STATUS_AIS_RX_LOONGSON | \
>> +					 DMA_STATUS_FBI_TX_LOONGSON | \
>> +					 DMA_STATUS_FBI_RX_LOONGSON)
>> +
>> +#define DMA_STATUS_MSK_RX_LOONGSON	(DMA_STATUS_ERI | DMA_STATUS_RWT | \
>> +					 DMA_STATUS_RPS | DMA_STATUS_RU  | \
>> +					 DMA_STATUS_RI  | DMA_STATUS_OVF | \
>> +					 DMA_STATUS_MSK_COMMON_LOONGSON)
>> +
>> +#define DMA_STATUS_MSK_TX_LOONGSON	(DMA_STATUS_ETI | DMA_STATUS_UNF | \
>> +					 DMA_STATUS_TJT | DMA_STATUS_TU  | \
>> +					 DMA_STATUS_TPS | DMA_STATUS_TI  | \
>> +					 DMA_STATUS_MSK_COMMON_LOONGSON)
>>   
>>   #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>> +#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
> Please move this to the new patch adding the Loongson GNET support.
OK
>
>> +#define DWMAC_CORE_LS2K2000		0x10	/* Loongson custom IP */
> Note it's perfectly fine to have a device named after the SoC it's
> equipped to. For example see the compatible strings defined for the
> vendor-specific versions of the DW *MAC IP-cores:
> Documentation/devicetree/bindings/net/snps,dwmac.yaml
>
> But if you aren't comfortable with such naming we can change the
> macro to something like:
> #define DWMAC_CORE_LOONGSON_MULTI_CH	0x10
Hmmm, It's all okay. What about huacai's comment?
>
>> +#define CHANNEL_NUM			8
>> +
>> +struct loongson_data {
>> +	u32 loongson_id;
>> +	struct device *dev;
> Please add the "dev" field in the new patch adding the Loongson GNET support.
OK.
>
>> +};
>>   
>>   struct stmmac_pci_info {
>>   	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
>> @@ -67,6 +130,298 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>>   	.setup = loongson_gmac_data,
>>   };
>>   
>> +static void loongson_gnet_dma_init_channel(struct stmmac_priv *priv,
> Since the multi-channel feature is no longer GNET-specific, please
> rename the method prefix to loongson_dwmac_ .
OK.
>
>> +					   void __iomem *ioaddr,
>> +					   struct stmmac_dma_cfg *dma_cfg,
>> +					   u32 chan)
>> +{
>> +	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
>> +	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
>> +	u32 value;
>> +
>> +	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
>> +
>> +	if (dma_cfg->pblx8)
>> +		value |= DMA_BUS_MODE_MAXPBL;
>> +
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
>> +	if (dma_cfg->atds)
>> +		value |= DMA_BUS_MODE_ATDS;
>> +
>> +	if (dma_cfg->aal)
>> +		value |= DMA_BUS_MODE_AAL;
>> +
>> +	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
>> +
>> +	/* Mask interrupts by writing to CSR7 */
>> +	writel(DMA_INTR_DEFAULT_MASK_LOONGSON, ioaddr +
>> +	       DMA_CHAN_INTR_ENA(chan));
>> +}
>> +
>> +static int loongson_gnet_dma_interrupt(struct stmmac_priv *priv,
> Similarly the loongson_dwmac_ prefix seems more appropriate now.
OK.
>
>> +				       void __iomem *ioaddr,
>> +				       struct stmmac_extra_stats *x,
>> +				       u32 chan, u32 dir)
>> +{
>> +	struct stmmac_pcpu_stats *stats = this_cpu_ptr(priv->xstats.pcpu_stats);
>> +	u32 abnor_intr_status;
>> +	u32 nor_intr_status;
>> +	u32 fb_intr_status;
>> +	u32 intr_status;
>> +	int ret = 0;
>> +
>> +	/* read the status register (CSR5) */
>> +	intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
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
>> +		if (unlikely(intr_status & DMA_STATUS_OVF))
>> +			x->rx_overflow_irq++;
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
>> +		if (unlikely(fb_intr_status)) {
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
>> +				u64_stats_update_begin(&stats->syncp);
>> +				u64_stats_inc(&stats->rx_normal_irq_n[chan]);
>> +				u64_stats_update_end(&stats->syncp);
>> +				ret |= handle_rx;
>> +			}
>> +		}
>> +		if (likely(intr_status & DMA_STATUS_TI)) {
>> +			u64_stats_update_begin(&stats->syncp);
>> +			u64_stats_inc(&stats->tx_normal_irq_n[chan]);
>> +			u64_stats_update_end(&stats->syncp);
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
>> +	/* Clear the interrupt by writing a logic 1 to the CSR5[19-0] */
>> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
>> +
>> +	return ret;
>> +}
>> +
>
>> +static void loongson_gnet_fix_speed(void *priv, unsigned int speed,
>> +				    unsigned int mode)
>> +{
>> +	struct loongson_data *ld = (struct loongson_data *)priv;
>> +	struct net_device *ndev = dev_get_drvdata(ld->dev);
>> +	struct stmmac_priv *ptr = netdev_priv(ndev);
>> +
>> +	/* The integrated PHY has a weird problem with switching from the low
>> +	 * speeds to 1000Mbps mode. The speedup procedure requires the PHY-link
>> +	 * re-negotiation.
>> +	 */
>> +	if (speed == SPEED_1000) {
>> +		if (readl(ptr->ioaddr + MAC_CTRL_REG) &
>> +		    GMAC_CONTROL_PS)
>> +			/* Word around hardware bug, restart autoneg */
>> +			phy_restart_aneg(ndev->phydev);
>> +	}
>> +}
>> +
>> +static int loongson_gnet_data(struct pci_dev *pdev,
>> +			      struct plat_stmmacenet_data *plat)
>> +{
>> +	loongson_default_data(pdev, plat);
>> +
>> +	plat->phy_interface = PHY_INTERFACE_MODE_GMII;
>> +	plat->mdio_bus_data->phy_mask = ~(u32)BIT(2);
>> +	plat->fix_mac_speed = loongson_gnet_fix_speed;
>> +
>> +	/* GNET devices with dev revision 0x00 do not support manually
>> +	 * setting the speed to 1000.
>> +	 */
>> +	if (pdev->revision == 0x00)
>> +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct stmmac_pci_info loongson_gnet_pci_info = {
>> +	.setup = loongson_gnet_data,
>> +};
> Please move this to the new patch adding the Loongson GNET support.
OK.
>
>> +
>> +static int loongson_dwmac_intx_config(struct pci_dev *pdev,
>> +				      struct plat_stmmacenet_data *plat,
>> +				      struct stmmac_resources *res)
>> +{
>> +	res->irq = pdev->irq;
>> +
>> +	return 0;
>> +}
> If you get to implement what suggested here
> https://lore.kernel.org/netdev/glm3jfqf36t5vnkmk4gsdqfx53ga7ohs3pxnsizqlogkbim7gg@a3dxav5siczn/
> than the loongson_dwmac_intx_config() won't be needed.

Yeah! and loongson_dwmac_acpi_config() also won't be needed.

Because loongson_dwmac_msi_config() will do everything. I already reply 
in patch 6.


>
>> +
>> +static int loongson_dwmac_msi_config(struct pci_dev *pdev,
>> +				     struct plat_stmmacenet_data *plat,
>> +				     struct stmmac_resources *res)
>> +{
>> +	int i, ret, vecs;
>> +
>> +	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
>> +	ret = pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_INTX);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
>> +		return ret;
>> +	}
>> +
>> +	if (ret >= vecs) {
>> +		for (i = 0; i < plat->rx_queues_to_use; i++) {
>> +			res->rx_irq[CHANNEL_NUM - 1 - i] =
>> +				pci_irq_vector(pdev, 1 + i * 2);
>> +		}
>> +		for (i = 0; i < plat->tx_queues_to_use; i++) {
>> +			res->tx_irq[CHANNEL_NUM - 1 - i] =
>> +				pci_irq_vector(pdev, 2 + i * 2);
>> +		}
>> +
>> +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
>> +	}
>> +
>> +	res->irq = pci_irq_vector(pdev, 0);
>> +
>> +	return 0;
>> +}
> Could you please clarify whether the multi-channel feature will work
> if the pci_alloc_irq_vectors() method failed to allocated as many MSI
> vectors as there are channels?

What I can confirm is that the multi-channel device can work in a single

channel, and as for the intermediate state, I still need to do experiments.

>
>> +
>> +static int loongson_dwmac_msi_clear(struct pci_dev *pdev)
>> +{
>> +	pci_free_irq_vectors(pdev);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct mac_device_info *loongson_dwmac_setup(void *apriv)
>> +{
>> +	struct stmmac_priv *priv = apriv;
>> +	struct mac_device_info *mac;
>> +	struct stmmac_dma_ops *dma;
>> +	struct loongson_data *ld;
>> +	struct pci_dev *pdev;
>> +
>> +	ld = priv->plat->bsp_priv;
>> +	pdev = to_pci_dev(priv->device);
>> +
>> +	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
>> +	if (!mac)
>> +		return NULL;
>> +
>> +	dma = devm_kzalloc(priv->device, sizeof(*dma), GFP_KERNEL);
>> +	if (!dma)
>> +		return NULL;
>> +
>> +	/* The original IP-core version is v3.73a in all Loongson GNET
>> +	 * (LS2K2000 and LS7A2000), but the GNET HW designers have changed the
>> +	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the Loongson
>> +	 * LS2K2000 MAC to emphasize the differences: multiple DMA-channels,
>> +	 * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
>> +	 * original value so the correct HW-interface would be selected.
>> +	 */
> The comment needs to be altered since the multi-channel feature is no
> longer GNET-specific. Like this:
>
> 	/* The Loongson GMAC and GNET devices are based on the DW GMAC
> 	 * v3.50a and v3.73a IP-cores. But the HW designers have changed the
> 	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the
> 	 * network controllers with the multi-channels feature
> 	 * available to emphasize the differences: multiple DMA-channels,
> 	 * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
> 	 * original value so the correct HW-interface would be selected.
> 	 */
OK.
>> +	if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
>> +		priv->synopsys_id = DWMAC_CORE_3_70;
>> +		*dma = dwmac1000_dma_ops;
>> +		dma->init_chan = loongson_gnet_dma_init_channel;
>> +		dma->dma_interrupt = loongson_gnet_dma_interrupt;
>> +		mac->dma = dma;
>> +	}
>> +
>> +	priv->dev->priv_flags |= IFF_UNICAST_FLT;
>> +
>> +	/* Pre-initialize the respective "mac" fields as it's done in
>> +	 * dwmac1000_setup()
>> +	 */
>> +	mac->pcsr = priv->ioaddr;
>> +	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
>> +	mac->unicast_filter_entries = priv->plat->unicast_filter_entries;
>> +	mac->mcast_bits_log2 = 0;
>> +
>> +	if (mac->multicast_filter_bins)
>> +		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>> +
>> +	/* Loongson GMAC doesn't support the flow control. LS2K2000
>> +	 * GNET doesn't support the half-duplex link mode.
>> +	 */
>> +	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
>> +		mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
>> +	} else {
>> +		if (ld->loongson_id == DWMAC_CORE_LS2K2000)
>> +			mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>> +					 MAC_10 | MAC_100 | MAC_1000;
>> +		else
>> +			mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>> +					 MAC_10FD | MAC_100FD | MAC_1000FD;
>> +	}
> AFAIU The only part that is applicable for the multi-channels case of
> the Loongson GMAC is:
> +	/* Loongson GMAC doesn't support the flow control */
> +	mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
>
> If so the rest of the changes in this chunk should be moved to the new
> patch adding the Loongson GNET support.
OK.
>
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
>>   static int loongson_dwmac_dt_config(struct pci_dev *pdev,
>>   				    struct plat_stmmacenet_data *plat,
>>   				    struct stmmac_resources *res)
>> @@ -119,6 +474,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	struct plat_stmmacenet_data *plat;
>>   	struct stmmac_pci_info *info;
>>   	struct stmmac_resources res;
>> +	struct loongson_data *ld;
>>   	int ret, i;
>>   
>>   	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>> @@ -135,6 +491,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	if (!plat->dma_cfg)
>>   		return -ENOMEM;
>>   
>> +	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
>> +	if (!ld)
>> +		return -ENOMEM;
>> +
>>   	/* Enable pci device */
>>   	ret = pci_enable_device(pdev);
>>   	if (ret) {
>> @@ -159,19 +519,39 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   
>>   	pci_set_master(pdev);
>>   
>> +	plat->bsp_priv = ld;
>> +	plat->setup = loongson_dwmac_setup;
>> +	ld->dev = &pdev->dev;
>> +
> Please make sure the chunk above and
> +	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
> are performed before the stmmac_pci_info::setup() is called so the
> callback could use the private platform data with the loongson_id
> field initialized.
OK. I've used your method on patch 6 and it works.
>
>>   	if (dev_of_node(&pdev->dev)) {
>>   		ret = loongson_dwmac_dt_config(pdev, plat, &res);
>>   		if (ret)
>>   			goto err_disable_device;
>> -	} else {
>> -		res.irq = pdev->irq;
>>   	}
>>   
>>   	memset(&res, 0, sizeof(res));
> I've just realised the memset() call will clear out everything
> initialized in "res" by the loongson_dwmac_dt_config() method.

As your comments in patch 6:

     memset(&res, 0, sizeof(res));
     res.addr = pcim_iomap_table(pdev)[0];

     plat->bsp_priv = ld;
     plat->setup = loongson_dwmac_setup;
     ld->dev = &pdev->dev;
     ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;

     info = (struct stmmac_pci_info *)id->driver_data;
     ret = info->setup(pdev, plat);
     if (ret)
         goto err_disable_device;

     if (dev_of_node(&pdev->dev)) {
         ret = loongson_dwmac_dt_config(pdev, plat, &res);
         if (ret)
             goto err_disable_device;
     }

...

>
>>   	res.addr = pcim_iomap_table(pdev)[0];
>> +	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
>> +
>
>> +	if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
>> +		plat->rx_queues_to_use = CHANNEL_NUM;
>> +		plat->tx_queues_to_use = CHANNEL_NUM;
>> +
>> +		/* Only channel 0 supports checksum,
>> +		 * so turn off checksum to enable multiple channels.
>> +		 */
>> +		for (i = 1; i < CHANNEL_NUM; i++)
>> +			plat->tx_queues_cfg[i].coe_unsupported = 1;
>>   
>> -	plat->tx_queues_to_use = 1;
>> -	plat->rx_queues_to_use = 1;
> Please move this part to the loongson_gmac_data() method (and to the
> loongson_gnet_data() in the new patch). The only
> code which would be left here is:
> 	if (ld->loongson_id == DWMAC_CORE_LOONGSON_MULTI_CH) {
> 		ret = loongson_dwmac_msi_config(pdev, plat, &res);
> 		if (ret)
> 			goto err_disable_device;
> 	}
OK. We don't need if else. I've explained this in patch 6.
>
>> +		ret = loongson_dwmac_msi_config(pdev, plat, &res);
>> +	} else {
>> +		plat->tx_queues_to_use = 1;
>> +		plat->rx_queues_to_use = 1;
>> +
>> +		ret = loongson_dwmac_intx_config(pdev, plat, &res);
>> +	}
>> +	if (ret)
>> +		goto err_disable_device;
> This won't be needed if you get to implement what is suggested here
> https://lore.kernel.org/netdev/glm3jfqf36t5vnkmk4gsdqfx53ga7ohs3pxnsizqlogkbim7gg@a3dxav5siczn/
I will drop it
>
>>   
>>   	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>>   	if (ret)
> I don't see the MSI-configs being undone in case of the
> stmmac_dvr_probe() failure. What should have been done:
>
> 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
> 	if (ret)
> 		goto err_clear_msi;
>
> 	return 0;
>
> err_clear_msi:
> 	if (ld->loongson_id == DWMAC_CORE_LOONGSON_MULTI_CH)
> 		loongson_dwmac_msi_clear(pdev);
>
> err_disable_device:
> 	pci_disable_device(pdev);
>
> 	...
OK!
>
>> @@ -202,6 +582,7 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>>   		break;
>>   	}
>>   
>> +	loongson_dwmac_msi_clear(pdev);
> Shouldn't this be done for the multi-channels device only? Like this
> 	if (ld->loongson_id == DWMAC_CORE_LOONGSON_MULTI_CH)
> 		loongson_dwmac_msi_clear(pdev);
Yeah!
>
>>   	pci_disable_device(pdev);
>>   }
>>   
>> @@ -245,6 +626,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>>   
>>   static const struct pci_device_id loongson_dwmac_id_table[] = {
>>   	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>> +	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
> Please move this to the new patch adding the Loongson GNET support.
OK.
>
>
>
> Sigh... The comments are brutal but if no more unexpected details get
> to be revealed the respective alterations shall bring us to the
> coherent set of changes. And hopefully there won't be need in such
> comprehensive patchset refactoring anymore.(

Sigh...


Thanks for you review!


Thanks,

Yanteng

>
> -Serge(y)
>
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
>> -- 
>> 2.31.4
>>


