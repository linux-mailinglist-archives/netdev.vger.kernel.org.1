Return-Path: <netdev+bounces-149376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5285A9E54FC
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35311882B9E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74421773D;
	Thu,  5 Dec 2024 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L7WwuRrx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7121772E;
	Thu,  5 Dec 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400420; cv=none; b=TSZbs7h6h6qKnmVX3oRCmz8BWuJsag/6gzZHCskkWsF9m+Aioj3v5epwiHJ8fuUniOMqU7hf+JWzCyxEumBggL9efsLg9afef0PolHRALprX1fBDs2h1/v3EtX6KHnkUXqkMQQUgK2ZRa38jI5gyPCudIhoINg9XRFkPYnnXOBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400420; c=relaxed/simple;
	bh=xX0Aik4SOLFTwMZuxb3lrcgb4axgzJ9TEpW7q3u8JdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7XbIPx+Pc12OWHoFiH0yH5FafIBUmfeAfUcwDI4aPWxQUJh8Fo2Fg1RxZPgNxOdyD1PfgJv5tCJZb2t1b7O3E9H6mqt6jyhnvTZFYmWrarNW9+DF8udjEm8x/w1si7OOTlBldnEM6GAifXq9HPS57chvJmf858+StDqeqKxm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=L7WwuRrx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eBlrQvHGQKgw3f0hUAy1Tn1aB3Z0FysLF4SCWm+DmMA=; b=L7WwuRrxnVVePXoGkHYV2dckCy
	me76cq9PzZve4IXx72VykMPBlw2MloWtD+Jt56Mhl40WL3PaQrZzY9BCmbcvdwiqbvcdNZCXSGrDa
	zkVGoUTiT/1pKUPkCepa0bvYmLkxLtFlJ31EXwM7mMTdp3rty4GJg9YDFZNPy5YzaLtZ6PRRrPeMQ
	A3cJvF7y0RjtcJsSRJO88c1RbIcoSn6Iq2A5GJk3eWwssJJrnT86GhEyMoRO644cmGGnuogRGxqmy
	eZUM+qAJ17rfI+0Zf8PhlP5D2FA2N52i2QMDLVmm7PGd5uFg9Q4CuZMGUq0cHKlgDnEeyiZs4lbbc
	4MsC1LWg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37060)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJAd9-0004kg-2F;
	Thu, 05 Dec 2024 12:06:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJAd8-0006Wq-1H;
	Thu, 05 Dec 2024 12:06:50 +0000
Date: Thu, 5 Dec 2024 12:06:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 3/7] phy: replace bitwise flag definitions
 with BIT() macro
Message-ID: <Z1GXWtZbJMgUq9zk@shell.armlinux.org.uk>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-4-o.rempel@pengutronix.de>
 <Z1GWSwtWrUKPZBU7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1GWSwtWrUKPZBU7@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 05, 2024 at 12:02:19PM +0000, Russell King (Oracle) wrote:
> On Tue, Dec 03, 2024 at 08:56:17AM +0100, Oleksij Rempel wrote:
> > Convert the PHY flag definitions to use the BIT() macro instead of
> > hexadecimal values. This improves readability and maintainability.
> 
> Maybe only readability. One can argue that changing them introduces the
> possibility of conflicts when porting patches which adds maintenance
> burden.

Thinking a bit more about this, we can do much better to improve
readability. The question that stands out right now is "but what
are these flags used for?" and their definition doesn't make any
hint.

The PHY_* constants are for struct phy_driver.flags, and I think
this needs to be documented. I think that's a much more important
detail here that would massively improve readability way beyond
simply changing them to be defined in terms of BIT().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

