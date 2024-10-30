Return-Path: <netdev+bounces-140274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BBB9B5BA3
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 07:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78671C20F84
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 06:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BAD1D0E30;
	Wed, 30 Oct 2024 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ATWlu256"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B363CB;
	Wed, 30 Oct 2024 06:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268935; cv=none; b=T5Ve4DUqZFn+dBXcuZDh5JhL7KJTxmBB+22FrJck9MkG7aMCi3YLMvYW0BJBUSS+tUbRM52ATtNVFhFYCEzqZu/7eiGCj/p9qV1s1CydhyUn3YaESP7NcMGS5CyLXeiPPR9K9Lc/HbmRoS05t9olrdEnXwsEJAMX1HsxAz6sV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268935; c=relaxed/simple;
	bh=V9FCv8uWIZXfjmEKMGrmygt4uI0Y8EGmOOHIBDswjh0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iM23uWisqISORvbZw7GdLeeA6X8hrTUk0pVG56ddXrtDInQm/NyZayDEg+z+ufYncU0FnxmKaMRlnJWOK5/xW3SAHRFWbyjQJQzh21V3tfWM9Jyly8BHhyqqbbgxwbQVaxNzy1ASR8r18Vq4Bmr6gvqO+A6y6ZH11WvIHg4yJjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ATWlu256; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730268932; x=1761804932;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=V9FCv8uWIZXfjmEKMGrmygt4uI0Y8EGmOOHIBDswjh0=;
  b=ATWlu256giOhELDMWl4yB/lt3QKAj+3UPFUdC3+rRotE5kLg3HX2qGVC
   ptM4QwPqnEwQ8Ffxn6eZ9fL6Vg6QXqWTvruDy1dgxSdEzTalGkEzxYx3f
   /A+KTj4WdQdFOPV04yL80GC/9AmY8Ok00jzC9U7JClQAgKdfRdNjoVqlM
   cWVmL4xk+09LMMzX9A94/ASp1kIMAPDAc5QL6kGUvaVkCFImnPieBFusF
   L4kq3k377+/UlzbP727U6G1eMrohiV1sWTgbtjolGDwBzJjCJYiCn0o9U
   OZOZmvXiIP5WDZ6Haonpf29EwxHFeyJuU7kJffNvIENNe3N8OPu1jBYQd
   A==;
X-CSE-ConnectionGUID: 0lqINZ9NTLmv5lbqBndLMg==
X-CSE-MsgGUID: Ug+4el6qQwSdlOWgj9/pSw==
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="34180610"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 23:15:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 29 Oct 2024 23:15:17 -0700
Received: from che-dk-ungapp06lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 29 Oct 2024 23:15:13 -0700
Message-ID: <b5ea0128f9fb3b59058fd264eecc1c7f31fd6591.camel@microchip.com>
Subject: Re: [PATCH] Add LAN78XX OTP_ACCESS flag support
From: Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>
To: Fabian Benschuh <Fabi.Benschuh@fau.de>, Woojung Huh
	<woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-usb@vger.kernel.org>
Date: Wed, 30 Oct 2024 11:48:11 +0530
In-Reply-To: <20241025230550.25536-1-Fabi.Benschuh@fau.de>
References: <20241025230550.25536-1-Fabi.Benschuh@fau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Fabian,

Please see the comments inline.

Thanks,
Rakesh.

On Sat, 2024-10-26 at 01:05 +0200, Fabian Benschuh wrote:
> With this flag we can now use ethtool to access the OTP:
> ethtool --set-priv-flags eth0 OTP_ACCESS on
> ethtool -e eth0  # this will read OTP if OTP_ACCESS is on, else
> EEPROM
> 
> When writing to OTP we need to set OTP_ACCESS on and write with the
> correct magic 0x7873 for OTP
> ---
>  drivers/net/usb/lan78xx.c | 55 ++++++++++++++++++++++++++++++++-----
> --
>  1 file changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 8adf77e3557e..2fc9b9b138b0 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -85,6 +85,7 @@
>  #define EEPROM_INDICATOR		(0xA5)
>  #define EEPROM_MAC_OFFSET		(0x01)
>  #define MAX_EEPROM_SIZE			512
> +#define MAX_OTP_SIZE			512
>  #define OTP_INDICATOR_1			(0xF3)
>  #define OTP_INDICATOR_2			(0xF7)
>  
> @@ -172,6 +173,7 @@
>  #define INT_EP_GPIO_2			(2)
>  #define INT_EP_GPIO_1			(1)
>  #define INT_EP_GPIO_0			(0)
> +#define LAN78XX_NET_FLAG_OTP		BIT(0)
Please move this macro to other macros defined with prefix "LAN78XX_"
and probably please rename it to "LAN78XX_ADAPTER_ETHTOOL_FLAG_OTP".

>  
>  static const char lan78xx_gstrings[][ETH_GSTRING_LEN] = {
>  	"RX FCS Errors",
> @@ -446,6 +448,7 @@ struct lan78xx_net {
>  	unsigned int		burst_cap;
>  
>  	unsigned long		flags;
> +	u32			priv_flags;
It would be good to include variables of single type to be grouped
together. There are variables of type u32, please move this variable to
that group.

>  
>  	wait_queue_head_t	*wait;
>  	unsigned char		suspend_count;
> @@ -1542,6 +1545,10 @@ static void lan78xx_status(struct lan78xx_net
> *dev, struct urb *urb)
>  
>  static int lan78xx_ethtool_get_eeprom_len(struct net_device *netdev)
>  {
> +	struct lan78xx_net *dev = netdev_priv(netdev);
> +
> +	if (dev->priv_flags & LAN78XX_NET_FLAG_OTP)
> +		return MAX_OTP_SIZE;
>  	return MAX_EEPROM_SIZE;
>  }
>  
> @@ -1555,9 +1562,10 @@ static int lan78xx_ethtool_get_eeprom(struct
> net_device *netdev,
>  	if (ret)
>  		return ret;
>  
> -	ee->magic = LAN78XX_EEPROM_MAGIC;
> -
> -	ret = lan78xx_read_raw_eeprom(dev, ee->offset, ee->len, data);
> +	if (dev->priv_flags & LAN78XX_NET_FLAG_OTP)
> +		ret = lan78xx_read_raw_otp(dev, ee->offset, ee->len,
> data);
> +	else
> +		ret = lan78xx_read_raw_eeprom(dev, ee->offset, ee->len, 
> data);
>  
>  	usb_autopm_put_interface(dev->intf);
>  
> @@ -1577,30 +1585,39 @@ static int lan78xx_ethtool_set_eeprom(struct
> net_device *netdev,
>  	/* Invalid EEPROM_INDICATOR at offset zero will result in a
> failure
>  	 * to load data from EEPROM
>  	 */
> -	if (ee->magic == LAN78XX_EEPROM_MAGIC)
> -		ret = lan78xx_write_raw_eeprom(dev, ee->offset, ee-
> >len, data);
> -	else if ((ee->magic == LAN78XX_OTP_MAGIC) &&
> -		 (ee->offset == 0) &&
> -		 (ee->len == 512) &&
> -		 (data[0] == OTP_INDICATOR_1))
> -		ret = lan78xx_write_raw_otp(dev, ee->offset, ee->len,
> data);
> +	if (dev->priv_flags & LAN78XX_NET_FLAG_OTP) {
> +		/* Beware!  OTP is One Time Programming ONLY! */
> +		if (ee->magic == LAN78XX_OTP_MAGIC)
> +		    ret = lan78xx_write_raw_otp(dev, ee->offset, ee-
> >len, data);
> +	} else {
> +		if (ee->magic == LAN78XX_EEPROM_MAGIC)
> +		    ret = lan78xx_write_raw_eeprom(dev, ee->offset, ee-
> >len, data);
In the function "lan78xx_write_raw_eeprom.otp", please add the
condition check if the offset + length are within the
EEPROM/OTP_MAX_SIZE limits and proceed further to write if the
condition is met.

> +	}
>  
>  	usb_autopm_put_interface(dev->intf);
>  
>  	return ret;
>  }
>  
> +static const char lan78xx_priv_flags_strings[][ETH_GSTRING_LEN] = {
> +	"OTP_ACCESS",
> +};
> +
>  static void lan78xx_get_strings(struct net_device *netdev, u32
> stringset,
>  				u8 *data)
>  {
>  	if (stringset == ETH_SS_STATS)
>  		memcpy(data, lan78xx_gstrings,
> sizeof(lan78xx_gstrings));
> +	else if (stringset == ETH_SS_PRIV_FLAGS)
> +		memcpy(data, lan78xx_priv_flags_strings,
> sizeof(lan78xx_priv_flags_strings));
>  }
>  
>  static int lan78xx_get_sset_count(struct net_device *netdev, int
> sset)
>  {
>  	if (sset == ETH_SS_STATS)
>  		return ARRAY_SIZE(lan78xx_gstrings);
> +	else if (sset == ETH_SS_PRIV_FLAGS)
> +		return ARRAY_SIZE(lan78xx_priv_flags_strings);
>  	else
>  		return -EOPNOTSUPP;
>  }
> @@ -1617,6 +1634,22 @@ static void lan78xx_get_stats(struct
> net_device *netdev,
>  	mutex_unlock(&dev->stats.access_lock);
>  }
>  
> +static u32 lan78xx_ethtool_get_priv_flags(struct net_device *netdev)
> +{
> +	struct lan78xx_net *dev = netdev_priv(netdev);
> +
> +	return dev->priv_flags;
> +}
> +
> +static int lan78xx_ethtool_set_priv_flags(struct net_device *netdev,
> u32 flags)
> +{
> +	struct lan78xx_net *dev = netdev_priv(netdev);
> +
> +	dev->priv_flags = flags;
Instead of assigning flags directly, it would be good to add checks and
assign something like this
if (flags & LAN78XX_ADAPTER_ETHTOOL_FLAG_OTP)
	dev->ethtool_flags |= LAN78XX_ADAPTER_ETHTOOL_FLAG_OTP;
else
	dev->ethtool_flags &= ~LAN78XX_ADAPTER_ETHTOOL_FLAG_OTP;

> +
> +	return 0;
> +}
> +
>  static void lan78xx_get_wol(struct net_device *netdev,
>  			    struct ethtool_wolinfo *wol)
>  {
> @@ -1905,6 +1938,8 @@ static const struct ethtool_ops
> lan78xx_ethtool_ops = {
>  	.get_eeprom	= lan78xx_ethtool_get_eeprom,
>  	.set_eeprom	= lan78xx_ethtool_set_eeprom,
>  	.get_ethtool_stats = lan78xx_get_stats,
> +	.get_priv_flags = lan78xx_ethtool_get_priv_flags,
> +	.set_priv_flags = lan78xx_ethtool_set_priv_flags,
>  	.get_sset_count = lan78xx_get_sset_count,
>  	.get_strings	= lan78xx_get_strings,
>  	.get_wol	= lan78xx_get_wol,


