Return-Path: <netdev+bounces-300844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id npFhCgvpNmpSGQcAu9opvQ
	(envelope-from <netdev+bounces-300844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 21:24:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B796A992A
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 21:24:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=6D6tNnXt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300844-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300844-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84B4B300405F
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 19:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C56369D55;
	Sat, 20 Jun 2026 19:24:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420551FBEBC;
	Sat, 20 Jun 2026 19:24:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781983490; cv=none; b=lxFP9sfoju8FNSLhV6zSGJjsm7qALXZROOospUlP3Z4D1/jR4flRGelADPv9XHhFezEmKSShj8azxUTBqtlnhUshMLIqZeLcKQfRXyX46Y8Cfken7AWPUrbj0BDbr4TiwLKyV8CtpBKgvXC2ocyS0mT8XUAiKzoKq0K7HH8HUnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781983490; c=relaxed/simple;
	bh=0EhfHHmd454sxOP6bZLi9rVkgwtyXZBFCpbo4ZcKf5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmzmAKg/BVmW0NZMWM7JCzr36EdkUodVB+6pwch/VGf/qqqKfM73CQz3nxybLEUGVJIpgQAdW9PIRHp81enYNvd2iFZtdqZ2SVEjNNAzR5XSCWLznT+aaBN680foWK8lONVW617DjJKwf4D1W9vGImoxOk2Jp3shNC+ei+R2kQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6D6tNnXt; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5Vr4wzBSMmUUn3FU+bTe35KUPQSu4QlPmHGB/7aG0pw=; b=6D6tNnXtQSl4hxbOe+OfrJd05v
	2ZteX0dAsB9NUN/1Ym88IooHpEz/2kJYTN3eZjpssNIbJ3GBwDmRAUuo6iAGU7kJmZGP+JvuPgdyl
	m1wsfOTqWzmobB3NUfgGaU7J3qr7bLMX9c/3/PvBNFWbQINVmMneY00wzYcUnEcNmlUI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wb1J0-008d5X-7q; Sat, 20 Jun 2026 21:24:38 +0200
Date: Sat, 20 Jun 2026 21:24:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk, vladimir.oltean@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: print correct c45 phy id when missing
 PHY driver
Message-ID: <f1900d7c-955d-4d7e-adfb-c66fc53a5a9f@lunn.ch>
References: <20260620131130.949298-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620131130.949298-1-olek2@wp.pl>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300844-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:olek2@wp.pl,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:vladimir.oltean@nxp.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[wp.pl];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nxp.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08B796A992A

On Sat, Jun 20, 2026 at 03:11:13PM +0200, Aleksander Jan Bajkowski wrote:
> If no PHY driver is found, `phy_id` is returned. `phy_id` holds the c22 ID.
> Modules with a rollball bridge support only c45 transfers. The c45 IDs are
> stored in the `c45_ids` structure. In the current code these modules report
> an ID 0x00000000. This may lead users to mistakenly conclude that the
> rollball bridge isn't properly implemented in their SFP module. This patch
> fixes the wrong IDs for c45 modules when a driver cannot be found.

The problem with C45 is there is not one ID, but multiple IDs. And
they can be from different vendors, depending on who the different IP
blocks have been licensed from.

We came to the conclusion not to report any C45 IDs is the most
meaningful thing to do.

      Andrew

