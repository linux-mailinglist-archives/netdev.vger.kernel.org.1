Return-Path: <netdev+bounces-116446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F172294A6B5
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69351F2125D
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51931E2890;
	Wed,  7 Aug 2024 11:10:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5C1E211D
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723029039; cv=none; b=euvvGLnts6K69fH2pWmiJDOseF0lTP8XMJTsFv5aHuXZ321wsRE3U/jP7hsAN8GHoYbx8zoL2hPZnQE/A58kW1waJYtWNMT0J6bC49lHPal1pTdpsm2yk/fgys74+W4phi1jZuKcC5LsBMLlm31nVkAjyR8odmeTLLILx1ocp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723029039; c=relaxed/simple;
	bh=w/33/4xPAAyjcsz8TUb0CK3jGN3A18eYdaVHZPd7ki8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqalkevEYZat6NCRyav8S1EooRlBGIQ/CNlJF9KaEvq+OeVIWR60ocE7/DuHv+82hFAJKoONFuRf4BtTC8FmyNASZ2wTyHBQMEs/WAyG8eJRxYZvsnY3bsUAjgMw/LAm6GhtwauJORv3g4qEMVDTXgEdXgQ6n5SDIKbCyz5RCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sbeYk-00079C-Us; Wed, 07 Aug 2024 13:10:26 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sbeYj-005B53-UC; Wed, 07 Aug 2024 13:10:25 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sbeYj-006vAm-2d;
	Wed, 07 Aug 2024 13:10:25 +0200
Date: Wed, 7 Aug 2024 13:10:25 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: dp83tg720: Add cable testing
 support
Message-ID: <ZrNWIfcCjHm4G4d9@pengutronix.de>
References: <20240807093251.3308737-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807093251.3308737-1-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


On Wed, Aug 07, 2024 at 11:32:51AM +0200, Oleksij Rempel wrote:
> Introduce cable testing support for the DP83TG720 PHY. This implementation
> is based on the "DP83TG720S-Q1: Configuring for Open Alliance Specification
> Compliance (Rev. B)" application note.
> 
> The feature has been tested with cables of various lengths:
> - No cable: 1m till open reported.
> - 5 meter cable: reported properly.
> - 20 meter cable: reported as 19m.
> - 40 meter cable: reported as cable ok.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
 
There is missing PHY_POLL_CABLE_TEST, i'll send v2 soon.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

