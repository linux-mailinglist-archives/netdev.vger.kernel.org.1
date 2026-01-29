Return-Path: <netdev+bounces-254768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA+EAWlCe2n6CwIAu9opvQ
	(envelope-from <netdev+bounces-254768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:20:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E16DAF8E7
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54459300CC9C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515373816E4;
	Thu, 29 Jan 2026 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KyFCb/Vd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE392C11CB
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685606; cv=none; b=tBl2KSDpilKtwaFFJv9Teg7FYSqm3fxpojDb0o/l6dMS49ADgmtN0VfPxWSxwQkB+2dP0Ajr8J8cvl0WMkTGCd35j3FUWr4m0/LMe6/WP8us7umBw2/ulfBhkTGm9qYamF+ahHy5CUR0zjkbbphPEMGnRtqCCtIvTxNMos9HqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685606; c=relaxed/simple;
	bh=gG3AoQioS5yoo+/CAhrIJzVTAKGePJE8rcikHoAzd0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHla2FkN+za0b6nl0isrn9T8CaMRWOdlpHdKPM+YOQ0eNQB2CNGI2iSRpjFgdAI1a5dNGpeURFSs8cnPNwoJ7uXmsUtVgz59x4YelRfk57w/vhdUWZyg6YyLRQJGXjHaD1HXiIzXukrTCp1lS06q8Ez03JSH5TPeY66w1TtGOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KyFCb/Vd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ob75jdBYoX9wiHBQOloMI0Lh2mnZbFBN44xnXGxBB2w=; b=KyFCb/VdIWuHIsK3Sb4/fZZ6H5
	4Wq4EeFYBMVjCqVZi1YxbDzXbloZRvhh7wFYa4O6Q8JoSPzHy4Vk2WGj0dW9OFHCxHzmVN5KG5p3L
	x7fssl39aO5ahKfTo009U4i/GV/hJ2J2rkXGmj57iv/0mAAQGD2119zZVX9M7wdVrpKKU1Vw9atVP
	G8uAx/Klf0uEwA2jFone1N4HAXQ/UMBqCPMAOLkd+9Xlt2mnRO8khDbVEBBorjot9VnUWnYTXxyZK
	1ejhid0LY220U9mXXbV2gUNZRJ0JG0MwxrxwGR7aChEusMq3w9iI+4JVG+vtpuaVwiw5eLhYPnmGh
	GGoUpqeQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38562)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlQ49-000000008Sd-0xz2;
	Thu, 29 Jan 2026 11:20:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlQ47-000000007vG-03eX;
	Thu, 29 Jan 2026 11:19:59 +0000
Date: Thu, 29 Jan 2026 11:19:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net v2] net: sfp: Fix quirk for Ubiquiti U-Fiber Instant
 SFP module
Message-ID: <aXtCXoGtsD4VUDKH@shell.armlinux.org.uk>
References: <20260129082227.17443-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129082227.17443-1-kabel@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,google.com,davemloft.net,gmail.com,lunn.ch,bootlin.com];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254768-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:url,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 6E16DAF8E7
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 09:22:27AM +0100, Marek Behún wrote:
> Commit fd580c9830316eda ("net: sfp: augment SFP parsing with
> phy_interface_t bitmap") did not add augumentation for the interface
> bitmap in the quirk for Ubiquiti U-Fiber Instant.
> 
> The subsequent commit f81fa96d8a6c7a77 ("net: phylink: use
> phy_interface_t bitmaps for optical modules") then changed phylink code
> for selection of SFP interface: instead of using link mode bitmap, the
> interface bitmap is used, and the fastest interface mode supported by
> both SFP module and MAC is chosen.
> 
> Since the interface bitmap contains also modes faster than 1000base-x,
> this caused a regression wherein this module stopped working
> out-of-the-box.

Thanks for finding that. Probably the result of having the patch
converting to use the PHY interface mode mask sitting around for a
very long time. Sorry about missing that.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

