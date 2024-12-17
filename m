Return-Path: <netdev+bounces-152632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3495A9F4EE5
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E086163AA4
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39991F6695;
	Tue, 17 Dec 2024 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YVth3anL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829B1F668D;
	Tue, 17 Dec 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448169; cv=none; b=UZ3q0AJO4fTkSpl5ONYZXJALKpymN+A1YdF+CVsLtBRGJ3k1p0QJHjaE+iw5Gcmo4PP3L8ymcP4SgzlPADh9QNnJJBT7jvD/S5o+KSkUEl/zCqFB1CHkIDc3Rk26DtFPZSS6WMjOmi0091nC3Oo7Z+u3PuUvHOcJykwKGobE2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448169; c=relaxed/simple;
	bh=w8hwC3U5jEWNrrqusUKhOAOj0b0suERE4RAZJLKNe6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZNUyDGfhn/SIPNAArhtAzZ372TE/ZM81V00FcVH4LV0mh2oUGT1KUnkUsbe5dXxsUzJTPO9y00x1hNy2dH177SMUitHHUQfQRHkWM4l8RDgsJxBgWUoVZkP68n+8w7gfWMikwUn/4+u7UFsTDeFdc/vC4AChdyHVxw+fcxnABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YVth3anL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cJ1C8zxr1Pd/IF0oEXnzTSz2bWW66ZYhVUTgfnPs34s=; b=YVth3anLtSOEB/LoxI7i9gA8Ox
	OhzSCNCf/ZNbRwYwz6+fhbJw/DJttAf1C91sBC5s13Imzaptc82njZmWmHPE2Gg2lBhBAyr21oPkv
	3nlTPe7uYNBg5gFZ82QvHCTJjI5XjAONzl86jLQApiDzXR3t70f3QGj05hIrVsc6dWXA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNZCJ-000z3f-GZ; Tue, 17 Dec 2024 16:09:19 +0100
Date: Tue, 17 Dec 2024 16:09:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v7 4/5] net: phy: Makefile: Add makefile support
 for rds ptp in Microchip phys
Message-ID: <bac2f8b7-d224-42c8-aaa3-ed6f55fe67df@lunn.ch>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
 <20241213121403.29687-5-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213121403.29687-5-divya.koppera@microchip.com>

> @@ -80,6 +80,7 @@ obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
>  obj-$(CONFIG_MICREL_PHY)	+= micrel.o
>  obj-$(CONFIG_MICROCHIP_PHY)	+= microchip.o
>  obj-$(CONFIG_MICROCHIP_T1_PHY)	+= microchip_t1.o
> +obj-$(CONFIG_MICROCHIP_PHY_RDS_PTP)	+= microchip_rds_ptp.o
>  obj-$(CONFIG_MICROCHIP_T1S_PHY) += microchip_t1s.o
>  obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/
>  obj-$(CONFIG_MOTORCOMM_PHY)	+= motorcomm.o

If you need to respin, please insert this library in alphabetic
order. But it is O.k. as is if there is no need to respin.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

