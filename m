Return-Path: <netdev+bounces-169705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF10A4552F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591DC7A1E26
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 05:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D6915852F;
	Wed, 26 Feb 2025 06:00:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E158433997
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549630; cv=none; b=ePf6tn6Al6qYZNEJuWBA1fKDje8cGJ+MCw2ytvDdRMqHKk5InWLsciC7YfMIGmY6FFfRFpVKh7/EiBW8c2ZauVA61IJQy+WntJOQmwoBnApIPHpoHjz8ZzL4W+2ebJRWBjuPWAgqVQbeevPOeU3IDWDHvEiWWGA/7qOOX89qla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549630; c=relaxed/simple;
	bh=PjPKATSdaH5JbvKv2y6nDT7XIJdOyM7DRFleSS8Wdes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYLVVZKVWK1lnxiRxwfqF+yswq9dUJS/Y1erBVQAic2wrc0E0o3f/MqEOLoLxCr3c2Afqa9ral1bDOrpXxYtg3AzudXQwLEMU2CLUJmF9rS8w0VPEChprWt1eTa2omMjQ8EN5tX2FBd3GSw+HGpw3g8PQVgm3Rc5wqFU8jBKxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tnASU-0004lp-1A; Wed, 26 Feb 2025 06:59:50 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tnASP-002tnR-1n;
	Wed, 26 Feb 2025 06:59:45 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tnASP-001SXr-1K;
	Wed, 26 Feb 2025 06:59:45 +0100
Date: Wed, 26 Feb 2025 06:59:45 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <Z76t0VotFL7ji41M@pengutronix.de>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
 <20250218-feature_poe_port_prio-v5-6-3da486e5fd64@bootlin.com>
 <20250220165129.6f72f51a@kernel.org>
 <20250224141037.1c79122b@kmaincent-XPS-13-7390>
 <20250224134522.1cc36aa3@kernel.org>
 <20250225102558.2cf3d8a5@kmaincent-XPS-13-7390>
 <20250225174752.5dbf65e2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225174752.5dbf65e2@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Feb 25, 2025 at 05:47:52PM -0800, Jakub Kicinski wrote:
> On Tue, 25 Feb 2025 10:25:58 +0100 Kory Maincent wrote:
> > On Mon, 24 Feb 2025 13:45:22 -0800
> > Jakub Kicinski <kuba@kernel.org> wrote:
> > 
> > > > No they can't for now. Even different PSE power domains within the same PSE
> > > > controller. I will make it explicit.    
> > > 
> > > Sounds like the property is placed at the wrong level of the hierarchy,
> > > then.  
> > 
> > When a PSE controller appears to be able to support mixed budget strategy and
> > could switch between them it will be better to have it set at the PSE power
> > domain level. As the budget is per PSE power domain, its strategy should also
> > be per PSE power domain.
> > For now, it is simply not configurable and can't be mixed. It is hard-coded by
> > the PSE driver.
> 
> Yes, but uAPI is forever. We will have to live with those domain
> attributes duplicated on each port. Presumably these port attributes
> will never support a SET operation, since the set should be towards 
> the domain? The uAPI does not inspire confidence. If we need more
> drivers to define a common API maybe a local sysfs API in the driver
> will do?

I tend to disagree here. The evaluation/allocation methods should be
per port.  

At this step, we support only "hardware"(firmware)-based methods:  
1. Static – Plain hardware classification-based power allocation per
port.  
2. Dynamic – Hardware classification with constant measurement for
optimization.  

For some devices, the dynamic method may not work reliably enough,
so we will need to switch to a fixed allocation method, which is
currently not implemented but will be set via user space. This
should be configurable per port.  

At some point, we will need to introduce LLDP-based allocation from
user space. This will be managed by a daemon.

For testing, here’s an example of how LLDP-based power negotiation can
be analyzed:
https://telecomtest.com.au/wp-content/uploads/2016/12/PDA-LLDP-Powered-Device-LLDP-Analyzer.pdf

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

