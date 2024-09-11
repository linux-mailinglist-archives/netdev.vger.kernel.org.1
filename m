Return-Path: <netdev+bounces-127501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BC397596F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C94282245
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91AF1B150D;
	Wed, 11 Sep 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G0Z4rkox"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641131AC8BE;
	Wed, 11 Sep 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075874; cv=none; b=X1kuh0G0Qnn602a60enEGvcl2HQIj8iQQG4RRD5WKw5wFzoOgQ8hNVOZnDhIiP8RbNxbXvnIm9Sg6J+vUHilR++K3RRwW3i+rljaNCf679F8FgI51GkV2r86pA4U5NTvkVDW+efU9EipAx1SLQ20x/G88Z1mDyKd1wXTSRLL3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075874; c=relaxed/simple;
	bh=mRaM2t/rbSGkrMbtS9n67rdf9rDIXKRWk+ETwGowD/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA7ZMT7M5whAxqevgW77o3QUg7weSc+HS1RAyNpjdVZhY4r1lV6QPSxye2syp8x3QUtftoTqLApvA0SmTWU9qHo2+nS74GPjDfbmaAkTUfz2ZaDze5EU1p2pLvkY4q2e0k0zL4MuhwDZsc7UwSLgBqoanfNsa1N0Bew/tH6da64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G0Z4rkox; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L1XCqinyQGPfUahG7TVwCefg+V1JXC5HVaYEwdzrGj4=; b=G0Z4rkoxlxkluExA04hB0+09fW
	mU1GHVNAjEBEn+RkVSUrBC/w79bYCQPsuhzal/EYYVDJmlIVImYWtzb+hbuFZ9hr3GYVIS3VxhNKL
	2LOX3XcOhDOk8HX4NCqRyh/cBFKUBObaI0jsRTQijOM1As7wsEv5UqK7ROH0+rgvhamk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soRBF-007Eov-Sn; Wed, 11 Sep 2024 19:31:01 +0200
Date: Wed, 11 Sep 2024 19:31:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, rdunlap@infradead.org,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 5/5] net: lan743x: Add Support for 2.5G SFP
 with 2500Base-X Interface
Message-ID: <82067738-f569-448b-b5d8-7111bef2a8e9@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-6-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911161054.4494-6-Raju.Lakkaraju@microchip.com>

> @@ -3359,6 +3362,7 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
>  	lan743x_phy_interface_select(adapter);
>  
>  	switch (adapter->phy_interface) {
> +	case PHY_INTERFACE_MODE_2500BASEX:
>  	case PHY_INTERFACE_MODE_SGMII:
>  		__set_bit(PHY_INTERFACE_MODE_SGMII,
>  			  adapter->phylink_config.supported_interfaces);

I _think_ you also need to set the PHY_INTERFACE_MODE_2500BASEX bit in
phylink_config.supported_interfaces if you actually support it.

Have you tested an SFP module capable of 2500BASEX?

	Andrew

