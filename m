Return-Path: <netdev+bounces-136918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8669A3A01
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34A21F25DF3
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AC91E1C2C;
	Fri, 18 Oct 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VY0r10MX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6188139587;
	Fri, 18 Oct 2024 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243888; cv=none; b=Vl+j3z9xzpKSMCJ/3krR64TzmE77qtb3ctDt9mdipdyD/LtH1sWmA+MLnl/98k0BzDij0B5gb+MJjtveykLapjbo+L3hjhw/T/Wvzd4zcBJHi2aQtxjGohjLZ0Snp1s2ToqcoLi15p5srkC/m56olbuzcHX5hwjEtCnJg3yYUXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243888; c=relaxed/simple;
	bh=i84Dwx1LB+rx8YIkwJVd9wiv9YsBexsdaLeMN5EpINw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEUcCDUDBrgeWmMogrYEilZUARd/PzJoanza7gJWelqxoz3/93XsY9bXGwLqBYuyb3Fn5z0VbtAUSxhf9rrC7sAgkN0c43Doucpx/gAwJ5E7E6dHB9dJQ7kvLEIWRYirKaCiHQN7dXRsmvHRgOSsLZYdcdEAhqAifYpKpp2Nutc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VY0r10MX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HlrpvQzAD74zpG/3GIoBLA8kbr31aQNRFZQK4Fk73F0=; b=VY0r10MXrN9/KTibX/0cBxVUqD
	VE7/7B1MR1tbT7/Pcc6fy4ctLa4apyToKbk7KUgbAK3ty6xImf+4Fs7iUDx0zdcDiqEYscfpLAUlq
	l4ISDQ1SCiH1lHe1wSCvfPNevz/NKTjejdFlv2KMUeKW230U59ityrajHFLBOiwwfJCczuLOEAZD4
	9ppriVgwcREP5pDdYtF34873tqElPSSBPE1v1F3t4uzl0rQDjgz/qfOt/YB6D+2rWQyW6zzoDUq8r
	AVUmN/eolaBrZ0LtcLwDq4MpH9+GBzUNB5czbNrMqE/B5XAjsHpWnkoH7jJMm7BnZdfRCe5vFrWkE
	Ps44qxUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47696)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t1jKI-0007uY-0V;
	Fri, 18 Oct 2024 10:31:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t1jKD-00077F-35;
	Fri, 18 Oct 2024 10:31:13 +0100
Date: Fri, 18 Oct 2024 10:31:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v2 7/8] net: stmmac: xgmac: Complete FPE support
Message-ID: <ZxIq4Q3GqdCEkK9D@shell.armlinux.org.uk>
References: <cover.1729233020.git.0x1207@gmail.com>
 <1776606b2eda8430077551ca117b035f987b5b70.1729233020.git.0x1207@gmail.com>
 <20241018091321.gfsdx7qzl4yoixgb@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018091321.gfsdx7qzl4yoixgb@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 18, 2024 at 12:13:21PM +0300, Vladimir Oltean wrote:
> I know this is a preposterous and heretic thing to suggest, but a person
> who isn't knee-deep in stmmac has a very hard time locating himself in
> space due to the unnecessarily complex layering. If that isn't something
> that is important, feel free to ignore.

That is driven by Serge, who seems to be driven by wanting the smallest
code possible with function pointers to abstract the minutest detail.
Like you, I disagree with this approach because it makes following the
code incredibly difficult unless one is constantly looking at it.

Serge wanted to do that to my PCS patches, and when I disagreed, he
stated basically that he'd convert the code after my patches were
merged to his style. So I deleted the patches from my tree. I've also
asked that stmmac removes its use of phylink because stmmac abuses
phylink and with Serge's attitude, it effectively makes it unfixable.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

