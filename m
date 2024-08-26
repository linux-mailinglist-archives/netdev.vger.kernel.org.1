Return-Path: <netdev+bounces-121989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D74F95F79C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0CA2838F2
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF5C198E6F;
	Mon, 26 Aug 2024 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eMCz+J8B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726EC1991A4;
	Mon, 26 Aug 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692386; cv=none; b=XY1b6YT+Y/F+4WQGUtpzq/lWc1enFPifnwAysseNjO/Sk8WYX2PVgcUlUSTZfEFP4+BV/KlLHgwnXhXyJGB6pVygBivNqp/Dz5cC7A6PJRwtUmEYvQ5sTx0CN4127WWQevic3iX5HuKFD70oNfryBUW4fvt29sKamnI89+Xdh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692386; c=relaxed/simple;
	bh=tbiBVHvyfoqoBD5Y1//Qn7pkiCD27dDDEnuA1CnXuwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gy+aXMTEZjkIrKjJWt++hP0Z0kKflcV8b0IvnP3LH2E2U/9bIH5DknT2Kjol1DSZmCsaUQ9n5o2FsSJxbo0Y134jqALLwyBuf2gs5WA/f9GNTmZOkuBTgPpIDVqfuMXMoSzvfxn7vDfssTXmzUah45NZKCgsi/JNPfK91cH2+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eMCz+J8B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nDNT8Y3fU9IXOJQGBKfBn5s9ZlZRI6QG2maBPGo3ssw=; b=eMCz+J8B84OSJDcNXfUlzdWgnN
	REj+6gbJU0InHRd/OO+naAWqL9vUSKKUX0Cj1LY+vYVxfBALUbBhk2u3lzUQukh8MJnEN9HI6UCm+
	R6QEXMHRmYGKSpSh2f/dKuvP6LEJTKQPXb5ATQW3rQivucTna5ZDNN3e9kCKR1NKf/p0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sidGu-005jNz-Cn; Mon, 26 Aug 2024 19:12:52 +0200
Date: Mon, 26 Aug 2024 19:12:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] phy: open_alliance_helpers: Add defines
 for link quality metrics
Message-ID: <4a1a72f5-44ce-4c54-9bc5-7465294a39fe@lunn.ch>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
 <20240822115939.1387015-2-o.rempel@pengutronix.de>
 <20240826093217.3e076b5c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826093217.3e076b5c@kernel.org>

On Mon, Aug 26, 2024 at 09:32:17AM -0700, Jakub Kicinski wrote:
> On Thu, 22 Aug 2024 13:59:37 +0200 Oleksij Rempel wrote:
> > Introduce a set of defines for link quality (LQ) related metrics in the
> > Open Alliance helpers. These metrics include:
> > 
> > - `oa_lq_lfl_esd_event_count`: Number of ESD events detected by the Link
> >   Failures and Losses (LFL).
> > - `oa_lq_link_training_time`: Time required to establish a link.
> > - `oa_lq_remote_receiver_time`: Time required until the remote receiver
> >   signals that it is locked.
> > - `oa_lq_local_receiver_time`: Time required until the local receiver is
> >   locked.
> > - `oa_lq_lfl_link_loss_count`: Number of link losses.
> > - `oa_lq_lfl_link_failure_count`: Number of link failures that do not
> >   cause a link loss.
> > 
> > These standardized defines will be used by PHY drivers to report these
> > statistics.
> 
> If these are defined by a standard why not report them as structured
> data? Like we report ethtool_eth_mac_stats, ethtool_eth_ctrl_stats,
> ethtool_rmon_stats etc.?

We could do, but we have no infrastructure for this at the
moment. These are PHY statistics, not MAC statistics. We don't have
all the ethool_op infrastructure, etc. We also need to think about
which PHY do we want the statics from, the bootlin code for multiple
PHYs etc.

I will leave it up to Oleksij, but it would neatly avoid different
vendors returning the same stats with different names.

	Andrew

