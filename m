Return-Path: <netdev+bounces-157221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A72A097B7
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3BF6188951D
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E345212FA9;
	Fri, 10 Jan 2025 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Oyf8g//k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18F20DD76;
	Fri, 10 Jan 2025 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527463; cv=none; b=cCWjxJa2Q8vx1eSaQgBHWKHsKFd90MJJQylsrenQoFv5rKHWvqVZTzI2Fy/ShdQkwZKgQjKNMk0Gql4hS/GfNpBMzDeBwcz9uZ2bvYyvYcgYuDrevFqRATLgw3EqiP37dYVH0fHamfLr+reY8ccPOXmMZLStSUJk3X5koAMao24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527463; c=relaxed/simple;
	bh=jOb3ATLZ95lU2Sn9JaRxyAXZq9gOTu88Prxrg2mmMdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+3ZJplipXMYT2ExCCSemUr/j95+/UxKdvjcKETC2i2nGnjvnuao771xaQwYvUzYX2juFVyGtMVUVtghi7Vcyal8x+t4yiflOhB5xOSC5NVAHxye5r0IyHSq0ZqCznGTP91qW2Gjd0ljkIS4QhiO8Xe5tJNaklTTutLTbJ2Qay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Oyf8g//k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aJNNzaCoHVVgUyOzZq3DcWyldWKaRjr8GGgLzYXhOZg=; b=Oyf8g//kEDXm+Dmpyxk/UMR2ba
	iW84vOWa5YM5VLG3cw37U8kNekr7DHtAQswJq+B5WJt8KDt9eF0+UiVqRUxc3sYoJbHQhm4TX1D4/
	QNcB43sztoWXOPrnF7KIymHi/sajBmQuYDJU6WJJUW/uwlcxrmYpZu4GK7ZEf5S1NIuQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWI7K-003IFm-EU; Fri, 10 Jan 2025 17:44:14 +0100
Date: Fri, 10 Jan 2025 17:44:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2] net: phy: dp83822: Add support for PHY LEDs
 on DP83822
Message-ID: <2bf9b881-542b-449a-a405-ae8c45696da5@lunn.ch>
References: <20250107-dp83822-leds-v2-1-5b260aad874f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107-dp83822-leds-v2-1-5b260aad874f@gmail.com>

On Tue, Jan 07, 2025 at 09:23:04AM +0100, Dimitri Fedrau wrote:
> The DP83822 supports up to three configurable Light Emitting Diode (LED)
> pins: LED_0, LED_1 (GPIO1), COL (GPIO2) and RX_D3 (GPIO3). Several
> functions can be multiplexed onto the LEDs for different modes of
> operation. LED_0 and COL (GPIO2) use the MLED function. MLED can be routed
> to only one of these two pins at a time. Add minimal LED controller driver
> supporting the most common uses with the 'netdev' trigger.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

