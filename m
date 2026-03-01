Return-Path: <netdev+bounces-262423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VZo2E21ypGlYhQUAu9opvQ
	(envelope-from <netdev+bounces-262423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:07:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F17C1D0C9C
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81CBB300D972
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AEF30BB8A;
	Sun,  1 Mar 2026 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="d6LKEvGS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59F1946DA;
	Sun,  1 Mar 2026 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772384872; cv=none; b=NTx6wdHoyRznW3tpVgweT0WOVVltW5WGDmLPt+KHXwSXY4ZHp0ihQrXxRK7XUU520jYmxe+RkVhq600Gr/UJzg6s7Fky0q1UIwxvIC0jVM4AHKE8oolYXRp4QLKvI4nRyOZslRmUWHd2AzuzxFSpVceg2J9KW3avsnLh0IEgYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772384872; c=relaxed/simple;
	bh=57oS5bQ055k7ktuguXQEo4c6VIOAMuP9Bg/XniNWFO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBMoQ4T3v/IyGX6HRlnKJZ1PN8+37Vwar4wZhyT7/jw9pWsgjsJXdcH4JmEQxebzh0Km7MHQZuY3tqAz33wdOgi1SOfJvbPV7n2LerMAYUuGzvKrzBJVHIxWG6GAN16J3RjdlIZm18C0xPyyp6PVtI1UVNzL4uxZc/4dASXuwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=d6LKEvGS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Un622xDC7FnwWsu0nW9JjgLshgCEblzowGP4apXnezA=; b=d6LKEvGS8BNYQi0d3OOewd1fz6
	vJwVCNXB57XMxGSI8MrYy4iLS8vmJVTV5HEoUp1W1+Q8HD37klPQaxNhjPymWzXuGYC/1ksclu0fb
	/FbWmWCoQmHQVNg8CkZHN9tOvRE6i3BZEN5YDNVxrTqUj3o9ZPvp0UMFa7X2cN3IgyqfUbpIKLfSa
	nWBEQ9J+dlZlEb+ax2gjXoT0i8Dcy1nIi0rol8oiKeMUeE+6cqbCbbgke71UjLr/T0cEiMeuV9zsW
	z3/F5HlHe1psTb5Od3Nsmn+jfBhxxnhy5TZlggBJsSQ+cF+I2yMLExfr8UVFfeYQCuATdYagQWAX1
	lfbq53Pg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50382)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vwkGi-0000000038D-0dvH;
	Sun, 01 Mar 2026 17:07:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vwkGg-00000000597-1jXd;
	Sun, 01 Mar 2026 17:07:46 +0000
Date: Sun, 1 Mar 2026 17:07:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub =?utf-8?B?VmFuxJtr?= <linuxtardis@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v2 0/5] net: phy: Disable MDIO broadcast address
 on YT8821
Message-ID: <aaRyYomoTj6PEcVd@shell.armlinux.org.uk>
References: <20260228232241.1274236-1-linuxtardis@gmail.com>
 <d0b2a87a-e981-4245-803d-d57c401b6156@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0b2a87a-e981-4245-803d-d57c401b6156@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,motor-comm.com,marvell.com,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-262423-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 7F17C1D0C9C
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 05:06:58PM +0100, Andrew Lunn wrote:
> I can understand a PHY might support this, optionally, with a
> pull-up/down strapping, saying "Break the standard, also respond to
> address 0". But this clearly should be an opt in, and an extra
> component is required.
> 
> I'm still not convinced Linux should be handling either of these
> conditions.

+1.

> And even if it did, it should not be in the core, but
> hidden away in a driver.

It's not something a driver can handle, because by the time a driver
gets to see anything about the devices, we could've already scanned
the addresses and read bad IDs.

I believe we've said before that the board firmware should be fixing
this, not the kernel - I know I have said that on more than one
occasion about this broken hardware.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

