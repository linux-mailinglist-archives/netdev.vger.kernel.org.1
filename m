Return-Path: <netdev+bounces-108460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109E0923E8B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B771C2299B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481E618755A;
	Tue,  2 Jul 2024 13:14:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE1178381
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926057; cv=none; b=SmwkUAr7mKJcwhjXLOhbqmUGEDjNe+77L7aIR1O4RPasW3o30vWUblLqEjmr3oL6XJwiVUrhwnBVv3CkmVHPEGGUut8/ovp8vIU2yEzmnjjE+DrAtejhpbCoF2n9okZnUswjLHhZk6IXMqx9fGhv6HahP4grjcU0vmrasv8sxy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926057; c=relaxed/simple;
	bh=A5iVFYoASUF69p31hcrRAoGe7u/Su3GrJLMC8nh6ti4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvbxCkYUN2q0ilVQ7UhWQO3IjHEnU/z/Bxq9+/I3SI8jrimFkatkAYv4b5d3Hl1ca54mr0dq8uHk1BBheVvul2Z2etNVSV1V7id3rLlX5/KNP4fn/PN+zHc5BXP6Jmv0H8D55duJqV6OIrP4sJD6bFA7obq8J63VA2WFXThLB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.45])
	by gateway (Coremail) with SMTP id _____8CxLOsi_YNm7CcAAA--.331S3;
	Tue, 02 Jul 2024 21:14:10 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.45])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Axjscf_YNm+JQ4AA--.412S3;
	Tue, 02 Jul 2024 21:14:08 +0800 (CST)
Message-ID: <475878c7-f386-4dd3-acb8-9f5a5f1b9102@loongson.cn>
Date: Tue, 2 Jul 2024 21:14:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b987281834a734777ad02acf96e968f05024c031.1716973237.git.siyanteng@loongson.cn>
 <io5eoyp7eq656fzrrd5htq3d7rc22tm7b5zpi6ynaoawhdb7sp@b5ydxzhtqg6x>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <io5eoyp7eq656fzrrd5htq3d7rc22tm7b5zpi6ynaoawhdb7sp@b5ydxzhtqg6x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Axjscf_YNm+JQ4AA--.412S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Wr4DAF4UCr4rCF18tr47trc_yoWxGF43pr
	WrCanrWasFqr10yws0qw4DZry5ArW5t347uF47ta48CryDGw1qq342gF409rZ7ZFWkZF17
	ZF4jkr47uFs8KFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==


在 2024/7/2 16:28, Serge Semin 写道:
> On Wed, May 29, 2024 at 06:19:03PM +0800, Yanteng Si wrote:
>> Loongson delivers two types of the network devices: Loongson GMAC and
>> Loongson GNET in the framework of four CPU/Chipsets revisions:
>>
>>     Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
>> LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
>> LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
>> LS2K2000 CPU         GNET      0x7a13          v3.73a            8
>> LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
>>
>> The driver currently supports the chips with the Loongson GMAC network
>> device. As a preparation before adding the Loongson GNET support
>> detach the Loongson GMAC-specific platform data initializations to the
>> loongson_gmac_data() method and preserve the common settings in the
>> loongson_default_data().
>>
>> While at it drop the return value statement from the
>> loongson_default_data() method as redundant.
> Based on the last hardware setup insight Loongson GMAC with AV-feature
> can be found on the LS2K2000 CPU. Thus the commit log should be:
>
> "Loongson delivers two types of the network devices: Loongson GMAC and
> Loongson GNET in the framework of four CPU/Chipsets revisions:
>
>     Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
> LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
> LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
> LS2K2000 CPU         GMAC      0x7a03          v3.73a            8
> LS2K2000 CPU         GNET      0x7a13          v3.73a            8
> LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
>
> The driver currently supports the chips with the Loongson GMAC network
> device synthesized with a single DMA-channel available. As a
> preparation before adding the Loongson GNET support detach the
> Loongson GMAC-specific platform data initializations to the
> loongson_gmac_data() method and preserve the common settings in the
> loongson_default_data().
>
> While at it drop the return value statement from the
> loongson_default_data() method as redundant."
OK, Thank you very much!
>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 19 ++++++++++++-------
>>   1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index 739b73f4fc35..ad3f44440963 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -11,7 +11,7 @@
>>   
>>   #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>>   
>> -static int loongson_default_data(struct plat_stmmacenet_data *plat)
>> +static void loongson_default_data(struct plat_stmmacenet_data *plat)
>>   {
>>   	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>>   	plat->has_gmac = 1;
>> @@ -20,16 +20,14 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>>   	/* Set default value for multicast hash bins */
>>   	plat->multicast_filter_bins = 256;
>>   
>> +	plat->mac_interface = PHY_INTERFACE_MODE_NA;
>> +
>>   	/* Set default value for unicast filter entries */
>>   	plat->unicast_filter_entries = 1;
>>   
>>   	/* Set the maxmtu to a default of JUMBO_LEN */
>>   	plat->maxmtu = JUMBO_LEN;
>>   
>> -	/* Set default number of RX and TX queues to use */
>> -	plat->tx_queues_to_use = 1;
>> -	plat->rx_queues_to_use = 1;
>> -
>>   	/* Disable Priority config by default */
>>   	plat->tx_queues_cfg[0].use_prio = false;
>>   	plat->rx_queues_cfg[0].use_prio = false;
>> @@ -42,6 +40,11 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>>   
>>   	plat->dma_cfg->pbl = 32;
>>   	plat->dma_cfg->pblx8 = true;
>> +}
>> +
>> +static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
>> +{
>> +	loongson_default_data(plat);
>>   
>>   	return 0;
>>   }
>> @@ -111,11 +114,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	}
>>   
>>   	plat->phy_interface = phy_mode;
>> -	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
>>   
>>   	pci_set_master(pdev);
>>   
>> -	loongson_default_data(plat);
>> +	loongson_gmac_data(plat);
>>   	pci_enable_msi(pdev);
>>   	memset(&res, 0, sizeof(res));
>>   	res.addr = pcim_iomap_table(pdev)[0];
>> @@ -140,6 +142,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   		goto err_disable_msi;
>>   	}
>>   
>> +	plat->tx_queues_to_use = 1;
>> +	plat->rx_queues_to_use = 1;
>> +
> Please move this to the loongson_gmac_data(). Thus all the
> platform-data initializations would be collected in two coherent
> methods: loongson_default_data() and loongson_gmac_data(). It will be
> positive from the readability and maintainability points of view.

OK, I will move this to the  loongson_default_data(),

Because loongson_gmac/gnet_data() call it.


>
> In the patch adding the Loongson multi-channel GMAC support make sure
> the loongson_data::loongson_id field is initialized before the
> stmmac_pci_info::setup() method is called.

I've tried. It's almost impossible.


The only way to do this is to initialize loongson_id again in 
loongson_default_data().

But that will add a lot of code.


Hmm, how about:


loongson_default_data() {

     plat->tx_queues_to_use = 1;
     plat->rx_queues_to_use = 1;

     ...

}


loongson_dwmac_probe() {

     ...

     if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
         plat->rx_queues_to_use = CHANNEL_NUM;
         plat->tx_queues_to_use = CHANNEL_NUM;

         /* Only channel 0 supports checksum,
          * so turn off checksum to enable multiple channels.
          */
         for (i = 1; i < CHANNEL_NUM; i++)
             plat->tx_queues_cfg[i].coe_unsupported = 1;

         ret = loongson_dwmac_msi_config(pdev, plat, &res);
     } else {
         ret = loongson_dwmac_intx_config(pdev, plat, &res);
     }

     ...

}



Thanks,

Yanteng

>
> -Serge(y)
>
>>   	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>>   	if (ret)
>>   		goto err_disable_msi;
>> -- 
>> 2.31.4
>>


