Return-Path: <netdev+bounces-149694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEFA9E6DDE
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6680B2836EE
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9B3200BBD;
	Fri,  6 Dec 2024 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T1o1hxwK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245AF5464A;
	Fri,  6 Dec 2024 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487271; cv=none; b=fogP3y6+lghJEX87iySVG75JAxT6MAIx85pq8/ULpP37WfDefC/dF0XzfEbzWXvAlk1KHkw7BmMCM5Svu425xSpO2F3OCi/0Xj33Jl9S653juavbt0pC+EkE/mDOcuhFv161r/gBPrDOw8cVqyhpZOosW87lHQ9HinedONdXp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487271; c=relaxed/simple;
	bh=P6HskHz8Y7kdjM7uh323LSTOxC6AtYxTfmyT/R4oxEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhQybOdAl4gCfjEtQI5U7iT6LXF2WYTLsCL9NTmAjQGx9BdwhGVGxbqjjf1+AAeRHkz33ZUvbhLwHW25okxl9cS00XOcjm+7Y7k8qNG/gb/kgsBW3fSCQxl/fMOx+mzfSprBJeIy7D4oM+f2wl8/4BsE0Ksb6Hr8pY6tzaEc1xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=T1o1hxwK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G0vAISNZ5Nl2vpcWQXz+Qy46dNJbCkdn26D1C1RDMHg=; b=T1o1hxwKSmM8pL7HN4mfsud9ef
	iiOrUVHTdBfX/OUeWjYaKeWuyAZYl5EYteLp93NOHyEAXW+Bht5LPFCVGQ8UXr9CUWo2NBiAC1Jtw
	VipKMtxYqIsvOtYts3R9IsCMgrbEDMaROo7TPhnI0cf1jMsAxPYeHoQuQzevwgbuAKjODcaAAcT8J
	64YtsPdhoLCaEJEFyVxbqrdIqccOwbraSFQ8z/mt8pA+ha9/OrQDaSlcVTbrtOE0pshChhqKJ2Yf8
	jpohvILZgPZewYFkKpmS7xT6pmwitjjW0YSDklha5Yd0fONpDXJgFogfTDKF/I0lpTY1VTJWr6p0t
	zCpiaHDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57340)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJXDt-0006E4-0O;
	Fri, 06 Dec 2024 12:14:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJXDp-0007XE-2u;
	Fri, 06 Dec 2024 12:14:13 +0000
Date: Fri, 6 Dec 2024 12:14:13 +0000
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
Subject: Re: [PATCH net-next v1 1/1] net: phy: Move callback comments from
 struct to kernel-doc section
Message-ID: <Z1LqlaG1IDvuz9Gy@shell.armlinux.org.uk>
References: <20241206113952.406311-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206113952.406311-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 06, 2024 at 12:39:52PM +0100, Oleksij Rempel wrote:
> Relocate all callback-related comments from the `struct phy_driver`
> definition to a dedicated `kernel-doc` section. This improves code
> readability by decluttering the structure definition and consolidating
> callback documentation in a central place for kernel-doc generation.
> 
> No functional changes are introduced by this patch.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thanks for doing this. This will mean that each method will be properly
documented in the generated kernel-doc.

It is a bit obtuse to work around kernel-doc in this way, but worth it
for the sake of the generated documentation containing all the pertinent
details.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

