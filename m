Return-Path: <netdev+bounces-60686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDF382132F
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 08:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370CF2828EF
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 07:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB661368;
	Mon,  1 Jan 2024 07:27:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1A217C6
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.252])
	by gateway (Coremail) with SMTP id _____8Cx7+tNaZJlguYAAA--.3812S3;
	Mon, 01 Jan 2024 15:27:09 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.252])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxD+VLaZJlnfoTAA--.62183S3;
	Mon, 01 Jan 2024 15:27:08 +0800 (CST)
Message-ID: <ac7cc7fc-60fa-4624-b546-bb31cd5136cb@loongson.cn>
Date: Mon, 1 Jan 2024 15:27:07 +0800
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
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <pbju43fy4upk32xcgrerkafnwjvs55p5x4kdaavhia4z7wjoqm@mk55pgs7eczz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxD+VLaZJlnfoTAA--.62183S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3GF4fur1kAFW5uw4ftw13Awc_yoW7ZF45pa
	y7AasF9FWjqF1xGwsYq398ZFyYyrZxtrZ7ur47tw17KFZFyr9YqFyUKFWakr97Cr4Dur1a
	qr4UursruFs8CrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0b6pPUUUUU==


在 2023/12/21 10:34, Serge Semin 写道:
> On Tue, Dec 19, 2023 at 10:26:47PM +0800, Yanteng Si wrote:
>> Add Loongson GNET (GMAC with PHY) support. Current GNET does not support
>> half duplex mode, and GNET on LS7A only supports ANE when speed is set to
>> 1000M.
>>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> ---
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 79 +++++++++++++++++++
>>   .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 ++
>>   include/linux/stmmac.h                        |  2 +
>>   3 files changed, 87 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index 2c08d5495214..9e4953c7e4e0 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -168,6 +168,83 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>>   	.config = loongson_gmac_config,
>>   };
>>   
>> +static void loongson_gnet_fix_speed(void *priv, unsigned int speed, unsigned int mode)
>> +{
>> +	struct net_device *ndev = dev_get_drvdata(priv);
>> +	struct stmmac_priv *ptr = netdev_priv(ndev);
>> +
>> +	/* The controller and PHY don't work well together.
>> +	 * We need to use the PS bit to check if the controller's status
>> +	 * is correct and reset PHY if necessary.
>> +	 */
>> +	if (speed == SPEED_1000)
>> +		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
>> +			phy_restart_aneg(ndev->phydev);
> {} around the outer if please.
OK.
>
>> +}
>> +
>> +static int loongson_gnet_data(struct pci_dev *pdev,
>> +			      struct plat_stmmacenet_data *plat)
>> +{
>> +	loongson_default_data(pdev, plat);
>> +
>> +	plat->multicast_filter_bins = 256;
>> +
>> +	plat->mdio_bus_data->phy_mask = 0xfffffffb;
> ~BIT(2)?
I still need to confirm, please allow me to get back to you later.
>
>> +
>> +	plat->phy_addr = 2;
>> +	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
>> +
>> +	plat->bsp_priv = &pdev->dev;
>> +	plat->fix_mac_speed = loongson_gnet_fix_speed;
>> +
>> +	plat->dma_cfg->pbl = 32;
>> +	plat->dma_cfg->pblx8 = true;
>> +
>> +	plat->clk_ref_rate = 125000000;
>> +	plat->clk_ptp_rate = 125000000;
>> +
>> +	return 0;
>> +}
>> +
>> +static int loongson_gnet_config(struct pci_dev *pdev,
>> +				struct plat_stmmacenet_data *plat,
>> +				struct stmmac_resources *res,
>> +				struct device_node *np)
>> +{
>> +	int ret;
>> +	u32 version = readl(res->addr + GMAC_VERSION);
>> +
>> +	switch (version & 0xff) {
>> +	case DWLGMAC_CORE_1_00:
>> +		ret = loongson_dwmac_config_multi_msi(pdev, plat, res, np, 8);
>> +		break;
>> +	default:
>> +		ret = loongson_dwmac_config_legacy(pdev, plat, res, np);
> Hm, do you have two versions of Loongson GNET? What does the second
Yes.
> one contain in the GMAC_VERSION register then? Can't you distinguish
> them by the PCI IDs (device, subsystem, revision)?

I'm afraid that's not possible.

Because they have the same pci id and revision.


Thanks,

Yanteng

>
> -Serge(y)
>
>> +		break;
>> +	}
>> +
>> +	switch (pdev->revision) {
>> +	case 0x00:
>> +		plat->flags |=
>> +			FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1) |
>> +			FIELD_PREP(STMMAC_FLAG_DISABLE_FORCE_1000, 1);
>> +		break;
>> +	case 0x01:
>> +		plat->flags |=
>> +			FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static struct stmmac_pci_info loongson_gnet_pci_info = {
>> +	.setup = loongson_gnet_data,
>> +	.config = loongson_gnet_config,
>> +};
>> +
>>   static int loongson_dwmac_probe(struct pci_dev *pdev,
>>   				const struct pci_device_id *id)
>>   {
>> @@ -318,9 +395,11 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>>   			 loongson_dwmac_resume);
>>   
>>   #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>> +#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
>>   
>>   static const struct pci_device_id loongson_dwmac_id_table[] = {
>>   	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>> +	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> index 8105ce47c6ad..d6939eb9a0d8 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> @@ -420,6 +420,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
>>   		return 0;
>>   	}
>>   
>> +	if (FIELD_GET(STMMAC_FLAG_DISABLE_FORCE_1000, priv->plat->flags)) {
>> +		if (cmd->base.speed == SPEED_1000 &&
>> +		    cmd->base.autoneg != AUTONEG_ENABLE)
>> +			return -EOPNOTSUPP;
>> +	}
>> +
>>   	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
>>   }
>>   
>> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
>> index f07f79d50b06..067030cdb60f 100644
>> --- a/include/linux/stmmac.h
>> +++ b/include/linux/stmmac.h
>> @@ -222,6 +222,8 @@ struct dwmac4_addrs {
>>   #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
>>   #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
>>   #define STMMAC_FLAG_HAS_LGMAC			BIT(13)
>> +#define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
>> +#define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(15)
>>   
>>   struct plat_stmmacenet_data {
>>   	int bus_id;
>> -- 
>> 2.31.4
>>


