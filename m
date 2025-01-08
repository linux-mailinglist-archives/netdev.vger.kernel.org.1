Return-Path: <netdev+bounces-156259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2159A05BEF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050D93A24ED
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A041D1F8AE3;
	Wed,  8 Jan 2025 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rawjzhiz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C104A59;
	Wed,  8 Jan 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340467; cv=none; b=edPaeI8HuIKm0KbwjvObRKmhOnff9EuuZH58NDmR6yUhH/6JvR7Gb0qvkD+Wrs09d8RSB6mLbRvJxW6p2uhqzwJ3vc0p+5Saqf+x8GFG5VllmfRzcer+HfBcfKcew0GdlStl2qrhLobReiNiuWLiDOo2dh5EsJZAXIiIfSC6Kg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340467; c=relaxed/simple;
	bh=GJPWNTnrVc7HqxNpt/q/Z8//D1qbMp6dc9dnjNty70A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txynyDp5i3bjcjtyYYAGBmsIY9oeQRtzD4g8+xNtEJD73md5d49f3qi7WWVpuUirbFnRrYlQbNcf6z2Jr1gZZmJmsA0ssG+pTwxizROriSOpQmPYiGm7TS1jru/NUdOUJ8E9u4suEvfrRvXdnO1jKkDw/YrLudx4EMG5u9y1GQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rawjzhiz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YPwbhJwai/J3CXP+3jUK1dMsF8G0MDDy6pQ7w6/Q/Rg=; b=rawjzhiz+MR5/8cOY4AkYF+cL2
	7rHxr5lwDp5A9+5rae+WtYsul8Fb6cfBNq/erD4LhLhM/mp232qrC+OyadCmd3b2pRulaaudcQUCp
	02dZdGGakU5Qs1C7IYeZLWKsMCJl0UD5OM2Rwv64d+Qe4P/tjjqYdhLvBLAmiZpZ2AMKfW2UMIdLK
	ayeIxSyFuddmUMGAVqeQBrnM+nxiPLkqDx1QloH6gQSqJ8tt2sYVlqv0FHcJPwRaXJ3c07scZYCST
	0Aup7QId40A2XmjmDte3dMXFaSfD4UqcOpVdoZvf115wej7BYx/P/wEdL/HcwyXr/0U6JUtuO0zNH
	iaOjbFPA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50336)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVVTG-0000ci-1b;
	Wed, 08 Jan 2025 12:47:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVVTF-0006J8-15;
	Wed, 08 Jan 2025 12:47:37 +0000
Date: Wed, 8 Jan 2025 12:47:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <Z35z6ZHspfSZK4U7@shell.armlinux.org.uk>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
 <20250108121341.2689130-8-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108121341.2689130-8-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 08, 2025 at 01:13:41PM +0100, Oleksij Rempel wrote:
> Refactor Energy-Efficient Ethernet (EEE) support in the LAN78xx driver
> to integrate with phylink. This includes the following changes:
> 
> - Use phylink_ethtool_get_eee and phylink_ethtool_set_eee to manage
>   EEE settings, aligning with the phylink API.
> - Add a new tx_lpi_timer variable to manage the TX LPI (Low Power Idle)
>   request delay. Default it to 50 microseconds based on LAN7800 documentation
>   recommendations.

phylib maintains tx_lpi_timer for you. Please use that instead.

In any case, I've been submitting phylink EEE support which will help
driver authors get this correct, but I think it needs more feedback.
Please can you look at my patch set previously posted which is now
a bit out of date, review, and think about how this driver can make
use of it.

In particular, I'd like ideas on what phylink should be doing with
tx_lpi_timer values that are out of range of the hardware. Should it
limit the value itself? Should set_eee() error out? I asked these
questions in the cover message but I don't think *anyone* reads
cover messages anymore - as evidenced by my recent patch series that
made reference to "make it sew" and Singer sewing machines. No one
noticed. So I think patch series cover messages are now useless on
netdev.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

