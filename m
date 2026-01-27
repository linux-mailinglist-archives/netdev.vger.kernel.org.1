Return-Path: <netdev+bounces-253984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K6XBrwNeWnyugEAu9opvQ
	(envelope-from <netdev+bounces-253984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:10:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D7199A97
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F70B300AB04
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CBE366076;
	Tue, 27 Jan 2026 19:10:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21EF364E95;
	Tue, 27 Jan 2026 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769541049; cv=none; b=SgDmZ+qb3K5zOQ7xQlU8SYeEUdUnSPstqeYW5rcDOoN1clvpdbYV/K09YI1KfpOUSkEeHsvV/ihrzXR3sEkf5hXOjn2B+ukHZHOb/pPbmECJSCipGYlhnCdD3jpc7ZelfVT1gTiUMx6HeU2LVqI9aBkZz+ikCIzweqj7Z7oF09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769541049; c=relaxed/simple;
	bh=TZIdSLXmIauKxvF1SwbChtRMQd40Hew97TKUK2jdNfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSFmUR+vpi4SvbStAMsNXLHwx+voTicX61+eOBlCiN5Hf+D6XBCBEoVjF+zE4wi+Yr3XsRKzU7CsfKww2MGkDPes1v2202RPDoL6jyRHSZOkQvdeYGtQJtNNolMZ4z2jOk3tcQYU3gTI0vAUxVdSQXzp5ehb38dZXXaymvMZeYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vkoSU-000000002Sb-1IRu;
	Tue, 27 Jan 2026 19:10:38 +0000
Date: Tue, 27 Jan 2026 19:10:34 +0000
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
Message-ID: <aXkNqmiUoWZja4gg@makrotopia.org>
References: <cover.1769053079.git.daniel@makrotopia.org>
 <18c6a24eef8617abb5073569fee162f1aa1c06ea.1769053079.git.daniel@makrotopia.org>
 <c2e191c4-dec4-4e42-b108-353778d9bd18@redhat.com>
 <aXinOE7KIFIm5dUK@makrotopia.org>
 <5e7c2f9c-bf49-4564-91b3-a639ef1c97d8@lunn.ch>
 <aXjQKoXBIAkV06XE@makrotopia.org>
 <8f267321-25fc-447f-8ff3-5d5b2d844d30@lunn.ch>
 <aXjirjOsc5IJFHfH@makrotopia.org>
 <b664b744-ddfd-409d-bee3-9e7e1dc0b5b2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b664b744-ddfd-409d-bee3-9e7e1dc0b5b2@lunn.ch>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253984-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3D7199A97
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 07:34:41PM +0100, Andrew Lunn wrote:
> On Tue, Jan 27, 2026 at 04:07:10PM +0000, Daniel Golle wrote:
> > On Tue, Jan 27, 2026 at 04:04:10PM +0100, Andrew Lunn wrote:
> > > > > int mxl862xx_to_zephyr_errno(u16 reg)
> > > > so that would then just be
> > > > 	return (s16)reg;
> > > > right?
> > > 
> > > Yes.
> > 
> > +1
> > 
> > Maybe better to check if bit 16~31 is actually zero as well, so
> > int mxl862xx_to_zephyr_errno(int reg)
> > {
> > 	if (reg >= 0 && reg <= U16_MAX)
> > 		return (s16)reg;
> > 
> > 	return 0;
> 
> If bits 16~31 are not zero, i would say the MDIO driver is broken, and
> we should fix it. Returning 0 is going to hide such issues. If you are
> worried about it, at least add a WARN_ON() or something.

The MDIO bus driver can very well return things like -ETIMEDOUT or
-ENODEV as a result of its .read_c45() operation (both values got
all bits 16~31 set, on every architecture I've checked)

This hints towards broken hardware, but not a broken driver. And I'd
rather catch that case (int reg < 0) separately and outside of the
mxl862xx_to_zephyr_errno() helper.

The broken-driver case would be values between U16_MAX and S32_MAX which
really don't make any sense.

Making sure mxl862xx_to_zephyr_errno() isn't called if any of the bits
16~31 are set would still be good to not end up blaming the firmware for
something which in reality is the MDIO bus driver or faulty hardware.
In that sense my idea of return 0 was just to say "it isn't a value
returned by the Zephyr firmware". If you prefer a WARN_ON() and return
-EINVAL instead of the return 0 that would be fine as well, of course.

