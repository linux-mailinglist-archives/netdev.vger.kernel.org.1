Return-Path: <netdev+bounces-307602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cWW8E2uyVmoxAQEAu9opvQ
	(envelope-from <netdev+bounces-307602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:04:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B63397591D8
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:04:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=DouM8fYl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307602-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307602-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1645C30433E9
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CB7418A3D;
	Tue, 14 Jul 2026 22:04:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADA39CD05;
	Tue, 14 Jul 2026 22:04:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066653; cv=none; b=rOmSrV5SVtA/NyEZVr1iq/SSq1Y2Y8IdADSWEJ33Et9HyS82Gsiy1Wcr7PTWuhBVJecG4llcYoPPz6/D3Pf3nIPpVnG10TylQJan5VPg8NhniPs/pNyfWP+xnC9Nsx1Rq1CWJ9kZslksbp8cd+RnVU8vjcxm6Gz6MQ4vRkzrAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066653; c=relaxed/simple;
	bh=EkdudOmWOyGCSMTXiUF6NJg4sRrCTsW5TANWSDrXATY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjEer/rXBl9dcj3G+i5gMAcCo0tptf1fmkyz1VnbiNb3nVVZ2cfaH603wx/Sb6Mh+nmkawmiw1yj/t9/mwkI2MHven5wfmjauDYCGt1QkKuGB5WqFirLbWYMq/cGa5oILvpzhUN+zgMMJpBIzT0DSDQgyyMtKcOUi6BzIOgxgBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DouM8fYl; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0eHHB8d2B7vvbxeAkpIrsxCHbE+widNpIqnbeNGWuvg=; b=DouM8fYlXxFXPcKUZjsgpqXBxD
	RFZbc5FGlSVhHD/ByrqaJw0XNxPaFxA80j866KAAl1LQ1orIneU2Lh4VoP855IZaYD+iojurmbzTG
	cSZqBozqnDng0T4bjmk1mq7D/uaTeEzeOvyZbLXEWR2o1Zx+fouQp+AvxstzxE02t3Tc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjlEQ-00CG0g-H3; Wed, 15 Jul 2026 00:04:02 +0200
Date: Wed, 15 Jul 2026 00:04:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Walle <mwalle@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: phy: sfp: drop 1000Base-T support for
 FCLF8521P2BTL
Message-ID: <c62c33be-0082-4e4a-8f13-2e14e851e975@lunn.ch>
References: <20260714125008.2466023-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714125008.2466023-1-mwalle@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307602-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mwalle@kernel.org,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,coherent.com:url,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B63397591D8

On Tue, Jul 14, 2026 at 02:49:34PM +0200, Michael Walle wrote:
> The FCLF8521P2BTL is marketed as a drop in replacement for fiber
> modules using 1000Base-X autoneg towards the host as default. See the
> referenced application note, esp. question #11. Drop the 1000baseT
> capability, so 1000Base-X will eventually be used.
> 
> This is esp. important if the TX_DISABLE pin is not connected on a
> board. Usually, pin is used as a reset line to the PHY on the copper
> SFP. If a bootloader expects the default mode and doesn't do any
> reconfiguration of the SFP module, a link might not be established.
> 
> Link: https://www.coherent.com/resources/application-note/networking/1000base-t-sfp-faq-an-2036.pdf
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> I'm not sure, this is the correct place for the fix, nor if it goes in
> the right direction. There is a comment in
> 
> /*
>  * Clause 22 copper SFP modules normally operate in Cisco SGMII mode with
>  * negotiation enabled, but some may be in 1000base-X - which is for the
>  * PHY driver to determine.
>  */

The reason Cisco SGMII is used is so you can support 10Mbps and
100Mbps, as well as 1G. If all you can do ix 1000BaseX, supporting
10/100 becomes harder. If the PHY is clever enough, it can send pause
frames to slow down the MAC. But that requires the PHY actually
converting the bitstream from the MAC back into packets, performing
packet buffering, and then creating the new bitstream at a lower
rate. Some multi-gigi PHYs do this, especially if they implement
MACSEC, but few 1G PHYs do.

Normally, if the PHY is in 1000BaseX, the PHY driver will try to
reconfigure it to SGMII. However, There are some SFPs which are stuck
in 1000BaseX, and there is no access to the PHY registers, so there is
nothing we can do.

Looking at the link you provided, this SFP has a Marvell 88E1111, and
its registers are available. So the Marvell PHY driver should
reconfigure it into SGMII mode.

Maybe look at the marvell PHY driver, and snoop what it does when it
configures the PHY.

	    Andrew

