Return-Path: <netdev+bounces-232549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13712C06721
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D38584E4106
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C9031B13A;
	Fri, 24 Oct 2025 13:18:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5752317708
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311906; cv=none; b=eob1xJurD232tS6PIWqTKvuT3OXY585bVQ6CS2iaSFcT72lBEjXkm1TVImreoFTLioMy/uCG2quRhVTjoNL3lBLToc0ZTEuklqq6qECWxbTc17tQebkMfBgCFy6G9MM/Ccx15noylGsI3ohLkZAcMGK9UHyWv/Ti8j2Ze+0Fv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311906; c=relaxed/simple;
	bh=5gwLBZAwmz9kkOBD504Qy/puGjfNFwfKuF+sFzrbAWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkKLeLnskjrnKmLsa7Q8QNATJhFcDGVQbVbcGPIGqRKSaOKtBneR5pl2n4zmqHB9jhl7TFOETak2DxYuT1QtQFGS9eMgtcQB8tQ7eUyktHNlGORHSbkBKT++qvm5P0+RyHLdyeRcu8V4f87N5fQkaxFVrZ9oUVSQJswqDHhgqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vCHgF-0002Tr-3t; Fri, 24 Oct 2025 15:18:07 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vCHgC-005ETD-1z;
	Fri, 24 Oct 2025 15:18:04 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vCHgC-00FB7D-1U;
	Fri, 24 Oct 2025 15:18:04 +0200
Date: Fri, 24 Oct 2025 15:18:04 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk <roan@protonic.nl>
Subject: Re: [PATCH net-next v7 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <aPt8jAXU0l1f2zPG@pengutronix.de>
References: <20251020103147.2626645-1-o.rempel@pengutronix.de>
 <20251020103147.2626645-3-o.rempel@pengutronix.de>
 <20251023181343.30e883a4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023181343.30e883a4@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Jakub,

On Thu, Oct 23, 2025 at 06:13:43PM -0700, Jakub Kicinski wrote:
> On Mon, 20 Oct 2025 12:31:44 +0200 Oleksij Rempel wrote:
> > +      -
> > +        name: supported-caps
> > +        type: nest
> > +        nested-attributes: bitset
> > +        enum: phy-mse-capability
> 
> This is read only, does it really have to be a bitset?

It describes the capabilities of the driver/hardware. You can get always
everything... Hm... I think we continue without capabilities for now and
also remove the specific channel request.

> YNL will generate the string table automatically for user space to map
> the bits to names. And we have to do a bunch of const_ilog2() and render
> the MASK in the uAPI...

regards,
Oleksij & Marc

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

