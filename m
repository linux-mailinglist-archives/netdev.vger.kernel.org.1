Return-Path: <netdev+bounces-216064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE39B31D68
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B071CE7155
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C053C33CE88;
	Fri, 22 Aug 2025 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a6X3SpP1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A533A017;
	Fri, 22 Aug 2025 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874731; cv=none; b=uwhOMAZUSZHCKs9yLZF6gNuB+TshbeWKxQwjKuLjEdcJr44Zjmq5CN2kFPLj8ai81xI9F1ZO58QmaOQOOwvyHOk5Nb8Bnjrf4hF55TXM0oqF9wYps1c8GAnjktP6GziMQeag/j7/lA50Xa+k5KCRYdALxjwKVeb1mDLL1G3YZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874731; c=relaxed/simple;
	bh=plRxkTMh5Z39UbxuFVkxtwfnP2adp6rEyti1GEBuxUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdjchqvqqyeN6rt+q5OU033loCc90ynWgNnlvTbgmeZs30CKBkgpQA5iJqwecdfEO0yo5N8LnaA2kTbr4zOkjFh3l+NGQ5ieuymz99mnO0B1CL1h+YN6PmUAlhZG/ltK3NKvv0bS9ejOAF1fkfy4bdg2OXOQ/6se/FPJUO6lE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a6X3SpP1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=URE+D0su0VrFUP7J2zinaAZYCW+u5ytWrsWx4Tu1kSM=; b=a6X3SpP1CYO6BFEjd1MVrQR8n8
	XaLu9Y7G4b3T/ocEmHIea4xVFgcCk3hQjE5OFc8navQIH0k3Gty98oGsMTgWaGM8gOkENWerVKQqu
	0BbHxjVdSo0EYbHm8qYwJa13ANfz8L955a2QljUJ2iw8NjFzO3PNcSY5jRvRL/EubTxc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upTE5-005ai6-NZ; Fri, 22 Aug 2025 16:58:45 +0200
Date: Fri, 22 Aug 2025 16:58:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jack Ping CHNG <jchng@maxlinear.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, davem@davemloft.net,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, yzhu@maxlinear.com,
	sureshnagaraj@maxlinear.com
Subject: Re: [PATCH net-next 1/2] net: maxlinear: Add build support for MxL
 SoC
Message-ID: <610db76b-7327-4331-888e-e538857c0887@lunn.ch>
References: <20250822090809.1464232-1-jchng@maxlinear.com>
 <20250822090809.1464232-2-jchng@maxlinear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822090809.1464232-2-jchng@maxlinear.com>

> +Driver Location
> +===============
> +
> +The driver source code is located in the kernel tree at:
> +  drivers/net/ethernet/maxlinear/
> +
> +Interfaces are created as standard Linux `net_device` interfaces:

Pointless comment. Anything else would be NACKed.

> +
> +- eth0, eth1 (up to 2)

This is also questionable. Yes, the kernel will give them names like
this, but systemd will then rename them.

> +- Multiqueue support (e.g., eth0 has multiple TX/RX queues)
> +
> +Kernel Configuration
> +====================
> +
> +The driver is located in the menu structure at:
> +
> +  -> Device Drivers
> +    -> Network device support
> +      -> Ethernet driver support
> +        -> MaxLinear NPU Ethernet driver
> +
> +Or set in your kernel config:
> +  CONFIG_NET_VENDOR_MAXLINEAR=y
> +  CONFIG_MAXLINEAR_ETH=y
> +
> +Maintainers
> +===========
> +
> +See the MAINTAINERS file:
> +
> +    MAXLINEAR ETHERNET DRIVER
> +    M: Jack Ping Chng <jchng@maxlinear.com>
> +    L: netdev@vger.kernel.org
> +    S: Supported
> +    F: drivers/net/ethernet/maxlinear/
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bce96dd254b8..9164ba07a9c3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15101,6 +15101,13 @@ W:	https://linuxtv.org
>  T:	git git://linuxtv.org/media.git
>  F:	drivers/media/radio/radio-maxiradio*
>  
> +MAXLINEAR ETHERNET DRIVER
> +M:	Jack Ping Chng <jchng@maxlinear.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/networking/device_drivers/ethernet/maxlinear/*
> +F:	drivers/net/ethernet/maxlinear/
> +
>  MAXLINEAR ETHERNET PHY DRIVER
>  M:	Xu Liang <lxu@maxlinear.com>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index f86d4557d8d7..94d0bb98351a 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -33,6 +33,7 @@ source "drivers/net/ethernet/aquantia/Kconfig"
>  source "drivers/net/ethernet/arc/Kconfig"
>  source "drivers/net/ethernet/asix/Kconfig"
>  source "drivers/net/ethernet/atheros/Kconfig"
> +source "drivers/net/ethernet/maxlinear/Kconfig"

This file is sorted. Please insert in the correct location. Please
check all your other insertions.

> +
> +	snprintf(ndev->name, IFNAMSIZ, "eth%%d");

The core does that.

> +static int mxl_eth_probe(struct platform_device *pdev)
> +{
> +	struct mxl_eth_drvdata *pdata;

Historically, pdata has been used for platform_data. With the adoption
of DT, platform_data is not used much any more, but to greybeards like
me, i still read it as platform_data. More normal would be priv, or
maybe in this case drvdata, since the structure is called
mxl_eth_drvdata.

	Andrew

