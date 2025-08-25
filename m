Return-Path: <netdev+bounces-216447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B846B33A6D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 11:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 776854E2E74
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 09:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFA02C1581;
	Mon, 25 Aug 2025 09:14:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382A29E116
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113267; cv=none; b=ZRn27Jk3mbHYaBkWdNRa17sZJP1sz/5iHgHn+ChVphZJJnztoXqcTWHWTD2TZVS5VzrN3T0HVARxBKRgjExQU5eqK5HOfHKw3ply4R/czttYjQzgKdCHLJgVCRU0CYK7tz/R7Gmyr3kkxE69Ipdv2RahO0ngNc6t3OdMq/9YNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113267; c=relaxed/simple;
	bh=IZE2IObkGus8MxAtOBzoPr06fFPibuycSoUDGf/CF4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLPXfeRr6bTYjB1UYlfot8ecNirY0/8VWfNFcsMvzwVGA7Hfw0OiSvS1oqy5LPYsVwZyO2wVOUGIB7Smi/41QK9WK5lDkdYlfc4WG6Ku/SzvBZOcNRqWqZqp2qeJ/tGJX+CcE0DUfWUVMvBL0HvnZMItUVfg/Lnm83ystbk6l7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uqTHB-0007QK-A7; Mon, 25 Aug 2025 11:14:05 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uqTH9-0022kd-2f;
	Mon, 25 Aug 2025 11:14:03 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uqTH9-00GI4f-2J;
	Mon, 25 Aug 2025 11:14:03 +0200
Date: Mon, 25 Aug 2025 11:14:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de,
	Dent Project <dentproject@linuxfoundation.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next 2/2] net: pse-pd: pd692x0: Add sysfs interface
 for configuration save/reset
Message-ID: <aKwpW-c-nZidEBe0@pengutronix.de>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
 <20250822-feature_poe_permanent_conf-v1-2-dcd41290254d@bootlin.com>
 <d4bc2c95-7e25-4d76-994f-b68f1ead8119@lunn.ch>
 <20250825104721.28f127a2@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825104721.28f127a2@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hello Kory,

On Mon, Aug 25, 2025 at 10:47:21AM +0200, Kory Maincent wrote:
> > I've not looked at the sysfs documentation. Are there other examples
> > of such a property?
> 
> Not sure for that particular save/reset configuration case.
> Have you another implementation idea in mind?

My personal preference would be to use devlink (netlink based)
interface. We will have more controller/domain specific functions which can't
be represented per port.

PS: if you are on the OSS Amsterdam, we can talk in person about it.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

