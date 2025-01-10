Return-Path: <netdev+bounces-157077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4781CA08DB2
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85F318836D0
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FB72080CB;
	Fri, 10 Jan 2025 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mb0AldzV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BD0204F61;
	Fri, 10 Jan 2025 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504228; cv=none; b=CmFmBLLP82gkJRhMqQptnxScpcf9O7RmykWdtTSSV9uDQoAtKE9GQznToe3ytuso4SFhElVSHdJoO04JFIDL7DtfNYv0tYe4i7yHkylcw/NnzQRMZ0hzO7vJuYb3C8Fq2hqewPaPwOtCiooIGQF8teolswavTLO8s7TagZByWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504228; c=relaxed/simple;
	bh=MUFaxaznto5kRfQFQH+aYzQT8JMNYVK4+BvHtJ5UUos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvETzlaXGy8zRxJyg1eV6jPHK60GitWjM613FsV+1KTjhEV6Tqpn4l67n9rj5mSrBnbKnGDhv113j5ieQ8UJcGZQ5nx2VDSmJAyHFWAd6OqAhcXwZpvjy+/hTMfqzY4FbXfPptWbq5uuwOzoOC7gcUrJT6vQvcGNPCs5gjwaS0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mb0AldzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CE8C4CED6;
	Fri, 10 Jan 2025 10:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736504227;
	bh=MUFaxaznto5kRfQFQH+aYzQT8JMNYVK4+BvHtJ5UUos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mb0AldzVEfBWq2aLqVXUWw/fXwd31CEoReoS/H0vfs+63xq/RRcf6xuWjECk9S2I6
	 2Bt9RcQ9m3gOYyT2ugDvlX7OTYgQNUuGb7q8whef29b23CVRuZgLyItLgr4iAhAqZW
	 rx7nze6hFxHRIGD6FCW2wIbJi42Ao6Q606Vd5Z5EX2vYLMCRVUhss9K4MbyzAuNHr1
	 SAg0pN1rzhKJ/X6KdZVUx7Dod3YZcY5Xdv3tXiDONixUaC0gsRGg2vV9F2GHvoB7r8
	 84bMNALMA/YnDU5iGDZFHiYPcjQsUCUrknCofKRI07ogZ8AM7phva5/lS1LzOKjFGd
	 LCXb+eUkUsVCQ==
Date: Fri, 10 Jan 2025 10:17:03 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux@roeck-us.net
Subject: Re: [PATCH net] r8169: remove redundant hwmon support
Message-ID: <20250110101703.GV7706@kernel.org>
References: <357e6526-ee3e-4e66-b556-7364fdcb2bfc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <357e6526-ee3e-4e66-b556-7364fdcb2bfc@gmail.com>

+ Jean Delvare, linux-hwmon, linux@roeck-us.net

On Thu, Jan 09, 2025 at 11:29:09PM +0100, Heiner Kallweit wrote:
> The temperature sensor is actually part of the integrated PHY and available
> also on the standalone versions of the PHY. Therefore hwmon support will
> be added to the Realtek PHY driver and can be removed here.
> 
> Fixes: 1ffcc8d41306 ("r8169: add support for the temperature sensor being available from RTL8125B")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 37 -----------------------
>  1 file changed, 37 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 5724f650f..7b9ba91c3 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -16,7 +16,6 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/ethtool.h>
> -#include <linux/hwmon.h>
>  #include <linux/phy.h>
>  #include <linux/if_vlan.h>
>  #include <linux/in.h>
> @@ -5338,36 +5337,6 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	return false;
>  }
>  
> -static int r8169_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> -			    u32 attr, int channel, long *val)
> -{
> -	struct rtl8169_private *tp = dev_get_drvdata(dev);
> -	int val_raw;
> -
> -	val_raw = phy_read_paged(tp->phydev, 0xbd8, 0x12) & 0x3ff;
> -	if (val_raw >= 512)
> -		val_raw -= 1024;
> -
> -	*val = 1000 * val_raw / 2;
> -
> -	return 0;
> -}
> -
> -static const struct hwmon_ops r8169_hwmon_ops = {
> -	.visible = 0444,
> -	.read = r8169_hwmon_read,
> -};
> -
> -static const struct hwmon_channel_info * const r8169_hwmon_info[] = {
> -	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> -	NULL
> -};
> -
> -static const struct hwmon_chip_info r8169_hwmon_chip_info = {
> -	.ops = &r8169_hwmon_ops,
> -	.info = r8169_hwmon_info,
> -};
> -
>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	struct rtl8169_private *tp;
> @@ -5547,12 +5516,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (rc)
>  		return rc;
>  
> -	/* The temperature sensor is available from RTl8125B */
> -	if (IS_REACHABLE(CONFIG_HWMON) && tp->mac_version >= RTL_GIGA_MAC_VER_63)
> -		/* ignore errors */
> -		devm_hwmon_device_register_with_info(&pdev->dev, "nic_temp", tp,
> -						     &r8169_hwmon_chip_info,
> -						     NULL);
>  	rc = register_netdev(dev);
>  	if (rc)
>  		return rc;
> -- 
> 2.47.1
> 

