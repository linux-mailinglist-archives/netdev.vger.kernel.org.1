Return-Path: <netdev+bounces-234449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7F1C20AE8
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D71294F16E8
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE889280CE0;
	Thu, 30 Oct 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gDfgxYfu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2883274FDB;
	Thu, 30 Oct 2025 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835048; cv=none; b=GCzy7cRnVDF6ibjsEeDGQNFnXZpQ4bzailZoD28M6HXyu7stEpOBXcxQJKr0t9CV2PzRHbCuzUUo9MqSv/5ObqWlysEY1UpeZnu6WjbqsuK4rYA3F1dEs//k954M/XZC/Jrma+ewVNIReHVZBVD5W4+Mj1tTLq7rnSBipYUbJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835048; c=relaxed/simple;
	bh=lkxOu4GsU+Vd9vTFr5qO9VsRoZ8QwNjUPqkZVZIFsNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HANpxyPwJiu5f5NkpkZTlvVD7wDPFcgmOeSYjSUyZ7FVD1A60HMppjvpj+9ko4z2lcBpdhzdmKdax626My59xm0YCyJ5M6XmUoUoyfpGmG7mWyw5Z0TdCpA8g3Zb9BxQTyKAyPS8VO12R7+j8kWqOjs7xr3sfHxqQNhY/+LbTqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gDfgxYfu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761835046; x=1793371046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lkxOu4GsU+Vd9vTFr5qO9VsRoZ8QwNjUPqkZVZIFsNs=;
  b=gDfgxYfuCa7R3CKZRyV2zCFIe5Lpb9ax5EZG61oNTVXF/GclPTK7faBQ
   PNKij1tbSozJIGwUtuYsEa7h/u5etVAG/Km1MRg5Zh2N1iRlAtCrlMAQP
   8G1KM+4KYUFru4u9tVhE1OdEDqybzAybOZCx2cZm32QfZmkIf3l4KIBGx
   T5/uu2I1V/TdA0lstudHsf1mvuzK/lopYFxSSshHoisIOTEGE59eVy/HU
   t15S9N+bEt+C6x/z5oe5p+GkWWWvQpRkm/+n5X4ZL2TsrDquFCbbRpbYX
   VKw7L2eO160+wCqPP4ouTI3xe4C98fYb7Q9UmtiIwjreasd/6wMtbNYGE
   w==;
X-CSE-ConnectionGUID: Gc6gALqnRPaiLmM/RLGxmg==
X-CSE-MsgGUID: yhhwWjqSTAGp2vk5GLZgLg==
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="47837983"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 07:37:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 30 Oct 2025 07:37:14 -0700
Received: from [10.171.248.18] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 30 Oct 2025 07:37:08 -0700
Message-ID: <56aed16d-4e03-4da9-9c53-5bb8359f313b@microchip.com>
Date: Thu, 30 Oct 2025 15:37:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
	<benoit.monin@bootlin.com>, =?UTF-8?Q?Gr=C3=A9gory_Clement?=
	<gregory.clement@bootlin.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Vladimir Kondratiev
	<vladimir.kondratiev@mobileye.com>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
 <20251023-macb-eyeq5-v3-5-af509422c204@bootlin.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20251023-macb-eyeq5-v3-5-af509422c204@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 23/10/2025 at 18:22, Théo Lebrun wrote:
> Add support for the two GEM instances inside Mobileye EyeQ5 SoCs, using
> compatible "mobileye,eyeq5-gem". With it, add a custom init sequence
> that must grab a generic PHY and initialise it.
> 
> We use bp->phy in both RGMII and SGMII cases. Tell our mode by adding a
> phy_set_mode_ext() during macb_open(), before phy_power_on(). We are
> the first users of bp->phy that use it in non-SGMII cases.
> 
> The phy_set_mode_ext() call is made unconditionally. It cannot cause
> issues on platforms where !bp->phy or !bp->phy->ops->set_mode as, in
> those cases, the call is a no-op (returning zero). From reading
> upstream DTS, we can figure out that no platform has a bp->phy and a
> PHY driver that has a .set_mode() implementation:
>   - cdns,zynqmp-gem: no DTS upstream.
>   - microchip,mpfs-macb: microchip/mpfs.dtsi, &mac0..1, no PHY attached.
>   - xlnx,versal-gem: xilinx/versal-net.dtsi, &gem0..1, no PHY attached.
>   - xlnx,zynqmp-gem: xilinx/zynqmp.dtsi, &gem0..3, PHY attached to
>     drivers/phy/xilinx/phy-zynqmp.c which has no .set_mode().
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Looks good to me, thanks:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> ---
>   drivers/net/ethernet/cadence/macb_main.c | 38 ++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 44188e7eee56..b1ed98d9c438 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2965,6 +2965,10 @@ static int macb_open(struct net_device *dev)
> 
>          macb_init_hw(bp);
> 
> +       err = phy_set_mode_ext(bp->phy, PHY_MODE_ETHERNET, bp->phy_interface);
> +       if (err)
> +               goto reset_hw;
> +
>          err = phy_power_on(bp->phy);
>          if (err)
>                  goto reset_hw;
> @@ -5189,6 +5193,28 @@ static int init_reset_optional(struct platform_device *pdev)
>          return ret;
>   }
> 
> +static int eyeq5_init(struct platform_device *pdev)
> +{
> +       struct net_device *netdev = platform_get_drvdata(pdev);
> +       struct macb *bp = netdev_priv(netdev);
> +       struct device *dev = &pdev->dev;
> +       int ret;
> +
> +       bp->phy = devm_phy_get(dev, NULL);
> +       if (IS_ERR(bp->phy))
> +               return dev_err_probe(dev, PTR_ERR(bp->phy),
> +                                    "failed to get PHY\n");
> +
> +       ret = phy_init(bp->phy);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to init PHY\n");
> +
> +       ret = macb_init(pdev);
> +       if (ret)
> +               phy_exit(bp->phy);
> +       return ret;
> +}
> +
>   static const struct macb_usrio_config sama7g5_usrio = {
>          .mii = 0,
>          .rmii = 1,
> @@ -5343,6 +5369,17 @@ static const struct macb_config versal_config = {
>          .usrio = &macb_default_usrio,
>   };
> 
> +static const struct macb_config eyeq5_config = {
> +       .caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
> +               MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_QUEUE_DISABLE |
> +               MACB_CAPS_NO_LSO,
> +       .dma_burst_length = 16,
> +       .clk_init = macb_clk_init,
> +       .init = eyeq5_init,
> +       .jumbo_max_len = 10240,
> +       .usrio = &macb_default_usrio,
> +};
> +
>   static const struct macb_config raspberrypi_rp1_config = {
>          .caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
>                  MACB_CAPS_JUMBO |
> @@ -5374,6 +5411,7 @@ static const struct of_device_id macb_dt_ids[] = {
>          { .compatible = "microchip,mpfs-macb", .data = &mpfs_config },
>          { .compatible = "microchip,sama7g5-gem", .data = &sama7g5_gem_config },
>          { .compatible = "microchip,sama7g5-emac", .data = &sama7g5_emac_config },
> +       { .compatible = "mobileye,eyeq5-gem", .data = &eyeq5_config },
>          { .compatible = "raspberrypi,rp1-gem", .data = &raspberrypi_rp1_config },
>          { .compatible = "xlnx,zynqmp-gem", .data = &zynqmp_config},
>          { .compatible = "xlnx,zynq-gem", .data = &zynq_config },
> 
> --
> 2.51.1
> 


