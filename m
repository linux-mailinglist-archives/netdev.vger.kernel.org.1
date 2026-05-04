Return-Path: <netdev+bounces-283916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKBQHOi4+Gn1zAIAu9opvQ
	(envelope-from <netdev+bounces-283916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:19:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883B34C08FD
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AECC303B4E2
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAF23DFC65;
	Mon,  4 May 2026 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v8EOGJNf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277E212FAD;
	Mon,  4 May 2026 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907825; cv=none; b=lMwPZCoAH9kdZ8isR0POsU/emZbC1UaETyGk6osfX7YraYH9LOAgfLiAj/wZlSe0RSUPwiuvHJncRhnqFb+Bp3voIb774SbIRhBnFZPS/njrM1BYoC1vS5MLKRiOY1G7Vu4Tp7yc3EgzC3ZVk/U2PA61zmP7kTrCalxDO8vW6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907825; c=relaxed/simple;
	bh=Sa2svEuLBLZ8KH/j6RQ4fA5zFnL3S+2a01dYu7BXg3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4fuQEWo2YG/j5gH8wzWd5IgXYW6O6SPoUESF14ZVzqHlVI0Xduc/qJcHCr3D1iaQfLlRiextC2SYwLfqTBeXE35hKUXMHbOfF28p+eIZ2oSdMNXe9ORbDToEaaOo48oRWweoAdauJRtvhrzc3CuI9h08UAoCNEikCWrscHWNe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v8EOGJNf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t5mOwJSbOKVmcddoujovssiEkLg2+KNjkUu/7AIUfk4=; b=v8EOGJNfTFTqkEbMl40D58wnNP
	0OVyx4oJ9ioxV6r29xmzi/ohoTWDxEtBZFj4+U9j6oQFFzs0LZErYH/TQ1rrAh0wb/1Q33lklgNTA
	dbWilQeoz0xgbzgILqbZIsC5HB7V6nFBNP4M94NW6oe8uqgzePJd31QCIV+qDCsOLvC8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJv2X-001I3F-HC; Mon, 04 May 2026 17:16:57 +0200
Date: Mon, 4 May 2026 17:16:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1 0/5] net: mdiobus: HIde ACPI implementation
Message-ID: <28a4ebd7-2670-439d-836b-14559a916ed0@lunn.ch>
References: <20260504074610.40799-1-andriy.shevchenko@linux.intel.com>
 <aee27459-387c-46ce-9c06-3de66309c8d6@lunn.ch>
 <afij7wOkQUGUN0kM@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afij7wOkQUGUN0kM@ashevche-desk.local>
X-Rspamd-Queue-Id: 883B34C08FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-283916-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

On Mon, May 04, 2026 at 04:49:35PM +0300, Andy Shevchenko wrote:
> On Mon, May 04, 2026 at 03:02:54PM +0200, Andrew Lunn wrote:
> > On Mon, May 04, 2026 at 09:29:51AM +0200, Andy Shevchenko wrote:
> > > This mini-series is dedicated to hiding ACPI implementation details
> > > from the wider users as they (as of today) do not need to know that.
> > 
> > Please could you expand on that. ACPI != OF. They have different
> > bindings, so you need different implementations.
> 
> As of today the users that want ACPI also have the OF support. Even without
> that if the device is pure ACPI supported one (and somehow never going to DT)
> the proposed API (see the first patch) will be no-op in case when CONFIG_ACPI=n
> or when it's a non-ACPI platform with no support of the device. Hence, the
> pure ACPI (and actually OF as well) do not need to be exposed. The decision is
> made based on the type of firmware node.

I see two different things here:

You are refactoring code into a helper, so reducing the amount of
duplicated code. That in itself is good.

However, we have the problem in general that developers think that OF
and ACPI do the same thing. And that is not true. OF MDIO busses have
support for a GPIO used as a reset. In retrospect, that was a bad
idea. The documented ACPI binding does not have this, and if anybody
was to suggest adding it, i want to NACK it.

Having OF code and ACPI code to instantiate the MDIO bus makes it
clearer they are different things. fwnode gives the impression they
are the same, which is not true. Hence i don't like fwnode at this
level.

Where fwnode makes sense is deeper down in the implementation of the
bindings, for properties which are the same in both bindings.  Then
you can use fwnode_ for the shared properties, of_ for the OF only
properties, and acpi_ for the ACPI only properties.

So although i like the reduction in duplicated code, i think overall
it makes the code worse because developers are more likely to wrongly
understand it.

	    Andrew

