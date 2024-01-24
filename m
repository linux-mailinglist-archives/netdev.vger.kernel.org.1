Return-Path: <netdev+bounces-65391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E79583A53C
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B383B2912AC
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DB218026;
	Wed, 24 Jan 2024 09:21:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC4517C91
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088077; cv=none; b=M7MlHj1NiJuloPi42KEFQz9qqQeH8+2AJV1tnNrwRCJikQlMqr5hd5B2O7lo13APu77eF7OJO3iwAvEDQhBo+Tz4HamCytb/xZGoXKwOdTAmW+qXdy3GUgBNOeAHQeQ7ruuUZb93XEO3WlmQ/xhDMk1KAYidYjl4Ik7MedDHEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088077; c=relaxed/simple;
	bh=Q2qONIKK09ZfZukddLM8W0gfwZQOBsz5dYTUKLyZ1Qg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tppcfQF27RcE+oT5NKu/0fWxwHaX1pif6SbhgaA1PWFK7bOQeo0hNavnlJYjRss5OvKgb18UCmoxzm6o3QFJNqd3BD+S212FBzbbgZf4uSaCh/iT3BtUjF962L0iN7qYv61f00WEDjPQA8vBq3mRYvJjnfjdyz0FfelbCRJZ8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.155])
	by gateway (Coremail) with SMTP id _____8BxTOmC1rBl_aoEAA--.8539S3;
	Wed, 24 Jan 2024 17:21:06 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.155])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHs9_1rBlv5AWAA--.33924S3;
	Wed, 24 Jan 2024 17:21:04 +0800 (CST)
Message-ID: <ce51f055-7564-4921-b45a-c4a255a9d797@loongson.cn>
Date: Wed, 24 Jan 2024 17:21:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 7/9] net: stmmac: dwmac-loongson: Add GNET
 support
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <caf9e822c2f628f09e02760cfa81a1bd4af0b8d6.1702990507.git.siyanteng@loongson.cn>
 <pbju43fy4upk32xcgrerkafnwjvs55p5x4kdaavhia4z7wjoqm@mk55pgs7eczz>
 <ac7cc7fc-60fa-4624-b546-bb31cd5136cb@loongson.cn>
In-Reply-To: <ac7cc7fc-60fa-4624-b546-bb31cd5136cb@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxHs9_1rBlv5AWAA--.33924S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3GF4fCw4kCry8Ww1DZw4rCrX_yoWxtry3pr
	1kAFWUGry5Jrn5Gw1DKa1UJFy5Ary5Jw1DWr4xXF1UJrs2yryagryjgr4q9r17Ar4kXr17
	Jr1UursxuFnxGrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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


在 2024/1/1 15:27, Yanteng Si 写道:
>
> 在 2023/12/21 10:34, Serge Semin 写道:
>> On Tue, Dec 19, 2023 at 10:26:47PM +0800, Yanteng Si wrote:
>>> Add Loongson GNET (GMAC with PHY) support. Current GNET does not 
>>> support
>>> half duplex mode, and GNET on LS7A only supports ANE when speed is 
>>> set to
>>> 1000M.
>>>
>>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>>> ---
>>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 79 
>>> +++++++++++++++++++
>>>   .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 ++
>>>   include/linux/stmmac.h                        |  2 +
>>>   3 files changed, 87 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c 
>>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>> index 2c08d5495214..9e4953c7e4e0 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>> @@ -168,6 +168,83 @@ static struct stmmac_pci_info 
>>> loongson_gmac_pci_info = {
>>>       .config = loongson_gmac_config,
>>>   };
>>>   +static void loongson_gnet_fix_speed(void *priv, unsigned int 
>>> speed, unsigned int mode)
>>> +{
>>> +    struct net_device *ndev = dev_get_drvdata(priv);
>>> +    struct stmmac_priv *ptr = netdev_priv(ndev);
>>> +
>>> +    /* The controller and PHY don't work well together.
>>> +     * We need to use the PS bit to check if the controller's status
>>> +     * is correct and reset PHY if necessary.
>>> +     */
>>> +    if (speed == SPEED_1000)
>>> +        if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
>>> +            phy_restart_aneg(ndev->phydev);
>> {} around the outer if please.
> OK.
>>
>>> +}
>>> +
>>> +static int loongson_gnet_data(struct pci_dev *pdev,
>>> +                  struct plat_stmmacenet_data *plat)
>>> +{
>>> +    loongson_default_data(pdev, plat);
>>> +
>>> +    plat->multicast_filter_bins = 256;
>>> +
>>> +    plat->mdio_bus_data->phy_mask = 0xfffffffb;
>> ~BIT(2)?
> I still need to confirm, please allow me to get back to you later.

Yes, that's fine.


Thanks,

Yanteng


>>
>>> +
>>> +    plat->phy_addr = 2;
>>> +    plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
>>> +
>>> +    plat->bsp_priv = &pdev->dev;
>>> +    plat->fix_mac_speed = loongson_gnet_fix_speed;
>>> +
>>> +    plat->dma_cfg->pbl = 32;
>>> +    plat->dma_cfg->pblx8 = true;
>>> +
>>> +    plat->clk_ref_rate = 125000000;
>>> +    plat->clk_ptp_rate = 125000000;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int loongson_gnet_config(struct pci_dev *pdev,
>>> +                struct plat_stmmacenet_data *plat,
>>> +                struct stmmac_resources *res,
>>> +                struct device_node *np)
>>> +{
>>> +    int ret;
>>> +    u32 version = readl(res->addr + GMAC_VERSION);
>>> +
>>> +    switch (version & 0xff) {
>>> +    case DWLGMAC_CORE_1_00:
>>> +        ret = loongson_dwmac_config_multi_msi(pdev, plat, res, np, 8);
>>> +        break;
>>> +    default:
>>> +        ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
>> Hm, do you have two versions of Loongson GNET? What does the second
> Yes.
>> one contain in the GMAC_VERSION register then? Can't you distinguish
>> them by the PCI IDs (device, subsystem, revision)?
>
> I'm afraid that's not possible.
>
> Because they have the same pci id and revision.
>
>
> Thanks,
>
> Yanteng
>
>>
>> -Serge(y)
>>
>>> +        break;
>>> +    }
>>> +
>>> +    switch (pdev->revision) {
>>> +    case 0x00:
>>> +        plat->flags |=
>>> +            FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1) |
>>> +            FIELD_PREP(STMMAC_FLAG_DISABLE_FORCE_1000, 1);
>>> +        break;
>>> +    case 0x01:
>>> +        plat->flags |=
>>> +            FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1);
>>> +        break;
>>> +    default:
>>> +        break;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static struct stmmac_pci_info loongson_gnet_pci_info = {
>>> +    .setup = loongson_gnet_data,
>>> +    .config = loongson_gnet_config,
>>> +};
>>> +
>>>   static int loongson_dwmac_probe(struct pci_dev *pdev,
>>>                   const struct pci_device_id *id)
>>>   {
>>> @@ -318,9 +395,11 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, 
>>> loongson_dwmac_suspend,
>>>                loongson_dwmac_resume);
>>>     #define PCI_DEVICE_ID_LOONGSON_GMAC    0x7a03
>>> +#define PCI_DEVICE_ID_LOONGSON_GNET    0x7a13
>>>     static const struct pci_device_id loongson_dwmac_id_table[] = {
>>>       { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>>> +    { PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
>>>       {}
>>>   };
>>>   MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c 
>>> b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>>> index 8105ce47c6ad..d6939eb9a0d8 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>>> @@ -420,6 +420,12 @@ stmmac_ethtool_set_link_ksettings(struct 
>>> net_device *dev,
>>>           return 0;
>>>       }
>>>   +    if (FIELD_GET(STMMAC_FLAG_DISABLE_FORCE_1000, 
>>> priv->plat->flags)) {
>>> +        if (cmd->base.speed == SPEED_1000 &&
>>> +            cmd->base.autoneg != AUTONEG_ENABLE)
>>> +            return -EOPNOTSUPP;
>>> +    }
>>> +
>>>       return phylink_ethtool_ksettings_set(priv->phylink, cmd);
>>>   }
>>>   diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
>>> index f07f79d50b06..067030cdb60f 100644
>>> --- a/include/linux/stmmac.h
>>> +++ b/include/linux/stmmac.h
>>> @@ -222,6 +222,8 @@ struct dwmac4_addrs {
>>>   #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING    BIT(11)
>>>   #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY    BIT(12)
>>>   #define STMMAC_FLAG_HAS_LGMAC            BIT(13)
>>> +#define STMMAC_FLAG_DISABLE_HALF_DUPLEX    BIT(14)
>>> +#define STMMAC_FLAG_DISABLE_FORCE_1000    BIT(15)
>>>     struct plat_stmmacenet_data {
>>>       int bus_id;
>>> -- 
>>> 2.31.4
>>>


