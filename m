Return-Path: <netdev+bounces-102408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5195902DAD
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D88A1F2202C
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0501109;
	Tue, 11 Jun 2024 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1RUpnTfi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E1EDF;
	Tue, 11 Jun 2024 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065757; cv=none; b=AtGyv+7uQ8dfXx8QGKBgrmZLCtAXmMKB3Rqtr19gHEmXVb+GqOt4BRpvFCp0uaS/u8rQopmKd9vSwAJ/D9EJb2qoR0gorT47Vm3X799G082dgWCGhqUSwlMuXee0QCyklPuedH0HQpNMa1HRwoTst3hZe5ewM7sa2SnPvgF6bbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065757; c=relaxed/simple;
	bh=5i2/zbwVRP1igz/41njrXF7PwGq4eAlplJF8NeffXHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJIVLocXKK7dKP3/gLo5g5urwuDzVBm2eaUdUDqwngA4jsrlTp0Uqtth0U8iA/DMyKdsKTd1kHPbuVHCoRIXGtQwK/LQgEjT8CEK0FYEvDpfaz1IhtGPs2O4kbqQ0UmzNWBVALJZssnv+V5CIVINCkIVxxQdVWDiNQR01lVvXXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1RUpnTfi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FI8V6GbrcwcqNDoiQdYzznx5EeFgF0kW14MQ9g3uM74=; b=1RUpnTfixFI/LG/nXiAskkZSA1
	U9xYDRtwIekyWRC/+7UaWvQ73dNRYjmaQs7e3wpgCybE/VX28Src4+MGAjkhOroK4oG+67c1ATwUB
	BneeN7J1QIiSTIZZX/JJ5JEdTm1Z/QD4PWRL3U+QeJ1yiAROeQ0h04+tTrHPr2wnpAQk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGpNp-00HLDV-Cl; Tue, 11 Jun 2024 02:29:05 +0200
Date: Tue, 11 Jun 2024 02:29:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 3/3] net: xilinx: axienet: Add statistics support
Message-ID: <d2cc10a6-0c6a-471a-bd5b-3e939905fc41@lunn.ch>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
 <20240610231022.2460953-4-sean.anderson@linux.dev>
 <7c06c9d7-ad11-4acd-8c80-fbeb902da40d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c06c9d7-ad11-4acd-8c80-fbeb902da40d@lunn.ch>

On Tue, Jun 11, 2024 at 02:13:40AM +0200, Andrew Lunn wrote:
> On Mon, Jun 10, 2024 at 07:10:22PM -0400, Sean Anderson wrote:
> > Add support for reading the statistics counters, if they are enabled.
> > The counters may be 64-bit, but we can't detect this as there's no
> > ability bit for it and the counters are read-only. Therefore, we assume
> > the counters are 32-bits.
> 
> > +static void axienet_stats_update(struct axienet_local *lp)
> > +{
> > +	enum temac_stat stat;
> > +
> > +	lockdep_assert_held(&lp->stats_lock);
> > +
> > +	u64_stats_update_begin(&lp->hw_stat_sync);
> > +	for (stat = 0; stat < STAT_COUNT; stat++) {
> > +		u32 counter = axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
> 
> The * 8 here suggests the counters are spaced so that they could be 64
> bit wide, even when only 32 bits are used. Does the documentation say
> anything about the upper 32 bits when the counters are only 32 bits?
> Are they guaranteed to read as zero? I'm just wondering if the code
> should be forward looking and read all 64 bits? 

Actually, if you read the upper 32 bits and they are not 0, you know
you have 64 bit counters. You can then kill off your period task, it
is not needed because your software counters will wrap around the same
time as the hardware counters.

     Andrew


