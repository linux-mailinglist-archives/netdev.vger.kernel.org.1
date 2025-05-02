Return-Path: <netdev+bounces-187414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC53CAA7060
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09EE9C588C
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87E1242D7C;
	Fri,  2 May 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="t/glLIo0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA22238C09;
	Fri,  2 May 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746184034; cv=none; b=MuzXe8UW7Jft8gsJqTPUHWqAYaxeOlLzQkdLO6YSjyQXaHcUcNIIzEyCDXtkWhiaDssmF4kNdEdLf2hasx6DRyKuDseruMhuY34za3WYO/y0brskilvN9kRzO1Dh0CCgOTsBudLmOkj4idYQRXq44XhqzoZiymp0hMt2uH6mDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746184034; c=relaxed/simple;
	bh=xbRFTk9j/CaY2rWfk0ojuy7uLZeBa00EkMY/PnfXQZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/5nZ9QfFKUBG0VQ7/MpXxWbDr6wEInzLwpm87+6dGI1zNrnOTgHH5rGlc4gHQIENQ6JrtPdkb8oj9W2VAhj5NjbU1ckJfwfw6BmvSuJQj1/dXW7HsglovzH6ucmNEel9bnI15ZcISOfEq437gH7efVFiwq4cvByf7Q56D3sccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=t/glLIo0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g1cIohdaDs6bXdyUuOwWEeJRglggxQPC86GuctGorOQ=; b=t/glLIo0tyzkQb3KoOlyaohDT9
	URUQrJK+OC/7ZJf+LpASPlR1pBWHs2RdySVbP4pIlupCjwJ7FIQdQJZzdPiCUL9f28AfnPW/F93Td
	AHvCBOZLRAFTxIJx7IEYGFkLCwRwn6unuxVlpIsFfYKAzWvQxrTcgNDK17pYjxgL4jRS4ucw7kv59
	g7tfPtPMMunHmGcBeHa1v9ijzplnbepnweYiAyGAyQSa45o+blQxAo1E8JDTQk9PELDsUZqY30UsV
	dpgUpg+rkxqMkFNUXfaBEGpowzBtwmgHXvDOH9ycowKrBKY3KP/ILlFYzyZoRAgb/9bZR5ZXhcThQ
	rpqVn9CQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36360)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uAoEF-0001GP-1H;
	Fri, 02 May 2025 12:06:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uAoE9-0000cz-1Y;
	Fri, 02 May 2025 12:06:45 +0100
Date: Fri, 2 May 2025 12:06:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] Documentation: networking: expand and
 clarify EEE_GET/EEE_SET documentation
Message-ID: <aBSnRZEGTnHxnMaI@shell.armlinux.org.uk>
References: <20250427134035.2458430-1-o.rempel@pengutronix.de>
 <f82fe7ac-fc12-4d50-98d4-4149db2bffa0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f82fe7ac-fc12-4d50-98d4-4149db2bffa0@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 02, 2025 at 10:46:02AM +0200, Paolo Abeni wrote:
> On 4/27/25 3:40 PM, Oleksij Rempel wrote:
> > Improve the documentation for ETHTOOL_MSG_EEE_GET and ETHTOOL_MSG_EEE_SET
> > to provide accurate descriptions of all netlink attributes involved.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> This looks like an almost complete rewrite WRT v1, a changelog would
> have helped reviewing. I'm unsure if it captures all the feedback from
> Russell,

Indeed, because I'm still of the opinion that we shouldn't be trying to
document the same thing in two different places, but differently, which
will only add confusion, and over time the two descriptions will diverge
making the problem harder.

We need to document this in exactly one place, not two places.

So please, choose one of:

* Documentation/devicetree/bindings/net/ethernet-phy.yaml
* Documentation/networking/phy.rst

and reference one from the other, if necessary improving the
documentation.

Given that phylib is not a DT thing, I believe it should not be
documented in the DT bindings, but people directed to the phylib
documentation (the second) for the clarification of our implementation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

