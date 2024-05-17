Return-Path: <netdev+bounces-96906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B46128C8277
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1231F225C1
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 08:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1746B1AAA5;
	Fri, 17 May 2024 08:12:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030DC199C7
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933551; cv=none; b=RdzV0tmOM3B4hbSkBVA7MsC9B1+iDHMlf/ctduu+XWclmI5q0kC5DMy8YoeiPU+6R+Pn2SpOQ4ayzYRa5WqbPY1WBNpAcLszsntpRyobyOAhiFIh28IIiHcSsNqajcaLCHNj8itYSkWlu5axsj3/xvAZnIv6qHruIc1Z9ZIr6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933551; c=relaxed/simple;
	bh=tDDQ0ehYR2jhArGhB4LyHHs+LIk7ybLcwTACynwtObo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwcbK/NA33OU9z0ViPuEpGKIXXrzCk78vM0ts52RqWtsiwJulFMyFyEJEPGD6sWWaXLUmLEYLvr86rjkNgdRHRtPflQgDTw3hICXPGMPLqdHFuVBuzBdqlKcAlXEiVVl09kBLYPp4Ty/YL9wdSbWIabbqHvveArHfb7HQGvDqZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8Dxd_BnEUdmWuINAA--.33565S3;
	Fri, 17 May 2024 16:12:23 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxBLlkEUdm2ygkAA--.4775S3;
	Fri, 17 May 2024 16:12:21 +0800 (CST)
Message-ID: <9e9302c6-3b52-401f-b9af-1551136c3242@loongson.cn>
Date: Fri, 17 May 2024 16:12:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 13/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <c97cb15ab77fb9dfdd281640f48dcfc08c6988c0.1714046812.git.siyanteng@loongson.cn>
 <dcsn7kixduijizlmkhm4jmzevc6dt46gl33orh3z2ohu6otbz2@zlkx3vyvlsur>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <dcsn7kixduijizlmkhm4jmzevc6dt46gl33orh3z2ohu6otbz2@zlkx3vyvlsur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxBLlkEUdm2ygkAA--.4775S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3tF1DXr4UKrWxCrW7Ww1rGrX_yoW8Xw4fuo
	Z3XFsavw4rKr1xXan7Ka48JFy3XF1ru3Z5trW8Can8ua9Iva15Cry5Cw4fXa9IkFWrKF1U
	A34rJw1jyFWIqws3l-sFpf9Il3svdjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYG7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==

Well, let's modify the biggest patch。

在 2024/5/6 05:50, Serge Semin 写道:
> On Thu, Apr 25, 2024 at 09:11:36PM +0800, Yanteng Si wrote:
>> There are two types of Loongson DWGMAC. The first type shares the same
> s/Loongson DWGMAC/Loongson GNET controllers
OK,
>
>> register definitions and has similar logic as dwmac1000. The second type
>> uses several different register definitions, we think it is necessary to
>> distinguish rx and tx, so we split these bits into two.
> s/rx/Rx
> s/tx/Tx

OK.

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
>>   1. Create the Loongson GNET-specific
>>   stmmac_dma_ops.dma_interrupt()
>>   stmmac_dma_ops.init_chan()
>>   methods in the dwmac-loongson.c driver. Adding all the
>>   Loongson-specific macros
>>
>>   2. Create a Loongson GNET-specific platform setup method with the next
>>   semantics:
>>      + allocate stmmac_dma_ops instance and initialize it with
>>        dwmac1000_dma_ops.
>>      + override the stmmac_dma_ops.{dma_interrupt, init_chan} with
>>        the pointers to the methods defined in 2.
>>      + allocate mac_device_info instance and initialize the
>>        mac_device_info.dma field with a pointer to the new
>>        stmmac_dma_ops instance.
>>      + initialize mac_device_info in a way it's done in
>>        dwmac1000_setup().
>>
>>   3. Initialize plat_stmmacenet_data.setup() with the pointer to the
>>   method created in 2.
>>
>> GNET features:
>>
>>   Speeds: 10/100/1000Mbps
>>   DMA-descriptors type: enhanced
>>   L3/L4 filters availability: support
>>   VLAN hash table filter: support
>>   PHY-interface: GMII
>>   Remote Wake-up support: support
>>   Mac Management Counters (MMC): support
>>   Number of additional MAC addresses: 5
>>   MAC Hash-based filter: support
>>   Number of ash table size: 256
>>   DMA chennel number: 0x10 device is 8 and 0x37 device is 1
>>
>> Others:
>>
>>   GNET integrates both MAC and PHY chips inside.
>>   GNET device: LS2K2000, LS7A2000, the chip connection between the mac and
>>               phy of these devices is not normal and requires two rounds of
>>               negotiation; LS7A2000 does not support half-duplex and
>>               multi-channel;
>>
>>               To enable multi-channel on LS2K2000, you need to turn off
>>               hardware checksum.
>>
>> **Note**: Currently, only the LS2K2000's synopsys_id is 0x10, while the
>> synopsys_id of other devices are 0x37.
> The entire commit log looks as a set of information and doesn't
> explicitly explain what is going on in the patch body. Let's make it a
> bit more coherent:
>
> "Aside with the Loongson GMAC controllers which can be normally found
> on the LS2K1000 SoC and LS7A1000 chipset, Loongson released a new
> version of the network controllers called Loongson GNET. It has
> been synthesized into the new generation LS2K2000 SoC and LS7A2000
> chipset with the next DW GMAC features enabled:
>
>    DW GMAC IP-core: v3.73a
>    Speeds: 10/100/1000Mbps
>    Duplex: Full (both versions), Half (LS2K2000 SoC only)
>    DMA-descriptors type: enhanced
>    L3/L4 filters availability: Y
>    VLAN hash table filter: Y
>    PHY-interface: GMII (PHY is integrated into the chips)
>    Remote Wake-up support: Y
>    Mac Management Counters (MMC): Y
>    Number of additional MAC addresses: 5
>    MAC Hash-based filter: Y
>    Hash Table Size: 256
>    AV feature: Y (LS2K2000 SoC only)
>    DMA channels: 8 (LS2K2000 SoC), 1 (LS7A2000 chipset)
>
> The integrated PHY has a weird problem with switching from the low
> speeds to 1000Mbps mode. The speedup procedure requires the PHY-link
> re-negotiation. Besides the LS2K2000 GNET controller the next
> peculiarities:
> 1. Split up Tx and Rx DMA IRQ status/mask bits:
>         Name              Tx          Rx
>    DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
>    DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
>    DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
>    DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
>    DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
> 2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER field.
> It's 0x10 while it should have been 0x37 in accordance with the actual
> DW GMAC IP-core version.
>
> Thus in order to have the Loongson GNET controllers supported let's
> modify the Loongson DWMAC driver in accordance with all the
> peculiarities described above:
>
> 1. Create the Loongson GNET-specific
>     stmmac_dma_ops::dma_interrupt()
>     stmmac_dma_ops::init_chan()
>     callbacks due to the non-standard DMA IRQ CSR flags layout.
> 2. Create the Loongson GNET-specific platform setup() method which
> gets to initialize the DMA-ops with the dwmac1000_dma_ops instance
> and overrides the callbacks described in 1, and overrides the custom
> Synopsys ID with the real one in order to have the rest of the
> HW-specific callbacks correctly detected by the driver core.
> 3. Make sure the Loongson GNET-specific platform setup() method
> enables the duplex modes supported by the controller.
> 4. Provide the plat_stmmacenet_data::fix_mac_speed() callback which
> will restart the link Auto-negotiation in case of the speed change."
>
>
> See, you don't need to mention the 0x10 ID all the time. Just once and
> in the place where it's actually relevant.
OK, Thanks a lot!
>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 381 +++++++++++++++++-
>>   2 files changed, 371 insertions(+), 11 deletions(-)
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
>> index a16bba389417..68de90c44feb 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -8,9 +8,71 @@
>>   #include <linux/device.h>
>>   #include <linux/of_irq.h>
>>   #include "stmmac.h"
>> +#include "dwmac_dma.h"
>> +#include "dwmac1000.h"
>> +
>>
>> +#define LOONGSON_DWMAC_CORE_1_00	0x10	/* Loongson custom IP */
> What about using the name like calling as:
> +#define DWMAC_CORE_LS2K2000		0x10
> Thus you'll have the name similar to the rest of the DWMAC_CORE_*
> macros and which would emphasize what the device for which the custom
> ID is specific.
OK.
>
>> +#define CHANNEL_NUM			8
>> +
>> +struct loongson_data {
>> +	u32 gmac_verion;
> Let's call it loongson_id thus referring to the
> stmmac_priv::synopsys_id field.
OK.
>
>> +
>> +static int loongson_gnet_dma_interrupt(struct stmmac_priv *priv,
>> +				       void __iomem *ioaddr,
>> +				       struct stmmac_extra_stats *x,
>> +				       u32 chan, u32 dir)
>> +{
>> +	struct stmmac_pcpu_stats *stats =
> ...
>> +	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
> 0x7ffff != CSR5[15-0]

Hmmm, It should be CSR5[19-0]?

BTW, 0x1ffff != CSR5[15-0], too.

It should be CSR5[16-0], right?


>
>> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
>> +
>> +	return ret;
>> +}
>> +
>> +static void loongson_gnet_fix_speed(void *priv, unsigned int speed,
>> +				    unsigned int mode)
>> +{
>> +	struct loongson_data *ld = (struct loongson_data *)priv;
>> +	struct net_device *ndev = dev_get_drvdata(ld->dev);
>> +	struct stmmac_priv *ptr = netdev_priv(ndev);
>> +
>> +	/* The controller and PHY don't work well together.
>> +	 * We need to use the PS bit to check if the controller's status
>> +	 * is correct and reset PHY if necessary.
> This doesn't correspond to what you're actually doing. Please align
> the comment with what is done below (if what I provided in the commit
> log regarding this problem is correct, use the description here).
OK, you are right.
>> +	 * MAC_CTRL_REG.15 is defined by the GMAC_CONTROL_PS macro.
> useless. please drop
OK.
>
>> +	 */
>> +	if (speed == SPEED_1000) {
>>
>> +
>> +static struct mac_device_info *loongson_dwmac_setup(void *apriv)
>> +{
>> +	struct stmmac_priv *priv = apriv;
>> +	struct mac_device_info *mac;
> seems unused. See my next comment.
No, We're using it. See my next reply.
>
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
> I see you no longer override the ops in dwmac1000_ops. If so this can
> be dropped.
No,

Because I pre-initialize the respective "mac" fields as it's done
in dwmac1000_setup().

>
>> +
>> +	dma = devm_kzalloc(priv->device, sizeof(*dma), GFP_KERNEL);
>> +	if (!dma)
>> +		return NULL;
>> +
>> +	/* The original IP-core version is 0x37 in all Loongson GNET
> s/0x37/v3.73a
Yeah!
>
>> +	 * (ls2k2000 and ls7a2000), but the GNET HW designers have changed the
>> +	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the Loongson
>> +	 * ls2k2000 MAC to emphasize the differences: multiple DMA-channels,
> s/ls2k2000/LS2K2000
> s/ls7a2000/LS7A2000
OK.
>
>> +	 * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
>> +	 * original value so the correct HW-interface would be selected.
>> +	 */
>> +	if (ld->gmac_verion == LOONGSON_DWMAC_CORE_1_00) {
>> +		priv->synopsys_id = DWMAC_CORE_3_70;
>> +		*dma = dwmac1000_dma_ops;
>> +		dma->init_chan = loongson_gnet_dma_init_channel;
>> +		dma->dma_interrupt = loongson_gnet_dma_interrupt;
>> +		mac->dma = dma;
>> +	}
>> +
>> +	mac->mac = &dwmac1000_ops;
> Unused?
Yeah, will be droped!
>
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
>> +	/* The GMAC devices with PCI ID 0x7a03 does not support any pause mode.
>> +	 * The GNET devices without CORE ID 0x10 does not support half-duplex.
>> +	 */
> No need to mention the IDs but just the actual devices:
> 	/* Loongson GMAC doesn't support the flow control. LS2K2000
> 	 * GNET doesn't support the half-duplex link mode.
> 	 */
>
OK, Thanks.
>> +	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
>> +		mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
>> +	} else {
>> +		if (ld->gmac_verion == LOONGSON_DWMAC_CORE_1_00)
>> +			mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>> +					 MAC_10 | MAC_100 | MAC_1000;
>> +		else
>> +			mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>> +					 MAC_10FD | MAC_100FD | MAC_1000FD;
>> +	}
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
>>   static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>>   	struct plat_stmmacenet_data *plat;
>>   	int ret, i, bus_id, phy_mode;
>>   	struct stmmac_pci_info *info;
>>   	struct stmmac_resources res;
>> +	struct loongson_data *ld;
>>   	struct device_node *np;
>>   
>>   	np = dev_of_node(&pdev->dev);
>> @@ -122,10 +460,12 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   		return -ENOMEM;
>>   
>>   	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
>> -	if (!plat->dma_cfg) {
>> -		ret = -ENOMEM;
>> -		goto err_put_node;
>> -	}
>> +	if (!plat->dma_cfg)
>> +		return -ENOMEM;
> This change must have been introduced in the patch
> [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
> which moves the mdio_node pointer initialization to under the if-clause.
OK.
>
>> +
>> +	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
>> +	if (!ld)
>> +		return -ENOMEM;
>>   
>>   	/* Enable pci device */
>>   	ret = pci_enable_device(pdev);
>> @@ -171,14 +511,34 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   		plat->phy_interface = phy_mode;
>>   	}
>>   
>> -	pci_enable_msi(pdev);
> Hm, this must be justified and better being done in a separate patch.
OK.
>
>> +	plat->bsp_priv = ld;
>> +	plat->setup = loongson_dwmac_setup;
>> +	ld->dev = &pdev->dev;
>> +
>>   	memset(&res, 0, sizeof(res));
>>   	res.addr = pcim_iomap_table(pdev)[0];
>> +	ld->gmac_verion = readl(res.addr + GMAC_VERSION) & 0xff;
>> +
>> +	switch (ld->gmac_verion) {
>> +	case LOONGSON_DWMAC_CORE_1_00:
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
>> +		ret = loongson_dwmac_config_msi(pdev, plat, &res, np);
>> +		break;
>> +	default:	/* 0x35 device and 0x37 device. */
>> +		plat->tx_queues_to_use = 1;
>> +		plat->rx_queues_to_use = 1;
>>   
> Move the NoF queues (and coe flag) initializations to the respective
> loongson_*_data() methods.
OK.
>
> Besides I don't see you freeing the IRQ vectors allocated in the
> loongson_dwmac_config_msi() method neither in probe(), nor in remove()
> functions. That's definitely wrong. What you need is to have a
> method antagonistic to loongson_dwmac_config_msi() (like
> loongson_dwmac_clear_msi()) which would execute the cleanup procedure.

Hmmm, We can free it in struct pci_driver ->remove method.

Just in loongson_dwmac_remove() call

pci_free_irq_vectors(pdev);


>
>> -	ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
>> +		ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
>> +		break;
>> +	}
>>   
>>   	/* GNET devices with dev revision 0x00 do not support manually
>>   	 * setting the speed to 1000.
>> @@ -189,12 +549,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   
>>   	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>>   	if (ret)
>> -		goto err_disable_msi;
>> +		goto err_disable_device;
>>   
>>   	return ret;
>>   
>> -err_disable_msi:
>> -	pci_disable_msi(pdev);
> Once again. Justify the change. Moreover I don't see you dropping the
> pci_disable_msi() from the remove() method.

Since we need to check the return value of the allocated msi, we will

restore this change in v13.


Thanks,

Yanteng


