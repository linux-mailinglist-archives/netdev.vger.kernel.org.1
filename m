Return-Path: <netdev+bounces-263280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAHuCvv/pmk7bgAAu9opvQ
	(envelope-from <netdev+bounces-263280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:36:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB01F2C0C
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B079306FE03
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9552A481FDF;
	Tue,  3 Mar 2026 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oRxNYFkw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B337481FC0;
	Tue,  3 Mar 2026 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551549; cv=none; b=aXgKm7q3Xf43lHKPAdLYJj2ZPSsRrWKEhsavEtDX6FQFU2Te3N34Ob0hdJrD7onfvBWPY1n32qyoawjkAgS4AGYBbBXaLrl6wpw7ulFp1xZ2AXQ90XMvILgRtsJdef7yIzkc24TT1h1cjl4NEhovJoVGT7aUIwFHuklJBu4Z8ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551549; c=relaxed/simple;
	bh=/C26syC9Ise1LgUY53DQ4PRhbY3Zn4GqHjOxYplOics=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXeMcl0of39LhPHMmzJoizqR5+zsAgqhNyUsUf8a3pozUhfd8EkpD54X1aOjPu/HJwStA0i5uPNimxRQ32RofdSoCy3p9raCopGSDb5BMMY+c97qP0db79EpP2FyOXXC3idU8kUsLM2fSQjj6HPQWkkfthRbJ959uMnoIYb31WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oRxNYFkw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YRbulbIhUbbvyG4w71EZHffhklu3RJDGWKEnLuozbpE=; b=oRxNYFkwzG+zI9Bl8vbdA6qtuD
	8lKH0UFz8QGoDq7fjgg7pN+v30/HKStxd2DXz2Lhyn5HBFiKAi0N83GZsky/LMwmYT3eoOSSkq8PJ
	53knfpSiPkHKi/+sCww4RyayEUKLknGlDTlijiyWcnGudqKGuE7G7pzu/voKDV1ZBO0wKV/c1TX6X
	6M9CETfjQpJz6/I0NI3j4z/lKpEBWeTrAdyHnS9WSaLi7rJZEKU5H2zzzP+YD+ZqI4Byp6Qj1Divc
	QMo/pMri7e4BxwUJxsCmjQfkJ6KN49MdS69ZuJKm6TglOf/ot8qSMdnqjvUjLB9esdH1Qn+swSF+a
	5d/VHHmw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60546)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vxRcv-000000005HC-2ojb;
	Tue, 03 Mar 2026 15:25:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vxRct-0000000072J-3Vth;
	Tue, 03 Mar 2026 15:25:35 +0000
Date: Tue, 3 Mar 2026 15:25:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: sfp: manage receiver and transmitter
 regulators
Message-ID: <aab9bwKSubR6zxKG@shell.armlinux.org.uk>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <20260303-sfp-regulators-v1-2-7101ae34cb84@bootlin.com>
 <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
 <aab6Tqo1z-8YQ4j6@shell.armlinux.org.uk>
 <536e57fe-9738-4026-a9c9-fdb7135cbe2f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536e57fe-9738-4026-a9c9-fdb7135cbe2f@sirena.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: 26BB01F2C0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263280-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.245];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.1:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,shell.armlinux.org.uk:mid,armlinux.org.uk:url]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 03:14:02PM +0000, Mark Brown wrote:
> On Tue, Mar 03, 2026 at 03:12:14PM +0000, Russell King (Oracle) wrote:
> > On Tue, Mar 03, 2026 at 02:22:40PM +0000, Mark Brown wrote:
> > > On Tue, Mar 03, 2026 at 02:54:27PM +0100, Romain Gantois wrote:
> 
> > > > If phandles to receiver and/or transmitter regulators for an SFP device are
> > > > found, enable them at probe time.
> 
> > > The driver should unconditionally request whatever power the device
> > > needs.
> 
> > ... and then we break everyone, just like you broke SATA, and I've
> > never forgiven you for taking a principled line on this rather than a
> > pragmatic approach. You're making the same mistake here.
> 
> Sorry, what's the breakage here?  The log messages, or something else?

... which then caused someone to "fix" DT by disabling devices to shut
up those log messages, including for platforms where those devices were
being used, which ultimately caused a boot failure.

... and your argument that SATA PHYs need these supplies, which is false
when the SATA PHY is integrated into the SoC and there's no details on
what those supplies are or where they come from, or even if they are
controllable.

Yet you demand that a SATA PHY supply must be provided, and so we're
stuck with:

[    1.207484] ahci f2540000.sata: supply ahci not found, using dummy regulator
[    1.213524] ahci f2540000.sata: supply phy not found, using dummy regulator
[    1.219630] platform f2540000.sata:sata-port@1: supply target not found, using dummy regulator
[    1.227800] ahci f4540000.sata: supply ahci not found, using dummy regulator
[    1.233757] ahci f4540000.sata: supply phy not found, using dummy regulator
[    1.239805] platform f4540000.sata:sata-port@0: supply target not found, using dummy regulator

on every boot with no way to shut them up. These supplies *ARE*
optional in terms of whether they can be described in DT.

As I've told you before, we have no information by which to describe
these supplies in DT on these platforms (not even with the data for
the chip) so you are effectively forcing people to "make stuff up" in
DT to shut up your warnings - blowing the whole idea that DT should
describe the hardware out of the water. How can we describe this
hardware if we don't have the internal design details of the chip?

The only way is to make something up, and all because you've decided
SATA supplies are no longer optional.

As SFP cages have not had to describe these supplies, requiring them
*now* will cause *regressions* because no one is going to be specifying
them, which will lead to stuff breaking. Again.

So, for the good of users of my SFP code, I will refuse any
introduction of regulators into my code for as long as you're take
the principled stance that regulators shall not be optional, rather
than applying a sensible pragmatic approach. You give me no option
here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

