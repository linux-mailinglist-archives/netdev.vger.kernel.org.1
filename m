Return-Path: <netdev+bounces-79638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC7387A547
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41DCAB20D40
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 09:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C78D383AE;
	Wed, 13 Mar 2024 09:52:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD78376F9
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323556; cv=none; b=XGtuowdnMl0/a0/iMzOuVM1DLhPK0NtLi/0FzObC/TRJMudcZDPfR0jun7Pp0C/lWWTxqbrdtGjbqrzDMg6YLuR7nePrJluWHonZvFVxoOVouh7HjThvLTuuxWk8+OWHyQ2b+W7/tRktMDs8OqaDYqEnIAoUN4cIhD3moWgbhOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323556; c=relaxed/simple;
	bh=oRbSpTA05p4B5l625VcsrZoram2Dj5rCS9kyeTZEqAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjyhvL9tT4IcckUwC6zyxZVSE8/QytrkoO4NIVsM/D7d9t6/gZ9Ye7SjKE0BCZ0qX3DKy17c9f21NA9eCuwOGDtW7vs/EnJZYLgyOCxbA9dxNAKqL40v7DHOMvDwAMALIv/qSzKvdRMZKM8KFSFSyk+nrMJPATTSK+//tS5p/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8Axz+tgd_FlDGEYAA--.59296S3;
	Wed, 13 Mar 2024 17:52:32 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX89dd_FlEmxYAA--.35380S3;
	Wed, 13 Mar 2024 17:52:30 +0800 (CST)
Message-ID: <6ba83c5c-a993-4d79-86cf-789505a893ed@loongson.cn>
Date: Wed, 13 Mar 2024 17:52:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 11/11] net: stmmac: dwmac-loongson: Disable
 coe for some Loongson GNET
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <151e688e8977376c3c97548540f8e15d272685cb.1706601050.git.siyanteng@loongson.cn>
 <52aodgfoh35zxpube73w53jv7rno5k7vfwdy276zjqpcbewk5t@4f2igj76y5ri>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <52aodgfoh35zxpube73w53jv7rno5k7vfwdy276zjqpcbewk5t@4f2igj76y5ri>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxX89dd_FlEmxYAA--.35380S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrW5CF4kuw17XF1kJFyDCFX_yoWrCF1kpr
	y7Jas09FyDKFn7Aan3trZ5ZryFgFWF9rWxWFWjk3yxCrZF9Fy5Xr12ka4UCwn7ZFykXr10
	vFW8CrnxWas0qrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==


在 2024/2/6 06:18, Serge Semin 写道:
> On Tue, Jan 30, 2024 at 04:49:16PM +0800, Yanteng Si wrote:
>> Some chips of Loongson GNET does not support coe, so disable them.
> s/coe/Tx COE
OK.
>
>> Set dma_cap->tx_coe to 0 and overwrite get_hw_feature.
>>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> ---
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 46 +++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index b78a73ea748b..8018d7d5f31b 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -196,6 +196,51 @@ static int dwlgmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>>   	return ret;
>>   }
>>   
>> +static int dwlgmac_get_hw_feature(void __iomem *ioaddr,
> Please use GNET-specific prefix.
OK. loongson_gnet_get_hw_feature()
>
>> +				  struct dma_features *dma_cap)
>> +{
>> +	u32 hw_cap = readl(ioaddr + DMA_HW_FEATURE);
>> +
>> +	if (!hw_cap) {
>> +		/* 0x00000000 is the value read on old hardware that does not
>> +		 * implement this register
>> +		 */
>> +		return -EOPNOTSUPP;
>> +	}
> This doesn't seems like possible. All your devices have the
> HW-features register. If so please drop.
OK, drop it.
>
>> +
>> +	dma_cap->mbps_10_100 = (hw_cap & DMA_HW_FEAT_MIISEL);
>> +	dma_cap->mbps_1000 = (hw_cap & DMA_HW_FEAT_GMIISEL) >> 1;
>> +	dma_cap->half_duplex = (hw_cap & DMA_HW_FEAT_HDSEL) >> 2;
>> +	dma_cap->hash_filter = (hw_cap & DMA_HW_FEAT_HASHSEL) >> 4;
>> +	dma_cap->multi_addr = (hw_cap & DMA_HW_FEAT_ADDMAC) >> 5;
>> +	dma_cap->pcs = (hw_cap & DMA_HW_FEAT_PCSSEL) >> 6;
>> +	dma_cap->sma_mdio = (hw_cap & DMA_HW_FEAT_SMASEL) >> 8;
>> +	dma_cap->pmt_remote_wake_up = (hw_cap & DMA_HW_FEAT_RWKSEL) >> 9;
>> +	dma_cap->pmt_magic_frame = (hw_cap & DMA_HW_FEAT_MGKSEL) >> 10;
>> +	/* MMC */
>> +	dma_cap->rmon = (hw_cap & DMA_HW_FEAT_MMCSEL) >> 11;
>> +	/* IEEE 1588-2002 */
>> +	dma_cap->time_stamp =
>> +	    (hw_cap & DMA_HW_FEAT_TSVER1SEL) >> 12;
>> +	/* IEEE 1588-2008 */
>> +	dma_cap->atime_stamp = (hw_cap & DMA_HW_FEAT_TSVER2SEL) >> 13;
>> +	/* 802.3az - Energy-Efficient Ethernet (EEE) */
>> +	dma_cap->eee = (hw_cap & DMA_HW_FEAT_EEESEL) >> 14;
>> +	dma_cap->av = (hw_cap & DMA_HW_FEAT_AVSEL) >> 15;
>> +	/* TX and RX csum */
>> +	dma_cap->tx_coe = 0;
>> +	dma_cap->rx_coe_type1 = (hw_cap & DMA_HW_FEAT_RXTYP1COE) >> 17;
>> +	dma_cap->rx_coe_type2 = (hw_cap & DMA_HW_FEAT_RXTYP2COE) >> 18;
>> +	dma_cap->rxfifo_over_2048 = (hw_cap & DMA_HW_FEAT_RXFIFOSIZE) >> 19;
>> +	/* TX and RX number of channels */
>> +	dma_cap->number_rx_channel = (hw_cap & DMA_HW_FEAT_RXCHCNT) >> 20;
>> +	dma_cap->number_tx_channel = (hw_cap & DMA_HW_FEAT_TXCHCNT) >> 22;
>> +	/* Alternate (enhanced) DESC mode */
>> +	dma_cap->enh_desc = (hw_cap & DMA_HW_FEAT_ENHDESSEL) >> 24;
> I am not sure whether you need to parse the capability register at all
> seeing this is a GNET-specific method. For that device all the
> capabilities are already known and can be just initialized in this
> method.
-dma_cap->tx_coe = (hw_cap & DMA_HW_FEAT_TXCOESEL) >> 16;

+dma_cap->tx_coe = 0;

I'm a little confused. Actually, I only modified this line, which is 
used to fix the checksum.

2k2000  of Loongson GNET does not support coe.


Thanks,
Yanteng

>
> -Serge(y)
>
>> +
>> +	return 0;
>> +}
>> +
>>   struct stmmac_pci_info {
>>   	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
>>   	int (*config)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat,
>> @@ -542,6 +587,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>   		ld->dwlgmac_dma_ops = dwmac1000_dma_ops;
>>   		ld->dwlgmac_dma_ops.init_chan = dwlgmac_dma_init_channel;
>>   		ld->dwlgmac_dma_ops.dma_interrupt = dwlgmac_dma_interrupt;
>> +		ld->dwlgmac_dma_ops.get_hw_feature = dwlgmac_get_hw_feature;
>>   
>>   		plat->setup = loongson_setup;
>>   		ret = loongson_dwmac_config_multi_msi(pdev, plat, &res, np, 8);
>> -- 
>> 2.31.4
>>


