Return-Path: <netdev+bounces-170454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1326A48D09
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7A316D5C1
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6852C136A;
	Fri, 28 Feb 2025 00:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gBdZlsQs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B140410E5
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740700956; cv=none; b=QyBPVBPinvUE/efuq9GZhs+qScXH8JGEaZS4YwIfze5eAzWb6UCFZ29mYpTRdxjTz7WVYfPzV+0jnLzlpLf3vzOr4jt4SK3rx3dxIPyAlEV/I8guKAKLhAn0+az/6JDDXg8B9TS29jjDnkpz7eu/bbV5vXwuuP42TEX5nF6qmgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740700956; c=relaxed/simple;
	bh=jvCNb55q78DcbXFH9Fma3EB3JZnd/9VH2xtNkVbWoCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNs4UbE9nKakTSHasTTL31ltCoy42OKzIVyiP/4wJq8wzeXiBwym7CWHKmGFPJJgnl3le2po5NvZHXkLBcOXSEgWsfzBchu2J1GgNO11k6gdfQoFVzeeu3Qp5b32YsM7+l9c5kSnPMa/Pim9fusDvTXtL3iUc9Z96pQfAKGtn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gBdZlsQs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C8YkUSgUJyyz9lrq7gtxuszWtm5nHi8ieFSmR1xycgY=; b=gBdZlsQs+VZBAHvrazy5uv0QAh
	FhAzeVBg9ePSZVo0xWfwq2yVJPqs3AaCsjAUXlNV1xUVXVD+1a7vqiK2XSalcs0QenaqxGz6zNgCk
	GDXplgBDHCJlwid/UuUelCUk4oV00kAnJ0AKC759Cw8GSSVc6bYXSIEHng2qT3SV9h7+NTqObWvTB
	BDiwfGm3JR3ocpOrGjRt73asEpNEAeoBb4SZCYxTF6o/ChYOy+Vuewwb1i1lyHAlIWhajv77yJR/O
	tjwT6rd/usaOVb7ovq/rmw2dU1Qemp2d5EUATjRQ0vIxLdrw0aCJBb3xIOGHkJ9b6/gXPOMQm6dq8
	KcIo5BLA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51146)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnnpX-0000ME-0Y;
	Fri, 28 Feb 2025 00:02:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnnpS-00008X-1H;
	Fri, 28 Feb 2025 00:02:10 +0000
Date: Fri, 28 Feb 2025 00:02:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 1/5] net: stmmac: call phylink_start() and
 phylink_stop() in XDP functions
Message-ID: <Z8D9AiZRPp_oyKi_@shell.armlinux.org.uk>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
 <E1tnfRe-0057S9-6W@rmk-PC.armlinux.org.uk>
 <92442281-9896-4271-a040-0c14331cb1d3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92442281-9896-4271-a040-0c14331cb1d3@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 27, 2025 at 11:27:57PM +0100, Andrew Lunn wrote:
> On Thu, Feb 27, 2025 at 03:05:02PM +0000, Russell King (Oracle) wrote:
> > Phylink does not permit drivers to mess with the netif carrier, as
> > this will de-synchronise phylink with the MAC driver. Moreover,
> > setting and clearing the TE and RE bits via stmmac_mac_set() in this
> > path is also wrong as the link may not be up.
> > 
> > Replace the netif_carrier_on(), netif_carrier_off() and
> > stmmac_mac_set() calls with the appropriate phylink_start() and
> > phylink_stop() calls, thereby allowing phylink to manage the netif
> > carrier and TE/RE bits through the .mac_link_up() and .mac_link_down()
> > methods.
> > 
> > Note that RE should only be set after the DMA is ready to avoid the
> > receive FIFO between the MAC and DMA blocks overflowing, so
> > phylink_start() needs to be placed after DMA has been started.
> 
> Sorry, i don't know enough about XDP to review this :-(

I suspect there aren't many people who could review it.

However, delving into the history, it seems that this commit was
responsible for introducing stmmac_xdp_{open,release}, thus
intrducing the fidding of the netif carrier which is prohibited
by phylink:

commit ac746c8520d9d056b6963ecca8ff1da9929d02f1
Author: Ong Boon Leong <boon.leong.ong@intel.com>
Date:   Thu Nov 11 22:39:49 2021 +0800

    net: stmmac: enhance XDP ZC driver level switching performance

but that commit was wrong for this very reason.

Didn't phylib used to not renegotiate the link if nothing changed
across a phy_stop()..phy_start() ?

I'm wondering whether my commit is in essence reverting this commit.


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

