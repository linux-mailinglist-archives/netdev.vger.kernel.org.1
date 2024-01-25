Return-Path: <netdev+bounces-65772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFE683BA62
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 07:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C911C22BA2
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 06:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D208C150;
	Thu, 25 Jan 2024 06:58:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D710A24
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165886; cv=none; b=AeqrPJZDWuOA23O2BNPncSl7KCFvB4PYhpHz2C+Cr+A6nvYcpCE3sEcWRABfLU5mY3oHw6nP0TnbjSkD3vkE14JiYZhYwzwjfA2D1xiywn4Uth8k4pH8GyPYgaJ/J44Ef/UX5sAznuCoO1CiqUNS4uxcdERIZ4yfals4yFLSXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165886; c=relaxed/simple;
	bh=ENBHu+paMmpNyKPbnlrKJbSJ0wY78/pHtvoMmib/YQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ih61/GnU1RWfMDsHo1qgsBzBJMF5pDN1F89H/s4YSmGxXlbtcj/cq3D5OvvD+6U5Uo9FyB0+dNoJRTkeqQNxiyehbM25XoNH3CrjT2SYXx0aRC+TI17Ky6ew2jTbwLuBZEQd02hVNAowhRhu4GPZDubrXwgLDIr5PltWAAAGGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.155])
	by gateway (Coremail) with SMTP id _____8Cxbet4BrJlH2kFAA--.20562S3;
	Thu, 25 Jan 2024 14:58:00 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.155])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTs10BrJlZ80YAA--.40799S3;
	Thu, 25 Jan 2024 14:57:57 +0800 (CST)
Message-ID: <b1fa4b0f-dd64-413f-835d-5a7a1aa8ddfb@loongson.cn>
Date: Thu, 25 Jan 2024 14:57:56 +0800
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
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <caf9e822c2f628f09e02760cfa81a1bd4af0b8d6.1702990507.git.siyanteng@loongson.cn>
 <pbju43fy4upk32xcgrerkafnwjvs55p5x4kdaavhia4z7wjoqm@mk55pgs7eczz>
 <ac7cc7fc-60fa-4624-b546-bb31cd5136cb@loongson.cn>
 <y6pomse5ekphiysbfoabd35bxi6zs3hmoezfbjiv5nh7ogpxg5@23fnkt2vbkgb>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <y6pomse5ekphiysbfoabd35bxi6zs3hmoezfbjiv5nh7ogpxg5@23fnkt2vbkgb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTs10BrJlZ80YAA--.40799S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3GF4xtFWrXw1DGr4rtry8Xrc_yoWxKFyUp3
	y8Aa4DCrWUJr1xJw1vqw4DAF9Iyry3tw18Wr47J3WUKFyqyr9IqFyjqFWj9rn7Cr4kuF17
	Xr4jkr4a9Fn8CrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2024/1/2 09:22, Serge Semin 写道:
> On Mon, Jan 01, 2024 at 03:27:07PM +0800, Yanteng Si wrote:
>> 在 2023/12/21 10:34, Serge Semin 写道:
>>> On Tue, Dec 19, 2023 at 10:26:47PM +0800, Yanteng Si wrote:
>>>> Add Loongson GNET (GMAC with PHY) support. Current GNET does not support
>>>> half duplex mode, and GNET on LS7A only supports ANE when speed is set to
>>>> 1000M.
>>>>
>>>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>>>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>>>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>>>> ---
>>>>    .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 79 +++++++++++++++++++
>>>>    .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 ++
>>>>    include/linux/stmmac.h                        |  2 +
>>>>    3 files changed, 87 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>> index 2c08d5495214..9e4953c7e4e0 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>>> @@ -168,6 +168,83 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>>>>    	.config = loongson_gmac_config,
>>>>    };
>>>> +static void loongson_gnet_fix_speed(void *priv, unsigned int speed, unsigned int mode)
>>>> +{
>>>> +	struct net_device *ndev = dev_get_drvdata(priv);
>>>> +	struct stmmac_priv *ptr = netdev_priv(ndev);
>>>> +
>>>> +	/* The controller and PHY don't work well together.
>>>> +	 * We need to use the PS bit to check if the controller's status
>>>> +	 * is correct and reset PHY if necessary.
>>>> +	 */
>>>> +	if (speed == SPEED_1000)
>>>> +		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
>>>> +			phy_restart_aneg(ndev->phydev);
>>> {} around the outer if please.
>> OK.
>>>> +}
>>>> +
>>>> +static int loongson_gnet_data(struct pci_dev *pdev,
>>>> +			      struct plat_stmmacenet_data *plat)
>>>> +{
>>>> +	loongson_default_data(pdev, plat);
>>>> +
>>>> +	plat->multicast_filter_bins = 256;
>>>> +
>>>> +	plat->mdio_bus_data->phy_mask = 0xfffffffb;
>>> ~BIT(2)?
>> I still need to confirm, please allow me to get back to you later.
>>>> +
>>>> +	plat->phy_addr = 2;
>>>> +	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
>>>> +
>>>> +	plat->bsp_priv = &pdev->dev;
>>>> +	plat->fix_mac_speed = loongson_gnet_fix_speed;
>>>> +
>>>> +	plat->dma_cfg->pbl = 32;
>>>> +	plat->dma_cfg->pblx8 = true;
>>>> +
>>>> +	plat->clk_ref_rate = 125000000;
>>>> +	plat->clk_ptp_rate = 125000000;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int loongson_gnet_config(struct pci_dev *pdev,
>>>> +				struct plat_stmmacenet_data *plat,
>>>> +				struct stmmac_resources *res,
>>>> +				struct device_node *np)
>>>> +{
>>>> +	int ret;
>>>> +	u32 version = readl(res->addr + GMAC_VERSION);
>>>> +
>>>> +	switch (version & 0xff) {
>>>> +	case DWLGMAC_CORE_1_00:
>>>> +		ret = loongson_dwmac_config_multi_msi(pdev, plat, res, np, 8);
>>>> +		break;
>>>> +	default:
>>>> +		ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
>>> Hm, do you have two versions of Loongson GNET? What does the second
>> Yes.
>>> one contain in the GMAC_VERSION register then? Can't you distinguish
>>> them by the PCI IDs (device, subsystem, revision)?
>> I'm afraid that's not possible.
>>
>> Because they have the same pci id and revision.
> Please provide more details about what platform/devices support you
> are adding and what PCI IDs and DW GMAC IP-core version they have.
Okay, I will do my best to make them appear in the next version of the 
commit message.
>
>>
>> Thanks,
>>
>> Yanteng
>>
>>> -Serge(y)
>>>
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	switch (pdev->revision) {
>>>> +	case 0x00:
>>>> +		plat->flags |=
>>>> +			FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1) |
>>>> +			FIELD_PREP(STMMAC_FLAG_DISABLE_FORCE_1000, 1);
>>>> +		break;
>>>> +	case 0x01:
>>>> +		plat->flags |=
>>>> +			FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1);
>>>> +		break;
>>>> +	default:
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static struct stmmac_pci_info loongson_gnet_pci_info = {
>>>> +	.setup = loongson_gnet_data,
>>>> +	.config = loongson_gnet_config,
>>>> +};
>>>> +
>>>>    static int loongson_dwmac_probe(struct pci_dev *pdev,
>>>>    				const struct pci_device_id *id)
>>>>    {
>>>> @@ -318,9 +395,11 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>>>>    			 loongson_dwmac_resume);
>>>>    #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>>>> +#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
>>>>    static const struct pci_device_id loongson_dwmac_id_table[] = {
>>>>    	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>>>> +	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
>>>>    	{}
>>>>    };
>>>>    MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>>>> index 8105ce47c6ad..d6939eb9a0d8 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>>>> @@ -420,6 +420,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
>>>>    		return 0;
>>>>    	}
>>>> +	if (FIELD_GET(STMMAC_FLAG_DISABLE_FORCE_1000, priv->plat->flags)) {
>>>> +		if (cmd->base.speed == SPEED_1000 &&
>>>> +		    cmd->base.autoneg != AUTONEG_ENABLE)
>>>> +			return -EOPNOTSUPP;
>>>> +	}
>>>> +
>>>>    	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
>>>>    }
>>>> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
>>>> index f07f79d50b06..067030cdb60f 100644
>>>> --- a/include/linux/stmmac.h
>>>> +++ b/include/linux/stmmac.h
>>>> @@ -222,6 +222,8 @@ struct dwmac4_addrs {
>>>>    #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
>>>>    #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
>>>>    #define STMMAC_FLAG_HAS_LGMAC			BIT(13)
>>>> +#define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
> Just noticed. I do not see this flag affecting any part of the code.
> Drop it if no actual action is implied by it.

Sorry, I lost it, it will be added in the next version, otherwise there 
will be an

error on the 7a13 0x37 device.


@@ -1201,7 +1201,8 @@ static int stmmac_init_phy(struct net_device *dev)
  static void stmmac_set_half_duplex(struct stmmac_priv *priv)
  {
         /* Half-Duplex can only work with single tx queue */
-       if (priv->plat->tx_queues_to_use > 1)
+       if (priv->plat->tx_queues_to_use > 1 ||
+               (STMMAC_FLAG_DISABLE_HALF_DUPLEX & priv->plat->flags))
                 priv->phylink_config.mac_capabilities &=
                         ~(MAC_10HD | MAC_100HD | MAC_1000HD);

         else




Thanks,

Yanteng

>
> -Serge(y)
>
>>>> +#define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(15)
>>>>    struct plat_stmmacenet_data {
>>>>    	int bus_id;
>>>> -- 
>>>> 2.31.4
>>>>


