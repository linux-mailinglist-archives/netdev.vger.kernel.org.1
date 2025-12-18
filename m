Return-Path: <netdev+bounces-245283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7719CCA893
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 07:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED79D300818A
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 06:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BB20FAB2;
	Thu, 18 Dec 2025 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LJT8UK6P"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D0246782
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040450; cv=none; b=rGPQmPVU8q5zpifH5HCOHLeFz3N+zStTnEOb66RIvk/UtK12OytvEUanW/HmfxTHzlv1nAuIgLkIZhHg14Ypgaox6Ayjj2HBe87Vq9ZFOa8yyakKg72XGnDm5JCE09bubJ2+wjROkgwwJMadBrnM5LFAEgFKbwZELvOJBTZr57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040450; c=relaxed/simple;
	bh=zSpsGIOZmjfjSbI0SGfZ2Lv8vfEhRdmC9SkOHrJa4IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJyoekxqBQZbEWeFdg7CwZ+e+MQzmBqomgEFh+Sy5ASkKh8Kn0DjazGDbl2OEL4xtJ3dfVhWUUWyoJ4uFfNxzz4zIgwQ2SC9GIUJ0ccO+UaW786YUS1Imzn6TzSodK9pE8Glvdg1SABIUw2IdU5jqr3uA3IZ9J9rVuQNRXkbd8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LJT8UK6P; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <26cb5301-bd57-479c-a0f0-6358432ebe76@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766040439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgnE2xe37AzxWyG1yaIXIDiXwPO0Nq/LwU/ylHbGqVY=;
	b=LJT8UK6PLx+oLXsL45RfqvYfIXfwbvzSjWbvFf8jgUax/7jA8bUcn/KJVvaE+kN5ybda3q
	J2qX/P+YBi05KwGsbUYQRK36vsQPmmnoK6Fa7SezWvyMXQwdDR7aGLd0/OOpiKhXTvt0zq
	9vb+j87j2Vf2V73nPio2qdk2TwD+Z84=
Date: Thu, 18 Dec 2025 06:47:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: wangxun: move PHYLINK dependency
To: Arnd Bergmann <arnd@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251216213547.115026-1-arnd@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251216213547.115026-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/12/2025 21:35, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The LIBWX library code is what calls into phylink, so any user of
> it has to select CONFIG_PHYLINK at the moment, with NGBEVF missing this:
> 
> x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_nway_reset':
> wx_ethtool.c:(.text+0x613): undefined reference to `phylink_ethtool_nway_reset'
> x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_get_link_ksettings':
> wx_ethtool.c:(.text+0x62b): undefined reference to `phylink_ethtool_ksettings_get'
> x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_set_link_ksettings':
> wx_ethtool.c:(.text+0x643): undefined reference to `phylink_ethtool_ksettings_set'
> x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_get_pauseparam':
> wx_ethtool.c:(.text+0x65b): undefined reference to `phylink_ethtool_get_pauseparam'
> x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_set_pauseparam':
> wx_ethtool.c:(.text+0x677): undefined reference to `phylink_ethtool_set_pauseparam'
> 
> Add the 'select PHYLINK' line in the libwx option directly so this will
> always be enabled for all current and future wangxun drivers, and remove
> the now duplicate lines.
> 
> Fixes: a0008a3658a3 ("net: wangxun: add ngbevf build")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/wangxun/Kconfig | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
> index d138dea7d208..ec278f99d295 100644
> --- a/drivers/net/ethernet/wangxun/Kconfig
> +++ b/drivers/net/ethernet/wangxun/Kconfig
> @@ -21,6 +21,7 @@ config LIBWX
>   	depends on PTP_1588_CLOCK_OPTIONAL
>   	select PAGE_POOL
>   	select DIMLIB
> +	select PHYLINK
>   	help
>   	Common library for Wangxun(R) Ethernet drivers.
>   
> @@ -29,7 +30,6 @@ config NGBE
>   	depends on PCI
>   	depends on PTP_1588_CLOCK_OPTIONAL
>   	select LIBWX
> -	select PHYLINK
>   	help
>   	  This driver supports Wangxun(R) GbE PCI Express family of
>   	  adapters.
> @@ -48,7 +48,6 @@ config TXGBE
>   	depends on PTP_1588_CLOCK_OPTIONAL
>   	select MARVELL_10G_PHY
>   	select REGMAP
> -	select PHYLINK
>   	select HWMON if TXGBE=y
>   	select SFP
>   	select GPIOLIB
> @@ -71,7 +70,6 @@ config TXGBEVF
>   	depends on PCI_MSI
>   	depends on PTP_1588_CLOCK_OPTIONAL
>   	select LIBWX
> -	select PHYLINK
>   	help
>   	  This driver supports virtual functions for SP1000A, WX1820AL,
>   	  WX5XXX, WX5XXXAL.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

