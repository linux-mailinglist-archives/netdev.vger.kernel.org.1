Return-Path: <netdev+bounces-115545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8878E946F8D
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F1E1F217D3
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F211341A8E;
	Sun,  4 Aug 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JRGyRbXX"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA31A95B
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722784595; cv=none; b=DDK6J6xF+ZxtULz6DV19CjYCp/41vpCGFImR2cGTNA6id5OQdANepdx5lD+t8NDOXR7eSpEIYeNxMOnWuPY/FhakFMMViQ1zui4B9WDzkO0K7CRJ5geiu1to7HpOhebd1ffaCxVYyPuBm7sS0CvSURPKet5ksnRCI7tkUYaiyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722784595; c=relaxed/simple;
	bh=XnJT9VpYwroO27XMV/V9SHFT0pzTZmT0kjJRTjuos7o=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=kHMMpYUz4iMj1VcWcO7kru3yt42PoRZwxVqUMHAmbm0oruKfpucQbWMr2qCAouijX31XQJLYnDvtvGyMIbVNRrT89nu/ThvM21Vn6yCSajN1zQarh9FQB0wX0eQfY4BtE2Lo001S2OpB4dB/gkaMykAlYsqFaA4xjnUIDTKLfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JRGyRbXX; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722784590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2QOQz7tdqWNPepXp9xcXRdH/MC0jWnJjzTUunF9gAU=;
	b=JRGyRbXXgx+QHAAoRnUJHSddOrGIgqUjbOm/ch55A1ee8QYeE9QHQjV7IU31HdXG5Ajbsy
	VHQvTAABfOvxTLtxm3ijdGiQR86THizSgLc19+B6H0HmwDM3mBXeJFf7mFNPsoZ6CdcOkj
	z4/s9/9wsDFO0wM6o3spCXRTFxD9BuM=
Date: Sun, 04 Aug 2024 15:16:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: si.yanteng@linux.dev
Message-ID: <633c7402f8297c95d5676c5153033f4ef1a9e877@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v15 12/14] net: stmmac: dwmac-loongson: Add
 Loongson Multi-channels GMAC support
To: "Serge Semin" <fancer.lancer@gmail.com>, "Yanteng Si"
 <siyanteng@loongson.cn>
Cc: "Paolo Abeni" <pabeni@redhat.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, diasyzhang@tencent.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, "Huacai Chen"
 <chenhuacai@loongson.cn>
In-Reply-To: <fnimgluzwjonv6h3n3g3a6un7hajwmiwti6akhoetsxj6sfwh7@2glcs5e2nwxo>
References: <cover.1722253726.git.siyanteng@loongson.cn>
 <9ff53ca4064774e389dd3d5f334fc82ed2443cf0.1722253726.git.siyanteng@loongson.cn>
 <fnimgluzwjonv6h3n3g3a6un7hajwmiwti6akhoetsxj6sfwh7@2glcs5e2nwxo>
X-Migadu-Flow: FLOW_OUT

2024=E5=B9=B48=E6=9C=882=E6=97=A5 01:09, "Serge Semin" <fancer.lancer@gma=
il.com> =E5=86=99=E5=88=B0:



>=20
>=20On Mon, Jul 29, 2024 at 08:23:56PM +0800, Yanteng Si wrote:
>=20
>=20>=20
>=20> The Loongson DWMAC driver currently supports the Loongson GMAC
> >=20
>=20>  devices (based on the DW GMAC v3.50a/v3.73a IP-core) installed to =
the
> >=20
>=20>  LS2K1000 SoC and LS7A1000 chipset. But recently a new generation
> >=20
>=20>  LS2K2000 SoC was released with the new version of the Loongson GMA=
C
> >=20
>=20>  synthesized in. The new controller is based on the DW GMAC v3.73a
> >=20
>=20>  IP-core with the AV-feature enabled, which implies the multi
> >=20
>=20>  DMA-channels support. The multi DMA-channels feature has the next
> >=20
>=20>  vendor-specific peculiarities:
> >=20
>=20>=20=20
>=20>=20
>=20>  1. Split up Tx and Rx DMA IRQ status/mask bits:
> >=20
>=20>  Name Tx Rx
> >=20
>=20>  DMA_INTR_ENA_NIE =3D 0x00040000 | 0x00020000;
> >=20
>=20>  DMA_INTR_ENA_AIE =3D 0x00010000 | 0x00008000;
> >=20
>=20>  DMA_STATUS_NIS =3D 0x00040000 | 0x00020000;
> >=20
>=20>  DMA_STATUS_AIS =3D 0x00010000 | 0x00008000;
> >=20
>=20>  DMA_STATUS_FBI =3D 0x00002000 | 0x00001000;
> >=20
>=20>  2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER regi=
ster
> >=20
>=20>  field. It's 0x10 while it should have been 0x37 in accordance with
> >=20
>=20>  the actual DW GMAC IP-core version.
> >=20
>=20>  3. There are eight DMA-channels available meanwhile the Synopsys D=
W
> >=20
>=20>  GMAC IP-core supports up to three DMA-channels.
> >=20
>=20>  4. It's possible to have each DMA-channel IRQ independently delive=
red.
> >=20
>=20>  The MSI IRQs must be utilized for that.
> >=20
>=20>=20=20
>=20>=20
>=20>  Thus in order to have the multi-channels Loongson GMAC controllers
> >=20
>=20>  supported let's modify the Loongson DWMAC driver in accordance wit=
h
> >=20
>=20>  all the peculiarities described above:
> >=20
>=20>=20=20
>=20>=20
>=20>  1. Create the multi-channels Loongson GMAC-specific
> >=20
>=20>  stmmac_dma_ops::dma_interrupt()
> >=20
>=20>  stmmac_dma_ops::init_chan()
> >=20
>=20>  callbacks due to the non-standard DMA IRQ CSR flags layout.
> >=20
>=20>  2. Create the Loongson DWMAC-specific platform setup() method
> >=20
>=20>  which gets to initialize the DMA-ops with the dwmac1000_dma_ops
> >=20
>=20>  instance and overrides the callbacks described in 1. The method al=
so
> >=20
>=20>  overrides the custom Synopsys ID with the real one in order to hav=
e
> >=20
>=20>  the rest of the HW-specific callbacks correctly detected by the dr=
iver
> >=20
>=20>  core.
> >=20
>=20>  3. Make sure the platform setup() method enables the flow control =
and
> >=20
>=20>  duplex modes supported by the controller.
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
>=20>  [...]
> >=20
>=20>  @@ -146,6 +450,7 @@ static int loongson_dwmac_probe(struct pci_dev=
 *pdev, const struct pci_device_id
> >=20
>=20>  struct plat_stmmacenet_data *plat;
> >=20
>=20>  struct stmmac_pci_info *info;
> >=20
>=20>  struct stmmac_resources res;
> >=20
>=20>  + struct loongson_data *ld;
> >=20
>=20>  int ret, i;
> >=20
>=20>=20=20
>=20>=20
>=20>  plat =3D devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> >=20
>=20>  @@ -162,6 +467,10 @@ static int loongson_dwmac_probe(struct pci_de=
v *pdev, const struct pci_device_id
> >=20
>=20>  if (!plat->dma_cfg)
> >=20
>=20>  return -ENOMEM;
> >=20
>=20>=20=20
>=20>=20
>=20>  + ld =3D devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> >=20
>=20>  + if (!ld)
> >=20
>=20>  + return -ENOMEM;
> >=20
>=20>  +
> >=20
>=20>  /* Enable pci device */
> >=20
>=20>  ret =3D pci_enable_device(pdev);
> >=20
>=20>  if (ret) {
> >=20
>=20>  @@ -184,6 +493,10 @@ static int loongson_dwmac_probe(struct pci_de=
v *pdev, const struct pci_device_id
> >=20
>=20>  memset(&res, 0, sizeof(res));
> >=20
>=20>  res.addr =3D pcim_iomap_table(pdev)[0];
> >=20
>=20>=20=20
>=20>=20
>=20>  + plat->bsp_priv =3D ld;
> >=20
>=20>  + plat->setup =3D loongson_dwmac_setup;
> >=20
>=20>  + ld->loongson_id =3D readl(res.addr + GMAC_VERSION) & 0xff;
> >=20
>=20>  +
> >=20
>=20>  info =3D (struct stmmac_pci_info *)id->driver_data;
> >=20
>=20>  ret =3D info->setup(pdev, plat);
> >=20
>=20>  if (ret)
> >=20
>=20>  @@ -196,6 +509,10 @@ static int loongson_dwmac_probe(struct pci_de=
v *pdev, const struct pci_device_id
> >=20
>=20>  if (ret)
> >=20
>=20>  goto err_disable_device;
> >=20
>=20>=20=20
>=20>=20
>=20>  + /* Use the common MAC IRQ if per-channel MSIs allocation failed =
*/
> >=20
>=20>  + if (ld->loongson_id =3D=3D DWMAC_CORE_LS_MULTICHAN)
> >=20
>=20>  + loongson_dwmac_msi_config(pdev, plat, &res);
> >=20
>=20>  +
> >=20
>=20>  ret =3D stmmac_dvr_probe(&pdev->dev, plat, &res);
> >=20
>=20>  if (ret)
> >=20
>=20>  goto err_plat_clear;
> >=20
>=20>  @@ -205,6 +522,8 @@ static int loongson_dwmac_probe(struct pci_dev=
 *pdev, const struct pci_device_id
> >=20
>=20>  err_plat_clear:
> >=20
>=20>  if (dev_of_node(&pdev->dev))
> >=20
>=20>  loongson_dwmac_dt_clear(pdev, plat);
> >=20
>=20>  + else if (ld->loongson_id =3D=3D DWMAC_CORE_LS_MULTICHAN)
> >=20
>=20>  + loongson_dwmac_msi_clear(pdev);
> >=20
>=20
> Why implementing "else if" here if the loongson_dwmac_msi_config() is
>=20
>=20called for both DT and ACPI cases? AFAICS it should be just "if".
Yeah, you are right!

>=20
>=20>=20
>=20> err_disable_device:
> >=20
>=20>  pci_disable_device(pdev);
> >=20
>=20>  return ret;
> >=20
>=20>  @@ -217,8 +536,10 @@ static void loongson_dwmac_remove(struct pci_=
dev *pdev)
> >=20
>=20>  {
> >=20
>=20>  struct net_device *ndev =3D dev_get_drvdata(&pdev->dev);
> >=20
>=20>  struct stmmac_priv *priv =3D netdev_priv(ndev);
> >=20
>=20>  + struct loongson_data *ld;
> >=20
>=20>  int i;
> >=20
>=20>=20=20
>=20>=20
>=20>  + ld =3D priv->plat->bsp_priv;
> >=20
>=20>  of_node_put(priv->plat->mdio_node);
> >=20
>=20>  stmmac_dvr_remove(&pdev->dev);
> >=20
>=20>=20=20
>=20>=20
>=20>  @@ -232,6 +553,9 @@ static void loongson_dwmac_remove(struct pci_d=
ev *pdev)
> >=20
>=20>  break;
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  + if (ld->loongson_id =3D=3D DWMAC_CORE_LS_MULTICHAN)
> >=20
>=20>  + loongson_dwmac_msi_clear(pdev);
> >=20
>=20>  +
> >=20
>=20
> Please do this just below the=20
>=20
>  if (dev_of_node(&pdev->dev))
>=20
>=20 loongson_dwmac_dt_clear(pdev, priv->plat);
>=20
>=20chunk so the remove() method would look similar to the
>=20
>=20cleanup-on-error path of the probe() method.
OK.

Thanks,
Yanteng
>=20
>=20-Serge(y)
>=20
>=20>=20
>=20> pci_disable_device(pdev);
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  --=20
>=20>=20
>=20>  2.31.4
> >
>

