Return-Path: <netdev+bounces-113309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC24293DA1C
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 23:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882B2284F80
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 21:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F37558B7;
	Fri, 26 Jul 2024 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LTtkF4sj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E375E1CA80;
	Fri, 26 Jul 2024 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722028552; cv=none; b=KpysdNSzvxIItxr1dDGXOKWlKeYjAIJFCSPzXC5tulWMCikqaxruel3gbfXSK7RKzB1N27BodetSLjvsIl9bOIiiwmMcktOn5PrreM6CVfIRWaGck7c2PDz8LDsJ++tDpIptWre7u7QOULK/DwoYrgakYPx0ivIpcelCyaeSe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722028552; c=relaxed/simple;
	bh=kFm1nFe/8mj73uBWAJ1mzHAKbs/jN0UTqZt+QE4QUbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ9J86C3+T38CaYx9WaIDkFY2ekEgNKSOW7YNQGPuc9i1IrF5IjEisRfw4BjpxeInBVv0uerWJ57MiQpn5JUnA8epaW7YsQm1pJYRlLpY3uOLMQFUN6cpkSp64oc+4IE+Pi7S53cIXBnEfQVqy9KLqqruQOXIYdShmncPv3zQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LTtkF4sj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=evJaG3qBPauXhpE79CCjKBWlGY0IN5mOJLlNHK9YetM=; b=LTtkF4sj+sf/XzVbP4GIBbZPbQ
	mpm9oFdxV9VpeUcQYVlA7NoUeDyjHu2wOMLSsBD1DTMxRuokg8b6sn4Dsi1gcn7aWzXC2HEnmMgVu
	rtWcKdw4CBztJ+0TEbv9jvwfxC/fYxQ6Y+QOzYffG+cghWsNzurSpdiubwlze7w8fOtk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sXSHv-003JDT-Ay; Fri, 26 Jul 2024 23:15:43 +0200
Date: Fri, 26 Jul 2024 23:15:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	UNGLinuxDriver@microchip.com, davem@davemloft.net,
	edumazet@google.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	lucas.demarchi@intel.com, mcgrof@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, woojung.huh@microchip.com
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy
 module
Message-ID: <fc40244c-b26f-421e-8387-98c7f9f0c8ca@lunn.ch>
References: <20240724145458.440023-1-jtornosm@redhat.com>
 <20240724161020.442958-1-jtornosm@redhat.com>
 <8a267e73-1acc-480f-a9b3-6c4517ba317a@lunn.ch>
 <20240726074925.1c7df571@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726074925.1c7df571@kernel.org>

> For MDIO are the ID registers too complicated to expose to user space
> and let it match the drivers using modinfo (avoiding the need to boot
> a kitchen sink kernel)?

That is how it actually works for MDIO. Mostly.

We read the ID from register 2 and 3. That gives us a 32 bit
value. That gets turned into a binary string. Which is then matched
against what is in modules.alias

alias mdio:0000000000100010010101010010???? amd
alias mdio:0011000111000011000111001011???? aquantia
alias mdio:0011000111000011000111000001???? aquantia
alias mdio:0011000111000011000111000100???? aquantia

The ? means the value of the bit does not matter. The least
significant nibble is often the revision of the PHY and the driver can
driver any revision.

The 'mostly' is because some PHYs need help from the driver to enable
clocks etc before you can read register 2 and 3. A chicken/egg
problem. So you can put the ID in device tree, and the exact same
lookup is performed to load the driver.

It gets a bit more complex with C45 devices, because they have
multiple ID registers. But the same basic lookup is performed using
them one by one until a driver is found.

You can also find the C22 ID which matched the driver in
/sys/bus/mdio_bus/devices/*/phy_id.

       Andrew

