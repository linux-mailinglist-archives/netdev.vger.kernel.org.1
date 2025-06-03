Return-Path: <netdev+bounces-194847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D70ACCEBA
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 23:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FBD3A5A42
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 21:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1970225A3D;
	Tue,  3 Jun 2025 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="azw+oXlD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB7224B05;
	Tue,  3 Jun 2025 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985210; cv=none; b=tcGHAES+HTQePnOp0ahxqcBEYSDoISs0WI4R/wiXyuimUYJPjHt+b771v1kp4EgDXRk9PUczHFpo2DKQg+wT17+KB0kKL44P5hKGPLXmb33DtY3v3fSEgpsA8rJm6G5gVs9D7wOZ0eNKrJij44c3AFnLbRSCPmbOq44M/8iIfaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985210; c=relaxed/simple;
	bh=1BcdnyMHgieTxm8ahEYkMYtEjs8zmaa3HiTW1iXKbeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgw/gbXtkf61pZK3dmIHSEhIgXIU6mykyYwi5+IzdFXqTaQulaAWQAIiTHoKC6wRAkJryKBQ/EZjSKv4vflDVYMgFvVbnlbYmjqpXdl5R54h6JaU6nHBNxezM2Fv6c+Ap9NgNqy676+PX0EsxBT150V95kfiuAhwL41RcbNzb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=azw+oXlD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bmhcf/j9uEBvFmWrno3AXxDLOTU31ZRPLYTptLNTT4I=; b=azw+oXlDU8KhpqtJ+QZTyDEzek
	az9+bvyrejgDDwDnTYRrsNnwEs/tNrrUkkuW2q6FVstjBRCXHKJ1Rha0xADMT/ZaRsPfeXYTGioDW
	JhA2xTwSl+wqPb6q+4y9wIrCuWJ3WVuT0C9jEYplZAxw5Qr0XmCD5li7WJfsRwvQllyqBmqsL8B9u
	dGu/JNl4QIglQ4Qg++Vrr0UtAJDvnvBEWpXisPFirXaG0fki932y5iiP/TqxRAd46JQRK7X9ONHUO
	rQ77av6uBKHAbqLIpPT7t4sLG58DhRvsc9R1OXyp4vFkr/B7V3a6LcCsBdptVtFcczQOMAhX5enZS
	VxB5v87A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35734)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uMYwY-0006Qr-1W;
	Tue, 03 Jun 2025 22:13:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uMYwP-0000Ug-2N;
	Tue, 03 Jun 2025 22:13:01 +0100
Date: Tue, 3 Jun 2025 22:13:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Wei Fang <wei.fang@nxp.com>,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xiaolei.wang@windriver.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
Message-ID: <aD9lXa1JVRyJKuP_@shell.armlinux.org.uk>
References: <20250523083759.3741168-1-wei.fang@nxp.com>
 <8b947cec-f559-40b4-a0e0-7a506fd89341@gmail.com>
 <d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jun 03, 2025 at 01:39:47PM -0700, Abhishek Chauhan (ABC) wrote:
> 
> 
> On 5/23/2025 8:19 AM, Florian Fainelli wrote:
> > 
> > 
> > On 5/23/2025 1:37 AM, Wei Fang wrote:
> >> There is a potential crash issue when disabling and re-enabling the
> >> network port. When disabling the network port, phy_detach() calls
> >> device_link_del() to remove the device link, but it does not clear
> >> phydev->devlink, so phydev->devlink is not a NULL pointer. Then the
> >> network port is re-enabled, but if phy_attach_direct() fails before
> >> calling device_link_add(), the code jumps to the "error" label and
> >> calls phy_detach(). Since phydev->devlink retains the old value from
> >> the previous attach/detach cycle, device_link_del() uses the old value,
> >> which accesses a NULL pointer and causes a crash. The simplified crash
> >> log is as follows.
> >>
> >> [   24.702421] Call trace:
> >> [   24.704856]  device_link_put_kref+0x20/0x120
> >> [   24.709124]  device_link_del+0x30/0x48
> >> [   24.712864]  phy_detach+0x24/0x168
> >> [   24.716261]  phy_attach_direct+0x168/0x3a4
> >> [   24.720352]  phylink_fwnode_phy_connect+0xc8/0x14c
> >> [   24.725140]  phylink_of_phy_connect+0x1c/0x34
> >>
> >> Therefore, phydev->devlink needs to be cleared when the device link is
> >> deleted.
> >>
> >> Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
> >> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > 
> @Wei 
> What happens in case of shared mdio ? 
> 
> 1. Device 23040000 has the mdio node of both the ethernet phy and device 23000000 references the phy-handle present in the Device 23040000
> 2. When rmmod of the driver happens 
> 3. the parent devlink is already deleted. 
> 4. This cause the child mdio to access an entry causing a corruption. 
> 5. Thought this fix would help but i see that its not helping the case. 
> 
> Wondering if this is a legacy issue with shared mdio framework. 

The device link does nothing for this as it has DL_FLAG_STATELESS set,
which only affects suspend/resume/shutdown ordering, and with
DL_FLAG_PM_RUNTIME also set, runtime PM.

The device probe/removal ordering is unaffected. Maybe that's a
problem, but it needs careful consideration to change.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

