Return-Path: <netdev+bounces-272833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1a0EOOxRyGnGkAUAu9opvQ
	(envelope-from <netdev+bounces-272833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 23:10:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3217B3501BA
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 23:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75E733015CAB
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 22:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC9333D506;
	Sat, 28 Mar 2026 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D3vOlMJb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBA8F9D9;
	Sat, 28 Mar 2026 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774735849; cv=none; b=Og6J/YW3oFWHPJUh/uaPD5Rt9cLJYPEcdoGu6i1NbEZXv2qi661xbJTiD63BRTixuauFtkNiN29M70xocCsW7eu1d6gus/phqy9Jl17HZIi78fXmly/xsJqkUeiilWntKM2XDeEzEnUAXaBoP3FKUpWJGa+zaTh3EuwJd/eGwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774735849; c=relaxed/simple;
	bh=iCTYI9LuFiPlopteCbwNN76nGCEOa5sLbzNABrenOxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3FP+0DqgdAP6ra6SU1ZCQzp8FtTbhreSxSVnaa1NZdoBQOxQqIbYtogJgPqNZodmyZy3jaa9Ut0EUQ73SOfVpUwTNhhKK6fJ20iA4I43npx1OtQALeZHkhcMzZFTCHMAnjvsiV/v++JrhRnm//9yVzeVhIaT6tRYnVi0enjwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=D3vOlMJb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7+xh8xiXpqUgP1uEid640mnPB3EZMrtDdY9UTyqroGY=; b=D3vOlMJbnGqpNn4an25eNAtvWF
	B/slxqKYvhomBdo2gVhmpHGgi033xLSPycU9KEUBETVlus4PgJjvQIndxde2vpJSeCh3tACG895ZT
	hOAa3BjIr5AvWbsludiQKoX9ZjVQQNXJuVbuuuHn8uBeoMAJFytAWPWnRIMQ2kaE4+8FbWHdFWM3a
	lEue1zaaTEC2eZlG0cX6+WA7pf3KoljFZ8Pj1rAbaJe1ceST1P+0wYPKLzXg1Jbgn3nk2+N3n9xpJ
	uipDFsqQruLuzfE7V0aavXx/QYZXH34SMoLzJ5vprREypuQQFGJcCzHEzsEg1iJcoP1vR1JpZIdlM
	iAFx6BWA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42570)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w6brc-000000007VZ-2kTK;
	Sat, 28 Mar 2026 22:10:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w6bra-0000000012B-36Yt;
	Sat, 28 Mar 2026 22:10:38 +0000
Date: Sat, 28 Mar 2026 22:10:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jan Hoffmann <jan@3e8.eu>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for ZOERAX SFP-2.5G-T
Message-ID: <achR3vHgO1feCZje@shell.armlinux.org.uk>
References: <20260325164034.1542787-1-jan@3e8.eu>
 <20260327205020.1c020731@kernel.org>
 <58089a15-61e4-4899-b74f-2f5a495a206c@3e8.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58089a15-61e4-4899-b74f-2f5a495a206c@3e8.eu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	TAGGED_FROM(0.00)[bounces-272833-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.910];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3217B3501BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 09:02:34PM +0100, Jan Hoffmann wrote:
> On 2026-03-28 at 04:50, Jakub Kicinski wrote:
> > On Wed, 25 Mar 2026 17:35:58 +0100 Jan Hoffmann wrote:
> > > This is a 2.5G copper module which appears to be based on a Motorcomm
> > > YT8821 PHY. There doesn't seem to be a usable way to to access the PHY
> > > (I2C address 0x56 provides only read-only C22 access, and Rollball is
> > > also not working).
> > > 
> > > The module does not report the correct extended compliance code for
> > > 2.5GBase-T, and instead claims to support SONET OC-48 and Fibre Channel:
> > > 
> > >    Identifier          : 0x03 (SFP)
> > >    Extended identifier : 0x04 (GBIC/SFP defined by 2-wire interface ID)
> > >    Connector           : 0x07 (LC)
> > >    Transceiver codes   : 0x00 0x01 0x00 0x00 0x40 0x40 0x04 0x00 0x00
> > >    Transceiver type    : FC: Multimode, 50um (M5)
> > >    Encoding            : 0x05 (SONET Scrambled)
> > >    BR Nominal          : 2500MBd
> > > 
> > > Despite this, the kernel still sets 2500Base-X as interface mode based
> > > on the (incorrect) nominal signaling rate.
> > > 
> > > However, it is also necessary to disable auto-negotiation for the module
> > > to actually work. Thus, create a SFP quirk to do this.
> > > 
> > > Signed-off-by: Jan Hoffmann <jan@3e8.eu>
> > > ---
> > > Note: I'm not quite sure "sfp_quirk_disable_autoneg" is enough here, or
> > > if it would be appropriate to use the full "sfp_quirk_oem_2_5g" quirk
> > > due to the not really correct compliance code / nominal signaling rate.
> > 
> > I'm no SFP expert but just going by the naming I strongly suspect that
> > the module is the same hardware as "SFP-2.5G-T" from "FS", so keeping
> > quirks consistent makes sense?
> Based on commit e27aca3760c0 ("net: sfp: enhance quirk for Fibrestore 2.5G
> copper SFP module"), the FS module uses an RTL8221B PHY, so it is different
> hardware. And it also supports the Rollball protocol for PHY access, unlike
> this Zoerax module.
> 
> From the existing quirks, the only valid alternative I see for the Zoerax
> module would be "sfp_quirk_oem_2_5g" (which also sets the additional bits
> for 2500Base-T link mode and explicitly enables 2500Base-X interface mode).
> But as that is not strictly necessary for making this particular module
> work, I am unsure if using this quirk would be appropriate.

See commit 50e96acbe11667b6fe9d99e1348c6c224b2f11dd which added this
function. This was for an OEM SFP-2.5G-T where the PHY was similarly
inaccessible, can only run at 2500base-X without inband and offers
2500Base-T connectivity.

This is basically the same as your Zoerax module.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

