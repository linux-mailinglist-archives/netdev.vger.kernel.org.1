Return-Path: <netdev+bounces-152349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C409F38B2
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 19:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70255168E3D
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4862B209678;
	Mon, 16 Dec 2024 18:14:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FFA207663
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372899; cv=none; b=JemJHBQJxQ6TzCpCWLU2EWbISosJbm+F2GXHMYRe+i5HlQwSctcD7lk7wh3lUS7YJXdKTjC4XHoCzOImPTmJNrPpNOxsV3nvSQqaKcJMKZKa2rWWHkIsuwvvLwBIRa8XJ7Km9gfyW1oPqG8o4rXX+jtyooi3s2c4I5NeIlesiFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372899; c=relaxed/simple;
	bh=yAYEJGQin22YjpiaWw+AA6gOan4p0iXYqa5yO/bgZlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIqc4+YMKRU7I8oLz2W77GkmeatOqBnetqx0W7T+exjW9679Oo0IBUaxTYAxcgnuSaUMaC0KXC8CfdsGZ3ewPlbs2l9asVi59IOQWBBhcVVDaAs2xV6T3BeciswuNhh+Z1ALqoAk1ghM/cZR1/62AnzzruPM83++O4C0F2MV2os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tNFcK-0004rN-9o; Mon, 16 Dec 2024 19:14:52 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tNFcH-003jpC-13;
	Mon, 16 Dec 2024 19:14:50 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tNFcH-002fD6-3B;
	Mon, 16 Dec 2024 19:14:50 +0100
Date: Mon, 16 Dec 2024 19:14:49 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <Z2BuGRxhIl0Xnw4F@pengutronix.de>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <20241211154109.dvkihluzdouhtamr@skbuf>
 <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216154947.fms254oqcjj72jmx@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Dec 16, 2024 at 05:49:47PM +0200, Vladimir Oltean wrote:
> On Mon, Dec 16, 2024 at 01:09:01PM +0100, Lorenzo Bianconi wrote:
> > I guess what I did not make clear here is that we are discussing about
> > 'routed' traffic (sorry for that). The traffic is received from the WAN
> > interface and routed to a DSA port (or the other way around).
> > In this scenario the 3-way handshake will be received by the CPU via the
> > WAN port (or the conduit port) while the subsequent packets will be hw
> > forwarded from WAN to LAN (or LAN to WAN). For EN7581 [0], the traffic
> > will be received by the system from GDM2 (WAN) and the PSE/PPE blocks
> > will forward it to the GDM1 port that is connected to the DSA cpu port.
> > 
> > The proposed series is about adding the control path to apply a given Qdisc
> > (ETS or TBF for EN7581) to the traffic that is following the described path
> > without creating it directly on the DSA switch port (for the reasons described
> > before). E.g. the user would want to apply an ETS Qdisc just for traffic
> > egressing via lan0.
> > 
> > This series is not strictly related to the airoha_eth flowtable offload
> > implementation but the latter is required to have a full pictures of the
> > possible use case (this is why I was saying it is better to post it first).
> 
> It's good to know this does not depend on flowtable.
> 
> When you add an offloaded Qdisc to the egress of a net device, you don't
> affect just the traffic L3 routed to that device, but all traffic (also
> includes the packets sent to it using L2 forwarding). As such, I simply
> don't believe that the way in which the UAPI is interpreted here (root
> egress qdisc matches only routed traffic) is proper.
> 
> Ack?
> 
> > > I'm trying to look at the big picture and abstract away the flowtable a
> > > bit. I don't think the tc rule should be on the user port. Can the
> > > redirection of packets destined towards a particular switch port be
> > > accomplished with a tc u32 filter on the conduit interface instead?
> > > If the tc primitives for either the filter or the action don't exist,
> > > maybe those could be added instead? Like DSA keys in "flower" which gain
> > > introspection into the encapsulated packet headers?
> > 
> > The issue with the current DSA infrastructure is there is no way to use
> > the conduit port to offload a Qdisc policy to a given lan port since we
> > are missing in the APIs the information about what user port we are
> > interested in (this is why I added the new netdev callback).
> 
> How does the introduction of ndo_setup_tc_conduit() help, since the problem
> is elsewhere? You are not making "tc qdisc add lanN root ets" work correctly.
> It is simply not comparable to the way in which it is offloaded by
> drivers/net/dsa/microchip/ksz_common.c, even though the user space
> syntax is the same. Unless you're suggesting that for ksz it is not
> offloaded correctly?
> 
> Oleksij, am I missing something?

Ahm.. let me try to understand the problem. First I would like to
interpret the diagram provide by Lorenzo, since I have no idea about
EN7581, I use KSZ* model and transfer it to this one:

                               CPU
                                |
              +-----------------|---------------------+
    EN7581    |      GDM1  <-- fabric? ---->    GDM2  | like NXP Layerscape?
              +-------|--------------------------|----+
                      |                          |
              +-------|---------+               WAN
    MT7530    |      CPU_port   |
              |     fabric      |
              | lan1 lan2 ....  |
	      +--|----|----|||--+

In case of lanN to lanN traffic, switch internal QoS should be used.
This is where "tc qdisc add lanN root ets" rules apply. At least, this
is how it is implemented for KSZ switches.

In case of traffic flow from WAN to lanN, we deal with two separate sets
of queues and schedulers: GDM1 egress queues and scheduler, (probably
ingress queues on CPU_port), lanN queues and scheduler. Combining both
parts in to one rule, is not good, especially if rules of each lanN port
may be different.

> > Please consider here we are discussing about Qdisc policies and not flower
> > rules to mangle the traffic.
> 
> What's a Qdisc policy?
> 
> Also, flower is a classifier, not an action. It doesn't mangle packets
> by the very definition of what a classifier is.
> 
> > The hw needs to be configured in advance to apply the requested policy
> > (e.g TBF for traffic shaping).
> 
> What are you missing exactly to make DSA packets go to a particular
> channel on the conduit?
> 
> For Qdisc offloading you want to configure the NIC in advance, of course.
> 
> Can't you do something like this to guide packets to the correct channels?
> 
> tc qdisc add dev eth0 clsact
> tc qdisc add dev eth0 root handle 1: ets strict 8 priomap ...
> tc filter add dev eth0 egress ${u32 or flower filter to match on DSA tagged packets} \
> 	flowid 1:1

ACK, this would be my expectation as well.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

