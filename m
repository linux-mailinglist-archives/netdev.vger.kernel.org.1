Return-Path: <netdev+bounces-181622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283B5A85CBF
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAC78C4C61
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E42BF3FD;
	Fri, 11 Apr 2025 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KJrmP+Jo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111D2BF3DF;
	Fri, 11 Apr 2025 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373479; cv=none; b=aij4CgPGVQkySSXi0TARSksd/JdqDE5Yp9+VYYZpoRubs0yAAPuf3CC82XoT0UdP5eghz78Yz2E60OP0ImnLzpQnmOmuRNX+1u9Fg/kWvYHZXNFaaVPfmHGEmcVmcjJW9NEgIXT1m3ikbahWAKqQQIMa3jwZwBBnyF9IBG4m8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373479; c=relaxed/simple;
	bh=yzF33gKvYRvTTNQyiHSKd1m6sCWnvqK2EfrNCow/rKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd0quCBjdTksYbOM4/cSfYqlDOUXoB26lEbWJC4dATODuQEN4SxlYFyI5Hq2f3J114ESvUEmVmaiCzF9tDqa/YjSc7V+NeC8dHVVd2J9Wf9gxAc8gxd0WrHBWyy6K/Z5DgMyVdWjyYi2S67dLcsdrtjorR/4wx5WGfKugD/9s0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KJrmP+Jo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rNYHj+jMsjKcQ0NBqVY00CTxiyNat9iFuHkI3uiocOY=; b=KJrmP+JovP2P9xpa3JDZx/JtZP
	JtWQwOoCQvVCPB4QGUr5YlNkKzL3r7Q5mOODeZKTr1+MR3Dhk7G+Paus7+haNrtDezlEwg0j3NSKd
	YcQudvJbx9SMzW55WVSP0oT924FtLAFG5eyLkvjBQKf+Cie6VGV/D73o5BfqDN5fT+Pkc67908pAp
	0KhKLNFsCx4PTo+fip5FDCjhK/MFYrHbEOofJZiTd3Gp0CMf4cuYeGZtr8rxgKVUBtzqY5m6NtZ8k
	PYv2jHn1UBaDECx067z/Fi7ZPPXJ/bPK0S5bsXIhQsnWK6ENdII4+oKiiHi/5bVoTtEiKwGkKZXc7
	1nPsgQIg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54684)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u3DDq-0003Js-0Q;
	Fri, 11 Apr 2025 13:11:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u3DDh-0004bC-1Y;
	Fri, 11 Apr 2025 13:10:53 +0100
Date: Fri, 11 Apr 2025 13:10:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com, linux-kernel@vger.kernel.org,
	"andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>, lee@trager.us,
	horms@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
	geert+renesas@glider.be, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v4 00/14] yt6801: Add Motorcomm yt6801 PCIe
 driver
Message-ID: <Z_kGzeUfQB9qa2EN@shell.armlinux.org.uk>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
 <Z_T6vv013jraCzSD@shell.armlinux.org.uk>
 <da434f13-fb08-4036-96ed-7de579cb9ddc@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da434f13-fb08-4036-96ed-7de579cb9ddc@motor-comm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 11, 2025 at 05:50:55PM +0800, Frank Sae wrote:
> 
> 
> On 2025/4/8 18:30, Russell King (Oracle) wrote:
> > On Tue, Apr 08, 2025 at 05:28:21PM +0800, Frank Sae wrote:
> >> This series includes adding Motorcomm YT6801 Gigabit ethernet driver
> >>  and adding yt6801 ethernet driver entry in MAINTAINERS file.
> >> YT6801 integrates a YT8531S phy.
> > 
> > What is different between this and the Designware GMAC4 core supported
> > by drivers/net/ethernet/stmicro/stmmac/ ?
> > 
> 
> We support more features: NS, RSS, wpi, wol pattern and aspm control.

Is it not possible to add those features?

> > Looking at the register layout, it looks very similar. The layout of the
> > MAC control register looks similar. The RX queue and PMT registers are
> > at the same relative offset. The MDIO registers as well.
> > 
> > Can you re-use the stmmac driver?
> > 
> 
> I can not re-use the stmmac driver, because pcie and ephy can not work well on
> the stmmac driver.

Doesn't the stmmac driver support PCIe already (e.g. for Intel
platforms?) Can't it be fixed?

We shouldn't be duplicating what we already have, but fixing it if
there are problems.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

