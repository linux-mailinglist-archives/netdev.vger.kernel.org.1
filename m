Return-Path: <netdev+bounces-116877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75994BEDB
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1AF2822BE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CE118E023;
	Thu,  8 Aug 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4OS2izXV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839118C33B;
	Thu,  8 Aug 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125257; cv=none; b=b5cJLVfU3ryjXvbAh0GWLXom4wFAmbcJoxwvKgrV4CA/3WeTxy2PqTWmYtcjyj/oAEsEKuD6cq2kdw2fgWIvYoN7wd2bqQ2UGTGZmMP3Dx+/4Ryt7WbKvSX2oE4LQKmVFwnwQEDLMT+K0zs+9f4BwRYl1dU+QnANCznKSILd/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125257; c=relaxed/simple;
	bh=GBv+W7DAAm8Buil6jNH7Qw4hgUZ1tJDOjBhJRBpxU84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7IH4gSiBbHx4uocG3rw+Lv6FyylXXRw+m6EP2772jPBxwquW/iLlydaH9qYdkZdPsZcvrk8nKycN3hpr/O89SuIcY5sFihkuhBywmxlt/MN/mAAVRP03TqtWQRwFoSlL82wuNG15gPzMUn0+yPPWUSRUY1Uj9DQiH8dCGayWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4OS2izXV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=58zN4ftIxRNizhrHrvEhTFzHNJy4lJZ8+V2vqdEUlIQ=; b=4OS2izXVHrJYIiUEUbwfrHUQrq
	/LS1cpO8mZGTk+ZgINWM4JhQzv8iTVnKDSkOl2Oh86hR6NZv65i6gvQOP1VObBP8bJq8IJbbQpWYd
	RRdtAAOi4Z2lxKk2PCnvQOCaCbgbm+UnYrU4TJm7MdtomXBUfFCfeepQOhNgOZkJoOtQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sc3ag-004ICJ-Do; Thu, 08 Aug 2024 15:54:06 +0200
Date: Thu, 8 Aug 2024 15:54:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] phy: Add Open Alliance helpers for the
 PHY framework
Message-ID: <eab136c5-ef49-4d4e-860c-c56840747199@lunn.ch>
References: <20240808130833.2083875-1-o.rempel@pengutronix.de>
 <20240808130833.2083875-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808130833.2083875-2-o.rempel@pengutronix.de>

On Thu, Aug 08, 2024 at 03:08:32PM +0200, Oleksij Rempel wrote:
> Introduce helper functions specific to Open Alliance diagnostics,
> integrating them into the PHY framework. Currently, these helpers
> are limited to 1000BaseT1 specific TDR functionality.

Thanks for generalising this code.

> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/Makefile                |  2 +-
>  drivers/net/phy/open_alliance_helpers.c | 70 +++++++++++++++++++++++++
>  include/linux/open_alliance_helpers.h   | 47 +++++++++++++++++

We don't have any PHY drivers outside of drivers/net/phy, and i don't
see any reason why we should allow them anywhere else. So please
consider moving the header file into that directory, rather than
having it global.

>  ifdef CONFIG_MDIO_DEVICE
> diff --git a/drivers/net/phy/open_alliance_helpers.c b/drivers/net/phy/open_alliance_helpers.c
> new file mode 100644
> index 0000000000000..eac1004c065ae
> --- /dev/null
> +++ b/drivers/net/phy/open_alliance_helpers.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * open_alliance_helpers.c - OPEN Alliance specific PHY diagnostic helpers
> + *
> + * This file contains helper functions for implementing advanced diagnostic
> + * features as specified by the OPEN Alliance for automotive Ethernet PHYs.
> + * These helpers include functionality for Time Delay Reflection (TDR), dynamic
> + * channel quality assessment, and other PHY diagnostics.
> + *
> + * For more information on the specifications, refer to the OPEN Alliance
> + * documentation: https://opensig.org/automotive-ethernet-specifications/

Please could you give a reference to the exact standard. I think this
is "Advanced diagnostic features for 1000BASE-T1 automotive Ethernet
PHYs TC12 - advanced PHY features" ?

The standard seem open, so you could include a URL:

https://opensig.org/wp-content/uploads/2024/03/Advanced_PHY_features_for_automotive_Ethernet_v2.0_fin.pdf

	Andrew

