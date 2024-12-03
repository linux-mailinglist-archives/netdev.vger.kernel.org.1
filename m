Return-Path: <netdev+bounces-148557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC999E2223
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF87161F96
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD5E1F75BC;
	Tue,  3 Dec 2024 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qTeCnhTU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0671F473A;
	Tue,  3 Dec 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238950; cv=none; b=P5VMhF7ZNmHvsAq/EqkFQQ+4ZhSdsfPgxMaKjFTI/Qppx2fQIwbVdTIzGTDs602cmmAmxJAbBkZw69RyH6LR5WRXEQ0DTOmW3OFmEvd1JpgqAFgOgkK+SGvaTo7DvzEQg5pn9rGyWqKtCLKtfMsJPsfsJfkaVN6C054szh+t8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238950; c=relaxed/simple;
	bh=MYd0JZSYUJNavZtjrEymN7Y2u2umwlA9KqCO6zvLvFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo8lZ7CUBKnFpSsq8xF4yZjqY3Te7QRgn7LImhRtVCnZHQ+kiLNlc/hIOz46LynnmbAwNU2/VeZWpYSMEaZtXag4mzLZOkzl5QYW30wAgtG9FbXeKEQqVWz3xNXpdpxwBW85kM/s451rywE1Vk3FiGEvy3NYkBJItjbeXqXSZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qTeCnhTU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1aJvf1+OXUaBUl6EVRktK5TufbSjl5kHRlSiByPPaFM=; b=qTeCnhTUuJNVGDTh7eB91s2Kvs
	kNxdWrH0VrYE1Sl0dlYAglT3qeZj1Q1j1Z2wzQwJi+hrg8uA954KdArz1EDNirFkjSnA9col9nMJ6
	9mceaKkYpGy9yb9rn72e9eeM8gIbBTjKKVWue3eNkI+LV8VHRa/pCTeocMZQEzWBgv1jICVkPtsYh
	yEopojMQyanQmHAJGhpB5KcyzsVQf5B066SQHjzR4gPtzOu17fKGl8rZuuIYlMRkCgDARy9fBsxIO
	EnDEAWKjdT3bZSPyN/7NnGokcTSyqToOs/ppEtLPPQHfMSEMuCI1epV1/24OkuBCbjGldEhtoTMWY
	jfCL/W7g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35088)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tIUcd-00025R-12;
	Tue, 03 Dec 2024 15:15:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tIUcZ-0004eF-2B;
	Tue, 03 Dec 2024 15:15:27 +0000
Date: Tue, 3 Dec 2024 15:15:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
Message-ID: <Z08gj2ImILpSALDn@shell.armlinux.org.uk>
References: <20241202100334.454599a7@fedora.home>
 <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
 <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
 <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
 <Z02KoULvRqMQbxR3@shell.armlinux.org.uk>
 <c1296735-81be-4f7d-a601-bc1a3718a6a2@cogentembedded.com>
 <Z02oTJgl1Ldw8J6X@shell.armlinux.org.uk>
 <5cef26d0-b24f-48c6-a5e0-f7c9bd0cefec@cogentembedded.com>
 <Z03aPw_QgVYn8WyR@shell.armlinux.org.uk>
 <2836f456-aac4-4925-97d6-25f6613fe998@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2836f456-aac4-4925-97d6-25f6613fe998@cogentembedded.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 03, 2024 at 04:01:56PM +0500, Nikita Yushchenko wrote:
> > As I say, need to see the code. Otherwise... sorry, I'm no longer
> > interested in your problem.
> 
> We already got valuable information.
> 
> I agree that the patch I tried to submit is a wrong way to handle the issue
> we have. Instead, need to improve the PHY driver stub, such that it does not
> declare no autoneg support for 2.5G Base-T1 PHY.
> 
> (creating a real driver for the PHY is not possible at this time due to lack of technical information)

Even seeing the existing code would help, rather than the current
situation which means we're poking about in total darkness. It doesn't
need to be "mainline quality". There is nothing worse for a maintainer
than to have someone trying to fix a problem, but not be able to know
the full details.

We're not asking for "a real driver", but just _seeing_ what the driver
is currently doing will help to answer questions such as why
phydev->duplex is changing.

Not being able to see what a driver is doing is very demotivating.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

