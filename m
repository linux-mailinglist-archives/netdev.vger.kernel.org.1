Return-Path: <netdev+bounces-163892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6479BA2BF63
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546B21600E1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C581A23A9;
	Fri,  7 Feb 2025 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pDw02Mcy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC318192D77;
	Fri,  7 Feb 2025 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920781; cv=none; b=U4SJEYHfn41DecgiMkXldmDwqCMYgugx9UBBb4+IYxZhuIUWMq/tmxykqoh6Oph3n+zaOZ+0JoVOxoKQgnQ/iGucf6rzC49MKR8qUesfP3t7T3ij2oE3woCMb0XRtYuFVn16AUrF7NS6TI278KiAz5ZPmOm5z+RFWJFbFF9iVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920781; c=relaxed/simple;
	bh=B1c+OTSM1c9tddOkoWptLmJtpLn+pT2dHbjYcfWCHXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhbxdTEyaMZk6DQQHsS550tyPHFbQ2Uj70QZZ92qpEZBIPCaMOJsEfQHnwWJgxdbbREkcghEdSIgFRtX/0gXqT0nejPNHfftdGuE4y5v+6DRyU9fmpYdupsOWScrWUja3Ko7+Nv7EHLZsyq/k7AcVbaugTHy//QOFXlrvMwNu1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pDw02Mcy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nkzd+ykZFKGd0XC0UyMNJ+RqDeQyoftDUT1KVX29vwY=; b=pDw02McyT/bUz32HFyhbXUb9ms
	bCRSkpUBZEmufrPStmWtkxH67IMQgzWPQMrqjd3P4yQK2o60CJ0uZGYPqI/fmU6oUjqZ1XCxCQX1n
	jub2CRmEMOdaADpTLvVQ5tkLCxhRjUQUJp2i/hqH11xNIzuDNq0wYFKmFdgLvic/FrSphkYGJJXet
	21yVFgvlyDC56gQf0tEY2xKZIDWoU28KioqFR/lCNsP6CUADaQtgWyPBj+ux1AfHcrtNizIG5cmgq
	d+qIkCIMwhI9xsWIqaKLlD5AHFVKJ9xXidMcAB1U3HUJmqU0sHFmXnpgTUD6xK/YvnPDcSL4werCv
	lNIDBWgg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38992)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tgKj9-0005AN-0T;
	Fri, 07 Feb 2025 09:32:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tgKj5-0004Ki-1Q;
	Fri, 07 Feb 2025 09:32:43 +0000
Date: Fri, 7 Feb 2025 09:32:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 0/3] Add SGMII port support to KSZ9477
 switch
Message-ID: <Z6XTO0PiaDiYZ4x8@shell.armlinux.org.uk>
References: <20250207024316.25334-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207024316.25334-1-Tristram.Ha@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 06, 2025 at 06:43:13PM -0800, Tristram.Ha@microchip.com wrote:
> The KSZ9477 switch DSA driver uses XPCS driver to operate its SGMII
> port.  After the previous XPCS driver updates are added the XPCS patch
> can be used to activate DW_XPCS_SGMII_MODE_MAC_MANUAL for KSZ9477.
> 
> The KSZ9477 driver will generate a special value for PMA device ids to
> activate the new code.
> 
> This will require the previous 4 patches from Russell King about
> "net: xpcs: cleanups and partial support for KSZ9477."

Great, thanks for using that work. It would be helpful if you could
reply to my posting with reviewed/tested-by as appropriate please.

Thanks again.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

