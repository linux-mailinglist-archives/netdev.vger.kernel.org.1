Return-Path: <netdev+bounces-80757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB0880F93
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FF51F2228D
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85473CF51;
	Wed, 20 Mar 2024 10:23:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4271F3C48D
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930207; cv=none; b=NaBsAUJXhceWp/ZXwAmitUS2pHf6RND/C9Fl1tpSvFmgRBXLrtqpqTzS3bZBZILYqUxeVY27zZVCaIEyN35omZGVyS4qJhhK7KSx0Z4q1zaiPq5CPUCJ08GEFmh0CT5/KnRwDAogmiFpTdVAJmILr/+NtJTinlEl2PJJoR/7aDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930207; c=relaxed/simple;
	bh=gacuUsieTjSDwfJ+Dd617AnbO3npO9CarMZn7llKTUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u78bNW5THBXR87GysrDvQzO8slrS/20FSlH9p5XJTNaReZjGShyvw5nVVyqT7ob/Ioe+GiltmwFFnYQx0zPi2TFKSAYLycPn0JyJZkGNypABcO25jQl3NsM3OdMYmv4LJ8SUnN8ng0saL5e2NVgJnwdDzdSHjOAZJavBPJkV9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8Cx77sWufplhDcbAA--.45514S3;
	Wed, 20 Mar 2024 18:23:18 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTs0TufplUVJeAA--.49904S3;
	Wed, 20 Mar 2024 18:23:15 +0800 (CST)
Message-ID: <3fcc6015-4ec2-4639-a089-1caa911d35e3@loongson.cn>
Date: Wed, 20 Mar 2024 18:23:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET
 support
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <027b4ee29d4d7c8a22d2f5c551f5c21ced3fb046.1706601050.git.siyanteng@loongson.cn>
 <ftqxjh67a7s4iprpiuw5xxmncj3bveezf5vust7cej3kowwcvj@m7nqrxq7oe2f>
 <d0e56c9b-9549-4061-8e44-2504b6b96897@loongson.cn>
 <466f138d-0baa-4a86-88af-c690105e650e@loongson.cn>
 <x6wwfvuzqpzfzstb3l5adp354z2buevo35advv7q347gnmo3zn@vfzwca5fafd3>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <x6wwfvuzqpzfzstb3l5adp354z2buevo35advv7q347gnmo3zn@vfzwca5fafd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTs0TufplUVJeAA--.49904S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xry5tryUtFW3Ar1UCw17urX_yoW3Ar1xpr
	W3Aa1UKrWDJr15C3Wvvw4DZrnIyrWfJryDur47t34UGF1qka42qryUKFWYkFyxCrWDuF1j
	vr4jkrW7uFn8GrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==


在 2024/3/19 23:03, Serge Semin 写道:
> On Thu, Mar 14, 2024 at 09:12:49PM +0800, Yanteng Si wrote:
>> 在 2024/3/14 16:27, Yanteng Si 写道:
>>> 在 2024/2/6 04:58, Serge Semin 写道:
>>>> On Tue, Jan 30, 2024 at 04:48:18PM +0800, Yanteng Si wrote:
>>>>> Add Loongson GNET (GMAC with PHY) support, override
>>>>> stmmac_priv.synopsys_id with 0x37.
>>>> Please add more details of all the device capabilities: supported
>>>> speeds, duplexness, IP-core version, DMA-descriptors type
>>>> (normal/enhanced), MTL Tx/Rx FIFO size, Perfect and Hash-based MAC
>>>> Filter tables size, L3/L4 filters availability, VLAN hash table
>>>> filter, PHY-interface (GMII, RGMII, etc), EEE support,
>>>> AV-feature/Multi-channels support, IEEE 1588 Timestamp support, Magic
>>>> Frame support, Remote Wake-up support, IP Checksum, Tx/Rx TCP/IP
>>>> Checksum, Mac Management Counters (MMC), SMA/MDIO interface,
>>> The gnet (2k2000) of 0x10 supports full-duplex and half-duplex at 1000/100/10M.
>>> The gnet of 0x37 (i.e. the gnet of 7a2000) supports 1000/100/10M full duplex.
>>>
>>> The gnet with 0x10 has 8 DMA channels, except for channel 0, which does not
>>> support sending hardware checksums.
>>>
>>> Supported AV features are Qav, Qat, and Qas, and other features should be
>>> consistent with the 3.73 IP.
> Just list all of these features in the commit message referring to the
> respective controller. Like this:
> "There are two types of them Loongson GNET controllers:
> Loongson 2k2000 GNET and the rest of the Loongson GNETs (like
> presented on the 7a2000 SoC). All of them of the DW GMAC 3.73a
> IP-core with the next features:
> Speeds, DMA-descriptors type (normal/enhanced), MTL Tx/Rx FIFO size,
> Perfect and Hash-based MAC Filter tables size, L3/L4 filters availability,
> VLAN hash table filter, PHY-interface (GMII, RGMII, etc), EEE support,
> IEEE 1588 Timestamp support, Magic Frame support, Remote Wake-up support,
> IP Checksum, Tx/Rx TCP/IP Checksum, Mac Management Counters (MMC),
> SMA/MDIO interface.
>
> The difference is that the Loongson 2k2000 GNET controller supports 8
> DMA-channels, AV features (Qav, Qat, and Qas) and half-duplex link,
> meanwhile the rest of the GNETs don't have these capabilities
> available."
OK, Thanks!
>
>>>>> Signed-off-by: Yanteng Si<siyanteng@loongson.cn>
>>>>> Signed-off-by: Feiyang Chen<chenfeiyang@loongson.cn>
>>>>> Signed-off-by: Yinggang Gu<guyinggang@loongson.cn>
>>>>> ---
>>>>>    .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 44 +++++++++++++++++++
>>>>>    1 file changed, 44 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>> index 3b3578318cc1..584f7322bd3e 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>>> @@ -318,6 +318,8 @@ static struct mac_device_info *loongson_setup(void *apriv)
>>>>>    	if (!mac)
>>>>>    		return NULL;
>>>>>    >> +	priv->synopsys_id = 0x37;	/*Overwrite custom IP*/
>>>>> +
>>>> Please add a more descriptive comment _above_ the subjected line. In
>>>> particular note why the override is needed, what is the real DW GMAC
>>>> IP-core version and what is the original value the statement above
>>>> overrides.
>>> The IP-core version of the gnet device on the loongson 2k2000 is 0x10, which is
>>> a custom IP.
>>>
>>> Compared to 0x37, we have split some of the dma registers into two (tx and rx).
>>> After overwriting stmmac_dma_ops.dma_interrupt() and stmmac_dma_ops.init_chan(),
>>> the logic is consistent with 0x37,
>>>
>>> so we overwrite synopsys_id to 0x37.
> Yeah, something like that:
> 	/* The original IP-core version is 0x37 in all Loongson GNET
> 	 * (2k2000 and 7a2000), but the GNET HW designers have changed the
> 	 * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the Loongson
> 	 * 2k2000 MAC to emphasize the differences: multiple DMA-channels, AV
> 	 * feature and GMAC_INT_STATUS CSR flags layout. Get back the
> 	 * original value so the correct HW-interface would be
> 	 * selected.
> 	 */
OK, Thanks!
>>>>>    	ld = priv->plat->bsp_priv;
>>>>>    	mac->dma = &ld->dwlgmac_dma_ops;
>>>>>    >> @@ -350,6 +352,46 @@ static struct mac_device_info
>>> *loongson_setup(void *apriv)
>>>>>    	return mac;
>>>>>    }
>>>>>    >> +static int loongson_gnet_data(struct pci_dev *pdev,
>>>>> +			      struct plat_stmmacenet_data *plat)
>>>>> +{
>>>>> +	loongson_default_data(pdev, plat);
>>>>> +
>>>>> +	plat->multicast_filter_bins = 256;
>>>>> +
>>>>> +	plat->mdio_bus_data->phy_mask =  ~(u32)BIT(2);
>>>>> +
>>>>> +	plat->phy_addr = 2;
>>>>> +	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
>>>> Are you sure PHY-interface is supposed to be defined as "internal"?
>>> Yes, because the gnet hardware has a integrated PHY, so we set it to internal，
>>>
> Why do you need the phy_addr set to 2 then? Is PHY still discoverable
> on the subordinate MDIO-bus?
>
> kdoc in "include/linux/phy.h" defines the PHY_INTERFACE_MODE_INTERNAL
> mode as for a case of the MAC and PHY being combined. IIUC it's
> reserved for a case when you can't determine actual interface between
> the MAC and PHY. Is it your case? Are you sure the interface between
> MAC and PHY isn't something like GMII/RGMII/etc?

Please allow me to consult with our hardware engineers before replying 
to you. :)


Thanks,

Yanteng

>
> -Serge(y)
>
>>> Correspondingly, our gmac hardware PHY is external.
>>>
>>>>> +
>>>>> +	plat->bsp_priv = &pdev->dev;
>>>>> +
>>>>> +	plat->dma_cfg->pbl = 32;
>>>>> +	plat->dma_cfg->pblx8 = true;
>>>>> +
>>>>> +	plat->clk_ref_rate = 125000000;
>>>>> +	plat->clk_ptp_rate = 125000000;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int loongson_gnet_config(struct pci_dev *pdev,
>>>>> +				struct plat_stmmacenet_data *plat,
>>>>> +				struct stmmac_resources *res,
>>>>> +				struct device_node *np)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
>>>> Again. This will be moved to the probe() method in one of the next
>>>> patches leaving loongson_gnet_config() empty. What was the problem
>>>> with doing that right away with no intermediate change?
>>> No problem. My original intention is to break the patches down into smaller pieces.
>>>
>>> In the next version, I will try to re-break them based on your comments.
>>>
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static struct stmmac_pci_info loongson_gnet_pci_info = {
>>>>> +	.setup = loongson_gnet_data,
>>>>> +	.config = loongson_gnet_config,
>>>>> +};
>>>>> +
>>>>>    static int loongson_dwmac_probe(struct pci_dev *pdev,
>>>>>    				const struct pci_device_id *id)
>>>>>    {
>>>>> @@ -516,9 +558,11 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>>>>>    			 loongson_dwmac_resume);
>>>>>    >>   #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>>>>> +#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
>>>>>    >>   static const struct pci_device_id loongson_dwmac_id_table[] =
>>> {
>>>>>    	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>>>>> +	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
>>>> After this the driver is supposed to correctly handle the Loongson
>>>> GNET devices. Based on the patches introduced further it isn't.
>>>> Please consider re-arranging the changes (see my comments in the
>>>> further patches).
>>> OK.
>>>
>>>
>>> Thanks,
>>>
>>> Yanteng
>>>
>>>
>>>> -Serge(y)
>>>>
>>>>>    	{}
>>>>>    };
>>>>>    MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
>>>>> -- >> 2.31.4
>>>>>


