Return-Path: <netdev+bounces-45749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B77DF59B
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 16:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49E51C20F35
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19F11BDE2;
	Thu,  2 Nov 2023 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ikcgjN67"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581971B29E;
	Thu,  2 Nov 2023 15:03:56 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37B718B;
	Thu,  2 Nov 2023 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O+sDd6BIqD7/T4iz8epXXGIsz006xpgyEhdsjBsc25M=; b=ikcgjN67fIx8DAR/kdecyTu6c8
	tBQ+pr+I416gvEST/6hFYJ6oQ5YwZ1VU0sJtZtXupz1r70wLWXUnS2gybH8OYGmcW0p+U4Mkf/tLh
	0d1cbMbnU2efyF/ATc9qpQzsF+wGiYJyBOrtwdWCLEduNH3yf/x6zztJyfs+S1Dl1+HU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qyZEL-000l7X-Jn; Thu, 02 Nov 2023 16:03:33 +0100
Date: Thu, 2 Nov 2023 16:03:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 1/4] net: phy: aquantia: move to separate
 directory
Message-ID: <5f60b2dc-4e97-49dc-8427-306400fb1b71@lunn.ch>
References: <20231102150032.10740-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102150032.10740-1-ansuelsmth@gmail.com>

> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 421d2b62918f..4b2451dd6c45 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -68,6 +68,8 @@ config SFP
>  
>  comment "MII PHY device drivers"
>  
> +source "drivers/net/phy/aquantia/Kconfig"
> +
>  config AMD_PHY
>  	tristate "AMD and Altima PHYs"
>  	help
> @@ -96,11 +98,6 @@ config ADIN1100_PHY
>  	  Currently supports the:
>  	  - ADIN1100 - Robust,Industrial, Low Power 10BASE-T1L Ethernet PHY
>  
> -config AQUANTIA_PHY
> -	tristate "Aquantia PHYs"
> -	help
> -	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
> -

Does this move the PHY in the make menuconfig menu? We try to keep it
sorted based on the tristate string.

       Andrew

