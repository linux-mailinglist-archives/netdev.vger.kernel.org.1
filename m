Return-Path: <netdev+bounces-263337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Cr/IkEYp2m+dgAAu9opvQ
	(envelope-from <netdev+bounces-263337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:20:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E670B1F4838
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D71C3021EA5
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 17:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06308439011;
	Tue,  3 Mar 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PsT6SkmH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11532351C31;
	Tue,  3 Mar 2026 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772558380; cv=none; b=ncTF0SGGrcVuRsre9RZj0M6JrJ+r+TTsJlCDEuVD9QfI5wjlRJhBHCaJC4OaKIqsFysXN5EDa375eTDnC2PTb3eFX2vJcRzuHsu/j71RIxLEuLL55bfu+Ao00gMDtmx1zI8on/kt6WhbrCQE1sNWkF1NDp9QZDDP/bexBWQxAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772558380; c=relaxed/simple;
	bh=Ca+ARr12/XdBIhnv7QrCLpRPeKuqqx38eJrQDvnhluA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lu2kGaBQsmDzFlk/IJOLUfEiX+WP9/9F6G3cyTYym/M/tRxLVJ8OhUEGvRxakOp0+4aiBly8Ceg6rr0cgdNiPLSFdK60pa1fdEEzoTxWdTgO1HwZawKE4sh06Pfs79wyhG537nUXLKPQP4RN6JR43movH3jdQAECAYhkp20ZtnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PsT6SkmH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FWEQDeYjZ/Kvx6qPEMl2sy6hl+csZIw5LCAMUKWoglQ=; b=PsT6SkmHwqV5c+BFaY/sSATpj0
	dahDe3Pnj8a6qokJxyJB4U4OolAl4dyJ+dbpeXihHVxwJ1RXwt3vMOSn9okNJ4Hrq0f0EHeP+VeV/
	GgbpNUa571Kdj5X0+tRKzX+SuNT1zY81z/YdFVtlijJp1T3K+2NPOqO9x5CWZNIJyg8Lgct2sFXZj
	Q+idnQF9keH4o4LoPiIKBHqr3ZpZ3aqfTHVys5XSmCeskb0acb3CwJkxPPuQ2TH3hwbGaneNH5LUQ
	0w0zHK4DggshS7iECxwkimq04+7qltJa19/b0j7AwQMxvdWbe0yElbZZy62HKBxN+OR+zY/OEGZTS
	Vf2OAD8g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47280)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vxTP3-000000005Qr-3lP3;
	Tue, 03 Mar 2026 17:19:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vxTOz-0000000076m-1NPo;
	Tue, 03 Mar 2026 17:19:21 +0000
Date: Tue, 3 Mar 2026 17:19:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: sfp: Describe and handle regulators
Message-ID: <aacYGTBobbfJgZpp@shell.armlinux.org.uk>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <aab51KbpIq72wtSU@shell.armlinux.org.uk>
 <9586950.CDJkKcVGEf@fw-rgant>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9586950.CDJkKcVGEf@fw-rgant>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: E670B1F4838
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263337-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.259];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 04:54:56PM +0100, Romain Gantois wrote:
> Hi Russell,
> 
> On Tuesday, 3 March 2026 16:10:12 CET Russell King (Oracle) wrote:
> > On Tue, Mar 03, 2026 at 02:54:25PM +0100, Romain Gantois wrote:
> > > Hi everyone,
> > > 
> > > This series describes regulators supplying the VccT and VccR pins of an
> > > SFP
> > > cage or soldered-down transceiver.
> > > 
> > > These regulators can then be turned on only when the SFP device is probed,
> > > thus saving power on systems which only load SFP cage support at certain
> > > times, or load SFP device descriptions via device tree overlays.
> > > 
> > > Please let me know what you think.
> > 
> > As ever, I don't want to be adding support for stuff into mainline
> > which doesn't ever get used - historically, we've had a lot of that.
> > So, any patch set which adds some kind of facility like this needs to
> > be accompanied by a user of it.
> > 
> 
> I understand, though I'm dealing with an out-of-tree board but I understand 
> that this doesn't really count as a valid first use case.
> 
> > This is especially true in this case, because I want to see why you're
> > wanting to have two regulators, when INF-8074 suggests that both VccT
> > and VccR should be derived from the same supply. The reason the
> > modules have separate supplies for the transmitter and receiver is
> > because the host side has the supply filtering networks to ensure
> > cross-talk between each is kept to a minimum.
> 
> Interesting, I wasn't aware of this. I thought it was something like "being 
> able to shut down the transmitter side only while waiting for a WoL packet".

A transceiver module is permitted to internally connect VccT and VccR,
which would make separate supplies questionable. See INF-8074, table 1
note 8, on page 22.

I suspect there could be boards out there which do have separate
control of each supply, but they need to be prepared for a module that
does physically connect VccT and VccR together on the module.

There is the problem that these documents do not specify which Vcc
pins supply power to the EEPROM, and if one powers down the supply
for the EEPROM, or the PHY/uC in the case of a copper module, that
could cause ESD diodes to conduct, pulling down the I2C bus. It
would also be out of spec. For example, the M24C02C datasheet from
Microchip states in 1.0 under the Absolute Maximum Ratings (beyond
which damage may occur) that for any input or output, the allowable
voltage range is -0.6V to Vcc + 1.0V - this is normally because of
the ESD diodes that clamp the input pin voltages to be within the
supply voltage pins +/- the diode drop.

Thus, powering down supplies to a SFP/SFF module while it's plugged
in and keeping IOs at their normal levels would have unspecified
behaviour, especially if there is no way to isolate the I2C bus from
the module and/or if other signals are actively driven or pulled up
to their "high" state.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

