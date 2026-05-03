Return-Path: <netdev+bounces-283537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AthCcLC9mlsYQIAu9opvQ
	(envelope-from <netdev+bounces-283537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 05:36:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C20A34B448A
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 05:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CB6B300A8C4
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 03:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9253283CAF;
	Sun,  3 May 2026 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WuwyskRF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B963CA52;
	Sun,  3 May 2026 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777779388; cv=none; b=pFf5IlZr3FbpuyBwPpi+LSa7cld40WCkvZvXJaV2ysLvmldR9Or7SQ4VGVxQ2c6mG67f/EbANvbdxoiYluzK3gAxVgWmrRebLNVXlJd2bzOw7mpPFPCrlpdBvu6TH5bIMONXAWH48P9O3zeC2/jeNc30K9jzDS3vit020jRAWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777779388; c=relaxed/simple;
	bh=16gE3Zmxvq9l/e+8Adas9Ssngs8xP2I/U10xr3qEPG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNfbkamFPbSKMu488z+7jkXQgfmIWce92+bu3OLZTh65hbcAi51dp1i7yxKLeK34L2KF3qnRUnEoiSl8IsLaOdOIzOvGG2TZloERhvzGIeMDXAIg6K/VtTQnI1Md8gSFtwTk24XhUAw1s/T1Rl1cc+1T6Xo7QMDiqHBXIJ7p8kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WuwyskRF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DTFRDFkycfQcVTewpGkLJugXa/JrmWlRAbcO2CAGRH4=; b=WuwyskRFKAttARx1y/Qw6F2PtQ
	VSfnmWsR0zwaG1mjFFG3zz5PfZxzNhLGqa3zB/gobKbU6K44LNuLmLWgx0dYnlvwjunAv1ocEbAK1
	1VM3StlIh5OepYjDOW/iiALrXM8pqTXJraGqgoPZ/efOcBUa35D9/Oe8I4QmCUt0JdIU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJNcr-0015Jc-HW; Sun, 03 May 2026 05:36:13 +0200
Date: Sun, 3 May 2026 05:36:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net: ethernet: adi: Add a driver for the
 ADIN1140 MACPHY
Message-ID: <afc1cf8d-4a02-430e-89a5-b213c15a4f70@lunn.ch>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-4-dd043cdd88f0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503-adin1140-driver-v1-4-dd043cdd88f0@analog.com>
X-Rspamd-Queue-Id: C20A34B448A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283537-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, May 03, 2026 at 02:24:53AM +0300, Ciprian Regus via B4 Relay wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> Add a driver for ADIN1140. The device is a 10BASE-T1S MAC-PHY
> (integrated in the same package) that connects to a CPU over an SPI bus,
> and implements the Open Alliance TC6 protocol for control and frame
> transfers. As such, this driver relies on oa_tc6 for the communication
> with the device. The device has an alternative name (AD3306), so the
> driver can be probed using one of the two compatible strings.
> 
> For control transactions, ADIN1140 only implements the protected mode.
> The driver has a custom implementation for the mii_bus access methods as a
> workaround for hardware issues:
> 
> 1. The OA TC6 standard defines the direct and indirect access modes for
>    MDIO transactions. The ADIN1140 incorrectly advertises indirect mode
>    only (supported capabilities register - 0x2, bit 9), while actually
>    implementing just the direct mode. We cannot rely on the CAP register
>    to choose an access method (which oa_tc6 does by default, even though
>    it only implements the direct mode), so the driver has to use its
>    own.
> 2. The ADIN1140 cannot access the C22 register space of the internal
>    PHY, while the PHY is busy receiving frames. If that happens, the
>    CONFIG0 and CONFIG2 registers of the MAC will get corrupted and the
>    data transfer will stop. Those two registers configure settings for
>    the transfer protocol between the MAC and host, so the value for some
>    of their subfields shouldn't be changed while the netdev is up.
>    Since we know the PHY is internal, the MAC driver can implement a
>    custom mii_bus, which can intercept C22 accesses. Most of the
>    registers mapped in the 0x0 - 0x3 range (the only ones the PHY offers)
>    are read only, and their value can be read from somewhere else (e.g
>    the PHYID 1 & 2 have the same value as 0x1 in the MAC memory map).
>    For the fields that are R/W (loopback and AN/reset) in the control
>    register, the PHY driver already implements the set_loopback() and
>    config_aneg() functions. The C22 write function of the driver is a
>    no-op and is used to protect against the ioctl MDIO access path.
>    C45 accesses do not cause this issue, so we can properly implement
>    them.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> ---
>  MAINTAINERS                         |   7 +
>  drivers/net/ethernet/adi/Kconfig    |  12 +
>  drivers/net/ethernet/adi/Makefile   |   1 +
>  drivers/net/ethernet/adi/adin1140.c | 805 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 825 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e58da5ef47a..f9784c25beac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1843,6 +1843,13 @@ S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/dma/dma-axi-dmac.c
>  
> +ANALOG DEVICES INC ETHERNET DRIVERS
> +M:	Ciprian Regus <ciprian.regus@analog.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	drivers/net/ethernet/adi/adin1140.c
> +
>  ANALOG DEVICES INC ETHERNET PHY DRIVERS
>  M:	Ciprian Regus <ciprian.regus@analog.com>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kconfig
> index 760a9a60bc15..bdb8ff7d15da 100644
> --- a/drivers/net/ethernet/adi/Kconfig
> +++ b/drivers/net/ethernet/adi/Kconfig
> @@ -26,4 +26,16 @@ config ADIN1110
>  	  Say yes here to build support for Analog Devices ADIN1110
>  	  Low Power 10BASE-T1L Ethernet MAC-PHY.
>  
> +config ADIN1140
> +	tristate "Analog Devices ADIN1140 MAC-PHY"
> +	depends on SPI
> +	select ADIN1140_PHY
> +	select OA_TC6
> +	help
> +	  Say yes here to build support for Analog Devices, Inc. ADIN1140
> +	  10BASE-T1S Ethernet MAC-PHY.
> +
> +	  To compile this driver as a module, choose M here. The module will be
> +	  called adin1140.
> +
>  endif # NET_VENDOR_ADI
> diff --git a/drivers/net/ethernet/adi/Makefile b/drivers/net/ethernet/adi/Makefile
> index d0383d94303c..0390ca8ccc49 100644
> --- a/drivers/net/ethernet/adi/Makefile
> +++ b/drivers/net/ethernet/adi/Makefile
> @@ -4,3 +4,4 @@
>  #
>  
>  obj-$(CONFIG_ADIN1110) += adin1110.o
> +obj-$(CONFIG_ADIN1140) += adin1140.o
> diff --git a/drivers/net/ethernet/adi/adin1140.c b/drivers/net/ethernet/adi/adin1140.c
> new file mode 100644
> index 000000000000..5bc3f5732ed8
> --- /dev/null
> +++ b/drivers/net/ethernet/adi/adin1140.c
> @@ -0,0 +1,805 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for Analog Devices, Inc. ADIN1140 10BASE-T1S MAC-PHY
> + *
> + * Copyright 2026 Analog Devices Inc.
> + */
> +
> +#include <linux/etherdevice.h>
> +#include <linux/kernel.h>
> +#include <linux/mdio.h>
> +#include <linux/module.h>
> +#include <linux/oa_tc6.h>
> +#include <linux/phy.h>
> +
> +#define ADIN1140_MMS_REG(m, r)	((((m) & GENMASK(3, 0)) << 16) |	\
> +				 ((r) & GENMASK(15, 0)))
> +
> +#define ADIN1140_MACPHY_ID_REG	ADIN1140_MMS_REG(0x0, 0x1)

This is not an ADIN1140 MACPHY_ID_REG, it is the TC6 PHYID register.

> +
> +#define ADIN1140_CONFIG0_REG		0x0004
> +#define ADIN1140_CONFIG0_TXFCSVE	BIT(14)
> +#define ADIN1140_CONFIG0_RFA_ZARFE	BIT(12)
> +#define ADIN1140_CONFIG0_CPS_64		GENMASK(2, 1)
> +
> +#define ADIN1140_CONFIG2_REG		ADIN1140_MMS_REG(0x0, 0x6)

This is not an ADIN1140 CONFIG2 register. It is the TC6 CONFIG2
register. 

Please add the TC6 registers to include/linux/oa_tc6.

	Andrew

