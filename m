Return-Path: <netdev+bounces-256249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFCnIMPYgWlYKgMAu9opvQ
	(envelope-from <netdev+bounces-256249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:15:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB45D8223
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46BE830ABADD
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 11:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6AD329C49;
	Tue,  3 Feb 2026 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b="ETTARjg+"
X-Original-To: netdev@vger.kernel.org
Received: from mail.twlab.de (mail.twlab.de [80.151.39.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23434331213
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.39.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117246; cv=none; b=u9KDkTdKUnsUee3DgdwCoQYVmwN6VOHgW6X6SYnoWZAlhhzfqYZlLKMvM9h+ePoiBOOjbM8wPfnQgxFmpLii2lM/nZS2+x56Ffa8L1Q7hoCJbjG8nJw6W+v6YcXJnblRI5MUWrO/EgMrrIgaBAtBJqOo7eu10vxGm7AWFvhDxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117246; c=relaxed/simple;
	bh=w2Y5NBeWc4YMPM/H20/W3+gCGExfGdtkvj7ZUA4aEtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZeyKs5f5v8Jny1Pt+bTLNtqdstG6LVqeAN2K+2M7MkV0eoct0Qv2dTWPOAyAgfJbHFAv5iHeDeR6MOdYOEWR+zB2UcFCBByi6ItzzRgtNpatr3ptz2psxPK/limk60VvHpsAmXPHUMAXfJZJ8+BkWQZw2eDwI/rS39xxYTzQ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de; spf=pass smtp.mailfrom=twx-software.de; dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b=ETTARjg+; arc=none smtp.client-ip=80.151.39.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twx-software.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D0305E88C5;
	Tue,  3 Feb 2026 12:13:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twx-software.de;
	s=dkim; t=1770117240;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=KBJF4XhTX+p7t0ze4KhR6sTsQCqUhV3G1ccggDday5o=;
	b=ETTARjg+JflmBVxIOzN/dq1pscXlVmE8BCTq4ohb3mZEyO8QqJz0jtKSIDdMdu9489go0t
	ZoIBWR38+dQ7NREXUG2VJLE5TmEtZcoLq1HzuhQXxw7LIoyELu/Ak9qIYSh8b9hcEcF3R/
	zhX+AivajhwEtfeUBPXS+FKtq07Tx+pTdOr/siRfrWWDdxb94EfZzJYlGmIpTmjCTA4Y52
	PxidkWXcBAbLd3jEPguJSDEfiGV1J1Sf0E25pslaXQLD/a7W9eQg8yy6+095im3zsUamXO
	ELbN5sk7/74MDh3Tvycm+//APxWhHwgYJmr5NvximXXnSyk/UqLy0P7oRtJJCg==
Date: Tue, 3 Feb 2026 12:13:50 +0100
From: Heinrich Toews <ht@twx-software.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: f.fainelli@gmail.com, robh+dt@kernel.org, andrew@lunn.ch, 
	olteanv@gmail.com, netdev@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [v1,3/3] net: dsa: microchip: add single-led-mode support for
 KSZ9477
Message-ID: <parqpamou43mzu6hlcszju2tk5jjikea4fcagtpcluklmaqwrf@zmulhigs65w4>
References: <20260128133842.1173406-4-ht@twx-software.de>
 <20260129022547.300907-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260129022547.300907-2-kuba@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[twx-software.de,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[twx-software.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256249-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,vger.kernel.org,linaro.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ht@twx-software.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[twx-software.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,twx-software.de:dkim]
X-Rspamd-Queue-Id: DBB45D8223
X-Rspamd-Action: no action

Hello Jakub,

On Wed, Jan 28, 2026 at 06:25:48PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: dsa: microchip: add single-led-mode support for KSZ9477
> 
> This patch adds single LED mode support for KSZ9477 via a device tree
> property. The mode is configured during MAC link-up for non-CPU ports
> and includes a workaround for Errata Module 19.
> 
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> > index e5fa1f5fc09b..bef8ec51d948 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.c
> > +++ b/drivers/net/dsa/microchip/ksz_common.c
> 
> [ ... ]
> 
> > @@ -3909,6 +3920,24 @@ static void ksz_set_gbit(struct ksz_device *dev, int port, bool gbit)
> >  	ksz_pwrite8(dev, port, regs[P_XMII_CTRL_1], data8);
> >  }
> >
> > +static void ksz_enable_single_led_mode(struct ksz_device *dev, int port, struct phy_device *phydev)
> > +{
> > +	const u16 *regs = dev->info->regs;
> > +
> > +	ksz_pwrite16(dev, port, regs[P_PHY_MMD_SETUP], 0x0002); /* Set up register address for MMD */
> > +	ksz_pwrite16(dev, port,  regs[P_PHY_MMD_DATA], 0x0000); /* Select Register 00h of MMD */
> > +	ksz_pwrite16(dev, port, regs[P_PHY_MMD_SETUP], 0x4002); /* Select register data for MMD */
> > +	ksz_pwrite16(dev, port,  regs[P_PHY_MMD_DATA], 0x0011); /* Write value 0011h to MMD */
> > +
> > +	/* According to KSZ9477S Errata DS80000754F (Module 19) 0xfa00 has to
> > +	 * be written to the Debug Register 3 to enable Single-LED Mode.
> > +	 */
> > +	if (phydev->dev_flags & MICREL_KSZ9_LED_ERRATA)
>               ^^^^^^
> 
> Can phydev be NULL here? The phylink framework passes phydev as NULL when
> using fixed-link configurations (MLO_AN_FIXED mode). For example, if a
> non-CPU port on KSZ9477 is configured with a fixed-link in device tree
> instead of a real PHY, phylink_fwnode_phy_connect() returns early without
> attaching a PHY, leaving pl->phydev as NULL.
> 
> When link comes up on such a port, phylink_link_up() calls the mac_link_up
> callback with this NULL phydev, which then gets passed to this function.

Thanks, I see the problem here. Indeed, in a fixed-link configuration, phydev
will be NULL here.

Since the LED mode configuration is specific to the PHY, I will add a 
NULL check to ensure we only proceed if a PHY is actually attached to 
the port.

> > +		ksz_pwrite16(dev, port, regs[P_PHY_DIGITAL_DEBUG_3], 0xfa00);
> > +
> > +	dev_info(dev->dev, "port-%d: single-led mode enabled.\n", port);
> > +}
> 
> [ ... ]
> 
> > @@ -3977,6 +4006,9 @@ static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
> >  	int port = dp->index;
> >  	struct ksz_port *p;
> >
> > +	if (dev->single_led_mode && port != dev->cpu_port)
> > +		ksz_enable_single_led_mode(dev, port, phydev);
> 
> The guard here checks single_led_mode and that port is not the CPU port,
> but it does not verify that phydev is valid. On KSZ9477, ports 5 and 6
> do not have internal PHYs (internal_phy[] is false), and if one of these
> external ports is configured with fixed-link while cpu_port is the other
> external port, this path will be taken with phydev=NULL.

I re-checked the datasheet (DS00002392C) and indeed the switch has seven 
ports, of which only five have integrated PHYs. The two external MAC 
ports (5 and 6) can be connected to a host processor, another switch, 
or an external PHY.

As you pointed out, if these are used as fixed-links, phydev will be 
NULL. I will add a check to ensure we only proceed if a PHY is 
attached to the port.

I will fix this in v2.

Regards,
Heinrich

