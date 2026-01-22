Return-Path: <netdev+bounces-252424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFIQHR9VcmkJiwAAu9opvQ
	(envelope-from <netdev+bounces-252424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:49:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EAA6A4B1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 860933009F0F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527393783D5;
	Thu, 22 Jan 2026 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="J2e52Lwy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349C3783D8;
	Thu, 22 Jan 2026 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097889; cv=none; b=CnClefzQ1Q2B7ewPEXJk1hEbjHtE8bSepD4mUpcMruLrOLC+spSUpjlkHbCk2LgFjwnHZieVlWTtV94Lf8jbPmlB7APrm28Pt5hW+DTo8dMc6kT2VP6OjsBcc+0U/OBuRtQpjothEOEHY22G1BCe948g1xasspVMH5sCh0b7dAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097889; c=relaxed/simple;
	bh=4EBQIdGZsDGt5LpjHJ0hgvsGwK+wpd4MDJekE2tbQec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB5z7aghlOArFIxSIgbq8BedpdGdUmniQ7eDHTJUKd7w4NbBTJe9UKNntYU7uyRMhrryP8gSipjbk4gR9ruHBwd1kjrMek+lqaPeIZzhRXHRkDK1P9nhKedK6F3H4X20bgpOQSaDnWRWS+AVdE7SiNvLtSNnsq3fbBtjU+fldI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=J2e52Lwy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=yF87tQDfmCy5Tvh/RPnBLWnSAMsaiL33neMbXbvwmxA=; b=J2
	e52LwywCUdXeS0lnw9oHIvFuyCuVsT8F9q1HiTAGC0Ymx8vaeOqZwW89iWSLQPTjl5VyA1kMvh96N
	AjJb8yOCBSpu6b0sDaG44gVbhXh0IfGXFK7Z8rf41k4FXIcm32YuhfZc5dfc2qvC07SO9auNDFx2H
	VuWOm5nqfB2jj1g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vixAb-003zkx-SI; Thu, 22 Jan 2026 17:04:29 +0100
Date: Thu, 22 Jan 2026 17:04:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
Message-ID: <92538fd0-aa1f-429b-9984-89bcd46e2a28@lunn.ch>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
 <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
 <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>
 <5e7c71f6-80dd-408b-a346-888e6febf07a@lunn.ch>
 <fcf7b3f2-eaf3-4da6-ab9a-a83acc9692b0@bootlin.com>
 <fe1bf7b6-d024-447c-a672-e84f4e77f8d7@lunn.ch>
 <91442f3f-0da9-4c52-89ce-2ca0a3188836@gmail.com>
 <66e8424c-86c9-4ad7-a3a7-3c277bfa5432@lunn.ch>
 <d223bf52-ba2a-4185-930d-e9db9dac9d80@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d223bf52-ba2a-4185-930d-e9db9dac9d80@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252424-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[bootlin.com,armlinux.org.uk,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: D1EAA6A4B1
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:14:03AM +0100, Jonas Jelonek wrote:
> Hi Andrew,
> 
> On 18.01.26 16:39, Andrew Lunn wrote:
> > On Sun, Jan 18, 2026 at 10:43:12AM +0100, Jonas Jelonek wrote:
> >> Hi,
> >>
> >> On 16.01.26 15:25, Andrew Lunn wrote:
> >>>> But let's first figure-out if word-only smbus are really a thing
> >>> Some grep foo on /drivers/i2c/busses might answer that.
> >> Did that and haven't found any driver in mainline which is word-only.
> >> All drivers with word access capability have byte access too.
> > So for the moment, maybe add a WARN_ON() for an I2C bus that only
> > supports word access, and we can deal with it only if we ever get a
> > report of it firing.
> 
> Should it just have a WARN_ON and continue (so it may work in some cases)
> or fail at that point? 

I guess doing a word access when a byte access is wanted will either
work, or immediately kill the I2C bus because the SFP is broken and
only supports byte access, and the dead I2C bus will cause a cascade
of errors.

So continue seems reasonable and hope for the best.

   Andrew

