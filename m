Return-Path: <netdev+bounces-215974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB176B312BF
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46981C828F5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D2925F7A7;
	Fri, 22 Aug 2025 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="m9ucEKO2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E13214232;
	Fri, 22 Aug 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854385; cv=none; b=bR3XloWaooFGUKWDNcGdTsmIASBafl9Tj+jro1z1zzYTdJU3IIed2HAeJUDe3yozg9qtWyfsGOYq82fQiIUkiTIP+JlS84BT2gfktBMfXUk/lGtZH8Thu0WeQl/jAGRakzN5BoJBcLc0V8CsouOy+RtAOxvVDfZWtuVkqY+ICtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854385; c=relaxed/simple;
	bh=aRpiojZMHRYXM5Uy7CSIuEAfNau1LrUfxz+fX4EO9zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWqBy+rHtgULNjr0UsZ5fD6Hfg++dlQVtKhHYXnzBOb+3Tgj5mQECtm/Xca9jlSzh/DscrIQfAYKOptMBOqU7aEKy/SBpjbMmNGX9ZOQ4psVVJSshXofZPS1xE2Gww4D3k5w4uR9hF2JhPJLZAClTOkYpx6IfZ2rl7fycC+14uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=m9ucEKO2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HuAJhlSM/9FTFsYa9IHzSdEVJFO5mghsio442YJyCq4=; b=m9ucEKO20lk5SnU6Q/87VLezu7
	AXfg4n1wXZvM7FZCLMueiU3Zeh3lRygbQou/pQ303URlS38CyeSH9qOzNLjewMZN/PKVQebpskPxX
	+XhDtndP/4ZOKqlZOYKxCOyn8miA4PSKnTTyZ94doNK1h3uGkZ1rPY7bsimotxA8jjGOLFq4axVOg
	weYGeXziOIeUCn/xV5AN3JvjEcrt/VM5S1dELLvc5+MESbTImrW9Mcwz2Ho3a8x51Z8CQRtNCE6AS
	Sw5UmP0hnldVbLPQJLkfnD/9JglEtLWtaJOBIqme/djq7BjYVDrGyeg81Zg7EonGzjrgdZNPqCu4e
	iQtY8QMw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39320)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1upNvj-000000002IR-2TCI;
	Fri, 22 Aug 2025 10:19:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1upNvg-000000001wA-3Wet;
	Fri, 22 Aug 2025 10:19:24 +0100
Date: Fri, 22 Aug 2025 10:19:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: phy: Clear link-specific data on
 link down
Message-ID: <aKg2HHIBAR8t2CQW@shell.armlinux.org.uk>
References: <20250822090947.2870441-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822090947.2870441-1-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 22, 2025 at 11:09:47AM +0200, Oleksij Rempel wrote:
> When a network interface is brought down, the associated PHY is stopped.
> However, several link-specific parameters within the phy_device struct
> are not cleared. This leads to userspace tools like ethtool reporting
> stale information from the last active connection, which is misleading
> as the link is no longer active.

This is not a good idea. Consider the case where the PHY has been
configured with autoneg disabled, and phydev->speed etc specifies
the desired speed.

When the link goes down, all that state gets cleared, and we lose
the user's settings.

So no, I don't think this is appropriate.

I think it is appropriate to clear some of the state, but anything that
the user can configure (such as ->speed and ->duplex) must not be
cleared.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

