Return-Path: <netdev+bounces-108375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68CD9239D8
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675C71F22B83
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015BD156962;
	Tue,  2 Jul 2024 09:24:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B49F153836
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912277; cv=none; b=kua85fjen/GRQ43d/TTQs4gHNuvCpMrRkVYmEcvMFBw/CxduUFPF7w++v/oVRUynj08yHtzpP26yueCJKR46mgOYx31FfxvARdSqVBINcxDjCJh4OtfJRw+4pgvpcKOJjw3q86B5NGCUlPJwWCVEWDtr1Ae5RO7ALA2nrCR1JAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912277; c=relaxed/simple;
	bh=Apb08SlADGIPecUxWIzphbbJaxEu4VxBte60/Q7syrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lp9q1VVPkFQ6YUjibTGhDJaGRCzA+q5OrWdbzoY+YFxVKd1o+Aouleq4lVNy0B52d5kgHRWbai/Fas1lBfxEr/xoWWCxn6Gee5rlkoSD2Kj0Y5s/eIo8UVUQZ8wm/cX/fQfXfWGWVDbp8y8gRUi0Jqz+daBzJoaXE+Jn1E3Kh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.45])
	by gateway (Coremail) with SMTP id _____8AxDOtQx4NmBxgAAA--.180S3;
	Tue, 02 Jul 2024 17:24:32 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.45])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxZcVMx4NmSmk4AA--.55315S3;
	Tue, 02 Jul 2024 17:24:29 +0800 (CST)
Message-ID: <dc3abcec-abaa-4ca5-a651-428b6e583f39@loongson.cn>
Date: Tue, 2 Jul 2024 17:24:28 +0800
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
 <eb305275-6509-4887-ad33-67969a9d5144@loongson.cn>
 <xafdw4u5nqknn2qehkke5p4mrj4bnfh33pcmkob5gbl7y5apr4@pkwmf6vphxsh>
 <55193345-f390-4fbb-b4e6-0bcd82cedc9a@loongson.cn>
 <6ergp6oqrccwzsvdshnapkaukurquouf74x7l7agnmzbhctwma@qw63qlynrred>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <6ergp6oqrccwzsvdshnapkaukurquouf74x7l7agnmzbhctwma@qw63qlynrred>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxZcVMx4NmSmk4AA--.55315S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxKFW7CFWfWF1kKr1rCF1fKrX_yoWxXF43pr
	WrAa9rGr9rXF1xAan0qr1UJry0vFy5Jw4UuF48tFyUK3sF9w1jqr1xuFWYgr9rZr4kZFyU
	ZFy8XFnruFs8CrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2024/7/2 06:57, Serge Semin 写道:
> On Tue, Jun 25, 2024 at 08:31:32PM +0800, Yanteng Si wrote:
>> 在 2024/6/24 09:47, Serge Semin 写道:
>>> On Mon, Jun 17, 2024 at 06:00:19PM +0800, Yanteng Si wrote:
>>>> Hi Serge,
>>>>
>>>> 在 2024/6/15 00:19, Serge Semin 写道:
>>>>> On Wed, May 29, 2024 at 06:19:03PM +0800, Yanteng Si wrote:
>>>>>> Loongson delivers two types of the network devices: Loongson GMAC and
>>>>>> Loongson GNET in the framework of four CPU/Chipsets revisions:
>>>>>>
>>>>>>       Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
>>>>>> LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
>>>>>> LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
>>>>>> LS2K2000 CPU         GNET      0x7a13          v3.73a            8
>>>>>> LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
>>>>> You mentioned in the cover-letter
>>>>> https://lore.kernel.org/netdev/cover.1716973237.git.siyanteng@loongson.cn/
>>>>> that LS2K now have GMAC NICs too:
>>>>> " 1. The current LS2K2000 also have a GMAC(and two GNET) that supports 8
>>>>>        channels, so we have to reconsider the initialization of
>>>>>        tx/rx_queues_to_use into probe();"
>>>>>
>>>>> But I don't see much changes in the series which would indicate that
>>>>> new data. Please clarify what does it mean:
>>>>>
>>>>> Does it mean LS2K2000 has two types of the DW GMACs, right?
>>>> Yes!
>>>>> Are both of them based on the DW GMAC v3.73a IP-core with AV-feature
>>>>> enabled and 8 DMA-channels?
>>>> Yes!
>>>>> Seeing you called the new device as GMAC it doesn't have an
>>>>> integrated PHY as GNETs do, does it? If so, then neither
>>>>> STMMAC_FLAG_DISABLE_FORCE_1000 nor loongson_gnet_fix_speed() relevant
>>>>> for the new device, right?
>>>> YES!
>>>>> Why haven't you changed the sheet in the commit log? Shall the sheet
>>>>> be updated like this:
>>>>>
>>>>>        Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
>>>>>     LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
>>>>>     LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
>>>>> +LS2K2000 CPU         GMAC      0x7a13          v3.73a            8
>>>>>     LS2K2000 CPU         GNET      0x7a13          v3.73a            8
>>>>>     LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
>>>>>
>>>>> ?
>>>> No! PCI Dev ID of GMAC is 0x7a03. So:
>>>>
>>>>    LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a 1
>>>>    LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a 1
>>>> +LS2K2000 CPU         GMAC      0x7a03          v3.73a 8
>>>>    LS2K2000 CPU         GNET      0x7a13          v3.73a 8
>>>>    LS7A2000 Chipset     GNET      0x7a13          v3.73a 1
>>>>
>>>>> I'll continue reviewing the series after the questions above are
>>>>> clarified.
>>>> OK, If anything else is unclear, please let me know.
>>> Got it. Thanks for clarifying. I'll get back to reviewing the series
>>> tomorrow. Sorry for the timebreak.
>> OK. No worries.
> Seeing Loongson GMAC can be also found with the 8-channels AV feature
> enabled, we'll need to reconsider the patches logic and thus the
> commit logs too. I'll try to thoroughly describe the changes in the
> respective parts of the series. But in general, if what I've come up
> with is implemented, the patchset will turn to look as follows:
>
> [PATCH net-next v14 01/15] net: stmmac: Move the atds flag to the stmmac_dma_cfg structure
> [PATCH net-next v14 02/15] net: stmmac: Add multi-channel support
> [PATCH net-next v14 03/15] net: stmmac: Export dwmac1000_dma_ops
> [PATCH net-next v14 04/15] net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size init
> [PATCH net-next v14 05/15] net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi calls
> [PATCH net-next v14 06/15] net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device identification
>
> [PATCH net-next v14 07/15] net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
> +-> Init the plat_stmmacenet_data::{tx_queues_to_use,rx_queues_to_use}
>      in the loongson_gmac_data() method.
>
> [PATCH net-next v14 08/15] net: stmmac: dwmac-loongson: Init ref and PTP clocks rate
> [PATCH net-next v14 09/15] net: stmmac: dwmac-loongson: Add phy_interface for Loongson GMAC
>
> [PATCH net-next v14 10/15] net: stmmac: dwmac-loongson: Introduce PCI device info data
> +-> Make sure the setup() method is called after the pci_enable_device()
>      invocation.
>
> [PATCH net-next v14 11/15] net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
> +-> Introduce the loongson_dwmac_dt_config() method here instead of
>      doing that in a separate patch.
> +-> Add loongson_dwmac_acpi_config() which would just get the IRQ from
>      the pdev->irq field and make sure it is valid.
>
> [PATCH net-next v14 12/15] net: stmmac: Fixed failure to set network speed to 1000.
> +-> ... not sure what to do with this ...
>
> [PATCH net-next v14 13/15] net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support
> +-> This is former "net: stmmac: dwmac-loongson: Add Loongson GNET
>      support" patch, but which adds the support of the Loongson GMAC with the
>      8-channels AV-feature available.
> +-> loongson_dwmac_intx_config() shall be dropped due to the
>      loongson_dwmac_acpi_config() method added in the PATCH 11/15.
> +-> Make sure loongson_data::loongson_id is initialized before the
>      stmmac_pci_info::setup() is called.
> +-> Move the rx_queues_to_use/tx_queues_to_use and coe_unsupported
>      fields initialization to the loongson_gmac_data() method.
> +-> As before, call the loongson_dwmac_msi_config() method if the multi-channels
>      Loongson MAC has been detected.
> +-> Move everything GNET-specific to the next patch.
>
> [PATCH net-next v14 14/15] net: stmmac: dwmac-loongson: Add Loongson GNET support
> +-> Everything Loonsgson GNET-specific is supposed to be added in the
>      framework of this patch:
>      + PCI_DEVICE_ID_LOONGSON_GNET macro
>      + loongson_gnet_fix_speed() method
>      + loongson_gnet_data() method
>      + loongson_gnet_pci_info data
>      + The GNET-specific part of the loongson_dwmac_setup() method.
>      + ...
>
> [PATCH net-next v14 15/15] net: stmmac: dwmac-loongson: Add loongson module author
>
> Hopefully I didn't forget anything. I'll give more details in the
> comments to the respective patches.

OK.  Thanks!


Thanks,

Yanteng

> -Serge(y)
>


