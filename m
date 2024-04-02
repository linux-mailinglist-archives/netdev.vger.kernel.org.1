Return-Path: <netdev+bounces-84156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6D3895C68
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 21:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC181C2204A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 19:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FAF15B569;
	Tue,  2 Apr 2024 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="m7Mol19y"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B815A4BF
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085895; cv=none; b=nKmbinDeDoW7WS3mC8XCWYFDLpNq6HAmUq9yWq2owKyqflF5H04av3eguuet+A1ZYNz8mHvJUM3e086tX9nJ4fxXMsjYuzw7Xfs3eNWI7mQdeBnjQ91aFWNpbHsZ3wvV/BBIY3wBCjZGdfFZVnAmZvm6FpKpU5Mheq+AM8edqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085895; c=relaxed/simple;
	bh=YNM5wy67WTubCB1YRaRsLm4JYyzWAeSSI2qq7nA8gXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzVYewGf25kwAhPtmmw21qIJj9XBGAXXevJsQyZtT7c6rBlMejzjn+jxjwYo/Q0eKqGtK2YzE3juIpvp1mfaudDSw8e+5XkO9DV/VHCbteClRloX5+2JSfsYFGGJ8E6pH9HGm5FDNMH6Q9CtlxtErj/X1QbI80LeB8YVqaJZkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=m7Mol19y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5Kx4OnritXdjTran63PhGH9xKYTcwY5ItAwi+gyI4uY=; b=m7Mol19yAmPu0ucaR3SAxna9AK
	HVhqSFZ5by7FW6PS8oqsk1sFYwJ6KOewgYFnRlUypkt1j930BsW+DVsmS1O9Rf8WJwNkUf2u4XnHQ
	uPH3TvvIUnzUa6ONajLLoemU0U79NE/LlD/Q6Q9dF4z7kBVdM3iPRwYNtLI79O0fNQIa2GHy7aThW
	1gmlEUhjvDWPj5eZGWp5w36P+2eWBmHiDCAsdaYBhhonmmzei1JYnVuG3PO46e41u5RQyQUz9YnX2
	NzOFsp3Ri1tcyO7Wwr9jZuyOtkDW5TYfPboQbf+5MjzRCwQvzzZSPMDXnim7ulybTAoHAbtLXyjki
	K+tgmmmQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46106)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rrjkS-0007Fk-1c;
	Tue, 02 Apr 2024 20:24:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rrjkS-0007C6-NA; Tue, 02 Apr 2024 20:24:44 +0100
Date: Tue, 2 Apr 2024 20:24:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 2/6] net: phy: realtek: add
 get_rate_matching() for rtl822xb PHYs
Message-ID: <ZgxbfPf6DSRtXuNj@shell.armlinux.org.uk>
References: <20240402055848.177580-1-ericwouds@gmail.com>
 <20240402055848.177580-3-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402055848.177580-3-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 02, 2024 at 07:58:44AM +0200, Eric Woudstra wrote:
> +	switch (val & RTL822X_VND1_SERDES_OPTION_MODE_MASK) {
> +	case RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX:
> +		return RATE_MATCH_PAUSE;
> +	/* case RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII: */
> +	default:
> +		return RATE_MATCH_NONE;
> +	}

Nit: Is this actually useful to have as a switch statement?

In any case,

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

