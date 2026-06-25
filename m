Return-Path: <netdev+bounces-302004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sab6Mv1HPWoI0wgAu9opvQ
	(envelope-from <netdev+bounces-302004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:23:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B0E6C7079
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:23:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q0u7dZSJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302004-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302004-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEC23304B565
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C13E834F;
	Thu, 25 Jun 2026 15:23:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74843E8330;
	Thu, 25 Jun 2026 15:23:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401017; cv=none; b=MoDT/Mdk6OYGgaHn9kRpgTIYol92jco3arVPGfQW+sDtWydU2zmoU0pyKrrVmmkr/ryOUlEddMxEA8pTXh8udCf2wT9eb/Vp3YY3nOJTGO5hZTZVSWRmBEge552ls4zAT24Y0z1qmAGaVglfZuGDZPeXjruIghZBOBkTKdG07R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401017; c=relaxed/simple;
	bh=JQtFa7htbY/CcYz7Ewd1TH9/9WSFG1efPRA7vBU8Jj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRA1eRAHM0tHDW+YWmF8FgJVYpljGw7ZujROBD2B/CQqkVxzkYu+LumzLSK/RvR5nHk1vmncb+Zn2o5KtDmz6HXVwthoKB9j0NLGt+6M9uOeBMVptoBVmWZFyeOJ5CwZGpMGWQPm/r37JWG69TmtA5o5VG/Z2g99OyXN+9sHtco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0u7dZSJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25181F00A3A;
	Thu, 25 Jun 2026 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782401016;
	bh=IL26CsHIrio9igkJNe+Qqcof5uxEGMEOJx0qYBrwMP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q0u7dZSJz2xQ/zdxR6ZDtcNHfIqQVSwaIgBwGod/vY1YCKPHqmCKp5E6p2d4gPaNp
	 Q2cP7lchEwkfPSE0PevJghkKY/ZpY8xNyMTHQm0TcHE6nDEDi5eeMwXXXxfcS24Dja
	 rFjygUKb3x/PawcX4tzFCN5y635WS6WNUkF98IJZTO/5+ByUktEclxi4As2jhzLYqh
	 zFLZHdnpip1/erG5oWgK2xf2urSOLAe+VmZDAd6eJyUFItrttohA+Q0WEq2wOnZ/6N
	 6i38rMkAQb4brzdgFJJp3OM71Y39ZvV94F9GojG35J7eH4x5oQQSCwLVTjY+cUVHdg
	 tqr9zBDSxuoVg==
Date: Thu, 25 Jun 2026 08:23:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Petr Wozniak <petr.wozniak@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Bjorn Mork <bjorn@mork.no>, Marek Behun
 <kabel@kernel.org>
Subject: Re: [PATCH net v4 2/2] net: phy: mdio-i2c: defer RollBall bridge
 probe to PHY discovery
Message-ID: <20260625082335.3d13d875@kernel.org>
In-Reply-To: <9f813a8e-8b9a-4708-b3b6-db4972adac35@wp.pl>
References: <20260624084814.20972-1-petr.wozniak@gmail.com>
	<20260624084814.20972-3-petr.wozniak@gmail.com>
	<9f813a8e-8b9a-4708-b3b6-db4972adac35@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-302004-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[wp.pl];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olek2@wp.pl,m:petr.wozniak@gmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:maxime.chevallier@bootlin.com,m:bjorn@mork.no,m:kabel@kernel.org,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,bootlin.com,mork.no,kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41B0E6C7079

On Wed, 24 Jun 2026 23:44:19 +0200 Aleksander Jan Bajkowski wrote:
> > For genuine RollBall modules (e.g. FLYPRO SFP-10GT-CS-30M with Aquantia
> > AQR113C) the probe now runs after initialization is complete and
> > correctly returns 0, so PHY detection proceeds normally.  
> The FLPRO SFP module still fails to detect the PHY. It is necessary to
> increase `module_t_wait` to 20 seconds. Most likely, during this time
> the module loads the PHY firmware from SPI memory or from the
> microcontroller (rollball bridge) via MDIO. Same probably applies to
> most SFP modules with a PHY that load firmware at start-up (AQR113,
> RTL8261C etc.).

Just to clarify is FLPRO a typo or a knock off ?
Do you want something to be changed here or you're just flagging that
more follow ups are needed if we want to cover more modules?

