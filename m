Return-Path: <netdev+bounces-60765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D598E821620
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 02:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525B81F2127A
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 01:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97863384;
	Tue,  2 Jan 2024 01:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTaV9EUY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A5620F8
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cc7d2c1ff0so95192131fa.3
        for <netdev@vger.kernel.org>; Mon, 01 Jan 2024 17:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704158535; x=1704763335; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WG7QBgQ+7JtmBHpWqUNHAv3ljnzfWa1IQRWQBC637Zs=;
        b=JTaV9EUY7YaiKtaVL9w6UP3DHAtvgljzorzskjmf12sV0zfepHy+KGciDvqWz12j5B
         D1qtT6qaqFHCcW6XD0tgCEZTofpz1BGZjLiK7XgCxisAx09TbFb7k6u0NPyiBl7XBk19
         BhRO822jV6vT9cRtB1q0QV43wYd/DvDtOn5/AEcLsax4EpFgvNEoQf7n8Xb3eYf4Egyt
         VkwhzvAY8aKwJAn1w28jvSDOPmXiYae8OttGhr1a5HSkcWt2LGmWHZYGYUw7x/FdO/Sk
         Il4ldZCIvbh/X+RjFzMO6yl0RqeOVPyk7KIS7VhzcboRxDT3vViQAsPkhrqmfBvmAgjb
         jP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704158535; x=1704763335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WG7QBgQ+7JtmBHpWqUNHAv3ljnzfWa1IQRWQBC637Zs=;
        b=gFfPLu7d7JGaFcuRtTlHf0uGwvQkuxmaVx83r1RcCIaTwYlhqesy/1jk7Hg4p1Y8yh
         eLaLDrspFNCHKqEAMthD6wSfedpWOckoZq3UoNxliWjks0WEOD5ERZxmECZOa+d3N2LU
         JDGOay60lmF3jS8vX0ZAGIwrGhI01Tt/pEnAZnm1Xmpf+DJOufIH6SQO4cXQy7bX/C2u
         GsGInuQg2IshfyQK2mVqBm6ARSx3v5EchN1WSvCcMUuueeOYOg005e5F/5KnQK6brgZk
         J5G+ZJmP8DErA54dyefl2j6x/z2hzRd6h39F5hxcSdaS5Xju1gEnKlPK3STnYrk5QQuC
         ZWng==
X-Gm-Message-State: AOJu0YzxBDzx3v5lmefdlKjHUDHpLTzTuxTl4fClFGlNuEhJqaxLUEyC
	PJiRLwXxXv/toBWz/JIyYt4=
X-Google-Smtp-Source: AGHT+IEzwt3OtrltuzFORfQyaupBsxmrMWvS7RKHykOpbj9rW+UaOPuinfjNry5Pem7j6jMJV8JIZQ==
X-Received: by 2002:a2e:381a:0:b0:2ca:30f5:7e02 with SMTP id f26-20020a2e381a000000b002ca30f57e02mr7619023lja.78.1704158534480;
        Mon, 01 Jan 2024 17:22:14 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id h2-20020a2ebc82000000b002cd03623ce5sm771663ljf.64.2024.01.01.17.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 17:22:14 -0800 (PST)
Date: Tue, 2 Jan 2024 04:22:12 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v7 7/9] net: stmmac: dwmac-loongson: Add GNET
 support
Message-ID: <y6pomse5ekphiysbfoabd35bxi6zs3hmoezfbjiv5nh7ogpxg5@23fnkt2vbkgb>
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <caf9e822c2f628f09e02760cfa81a1bd4af0b8d6.1702990507.git.siyanteng@loongson.cn>
 <pbju43fy4upk32xcgrerkafnwjvs55p5x4kdaavhia4z7wjoqm@mk55pgs7eczz>
 <ac7cc7fc-60fa-4624-b546-bb31cd5136cb@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac7cc7fc-60fa-4624-b546-bb31cd5136cb@loongson.cn>

On Mon, Jan 01, 2024 at 03:27:07PM +0800, Yanteng Si wrote:
> 
> 在 2023/12/21 10:34, Serge Semin 写道:
> > On Tue, Dec 19, 2023 at 10:26:47PM +0800, Yanteng Si wrote:
> > > Add Loongson GNET (GMAC with PHY) support. Current GNET does not support
> > > half duplex mode, and GNET on LS7A only supports ANE when speed is set to
> > > 1000M.
> > > 
> > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > ---
> > >   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 79 +++++++++++++++++++
> > >   .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 ++
> > >   include/linux/stmmac.h                        |  2 +
> > >   3 files changed, 87 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > index 2c08d5495214..9e4953c7e4e0 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > @@ -168,6 +168,83 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
> > >   	.config = loongson_gmac_config,
> > >   };
> > > +static void loongson_gnet_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> > > +{
> > > +	struct net_device *ndev = dev_get_drvdata(priv);
> > > +	struct stmmac_priv *ptr = netdev_priv(ndev);
> > > +
> > > +	/* The controller and PHY don't work well together.
> > > +	 * We need to use the PS bit to check if the controller's status
> > > +	 * is correct and reset PHY if necessary.
> > > +	 */
> > > +	if (speed == SPEED_1000)
> > > +		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
> > > +			phy_restart_aneg(ndev->phydev);
> > {} around the outer if please.
> OK.
> > 
> > > +}
> > > +
> > > +static int loongson_gnet_data(struct pci_dev *pdev,
> > > +			      struct plat_stmmacenet_data *plat)
> > > +{
> > > +	loongson_default_data(pdev, plat);
> > > +
> > > +	plat->multicast_filter_bins = 256;
> > > +
> > > +	plat->mdio_bus_data->phy_mask = 0xfffffffb;
> > ~BIT(2)?
> I still need to confirm, please allow me to get back to you later.
> > 
> > > +
> > > +	plat->phy_addr = 2;
> > > +	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
> > > +
> > > +	plat->bsp_priv = &pdev->dev;
> > > +	plat->fix_mac_speed = loongson_gnet_fix_speed;
> > > +
> > > +	plat->dma_cfg->pbl = 32;
> > > +	plat->dma_cfg->pblx8 = true;
> > > +
> > > +	plat->clk_ref_rate = 125000000;
> > > +	plat->clk_ptp_rate = 125000000;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int loongson_gnet_config(struct pci_dev *pdev,
> > > +				struct plat_stmmacenet_data *plat,
> > > +				struct stmmac_resources *res,
> > > +				struct device_node *np)
> > > +{
> > > +	int ret;
> > > +	u32 version = readl(res->addr + GMAC_VERSION);
> > > +
> > > +	switch (version & 0xff) {
> > > +	case DWLGMAC_CORE_1_00:
> > > +		ret = loongson_dwmac_config_multi_msi(pdev, plat, res, np, 8);
> > > +		break;
> > > +	default:
> > > +		ret = loongson_dwmac_config_legacy(pdev, plat, res, np);

> > Hm, do you have two versions of Loongson GNET? What does the second
> Yes.
> > one contain in the GMAC_VERSION register then? Can't you distinguish
> > them by the PCI IDs (device, subsystem, revision)?
> 
> I'm afraid that's not possible.
> 
> Because they have the same pci id and revision.

Please provide more details about what platform/devices support you
are adding and what PCI IDs and DW GMAC IP-core version they have.

> 
> 
> Thanks,
> 
> Yanteng
> 
> > 
> > -Serge(y)
> > 
> > > +		break;
> > > +	}
> > > +
> > > +	switch (pdev->revision) {
> > > +	case 0x00:
> > > +		plat->flags |=
> > > +			FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1) |
> > > +			FIELD_PREP(STMMAC_FLAG_DISABLE_FORCE_1000, 1);
> > > +		break;
> > > +	case 0x01:
> > > +		plat->flags |=
> > > +			FIELD_PREP(STMMAC_FLAG_DISABLE_HALF_DUPLEX, 1);
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static struct stmmac_pci_info loongson_gnet_pci_info = {
> > > +	.setup = loongson_gnet_data,
> > > +	.config = loongson_gnet_config,
> > > +};
> > > +
> > >   static int loongson_dwmac_probe(struct pci_dev *pdev,
> > >   				const struct pci_device_id *id)
> > >   {
> > > @@ -318,9 +395,11 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
> > >   			 loongson_dwmac_resume);
> > >   #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
> > > +#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
> > >   static const struct pci_device_id loongson_dwmac_id_table[] = {
> > >   	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> > > +	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
> > >   	{}
> > >   };
> > >   MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > index 8105ce47c6ad..d6939eb9a0d8 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > > @@ -420,6 +420,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
> > >   		return 0;
> > >   	}
> > > +	if (FIELD_GET(STMMAC_FLAG_DISABLE_FORCE_1000, priv->plat->flags)) {
> > > +		if (cmd->base.speed == SPEED_1000 &&
> > > +		    cmd->base.autoneg != AUTONEG_ENABLE)
> > > +			return -EOPNOTSUPP;
> > > +	}
> > > +
> > >   	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
> > >   }
> > > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > > index f07f79d50b06..067030cdb60f 100644
> > > --- a/include/linux/stmmac.h
> > > +++ b/include/linux/stmmac.h
> > > @@ -222,6 +222,8 @@ struct dwmac4_addrs {
> > >   #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
> > >   #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
> > >   #define STMMAC_FLAG_HAS_LGMAC			BIT(13)

> > > +#define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)

Just noticed. I do not see this flag affecting any part of the code.
Drop it if no actual action is implied by it.

-Serge(y)

> > > +#define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(15)
> > >   struct plat_stmmacenet_data {
> > >   	int bus_id;
> > > -- 
> > > 2.31.4
> > > 
> 

