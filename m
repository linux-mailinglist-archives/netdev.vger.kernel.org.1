Return-Path: <netdev+bounces-274308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENNfHCLFzWlVhAYAu9opvQ
	(envelope-from <netdev+bounces-274308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 03:23:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B73382339
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 03:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDEC9302D5AB
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 01:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA8D24A058;
	Thu,  2 Apr 2026 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mI42KxeR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A644219EED3
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093022; cv=none; b=frmgpJOdBqWj4/8ouS0cpmOLB2c7EbkbnIsj4BCgq0H1IfRAeOxuiZVzXFB33TiazySNOR1v/Ec6L/ORN7dOewdgUAbqFkdzEenju/VS9WEnUFPIN9ki2GV9qJOX5cURfoVtW7c9o8Dmf96NMAS1CFKgmn+K8vWhxUU800ZVVbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093022; c=relaxed/simple;
	bh=IY74TKvYyJuTf4HhHheLEmU7/wifkxG4ZbTulLSo+v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNcmCvtjjZYKcw5qNkIzWuy2uXjCjBE/lDlDJrsB8VFhUsHXg4a2Ibbi49xsxkikiipzSjQG+BrA1TVp6SsVWtICBJnNhFfGooc8Bb+H8DsNl/4ggrV529iqRQsamfWzKgRtzLd54+RzbCoVZ4TL1fGRNo0iYwoDtvo/Iam4m+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mI42KxeR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uY732acVgv/m3sV9JI1hkfqAR86FQ+1iVAHhiOzwBpA=; b=mI42KxeRRRdVbbiFn2b7lQMQr5
	ApRKJBI6RPAM/RVC8V9qP2Mmz2Od50WLL5R+qEt/9KmdBJCseJtkfhhoJYiAAYM6mOO0SVZbkPyOI
	n6fZCdVEZPRNdBYoWpVbk32sqh2R3soNJQfF6vN5LLnt9N3GbJcMOybI0IcO6pqmZtjU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w86mW-00ER7p-25; Thu, 02 Apr 2026 03:23:36 +0200
Date: Thu, 2 Apr 2026 03:23:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Wagner <wagner.daniel.t@gmail.com>
Cc: netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: phy: bcm84881: add LED framework support
 for BCM84891/BCM84892
Message-ID: <81ae5337-5752-429f-bdc4-a0a7857739b5@lunn.ch>
References: <20260401114931.3091818-1-wagner.daniel.t@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401114931.3091818-1-wagner.daniel.t@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274308-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2B73382339
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 12:49:31PM +0100, Daniel Wagner wrote:
> Expose LED1 and LED2 pins via the PHY LED framework. Each pin has a
> source mask (MASK_LOW + MASK_EXT registers) selecting which hardware
> events light it, plus a CTL field in the shared 0xA83B register
> (RMW; LED4 is firmware-controlled per the datasheet).
> 
> Hardware can offload per-speed link triggers (1000/2500/5000/10000),
> RX/TX activity, and force-on. LINK_100 is accepted only alongside
> LINK_1000: source bit 4 lights at both speeds and 100-alone isn't
> representable, so the unrepresentable case falls to software.
> 
> The chip has five LED pins; only LED1/LED2 are exposed here as those
> are the only ones characterized on tested hardware. LED4 is firmware-
> controlled regardless of strap configuration.
> 
> Tested on TRENDnet TEG-S750 (LED1/LED2 wired to an antiparallel
> bicolor LED): brightness_set via sysfs; netdev trigger offloaded=1
> with amber lit at 100M/1G/2.5G and green lit at 10G via respective
> link_* modes; LED off immediately on cable unplug with no software
> involvement.
> 
> Signed-off-by: Daniel Wagner <wagner.daniel.t@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

