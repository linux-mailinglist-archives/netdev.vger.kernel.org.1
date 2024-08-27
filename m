Return-Path: <netdev+bounces-122139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DD6960083
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 06:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8C3B21276
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 04:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9757C84D3E;
	Tue, 27 Aug 2024 04:51:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4174413
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734309; cv=none; b=uju/Rp3NGUM8Io4sm7N8kDllHLS87wD4jEgf3ugyPGQbPdmhPMpdVVvCyjvYVuYoHJKvBSjoTlQ/lxNXEsUgZju/v1XBiNrV0kzjBqhYqGupYcXJNVJNU6ZGwo2AsHolcPSKRMR5Z3fG8EKdPWJy31SHHAy+rHiMPrjPWO8s3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734309; c=relaxed/simple;
	bh=rk1ILzNR9aZcVW4we80tUSCcb66iRVn+P15SZ3FPF7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6crZr9CT7u4kyvSqSDtIuaFv4Xn9qW4/kmaa1l8tgF6+eN3Sqc35OXyIUa1UxkMMvh7IAYDYlOd1CZpK3xQMhUd03NYSiQ15bwi+3kmmf5wRx/qfev6rflmHORKi2xnCttWUgL79Eqlo4ui7KxNri/N6FfY7zqJtkV806ulikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sioAz-00055m-As; Tue, 27 Aug 2024 06:51:29 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sioAx-003LV2-L4; Tue, 27 Aug 2024 06:51:27 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sioAx-008ohO-1h;
	Tue, 27 Aug 2024 06:51:27 +0200
Date: Tue, 27 Aug 2024 06:51:27 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] phy: open_alliance_helpers: Add defines
 for link quality metrics
Message-ID: <Zs1bT7xIkFWLyul3@pengutronix.de>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
 <20240822115939.1387015-2-o.rempel@pengutronix.de>
 <20240826093217.3e076b5c@kernel.org>
 <4a1a72f5-44ce-4c54-9bc5-7465294a39fe@lunn.ch>
 <20240826125719.35f0337c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826125719.35f0337c@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Jakub,

On Mon, Aug 26, 2024 at 12:57:19PM -0700, Jakub Kicinski wrote:
> On Mon, 26 Aug 2024 19:12:52 +0200 Andrew Lunn wrote:
> > > If these are defined by a standard why not report them as structured
> > > data? Like we report ethtool_eth_mac_stats, ethtool_eth_ctrl_stats,
> > > ethtool_rmon_stats etc.?  
> > 
> > We could do, but we have no infrastructure for this at the
> > moment. These are PHY statistics, not MAC statistics.
> > We don't have all the ethool_op infrastructure, etc.
> 
> This appears to not be a concern when calling phy_ops->get_sset_count()
> You know this code better than me, but I can't think of any big 'infra'
> that we'd need. ethtool code can just call phy_ops, the rest is likely
> a repeat of the "MAC"/ethtool_ops stats.
> 
> > We also need to think about which PHY do we want the statics from,
> > the bootlin code for multiple PHYs etc.
> 
> True, that said I'd rather we added a new group for the well-defined
> PHY stats without supporting multi-PHY, than let the additional
> considerations prevent us from making progress. ioctl stats are
> strictly worse.
> 
> I'm sorry to pick on this particular series, but the structured ethtool
> stats have been around for 3 years. Feels like it's time to fill the
> gaps on the PHY side.

I completely agree with you, but I currently don't have additional
budget for this project.

What might help is a diagnostic concept that I can present to my
customers to seek sponsorship for implementing various interfaces based
on their relevance and priority for different projects.

Since I haven't seen an existing concept from the end product or
component vendors, I suggest starting this within the Linux Kernel
NetDev community.

I'll send my current thoughts in a separate email

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

