Return-Path: <netdev+bounces-203696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A4EAF6C82
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145AA1BC7020
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959092C08D6;
	Thu,  3 Jul 2025 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z6bhtbg7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9642C08A1;
	Thu,  3 Jul 2025 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530295; cv=none; b=aePAnTojNx6LcvEafeF4T/u/U8DeEYyqFTD5hldk3/oexFdu28OZbx8LKvxwS1LiBJiSp6TiYWfEHqwrmPfwKg1ERHzdQCNpaom+t3n53CPZFoi2T3h/7kg9iTYIXjFdkRDMzDwdZRiYW+eqrBk2MfKzgjTVhL1s8hRt5giOZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530295; c=relaxed/simple;
	bh=OG7N8hCpaNHrbu6mip5X8jEqLISFL4xZLo5itmyDMSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOgdCuLcBtd9XeW4FRQlzRltoyCG6JZGSThnqZe741iNlT6fpQ9Pbd3ZHqrdlQQq/37RxmTom0ujKqFCPGUNggazssQt1vjLlpyyUz6zUAig6ncAzT605bLoZf0qyyZESLQSC5FQ9zyXr6qaGhv9OgRFDnRfFB530AhVta2SOlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z6bhtbg7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+7q+U+33ibb+XOw945zAHKjFwr1papFiJIxdAK30AAI=; b=Z6bhtbg7hVOGO4WGll0htd7dk9
	jQS95+cK5RUK1VWmzYFL6wi+kr/Bt6CwjKKYsK7YDpnBMHvF85fOdAhL0Sjfp9FfUhAglu3dLKFlY
	GMFfAVni/vdRtGtxP4ULSfoQS+8WJpPTnRGjjHG+bhFL/8AYkfaVw4oBgwh0xuyxZVHM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXF2R-0004bO-0z; Thu, 03 Jul 2025 10:11:23 +0200
Date: Thu, 3 Jul 2025 10:11:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next] net: usb: lan78xx: stop including phy_fixed.h
Message-ID: <249be664-7faf-44a3-9d87-0c61df794abe@lunn.ch>
References: <626d389a-0f33-4b45-8949-ad53e89c36f5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626d389a-0f33-4b45-8949-ad53e89c36f5@gmail.com>

On Thu, Jul 03, 2025 at 07:49:12AM +0200, Heiner Kallweit wrote:
> Since e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved
> PHY and MAC management") this header isn't needed any longer.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

