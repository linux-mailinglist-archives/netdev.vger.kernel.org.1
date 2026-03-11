Return-Path: <netdev+bounces-266711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJa4G2ifsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:59:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AB5267A15
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40C743013452
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024CF3E1236;
	Wed, 11 Mar 2026 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JzmL4OYI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88643E277F;
	Wed, 11 Mar 2026 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248357; cv=none; b=iA2bbUNg7mSPNcMGZ61N2/aCDkAm8G2rnvgtPm9Zo8DSE5VvYXIxa1ERgkmm/DC6G4+BXwfoH+Kdz2YLp2uaIcq68eOdnybeJ/njqzJep4K+RHHQmHD2Pluzpn1Mx6T7WHPb8RyaTJmD/qKtyQj2vAvFxCJ+hsyF8Tvs4kPlUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248357; c=relaxed/simple;
	bh=aPP5+Lpn9w2FqURG6pLJniGUGaWCGJr41lxWMQTcgcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHDSBTcP/ItZ+nM+OgbrbGeLhnNzESZyqIcRCdAuIZ0kIpAGa3iDAXFohdimjOsiKmkRUGsyD1dU3UeHrC3+h+Cm2GAMT2b3b6ynwiUrq/wjsn/BfSWvNZ5Fi9tEUfAkXe5/EjFvhOmdqoRGdn8OsXMHhxsnkE/223I/HH5xaqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JzmL4OYI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Az3cnZFilMdn5q62UDAm8yUyIxH4WAfr8yQyMccGVpc=; b=JzmL4OYIxXQcOCQEUgsWHhDbB7
	tLN3/IBdsnxWRaJwucok4mTBzDeEipsG8p7PGzNoAD61cJpsH9iUDQIQxnmWpVA5s14oNLxrfPEkZ
	TnwZBQ4G/QyrUe5/4nBb5Jta408COnu4YXG4IuRh2tIT0sCYrIPhD1qy8MILb2KaE3jWnljwKKJCc
	o5BRBlXPeVVbd7uUHnP16imZkoYz/2p/Ou7VZdfyFN1Ckh0cX9s3mrfmee1luZXiyhuDt00sU4Lmx
	OoGTHo98rvX5gvtrhL60JshJA1EpP/SYI9ciU/Z3aOEodF7ptW1u7QSmbwJvFtKhTLzMbaGxb7q7G
	Gj/I1xRw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47316)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w0MtY-000000006gk-24vO;
	Wed, 11 Mar 2026 16:58:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w0MtU-000000006OX-40aR;
	Wed, 11 Mar 2026 16:58:48 +0000
Date: Wed, 11 Mar 2026 16:58:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Divya.Koppera@microchip.com, Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v12 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <abGfSJ7nvkmbcdz8@shell.armlinux.org.uk>
References: <20260304094811.2779953-1-o.rempel@pengutronix.de>
 <20260309190953.7c0831b7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309190953.7c0831b7@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266711-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,pengutronix.de,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bootlin.com,denx.de,lwn.net,linux.dev,resnulli.us,nxp.com,iogearbox.net,vger.kernel.org,microchip.com,queasysnail.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 12AB5267A15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 09, 2026 at 07:09:52PM -0700, Jakub Kicinski wrote:
> On Wed,  4 Mar 2026 10:48:11 +0100 Oleksij Rempel wrote:
> > Introduce a new document, flow_control.rst, to provide a comprehensive
> > guide on Ethernet Flow Control in Linux. The guide explains how flow
> > control works, how autonegotiation resolves pause capabilities, and how
> > to configure it using ethtool and Netlink.
> > 
> > In parallel, document the pause and pause-stat attributes in the
> > ethtool.yaml netlink spec. This enables the ynl tool to generate
> > kernel-doc comments for the corresponding enums in the UAPI header,
> > making the C interface self-documenting.
> > 
> > Finally, replace the legacy flow control section in phy.rst with a
> > reference to the new document and add pointers in the relevant C source
> > files.
> 
> Russell, Andrew, does this doc look good to you?

Only just stumbled across your email - I haven't had a chance to look at
it yet, so can't comment.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

