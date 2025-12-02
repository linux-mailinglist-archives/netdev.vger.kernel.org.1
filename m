Return-Path: <netdev+bounces-243207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC317C9B848
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 13:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB2A3A76D9
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 12:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628D63112C0;
	Tue,  2 Dec 2025 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YeT/2TQV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E627E7EC;
	Tue,  2 Dec 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764679739; cv=none; b=LbSHvoRYbLgzNtV7R8eoGShI87u2RYZ8j4v2s5Bk/XAqOVIXzMx9cGjZ+Zw3wnsS+ZVVq93crZjoxRl5G6agTu4Zvf61GslpoTjkgNrtio23QoPn7rcWab3349sud1IuZLYoOhFFdCimngqDOfwKhpZNcxOV0r8FlsNufU6dkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764679739; c=relaxed/simple;
	bh=Q/Q2MABCeFdvFC5jiF9V2vdmAazYBvEXlBM6uxmeOvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu+EEIyiQUIcDyXZB8UlKtq5G+r1FWnDYmrkELgowAcWlWavm45u0JrYXy6leZNLCLb8UUgOxgdGmVcxuokLTCkeV/5LLaM5bFxhS+OkBldejJJrFWKW832kNrsyfKSz7POV0Cd88c0FM7NPjhFbZCq/W6l2K/0WrxVGh/sPQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YeT/2TQV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hulALADupkYx2mqTey5L9MdK5RG+4Joo2BEDO/6rQd8=; b=YeT/2TQV1yJKH+mxwUl3FmYvWb
	xRNgYcGHofO1x9XB+HJ3w8fGBRvk+CfZi8rU5ui3gbeouX1vwZfYRt9gngAnuheCf5EURFPcgwV4P
	Klut+G/2bBPZfWOpO+UpJN/GXojseQATe49HQlFgRIfFv90+mPPn5gv1/7BD4V3iLmbz2FBZ7Rg+u
	TsBqe++hn5gwvr8/VaK9QHjiZJEm712wKnY3lOs7ZG5qJfXzyb8HcSAANkUQUyScUO/8UEfAemlzW
	W5lqhHoEmlLIyPbYG45eFy0/R6KnT1YW/EB5MfBqFI2TGn+MrwNbsBJzZKwv6Up46adGOrb9NYppJ
	gaS8vZvQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44522)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQPoI-000000001hp-1XDI;
	Tue, 02 Dec 2025 12:48:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQPoF-000000007T4-2dQL;
	Tue, 02 Dec 2025 12:48:47 +0000
Date: Tue, 2 Dec 2025 12:48:47 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Buday Csaba <buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: mdio: reset PHY before attempting
 to access ID register
Message-ID: <aS7gL3md82HEEjaP@shell.armlinux.org.uk>
References: <5701a9faafd1769b650b79c2d0c72cc10b5bdbc8.1764337894.git.buday.csaba@prolan.hu>
 <37ecfff6-19da-4b0d-9623-129431d5a218@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ecfff6-19da-4b0d-9623-129431d5a218@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 02, 2025 at 01:38:21PM +0100, Paolo Abeni wrote:
> On 11/28/25 2:53 PM, Buday Csaba wrote:
> > When the ID of an Ethernet PHY is not provided by the 'compatible'
> > string in the device tree, its actual ID is read via the MDIO bus.
> > For some PHYs this could be unsafe, since a hard reset may be
> > necessary to safely access the MDIO registers.
> > 
> > Add a fallback mechanism for such devices: when reading the ID
> > fails, the reset will be asserted, and the ID read is retried.
> > 
> > This allows such devices to be used with an autodetected ID.
> > 
> > The fallback mechanism is activated in the error handling path, and
> > the return code of fwnode_mdiobus_register_phy() is unaltered, except
> > when the reset fails with -EPROBE_DEFER, which is propagated to the
> > caller.
> > 
> > Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> 
> IMHO this deserves an explicit ack from phy maintainers. Unless such ack
> is going to land on the ML very soon, I suggest to defer this patch to
> the next cycle, as Jakub is wrapping the net-next PR.

No time to do anything quickly, sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

