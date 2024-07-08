Return-Path: <netdev+bounces-109899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C8792A394
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14681F2299B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C813137747;
	Mon,  8 Jul 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FUeYDHlh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3BB665;
	Mon,  8 Jul 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445141; cv=none; b=bLUV0+/gYFprC8NRa8HWcz917lxBO+W+c6s0P1rzdw67rS4IbjmwwIjvvnNUZNOll6WuY2fcDbOm1mRQPuE3fY+7Pv62wDnQuBSlYiUobbLWbdz4bdlwsFW1RzZHjWPBFNmXDa5b9SrkU3/qI/5uXArWfeJ6JCc76iTlZkHEg8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445141; c=relaxed/simple;
	bh=CYj1Ybx6t2iGxmKAZ54frfKFPPj73fHUwkFj1GbZgdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnUqHMD9Wa0h93z3KnFTMZO5Tmu+GMiWH9qy+ZUWcdZPIphv15idMTeZotQkUn33ea1VMZVs7cahaU6rsoPPU1RW6p/H3tYlQvfMJb2cUJXintRcn1BDmqKWMDZowwBTvPRKqNGpfb2UJh7zvrEwsr6NZV1ZbCodt3cBn0xR9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FUeYDHlh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=laITuNh73iVRXKx7d8BglANnChNAN0iqcf937i6d+kM=; b=FUeYDHlhXG1LT2sQIVtY+VCXCd
	A5ETYQ56hVG1kTR78TaczRocUTaw6I6UKohgpLUbkBFOnup2c35glnGH/lLvWGnFvYIQkZFBvm8MN
	VjG5MZKFnyPgqN7PqBT8N5MXNv2RPTcYpzI+I8UuqNiSKUM+CTwUKQSzegp6ifKl4h7o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sQoN1-0022hq-Ow; Mon, 08 Jul 2024 15:25:31 +0200
Date: Mon, 8 Jul 2024 15:25:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: qcom-ethqos: enable SGMII
 loopback during DMA reset on sa8775p-ride-r3
Message-ID: <acc4ebc7-9c82-45a7-ae22-bdf927dd0317@lunn.ch>
References: <20240703181500.28491-1-brgl@bgdev.pl>
 <20240703181500.28491-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703181500.28491-3-brgl@bgdev.pl>

On Wed, Jul 03, 2024 at 08:14:59PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> On sa8775p-ride-r3 the RX clocks from the AQR115C PHY are not available at
> the time of the DMA reset. We can however extract the RX clock from the
> internal SERDES block. Once the link is up, we can revert to the
> previous state.
> 
> The AQR115C PHY doesn't support in-band signalling so we can count on
> getting the link up notification and safely reuse existing callbacks
> which are already used by another HW quirk workaround which enables the
> functional clock to avoid a DMA reset due to timeout.
> 
> Only enable loopback on revision 3 of the board - check the phy_mode to
> make sure.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

