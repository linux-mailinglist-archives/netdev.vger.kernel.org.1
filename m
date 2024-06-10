Return-Path: <netdev+bounces-102150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B35F0901A24
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4258D28114F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 05:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159C0B665;
	Mon, 10 Jun 2024 05:19:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19263E54C
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 05:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717996752; cv=none; b=UyMdFUUjT7Md7X4jZe1zWtRQQLApw8Bsb7tjQXT6bYbIJVOTU/LqEC2iX48wqgXK1cM+fSdDcBneK17Zh6W6slmp0n++5u4d8pA9+tT7y2SN3PY7RmRVbfXlUYqa1W56H282UeguYt/SooscA+Wz1qUu87RF8Y++oIyD8On0jjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717996752; c=relaxed/simple;
	bh=7ntQIKjCmbVB3mRfR1Es9qBGZ2i/gfx/4taFn68S4lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LckfcdWa686Qu9HDDWTC2Lcf09sTj3yWH5xyUO1StqSwgILRuENRyUZD9mCRWwRZfvVNmC/NTeEr44l3QlnOy/ym6tbaIyhzLAP9IQt6fjv5bWoGI5Saf2cxr2TgmHJfhgAwvbmYvHKvhXaNts3iImiynWB4v8nwSTy1bNuF7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sGXQp-0004IY-Uq; Mon, 10 Jun 2024 07:18:59 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sGXQp-001E4m-2X; Mon, 10 Jun 2024 07:18:59 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sGXQo-002fpI-3B;
	Mon, 10 Jun 2024 07:18:58 +0200
Date: Mon, 10 Jun 2024 07:18:58 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next v2 1/8] net: pse-pd: Use EOPNOTSUPP error code
 instead of ENOTSUPP
Message-ID: <ZmaMwrnUx-sqabFs@pengutronix.de>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
 <20240607-feature_poe_power_cap-v2-1-c03c2deb83ab@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607-feature_poe_power_cap-v2-1-c03c2deb83ab@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Jun 07, 2024 at 09:30:18AM +0200, Kory Maincent wrote:
> From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
> 
> ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP as reported by
> checkpatch script.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

This patch can go directly to net as fixes.
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

