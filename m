Return-Path: <netdev+bounces-179718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E955A7E5D0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA1442452F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB58C20967A;
	Mon,  7 Apr 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Y7brdNK4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C01FF612;
	Mon,  7 Apr 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041765; cv=none; b=u/DooVRgpZpwMedJgo2NdOushXS6yOJhsxrzv/G2vrI1Mc1wd+yeWuoTKLquA/FdP5xu6qSxnmySpYrFAZaU1LqOJGVJspiKZ9UcwzaQ8oKYK9xxnbPcQGU/TpqLic2336X0QT5X7SghtdUQlXzwF8U33pkVGI9KQCvUOVE+kg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041765; c=relaxed/simple;
	bh=hiJ3fT1ox825yzWnFcIhZ9Yu7DI+fIxJr/WKZ2bpIDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCTvwtIWIRjdWvKXz37CrnygqEDQ7+wKqyctiew6IIUAAZ49F9qIcP9DmkN9IbZn8vegou/IZ4Z0Vxq2bA//Fp/nhaAtHYrOPW82+ehIPC6nEsPaxDwIht+ECAH/SGFBBvEkwoEfPilsy9s+E31FvuAtIM1/Ed7qKlNCM3pd+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Y7brdNK4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P8u7FBm5bMOio2OYhUxH103ncbBvCJ9P9eGnDVqb34o=; b=Y7brdNK4ulsORgCtQ3i41lVgCr
	Fk62Yedh9QBxkjhGpeYQN7ELL2hAX7+PiMAiNAd08/3bi+Cd6J8x4vMoHjAdRy3kJL3dedfTHitZC
	u+YTSi+WQgjuJXU08S2LmbXvw86hWqd2eqTK1kOGMyq7wEvMhlf6S+Yb2ozxVi8O95YJPyGRPczqm
	dEgJPAB35s4j3r/0XH0O/eeNNo7XWn+cK2YsbmVJJEyYQreoNdGKu435TwvMP/kXsPK6KcFUTXM8M
	MOYXKG57CjJYWyr1ozEwqKb1/7sHwlwnDmYhtnWWteDN7AE4wsbNBeHQlYEq0cNEY1+KWmP3R6of5
	scNRrd6g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36256)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u1ovf-0005co-1p;
	Mon, 07 Apr 2025 17:02:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u1ovc-0000Vv-26;
	Mon, 07 Apr 2025 17:02:28 +0100
Date: Mon, 7 Apr 2025 17:02:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 07, 2025 at 04:02:59PM +0200, Kory Maincent wrote:
> Add PTP basic support for Marvell 88E151x PHYs.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Is the PTP selection stuff actually sorted now? Last time I tested it
after it having been merged into the kernel for a while, it didn't work,
and I reported that fact. You haven't told me that you now expect it to
work.

I don't want this merged until such time that we can be sure that MVPP2
platforms can continue using the MVPP2 PTP support, which to me means
that the PTP selection between a MAC and PHY needs to work.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

