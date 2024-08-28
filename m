Return-Path: <netdev+bounces-122605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAF6961DC1
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 06:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBE51F240AE
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 04:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97867132120;
	Wed, 28 Aug 2024 04:51:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729D3D96A
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 04:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724820660; cv=none; b=VJ01hBPtmdFxdAjrb6o1sTnmW2Qaa/rQVGBOrdfP12P8zu2tZfdmO6cTmmh1aO+sqQmeQPYTmuFT+1+hvjP0hv1TssnXniL6FGeyWqbH0CG6xe9/LpgbZY6yZ8NHmeLZpIj1l6EJUDj+K2pKitoNtT3RAmguafrfxobN4lrWO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724820660; c=relaxed/simple;
	bh=mC9LMTWSpFcuIJEu28ZZ2VhcDn6OzdsBY8UEHYOb20Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzegikarwp3iGPaE/85ie0tgNDt2htFJ/N6lPoFVoo2kQ8PvGXcpPMHjg7NKanhfmtzWkONL15W35X3noJi10TxAJUhjHCqHDQVRyCESYFSYsieLPxt6xBXIowZ8ItQFJhFb181qj1tktYI/NT9vk7QUKL0NT8CfvfNLVTc83Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sjAds-0007LE-UW; Wed, 28 Aug 2024 06:50:48 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sjAdq-003akd-KX; Wed, 28 Aug 2024 06:50:46 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sjAdq-00Ahtu-1f;
	Wed, 28 Aug 2024 06:50:46 +0200
Date: Wed, 28 Aug 2024 06:50:46 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v3 1/3] phy: open_alliance_helpers: Add defines
 for link quality metrics
Message-ID: <Zs6spnCAPsTmUfrL@pengutronix.de>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
 <20240822115939.1387015-2-o.rempel@pengutronix.de>
 <20240826093217.3e076b5c@kernel.org>
 <4a1a72f5-44ce-4c54-9bc5-7465294a39fe@lunn.ch>
 <20240826125719.35f0337c@kernel.org>
 <Zs1bT7xIkFWLyul3@pengutronix.de>
 <20240827113300.08aada20@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827113300.08aada20@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Aug 27, 2024 at 11:33:00AM -0700, Jakub Kicinski wrote:
> On Tue, 27 Aug 2024 06:51:27 +0200 Oleksij Rempel wrote:
> > I completely agree with you, but I currently don't have additional
> > budget for this project.
> 
> Is this a legit reason not to do something relatively simple?

Due to the nature of my work in a consulting company, my time is scheduled
across multiple customers. For the 10BaseT1 PHY, I had 2 days budgeted left,
which allowed me to implement some extra diagnostics. This was simple,
predictable, and within the scope of the original task.

However, now that the budget for this task and customer has been used up, any
additional work would require a full process:
- I would need to sell the idea to the customer.
- The new task would need to be prioritized.
- It would then be scheduled, which could happen this year, next year, or
  possibly never.

A similar situation occurred with the EEE implementation. I started with a
simple fix for Atheros PHY's SmartEEE, but it led to reworking the entire EEE
infrastructure in the kernel. Once the budget was exhausted, I couldn’t
continue with SmartEEE for Atheros PHYs. These are the risks inherent to
consulting work. I still see it as not wasted time, because we have a better
EEE infrastructure now.

Considering that you've requested a change to the uAPI, the work has now become
more predictable. I can plan for it within the task and update the required
time budget accordingly. However, it's worth noting that while this work is
manageable, the time spent on this particular task could be seen as somewhat
wasted from a budget perspective, as it wasn't part of the original scope.

> Especially that we're talking about uAPI, once we go down
> the string path I presume they will stick around forever.

Yes, I agree with it. I just needed this feedback as early as possible.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

