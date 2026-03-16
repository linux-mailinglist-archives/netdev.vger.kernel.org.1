Return-Path: <netdev+bounces-268055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKGNJvvIt2kRVQEAu9opvQ
	(envelope-from <netdev+bounces-268055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:10:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 960C8296C08
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E99A9302B3B1
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A993793A2;
	Mon, 16 Mar 2026 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MhTkSR+O"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722AC38238C;
	Mon, 16 Mar 2026 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651811; cv=none; b=q4SPdWKE3P9OgTZMHQ95TyPDOnXFiUoIq/eEuyhHkxv43cRBVzSlPnevWZ7T3c78EQYjSg1e36oUqeTuoFQUmZKl+T3E0Pv4dkz7XWJrCggOEchkbrHcasoeoRauzyw9+h5hMwBvbN2pDhFsuNPRPeOTYIXMBBNqBsiwlDHPFNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651811; c=relaxed/simple;
	bh=5j4PLO1hnK9/bR8drxJpSC3gYAwLz+mJRyotjG4l4gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4zU3w52vleBHjSxHvYlm5chAYJlLxIjcu+vey1iXlnRzOdky/DVBfd6bGXFgm2S/rgjaNM5TiQL5C2Rn9GghY2z5pj8WsNSSuqW9saTTddctgLMjK+YiQm/DEKT1KRz2AONqQ6s0nmtkz2j+83XjdVR1+JYYWSUUf/MxwLsPQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MhTkSR+O; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x21XFiKWNX9OSKttQyxY4H13HZnCZYTMHuJhv60Nsyw=; b=MhTkSR+ONSdKHyO99rOR4NelmK
	EeNzxCC17brplbhzSS4XLCIaP23lo0lY470qFfFb7lUvkfraYhazE/cArAGUT5rMnJ+ThXRcDP9tJ
	N/B3Ol/B5g33wzaBR1lULFs2QvXrxWpNWvw9aF7XEQc/GZdXF6U8Au0rH3jYpnVkPQphbmneEWdIW
	OBKKs7I31VMXi/z6vKI9/RfGYBdry5Ofs18cQty9iafbqMJgaCx4x2uYk1ZEy/zC0NpvvNiDxsgr5
	IO4xiCkEgdmjZ6h2e/U/NIa5bFVZnAMO1wN216HbavaGtd5i9J2kyirLJo3BPFWYuCp0vf/h+JwZi
	SoKzALbA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44006)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w23r3-000000003Wg-3LDr;
	Mon, 16 Mar 2026 09:03:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w23r0-000000004wi-3A9F;
	Mon, 16 Mar 2026 09:03:14 +0000
Date: Mon, 16 Mar 2026 09:03:14 +0000
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
Message-ID: <abfHUrOpHnjv3GGW@shell.armlinux.org.uk>
References: <20260313105718.359614-1-christophe.roullier@foss.st.com>
 <20260313105718.359614-2-christophe.roullier@foss.st.com>
 <abPwHh12MLwMwOIs@shell.armlinux.org.uk>
 <CAD++jLmBP5Puwf1ZuFOzF6U0XowoF1nfqEL3gwLy-svXsXrbJA@mail.gmail.com>
 <abStv0IPLfkKMD-W@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abStv0IPLfkKMD-W@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268055-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,bootlin.com,nxp.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 960C8296C08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 12:37:19AM +0000, Russell King (Oracle) wrote:
> On Sat, Mar 14, 2026 at 12:44:56AM +0100, Linus Walleij wrote:
> > On Fri, Mar 13, 2026 at 12:08 PM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > > On Fri, Mar 13, 2026 at 11:57:16AM +0100, Christophe Roullier wrote:
> > > > In the deepest low-power modes, the pinctrl configuration is lost
> > > > and is never restored if the interface is down.
> > > > This commit ensures that the pinctrl state is set in all cases.
> > >
> > > Shouldn't the pin state be restored by the pinctrl layer?
> > 
> > What we have in the device core only applies "init" and "default"
> > states, and provides these handles for transitioning to "sleep"
> > and "default" again (like a state machine).
> 
> What I was meaning is that - for a driver using the "default" state,
> if the hardware loses the pinctrl state during sleep, isn't it the
> responsibility of the pinctrl driver to restore the state rather
> than leaving it in whatever states it happens to be when the SoC
> comes back from suspend?
> 
> If that is not the case, then don't we have a major issue where
> drivers using pinctrl but do not issue any pinctrl calls in the
> resume function are buggy?

I would like an answer on this before this patch is merged, because
even with your reviewed-by, I don't think this patch is correct.

For example, if pinctrl loses the pinmux state across suspend/resume,
then this patch only solves the case where the NIC is down when
suspending.

It does not address the case where the NIC is up but WoL is disabled.
Also, what happens when WoL is enabled at the MAC, when we expect the
NIC to still be functional - which means that the pinmux state must
remain active over suspend.

This is in addition to a more general concern that almost every driver
in the kernel is likely broken if we need to switch pinmux modes on
resume to ensure that the "default" pinmux state is restored upon
resume, which seems to be what you're saying by giving a r-b for this
patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

