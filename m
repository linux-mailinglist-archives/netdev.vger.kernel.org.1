Return-Path: <netdev+bounces-221550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47778B50CC0
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 06:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05825E4F2B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 04:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B10287515;
	Wed, 10 Sep 2025 04:17:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424824E4C6
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 04:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757477824; cv=none; b=hJQf7k7DduR3WfP1375O5Z8jCxtUqpnCdpxgdqPjYj3E1SwTwkd3boOjLbX6sMHR7MTLDd2J7R+WgnippxXwbijjfIUjHmwPp99UgYM3rCXLOSDyKpmrZmjxBzdUuAYshKj7Utp+4cqN/HotLU5Aqy4A18+vnvIW9giYm2LQWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757477824; c=relaxed/simple;
	bh=w0W3KNjsi/GHJVWcfix9W6ySCaUXQgtzSg/5Pkb/yZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M60O48/1g2OHO9Grahnj+uQQ/uXy4uA+hvZtYhORTCJC4+7HZs7MlPALainyAjhh08UnrZEaprF5Vh2yhc19e5J/fNZ64frINAoDOQ+b2JMrXFXWe3ZseRvEYnKkbTSnhy+2jB0nDE4b4sIgkjxkDgszY31tSDuXqF6dWYCODTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uwCGH-0003hM-82; Wed, 10 Sep 2025 06:16:49 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uwCGG-000X4t-2J;
	Wed, 10 Sep 2025 06:16:48 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uwCGG-00G74b-1q;
	Wed, 10 Sep 2025 06:16:48 +0200
Date: Wed, 10 Sep 2025 06:16:48 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Russell King <linux@armlinux.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <aMD7sFlcQJpOK51B@pengutronix.de>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
 <DCNKVCWI6VEQ.30M6YA786ZIX2@gmail.com>
 <aL_UfST0Q3HrSEtM@pengutronix.de>
 <20250909165645.755e52f6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909165645.755e52f6@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Sep 09, 2025 at 04:56:45PM -0700, Jakub Kicinski wrote:
> On Tue, 9 Sep 2025 09:17:17 +0200 Oleksij Rempel wrote:
> > > > Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")  
> > > 
> > > It does, but v5.15 (including v5.15.191 LTS) is affected as well, from
> > > 4a2c7217cd5a ("net: usb: asix: ax88772: manage PHY PM from MAC"). I think
> > > it could also use a patch, but I won't insist.  
> > 
> > Ack, I'll try do address it later.
> 
> Any idea what the problem is there? Deadlocking on a different lock?

Yes, it is PM lock taken in MDIO access inside of PM routine.  We can't
reliably detect a PM context from MDIO bus read/write calls.  Taking
local counters or setting flags would partially work, but they all are
not safe against race conditions.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

