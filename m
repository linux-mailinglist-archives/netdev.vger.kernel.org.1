Return-Path: <netdev+bounces-239426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD798C682F1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 943A028A56
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6F307AC7;
	Tue, 18 Nov 2025 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XzsDB1G9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B426B75C;
	Tue, 18 Nov 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454245; cv=none; b=dVNJJ/otx854sTVdyj/PGSzIjN+A6opQWxw7dGNMHhO6FMNnjEZuG16NAWuFHmiSkpcfOPLu5nuGsxzVG8N/ti7TfLVv0FJk3R7BQc6obnyqwVXN8xCSXCaXZAb9AAwKhl5FefCel7oJA1fpbzubfDFAB1MZZZIJdWlE/Z+NP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454245; c=relaxed/simple;
	bh=GWBWi6n/09s4UFkCZrc4hn3vheoXtmdjxbEXTYUz66I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzhdQj4sB6UDMEBmSQvfsiLDBvKsg/QWy2BBobkX+ytKeOYoBB90r8KQ+P+pzr3VpYHGnwlS+5LsbMhOqsvjvWY5tlYdXO1DT3yRByiRvoT8rMtmx3IdBtZHXTUiJU4k3KKC9uv3yId42p000xSp7A6TwK40ZJSXTq0kbnhD1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XzsDB1G9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8SLu1N6OkiZOCKYpKcgBHYGaJlgn3HankT7fWKAAW+g=; b=XzsDB1G9tH6y6Am4sthjbvOngF
	F84JB9kQMPJ/3gUMA8ErN74tm83ExxYGIC5MQhG0I9pMt9u4VIfAO+tO5vInKyPiu4CbNeIUVg1i/
	NsWjhcBW2hhaz7Cf5fbeufgQFsaM8OlplZ1hjTnTRlwEaKUVhw3shh6OOslzqx7XUcmW/wxMKmswL
	BczBrSBZRRs2j3ghXL+RHYXJ/V/sNbaCD59TVansTjdcoGrPrY/SFK9ZdJqmtbSepTP4kshJjI4Ij
	MX17udDSBe9XcHZpmj3Vvd5KQ9viTYzHryqBBOxk5rLdZ1J2NeurXaHwsFihy5aO8byOTL03V/0uU
	WiF4jyTw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57590)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLH0A-000000002uO-1cZE;
	Tue, 18 Nov 2025 08:23:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLH05-000000002Jb-2EVx;
	Tue, 18 Nov 2025 08:23:45 +0000
Date: Tue, 18 Nov 2025 08:23:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wei Fang <wei.fang@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	eric@nelint.com, maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] net: phylink: add missing supported link modes
 for the fixed-link
Message-ID: <aRwtEVvzuchzBHAu@shell.armlinux.org.uk>
References: <20251117102943.1862680-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117102943.1862680-1-wei.fang@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 17, 2025 at 06:29:43PM +0800, Wei Fang wrote:
> Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
> initialized, so these link modes will not work for the fixed-link. This
> leads to a TCP performance degradation issue observed on the i.MX943
> platform.
> 
> The switch CPU port of i.MX943 is connected to an ENETC MAC, this link
> is a fixed link and the link speed is 2.5Gbps. And one of the switch
> user ports is the RGMII interface, and its link speed is 1Gbps. If the
> flow-control of the fixed link is not enabled, we can easily observe
> the iperf performance of TCP packets is very low. Because the inbound
> rate on the CPU port is greater than the outbound rate on the user port,
> the switch is prone to congestion, leading to the loss of some TCP
> packets and requiring multiple retransmissions.
> 
> Solving this problem should be as simple as setting the Asym_Pause and
> Pause bits. The reason why the Autoneg bit needs to be set, Russell
> has gave a very good explanation in the thread [1], see below.
> 
> "As the advertising and lp_advertising bitmasks have to be non-empty,
> and the swphy reports aneg capable, aneg complete, and AN enabled, then
> for consistency with that state, Autoneg should be set. This is how it
> was prior to the blamed commit."
> 
> [1] https://lore.kernel.org/all/aRjqLN8eQDIQfBjS@shell.armlinux.org.uk/
> 
> Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

NAK. I give up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

