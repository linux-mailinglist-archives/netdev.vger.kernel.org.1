Return-Path: <netdev+bounces-221083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48A7B4A34C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4AC1768A4
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 07:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BCD30507E;
	Tue,  9 Sep 2025 07:17:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579E239E70
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402264; cv=none; b=tmqqh52/BhScdJ1bq9Y3HIXnAysCQ840QL5gSYANkoZB8G6PswP3tFeMe/9i64GmZ9E9uFlQl0N4FmlZr8XKsliUPzRh5dPFigWWyHC/ryPU1GxSV3G5xB5dSZSt64dphEuBqqdTSs/voQc6hoyaQPkdihroVMVWqUbu0eaCvxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402264; c=relaxed/simple;
	bh=xcbuBAIcV7PYG4iVvgt6Hx4JudC8RwH/H+Q+eNBFY44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlT5yvftkx5Zh+ie46EMe1XEMq1BXPyLdrDbUn+CL7JesPoT8U8xdS7G44BUhJY0jqoaWFz1ThX8IlaLeOg5BlivbVqEAVx1TuKipQn9SW7GmMIJgFOdL0y8mGOR3zhZZoPhEqpwd9rfXqKXIi+NdWlfuNFEKSm6sFIULycREUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsbO-0003x4-SX; Tue, 09 Sep 2025 09:17:18 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsbN-000Nkg-0l;
	Tue, 09 Sep 2025 09:17:17 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsbN-00DwzJ-0J;
	Tue, 09 Sep 2025 09:17:17 +0200
Date: Tue, 9 Sep 2025 09:17:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Russell King <linux@armlinux.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <aL_UfST0Q3HrSEtM@pengutronix.de>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
 <DCNKVCWI6VEQ.30M6YA786ZIX2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DCNKVCWI6VEQ.30M6YA786ZIX2@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Sep 08, 2025 at 07:00:09PM +0200, Hubert Wiśniewski wrote:
> On Mon Sep 8, 2025 at 1:26 PM CEST, Oleksij Rempel wrote:
> > Drop phylink_{suspend,resume}() from ax88772 PM callbacks.
> >
> > MDIO bus accesses have their own runtime-PM handling and will try to
> > wake the device if it is suspended. Such wake attempts must not happen
> > from PM callbacks while the device PM lock is held. Since phylink
> > {sus|re}sume may trigger MDIO, it must not be called in PM context.
> >
> > No extra phylink PM handling is required for this driver:
> > - .ndo_open/.ndo_stop control the phylink start/stop lifecycle.
> > - ethtool/phylib entry points run in process context, not PM.
> > - phylink MAC ops program the MAC on link changes after resume.
> 
> Thanks for the patch! Applied to v6.17-rc5, it fixes the problem for me.
> 
> Tested-by: Hubert Wiśniewski <hubert.wisniewski.25632@gmail.com>

Thank you for testing!

> > Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")
> 
> It does, but v5.15 (including v5.15.191 LTS) is affected as well, from
> 4a2c7217cd5a ("net: usb: asix: ax88772: manage PHY PM from MAC"). I think
> it could also use a patch, but I won't insist.

Ack, I'll try do address it later.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

