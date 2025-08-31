Return-Path: <netdev+bounces-218557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0810BB3D2A3
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 14:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C110217D1CF
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F6119D89E;
	Sun, 31 Aug 2025 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZWycaXla"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3E1E868;
	Sun, 31 Aug 2025 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756641735; cv=none; b=WR/HevFyrmBbSGi/spwCDJ63FlS3xdYW4zGBih7cTrDLyrWilaoH7IeklhW5BxNwhva8c03jlITbj3PvtzC0AKl6n80fTudf7OVhpIXQ2M8A1PWfZK5xYJZmH0tc0p1R8eLwZTAMORSIpnpCvi+ZGToKAJaVarOK7gOd9SceeIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756641735; c=relaxed/simple;
	bh=ribR9/AuZOPpiMhK/w14rluUxwkT+8OamddhItszUaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3M7G4UMStKz9tZrKJdATWGhcMsgk3jxTBIF6MeEsPAFDLWcpAJPwcp9Z34AiTlT1ItyzDbIXwlofNtzQlu9i9rKWh9Y7hfwe2OJ0uC00t14+WkqNj7OyG+13N1g5IFxmbi4lP9ORRbQH6oTuETGwjQ4QV9zHMmwgtEI5Evw0U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZWycaXla; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Usc/bQAs5oZoelpx1f1OtvcvEsjxriw+T4TtYvBvWsg=; b=ZWycaXla7qvrzW5ZDVL7pMaxOS
	hbzyWbdZsvT65pvof02j5kSqRXTwVmBPptZfKG1A6Yl/hWIIPI6ynUS5sDSX40iUwJF9ampQcna8r
	6JVgkF2AXmrvBi6Hs//N4qXiAUrdX5qjtn60LfaWhF1FWAltT2d2CIfwyGhqe/4JSYWpbuj0yk7L1
	311spQ4agm8FWyuCQIh+bMYYpvEhqavgu6aFzkYrBhUOuMEmmwG3M5w1xOUIP4zmaWjjxlgT+X9C8
	zkNZnzZDxhaxcZ4BEPeUcjB6wGTzro1xIrE6dHlBWAWLKHu3/Bi8U8mrGsrVmN9bznSe8WWSHQWd9
	TMyucNHg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58808)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1usgl3-000000004tS-191w;
	Sun, 31 Aug 2025 13:02:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1usgl0-0000000062g-30Gu;
	Sun, 31 Aug 2025 13:02:02 +0100
Date: Sun, 31 Aug 2025 13:02:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sfp: add quirk for FLYPRO copper SFP+ module
Message-ID: <aLQ5upCX_TlhrBlB@shell.armlinux.org.uk>
References: <20250831105910.3174-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831105910.3174-1-olek2@wp.pl>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Aug 31, 2025 at 12:59:07PM +0200, Aleksander Jan Bajkowski wrote:
> Add quirk for a copper SFP that identifies itself as "FLYPRO"
> "SFP-10GT-CS-30M". It uses RollBall protocol to talk to the PHY.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

