Return-Path: <netdev+bounces-253932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMCqCCLjeGkztwEAu9opvQ
	(envelope-from <netdev+bounces-253932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:09:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C1D97705
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A07633046AA4
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F1B355058;
	Tue, 27 Jan 2026 16:07:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA872DC34E;
	Tue, 27 Jan 2026 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530046; cv=none; b=JCQ3W3E29+k8g3IgyWC6qzV5WdhCjgs6HV/Ius3J9yd0GdWI51S2DDCtzuVAF2/rTv1lekw0AkfLKtWPPMBKOph259htJOtsQoNVbqRlhj7/G+JGiGaVsx50XNYkMIYwOYr/e/spkvKp24X6isCgmPR0wzyaV3L8SSuBp4oKZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530046; c=relaxed/simple;
	bh=NY9cb+akJlTJ+NzsdrBYWtGImGb9ceHiU09JJg2Gbts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX+lfxYf7vKx74xvLgPH4PqMs8WGEcmDdZZEQuA38sYHL6Qr9ncUy2VwtyAkDUCtOoMrYG7lc1O6KjUqh8Ps0dJUNBIB0GlFxY9HiTX1X49dCLJlmDANYcRt9FR2ZcslO5NshZ5O3JgMXEfyQshTmEbMOPCv8mfznlNMvLRz58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vklb1-000000001UI-27PD;
	Tue, 27 Jan 2026 16:07:15 +0000
Date: Tue, 27 Jan 2026 16:07:10 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v8 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aXjirjOsc5IJFHfH@makrotopia.org>
References: <cover.1769053079.git.daniel@makrotopia.org>
 <18c6a24eef8617abb5073569fee162f1aa1c06ea.1769053079.git.daniel@makrotopia.org>
 <c2e191c4-dec4-4e42-b108-353778d9bd18@redhat.com>
 <aXinOE7KIFIm5dUK@makrotopia.org>
 <5e7c2f9c-bf49-4564-91b3-a639ef1c97d8@lunn.ch>
 <aXjQKoXBIAkV06XE@makrotopia.org>
 <8f267321-25fc-447f-8ff3-5d5b2d844d30@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f267321-25fc-447f-8ff3-5d5b2d844d30@lunn.ch>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253932-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,makrotopia.org:mid]
X-Rspamd-Queue-Id: 93C1D97705
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 04:04:10PM +0100, Andrew Lunn wrote:
> > > int mxl862xx_to_zephyr_errno(u16 reg)
> > so that would then just be
> > 	return (s16)reg;
> > right?
> 
> Yes.

+1

Maybe better to check if bit 16~31 is actually zero as well, so
int mxl862xx_to_zephyr_errno(int reg)
{
	if (reg >= 0 && reg <= U16_MAX)
		return (s16)reg;

	return 0;
}

or

int mxl862xx_to_zephyr_errno(int reg)
{
	if (!(reg & GENMASK(31, 16))
		return (s16)reg;

	return 0;
}

or something like that. Let me know what you prefer.


> 
> > 
> > Or did you think to include the handling of the error __mdiodev_c45_read()
> > would return, ie.
> > int mxl862xx_to_zephyr_errno(int reg)
> > {
> > 	if (reg < 0)
> > 		return reg;
> 
> No, that mixes up real linux error codes and Zephyr OS error codes.

I thought of that 'int reg' to be the return value of
__mdiodev_c45_read(), so if that 32-bit signed int < 0 that means what
you get is the error returned from __mdiodev_c45_read().

> 
> If the MDIO operation fails, you have a real error code you can
> return. If the firmware fails, you will want to netdev_err() the
> Zephyr error code to aid debug, and then return -EIO.

+1


> 
> > Or actually translating the actual errno to a Linux error code?
> 
> Is it worth the effort? How many times have you seen the firmware
> fail? During debugging, it might be useful, but in production?

Some of the error values are useful, it *is* good to know whether eg. a
bridge cannot be allocated because (for what ever reason) of resource
exhaustion (-ENOMEM) or because of otherwise invalid settings (-EINVAL).
However, it is true that in production none of that should ever happen.
The driver will be able to predict and manage the resources of the
switch without ever hitting -ENOMEM, and make sure parameters are valid
before passing anything to the firmware. And even during development it
is good enough to see the error number in the netdev_err() output.


