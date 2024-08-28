Return-Path: <netdev+bounces-122978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD2E963529
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58AF11C2176B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235E31AC8B2;
	Wed, 28 Aug 2024 23:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vbI9BDo5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACDE158DCD;
	Wed, 28 Aug 2024 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886318; cv=none; b=lMlMCiNnHgG45tXaq+kwwYy+hbldu2rJdepheQb6cfjIOwW2MAYaSHkNZmEPhS4uDsMY9evKP9qtyzddWo00JGopASFquXKjo87rh8Bg4ulfTiGCvVeXozXCX0BMfc9CnwC9TtPtdSQQb6SGW++NIzVIGoupvnfDPAlrtw+cIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886318; c=relaxed/simple;
	bh=llHts8eNjq0P0NBAG429dD9B8JX0dv2yxzxzDWhrfyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpToIKMNyt6otr13kg82idiFc+9MjP9nm5fdhNBoTdeD7I8Thew1Pp7uXD3Uudg+NpJ91phUE3rZwCt8y2RQDM4xYKeQuT8HU+EZ4SYYnm+tWJ/SvSImq/JlGJU0rdV5mEnabuzynizJ3TwKjik9xrrp+2nBw/0l6nVtqQO6YQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vbI9BDo5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T2M/0J58JB0YRsETocA8T7qG6Z8ibgdVe/L0GaWjXjE=; b=vbI9BDo54PDvk0yL9yvSBRRlo9
	W8L3dNzG0X1dDt7AB2sbG7UEZjEigo4P2HeJ7I0TX+wCNw1CM/F/MDmigRwqFDsc9wDUIs7fw3sj6
	u3FV74+RVEIEXc+sQUMeBbYGGT/MP4rekxso+dogvak9coiLy15H+HY0fyMQQt91c73A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjRim-005yiR-N9; Thu, 29 Aug 2024 01:05:00 +0200
Date: Thu, 29 Aug 2024 01:05:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: aquantia: allow forcing order
 of MDI pairs
Message-ID: <afca2465-3e42-4bf1-8f07-13e15e9ed773@lunn.ch>
References: <1cdfd174d3ac541f3968dfe9bd14d5b6b28e4ac6.1724885333.git.daniel@makrotopia.org>
 <e56a9065f50cd90d33da7fe50bf01989adc65d26.1724885333.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e56a9065f50cd90d33da7fe50bf01989adc65d26.1724885333.git.daniel@makrotopia.org>

On Wed, Aug 28, 2024 at 11:52:09PM +0100, Daniel Golle wrote:
> Despite supporting Auto MDI-X, it looks like Aquantia only supports
> swapping pair (1,2) with pair (3,6) like it used to be for MDI-X on
> 100MBit/s networks.
> 
> When all 4 pairs are in use (for 1000MBit/s or faster) the link does not
> come up with pair order is not configured correctly, either using
> MDI_CFG pin or using the "PMA Receive Reserved Vendor Provisioning 1"
> register.
> 
> Normally, the order of MDI pairs being either ABCD or DCBA is configured
> by pulling the MDI_CFG pin.
> 
> However, some hardware designs require overriding the value configured
> by that bootstrap pin. The PHY allows doing that by setting a bit in
> "PMA Receive Reserved Vendor Provisioning 1" register which allows
> ignoring the state of the MDI_CFG pin and another bit configuring
> whether the order of MDI pairs should be normal (ABCD) or reverse
> (DCBA). Pair polarity is not affected and remains identical in both
> settings.
> 
> Introduce two mutually exclusive boolean properties which allow forcing
> either normal or reverse order of the MDI pairs from DT.
> 
> If none of the two new properties is present, the behavior is unchanged
> and MDI pair order configuration is untouched (ie. either the result of
> MDI_CFG pin pull-up/pull-down, or pair order override already configured
> by the bootloader before Linux is started).
> 
> Forcing normal pair order is required on the Adtran SDG-8733A Wi-Fi 7
> residential gateway.

Is there an in-tree dts file for this? We like to see that options
which are added are actually used.

      Andrew

