Return-Path: <netdev+bounces-149365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B949E5446
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF351675A3
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F9820C49E;
	Thu,  5 Dec 2024 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="panrZADX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A0420C485
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399054; cv=none; b=GGoMfcZ6TLZ76LYeU4ApkqOv4DWfNjCCuA995AaZiS6MDnJfUYwrkrJ8KicxcG5yqixQe9k6TyvI1AMSP6r9j/0dDREoURBxvKmkcBSeRAAjarQCGxlIkaOWxQxucSzmZ8hEStY2JQrTOuNGmuyOt5m7oKDXgI8vjvEBoFOR6zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399054; c=relaxed/simple;
	bh=SQSVCTlLMv5VGy6JUrV/B2IzGACC7P2o6NqFClYzSDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXg5cq/7y8OQixXf3gxhrsKuolWNs7eOCwLV46ANyRXu6N0KejWAJpchbHb4NN5/B0rvWLACmvMmi1cvIQufTPrdjl63jMn4oV7BPdNVRXoJAMx1yX7xrVbevuY1LiRlxDYMpPcXYFA1K++ii9hxtZgkjnUgQB1+3LcluhNtkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=panrZADX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9vJ5dEfxI5ASDiB05ls/GLsRW5xtuJVYYJTX88ZerKg=; b=panrZADXD1pGRW6Fj04adtBxOP
	s0K67YnYG/Spa+VEOJtY7AVP+ohSPcuW+7sQJPyF0Z6BBhmzWyFlTw4xyBNTYds4qRn93ud75655B
	CUpFXMHEAGlwGXpqOWOucmldh5aIPzDJCbgnwytKLpLXVGHVb78e8MHy/w06WlhRg4FIL8I2kicfZ
	yd3+kNRqej629ZfBlJVkU3qJIJjOCzFn4PWo0+JRFjQ2R0ZzCiOOi+G4b0ZnBk/Z47AIrBYFQRxHs
	+5SwA+maF45pct/ZDUveuGRFiseQCuWL48fMXxYZX3kvEzRyBFR41iZ2ZAhabZ4cr7fPTylBiNwlk
	xm5SCDNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36410)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJAH9-0004fJ-2z;
	Thu, 05 Dec 2024 11:44:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJAH9-0006Vs-0f;
	Thu, 05 Dec 2024 11:44:07 +0000
Date: Thu, 5 Dec 2024 11:44:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: phy: remove
 genphy_c45_eee_is_active()'s is_enabled arg
Message-ID: <Z1GSBwiasZBuSswx@shell.armlinux.org.uk>
References: <Z1GDZlFyF2fsFa3S@shell.armlinux.org.uk>
 <E1tJ9JC-006LIt-Ne@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tJ9JC-006LIt-Ne@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 05, 2024 at 10:42:10AM +0000, Russell King (Oracle) wrote:
> All callers to genphy_c45_eee_is_active() now pass NULL as the
> is_enabled argument, which means we never use the value computed
> in this function. Remove the argument and clean up this function.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I seem to have missed adding Heiner's r-b given in the RFC posting:

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

