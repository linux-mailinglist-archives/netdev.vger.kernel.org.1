Return-Path: <netdev+bounces-256662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJNlL/wdg2nWhwMAu9opvQ
	(envelope-from <netdev+bounces-256662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:22:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD99E4704
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0B5130054C7
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C573D902A;
	Wed,  4 Feb 2026 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b="Z9suebFo"
X-Original-To: netdev@vger.kernel.org
Received: from mail.twlab.de (mail.twlab.de [80.151.39.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A363AE6F8
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.39.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200569; cv=none; b=O/S+O9xhN5CwSmZ9gS2pmeNLM/8uPTSGGFtubZS0OeZouwsjQScAee9Xe+ZtNijZ2P+kkCaqaOMh4puHikggi5gkEM/2Tipi1zpKQ29qkgxCBPGEqrTxSk82NE7M4PhbTRU4NQk6JsrXLWgZ8DiBYYJBWX2piBHVHIqhoWSaFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200569; c=relaxed/simple;
	bh=2/LKtul8YdBrkTFONDHycPi4ySfrKt9cKjJMOw+43LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5BQf9XJynMy6xdbyYhzF4lD/Y4cIIayM3hsWr0Bwod6yfCU19kUz6GbaKoLKkK3GQ4/0HKTLsAGfSRC02qpMkH+I0IYT2gCiz7/kuKrUsoo34VbWUJvsCd9cWcaPYSvAtke6+AQfolioUfnihr1EmawX9DZ5qyljEf5YapQ58E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de; spf=pass smtp.mailfrom=twx-software.de; dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b=Z9suebFo; arc=none smtp.client-ip=80.151.39.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twx-software.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 726D15E88C6;
	Wed,  4 Feb 2026 11:22:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twx-software.de;
	s=dkim; t=1770200559;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=d4GYL7CwdhiYHmTTzLHTzq+LPLuyEzanj6N0LqWTsT4=;
	b=Z9suebFow9qli62kB85XybtFIqh6gx32KJXBL4GuQMb6ewxGjTvL2WgyDcHWVcbZBtL/Bh
	IbXByOuVOCoAUqVZHOES2WEKNE1xm2x24cMXxh786EG1E8Q7P0hNupiqf9W+XRz/RvZSCg
	1lsXDja0cMKmTVdIJm1shLLaQqnaY6CE6GttBljUKFh/sYdmWerwNjsB+gmTWWl89eg5c5
	eRmgGQJ99Kkap9snuSNqSAQhN5YzxIOWeW7GmmKNIVJsRj8W6MY8fFezrKMFdLmX0B+yVf
	XfZHPeOo46j+ljwhEgP2y5rtuDHbmVrkGf7XGUYrdQ2lyltsZb8SQOkWe5mk2Q==
Date: Wed, 4 Feb 2026 11:22:23 +0100
From: Heinrich Toews <ht@twx-software.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [v1,3/3] net: dsa: microchip: add single-led-mode support for
 KSZ9477
Message-ID: <w3go7zpdrab7ysvbpdnsmymcufh35ahgtpz4ahsxbcbhsvd6p2@eq5iglbkg5xj>
References: <CAJ+vNU2c+kt3vX6PzqALakdwzyb5qh6O7Oj4xyxsWnsXCAUaRw@mail.gmail.com>
 <xannp3dq73ufdyvke535opvb2hb7zra3tbxcvfkso2ossjf2hf@tucgd7qfwwcp>
 <CAJ+vNU2Qw2mJv4QwUee0UAxpis03238oJksRSdXZ2UG2MM=xXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU2Qw2mJv4QwUee0UAxpis03238oJksRSdXZ2UG2MM=xXw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[twx-software.de,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[twx-software.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-256662-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[twx-software.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ht@twx-software.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,twx-software.de:email,twx-software.de:dkim]
X-Rspamd-Queue-Id: 5CD99E4704
X-Rspamd-Action: no action

Hi Tim,

On Tue, Feb 03, 2026 at 04:56:30PM -0800, Tim Harvey wrote:
> On Tue, Feb 3, 2026 at 8:58 AM Heinrich Toews <ht@twx-software.de> wrote:
> >
> > Hi Rob,

Oh Sorry, I see that I was accidentally using the wrong name in my last message.

[...]

> > I added debug output and tested my setup on all 4 external ports and it
> > works:
> >
> > ksz-switch spi1.0: ksz_pwrite16: port: 1, offset: 0x011a, data: 0x0002
> > ksz-switch spi1.0: ksz_write16: reg: 0x0000211a, value: 0x0002
> >                                                           ^^^^
> >                                                           The port index
> >                                                           is set
> >                                                           correctly.
> >
> > [...]
> >
> > ksz-switch spi1.0: ksz_pwrite16: port: 2, offset: 0x011a, data: 0x0002
> > ksz-switch spi1.0: ksz_write16: reg: 0x0000311a, value: 0x0002
> >                                                           ^^^^
> >                                                           The same here
> >                                                           on port 2.
> >
> > Is see activity on the leds connected to LEDx_0.
> >
> 
> Hi Heinrich,
> 
> My apologies - you are correct. I accidentally missed the hunk where
> you set your registers in ksz9477_regs causing it to not work for me.

Ahh okay. Now I understand.

> > ksz9477_get_port_addr() is adding the port index by PORT_CTRL_ADDR(port, offset).
> >
> > But since I'm accessing PHY registers here, I'll switch to ksz_phy_write16() in v2.
> 
> Yes, that would be best as you would no longer need to add custom registers.

Right, this is also a goog reason to switch.

> I have:
> 
>         ksz_phy_write16(dev->ds, port, MII_MMD_CTRL, 0x0002);
>         ksz_phy_write16(dev->ds, port,  MII_MMD_DATA, 0x0000);
>         ksz_phy_write16(dev->ds, port, MII_MMD_CTRL,
> MII_MMD_CTRL_NOINCR | 0x02);
>         ksz_phy_write16(dev->ds, port,  MII_MMD_DATA, 0x0010); /* set bit 4 */
>         /* LED_ERRATA requires writing 0xfa00 to Debug Register 3 (PHY
> register 0x1e) */
>         if (phydev->dev_flags & MICREL_KSZ9_LED_ERRATA)
>                 ksz_phy_write16(dev->ds, port, 0x1e, 0xfa00);

Thanks. But I'm thinking to add a local '#define MII_PHY_DIGITAL_DEBUG_3 0x1e' here.

> I look forward to seeing your next submission.

I hopefully will get it ready this week.

Regards,
Heinrich.

