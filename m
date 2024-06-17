Return-Path: <netdev+bounces-103977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F23090AA93
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 12:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18881F24564
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA06188CD0;
	Mon, 17 Jun 2024 10:02:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC11A18C326
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618545; cv=none; b=ZXDJgxgg3FCdtb/Rx9p4njVU4iC1TOHtEvYytklbcG6gTkLSuVM2eT2Su9UsavH8OCNqfZCpRAeZRCKHP+ztcFtKMgmESlgZXvrK1oB1kdkdc1jOV1iDcaL4VOgAAUGtUaNTbiR7FqeyshyEDy3YBa+jjVCitX/eElMxOpUw2Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618545; c=relaxed/simple;
	bh=IBL2p5cX+CU7WpuIWMGRn3Cl9Z2pe6CTPZkt5FZJDfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gl8tpw4DMD6xFTOfhEJlkI+pDqOhX5Bg9qt6FZEbuCYy1tGQ7lgf1nM+A4BF3k1M9QIhqS1AcPuW7IeyW6myB8EabfZ+9BHKPaVbgFqAJCYZfNRGcz1NcQLUCDXSoU4Im51l4rkZmEugZwiXUTztv9ABMpLfshHn6D0SsSHQM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.225])
	by gateway (Coremail) with SMTP id _____8Dxi+o2CXBmpYkHAA--.30517S3;
	Mon, 17 Jun 2024 18:00:22 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.225])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxssQzCXBmIWMlAA--.13502S3;
	Mon, 17 Jun 2024 18:00:20 +0800 (CST)
Message-ID: <eb305275-6509-4887-ad33-67969a9d5144@loongson.cn>
Date: Mon, 17 Jun 2024 18:00:19 +0800
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
 <wosihpytgfb6icdw7326xtez45cm6mbfykt4b7nlmg76xpwu4m@6xwvqj7ls7is>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <wosihpytgfb6icdw7326xtez45cm6mbfykt4b7nlmg76xpwu4m@6xwvqj7ls7is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxssQzCXBmIWMlAA--.13502S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Aw18JrW8ArW5Wr4ktF4UJrc_yoW7CF43pr
	W8Ca9rWa47XF1xtw4Dtw4UZry5ArW3t34UuF1Ut3WfGryDCw1jq3W2gF409FZ7ZFWkuw12
	vF1jkr43uFs8KwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
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

Hi Serge,

在 2024/6/15 00:19, Serge Semin 写道:
> On Wed, May 29, 2024 at 06:19:03PM +0800, Yanteng Si wrote:
>> Loongson delivers two types of the network devices: Loongson GMAC and
>> Loongson GNET in the framework of four CPU/Chipsets revisions:
>>
>>     Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
>> LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
>> LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
>> LS2K2000 CPU         GNET      0x7a13          v3.73a            8
>> LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
> You mentioned in the cover-letter
> https://lore.kernel.org/netdev/cover.1716973237.git.siyanteng@loongson.cn/
> that LS2K now have GMAC NICs too:
> " 1. The current LS2K2000 also have a GMAC(and two GNET) that supports 8
>      channels, so we have to reconsider the initialization of
>      tx/rx_queues_to_use into probe();"
>
> But I don't see much changes in the series which would indicate that
> new data. Please clarify what does it mean:
>
> Does it mean LS2K2000 has two types of the DW GMACs, right?
Yes!
>
> Are both of them based on the DW GMAC v3.73a IP-core with AV-feature
> enabled and 8 DMA-channels?
Yes!
>
> Seeing you called the new device as GMAC it doesn't have an
> integrated PHY as GNETs do, does it? If so, then neither
> STMMAC_FLAG_DISABLE_FORCE_1000 nor loongson_gnet_fix_speed() relevant
> for the new device, right?
YES!
>
> Why haven't you changed the sheet in the commit log? Shall the sheet
> be updated like this:
>
>      Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
>   LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
>   LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
> +LS2K2000 CPU         GMAC      0x7a13          v3.73a            8
>   LS2K2000 CPU         GNET      0x7a13          v3.73a            8
>   LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
>
> ?

No! PCI Dev ID of GMAC is 0x7a03. So:

  LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a 1
  LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a 1
+LS2K2000 CPU         GMAC      0x7a03          v3.73a 8
  LS2K2000 CPU         GNET      0x7a13          v3.73a 8
  LS7A2000 Chipset     GNET      0x7a13          v3.73a 1

>
> I'll continue reviewing the series after the questions above are
> clarified.

OK, If anything else is unclear, please let me know.


Thanks,

Yanteng


>
> -Serge(y)
>
>> The driver currently supports the chips with the Loongson GMAC network
>> device. As a preparation before adding the Loongson GNET support
>> detach the Loongson GMAC-specific platform data initializations to the
>> loongson_gmac_data() method and preserve the common settings in the
>> loongson_default_data().
>>
>> While at it drop the return value statement from the
>> loongson_default_data() method as redundant.
>>
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
>>   	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>>   	if (ret)
>>   		goto err_disable_msi;
>> -- 
>> 2.31.4
>>


