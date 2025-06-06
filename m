Return-Path: <netdev+bounces-195362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18435ACFE54
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 10:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B12B18959BB
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143382857DE;
	Fri,  6 Jun 2025 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r7EdqUQS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47205F9EC;
	Fri,  6 Jun 2025 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749198677; cv=none; b=kCR6Plth6BPUnRNYiJ7RxAFM6VRlRUnyp+47Ps8l2H5vTRozAdfled1WITk2IXAtFFuvdV9ZKuuLXqVyLBb7dW32Pc/lGALOA3a8OXcUGZgHC/JIaFtYJCZzbx/jdhCuOjyfUAqrrOn3CDW68236J8AEDYw6gvxJsyThlE7Ehd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749198677; c=relaxed/simple;
	bh=GOaecTwnFqUtKaM46dtg8BN9hvAYfBIit3afUD3tV4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNRXsD0TuRiYoTXr+PbP42Kj6MJ86AGt24YqIMp3/yz6mtAqb6mM9TqosctsRkH46Xb7L4ucLZH0EUYixTlXhS9DubqVUrTqrxRqZ0BEySekVbHH7cmkwmAKEyfYNlFJfIYJ8L7bylDMmo1XrtpAXSmkY10uNBqUuYfPFf8gKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=r7EdqUQS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UiP4Miv2fJBDHLcvZPsk9HjMhtpzsvxsINCe1ehfFjc=; b=r7EdqUQSJRqm9CeA+rK2wsC/Xm
	s2szXU0GVh++A4mDTsHpuq3LGkszUuEdzlaAculq6QhLktb52PTg4VCssV8DMF3ktMRbeYlgjo3md
	wHvN5GQma3fHpkPAE0Qu+kA52r6/uwh8L/gvtSF7z8Rb3XxxtUYZtPtQUd26DBhFpVLQ8WEDR+GOw
	FEXwoJw+SnfMc+WG13rWZzdRa8u/+8Y1zMm+VNbreqiKZQ28jqpPQBbS1a5k+0uxw5C/ILmaUdxgN
	XUuQQUiKriG38tnn9HGEq0RJIUYAXTGLR4a6fd3xNwRFHJ4MUjux+hOJ8dreS7Rz0z83KsC4vi3aD
	MtTXOAmQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33176)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uNSTg-0000Zv-22;
	Fri, 06 Jun 2025 09:31:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uNSTb-00034M-2K;
	Fri, 06 Jun 2025 09:30:59 +0100
Date: Fri, 6 Jun 2025 09:30:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH net] net: phy: phy_caps: Don't skip better duplex macth
 on non-exact match
Message-ID: <aEKnQ4haQtcJWzXX@shell.armlinux.org.uk>
References: <20250603083541.248315-1-maxime.chevallier@bootlin.com>
 <ef3efb3c-3b5a-4176-a512-011e80c52a06@redhat.com>
 <20250606101923.04393789@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606101923.04393789@fedora>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 06, 2025 at 10:19:23AM +0200, Maxime Chevallier wrote:
> In reality, the case you're mentioning would be a device that supports
> 1000/Full, 100/Full and 100/Half, user asks for 1000/Half, and 100/Full
> would be reported.
> 
> That's unlikely to exist, but I'll document it as I've been surprised
> in the past with setups that shouldn't exist that actually do :)

That's not unlikely. Many MACs do not support 1000/Half but do support
100/Half and 10/Half.

Also... you're wrong about the result.

If phy_lookup_setting() is called with speed = 1000, duplex = half,
and we have a MAC that supports 1000/Full, 100/Half, 100/Full, then:

- We iterate down through the phy_settings[] to:
	PHY_SETTING(   1000, FULL,   1000baseT_Full             ),

	if (p->speed == speed && p->duplex == duplex) {
  the first condition is true, the second is false.
	} else if (!exact) {
  this is true.
		if (!match && p->speed <= speed)
  match is NULL, and p->speed == speed, so this is a candidate:
			match = p;
  We continue.
- The next entry that will be tested is:
	PHY_SETTING(    100, FULL,    100baseT_Full             ),

	if (p->speed == speed && p->duplex == duplex) {
  the first condition is false.
	} else if (!exact) {
  this is true.
		if (!match && p->speed <= speed)
  this is now false because match is set.
  We continue.
- The next entry that will be tested is:
	PHY_SETTING(    100, HALF,    100baseT_Half             ),

	if (p->speed == speed && p->duplex == duplex) {
  the first condition is false.
	} else if (!exact) {
  this is true.
		if (!match && p->speed <= speed)
  this is now false because match is set.
  We continue.

- We eventually get to the end of the list.
	if (!match && !exact)
  this is false.

- We return the entry for 1000/Full, which is exactly the behaviour I
  was after when I wrote this matching.

If you're version doesn't come out with a matching speed, then I'm
afraid it's still broken.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

