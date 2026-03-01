Return-Path: <netdev+bounces-262422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EHOLY9xpGmYhAUAu9opvQ
	(envelope-from <netdev+bounces-262422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:04:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B81D0C8A
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C09DC300D955
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119230BB8A;
	Sun,  1 Mar 2026 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CI4lkyH4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2365145A1F;
	Sun,  1 Mar 2026 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772384652; cv=none; b=oNnBbwTXk+T220M1qRDTu2uWMrEHNPvG0amjoOokEFc7LlknT5FKV2MQbKCNbTaRsRu48cF3Khxy5dqAz+w2FDI7Y05cCcBVqknvdkrHFTZ7EjjxzVFF32Q7uc86V9b53+WD6tKpnXM650cyC3PMpqtSib/a0Pb99hNrP/OoetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772384652; c=relaxed/simple;
	bh=XhmI8QdSfKZMoWwCQziC59jkdu6v/M6Rwy//m29xXCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb2F+g3mNvDvIEF0y+9xhfgRYRvE4Ve6Rh/jvC9YpDVFsoG0jkyv4SxuoBf8wWXMdW8RDFm5mftoGeQB3ZOSu4/Lr9v5HpkGT4rvyqHLgxCPIdFUzK6aR/wtx/0fFo2M2BSrbnkYaa4MtLfe1NM3csPTVXqrzRdlUM8bjU3lWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CI4lkyH4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4xnjqpiznnNS0o9eJZCKxcNr08IeaWwhyXUGcdoHQik=; b=CI4lkyH4NevKudYPRTwjddHC/l
	TfeHPq/AlXnVyKEtHpgo9HPEH5PCSeurt5zkJkFXnSAh4ziP345nqQdIeIlGiSNhG1mTIV8JUeK4r
	tkp9+bMbt1H1oKBr7iA7U42zF52I9w7KDhS73gQzEiTqkYsRA3GqK8dY/MnBoLXMvfpXupCt9G5BC
	9tFjHNZ3+mq/Xis2PTvJ80LPGwbvb/857DMI/hCFgPwBhOn6Eq8yc6QG6SXuLaEt1UBle972P7UPA
	NvELWv/7DWYkIizqglWHAc8VxA0VeFK0Uspvj6UV7h+e89/0yxa014YlyCAVk6rkP6X0jHB+RvwzN
	sy+l1kOA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54870)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vwkD4-0000000037w-2O6p;
	Sun, 01 Mar 2026 17:04:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vwkCv-0000000058v-3M73;
	Sun, 01 Mar 2026 17:03:53 +0000
Date: Sun, 1 Mar 2026 17:03:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub =?utf-8?B?VmFuxJtr?= <linuxtardis@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v2 1/5] net: mdiobus: Scan buses in reverse
 order (31 -> 0)
Message-ID: <aaRxee0mf4WJlxUU@shell.armlinux.org.uk>
References: <20260228232241.1274236-1-linuxtardis@gmail.com>
 <20260228232241.1274236-2-linuxtardis@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260228232241.1274236-2-linuxtardis@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-262422-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,motor-comm.com,marvell.com,makrotopia.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 183B81D0C8A
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 12:22:37AM +0100, Jakub Vaněk wrote:
> Some PHY devices incorrectly treat address 0 as a broadcast address.
> As a result, accesses to address 0 may cause multiple PHYs to respond,
> making one or both PHYs work unreliably. In other cases, the PHY may be
> detected twice by Linux: once at address 0 and once at its actual
> address).
> 
> On several PHYs (e.g. Motorcomm YT8821 and Realtek RTL8221B), this
> behavior can be disabled via a vendor-specific internal register.
> However, for that to be useful, that register would have to be
> programmed before address 0 is accessed for the first time.
> 
> On non-Device Tree systems, MDIO buses are typically scanned in
> mdiobus_register(). Change the address scan order from 0->31 to 31->0
> so that PHY fixups are applied to addresses 1-31 before address 0
> is probed. This way the address collision can be avoided.

I've said no to this before.

The order of scanning may affect the order in which devices are added.
However, that doesn't really have that much bearing in the order in
which devices are bound to their drivers.

If the drivers are already registered, then as each device is
registered with the driver model, it will be offered to drivers. So
in this case, the order in which devices are proed will be the order
in which they are scanned.

However, if a driver is loaded after scanning is complete, then the
order in which devices are presented to the driver is not under the
control of phylib, but is down to the driver model code. The driver
model scans the bus_type's devices in some order, and attempts to
match each with the new driver.

If the driver is not present, then even if you scan in reverse order,
the "ghost" at address 0 will be found, because the driver hasn't had
the opportunity to reprogram the PHY to disable that.

In both cases, things get worse if -EPROBE_DEFER happens.

So, you can't definitively control the order in which devices are
probed, which means that anything that depends on that will be fragile.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

