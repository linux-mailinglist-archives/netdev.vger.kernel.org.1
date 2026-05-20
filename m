Return-Path: <netdev+bounces-289727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OgDJJUjDWrctgUAu9opvQ
	(envelope-from <netdev+bounces-289727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:59:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA6587022
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 998E7300C010
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD007248861;
	Wed, 20 May 2026 02:59:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6C343899
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245970; cv=none; b=rYjJWSLStGOOMrqCH4THQmJK5QfhKEOJZBX6+OZdmgbe77cE7odM0mvfn3ZhLUxpuyPrZ2dnsQcnQJwdVJz+FTWrnR/71A+AsjFvIfS1dqnc1tkxnJaWdUtQAHxUUxrGRbe3K2cDfXhy5AaxdSiDEBhn0gyFQG7WR3S2BXnIj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245970; c=relaxed/simple;
	bh=fW3WS/6ujvjw3jqOWJ20Tj9J9neMcW9xQhQg62eQ1yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kv5tS6+gywQyNYs1KXBtfVM6a0IRl1B8S6lxWRQECK/aun16d9erHzE1BwxENRu6tkY+3HsxsvSMYpt5ZB8I30ShSL0AeOGThrsiEoNlH+nP03v9gcZb3HKfWobocH9jY8gONOLzzSnPudlbbg+NsNOqE2vBu2v4flCL7PYVavc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wPX9O-000000004Eq-40T5;
	Wed, 20 May 2026 02:59:15 +0000
Date: Wed, 20 May 2026 03:59:11 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"chris.packham@alliedtelesis.co.nz" <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH 3/9] net: mdio: realtek-rtl9300: Add ports to info
 structure
Message-ID: <ag0jf16wrOr7F9d6@makrotopia.org>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-4-markus.stockhausen@gmx.de>
 <agydm8V25M-jy5o6@makrotopia.org>
 <85d5f162-8999-43d4-b879-6e5e686246f7@lunn.ch>
 <01d801dce7c2$a0a08ba0$e1e1a2e0$@gmx.de>
 <fff19211-a41a-481d-a6a6-4429a6901129@lunn.ch>
 <agzoaMnmeVpjiFC0@makrotopia.org>
 <82214c5e-23d5-4615-b2ae-81985fb573f8@lunn.ch>
 <10121615-6F47-2A48-825A-0AC1E0C0F0C1@hxcore.ol>
 <87c64246-5f3e-44d5-8d62-6778c771e83c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87c64246-5f3e-44d5-8d62-6778c771e83c@lunn.ch>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289727-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,makrotopia.org:mid]
X-Rspamd-Queue-Id: DCAA6587022
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 03:42:44AM +0200, Andrew Lunn wrote:
> > > Do any of these MDIO busses appear on the 
> > > outside? Somewhere i can connect an 
> > > external PHY, or another switch in cascade?
> > 
> > Yes. See 6.14 in datasheet [1]
> > We even can disable/enable each on RTL931x
> 
> So how do you handle that this external PHY is not for a port of the
> switch? It is for an i210 hanging off the PCIe bus, or a USB-Ethernet
> dongle? Linux itself would have no problem with that.

On the *primary* MDIO busses of this class of SoCs (ie. which this
driver deals with) it only possible to access MDIO devices which are
Ethernet PHYs mapped to a switch port.

Theoretically you could maybe use pinctrl/pinmux to switch the MDC and
MDIO pins to simple GPIOs and bit-bang the MDIO bus. However, as
configuring the MACs depends on the hardware PHY polling, that
bit-banged bus could then no longer be used to connect Ethernet PHYs
used for switch ports of that SoC.

That being said, many of those SoCs also got an auxilary MDIO bus
(which require another, completely different and much more simple
driver[1]) to connect things (such as RealTek's own LED/GPIO
controllers) which aren't directly mapped to a switch port.

Obviously all existing hardware (ie. low-cost switches) using those
SoCs obey to those restrictions.

(plus: there simply aren't any PCIe or USB busses; it's an Ethernet
switch; the CPU is a low-end MIPS and itself hardly capably of moving
more than a few megabits, it's meant to manage and monitor the
Ethernet switch fabric doing all the actual work)

[1]: https://git.openwrt.org/openwrt/openwrt/tree/target/linux/realtek/patches-6.18/723-net-mdio-Add-Realtek-Otto-auxiliary-controller.patch

