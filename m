Return-Path: <netdev+bounces-259780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFuiDfPWmGl+NQMAu9opvQ
	(envelope-from <netdev+bounces-259780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:49:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A4716B101
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30E5A30089B3
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F8A2D3EC7;
	Fri, 20 Feb 2026 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GN0jKyAi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441201C84AB;
	Fri, 20 Feb 2026 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771624175; cv=none; b=N5jSIvT+kHRWyLMVAnCF1lw6hztt+RN0Xhm/3gye+1W1GQXABwf94EJdbH6b46hvqe7RbSJKUe61oL9BB2N77TCQKhbIutaTHuVKM5QiccI0ZXgPXj1Pzz0rV6fw5YtQMCQSJk0rHOSZKlqM9ohA8rEtDXGp6jPmXo26eYE+IlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771624175; c=relaxed/simple;
	bh=V+eoAGRkrsj0z+IjZ2v2Rq4DWFTe8YXVusgyYR/mgU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx0fUjdlpn7luPymD3RCHeFJJiGQSgtfFoUHZRTfnrV1ETQU70oYOfK0btrHNgZ3776J6OA4M8uqy2RbMGwlxSx7L4jUh9LT2vpPQxm45kJq8TAQP7m6dHyYUIMa0NV2GaLiop1BaSgJQrl/yIBmj+5WnM/RvrB99HFOMOpgugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GN0jKyAi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+VeijS7NlKPnw5vFoa9esSeWRS04KaWltEkWtGqAUTw=; b=GN0jKyAiVAYHDVSEmsgW+djV8T
	FDuDWtYKIq9Si9p/3Zop90frKssDzGuV9k5ywk/GLmzpVa47mtz0leizbkrQuhlbwQAkYo/8Dir+C
	FgQ6R6VVJ5jEL5Ma2uWPT0ElNQ+YNtuMIFtENIDaIr7xkmmxv7VHqRBIaB1Wzyndig5dCnkn6vLUw
	7pf3NQaz27GWki2qlAwaKlh0MiSh8XjRvU5Cq7BSgCg8SMIUu5RRe+nm/RYNWG30kvJdUuetgackM
	xcrAf0cZkEwT2mR2BB+jId9JfWKFlmba9Rz6BhtOj60d0rRMvjlFlBoTsBTl3UWrwNzNsiJGT1uXW
	I+euSoEA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37188)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vtYNI-000000002C0-0l6t;
	Fri, 20 Feb 2026 21:49:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vtYNF-000000004fv-3ca8;
	Fri, 20 Feb 2026 21:49:22 +0000
Date: Fri, 20 Feb 2026 21:49:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	o.rempel@pengutronix.de,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: micrel: Add support for lan9645x
 internal phy
Message-ID: <aZjW4dXiSepPNHQ1@shell.armlinux.org.uk>
References: <20260130-phy_micrel_add_support_for_lan9645x_internal_phy-v2-1-202ac31cf9c4@microchip.com>
 <92ba22ee64b2670448295b44d663d8ae7e8fe9c4.camel@microchip.com>
 <641d92a2-93fb-4ffe-89d8-77bf10edecf8@gmail.com>
 <1b14f42944d21fff1cb45132fe6dc9e5c18289a1.camel@microchip.com>
 <00f03a3f-fc12-4875-b4b5-7470e7f0452d@gmail.com>
 <aZjN48iisYaJ4xeg@shell.armlinux.org.uk>
 <4674c965-f4d1-4ba9-9e36-9d3bbbb37f64@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4674c965-f4d1-4ba9-9e36-9d3bbbb37f64@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259780-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8A4716B101
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:30:36PM +0100, Heiner Kallweit wrote:
> On 20.02.2026 22:10, Russell King (Oracle) wrote:
> > On Fri, Feb 20, 2026 at 09:50:44PM +0100, Heiner Kallweit wrote:
> >> No, BMCR_RESET usually doesn't reset configuration registers. That's why the
> >> function is called genphy_*soft*_reset. In case your PHY behaves different,
> >> which configuration registers does it change?
> > 
> > I don't think your statement is correct.
> > 
> > Looking at AR8035 for example, the WoL interrupt enable is doumented as
> > being cleared on soft reset. Smart Speed configuration also gets reset.
> > 
> > 802.3 22.2.4.1.1 states that setting 0.15 results in the status and
> > control registers shall be set to their default states.
> > 
> > So, we should not assume that setting 0.15 will retain configuration in
> > the PHY - at least phylib should not assume that a call to
> > genphy_soft_reset will not clear the configuration registers. If we
> > have code in phylib that makes that assumption, phylib is buggy to
> > 802.3.
> > 
> 
> Indeed I was wondering why c22 states "reset control registers"
> whilst the PHY's I'm dealing with don't do this. At least for the
> Marvell PHY's I used the spec says "resets PHY state machine".
> For Realtek the spec statement was "resets BMCR and BMSR".
> And often config bits are described as "becomes effective after
> reset". But yes, there may be PHY's implementing exactly the c22
> behavior, so we shouldn't rely on "soft" in general.

Looking at LAN8841
(https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/LAN8841-Data-Sheet-00004726A.pdf)
this states:

5.28.1 SOFTWARE RESET
The Gigabit Ethernet PHY may be reset by software by using the IEEE
802.3 standard PHY Soft Reset (RESET) bit in the Basic Control
Register. This resets all the PHY and all its registers to their
default state, with the following exceptions.

(none mention standard 802.3 registers)

An additional software reset is available by using the bit Software
Reset bit in the Control Register. This resets all of the PHY except
for its registers.

So, setting 0.15 will be disruptive to the control registers on this
PHY. Register definitions can be found at:
https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ApplicationNotes/ApplicationNotes/AN4783-LAN8841-Register-Definitions-Application-Note-DS00004783A.pdf

Bit 1 of register 31 resets the PHY without clearing the registers.

As one of their PHYs behaves like this, I suspect it'll be common
amongst their LAN PHYs. The KSZ PHYs seem to either be more like
Marvell, or maybe the documentation isn't clear enough.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

