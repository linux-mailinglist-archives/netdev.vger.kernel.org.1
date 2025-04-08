Return-Path: <netdev+bounces-180368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AFCA81145
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 156FC7AB90A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12CF22F145;
	Tue,  8 Apr 2025 15:59:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9618522CBCC;
	Tue,  8 Apr 2025 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127946; cv=none; b=Dc+ZKX+P6QIqe03KPnJWOUfNXlQ0FW1cfzMxOzkSAfYHpGyLz7vmm0YEbUNI2b8uAaiXuM3B4rVE1EH3+of4P7KhqtbN2fzHlGREIO5jhXSGoMstsdh/Ym5HD+svCI4PRre3mzM+DHZz1rRFEa+SOXMxEJkV60ws+Xhdu44vCiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127946; c=relaxed/simple;
	bh=bvEpywJ78FYfk9dzJS3R8rHsthJ1q3NQt8iEloMCFGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpkjAX0d1jnioBJU7PyT50nPoNW7OAsI/L/mtlk0vweNeWQAi8EueTJex+06wLEU41GASQogI1YPtPyVT6FV54DYM8G7eJkDzL3X/KsbKvmzCOrlGnfk90owhvLPR5xZrtXhMaqD8UAhGR+TZWNcLgRZ+5k20cvOQc22dgRjZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u2BLa-000000000U3-0ZJW;
	Tue, 08 Apr 2025 15:58:46 +0000
Date: Tue, 8 Apr 2025 16:58:39 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.or
Subject: Re: [net-next PATCH 1/2] net: phy: mediatek: permit to compile test
 GE SOC PHY driver
Message-ID: <Z_VHr8ub-uXJy53y@makrotopia.org>
References: <20250408155321.613868-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408155321.613868-1-ansuelsmth@gmail.com>

On Tue, Apr 08, 2025 at 05:53:13PM +0200, Christian Marangi wrote:
> When commit 462a3daad679 ("net: phy: mediatek: fix compile-test
> dependencies") fixed the dependency, it should have also introduced
> an or on COMPILE_TEST to permit this driver to be compile-tested even if
> NVMEM_MTK_EFUSE wasn't selected. The driver makes use of NVMEM API that
> are always compiled (return error) so the driver can actually be
> compiled even without that config.
> 
> Fixes: 462a3daad679 ("net: phy: mediatek: fix compile-test dependencies")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Acked-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/phy/mediatek/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
> index 2a8ac5aed0f8..c80b4c5b7b66 100644
> --- a/drivers/net/phy/mediatek/Kconfig
> +++ b/drivers/net/phy/mediatek/Kconfig
> @@ -16,7 +16,7 @@ config MEDIATEK_GE_PHY
>  config MEDIATEK_GE_SOC_PHY
>  	tristate "MediaTek SoC Ethernet PHYs"
>  	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
> -	depends on NVMEM_MTK_EFUSE
> +	depends on NVMEM_MTK_EFUSE || COMPILE_TEST
>  	select MTK_NET_PHYLIB
>  	help
>  	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
> -- 
> 2.48.1
> 

