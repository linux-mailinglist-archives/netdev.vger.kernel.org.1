Return-Path: <netdev+bounces-255167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMY8ITbFfGm+OgIAu9opvQ
	(envelope-from <netdev+bounces-255167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:50:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB83ABBBE9
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FC573002F61
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA26318ED1;
	Fri, 30 Jan 2026 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WH5B80zX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E072C11D7;
	Fri, 30 Jan 2026 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784624; cv=none; b=Ok2wTve3rMyO8vSJ4VKiQlNF2R477EiFYca1t7fRhct1bE/yRjr+ka9bUXbFfiZxzvKi82oLKROm/I+ZHTkDghjqSO0NZbwH4VGuYNUI90qmQFLVA5O4OmDTPOGJVzV9CtxrD3dyfuvivNKmlai+wvP0njrsutB2aGhHphM/gU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784624; c=relaxed/simple;
	bh=HXujmcHAS9+iwTW6ICXOooCX0MlY74Azq227cCjStKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4NpHNjDZSXry3n1aa5Dw5J2jt0wC+dZSKASt8LB1NmOM3RqThfLB5mZmMHHYFxIe3g9JZs97DubdG34DpLq9BQMwwJVcop3aiUlm6i98uIUzuwxVNwLa06KFygOAIGwsfT/taHU8RE0KbMetjuv0wK3/1MLqKqGCopshImk9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WH5B80zX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LZzYYZ47MhM5DbXuBFYv+5+5v+vkghMIaO5mgHVitCI=; b=WH5B80zX3ZnL/qn/O8PYSUOAQF
	/EGSfRNsE7jPycCz+dQZZzZe8SalMBbiZQXiHm4FltNSMewf03zVxDP/jFqYOUFGteKF3Ngv9ZlkX
	iFPNODNPoWnURYUS0Vhowsvpmae3wTfe19CCBUl2nXKX2jr7kMwHDiX5sVud9TSAtW5MiGjMh10pG
	76sp88yzPMDzxq3EWeO0W4PYsh00qKNcAxFD4gkSKRE7vAdrMWHXnzx+56maqPQhpm5ZlcDkkBM4I
	TqTTE7+ISJl9mtxhtXHZeSenO5EvjqZcSafwi0aQu66BUUbABkXv3Dkd8xHMQK889/gg8cyKUkp/c
	RVy6FFaQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35632)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlpp4-000000001Cc-1afO;
	Fri, 30 Jan 2026 14:50:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlpp2-000000000b3-0oEH;
	Fri, 30 Jan 2026 14:50:08 +0000
Date: Fri, 30 Jan 2026 14:50:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vinod Koul <vkoul@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, neil.armstrong@linaro.org,
	Simon Horman <horms@kernel.org>, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com,
	Ionut.Vicovan@nxp.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Frank.li@nxp.com
Subject: Re: [PATCH 2/4] phy: s32g: Add serdes subsystem phy
Message-ID: <aXzFH09AeIRawCwU@shell.armlinux.org.uk>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-3-vincent.guittot@linaro.org>
 <aXsuRTZUUnw0kdzV@horms.kernel.org>
 <CAKfTPtDfnpzq2CB-isVzvh1ZCWo7kit9KRJvVGoU1C3zZTgdXw@mail.gmail.com>
 <aXtfVUb0eLwP4R28@shell.armlinux.org.uk>
 <CAKfTPtCiJcNOdoddZN5N1dKHXfUJBe0=zeWfZ5uENoXDvbMnpQ@mail.gmail.com>
 <aXtl6eQ8zD_olTdc@shell.armlinux.org.uk>
 <aXtvDn_-pCuKPrnf@vaman>
 <aXtwfj1vqB1cXKFM@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXtwfj1vqB1cXKFM@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255167-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:url,armlinux.org.uk:email]
X-Rspamd-Queue-Id: EB83ABBBE9
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 02:36:46PM +0000, Russell King (Oracle) wrote:
> On Thu, Jan 29, 2026 at 08:00:38PM +0530, Vinod Koul wrote:
> > On 29-01-26, 13:51, Russell King (Oracle) wrote:
> > > On Thu, Jan 29, 2026 at 02:36:01PM +0100, Vincent Guittot wrote:
> > > > On Thu, 29 Jan 2026 at 14:23, Russell King (Oracle)
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Thu, Jan 29, 2026 at 02:01:13PM +0100, Vincent Guittot wrote:
> > > > > > yes, the usual pattern is :
> > > > > > - phy_set_mode_ext()
> > > > > > - then phy_power_on()
> > > > > > but I can add an additional check
> > > > >
> > > > > Please read Documentation/driver-api/phy/phy.rst section "Order of API
> > > > > calls" which suggests phy_set_mode_ext() after phy_power_on().
> > > > 
> > > > Fair enough.
> > > > That being said, all pcie drivers  that use phy_set_mode_ext(), call
> > > > it before phy_power_on()
> > > 
> > > It looks like many ethernet drivers do the same, so I think maybe the
> > > generic PHY documentation is incorrect or misleading, or is expressing
> > > a preference that almost no one follows. Something for the generic PHY
> > > maintainers to look at and/or comment on.
> > 
> > I would feel it makes sense to configure the mode first and then power
> > the phy up. As commented above yes it looks like apart from one tegra
> > driver rest seem to do it this way.
> > 
> > Lets update the documentation
> 
> Please also indicate in the documentation whether changing the submode
> of the serdes (particularly for ethernet) is permitted without doing a
> phy_power_down()..phy_power_up() dance around the phy_set_mode_ext()
> call.

Maybe something like this, which simply alters the documentation to
indicate that phy_set_mode*() is permissible prior to phy_power_on(),
and should be used at that point where drivers know the mode which
will be used.

Leaving the existing phy_set_mode*() in the sequence also indicates
that it's permissible to call this while the PHY is still powered
on.

For drivers such as stmmac, it will be important that details such as
whether phy_est_mode*() can be called with the PHY powered on are
riveted down and not left up to the generic PHY driver author - without
that, generic PHYs basically aren't usable from SoC/platform
independent code, and stmmac has bazillions of platform specific glue
already because of (a) bad code structuring and (b) lack of
generalisation through standardised interfaces that abstract platform
differences.

I want to be able for core stmmac code, or even phylink code (which
is even more platform generic) to be able to make use of generic PHY
stuff, but if the calls that can be made into generic PHY are platform
dependent, that is a blocking issue against that, and makes me question
why we have the generic PHY subsystem... it's not very generic if it
exposes the differences of each implementation to users of its
interfaces.

I think generic PHY has had the idea that its interfaces will only be
used from platform specific code that knows about the behaviour of it's
generic PHY driver, but as can be seen above, this will not remain the
case given that we have hardware designs where the core of the driver
is one vendor's IP that gets re-used across many different platforms,
but the SerDes PHY is one of many other vendor's IP.

diff --git a/Documentation/driver-api/phy/phy.rst b/Documentation/driver-api/phy/phy.rst
index 719a2b3fd2ab..cf73e4fb0951 100644
--- a/Documentation/driver-api/phy/phy.rst
+++ b/Documentation/driver-api/phy/phy.rst
@@ -142,6 +142,7 @@ Order of API calls
 
     [devm_][of_]phy_get()
     phy_init()
+    [phy_set_mode[_ext]()]
     phy_power_on()
     [phy_set_mode[_ext]()]
     ...
@@ -154,7 +155,7 @@ but controllers should always call these functions to be compatible with other
 PHYs. Some PHYs may require :c:func:`phy_set_mode <phy_set_mode_ext>`, while
 others may use a default mode (typically configured via devicetree or other
 firmware). For compatibility, you should always call this function if you know
-what mode you will be using. Generally, this function should be called after
+what mode you will be using. Generally, this function should be called before
 :c:func:`phy_power_on`, although some PHY drivers may allow it at any time.
 
 Releasing a reference to the PHY

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

