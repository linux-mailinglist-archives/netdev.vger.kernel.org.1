Return-Path: <netdev+bounces-219954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D946B43DCC
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023F0A0591F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF062D8771;
	Thu,  4 Sep 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T1aDiM3l"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4118A956;
	Thu,  4 Sep 2025 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994027; cv=none; b=TTIK2yUdR8aPKiWcOM0HMn7GzV8+LB+XUOImtlSp5Z7ySvkwG1YEs7+N2kvvZVNeBpthzNRFf8Us4V7E9iaN0I1ncDzenoTzsiWqnTVImHlKefrCHUUAsDUz5JDv+GxvEVcY006hDoqOgYfZwfevMuo3p61C6yyBKEGya5ng8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994027; c=relaxed/simple;
	bh=3JWvrSxs/VkPUPd7kJ+RfqaI4eUIer0kevDCwWpa1H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrnGKV+krKK4CHGGekVpA9/pXjP8lcoyzR4rtIt/x9HyKEtY1iByj0dRkUyC/nudIupADb/wi0lCNnuZDlBq6mC0MjKFzJ+lZ6Upq6FHITLperlGC3rLnP+KH7+lozYVHR8I7ru++yIesYQvyEivyxivumTYH/5m5H1Xu1QVKWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=T1aDiM3l; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WVRx4ACMo3uPYzrq8ZZJI3V5oxK2CXBawgeB+ZsH1pA=; b=T1aDiM3lt4WfZ820xv8tBd7nKM
	9lA48fWmw79ddq94FECn4nNnQRedKa+j/kx6Kb+W3smuRxFewf8nszQbU/kYOjQi6QzbyBNsJy+fJ
	t7SjAl96c4DUOF5cXbZtjYmKDTVi+8/R0eZxVuOsRFTrkFmRTtvdqX2LcqSon27TDcWqMu/wbHpAG
	wSk/P1qepEDTd+BVAFNAObzH+mRboC29sPhxHhL8/JgA2gHyuWSEXrUZnaGHU8poyIqimJJ6ZNtCp
	Y5lTFhnDRd5XjbiUJsno6OcXZwcLfMEaplYCbkBxBttQwpnaedYoDWjYNjGekkYmIuNBjsy772Md4
	Wy59nTQA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54242)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uuAPG-0000000025f-2k6Y;
	Thu, 04 Sep 2025 14:53:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uuAPF-000000001Zx-1GKJ;
	Thu, 04 Sep 2025 14:53:41 +0100
Date: Thu, 4 Sep 2025 14:53:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net 2/2] net: phy: transfer phy_config_inband()
 locking responsibility to phylink
Message-ID: <aLmZ5Ry8lPHf2Qvg@shell.armlinux.org.uk>
References: <20250904125238.193990-1-vladimir.oltean@nxp.com>
 <20250904125238.193990-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904125238.193990-2-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 04, 2025 at 03:52:38PM +0300, Vladimir Oltean wrote:
> Problem description
> ===================
> 
> Lockdep reports a possible circular locking dependency (AB/BA) between
> &pl->state_mutex and &phy->lock, as follows.
> 
> phylink_resolve() // acquires &pl->state_mutex
> -> phylink_major_config()
>    -> phy_config_inband() // acquires &pl->phydev->lock
> 
> whereas all the other call sites where &pl->state_mutex and
> &pl->phydev->lock have the locking scheme reversed. Everywhere else,
> &pl->phydev->lock is acquired at the top level, and &pl->state_mutex at
> the lower level. A clear example is phylink_bringup_phy().
> 
> The outlier is the newly introduced phy_config_inband() and the existing
> lock order is the correct one. To understand why it cannot be the other
> way around, it is sufficient to consider phylink_phy_change(), phylink's
> callback from the PHY device's phy->phy_link_change() virtual method,
> invoked by the PHY state machine.
> 
> phy_link_up() and phy_link_down(), the (indirect) callers of
> phylink_phy_change(), are called with &phydev->lock acquired.
> Then phylink_phy_change() acquires its own &pl->state_mutex, to
> serialize changes made to its pl->phy_state and pl->link_config.
> So all other instances of &pl->state_mutex and &phydev->lock must be
> consistent with this order.
> 
> Problem impact
> ==============
> 
> I think the kernel runs a serious deadlock risk if an existing
> phylink_resolve() thread, which results in a phy_config_inband() call,
> is concurrent with a phy_link_up() or phy_link_down() call, which will
> deadlock on &pl->state_mutex in phylink_phy_change(). Practically
> speaking, the impact may be limited by the slow speed of the medium
> auto-negotiation protocol, which makes it unlikely for the current state
> to still be unresolved when a new one is detected, but I think the
> problem is there. Nonetheless, the problem was discovered using lockdep.
> 
> Proposed solution
> =================
> 
> Practically speaking, the phy_config_inband() requirement of having
> phydev->lock acquired must transfer to the caller (phylink is the only
> caller). There, it must bubble up until immediately before
> &pl->state_mutex is acquired, for the cases where that takes place.
> 
> Solution details, considerations, notes
> =======================================
> 
> This is the phy_config_inband() call graph:
> 
>                           sfp_upstream_ops :: connect_phy()
>                           |
>                           v
>                           phylink_sfp_connect_phy()
>                           |
>                           v
>                           phylink_sfp_config_phy()
>                           |
>                           |   sfp_upstream_ops :: module_insert()
>                           |   |
>                           |   v
>                           |   phylink_sfp_module_insert()
>                           |   |
>                           |   |   sfp_upstream_ops :: module_start()
>                           |   |   |
>                           |   |   v
>                           |   |   phylink_sfp_module_start()
>                           |   |   |
>                           |   v   v
>                           |   phylink_sfp_config_optical()
>  phylink_start()          |   |
>    |   phylink_resume()   v   v
>    |   |  phylink_sfp_set_config()
>    |   |  |
>    v   v  v
>  phylink_mac_initial_config()
>    |   phylink_resolve()
>    |   |  phylink_ethtool_ksettings_set()
>    v   v  v
>    phylink_major_config()
>             |
>             v
>     phy_config_inband()
> 
> phylink_major_config() caller #1, phylink_mac_initial_config(), does not
> acquire &pl->state_mutex nor do its callers. It must acquire
> &pl->phydev->lock prior to calling phylink_major_config().
> 
> phylink_major_config() caller #2, phylink_resolve() acquires
> &pl->state_mutex, thus also needs to acquire &pl->phydev->lock.
> 
> phylink_major_config() caller #3, phylink_ethtool_ksettings_set(), is
> completely uninteresting, because it only calls phylink_major_config()
> if pl->phydev is NULL (otherwise it calls phy_ethtool_ksettings_set()).
> We need to change nothing there.
> 
> Other solutions
> ===============
> 
> The lock inversion between &pl->state_mutex and &pl->phydev->lock has
> occurred at least once before, as seen in commit c718af2d00a3 ("net:
> phylink: fix ethtool -A with attached PHYs"). The solution there was to
> simply not call phy_set_asym_pause() under the &pl->state_mutex. That
> cannot be extended to our case though, where the phy_config_inband()
> call is much deeper inside the &pl->state_mutex section.
> 
> Fixes: 5fd0f1a02e75 ("net: phylink: add negotiation of in-band capabilities")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

