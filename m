Return-Path: <netdev+bounces-152545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034E39F48C7
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D75188CE41
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D61E048B;
	Tue, 17 Dec 2024 10:24:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F51DBB35
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431052; cv=none; b=sYkvQWsdZLDt78795pRrYsp2m6r3L5Dg0ax13HNfEOl7EVT+S9MuhnbRNby8jWi1ex7EKcYR2TQLDWTtv0xzIZwNHCo3LJ1lVnK0T5g9s8wVHcjV3p+dH7a7Mj6O8YvyC3KIKYYFnGOSRseUEmWt+K6qvRHy2qS+ISg+L2uf/H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431052; c=relaxed/simple;
	bh=6arRrA87vBXYEa34I0Qtw5crSOyJNNwrEmLHh4mnJiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRvLL5KEIOI6G5ya6P5EwJHGrcI3FnI8mbM4oVs006cjXdejThAwcQEtsvfe6HtqqFiDFW6MMeSb8Q3hhYSWTqVAY7RslcyqEMlGpj/8m/9u/KNbIgkKGx/mtjbWM98uZna+zbGYGrAdW6+1dApvbGqngZswAWGU78wu6HHzFtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tNUkD-0003em-RE; Tue, 17 Dec 2024 11:24:01 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tNUkA-003qct-2M;
	Tue, 17 Dec 2024 11:23:59 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tNUkB-004V6C-1G;
	Tue, 17 Dec 2024 11:23:59 +0100
Date: Tue, 17 Dec 2024 11:23:59 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <Z2FRP6K0uZRyvtUC@pengutronix.de>
References: <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
 <20241216194641.b7altsgtjjuloslx@skbuf>
 <Z2CpgqpIR5_MXTO7@lore-desk>
 <20241216231311.odozs4eki7bbagwp@skbuf>
 <Z2FAUuOh4jrA0uGu@lore-desk>
 <20241217093040.x4yangwss2xa5lbz@skbuf>
 <Z2FL-IcDLHXV-WCU@lore-desk>
 <20241217101724.v6kbmfqpq3kgyrd4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241217101724.v6kbmfqpq3kgyrd4@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Dec 17, 2024 at 12:17:24PM +0200, Vladimir Oltean wrote:
> On Tue, Dec 17, 2024 at 11:01:28AM +0100, Lorenzo Bianconi wrote:
> > I agree it is unnecessary, but w/o it we must rely on limited QoS capabilities
> > of the hw dsa switch. The goal of the series is just exploit enhanced QoS
> > capabilities available on the EN7581 SoC.
> (...)
> > AFIR there is even the possibility to configure inter-channel QoS on the chip,
> > like a Round Robin scheduler or Strict-Priority between channels.
> 
> So the conclusion of both these statements is that it would be good to understand
> the QoS algorithm among channels of the MAC chip, see if there is any classful
> root Qdisc which can describe that algorithm, then offload it with ndo_setup_tc(),
> then assign traffic to user ports probably using a software classifier + flowid.
> The ETS Qdiscs which you are trying to add here should not be attached to the root
> egress Qdisc of DSA user ports, but to the classes of this unknown conduit root
> Qdisc. Agree?

I would love to have some kind of easy to use DSA user ports classifiers.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

