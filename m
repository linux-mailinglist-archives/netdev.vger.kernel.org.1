Return-Path: <netdev+bounces-234444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DC2C20AA6
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3C2F4EFD98
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4A228506F;
	Thu, 30 Oct 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BfITBlv/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F0283FF1;
	Thu, 30 Oct 2025 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834900; cv=none; b=CjwmDHG3TcAqdb9k4FYrh0/tznPMT/tNQsLBc7Q34EmkBf0bwWwjQ5WhiFXxmMPyT6MkA/Bidw/FBpm7yrkgtnntDGduNq4bRo301QYSZU1Wn+aYagzbKenLA058f94To1aTZ7kcpkHbmqrHBKQ5f5TMdOICvap71YQUALv3Uig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834900; c=relaxed/simple;
	bh=kzKBgV8r5q8edgixyS3j7wmuBEdehQSVMTJBgW7xz6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CsX7yIZIaXJQW9rTFplDbCam8XnMif61TnMxD/Ny+jhIITUSOv+LfdRmHqDtwGXYOPOr9fLZ/t1gJYsnbiIVCShzxlTBrEmoNnKKB84hskLG/eVMAs6XZVCJQFk8EDzqnRhXXy3GXjN7qIGTypbQkv+al7cNFz1lYoOU/2NU2o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BfITBlv/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761834899; x=1793370899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kzKBgV8r5q8edgixyS3j7wmuBEdehQSVMTJBgW7xz6E=;
  b=BfITBlv/T80CUadRIPGXDf6mSx5WZNa3ncao3fpK6ClgGI3cO9M3RlEA
   MFgdiIrOaQVzFx9NqmKZDtLGS/+/WDzZgD3u5GLcv7Ntd8erYQvcjr1l+
   U1hIVU5is5s24wN3DCJsjnW5wc3uk6N9J1k+06YhJyXYRrzLDvQLvaJVN
   0DxeDPSMHiaNExODKpxpt2CtJEPYxZMBk9k4zr/hCWEjVBKSuiPbSVy89
   wyNKguMB+HNqN+7XgrYGbDbeQUtE19035Pkz9OSB6Nblb1mN6taDuYxmd
   +HLRDheHmoVe0HopG0OXqPk2DvdATRc5iSiPa+Q24OUltxDMKEIuiBZHP
   A==;
X-CSE-ConnectionGUID: iP8P+z7SToStG8EktGUkkw==
X-CSE-MsgGUID: hH6D5D30RymrOV/Z5QwJMQ==
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="48472823"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 07:34:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 30 Oct 2025 07:34:51 -0700
Received: from [10.171.248.18] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 30 Oct 2025 07:34:45 -0700
Message-ID: <cd0ae7c8-0df7-443f-a5d3-da2c3aa88582@microchip.com>
Date: Thu, 30 Oct 2025 15:34:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/5] net: macb: rename bp->sgmii_phy field to
 bp->phy
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
	<vladimir.kondratiev@mobileye.com>, Andrew Lunn <andrew@lunn.ch>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
 <20251023-macb-eyeq5-v3-4-af509422c204@bootlin.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20251023-macb-eyeq5-v3-4-af509422c204@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 23/10/2025 at 18:22, Théo Lebrun wrote:
> The bp->sgmii_phy field is initialised at probe by init_reset_optional()
> if bp->phy_interface == PHY_INTERFACE_MODE_SGMII. It gets used by:
>   - zynqmp_config: "cdns,zynqmp-gem" or "xlnx,zynqmp-gem" compatibles.
>   - mpfs_config: "microchip,mpfs-macb" compatible.
>   - versal_config: "xlnx,versal-gem" compatible.
> 
> Make name more generic as EyeQ5 requires the PHY in SGMII & RGMII cases.
> 
> Drop "for ZynqMP SGMII mode" comment that is already a lie, as it gets
> used on Microchip platforms as well. And soon it won't be SGMII-only.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/net/ethernet/cadence/macb.h      |  2 +-
>   drivers/net/ethernet/cadence/macb_main.c | 26 +++++++++++++-------------
>   2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 05bfa9bd4782..87414a2ddf6e 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1341,7 +1341,7 @@ struct macb {
> 
>          struct macb_ptp_info    *ptp_info;      /* macb-ptp interface */
> 
> -       struct phy              *sgmii_phy;     /* for ZynqMP SGMII mode */
> +       struct phy              *phy;
> 
>          spinlock_t tsu_clk_lock; /* gem tsu clock locking */
>          unsigned int tsu_rate;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 8b688a6cb2f9..44188e7eee56 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2965,7 +2965,7 @@ static int macb_open(struct net_device *dev)
> 
>          macb_init_hw(bp);
> 
> -       err = phy_power_on(bp->sgmii_phy);
> +       err = phy_power_on(bp->phy);
>          if (err)
>                  goto reset_hw;
> 
> @@ -2981,7 +2981,7 @@ static int macb_open(struct net_device *dev)
>          return 0;
> 
>   phy_off:
> -       phy_power_off(bp->sgmii_phy);
> +       phy_power_off(bp->phy);
> 
>   reset_hw:
>          macb_reset_hw(bp);
> @@ -3013,7 +3013,7 @@ static int macb_close(struct net_device *dev)
>          phylink_stop(bp->phylink);
>          phylink_disconnect_phy(bp->phylink);
> 
> -       phy_power_off(bp->sgmii_phy);
> +       phy_power_off(bp->phy);
> 
>          spin_lock_irqsave(&bp->lock, flags);
>          macb_reset_hw(bp);
> @@ -5141,13 +5141,13 @@ static int init_reset_optional(struct platform_device *pdev)
> 
>          if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
>                  /* Ensure PHY device used in SGMII mode is ready */
> -               bp->sgmii_phy = devm_phy_optional_get(&pdev->dev, NULL);
> +               bp->phy = devm_phy_optional_get(&pdev->dev, NULL);
> 
> -               if (IS_ERR(bp->sgmii_phy))
> -                       return dev_err_probe(&pdev->dev, PTR_ERR(bp->sgmii_phy),
> +               if (IS_ERR(bp->phy))
> +                       return dev_err_probe(&pdev->dev, PTR_ERR(bp->phy),
>                                               "failed to get SGMII PHY\n");
> 
> -               ret = phy_init(bp->sgmii_phy);
> +               ret = phy_init(bp->phy);
>                  if (ret)
>                          return dev_err_probe(&pdev->dev, ret,
>                                               "failed to init SGMII PHY\n");
> @@ -5176,7 +5176,7 @@ static int init_reset_optional(struct platform_device *pdev)
>          /* Fully reset controller at hardware level if mapped in device tree */
>          ret = device_reset_optional(&pdev->dev);
>          if (ret) {
> -               phy_exit(bp->sgmii_phy);
> +               phy_exit(bp->phy);
>                  return dev_err_probe(&pdev->dev, ret, "failed to reset controller");
>          }
> 
> @@ -5184,7 +5184,7 @@ static int init_reset_optional(struct platform_device *pdev)
> 
>   err_out_phy_exit:
>          if (ret)
> -               phy_exit(bp->sgmii_phy);
> +               phy_exit(bp->phy);
> 
>          return ret;
>   }
> @@ -5594,7 +5594,7 @@ static int macb_probe(struct platform_device *pdev)
>          mdiobus_free(bp->mii_bus);
> 
>   err_out_phy_exit:
> -       phy_exit(bp->sgmii_phy);
> +       phy_exit(bp->phy);
> 
>   err_out_free_netdev:
>          free_netdev(dev);
> @@ -5618,7 +5618,7 @@ static void macb_remove(struct platform_device *pdev)
>          if (dev) {
>                  bp = netdev_priv(dev);
>                  unregister_netdev(dev);
> -               phy_exit(bp->sgmii_phy);
> +               phy_exit(bp->phy);
>                  mdiobus_unregister(bp->mii_bus);
>                  mdiobus_free(bp->mii_bus);
> 
> @@ -5645,7 +5645,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
>          u32 tmp;
> 
>          if (!device_may_wakeup(&bp->dev->dev))
> -               phy_exit(bp->sgmii_phy);
> +               phy_exit(bp->phy);
> 
>          if (!netif_running(netdev))
>                  return 0;
> @@ -5774,7 +5774,7 @@ static int __maybe_unused macb_resume(struct device *dev)
>          int err;
> 
>          if (!device_may_wakeup(&bp->dev->dev))
> -               phy_init(bp->sgmii_phy);
> +               phy_init(bp->phy);
> 
>          if (!netif_running(netdev))
>                  return 0;
> 
> --
> 2.51.1
> 


