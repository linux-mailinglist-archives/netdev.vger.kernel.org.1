Return-Path: <netdev+bounces-88114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 792CC8A5CB8
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 23:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190871F23953
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 21:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25DB156987;
	Mon, 15 Apr 2024 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PReRQ1eO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD51DFEB
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215561; cv=none; b=FM69iWpVw3p46WQem6q5DzUq5QExKBjGpx2rk7P8p7QA/UnJCnu+1ChMISgQhMu9nqf3+M81+XvU9JfMbhdlXVAx0bVDtSgQ3mjZeC0AEmWyekoiOKLm7DTNJ1C3TgG1UculN+rr3VOURTuecLGIqAuArzaViNYCgav3myVUVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215561; c=relaxed/simple;
	bh=kZiOkKI05Osd1GdLJY6ZMf/jsn4bZKG9G+Jv1eBu6ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1fU/2wpH2G+7od3nuogWQC0VuvJ2mUeS8IqpHSnSJB57CAVlCvvwrBkZxjFqBDArbTWw0pxqBxqJpNRm6y8+Xz2svliIx9Dg6/N2MUNFB4DsisymQGCC4FXtdKN/vQRt+b+HTxK9lYxUrtfFuvEr+cckW7JahVQV10eh9ogIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PReRQ1eO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rWrgQpyI1nGSK/7EgokvyBb4TKGm/gFS2vuqxkHiwdY=; b=PReRQ1eOYbVTvRpTbWKhN7CROi
	WFcVBf5Fmt8jemx0HIQsfaUELTtGmnvDfPEudCUaPtgQZ4Xe3XUJT/h01t6jf0ZumnyJYuVdk1TOV
	edHhukMYD115TNwqwEObbsnEmYkgrNo3hblgKSRSFKVY3M6a+ChbGUsNJG7xcC1NJjG1XneyGjqxh
	VJYiUgHuqTqDKqP9t9fkFcGuHVJ+3d74pYqkHRpRK1o1rta0xa+s9pxw+O5/WRDmi8kD9k5nkfrKL
	AWYgHgmrrbUcI+UShBCxS2n7mCwz/pShj4SaW5B3NUDSfptki9Hl5mmFs/4RY5Qctoj9UyhZJW+pC
	pHwpk/jQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33540)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwTcn-0007JF-0b;
	Mon, 15 Apr 2024 22:12:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwTcl-0002V1-AD; Mon, 15 Apr 2024 22:12:23 +0100
Date: Mon, 15 Apr 2024 22:12:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: felix: provide own phylink MAC
 operations
Message-ID: <Zh2YN992dZuAREcZ@shell.armlinux.org.uk>
References: <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
 <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
 <20240415103453.drozvtf7tnwtpiht@skbuf>
 <Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk>
 <20240415160150.yejcazpjqvn7vhxu@skbuf>
 <Zh1afZNFnl0DObX0@shell.armlinux.org.uk>
 <20240415201359.5sw6wa5imcc6gaft@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415201359.5sw6wa5imcc6gaft@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 15, 2024 at 11:13:59PM +0300, Vladimir Oltean wrote:
> On Mon, Apr 15, 2024 at 05:49:01PM +0100, Russell King (Oracle) wrote:
> > Sounds like there's an opportunity to beneficially clean this driver
> > up before I make this change
> 
> Yes, it is.
> 
> > so I'll hold off this patch until that's happened. I probably don't
> > have the spare cycles for that.
> 
> Alternatively to you waiting, I could pick up this patch and include it
> as the last one in the cleanup series, if you're ok with that.

Sure, please do. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

