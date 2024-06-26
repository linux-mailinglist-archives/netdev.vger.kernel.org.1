Return-Path: <netdev+bounces-107025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A081B918A29
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24DC1C23004
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0131F18FDC7;
	Wed, 26 Jun 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ny6xfVjl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248BE14532F;
	Wed, 26 Jun 2024 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423140; cv=none; b=S7bGzDNDcwjUtY89a1x51s7ij5t2R1Pvp7P/tz9kYY8S1i6FMCzWd2eWlMyYS+vT/pQ/GB62oUa/8CwjVtOCZdRrOjXDNIWYWNY6vCkJtf1pIv3nBWKqBZxgYCk/VEiD6Eu7U/2OqnR67Soy+kwKagbdCJYIhE5SxLfwviwxz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423140; c=relaxed/simple;
	bh=g3M9qq5WIiQ5+XT2FOnvuWrVwkbkFlUU30JxxnoL4gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndwLm/JMEF/DN7VtTxex/euUzJLzEDzZYpnwFJZbRmdRdjyM7keYOkO+/0c+e9S+xexvqBMtpn4UYMyR3MrfBlLVhNG2UVhs58060YZJTAtvbtktEgheieH/SbJC3sH6uW5Q/vRfdu0+ijFqQaspCbCcHStsFeopfQnIFsN9UDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ny6xfVjl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Asyx6kO5JxFxGPhIzsOJBUaJNZZe6zy3iTpvyHsXWKQ=; b=Ny6xfVjlKr/rBVETyIYZyYUT3S
	BIq7bSi2VNzid/d2B5nJaaTzqgDkkA9EvfQXFCDTqgFZ/5jDcvAt79fyT97q1T7ncHnDaoTs47sr1
	iSa4DM5HGIdQ2IWnp9yCihBQXz6MWKfMgQlFUaDoWNxhL6IGJ3aaaAhmJvynVQq85ovg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMWVB-0013ru-Cg; Wed, 26 Jun 2024 19:32:13 +0200
Date: Wed, 26 Jun 2024 19:32:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: phy_device: Fix PHY LED blinking code comment
Message-ID: <9656eb1a-921b-4f2e-b01f-7df7d890254e@lunn.ch>
References: <20240626030638.512069-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626030638.512069-1-marex@denx.de>

On Wed, Jun 26, 2024 at 05:06:17AM +0200, Marek Vasut wrote:
> Fix copy-paste error in the code comment. The code refers to
> LED blinking configuration, not brightness configuration. It
> was likely copied from comment above this one which does
> refer to brightness configuration.
> 
> Fixes: 4e901018432e ("net: phy: phy_device: Call into the PHY driver to set LED blinking")
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

There is a lot of context in this patch. Do you have some odd git diff
settings?

    Andrew

