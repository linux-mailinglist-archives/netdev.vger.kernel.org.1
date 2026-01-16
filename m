Return-Path: <netdev+bounces-250505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D854D30515
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB5133082A27
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C02E36C5B9;
	Fri, 16 Jan 2026 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="khFazCMl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5022FF65F;
	Fri, 16 Jan 2026 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562495; cv=none; b=nCDEuZdVW6arGbWxvfqLozQ5Pn6IWBIZifTyL8rtaJ6Ja8x85EWZhD97Va0WERtIynPtqilG7g8FXKFjVB27BhMCPxhPFDVYq0PfJKMLcRCVcvUuK1jVDZA1xIVqWRpxcLtcEj7sFpbsM4DlwmIa9MFebLM3NsQlYPiGx+WoT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562495; c=relaxed/simple;
	bh=8AvaulKIS+LglmFonRB2jt85nfPGs7h6Z60XGPl7n6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xhhq8kyk26F2RuXebf3nrDofIp47Z7noaNi9DhpR6qAFKR4jVBK5i+yzjXtgmjrdyYZzZZqhw8orbszA2ZbFF9+wMtBM4mmDH0iDrMmpiKMxjgNzGHfePqjtdBoNEnLxkZx3FhVa+ZmiVRWEcwEYDiJ0OAfaMeEl8+aS6pSYGuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=khFazCMl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G+eYF1EdvyXkLboVNLbmsCw9+IK3+4mhBbVGMSLho3A=; b=khFazCMlbVS5BtGHDU23tsWrOv
	pGL+ABZnDx2OCuv0L1ZRT/6PaXaoVKZFn92Cvbwce53uczTvaY4ljskR9od8pOKF0gJBWk9et3L7M
	2mqBGtA5dy9/rP7jNwhmKAmjsLk1feqVKZT4Gw6mCHd8BJF2wrJ2rWIFgwiuzZKiJPBeH8xF8q0RA
	qmY2CvNhIOr1xXVfxZ+Iut3j8ZOBPBgMSr9mxGP7BUIHGs9Adt+RQGPwbAkPVt6g8yd5VFQ/Vje8A
	azaWpm8LeoCvjNyhAJWnFDPXmz1VJ1jpDNFe3hTGTsSa+Fajqke58II3oz3mb4v5hlJYvawXvyKk6
	1EC0x9yg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55848)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vghtO-000000002Bl-1sL6;
	Fri, 16 Jan 2026 11:21:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vghtL-000000003ZO-1zdt;
	Fri, 16 Jan 2026 11:21:23 +0000
Date: Fri, 16 Jan 2026 11:21:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v4] net: sfp: add SMBus I2C block support
Message-ID: <aWofM8Y0AIHVESml@shell.armlinux.org.uk>
References: <20260109101321.2804-1-jelonek.jonas@gmail.com>
 <466efdd2-ffe2-4d2e-b964-decde3d6369b@bootlin.com>
 <397e0cdd-86de-4978-a068-da8237b6e247@gmail.com>
 <0c181c3d-cb68-4ce4-b505-6fc9d10495cd@bootlin.com>
 <d5c11fec-1e75-46cf-aeae-593fb6a4af09@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5c11fec-1e75-46cf-aeae-593fb6a4af09@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 16, 2026 at 12:16:11PM +0100, Jonas Jelonek wrote:
> Hi Maxime,
> 
> On 09.01.26 18:03, Maxime Chevallier wrote:
> > ACK, I'll gladly help with testing. This should actually be easily
> > achievable with a board that has a real i2c interface connected to the
> > SFP cage, as there's a i2c smbus emulation layer. The SMBus helpers will
> > work with a true I2C adapter, you may have to tweak the code though.
> >
> > This is relevant for modules that have a built-in PHY that you can
> > access, if you don't have any I can run some tests here, I have more
> > than enough modules...
> >
> > If you don't have time at all for that, I may give this a shot at some
> > point, but my time is a bit scarce right now :'(
> >
> 
> I'd postpone this part if that's ok. Quite busy at the moment :(
> 
> When I come to trying to work on that, should that all be kept in
> mdio-i2c.c? I'm asking because we have a downstream implementation
> moving that SMbus stuff to mdio-smbus.c. This covers quite a lot right
> now, C22/C45 and Rollball, but just with byte access [1]. Because that
> isn't my work, I'll need to check with the original authors and adapt this
> for an upstream patch, trying to add word + block access.
> 
> Kind regards,
> Jonas
> 
> [1] https://github.com/openwrt/openwrt/blob/66b6791abe6f08dec2924b5d9e9e7dac93f37bc4/target/linux/realtek/patches-6.12/712-net-phy-add-an-MDIO-SMBus-library.patch

My personal view on this is not suitable for sharing publicly. I'm sure
people can guess what my view is and why. (Look at the age of the
patch, and it's clearly "lets re-implement mdio-i2c" rather than "let's
adapt it".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

