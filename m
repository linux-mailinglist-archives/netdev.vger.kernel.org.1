Return-Path: <netdev+bounces-96006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3A68C3F77
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651BF1F21910
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5804414B076;
	Mon, 13 May 2024 11:07:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080C314AD29
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715598466; cv=none; b=LJipdZ1ljZgn/DoTnhF99OnV9lFFS6kXgDnPKELZjY6b5AtmUypGgU+ZpDBFY9iuOuZCalqpB9MpV9Cen7LVqGVefj6cxBzu6YuRkO8vuyWVgdVDAiqYpOZFHI5MwbO9mxQhnv6Pp2suXacGC0PFrsZNKgtiVdnPN7xqg5946Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715598466; c=relaxed/simple;
	bh=fKULGgD6Rkrro8jfLndBJsrIenMsRa97mhmMaG+rX18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0UmzSsHy88MXPq+UecGvHIcWq1PU6bEXk+efn05bIRv2eK4A0rocmWTyrdn5rKXGFRGLs7ptRl/te/ckilNE3jY9pyiYKY6ArxxngNZjnInGkzIgt7osFuGpo1IkSAXRMh57qJA1WyahHAF4WIfi2xvHYVdqd8L11wdH3YeLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8Bx3+t99EFmCCYMAA--.29940S3;
	Mon, 13 May 2024 19:07:41 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxwVV69EFm3NocAA--.35813S3;
	Mon, 13 May 2024 19:07:39 +0800 (CST)
Message-ID: <29f046d6-67a8-4566-be6a-e2ee73037a94@loongson.cn>
Date: Mon, 13 May 2024 19:07:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 06/15] net: stmmac: dwmac-loongson: Split up
 the platform data initialization
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <e0ea692698171f9c69b80a70607a55805d249c4a.1714046812.git.siyanteng@loongson.cn>
 <arxxtmtifgus4qfai5nkemg46l5ql5ptqfodnflqpf2eenfj57@4x4h3vmcuw5x>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <arxxtmtifgus4qfai5nkemg46l5ql5ptqfodnflqpf2eenfj57@4x4h3vmcuw5x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxwVV69EFm3NocAA--.35813S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtrykGr1xKF1Duw4Utw45CFX_yoW3ZF4Dpr
	W8CanIg3srXr1Ikws0yw4UZryUArWrt347Cr18Ka48Cryqk34qqFyjgF4j9rZ7urWkZF12
	vF4jkr47uF4DGFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8oGQDUUUUU==


在 2024/5/4 02:08, Serge Semin 写道:
>> [PATCH net-next v12 06/15] net: stmmac: dwmac-loongson: Split up the platform data initialization
> Please convert the subject to being more specific, like this:
>
> net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
>
> On Thu, Apr 25, 2024 at 09:04:37PM +0800, Yanteng Si wrote:
>> Based on IP core classification, loongson has two types of network
> What is the real company name? At least start the name with the
> capital letter.
> * everywhere
OK,  LOONGSON
>
>> devices: GMAC and GNET. GMAC's ip_core id is 0x35/0x37, while GNET's
>> ip_core id is 0x37/0x10.
> s/ip_core/IP-core
>
> Once again the IP-core ID isn't _hex_, but a number of the format:
> "v+Major.Minor"
> so use the _real_ IP-core version number everywhere. Note mentioning
> that some of your GNET device has the GMAC_VERSION.SNPSVER hardwired
> to 0x10 is completely redundant in this and many other context. The
> only place where it's relevant is the patch(es) where you have the
> Snps ID override.
OK.
>
>> Device tables:
>>
>> device    type    pci_id    snps_id    channel
>> ls2k1000  gmac    7a03      0x35/0x37   1
>> ls7a1000  gmac    7a03      0x35/0x37   1
>> ls2k2000  gnet    7a13      0x10        8
>> ls7a2000  gnet    7a13      0x37        1
> s/gmac/GMAC
> s/gnet/GNET
> s/pci_id/PCI Dev ID
> s/snsp_id/Synopys Version
> s/channels/DMA-channels
> s/ls2k/LS2K
> s/ls7a/LS7A
>
> * everywhere
OK.
>
>> The GMAC device only has a MAC chip inside and needs an
>> external PHY chip;
>>
>> To later distinguish 8-channel gnet devices from single-channel
>> gnet/gmac devices, move rx_queues_to_use loongson_default_data
>> to loongson_dwmac_probe(). Also move mac_interface to
>> loongson_default_data().
> Again. This is only a part of the reason why you need this change.
> The main reason is to provide the two-leveled platform data init
> functions: fist one is the common method initializing the data common
> for both GMAC and GNET, second one is the device-specific data
> initializer.
>
> To sum up I would change the commit log to something like this:
>
> "Loongson delivers two types of the network devices: Loongson GMAC and
> Loongson GNET in the framework of four CPU/Chipsets revisions:
>
>     Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
> LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
> LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
> LS2K2000 CPU         GNET      0x7a13          v3.73a            8
> LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
>
> The driver currently supports the chips with the Loongson GMAC network
> device. As a preparation before adding the Loongson GNET support
> detach the Loongson GMAC-specific platform data initializations to the
> loongson_gmac_data() method and preserve the common settings in the
> loongson_default_data().
>
> While at it drop the return value statement from the
> loongson_default_data() method as redundant."
OK, Thanks!
>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 20 ++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index 4e0838db4259..904e288d0be0 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -11,22 +11,20 @@
>>   
>>   #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>>   
>> -static int loongson_default_data(struct plat_stmmacenet_data *plat)
>> +static void loongson_default_data(struct plat_stmmacenet_data *plat)
>>   {
>>   	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>>   	plat->has_gmac = 1;
>>   	plat->force_sf_dma_mode = 1;
>>   
>> +	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
>> +
> I double-checked this part in my HW and in the databooks. DW GMAC with
> _RGMII_ PHY-interfaces can't be equipped with a PCS (STMMAC driver is
> wrong in considering otherwise at least in the Auto-negotiation part).
> PCS is only available for the RTI, RTBI and SGMII interfaces.
>
> You can double-check that by checking out the DMA_HW_FEATURE.PCSSEL
> flag state. I'll be surprised if it's set in your case. If it isn't
> then either drop the plat_stmmacenet_data::mac_interface
> initialization or (as Russell suggested) initialize it with
> PHY_INTERFACE_MODE_NA. But do that in a separate pre-requisite patch!
OK.
>
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
>> @@ -41,6 +39,12 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>>   	plat->dma_cfg->pblx8 = true;
>>   
>>   	plat->multicast_filter_bins = 256;
>> +}
>> +
>> +static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
>> +{
>> +	loongson_default_data(plat);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -109,11 +113,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
>> @@ -138,6 +141,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   		goto err_disable_msi;
>>   	}
>>   
>> +	plat->tx_queues_to_use = 1;
>> +	plat->rx_queues_to_use = 1;
>> +
> You can freely move this to loongson_gmac_data() method. And then, in
> the patch adding the GNET-support, you'll be able to provide these fields
> initialization in the loongson_gnet_data() method together with the
> plat->tx_queues_cfg[*].coe_unsupported flag init. Thus the probe()
> method will get to be smaller and easier to read, and the
> loongson_*_data() method will be more coherent.

As you said, at first glance, putting them in loongson_gnet_data() 
method is fine,

but in LS2K2000:

         plat->rx_queues_to_use = CHANNEL_NUM;    // CHANNEL_NUM = 8;
         plat->tx_queues_to_use = CHANNEL_NUM;

So we need to distinguish between them. At the same time, we have to 
distinguish

between LS2K2000 in probe() method. Why not put them inside probe, which 
will

save a lot of duplicate code, like this:

     struct stmmac_resources res;
     struct loongson_data *ld;

...

     memset(&res, 0, sizeof(res));
     res.addr = pcim_iomap_table(pdev)[0];
     ld->gmac_verion = readl(res.addr + GMAC_VERSION) & 0xff;

     switch (ld->gmac_verion) {
     case LOONGSON_DWMAC_CORE_1_00:
         plat->rx_queues_to_use = CHANNEL_NUM;
         plat->tx_queues_to_use = CHANNEL_NUM;

         /* Only channel 0 supports checksum,
          * so turn off checksum to enable multiple channels.
          */
         for (i = 1; i < CHANNEL_NUM; i++)
             plat->tx_queues_cfg[i].coe_unsupported = 1;

         ret = loongson_dwmac_config_msi(pdev, plat, &res, np);
         break;
     default:    /* 0x35 device and 0x37 device. */
         plat->tx_queues_to_use = 1;
         plat->rx_queues_to_use = 1;

         ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
         break;
     }
     if (ret)
         goto err_disable_device;


What do you think?


Of course, if you insist, I'm willing to repeat this in the

loongson_gnet_data() method.



Thanks,

Yanteng


