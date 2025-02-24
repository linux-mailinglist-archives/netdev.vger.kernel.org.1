Return-Path: <netdev+bounces-168889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C44A414BE
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 06:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28221714EB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 05:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BF91A4B69;
	Mon, 24 Feb 2025 05:28:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE432C85
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374890; cv=none; b=JSdOxknhHvQ/1UeMAICyNcff1INNlXYFTsbSyUsIiNq/tK0BzZWrZx83uwfPZKebb5iLjcIhvjn3S7E0jYYqJNStNhyAQUGzA6KTiXsgqroyE9SuO8P+3nEYnYXn+4CdzrJ9AtIQbrG3VxyV1nLN/WjDlhfQ47l35pJzYB0LJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374890; c=relaxed/simple;
	bh=uWzuRER86US7MCxF1bR4hfhEqdBGONa/5pQMLfGBCnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRwvMx1EN/ZS/JDgMiBfjPzIskOrTQ74F4vFKzC/QJlG7T8OlkrBqinjJm/VPuiwGN4ZQf2nNkGZscgbWx3yhmSszOlhh3sIQCOf1PxG0l2omk5XV46PLqSzVkNiXiXtupwqKb/4WVa80mMNPFtIQauUcgvU6KXqHq/Mny1ccdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1tmR0d-0001GI-HD; Mon, 24 Feb 2025 06:28:03 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tmR0d-002XWw-0e;
	Mon, 24 Feb 2025 06:28:03 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tmR0d-00FLfr-0J;
	Mon, 24 Feb 2025 06:28:03 +0100
Date: Mon, 24 Feb 2025 06:28:03 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: select PAGE_POOL
Message-ID: <Z7wDYwWfhXWrPlAi@pengutronix.de>
References: <20250220-net-am654-nuss-kconfig-v1-1-acc813b769de@pengutronix.de>
 <20250221161613.67fe279f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221161613.67fe279f@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Feb 21, 2025 at 04:16:13PM -0800, Jakub Kicinski wrote:
> On Thu, 20 Feb 2025 09:43:06 +0100 Sascha Hauer wrote:
> > am65-cpsw uses page_pool_dev_alloc_pages(), thus needs PAGE_POOL
> > selected to avoid linker errors.
> 
> If it can actually result in linker errors today could you add a Fixes
> tag pointing to the commit that added the dependency?

Sure. I just sent a v2.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

