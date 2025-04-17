Return-Path: <netdev+bounces-183690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A944A918D7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573B24481D5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84BC22A817;
	Thu, 17 Apr 2025 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lyFy02Zs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E82A1D63D6;
	Thu, 17 Apr 2025 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884676; cv=none; b=VZx+OeJlOvRa4UKbI555x+6D+KKahtdpsGKXoUqBNlhAwYXLWAsMjACa/NQoWXEbR5xFA6B95BCPjjdAVAc2fUWDjkW/+9gqqN4Ayi2Cdvpy1LRQmjpKyIQ6RMp5h3+vKF5cVxRr8OVi5ARyvs+UdriQiVckbv/n+HRA0lk2tWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884676; c=relaxed/simple;
	bh=OjOyXwwkPkvApQlOY7upCNWh6uL9evvXiu2wCmgHLjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+wTpS2S+a33vTOxwzyjOlKx4EZLZusukEgN7EeG+VNG06ze0W0jDtBuggQAcoyLPrMg73UnAK+0Uv8X+u8SPeE6LwekLackqCqgevwi4spzAX+eWSrYVtMp27Mj9bFkueUOebRomSREP2AgSLdFtnLslJzaE20Dj3wP14PHLPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lyFy02Zs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cJJC6WP3gpZ9K3VX9TT93MWqlpGNyRN7xfN0nAAX5ow=; b=lyFy02Zs99XdoiAkZ/hc5CAzhD
	YiWUy1eBRdXDgyCSLi+Pqr1lv4YSwKj8r6wjCEIEIoLu/z/rX95dT07toDiLrulNaqFjc1c5qbVhn
	hizjLWioCaBWkTeKE8r42yWwdh10Q22hupiiju9Z3v0WMdB6hUPI3IFzp1LqVpp34EXIE/RB4SRAN
	CrVkbklx9/GIp1WNkLMyXIOYLRJsxc10oLD8CihkTabScq1KrtdUoHviFLiY0rKjWD5/xAbEqUFMv
	a5bnTMsqsqZ+CPCHujM49texrGF0DHB+VrOKUyGJ7yrpByjYN5ahyB60pxoMuKVdPckB2ysBQl9R0
	2EKY1wNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50752)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u5MCv-0005Bh-2W;
	Thu, 17 Apr 2025 11:10:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u5MCm-0002MO-1y;
	Thu, 17 Apr 2025 11:10:48 +0100
Date: Thu, 17 Apr 2025 11:10:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
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
Message-ID: <aADTqCC7oaXFauOm@shell.armlinux.org.uk>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
 <Z_T6vv013jraCzSD@shell.armlinux.org.uk>
 <da434f13-fb08-4036-96ed-7de579cb9ddc@motor-comm.com>
 <4fac4c4f-543b-4887-ace9-d264a0e5b0f2@lunn.ch>
 <4ad68dae-311f-4cdd-a6f8-0229f069ece3@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ad68dae-311f-4cdd-a6f8-0229f069ece3@motor-comm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 17, 2025 at 02:06:05PM +0800, Frank Sae wrote:
> 
> 
> On 2025/4/14 04:33, Andrew Lunn wrote:
> > On Fri, Apr 11, 2025 at 05:50:55PM +0800, Frank Sae wrote:
> >>
> >>
> >> On 2025/4/8 18:30, Russell King (Oracle) wrote:
> >>> On Tue, Apr 08, 2025 at 05:28:21PM +0800, Frank Sae wrote:
> >>>> This series includes adding Motorcomm YT6801 Gigabit ethernet driver
> >>>>  and adding yt6801 ethernet driver entry in MAINTAINERS file.
> >>>> YT6801 integrates a YT8531S phy.
> >>>
> >>> What is different between this and the Designware GMAC4 core supported
> >>> by drivers/net/ethernet/stmicro/stmmac/ ?
> >>>
> >>
> >> We support more features: NS, RSS, wpi, wol pattern and aspm control.
> > 
> > Details please as to why these preventing the stmmac driver from being
> > used? Our default opinion will be that you will extend that stmmac
> > driver. In order to change that, you need to give us deep technical
> > arguments why it cannot be done.
> > 
> 
> After internal discussion, we have decided to temporarily suspend upstream.
> Thanks again!

Sorry, but please understand the issue from our side, because the more
code that's in the kernel tree, the more work that gives maintainers
who stick around for the long term. Therefore, it is desirable not to
collect lots of driver code that is only subtly different from each
other, but require re-use and/or adaption of what is already present.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

