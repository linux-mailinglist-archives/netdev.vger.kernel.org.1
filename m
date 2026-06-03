Return-Path: <netdev+bounces-294805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qBSyDgpQIGpZ0wAAu9opvQ
	(envelope-from <netdev+bounces-294805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:02:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2746A639858
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:02:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=0auSrhjY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294805-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294805-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB01030FAB51
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D873C8C70;
	Wed,  3 Jun 2026 15:12:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33D33C2BA2;
	Wed,  3 Jun 2026 15:12:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499579; cv=none; b=B1MfuFulUQLbHgPSm27vc8p82wtEcbUdKnup/VJ9ad8439AHXdCW2EJi5LsAl1poYTG1cNUeR/Z3k0NrDuu/959gO5F7iBunXqDkztbCm5FkzTqkTB6aTq1bjZcBpAbnesobcuJaG1lhVjlhXZ7/KNUGv+Uy9f1BupFniSu4T7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499579; c=relaxed/simple;
	bh=wqT/NeCdh96ffasWjA0ZUW2cb8M6HKQLY5aV1SesoWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGzXm8y5pbqx4Ke5jsAX6Q4tLKW6N39W9PBCZ0SdiFIFf5yr9Tff0QtzWi1kWWO+14XO8H8zitJp3rKu/4oy6PLm1HIoZFq9/rrOWwfZTAQwyYqoiLv9GlcL42voBr5H1InKLKdvUDOu+WerRgdD76X8y5ASXal5KikVV6P3IZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0auSrhjY; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=K8VjJf/HUzNlS5O97pfTkpYfS/SCF01D92Z6GUyjNIg=; b=0auSrhjYn3zYJwOI8Dzfkp2Z6p
	UBhsa5fazcwoC3aNlQnHJVXaKX7q/BRra7Q1lsq7au+wKAcOmIInU4wmHQ6A8gbkMQt2HdgZJdyfp
	xN3KfnRvXOnuIcq9gxQQo27ruR63+Ix9/mQjAFf1xco6YC/3RK3Z04dASI7hl/5/Gabo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUnH1-005tpa-9S; Wed, 03 Jun 2026 17:12:51 +0200
Date: Wed, 3 Jun 2026 17:12:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Greg Patrick <gregspatrick@hotmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] net: phy: sfp: detect presence via I2C when
 no MOD_DEF0 GPIO
Message-ID: <6d602922-15c2-440c-b872-6b87c3e0a6e6@lunn.ch>
References: <20260602235528.2795028-1-gregspatrick@hotmail.com>
 <dd3c9c23-a9de-4505-8e49-97d4bf18f465@lunn.ch>
 <20260603143717.2985309-1-gregspatrick@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603143717.2985309-1-gregspatrick@hotmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294805-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregspatrick@hotmail.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[hotmail.com];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2746A639858

> > Did you try a 0 byte read? That is what tools like i2cdetect use.
> 
> I can't on this board: the cage I2C master is the RTL9303's SMBus
> controller, which advertises only I2C_FUNC_SMBUS_BYTE_DATA -- no
> I2C_FUNC_I2C and, notably, no SMBus Quick Command

O.K. So the board design is broken. To properly use an SFP you need
two byte reads :-(

Anyway, i was thinking 0 byte might be more reliable. We know SFPs get
all sorts of things wrong, even simple things like reading a word. Can
they get reading 0 bytes wrong? I suppose it is not a typical use
case, so probably yes :-)

So lets stick to 1-byte reads.

      Andrew

