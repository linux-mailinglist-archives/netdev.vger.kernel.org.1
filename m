Return-Path: <netdev+bounces-210010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE95B11E7A
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE0B173D9A
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 12:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0D22D131A;
	Fri, 25 Jul 2025 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TDmjzyT3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D182E8E08;
	Fri, 25 Jul 2025 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446474; cv=none; b=Hw6nTSIzNmGnsF9FOwLhPK+FNjiRGfB/vzXpREu58b532OSGJbZ1y5LJRBZizLepByxY8RkkQxx8lpPFshnp+bsJz1/6+aDjZH9dK4x7ONmYfPu7c3DoGrrMTdQFpK3AVg7EFA13Hz1oU2QB84rzR04Y1ALfPkTbbwgvm08Dba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446474; c=relaxed/simple;
	bh=yTM+XFSwPMbC1NfMAra3XToo5zUi5BoME92HfCLRi9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un/ApgHziLQ0lTfXmK121Q7RCTXx5XWMEcQJolzrsJr9uMK2OXXOA2UQWyryP5tmbDpnsJrzqCS6dX9otYLHYOJMfiRrbSyD9IhEXiRmRcjfb7ztlDb81X27Y4tGuFunyPAsIhXMvpBQit+dusfohsb1k2SBNCBxTd6GPvsVjF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TDmjzyT3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SE5NyeTRZ2PlENWak0tNphrtwhw6S/QvuTTHOY9y5WM=; b=TDmjzyT3rmttHFmY0Xvgtats5Y
	ngzWo+qiRBa/r4FL0qq+j91mZssmhBitgA8NyDbn8dqc0HabLELl9sFD/ax4lbkPTqzU1yFREVuw/
	nBz2TixdD4zsD0qj7Wbg2AzPIYkFHPntlCsOxn3/Bb6fyTiKcJEMfvo8ezkk6qsVGWpg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ufHWV-002rb3-Ny; Fri, 25 Jul 2025 14:27:39 +0200
Date: Fri, 25 Jul 2025 14:27:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/6] net: dsa: microchip: Add KSZ8463 switch
 support to KSZ DSA driver
Message-ID: <6fc3ef55-68f7-4b1a-aa8f-70dc8ffdba3e@lunn.ch>
References: <20250725001753.6330-1-Tristram.Ha@microchip.com>
 <20250725001753.6330-3-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725001753.6330-3-Tristram.Ha@microchip.com>

> On Thu, Jul 24, 2025 at 05:17:49PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8463 switch is a 3-port switch based from KSZ8863.  Its major
> difference from other KSZ SPI switches is its register access is not a
> simple continual 8-bit transfer with automatic address increase but uses
> a byte-enable mechanism specifying 8-bit, 16-bit, or 32-bit access.  Its
> registers are also defined in 16-bit format because it shares a design
> with a MAC controller using 16-bit access.  As a result some common
> register accesses need to be re-arranged.
> 
> This patch adds the basic structure for using KSZ8463.  It cannot use the
> same regmap table for other KSZ switches as it interprets the 16-bit
> value as little-endian and its SPI commands are different.
> 
> KSZ8463 uses a byte-enable mechanism to specify 8-bit, 16-bit, and 32-bit
> access.  The register is first shifted right by 2 then left by 4.  Extra
> 4 bits are added.  If the access is 8-bit one of the 4 bits is set.  If
> the access is 16-bit two of the 4 bits are set.  If the access is 32-bit
> all 4 bits are set.  The SPI command for read or write is then added.
> 
> Because of this register transformation separate SPI read and write
> functions are provided for KSZ8463.
> 
> KSZ8463's internal PHYs use standard PHY register definitions so there is
> no need to remap things.  However, the hardware has a bug that the high
> word and low word of the PHY id are swapped.  In addition the port
> registers are arranged differently so KSZ8463 has its own mapping for
> port registers and PHY registers.  Therefore the PORT_CTRL_ADDR macro is
> replaced with the get_port_addr helper function.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Thanks for keeping working on regmap. The end result is a lot better,
smaller.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

