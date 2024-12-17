Return-Path: <netdev+bounces-152582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C16D9F4ADB
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0221888D96
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A51E3DF7;
	Tue, 17 Dec 2024 12:22:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA113A3ED
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438174; cv=none; b=HaLeO+kDihMI4GAMBA5PUwIcAZvIGb25hL/ZTzvtyt9FWcXmZ5hIM2Nlu5Yksod/9PfrnFvKXE37vPzSMwffofKelCQe3E/JpKWJgHvJYCYWz2kJ//1k6/kYESrs6pDqhuob0kl6q0qL5YctdcXOx30ejlqi+xfLqAkVcXPZWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438174; c=relaxed/simple;
	bh=mi5CgPyFWHrY64jxsmXTL5sseSLIHSnEP+8MGtPqWUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjj4ZDku3hSyrgsarm0utC02aHbRN502mjgwZGGAD1t2LtDU/1lViQnzJMe+ixR9GPotpIkViVvQYquEe+H8hjTFlsLp4LVDVJ/XEIRpHjvtf8dTyhW0VTA4g2/G8pXzkLdBZ3W0GjpVlZmCTQQvLYAfwe+B1mvVFc9PdHNdQbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tNWbA-0005Pu-HF; Tue, 17 Dec 2024 13:22:48 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tNWb7-003rV6-16;
	Tue, 17 Dec 2024 13:22:46 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tNWb8-004WuF-00;
	Tue, 17 Dec 2024 13:22:46 +0100
Date: Tue, 17 Dec 2024 13:22:45 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <Z2FtFR6Ll6c-XPTX@pengutronix.de>
References: <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
 <f8e74e29-f4b0-4e38-8701-a4364d68230f@lunn.ch>
 <Z2FGjeyawnhABnRb@pengutronix.de>
 <Z2FGjeyawnhABnRb@pengutronix.de>
 <20241217115448.tyophzmiudpxuxbz@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217115448.tyophzmiudpxuxbz@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Dec 17, 2024 at 01:54:48PM +0200, Vladimir Oltean wrote:
> On Tue, Dec 17, 2024 at 10:38:21AM +0100, Oleksij Rempel wrote:
> > Hi,
> > 
> > You are absolutely correct that offloading should accelerate what Linux already
> > supports in software, and we need to respect this model. However, I’d like to
> > step back for a moment to clarify the underlying problem before focusing too
> > much on solutions.
> > 
> > ### The Core Problem: Flow Control Limitations
> > 
> > 1. **QoS and Flow Control:** 
> > 
> >    At the heart of proper QoS implementation lies flow control. Flow control
> >    mechanisms exist at various levels:
> > 
> >    - MAC-level signaling (e.g., pause frames)
> > 
> >    - Queue management (e.g., stopping queues when the hardware is congested)
> > 
> >    The typical Linux driver uses flow control signaling from the MAC (e.g.,
> >    stopping queues) to coordinate traffic, and depending on the Qdisc, this
> >    flow control can propagate up to user space applications.
> 
> I read this section as "The Core Problem: Ethernet".

ack.

> > ### Why This Matters for QoS
> > 
> > For traffic flowing **from the host** to DSA user ports:
> > 
> > - Without proper flow control, congestion cannot be communicated back to the
> >   host, leading to buffer overruns and degraded QoS.  
> 
> There are multiple, and sometimes conflicting, goals to QoS and strategies on
> congestion. Generally speaking, it is good to clarify that deterministic latency,
> high throughput and zero loss cannot be all achieved at the same time. It is
> also good to highlight the fact that you are focusing on zero loss and that
> this is not necessarily the full picture. Some AVB/TSN switches, like SJA1105,
> do not support pause frames at all, not even on user ports, because as you say,
> it's like the nuclear solution which stops the entire port regardless of
> packet priorities. And even if they did support it, for deterministic latency
> applications it is best to turn it off. If you make a port enter congestion by
> bombarding it with TC0 traffic, you'll incur latency to TC7 traffic until you
> exit the congestion condition. These switches just expect to have reservations
> very carefully configured by the system administrator. What exceeds reservations
> and cannot consume shared resources (because they are temporarily depleted) is dropped.

> > - To address this, we need to compensate for the lack of flow control signaling
> >   by applying traffic limits (or shaping).
> 
> A splendid idea in theory. In practice, the traffic rate at the egress
> of a user port is the sum of locally injected traffic plus autonomously
> forwarded traffic. The port can enter congestion even with shaping of
> CPU-injected traffic at a certain rate.
> 
>             Conduit
>                |
>                v
>   +-------------------------+
>   |         CPU port        |
>   |            |            |
>   |   +--------+            |
>   |   |                     |
>   |   +<---+                |
>   |   |    |                |
>   |   v    |                |
>   | lan0  lan1  lan2  lan3  |
>   +-------------------------+
>       |
>       v Just 1Gbps.
> 
> You _could_ apply this technique to achieve a different purpose than
> net zero packet loss: selective transmission guarantees for CPU-injected
> traffic. But you also need to ensure that injected packets have a higher
> strict priority than the rest, and that the switch resources are
> configured through devlink-sb to have enough reserved space to keep
> these high priority packets on congestion and drop something else instead.
> 
> It's a tool to have for sure, but you need to be extremely specific and
> realistic about your goals.

Yes, you are right. For my specific use case the switch is used mostly as port
multiplayer.

> > #### 2. Apply Rules Directly on the User Ports (With Conduit Marker)
> > 
> > In this approach, rules are applied **directly to the user-facing DSA ports**
> > (e.g., `lan0`, `lan1`) with a **conduit-specific marker**. The kernel resolves
> > the mapping internally.
> > 
> > # Apply rules with conduit marker for user ports  
> > tc qdisc add dev lan0 root tbf rate 50mbit burst 5k conduit-only  
> > tc qdisc add dev lan1 root tbf rate 30mbit burst 3k conduit-only  
> > 
> > Here:  
> > - **`conduit-only`**: A marker (flag) indicating that the rule applies
> > specifically to **host-to-port traffic** and not to L2-forwarded traffic within
> > the switch.  
> > 
> > ### Recommendation
> > 
> > The second approach (**user port-based with `conduit-only` marker**) is cleaner
> > and more intuitive. It avoids exposing hardware details like port indices while
> > letting the kernel handle conduit-specific behavior transparently.
> > 
> > Best regards,  
> > Oleksij
> 
> The second approach that you recommend suffers from the same problem as Lorenzo's
> revised proposal, which is that it treats the conduit interface as a collection of
> independent pipes of infinite capacity to each user port, with no arbitration concerns
> of its own. The model is again great in theory, but maps really poorly on real life.
> Your proposal actively encourages users to look away from the scheduling algorithm
> of the conduit, and just look at user ports in isolation of each other. I strongly
> disagree with it.

I'm still thinking about best way to classify DSA user port traffic.
Will it be enough to set classid on user port?

tc filter add dev lan0 protocol all flower skip_hw \
    action classid 1:1
tc filter add dev lan1 protocol all flower skip_hw \
    action classid 1:2

And then process it on the conduit port:
# Add HTB Qdisc on the conduit interface
tc qdisc add dev conduit0 root handle 1: htb default 1

# Define rate-limiting classes
tc class add dev conduit0 parent 1: classid 1:1 htb rate 100mbit burst 5k
tc class add dev conduit0 parent 1: classid 1:2 htb rate 100mbit burst 5k

Or the classid will not be transferred between devices and i'll need to
use something like skbedit?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

