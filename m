Return-Path: <netdev+bounces-230606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E64BEBD0F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 23:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DC319A3D13
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 21:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0281F2620E5;
	Fri, 17 Oct 2025 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="fjlTA41M"
X-Original-To: netdev@vger.kernel.org
Received: from mx39lb.world4you.com (mx39lb.world4you.com [81.19.149.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3502247DEA;
	Fri, 17 Oct 2025 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736698; cv=none; b=B5l7XfGN70IJmu7H3u4OarUXP+DKO/fDBCXLY3BKNcBjnAu528Rza0beU0mdryHmEE0NNVtv+NhtIECqLMHZom/O2AliJMvKXAYY1ElI/LfLKTSC/F+cEq4cK830veodHAq+Kq7awtVdZPTwdqDIhhTQUE12COe0w7xGOt50TrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736698; c=relaxed/simple;
	bh=gm9Yi3sx/kWicfL9RWWXdAcEElUO61mEIkpUJvmbf+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKrGVWRGOKKjwMF2H8LxhLO3NEshZXcv2Hv1Op+QMmZNt9WEL45tgqgC5pvIl08N1kootI1WBBJbkvstfg+v2y1TMbdlaPWXNv/iKxkDgWrJsL27RUI1RzkqHzbb1rZbj0UNF3Upztt8ELQhRBT4mHsQq5UWRcVU0APkdogoTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=fjlTA41M; arc=none smtp.client-ip=81.19.149.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BLthG6nGUCqm0GR2fabqqpjxkTBEQ9HRzUm3hiA+XNU=; b=fjlTA41MybLxAT7C2zAuo+4JIc
	/o1cIkpy8ttE2m3YycvxXLWSihtECLVTWqkZ5Hqa2a9bxacyGw5N+xTMfEoXhQzs8e10WYyaP8anz
	4Bt8QVep65YSG10Rrd6+HPp40eNh5bvqlURgLH0k52uFS3xcRpo9rsnJF1Idjo0HPj8w=;
Received: from [93.82.65.102] (helo=[10.0.0.160])
	by mx39lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1v9rnH-000000001XB-0NQs;
	Fri, 17 Oct 2025 23:15:23 +0200
Message-ID: <79f403f0-84ed-43fe-b093-d7ce122d41fd@engleder-embedded.com>
Date: Fri, 17 Oct 2025 23:15:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for non PTP SKUs
 for lan8814
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com
References: <20251017074730.3057012-1-horatiu.vultur@microchip.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20251017074730.3057012-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 17.10.25 09:47, Horatiu Vultur wrote:
> The lan8814 has 4 different SKUs and for 2 of these SKUs the PTP is
> disabled. All these SKUs have the same value in the register 2 and 3
> meaning we can't differentiate them based on device id therefore check

Did you miss to start a new sentence?

> the SKU register and based on this allow or not to create a PTP device.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>   drivers/net/phy/micrel.c | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 79ce3eb6752b6..16855bf8c3916 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -101,6 +101,8 @@
>   #define LAN8814_CABLE_DIAG_VCT_DATA_MASK	GENMASK(7, 0)
>   #define LAN8814_PAIR_BIT_SHIFT			12
>   
> +#define LAN8814_SKUS				0xB
> +
>   #define LAN8814_WIRE_PAIR_MASK			0xF
>   
>   /* Lan8814 general Interrupt control/status reg in GPHY specific block. */
> @@ -367,6 +369,9 @@
>   
>   #define LAN8842_REV_8832			0x8832
>   
> +#define LAN8814_REV_LAN8814			0x8814
> +#define LAN8814_REV_LAN8818			0x8818
> +
>   struct kszphy_hw_stat {
>   	const char *string;
>   	u8 reg;
> @@ -449,6 +454,7 @@ struct kszphy_priv {
>   	bool rmii_ref_clk_sel;
>   	bool rmii_ref_clk_sel_val;
>   	bool clk_enable;
> +	bool is_ptp_available;
>   	u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
>   	struct kszphy_phy_stats phy_stats;
>   };
> @@ -4130,6 +4136,17 @@ static int lan8804_config_intr(struct phy_device *phydev)
>   	return 0;
>   }
>   
> +/* Check if the PHY has 1588 support. There are multiple skus of the PHY and
> + * some of them support PTP while others don't support it. This function will
> + * return true is the sku supports it, otherwise will return false.
> + */

Hasn't net also switched to the common kernel multiline comment style
starting with an empty line?

> +static bool lan8814_has_ptp(struct phy_device *phydev)
> +{
> +	struct kszphy_priv *priv = phydev->priv;
> +
> +	return priv->is_ptp_available;
> +}
> +
>   static irqreturn_t lan8814_handle_interrupt(struct phy_device *phydev)
>   {
>   	int ret = IRQ_NONE;
> @@ -4146,6 +4163,9 @@ static irqreturn_t lan8814_handle_interrupt(struct phy_device *phydev)
>   		ret = IRQ_HANDLED;
>   	}
>   
> +	if (!lan8814_has_ptp(phydev))
> +		return ret;
> +
>   	while (true) {
>   		irq_status = lanphy_read_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
>   						  PTP_TSU_INT_STS);
> @@ -4207,6 +4227,9 @@ static void lan8814_ptp_init(struct phy_device *phydev)
>   	    !IS_ENABLED(CONFIG_NETWORK_PHY_TIMESTAMPING))
>   		return;
>   
> +	if (!lan8814_has_ptp(phydev))
> +		return;
> +
>   	lanphy_write_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
>   			      TSU_HARD_RESET, TSU_HARD_RESET_);
>   
> @@ -4336,6 +4359,9 @@ static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
>   
>   static int lan8814_ptp_probe_once(struct phy_device *phydev)
>   {
> +	if (!lan8814_has_ptp(phydev))
> +		return 0;
> +
>   	return __lan8814_ptp_probe_once(phydev, "lan8814_ptp_pin",
>   					LAN8814_PTP_GPIO_NUM);
>   }
> @@ -4450,6 +4476,18 @@ static int lan8814_probe(struct phy_device *phydev)
>   	devm_phy_package_join(&phydev->mdio.dev, phydev,
>   			      addr, sizeof(struct lan8814_shared_priv));
>   
> +	/* There are lan8814 SKUs that don't support PTP. Make sure that for
> +	 * those skus no PTP device is created. Here we check if the SKU
> +	 * supports PTP.
> +	 */

Check comment style.

> +	err = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> +				   LAN8814_SKUS);
> +	if (err < 0)
> +		return err;
> +
> +	priv->is_ptp_available = err == LAN8814_REV_LAN8814 ||
> +				 err == LAN8814_REV_LAN8818;
> +
>   	if (phy_package_init_once(phydev)) {
>   		err = lan8814_release_coma_mode(phydev);
>   		if (err)


