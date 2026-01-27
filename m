Return-Path: <netdev+bounces-253913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Nt0OnPSeGmNtQEAu9opvQ
	(envelope-from <netdev+bounces-253913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:57:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D329624C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92E45306DD88
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F7035CBD6;
	Tue, 27 Jan 2026 14:48:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750E359714;
	Tue, 27 Jan 2026 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525305; cv=none; b=kxyuqOt52y5KS7g1YY9AvzgRFkdetoILI2HLuMfdgo7awGwTK1ixZwlgiUGDnhoT+5NfuJw5NXINN/q13HrqRPWeca1YhKF432Bh9zll37LjQAYIGe2XUNaZyVxUPcXg+ZnzqGuJhk/o1q22uQz9z972F2frnwGq19yW0PvCpNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525305; c=relaxed/simple;
	bh=1dGrQxPMqXnmX/zIdN8/9kmEKhqIvaP+J3Qi7b/et/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFw16fBq9WdrjttSsoSepMS1iDVPAN9s/Hyvqt9CXt6M4ad3CcQAFCxuLcaLnaflfLry7kKwG05E7RSqKJld5Ps3fkXdiTvLJb5QKOLozXecIfllGMLbffnWWNuUwQ4CQOKZdPqmsKgKyGuu+DjVpUIlQRPtiMqCKM1IN59t/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vkkMY-0000000015f-3rkJ;
	Tue, 27 Jan 2026 14:48:15 +0000
Date: Tue, 27 Jan 2026 14:48:10 +0000
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
Message-ID: <aXjQKoXBIAkV06XE@makrotopia.org>
References: <cover.1769053079.git.daniel@makrotopia.org>
 <18c6a24eef8617abb5073569fee162f1aa1c06ea.1769053079.git.daniel@makrotopia.org>
 <c2e191c4-dec4-4e42-b108-353778d9bd18@redhat.com>
 <aXinOE7KIFIm5dUK@makrotopia.org>
 <5e7c2f9c-bf49-4564-91b3-a639ef1c97d8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7c2f9c-bf49-4564-91b3-a639ef1c97d8@lunn.ch>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253913-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8D329624C
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:50:14PM +0100, Andrew Lunn wrote:
> > > > +	/* handle errors returned by the firmware as -EIO
> > > > +	 * The firmware is based on Zephyr OS and uses the errors as
> > > > +	 * defined in errno.h of Zephyr OS. See
> > > > +	 * https://github.com/zephyrproject-rtos/zephyr/blob/v3.7.0/lib/libc/minimal/include/errno.h
> > > > +	 */
> > > > +	if ((s16)ret < 0) {
> > > 
> > > The cast is likely not needed above? if `ret` values < S16_MIN are
> > > possible this will return such values to the caller without the IO err
> > > printk.
> > 
> > Right, it should rather be
> > 
> > if (ret > S16_MAX && ret <= U16_MAX)
> > 
> > to really only catch the range of numbers which are negative 16-bit
> > signed values represented as positive 32-bit signed values.
> > 
> > mxl862xx_reg_read() primarily returns a signed 32-bit integer, as it is
> > basically just a wrapper around __mdiodev_c45_read(). Negative values of
> > that 32-bit integer mean that the MDIO Clause-45 read has somehow
> > failed, ie. it's the error the MDIO bus .read_c45() operation has
> > returned.
> > 
> > In case __mdiodev_c45_read() succeeds it returns the 16-bit value of the
> > register read. In this case, those 16-bit should be interpreted as a
> > 16-bit signed integer here. A negative value denotes an error returned
> > from the firmware running on the switch (see comment above the code).
> 
> Rather than these casts, maybe add a helper which takes the unsigned
> u16 from the register and returns a signed Zepher error code?
> 
> int mxl862xx_to_zephyr_errno(u16 reg)
so that would then just be
	return (s16)reg;
right?

Or did you think to include the handling of the error __mdiodev_c45_read()
would return, ie.
int mxl862xx_to_zephyr_errno(int reg)
{
	if (reg < 0)
		return reg;

	/* handle errors returned by the firmware as -EIO
	 * The firmware is based on Zephyr OS and uses the errors as
	 * defined in errno.h of Zephyr OS. See
	 * https://github.com/zephyrproject-rtos/zephyr/blob/v3.7.0/lib/libc/minimal/include/errno.h
	 */
	if (reg > S16_MAX && reg <= U16_MAX)
		return -EIO;
}

Or actually translating the actual errno to a Linux error code?

