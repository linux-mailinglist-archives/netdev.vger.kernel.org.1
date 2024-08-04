Return-Path: <netdev+bounces-115544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB16946F8C
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CF21F214DA
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F161FE1;
	Sun,  4 Aug 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D3PeujrP"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD4A934
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722784425; cv=none; b=ndFR4IYu05ZT+FZFe8CHL9MCNNHyZ0BVCvorM5RR7X4G8a3DVi7zlkiGihV6KejmgGE46mLWsd1ILSpJNaN0d6Ax6leE5jGb3Ok84w/7y5p9CMUrr04uENKoIz7S2z7w2ELzKAr4E5RzCjj6cGrwlrt+JTI0/f3u+9kIsHf91mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722784425; c=relaxed/simple;
	bh=V7DTCSOrD1xnLrFRPdiNnNw2M/4VWGs2fbshwnOqKlY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=DMncJqAeRl8EELgTLjjphntDoZqGN3hMDnDQtiSrlN/BnHwbvdreijub/4MF+0Iyd8Ny84ZNLCopUt5zAP0daeT2aY4PeL4oxxfLkIf9Uf4Bp8/8gXI3ZGjaMqClihO5V9PEluh4pkGBTSrpqQF13uY6+k9/HxW5f7wHyfQWIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D3PeujrP; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722784420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCAQO6cPk8v57qbqEVR80gzbtEzQ3y3eFOhztbdIBzA=;
	b=D3PeujrPeIoU2zQZfPSNaKtuC+Z146S8DDVXTjPoQhLGbxLNDV3JVawECUFhoCdDJJLPxC
	RNdRVYqwz/cGaREZ8fiASl5PysBc5f/ED7OkbrIjBgcuwrBRkQqmgPDIXAm9RRT4ix11OL
	4NCDfa9Q+mA9PajF1UhS8WXsXhYJ9mw=
Date: Sun, 04 Aug 2024 15:13:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: si.yanteng@linux.dev
Message-ID: <733374712e545a1b15a03145fa462f1503ea3d9e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v15 11/14] net: stmmac: dwmac-loongson: Add
 DT-less GMAC PCI-device support
To: "Serge Semin" <fancer.lancer@gmail.com>, "Yanteng Si"
 <siyanteng@loongson.cn>
Cc: "Paolo Abeni" <pabeni@redhat.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, diasyzhang@tencent.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, "Huacai Chen"
 <chenhuacai@loongson.cn>
In-Reply-To: <ow47o3pjvma2g4m5jtjw6e5vnz6rp7qtxcdmgzhlr2wgltqrbk@hyqnko2hzkyu>
References: <cover.1722253726.git.siyanteng@loongson.cn>
 <359b2c226e7b18d4af8bb827ca26a2e7869d5f85.1722253726.git.siyanteng@loongson.cn>
 <ow47o3pjvma2g4m5jtjw6e5vnz6rp7qtxcdmgzhlr2wgltqrbk@hyqnko2hzkyu>
X-Migadu-Flow: FLOW_OUT

2024=E5=B9=B48=E6=9C=882=E6=97=A5 00:50, "Serge Semin" <fancer.lancer@gma=
il.com> =E5=86=99=E5=88=B0:



>=20
>=20Hi Yanteng,
>=20
>=20On Mon, Jul 29, 2024 at 08:23:55PM +0800, Yanteng Si wrote:
>=20
>=20>=20
>=20> The Loongson GMAC driver currently supports the network controllers
> >=20
>=20>  installed on the LS2K1000 SoC and LS7A1000 chipset, for which the =
GMAC
> >=20
>=20>  devices are required to be defined in the platform device tree sou=
rce.
> >=20
>=20>  But Loongson machines may have UEFI (implies ACPI) or PMON/UBOOT
> >=20
>=20>  (implies FDT) as the system bootloaders. In order to have both sys=
tem
> >=20
>=20>  configurations support let's extend the driver functionality with =
the
> >=20
>=20>  case of having the Loongson GMAC probed on the PCI bus with no dev=
ice
> >=20
>=20>  tree node defined for it. That requires to make the device DT-node
> >=20
>=20>  optional, to rely on the IRQ line detected by the PCI core and to
> >=20
>=20>  have the MDIO bus ID calculated using the PCIe Domain+BDF numbers.
> >=20
>=20>=20=20
>=20>=20
>=20>  In order to have the device probe() and remove() methods less
> >=20
>=20>  complicated let's move the DT- and ACPI-specific code to the
> >=20
>=20>  respective sub-functions.
> >=20
>=20>=20=20
>=20>=20
>=20>  Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> >=20
>=20>  Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> >=20
>=20>  Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> >=20
>=20>  Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> >=20
>=20>  ---
> >=20
>=20>  .../ethernet/stmicro/stmmac/dwmac-loongson.c | 159 +++++++++++----=
---
> >=20
>=20>  1 file changed, 100 insertions(+), 59 deletions(-)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c =
b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >=20
>=20>  index 10b49bea8e3c..010821fb6474 100644
> >=20
>=20>  --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >=20
>=20>  +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >=20
>=20>  @@ -12,11 +12,15 @@
> >=20
>=20>  #define PCI_DEVICE_ID_LOONGSON_GMAC 0x7a03
> >=20
>=20>=20=20
>=20>=20
>=20>  struct stmmac_pci_info {
> >=20
>=20>  - int (*setup)(struct plat_stmmacenet_data *plat);
> >=20
>=20>  + int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *=
plat);
> >=20
>=20>  };
> >=20
>=20>=20=20
>=20>=20
>=20>  -static void loongson_default_data(struct plat_stmmacenet_data *pl=
at)
> >=20
>=20>  +static void loongson_default_data(struct pci_dev *pdev,
> >=20
>=20>  + struct plat_stmmacenet_data *plat)
> >=20
>=20>  {
> >=20
>=20>  + /* Get bus_id, this can be overwritten later */
> >=20
>=20>  + plat->bus_id =3D pci_dev_id(pdev);
> >=20
>=20>  +
> >=20
>=20>  plat->clk_csr =3D 2; /* clk_csr_i =3D 20-35MHz & MDC =3D clk_csr_i=
/16 */
> >=20
>=20>  plat->has_gmac =3D 1;
> >=20
>=20>  plat->force_sf_dma_mode =3D 1;
> >=20
>=20>  @@ -49,9 +53,10 @@ static void loongson_default_data(struct plat_s=
tmmacenet_data *plat)
> >=20
>=20>  plat->dma_cfg->pblx8 =3D true;
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  -static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
> >=20
>=20>  +static int loongson_gmac_data(struct pci_dev *pdev,
> >=20
>=20>  + struct plat_stmmacenet_data *plat)
> >=20
>=20>  {
> >=20
>=20>  - loongson_default_data(plat);
> >=20
>=20>  + loongson_default_data(pdev, plat);
> >=20
>=20>=20=20
>=20>=20
>=20>  plat->tx_queues_to_use =3D 1;
> >=20
>=20>  plat->rx_queues_to_use =3D 1;
> >=20
>=20>  @@ -65,20 +70,83 @@ static struct stmmac_pci_info loongson_gmac_pc=
i_info =3D {
> >=20
>=20>  .setup =3D loongson_gmac_data,
> >=20
>=20>  };
> >=20
>=20>=20=20
>=20>=20
>=20>  +static int loongson_dwmac_dt_config(struct pci_dev *pdev,
> >=20
>=20>  + struct plat_stmmacenet_data *plat,
> >=20
>=20>  + struct stmmac_resources *res)
> >=20
>=20>  +{
> >=20
>=20>  + struct device_node *np =3D dev_of_node(&pdev->dev);
> >=20
>=20>  + int ret;
> >=20
>=20>  +
> >=20
>=20>  + plat->mdio_node =3D of_get_child_by_name(np, "mdio");
> >=20
>=20>  + if (plat->mdio_node) {
> >=20
>=20>  + dev_info(&pdev->dev, "Found MDIO subnode\n");
> >=20
>=20>  + plat->mdio_bus_data->needs_reset =3D true;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + ret =3D of_alias_get_id(np, "ethernet");
> >=20
>=20>  + if (ret >=3D 0)
> >=20
>=20>  + plat->bus_id =3D ret;
> >=20
>=20>  +
> >=20
>=20>  + res->irq =3D of_irq_get_byname(np, "macirq");
> >=20
>=20>  + if (res->irq < 0) {
> >=20
>=20>  + dev_err(&pdev->dev, "IRQ macirq not found\n");
> >=20
>=20>  + ret =3D -ENODEV;
> >=20
>=20>  + goto err_put_node;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + res->wol_irq =3D of_irq_get_byname(np, "eth_wake_irq");
> >=20
>=20>  + if (res->wol_irq < 0) {
> >=20
>=20>  + dev_info(&pdev->dev,
> >=20
>=20>  + "IRQ eth_wake_irq not found, using macirq\n");
> >=20
>=20>  + res->wol_irq =3D res->irq;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + res->lpi_irq =3D of_irq_get_byname(np, "eth_lpi");
> >=20
>=20>  + if (res->lpi_irq < 0) {
> >=20
>=20>  + dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> >=20
>=20>  + ret =3D -ENODEV;
> >=20
>=20>  + goto err_put_node;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + ret =3D device_get_phy_mode(&pdev->dev);
> >=20
>=20>  + if (ret < 0) {
> >=20
>=20>  + dev_err(&pdev->dev, "phy_mode not found\n");
> >=20
>=20>  + ret =3D -ENODEV;
> >=20
>=20>  + goto err_put_node;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + plat->phy_interface =3D ret;
> >=20
>=20>  +
> >=20
>=20>  +err_put_node:
> >=20
>=20>  + of_node_put(plat->mdio_node);
> >=20
>=20>  +
> >=20
>=20>  + return ret;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  +static void loongson_dwmac_dt_clear(struct pci_dev *pdev,
> >=20
>=20>  + struct plat_stmmacenet_data *plat)
> >=20
>=20>  +{
> >=20
>=20>  + of_node_put(plat->mdio_node);
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  +static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
> >=20
>=20>  + struct plat_stmmacenet_data *plat,
> >=20
>=20>  + struct stmmac_resources *res)
> >=20
>=20>  +{
> >=20
>=20>  + if (!pdev->irq)
> >=20
>=20>  + return -EINVAL;
> >=20
>=20>  +
> >=20
>=20>  + res->irq =3D pdev->irq;
> >=20
>=20>  +
> >=20
>=20>  + return 0;
> >=20
>=20>  +}
> >=20
>=20>  +
> >=20
>=20>  static int loongson_dwmac_probe(struct pci_dev *pdev, const struct=
 pci_device_id *id)
> >=20
>=20>  {
> >=20
>=20>  struct plat_stmmacenet_data *plat;
> >=20
>=20>  struct stmmac_pci_info *info;
> >=20
>=20>  struct stmmac_resources res;
> >=20
>=20>  - struct device_node *np;
> >=20
>=20>  - int ret, i, phy_mode;
> >=20
>=20>  -
> >=20
>=20>  - np =3D dev_of_node(&pdev->dev);
> >=20
>=20>  -
> >=20
>=20>  - if (!np) {
> >=20
>=20>  - pr_info("dwmac_loongson_pci: No OF node\n");
> >=20
>=20>  - return -ENODEV;
> >=20
>=20>  - }
> >=20
>=20>  + int ret, i;
> >=20
>=20>=20=20
>=20>=20
>=20>  plat =3D devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> >=20
>=20>  if (!plat)
> >=20
>=20>  @@ -90,17 +158,9 @@ static int loongson_dwmac_probe(struct pci_dev=
 *pdev, const struct pci_device_id
> >=20
>=20>  if (!plat->mdio_bus_data)
> >=20
>=20>  return -ENOMEM;
> >=20
>=20>=20=20
>=20>=20
>=20>  - plat->mdio_node =3D of_get_child_by_name(np, "mdio");
> >=20
>=20>  - if (plat->mdio_node) {
> >=20
>=20>  - dev_info(&pdev->dev, "Found MDIO subnode\n");
> >=20
>=20>  - plat->mdio_bus_data->needs_reset =3D true;
> >=20
>=20>  - }
> >=20
>=20>  -
> >=20
>=20>  plat->dma_cfg =3D devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg),=
 GFP_KERNEL);
> >=20
>=20>  - if (!plat->dma_cfg) {
> >=20
>=20>  - ret =3D -ENOMEM;
> >=20
>=20>  - goto err_put_node;
> >=20
>=20>  - }
> >=20
>=20>  + if (!plat->dma_cfg)
> >=20
>=20>  + return -ENOMEM;
> >=20
>=20>=20=20
>=20>=20
>=20>  /* Enable pci device */
> >=20
>=20>  ret =3D pci_enable_device(pdev);
> >=20
>=20>  @@ -109,6 +169,8 @@ static int loongson_dwmac_probe(struct pci_dev=
 *pdev, const struct pci_device_id
> >=20
>=20>  goto err_put_node;
> >=20
>=20
>  return ret;
>=20
>=20* Once again BTW.
>=20
>=20>=20
>=20> }
> >=20
>=20>=20=20
>=20>=20
>=20>  + pci_set_master(pdev);
> >=20
>=20>  +
> >=20
>=20>  /* Get the base address of device */
> >=20
>=20>  for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> >=20
>=20>  if (pci_resource_len(pdev, i) =3D=3D 0)
> >=20
>=20>  @@ -119,57 +181,33 @@ static int loongson_dwmac_probe(struct pci_d=
ev *pdev, const struct pci_device_id
> >=20
>=20>  break;
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  - plat->bus_id =3D of_alias_get_id(np, "ethernet");
> >=20
>=20>  - if (plat->bus_id < 0)
> >=20
>=20>  - plat->bus_id =3D pci_dev_id(pdev);
> >=20
>=20>  -
> >=20
>=20>  - phy_mode =3D device_get_phy_mode(&pdev->dev);
> >=20
>=20>  - if (phy_mode < 0) {
> >=20
>=20>  - dev_err(&pdev->dev, "phy_mode not found\n");
> >=20
>=20>  - ret =3D phy_mode;
> >=20
>=20>  - goto err_disable_device;
> >=20
>=20>  - }
> >=20
>=20>  -
> >=20
>=20>  - plat->phy_interface =3D phy_mode;
> >=20
>=20>  -
> >=20
>=20>  - pci_set_master(pdev);
> >=20
>=20>  -
> >=20
>=20>  memset(&res, 0, sizeof(res));
> >=20
>=20>  res.addr =3D pcim_iomap_table(pdev)[0];
> >=20
>=20>=20=20
>=20>=20
>=20>  info =3D (struct stmmac_pci_info *)id->driver_data;
> >=20
>=20>  - ret =3D info->setup(plat);
> >=20
>=20>  + ret =3D info->setup(pdev, plat);
> >=20
>=20>  if (ret)
> >=20
>=20>  goto err_disable_device;
> >=20
>=20>=20=20
>=20>=20
>=20>  - res.irq =3D of_irq_get_byname(np, "macirq");
> >=20
>=20>  - if (res.irq < 0) {
> >=20
>=20>  - dev_err(&pdev->dev, "IRQ macirq not found\n");
> >=20
>=20>  - ret =3D -ENODEV;
> >=20
>=20>  - goto err_disable_device;
> >=20
>=20>  - }
> >=20
>=20>  -
> >=20
>=20>  - res.wol_irq =3D of_irq_get_byname(np, "eth_wake_irq");
> >=20
>=20>  - if (res.wol_irq < 0) {
> >=20
>=20>  - dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n=
");
> >=20
>=20>  - res.wol_irq =3D res.irq;
> >=20
>=20>  - }
> >=20
>=20>  -
> >=20
>=20>  - res.lpi_irq =3D of_irq_get_byname(np, "eth_lpi");
> >=20
>=20>  - if (res.lpi_irq < 0) {
> >=20
>=20>  - dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> >=20
>=20>  - ret =3D -ENODEV;
> >=20
>=20>  + if (dev_of_node(&pdev->dev))
> >=20
>=20>  + ret =3D loongson_dwmac_dt_config(pdev, plat, &res);
> >=20
>=20>  + else
> >=20
>=20>  + ret =3D loongson_dwmac_acpi_config(pdev, plat, &res);
> >=20
>=20>  + if (ret)
> >=20
>=20>  goto err_disable_device;
> >=20
>=20>  - }
> >=20
>=20>=20=20
>=20>=20
>=20>  ret =3D stmmac_dvr_probe(&pdev->dev, plat, &res);
> >=20
>=20>  if (ret)
> >=20
>=20>  - goto err_disable_device;
> >=20
>=20>  + goto err_plat_clear;
> >=20
>=20>=20=20
>=20>=20
>=20>  - return ret;
> >=20
>=20>  + return 0;
> >=20
>=20>=20=20
>=20>=20
>=20>  +err_plat_clear:
> >=20
>=20>  + if (dev_of_node(&pdev->dev))
> >=20
>=20>  + loongson_dwmac_dt_clear(pdev, plat);
> >=20
>=20>  err_disable_device:
> >=20
>=20>  pci_disable_device(pdev);
> >=20
>=20>  + return ret;
> >=20
>=20>  err_put_node:
> >=20
>=20>  of_node_put(plat->mdio_node);
> >=20
>=20>  return ret;
> >=20
>=20
> The main point of my v14 comment was to completely move the
>=20
>=20of_node_put(plat->mdio_node) call to the DT-config/clear methods
>=20
>=20(since it's OF-related config) and setting the loongson_dwmac_probe()
>=20
>=20method free from the direct MDIO-node putting. Don't you see that
>=20
>=20calling of_node_put() in the loongson_dwmac_probe() and
>=20
>=20loongson_dwmac_remove() is now redundant?
Oh, I see! Thanks!


Thanks,
Yanteng

