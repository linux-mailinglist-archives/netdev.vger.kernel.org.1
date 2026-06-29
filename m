Return-Path: <netdev+bounces-302710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yhx2MqCcQmqU+gkAu9opvQ
	(envelope-from <netdev+bounces-302710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:26:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF696DD4F4
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:26:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="wK/hEPrO";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302710-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302710-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30E0730131DC
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5A442EEC0;
	Mon, 29 Jun 2026 16:21:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B93BBFCC;
	Mon, 29 Jun 2026 16:21:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750105; cv=none; b=jIWkgyplI5vBT/7M52iWIF6KMBFeMV9BkoszpRk0S6mhrcaeNrTQf/6dBszuWP7N1i+GMX5NApxHQX+KpTQFhsjuUL3+/y3eR18T2+yTNvkeJkD62vG2LYD+XXyR6//hOH902UFkBzyY2/YY5HS58ejARXzeyc/x4HdcHl4Wg7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750105; c=relaxed/simple;
	bh=Defe668IL7FPzeNI2seoG1Y6mDC+LPzUNZ4I2LKsguo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXwOyBO+er85/N1sMRDiMCReztpTX8/8JNGfHvFI9XCTADzAQTD80zo/mu1f9uP3pDdFWOlG3dVVlaHVrysS3b3PI8qRprp9DNYGd/79uCK6YQlHUJTWcMDnBqPZEzvF1TY32y7xZMKDaCBGDxW4QU3LHDjucsrVoO8Z/Ulxx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wK/hEPrO; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n8mFplghMkqJprxe7nxlYj/qP9uUv0qloer/MIQXG6Q=; b=wK/hEPrOq/wD6cfR0qh1TlI9bv
	fp9JkoQi5OBNrhxr/5Vi54W1vO5MWnbD+xQaNcJUSHFycbk9Ax9WyOmzIrYu4gH9+lkYWYS5kecmu
	Rbv7YbNuQOkHq+YpXPQMuM1j4fNmhvYXRQxddiTj9tJ+W1FXTTYDybROPGzDVOn/PSPk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weEjY-009miz-Rh; Mon, 29 Jun 2026 18:21:20 +0200
Date: Mon, 29 Jun 2026 18:21:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/8] net: mdio: realtek-rtl9300: Add polling
 documentation
Message-ID: <fbd96fcc-8dcc-4d54-a17e-6bb7e355eb3e@lunn.ch>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
 <20260629152336.2239826-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629152336.2239826-2-markus.stockhausen@gmx.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302710-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CF696DD4F4

> + * Each device has a SMI_POLL_CTRL register. A per-port bitmask decides if the hardware polling of
> + * the associated bus/address is active or not. The hardware runs a tight loop over this and for
> + * each set polling bit it issues a status check for the PHY. Attaching a logic analyzer to the
> + * MDIO bus of an RTL8380 and RTL8393 gives the following commands (in kernel notation):
> + *
> + *	RTL8380				RTL8393
> + *	---------------------------	---------------------------
> + *	phy_write(phy, 31, 0x0);	phy_read(phy, 0);
> + *	phy_write(phy, 13, 0x7);	phy_read(phy, 1);
> + *	phy_write(phy, 14, 0x3c);	phy_read(phy, 4);
> + *	phy_write(phy, 13, 0x8007);	phy_read(phy, 5);
> + *	phy_read(phy, 14);		phy_read(phy, 6);
> + *	phy_write(phy, 13, 0x7);	phy_read(phy, 9);
> + *	phy_write(phy, 14, 0x3d);	phy_read(phy, 10);
> + *	phy_write(phy, 13, 0x8007);	phy_read(phy, 15);
> + *	phy_read(phy, 14);		phy_write(phy, 13, 0x7);
> + *	phy_read(phy, 9);		phy_write(phy, 14, 0x3c);
> + *	phy_read(phy, 10);		phy_write(phy, 13, 0x4007);
> + *	phy_read(phy, 15);		phy_read(phy, 14);
> + *	phy_read(phy, 0);		phy_write(phy, 13, 0x7);
> + *	phy_read(phy, 1);		phy_write(phy, 14, 0x3d);
> + *	phy_read(phy, 4);		phy_write(phy, 13, 0x4007);
> + *	phy_read(phy, 5);		phy_read(phy, 14);
> + *	phy_read(phy, 6);

Great to see this reverse engineering.

> + *
> + * The c45 over c22 register 13/14 sequences read MDIO_AN_EEE_ADV and MDIO_AN_EEE_LPABLE.

How do you tell it that C45 over C22 is actually supported by the PHY?
Not all PHYs do. Some PHYs use those registers for other things.

> + * How does MDIO access from kernel work?
> + *
> + * When issuing MDIO accesses via an MMIO based interface the final write to the command register
> + * sets a "run command now" bit. Between two polling sequences for different PHYs the hardware
> + * checks if a user command needs to run and sends it onto the bus. Afterwards it simply continues
> + * its polling work. Inspecting the command sequence for a paged read on the logic analyzer gives:
> + *
> + *	RTL8380				RTL8393
> + *	---------------------------	---------------------------
> + *	phy_write(phy, 31, page);	phy_write(phy, 31, page);
> + *	phy_write(phy, reg, value);	phy_write(phy, reg, value);
> + *					phy_write(phy, 31, 0);
> + *
> + * What does this mean?
> + *
> + * There are slight differences in polling and PHY access between the models but the challenge
> + * stays the same. On the one hand that greatly simplifies the MAC layer, on the other hand it
> + * has some implications for the kernel PHY subsystem.
> + *
> + * - Without the polling and a proper MAC status, some of the link handling features do not work.
> + *   Especially an unpopulated MAC_LINK_STS register cancels operations to other MAC registers.
> + * - The Realtek page register 31 is magically modified in the background. On the RTL838x it is
> + *   simply reset. Other devices have hardware mitigations for this in place.
> + * - A c45 over c22 kernel access sequence is most likely to fail because chances are high that
> + *   the polling engine overwrites registers 13/14 in between.
> + * - PHY firmware loading can have issues. Especially if a PHY is designed to expect a clean
> + *   sequence of registers and values without deviation.
> + * - An access to one PHY will need to wait for the next free slot of the polling engine.

* - PHYs which make use of pages will break the hardware polling,
*   because it is not aware a different page is currently selected, and
*   the values it reads from the PHY do not mean what it expects.

> + *
> + * Conclusion: Kernel access to the PHYs must know and handle any interference that arises from
> + * the above described hardware polling.

This is not the best of wording. We need to narrow it down from
'kernel', to Realtek MDIO bus driver. What we cannot do is have PHY
drivers need to know anything about this. Working around this needs to
be limited to the Realtek MDIO driver, and probably the MDIO bus
locking operations.

When the PHY driver does a paged access, it takes the MDIO bus
lock. We need that to disable the HW polling. Once the paged access is
complete and the MDIO bus lock is released, we can re-enable HW
polling. I'm pretty sure C45 over C22 already takes the MDIO lock, so
that also solves the issue you pointed out above.

We also need an understanding of how the hardware uses the values it
reads during poll. One obvious issue i see is that it is not reading
register 26, so how does it know what speed the realtek PHYs are
using, in order to correctly configure the MAC?

    Andrew

---
pw-bot: cr

