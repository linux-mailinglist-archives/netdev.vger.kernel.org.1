Return-Path: <netdev+bounces-59418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D0E81ACA8
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5641F241EE
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 02:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D79D19D;
	Thu, 21 Dec 2023 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDP5HKyR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF38BED
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e23a4df33so425116e87.2
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 18:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703126047; x=1703730847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=53JhHH2dwPvdH3Iluo2Dzh27wvgV06NmTEZZFQKP9RI=;
        b=fDP5HKyRayZ8weqZNU2oYozXYXq1ompA+t2MwKJ1B5GDsvyK950H3po0Qc5r4hu6CX
         RpOhzSEr5qRzfNPEMOz759WE91TpR9Yu1t7y5a1VzrwpdRtL8pNvZJ++eFmT4aR0eLCO
         W0A5HNb03WG+8QqX7r0KzFEhCX9yqnnnsZNe8Lp8k1hIFzCVMl8OcZArnlosbUqxHVsM
         71mtuoOL1T+JBrlf1pXdeW2yKzm53tM2iznZLjQtMeX840rql1rsd8rmoXU0tfEazcBy
         /tCDLMSTDfxUoSegmJlMRwR/vMcvPYglglsmwA1g2usWtF3+HCQrY+nQ4ir5lJeIId7h
         p6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703126047; x=1703730847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53JhHH2dwPvdH3Iluo2Dzh27wvgV06NmTEZZFQKP9RI=;
        b=mwNLaRtcR3Og7KOwMo4pVbgoh5rz+xy0S/uicZrshJwEJaRNZXL9L6q9humYPP/7/r
         MzoRt7RIT3RjZjQlXAYnq4kP7p2yT6ULCGfHLBuvh91XC2XpfjXIoquPh5Xlto71SVA6
         kpPl6zBIVPK2EN2jctITdzxW3GY+urdF5BHfmP4LrldJYIST8NifSekP24c4wLKE9gsP
         tzuJgl80dAUX+J6PhxL/RhR8/hrY7ScYaX8GMxQ/U13dDyza6SR8DJjhFduzNl2A1XF7
         x7Y80QGpzhDyagAD+eAe/xXQw5NnKOqzkCZRgS+K8djrK3pTT9Miw6fqYfAGYZnHvbVF
         yjog==
X-Gm-Message-State: AOJu0YwM7lbyiMHhZr54LUsRgYbWjt9MrUx492aPc4tSrM4Yrkei7hXY
	gMzsUvkBJyy/jGNn+MqTCt0=
X-Google-Smtp-Source: AGHT+IETNuNEMM5lqI9Za/svdvZsoLFU5rD+ObEeyxw1yigqMb/A0LJKvXKvd9NzxJbGJW5BOVruCQ==
X-Received: by 2002:a05:6512:3ba2:b0:50e:335f:6f50 with SMTP id g34-20020a0565123ba200b0050e335f6f50mr4512402lfv.124.1703126047261;
        Wed, 20 Dec 2023 18:34:07 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id k18-20020ac24572000000b0050e36a32b15sm130379lfm.239.2023.12.20.18.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 18:34:06 -0800 (PST)
Date: Thu, 21 Dec 2023 05:34:04 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v7 7/9] net: stmmac: dwmac-loongson: Add GNET
 support
Message-ID: <pbju43fy4upk32xcgrerkafnwjvs55p5x4kdaavhia4z7wjoqm@mk55pgs7eczz>
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <caf9e822c2f628f09e02760cfa81a1bd4af0b8d6.1702990507.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caf9e822c2f628f09e02760cfa81a1bd4af0b8d6.1702990507.git.siyanteng@loongson.cn>

On Tue, Dec 19, 2023 at 10:26:47PM +0800, Yanteng Si wrote:
> Add Loongson GNET (GMAC with PHY) support. Current GNET does not support
> half duplex mode, and GNET on LS7A only supports ANE when speed is set to
> 1000M.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 79 +++++++++++++++++++
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 ++
>  include/linux/stmmac.h                        |  2 +
>  3 files changed, 87 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 2c08d5495214..9e4953c7e4e0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -168,6 +168,83 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>  	.config = loongson_gmac_config,
>  };
>  
> +static void loongson_gnet_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> +{
> +	struct net_device *ndev = dev_get_drvdata(priv);
> +	struct stmmac_priv *ptr = netdev_priv(ndev);
> +
> +	/* The controller and PHY don't work well together.
> +	 * We need to use the PS bit to check if the controller's status
> +	 * is correct and reset PHY if necessary.
> +	 */

> +	if (speed == SPEED_1000)
> +		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
> +			phy_restart_aneg(ndev->phydev);

{} around the outer if please.

> +}
> +
> +static int loongson_gnet_data(struct pci_dev *pdev,
> +			      struct plat_stmmacenet_data *plat)
> +{
> +	loongson_default_data(pdev, plat);
> +
> +	plat->multicast_filter_bins = 256;
> +

> +	plat->mdio_bus_data->phy_mask = 0xfffffffb;

~BIT(2)?

> +
> +	plat->phy_addr = 2;
> +	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
> +
> +	plat->bsp_priv = &pdev->dev;
> +	plat->fix_mac_speed = loongson_gnet_fix_speed;
> +
> +	plat->dma_cfg->pbl = 32;
> +	plat->dma_cfg->pblx8 = true;
> +
> +	plat->clk_ref_rate = 125000000;
> +	plat->clk_ptp_rate = 125000000;
> +
> +	return 0;
> +}
> +
> +static int loongson_gnet_config(struct pci_dev *pdev,
> +				struct plat_stmmacenet_data *plat,
> +				struct stmmac_resources *res,
> +				struct device_node *np)
> +{
> +	int ret;
> +	u32 version = readl(res->addr + GMAC_VERSION);
> +
> +	switch (version & 0xff) {

> +	case DWLGMAC_CORE_1_00:
> +		ret = loongson_dwmac_config_multi_msi(pdev, plat, res, np, 8);
> +		break;
> +	default:
> +		ret = loongson_dwmac_config_legacy(pdev, plat, res, np);

Hm, do you have two versions of Loongson GNET? What does the second
one contain in the GMAC_VERSION register then? Can't you distinguish
them by the PCI IDs (device, subsystem, revision)?

-Serge(y)

> +		break;
> +	}
> +
> +	switch (pdev->revision) {
> +	case 0x00:
> +		plat->flags |=
> +			FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1) |
> +			FIELD_PREP(STMMAC_FLAG_DISABLE_FORCE_1000, 1);
> +		break;
> +	case 0x01:
> +		plat->flags |=
> +			FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct stmmac_pci_info loongson_gnet_pci_info = {
> +	.setup = loongson_gnet_data,
> +	.config = loongson_gnet_config,
> +};
> +
>  static int loongson_dwmac_probe(struct pci_dev *pdev,
>  				const struct pci_device_id *id)
>  {
> @@ -318,9 +395,11 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>  			 loongson_dwmac_resume);
>  
>  #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
> +#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
>  
>  static const struct pci_device_id loongson_dwmac_id_table[] = {
>  	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> +	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 8105ce47c6ad..d6939eb9a0d8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -420,6 +420,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
>  		return 0;
>  	}
>  
> +	if (FIELD_GET(STMMAC_FLAG_DISABLE_FORCE_1000, priv->plat->flags)) {
> +		if (cmd->base.speed == SPEED_1000 &&
> +		    cmd->base.autoneg != AUTONEG_ENABLE)
> +			return -EOPNOTSUPP;
> +	}
> +
>  	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
>  }
>  
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index f07f79d50b06..067030cdb60f 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -222,6 +222,8 @@ struct dwmac4_addrs {
>  #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
>  #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
>  #define STMMAC_FLAG_HAS_LGMAC			BIT(13)
> +#define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
> +#define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(15)
>  
>  struct plat_stmmacenet_data {
>  	int bus_id;
> -- 
> 2.31.4
> 

