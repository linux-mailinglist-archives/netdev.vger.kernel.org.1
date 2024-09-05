Return-Path: <netdev+bounces-125537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4095196D994
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA6E1F27FA0
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633DF199E95;
	Thu,  5 Sep 2024 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zvD7G6ig"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F11CFBC;
	Thu,  5 Sep 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541225; cv=none; b=K4TWCwDhshMncyTiFmUja0h5BSWskAm0MxCgSg3QXfOXt8OwwaXBolxEzGmXmNmEnJwdaTr1/4/aBZOnyzHwvz41aQxqZChH3brjkepy4eGuu3Hh/rvvSIrn6sMslR/6PiFWZkl02iT9eTWL9PBAEqhqMWcrDVjUClomJzQ6mWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541225; c=relaxed/simple;
	bh=RYPJ9QX2JdbNsNVXYiRNiK0qzxXao8kCQrM9DyzSAt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mj3C1fF6ZNey//64I39gtaQUiQy7/HfnxHIqSlpeaL3QWIdjOJLKpFia0q/gpEUouUdbbCBl7wplzt7tn+e0KwJUlCgV2VxyBab1OCaTkmr/KgtpjdlYr4ib9uhOPcRwZiKV5qF9cUYgdtJTPjm1FJ3QyN1CPX9YdTMiwbOR0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zvD7G6ig; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lf5SCBqAJ/1V/BvjePNsgl0afk21tcT67kmnLdABL8Y=; b=zvD7G6ig5Ji8K7gZS10IAJUmit
	GuzmGR7HEB8nnIlb/fCVoM323P88gng1dRuMiD2mw3eW85UHTQOHDHBH/x6e7cF5mzbyVTHnYUr9I
	/+xFmMTip2g2BZasBvZ1wSxpgxEsBeGBIxKHGYG0sAlAv2zk8idi47BOKxu+refF2sBQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smC5t-006g80-6h; Thu, 05 Sep 2024 15:00:13 +0200
Date: Thu, 5 Sep 2024 15:00:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux@armlinux.org.uk,
	kuba@kernel.org, hkallweit1@gmail.com, richardcochran@gmail.com,
	rdunlap@infradead.org, bryan.whitehead@microchip.com,
	edumazet@google.com, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, linux-kernel@vger.kernel.org,
	horms@kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V5 5/5] net: lan743x: Add support to ethtool
 phylink get and set settings
Message-ID: <9fa0bd86-6c5c-4056-8538-f4eabfa44845@lunn.ch>
References: <20240904090645.8742-1-Raju.Lakkaraju@microchip.com>
 <20240904090645.8742-6-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904090645.8742-6-Raju.Lakkaraju@microchip.com>

On Wed, Sep 04, 2024 at 02:36:45PM +0530, Raju Lakkaraju wrote:
> Add support to ethtool phylink functions:
>   - get/set settings like speed, duplex etc
>   - get/set the wake-on-lan (WOL)
>   - get/set the energy-efficient ethernet (EEE)
>   - get/set the pause
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

