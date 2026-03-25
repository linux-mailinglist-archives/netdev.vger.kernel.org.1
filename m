Return-Path: <netdev+bounces-271481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEZ6DJuxw2kktgQAu9opvQ
	(envelope-from <netdev+bounces-271481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:57:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B42D32287B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FF09306A312
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACAF3A3838;
	Wed, 25 Mar 2026 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z8x233+7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412D33DED9;
	Wed, 25 Mar 2026 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432560; cv=none; b=iK9buLMZHXmNsj/Xzk46LgyvYRqVjihYanTTEEHETMCmDc7NYP8nUdDzDEG0Ko/QQNUvMSZ2s8rgNvqQXSD/rptZVzAzXwLWRyI7/B0fbboXeG42WEAscmYjeYWkgNZgDP/mIyt2ityhAUkklzAW/FVWYTqMno4utmmDBrdAKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432560; c=relaxed/simple;
	bh=eGcO8nmKMF0kgmNqDIPpvsCqlsO5XrI1/W32NJH1C+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3aL7QJ9mU9+GXs7Def11fQimocBy1G20cBuLljhY9R8pP/FQeVx7/xQRp2TOMS/UvHIWhm3qTP+9moBQhot7fUfs3YSIpnLL4FY53KgHKOJeWADkiwOm8ssQgtVlQ7w4owKWD+eHWNz6x662FS0WzXUHMX0EwuCfCXpHZPP3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Z8x233+7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MrD/JzDrD0dZqQ/BKgHkwNPVPT9uW7xqNUxn9RdOSf0=; b=Z8x233+7/xEqjXlOVVGBNMEXlx
	4PiPESHRrXr707uK287cImoqPmojVVBPJjpiVHLP8K9o5bXrO+huTt6l5UZtjgdow0hyYQyewI6qB
	dT32Wx231olUTVkjaMDCdoE0HxdSh2PQBNWYNqzhPUpbLfVZa9mGfdcGMV6l99/nbaqi3JuWsCE/O
	p65OUFIr0EM7afi/FmlgJMmDaIqpLw0LAdkUkZv4NoWGSyxcYpeFInUdc/MoOof2CTfOowrMacfuq
	gDu3gemEl3fmL1dH19WvcRcuwPUBqM40rzNdpubjfZ82DGouFaBdNzPUIFR3/uSAiM2CSbcVfvIKb
	0QuMRIrA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54494)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5Kxf-0000000039n-2tj3;
	Wed, 25 Mar 2026 09:55:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5Kxc-000000005wp-1R1H;
	Wed, 25 Mar 2026 09:55:36 +0000
Date: Wed, 25 Mar 2026 09:55:36 +0000
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
Message-ID: <acOxGC7c5L6UwL8H@shell.armlinux.org.uk>
References: <20260313105718.359614-1-christophe.roullier@foss.st.com>
 <20260313105718.359614-2-christophe.roullier@foss.st.com>
 <abPwHh12MLwMwOIs@shell.armlinux.org.uk>
 <CAD++jLmBP5Puwf1ZuFOzF6U0XowoF1nfqEL3gwLy-svXsXrbJA@mail.gmail.com>
 <abStv0IPLfkKMD-W@shell.armlinux.org.uk>
 <CAD++jL=Av5K7Ag95LYou4TMKGR59TmtiQpxcnpcj+4tZFtzRug@mail.gmail.com>
 <ablS_C8oEQFeSU1Q@shell.armlinux.org.uk>
 <CAD++jLm5_mfx1572Cg+NPhuLoPu6DKDfOwK5XxRc4R_8M7kbYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLm5_mfx1572Cg+NPhuLoPu6DKDfOwK5XxRc4R_8M7kbYw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271481-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,bootlin.com,nxp.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shell.armlinux.org.uk:mid,armlinux.org.uk:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 9B42D32287B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:43:25AM +0100, Linus Walleij wrote:
> On Tue, Mar 17, 2026 at 2:11 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> > I'm trying to get an answer on this, because the original patch
> > description here says:
> >
> > | In the deepest low-power modes, the pinctrl configuration is
> > | lost and is never restored if the interface is down.
> >
> > stmmac uses the "default" pinctrl state at probe time. This commit
> > says that is lost over suspend/resume - which to me sounds like
> > a pinctrl driver bug, because on resume, the pinctrl driver is not
> > ensuring that the pinctrl state is restored to whatever it was when
> > the suspend happened (whether the driver explicitly changed it or
> > not.)
> >
> > To put it another way...
> >
> > On entry to probe for a non-pinctrl driver, if DT describes a default
> > pinctrl state, that state will be selected by core code.
> >
> > On suspend, the driver is free to select another state if it so wishes,
> > or do nothing (e.g. it's unaware of pinctrl.)
> >
> > On resume, the pinctrl layer, what is expected to happen. Surely, it
> > is reasonable for a pinctrl unaware driver, or at least a driver which
> > has _not_ changed the pinctrl state to expect that the default pinctrl
> > state is still in effect when its resume function is called - and if
> > that is not the case, then there's a bug here.
> >
> > Another way to put it...
> >
> > We shouldn't be expecting device drivers to have to mess with pinctrl
> > e.g. switching to a sleep state and then back to a default state just
> > to have pinctrl settings restored to a functional state on resume.
> 
> OK I see your point, the pinctrl hardware state should not change
> behind the back of the driver, and if it does, and that is worked
> around by these calls to restore the state using the pinctrl PM
> helpers become a messy quirk.
> 
> - Selecting those states to reconfigure pins into special modes
>   during sleep is OK.
> 
> - Selecting those states to restore the hardware state inside the
>   pin controller itself is NOT OK.
> 
> If this is done for the latter reason, you're right of course, there is
> a bug in the pin controller. Certainly it is expected to maintain its
> own state over a suspend/resume cycle.

Thanks for the clarification. So, going back to the original patch:

"In the deepest low-power modes, the pinctrl configuration is lost
 and is never restored if the interface is down.
 This commit ensures that the pinctrl state is set in all cases."

This commit message seems to be suggesting that the switch to sleep
mode and back to default mode is to ensure that the pinctrl driver
for this platform correctly re-sets the pinctrl state back to the
default state - which suggests that this patch is the wrong approach
and there is a bug somewhere in the pin controller layer.

That said, for platforms that do provide a sleep state for stmmac, it
makes sense to switch the pinctrl to that state even when the netif
is down. So, I think there's actually two separate issues:

1. the pin controller not restoring the state that was set at suspend.

2. not switching to sleep state when supported when the netif is down.

and fixing (2) will mask (1) which will be bad. So, I think (1) needs
to be fixed first while we have an easy-to-test case, and my suggested
replacement patch is a better approach for (2).

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

