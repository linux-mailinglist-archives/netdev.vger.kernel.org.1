Return-Path: <netdev+bounces-111467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6302931327
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5976B1F23A75
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723E31891DA;
	Mon, 15 Jul 2024 11:35:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E794D18629E
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043316; cv=none; b=Lh1i/3hlc9YXFtNC3J1dm3Iw8G77X7pP8SMgWvD00laJ/YGqgQ6U5NaTlbgqA6pfg/L7fucJjNs2OS69URHu13NQsUWmGFuI9L9Ekk1FYOvsoE3vms/fwTfOsZgPVTL1qtIc7xliTQ4BTG5RfWwtd8Q8SGm1U0I24Fu4BTxklgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043316; c=relaxed/simple;
	bh=toOaoQysFEysb/mv3TZ92tsLXvsVT5YqQrIRg5tAt/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvmPd6vNLY85n9AWcO0wKH1N8JNKtTmu6U+DyUcNX+FkNinDsrLyya/HZhddioWu8Kz9ZP3D8ql3Ziknq1jUy9oeEAI1qfhTDFRfoBRQA4muj3qKoH/rYizoDd9td28k7HlB2diCZSuoQAVohYQWlT+JvjCtWjrOqgsNhnZkssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.130])
	by gateway (Coremail) with SMTP id _____8CxLOttCZVmdpYEAA--.12020S3;
	Mon, 15 Jul 2024 19:35:09 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.130])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTcdoCZVmCrlJAA--.36069S3;
	Mon, 15 Jul 2024 19:35:06 +0800 (CST)
Message-ID: <84d5db29-5da4-440c-82a4-e223e3afc977@loongson.cn>
Date: Mon, 15 Jul 2024 19:35:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 00/14] stmmac: Add Loongson platform support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1720512634.git.siyanteng@loongson.cn>
 <xebiag2qjzaxgmtl4o5fn4zaon75gjl4akzxgb56ngxeahm2eu@si4our7feved>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <xebiag2qjzaxgmtl4o5fn4zaon75gjl4akzxgb56ngxeahm2eu@si4our7feved>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTcdoCZVmCrlJAA--.36069S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFWkGF47Jw4rtFyDuFW5twc_yoWrGw45pr
	yfAan8Cr9FvryfAan8Zw1UZry8ZFyYyrZruF4ftr9Fkasruw1Yq34xWayYyw47Zrs5WFyU
	uFW8WF4Duan8CrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
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
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU


在 2024/7/11 23:35, Serge Semin 写道:
> Hi Yanteng
>
> On Tue, Jul 09, 2024 at 05:34:07PM +0800, Yanteng Si wrote:
>> v14:
>>
>> Because Loongson GMAC can be also found with the 8-channels AV feature
>> enabled, we'll need to reconsider the patches logic and thus the
>> commit logs too. As Serge's comments and Russell's comments:
>> [PATCH net-next v14 01/15] net: stmmac: Move the atds flag to the stmmac_dma_cfg structure
>> [PATCH net-next v14 02/15] net: stmmac: Add multi-channel support
>> [PATCH net-next v14 03/15] net: stmmac: Export dwmac1000_dma_ops
>> [PATCH net-next v14 04/15] net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size init
>> [PATCH net-next v14 05/15] net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi calls
>> [PATCH net-next v14 06/15] net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device identification
>> [PATCH net-next v14 07/15] net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
>> +-> Init the plat_stmmacenet_data::{tx_queues_to_use,rx_queues_to_use}
>>      in the loongson_gmac_data() method.
>> [PATCH net-next v14 08/15] net: stmmac: dwmac-loongson: Init ref and PTP clocks rate
>> [PATCH net-next v14 09/15] net: stmmac: dwmac-loongson: Add phy_interface for Loongson GMAC
>> [PATCH net-next v14 10/15] net: stmmac: dwmac-loongson: Introduce PCI device info data
>> +-> Make sure the setup() method is called after the pci_enable_device()
>>      invocation.
>> [PATCH net-next v14 11/15] net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
>> +-> Introduce the loongson_dwmac_dt_config() method here instead of
>>      doing that in a separate patch.
>> +-> Add loongson_dwmac_acpi_config() which would just get the IRQ from
>>      the pdev->irq field and make sure it is valid.
>> [PATCH net-next v14 12/15] net: stmmac: Fixed failure to set network speed to 1000.
>> +-> Drop the patch as Russell's comments, At the same time, he provided another
>>      better repair suggestion, and I decided to send it separately after the
>>      patch set was merged. See:
>>      <https://lore.kernel.org/netdev/ZoW1fNqV3PxEobFx@shell.armlinux.org.uk/>
>> [PATCH net-next v14 13/15] net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support
>> +-> This is former "net: stmmac: dwmac-loongson: Add Loongson GNET
>>      support" patch, but which adds the support of the Loongson GMAC with the
>>      8-channels AV-feature available.
>> +-> loongson_dwmac_intx_config() shall be dropped due to the
>>      loongson_dwmac_acpi_config() method added in the PATCH 11/15.
>> +-> Make sure loongson_data::loongson_id  is initialized before the
>>      stmmac_pci_info::setup()  is called.
>> +-> Move the rx_queues_to_use/tx_queues_to_use and coe_unsupported
>>      fields initialization to the loongson_gmac_data() method.
>> +-> As before, call the loongson_dwmac_msi_config() method if the multi-channels
>>      Loongson MAC has been detected.
>> +-> Move everything GNET-specific to the next patch.
>> [PATCH net-next v14 14/15] net: stmmac: dwmac-loongson: Add Loongson GNET support
>> +-> Everything Loonsgson GNET-specific is supposed to be added in the
>>      framework of this patch:
>>      + PCI_DEVICE_ID_LOONGSON_GNET macro
>>      + loongson_gnet_fix_speed() method
>>      + loongson_gnet_data() method
>>      + loongson_gnet_pci_info data
>>      + The GNET-specific part of the loongson_dwmac_setup() method.
>>      + ...
>> [PATCH net-next v14 15/15] net: stmmac: dwmac-loongson: Add loongson module author
>>
>> Other's:
>> Pick Serge's Reviewed-by tag.
> Thanks for submitting an update. I've briefly looked at it and spotted a
> few places left to improve. I'll send my comments on the next week.

Okay, thank you for spending a lot of time and effort reviewing our patch.


Thanks,

Yanteng


