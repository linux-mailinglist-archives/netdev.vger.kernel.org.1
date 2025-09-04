Return-Path: <netdev+bounces-219952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD05B43DBA
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4828B1C819D5
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5112EFD81;
	Thu,  4 Sep 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YXroj9DQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7318A956;
	Thu,  4 Sep 2025 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993940; cv=none; b=D3qH3Kw+oe8VIZXdtzGUJq1f7o/XCA7TEMeSYZf1hUXF4Y03uvbhRXy8Gt89Obr8fgokmzJ91QOAVXwPAVfDYiCpDeRIz3c1U0u4w6bjtHgQKGx4TAgVazD/We4DI5odWKo9ZeTNr3lAItA8YGTBgP9l6Hgdf2F57NOStHOmY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993940; c=relaxed/simple;
	bh=Mls69VKfWElYGVqggJF++7wDVfDhORSsd8b4fL4Wibs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5uk7juqwVS7d1MWQA/okLwfiqJLktEvEebh4jLktzAOEoY8xpyESH7GwfVZLlfcOPobkUHKcJ/meA+8yOf/PK0/S43vgvWDVAOKploik0N1kY86CgVLxam9ztXSz+sn/SaoD2R4Ex0aBHEFWjQX2xQWLX8Pfiul88i2GsIoFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YXroj9DQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jioOZ/YKP696h31GdxCKZH7S75Olh8LYI/7clG07OIA=; b=YXroj9DQwIFA53lTCR7LfFXm0i
	7L/PiLzUl4wRbv/I+ZCAx5xJH30otZKXQOVRSpqERsNvKRwz12aqTpdB7HXRTqO2O+GzJeK6K4Dec
	p6yD4CoHT4r9BhVtRZ6H4SINS6H9j81sRSgUFBkDdNAX5eDz+mcXAoHgGmzLjxb+wx+9InjGRPFul
	3eGDinWRPuKngBkrtjX1oMascVVgTkySUVABC6Qybv/1dRbJ8AH3JG4R7LMrdIl06Eki4AB4+TUiF
	zHAKIAHIAiRe64y2j2gUSaZVsPhiONC5f2VFV01PBOGzJxLlEncDxlgXS9FJsXR7N2TAn3i8UMrSF
	gXvwlM8Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57008)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uuANq-0000000025R-2HbV;
	Thu, 04 Sep 2025 14:52:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uuANn-000000001Zp-1hw1;
	Thu, 04 Sep 2025 14:52:11 +0100
Date: Thu, 4 Sep 2025 14:52:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net 1/2] net: phylink: add lock for serializing
 concurrent pl->phydev writes with resolver
Message-ID: <aLmZiwnGGSCS8Ll-@shell.armlinux.org.uk>
References: <20250904125238.193990-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904125238.193990-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 04, 2025 at 03:52:37PM +0300, Vladimir Oltean wrote:
> Currently phylink_resolve() protects itself against concurrent
> phylink_bringup_phy() or phylink_disconnect_phy() calls which modify
> pl->phydev by relying on pl->state_mutex.
> 
> The problem is that in phylink_resolve(), pl->state_mutex is in a lock
> inversion state with pl->phydev->lock. So pl->phydev->lock needs to be
> acquired prior to pl->state_mutex. But that requires dereferencing
> pl->phydev in the first place, and without pl->state_mutex, that is
> racy.
> 
> Hence the reason for the extra lock. Currently it is redundant, but it
> will serve a functional purpose once mutex_lock(&phy->lock) will be
> moved outside of the mutex_lock(&pl->state_mutex) section.
> 
> Another alternative considered would have been to let phylink_resolve()
> acquire the rtnl_mutex, which is also held when phylink_bringup_phy()
> and phylink_disconnect_phy() are called. But since phylink_disconnect_phy()
> runs under rtnl_lock(), it would deadlock with phylink_resolve() when
> calling flush_work(&pl->resolve). Additionally, it would have been
> undesirable because it would have unnecessarily blocked many other call
> paths as well in the entire kernel, so the smaller-scoped lock was
> preferred.
> 
> Link: https://lore.kernel.org/netdev/aLb6puGVzR29GpPx@shell.armlinux.org.uk/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

