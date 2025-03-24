Return-Path: <netdev+bounces-177120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15DCA6DF75
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA37189340C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D9261570;
	Mon, 24 Mar 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FioJRn9n"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532D72638AF;
	Mon, 24 Mar 2025 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833244; cv=none; b=fj3OTyff7b1xKDnKQwGDtYdJeotYDTbj8engnPHONJ0V89iFnqSRcdFGWC7o+Th943ekQeTLzDOAT54ZZkntnOavf1XPYVRfSXR51IyMtLJh/aCAzpIz22qvpH3/VI3A5sa4MGiS3d6jx2vbrjlOf5zmnD0ABBgs0KfDU+Za36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833244; c=relaxed/simple;
	bh=8TC//ir4ABf0L/MvZx7joLY3RLImUclr8ZtF668vhB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V95awihH7ekdLXcEBCseSrFdghDJNU+PrqlIGIpRjYNJU0YWPmGygHdGprgoOmQqR8H7lOzOTK9/Vm01AF/KXIKU7k18+OfHVJJLk0TruDdxs+LvrjZB///4a2HbUHMvF8HIBQQnvpKdYQe5xb+WCfFtiMUY/D7kBFEaG8+dUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FioJRn9n; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uL2csTBzp2t5f/5h7tPw4p2egtXULrKZ5Bvb+JpkFJc=; b=FioJRn9nkFUKWBjyJC/ZVt0FVf
	CxpmOH9eRjgu+KSYtQFtyCIhwxeApnvDJ+04siXaLvZ0VxaGUpT0q9K52aYQoOmdaFBIYKrIMSSI6
	1l0cG7rHRJqU44LJFY49mEx5nlt6BLYwh5W6l/U3xmnV4nsLPJOyyGvDAtHYM91M0AH2fmy7kj6HV
	3VlLsSJaZ3bSjqR5xqcZ2InvgDD3db6ETQ7qkGBmrTlXPpEiw5cZvZyibWhK42KJkX4UjptSLcuPl
	c4uWCdonXZtxi07HEFZqJBi+kXSfOqIa4dFHYENe22F8UvVaI/xk/kR8nE3igLPDYMpw/yy5J4vWG
	W3UEYfVw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33668)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1twkXR-0003ms-2c;
	Mon, 24 Mar 2025 16:20:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1twkXQ-0002Nw-1i;
	Mon, 24 Mar 2025 16:20:32 +0000
Date: Mon, 24 Mar 2025 16:20:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v5 6/6] net: usb: lan78xx: remove unused struct
 members
Message-ID: <Z-GGUA-xQZVzdIta@shell.armlinux.org.uk>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
 <20250319084952.419051-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319084952.419051-7-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 09:49:52AM +0100, Oleksij Rempel wrote:
> Remove unused members from struct lan78xx_net, including:
> 
>     driver_priv
>     suspend_count
>     link_on
>     mdix_ctrl
>     interface
>     fc_autoneg
>     fc_request_control
> 
> These fields are no longer used in the driver and can be safely removed
> as part of a cleanup.

Shouldn't these members be removed in the patches that removed their
users? For example, I think "interface" becomes unused in patch 2.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

