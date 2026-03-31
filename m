Return-Path: <netdev+bounces-273789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDyVDCpczGlmSgYAu9opvQ
	(envelope-from <netdev+bounces-273789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:43:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E7B372E4D
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C66B73043D6F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEBB3B3C07;
	Tue, 31 Mar 2026 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3+X2J3Tr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A218138F92F;
	Tue, 31 Mar 2026 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000610; cv=none; b=gyKidTkPp4gqGBsNfIsDbUHp0bFbPtxiRhESNEHjMzdBWw059XSdYSeOD1LWEZViehqC+SmEYMHjr/emkHqiG9KebOQO/HDg5JCT4rxvzyXj49l/Q6mtSqBnn8hp7kekc7kwzy4gYyYVzlp0lWXTIXu3UoE5kSzvHfxPy2z7MAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000610; c=relaxed/simple;
	bh=BxqCnSY5nKYzQI+XSTwEMDaFXggstvf2XTqTNp0xoq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC5cQL+s23NCpKsRSf3Up/ykePIXT+dvPVD9sXao1nTxYVZeSiQnchTTBNgMl6O/nHuQg8QWG5dK+5ed7o1dABiwZH9el+uuDMvPl1tpjCxreYYVpsypIx4xJdwQw60hR331YnPUL2CZSYacWPLjnbYt3Fn4Pw7p4bSyZx/hkp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3+X2J3Tr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9LT9LB2eqfXMx5uo+MExWZWxWBdvuyNS0qeLk4248lM=; b=3+X2J3TrcbgNCa0HmPrP9NGcdW
	QadEwj9DMn2BWhtBUuVZUAmX+mQtsZCI1qPO5NWwDqmm0dlTMSGwDSK3FbpU7hdJBhAgkY2f5usup
	2e0rNKQ7MgFuIGbwMNK3wUYS42PVW0W7RnHgDGVWXpONG7C67kBiu1tcUyCk6y5jioTE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7ijs-00EG9L-H3; Wed, 01 Apr 2026 01:43:16 +0200
Date: Wed, 1 Apr 2026 01:43:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Charles Perry <charles.perry@microchip.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: mdio: add a driver for
 PIC64-HPSC/HX MDIO controller
Message-ID: <6b856105-401c-4e1c-88bc-9129efc5b733@lunn.ch>
References: <20260331123858.1912449-1-charles.perry@microchip.com>
 <20260331123858.1912449-3-charles.perry@microchip.com>
 <acvEpk1grDFAahzd@shell.armlinux.org.uk>
 <acvPKuuikqvfXauy@bby-cbu-swbuild03.eng.microchip.com>
 <acvUqDgepCIScs8M@shell.armlinux.org.uk>
 <88d652b9-ed4f-4bf4-b0ab-8703c15ce58b@lunn.ch>
 <acvdkBF4ZjZaCHwd@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acvdkBF4ZjZaCHwd@bby-cbu-swbuild03.eng.microchip.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,vger.kernel.org,bootlin.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-273789-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: A2E7B372E4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > > Andrew?
> > 
> > The general pattern is to not wait on write.
> 
> Ok, then it's status quo for this.
> 
> I'll send a v4 later this week for the other return issue.

Please consider adding a one line patch to phy_disable_interrupts to
read register MII_PHYSID1 and throw away the result.

     Andrew

