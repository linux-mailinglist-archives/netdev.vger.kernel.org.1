Return-Path: <netdev+bounces-268603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHw3H6NVuWnYAgIAu9opvQ
	(envelope-from <netdev+bounces-268603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:22:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B762AAC67
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62B7C3040F3C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC25E3CA48A;
	Tue, 17 Mar 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EPue8tD3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D333A5E71;
	Tue, 17 Mar 2026 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753102; cv=none; b=hk0iGn32mTpqeVLf/gvYH2cVHTZ4qTcZotYxic/Fa7n62iB/bLy5JJc7O0Iq6aUUgw7fAhcNt0ICIgRddzqZCH10wqngCmq9lKcd3RaviCJMrTieCUb7MfuugedH7zjY9wcMPqI4+htzHkrxz1dx0qD86MRwSNdTyYZtFGAnL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753102; c=relaxed/simple;
	bh=J8k7FTZIqVHfmNw+1TbR8Tjv/+Yx+BVsPl6Elo2H/Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsIOzIOZ0kkmC30J+ZnJA9dnB8Xnl1SrE89oUx0wEwCu7Sss6sKGoNNQCj/PfqlRHwvuA76pzBjH+TNytkTkAn/f/8Mdn7dgxA/Sbq/Wq9t2KYYESEE9I5d7IsxWZ7paPkAdjpysyZA1fgF26r06WyNQMf4E0pN1s9g2HEPyiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EPue8tD3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wVX+e0F9KN8dfj/SwmnvICc5jP1yDHnEZ0Sn7ozoJNs=; b=EPue8tD3UjFJLyx+/NIDJIFQFG
	CCdoKdaIuUH7eJ+4tYTn/wTRk4U9UzHLkBcTwnYjtu/CHI3q1EnJ8OewQDOdHV574I/ua1i2KjrRW
	nkCrgvXJhhR+/9zsyJiTVlb6FfW43WjKokDq1KCt8MwUtRl/Xhx5k4HHazKF6A89/7AuzUZm8xC2T
	h9C/Ubvqtb3MjEYh2KUtoCR5RwEzeUDZXmkoBRnbDG+n2B3ALsAKXB2hM/XIu6N40n7ORJVbrI9t3
	3SASwFucwlFauZh+LFefZI35v/Uq8R7ND0OoYkbdR1cOhEutZM7ZBFcrngrETuzhPl+i1e5P8SoyB
	ajRZrEMw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59600)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w2UCl-000000005EG-45Ud;
	Tue, 17 Mar 2026 13:11:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w2UCi-00000000649-1jir;
	Tue, 17 Mar 2026 13:11:24 +0000
Date: Tue, 17 Mar 2026 13:11:24 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linusw@kernel.org>
Cc: Christophe Roullier <christophe.roullier@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	antonio.borneo@foss.st.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: stmmac: fix pinctrl management during
 suspend/resume
Message-ID: <ablS_C8oEQFeSU1Q@shell.armlinux.org.uk>
References: <20260313105718.359614-1-christophe.roullier@foss.st.com>
 <20260313105718.359614-2-christophe.roullier@foss.st.com>
 <abPwHh12MLwMwOIs@shell.armlinux.org.uk>
 <CAD++jLmBP5Puwf1ZuFOzF6U0XowoF1nfqEL3gwLy-svXsXrbJA@mail.gmail.com>
 <abStv0IPLfkKMD-W@shell.armlinux.org.uk>
 <CAD++jL=Av5K7Ag95LYou4TMKGR59TmtiQpxcnpcj+4tZFtzRug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jL=Av5K7Ag95LYou4TMKGR59TmtiQpxcnpcj+4tZFtzRug@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268603-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,bootlin.com,nxp.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.600];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 76B762AAC67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 01:13:14AM +0100, Linus Walleij wrote:
> On Sat, Mar 14, 2026 at 1:37 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> > On Sat, Mar 14, 2026 at 12:44:56AM +0100, Linus Walleij wrote:
> > > On Fri, Mar 13, 2026 at 12:08 PM Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > > On Fri, Mar 13, 2026 at 11:57:16AM +0100, Christophe Roullier wrote:
> > > > > In the deepest low-power modes, the pinctrl configuration is lost
> > > > > and is never restored if the interface is down.
> > > > > This commit ensures that the pinctrl state is set in all cases.
> > > >
> > > > Shouldn't the pin state be restored by the pinctrl layer?
> > >
> > > What we have in the device core only applies "init" and "default"
> > > states, and provides these handles for transitioning to "sleep"
> > > and "default" again (like a state machine).
> >
> > What I was meaning is that - for a driver using the "default" state,
> > if the hardware loses the pinctrl state during sleep, isn't it the
> > responsibility of the pinctrl driver to restore the state rather
> > than leaving it in whatever states it happens to be when the SoC
> > comes back from suspend?
> 
> Aha I understand.

I'm not so sure. My point is that if a driver binds, and pinctrl
ends up using the default pinctrl settings, then should it not
be the case that after a suspend/resume cycle, the pinctrl
settings remain configured in the default state with no driver
intervention?

This is my point - a driver that is unaware of pinctrl should not
have to do anything special in its resume path to ensure that the
pinctrl state that was configured by generic code at probe time
is maintained after a resume - that state should not be lost.

I'm trying to get an answer on this, because the original patch
description here says:

| In the deepest low-power modes, the pinctrl configuration is
| lost and is never restored if the interface is down.

stmmac uses the "default" pinctrl state at probe time. This commit
says that is lost over suspend/resume - which to me sounds like
a pinctrl driver bug, because on resume, the pinctrl driver is not
ensuring that the pinctrl state is restored to whatever it was when
the suspend happened (whether the driver explicitly changed it or
not.)

To put it another way...

On entry to probe for a non-pinctrl driver, if DT describes a default
pinctrl state, that state will be selected by core code.

On suspend, the driver is free to select another state if it so wishes,
or do nothing (e.g. it's unaware of pinctrl.)

On resume, the pinctrl layer, what is expected to happen. Surely, it
is reasonable for a pinctrl unaware driver, or at least a driver which
has _not_ changed the pinctrl state to expect that the default pinctrl
state is still in effect when its resume function is called - and if
that is not the case, then there's a bug here.

Another way to put it...

We shouldn't be expecting device drivers to have to mess with pinctrl
e.g. switching to a sleep state and then back to a default state just
to have pinctrl settings restored to a functional state on resume.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

