Return-Path: <netdev+bounces-287120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEVCIKUuA2qN1QEAu9opvQ
	(envelope-from <netdev+bounces-287120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:44:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E1E52181C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A6DA32486ED
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516DC379C54;
	Tue, 12 May 2026 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uKwpfeBp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2F36A343
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589555; cv=none; b=VFfaCbu/7eeE4JVHifr76W0FoVgCN68/GBZNauXWeKLWPxz9EfNL9UiN7Y5PKbc3p6Jxi+n3kMOS+2eXQDmhdSZl5zpdJY7t+78MAhbnf275YmiymYwnloFmS6BWnqLeOuSuFpPpTOlCv1EZDM3pYbkx/3KoQRue8SAuS+c/ZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589555; c=relaxed/simple;
	bh=Rz/65pv7HQA4lh+u2l05XrHxcptLoi7N+HXifJUf99c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf1y8vbPBHgB21/FJNUHjOKSBTEqyVtVQndd5nvR60cFUrcp5mEhKoReF8RswRXn4ISEQOLDI1XdUfXHvBy7fGzxEXw81yFkrrHDiahyLPeGJNoodeEXALzfRmxMFiXL76uqklP4FDqXNnB1L2rgMSyC36obpnL3FqAB1dfq/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uKwpfeBp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XcA6QnZVPpX6xEnYNB4CQPVgtp66izVY9T2pg47uM/Y=; b=uKwpfeBprf6rfhJBkMALS+HxNq
	2zj4pNcygN0kOndGAC1N3LBFLwLcM4tQrZZ3y8EgTqFVteRm/qS//azjttnzNZTgNaILfykqQIT6R
	4yxQb3FjwRZ+7kpxTXyEp3cQQXLu5v4qSJHYErLz807izAYobJhnanVNzREgh5zXsXVk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMmO8-002Xmq-0y; Tue, 12 May 2026 14:39:04 +0200
Date: Tue, 12 May 2026 14:39:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tiju Jacob <jacobtiju@gmail.com>
Cc: netdev@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: mv88e6xxx: 88E6320 =?utf-8?Q?external_?=
 =?utf-8?Q?PHY_on_MDC=5FPHY=2FMDIO=5FPHY_-_=28GPIO_7=2F8=29_?=
 =?utf-8?B?4oCU?= is mdio-gpio the right approach?
Message-ID: <1b509630-5c2e-4763-af07-28cd165678fa@lunn.ch>
References: <CADAg6uxK+xjPRgmSXeqfmbw1RgzOhUukkc-X72O61ywKhvx1_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADAg6uxK+xjPRgmSXeqfmbw1RgzOhUukkc-X72O61ywKhvx1_Q@mail.gmail.com>
X-Rspamd-Queue-Id: B6E1E52181C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287120-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 07:32:19AM -0400, Tiju Jacob wrote:
> Hi All,
> 
> We have an 88E6320 (marvell,mv88e6085) with an 88E1512 PHY on Port 5.
> 
> The PHY's MDIO is wired to the switch's MDC_PHY/MDIO_PHY pins (52/53
> =GPIO 7/8), which are separate physical pins from MDC_CPU/MDIO_CPU
> (54/55) used by the CPU. GPIO 7/8 read HIGH as inputs confirming the
> PHY is alive.
> 
> We tested exhaustively at runtime: marvell,mv88e6xxx-mdio-external,

marvell,mv88e6xxx-mdio-external is for the 6390 family and newer. It
is not relevant for the 6320.

The 6320 has one MDIO bus, covering both the internal and external
devices. What address do you have the 88E1512 PHY strapped to? You
need to avoid the internal devices. Ideally you want it on address 5,
but it can be other addresses.

	Andrew

