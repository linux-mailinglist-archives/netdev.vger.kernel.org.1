Return-Path: <netdev+bounces-152530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 827929F47B8
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41ACB1882816
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B181DD55A;
	Tue, 17 Dec 2024 09:38:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67371D5ACD
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428306; cv=none; b=Jli9aSWAf7EJRSX45L8qQbzN2F9DXzU8STMOhhV/y/VS1gFaM8T37fUOW1j0hsRH9AyN1ies+TDlPDM+PrjpPlK62ngYdm/pQAx9vT/rWGOwBFVgw6sLROafjNb0c9PD9naJ6AND0wDJy7Kd+gwxkbYGfQ1HIVM+xEMZZquiiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428306; c=relaxed/simple;
	bh=DSYqypXNdmM+KHwzpyTPv0EPrH2E07uPN4gp6XAZ5dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjYl9V/ULHppjlYG2sdVFWOIL3aP/THPRFhpGboZVwU0VfNMTbbSQ1xA8zYJhketJ+KyJjqmQv/6W/0rHyNb2djnrjGwPY8sUr/OkGo2PlCcCM7DbWbhc98rQkE4rA1ztyRYBnU3R0Q0vUqjvFGEHm6sH9W2mAjmtxHuChAMdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tNU22-0006wG-Mz; Tue, 17 Dec 2024 10:38:22 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tNU20-003qHW-2f;
	Tue, 17 Dec 2024 10:38:21 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tNU21-004UUM-1b;
	Tue, 17 Dec 2024 10:38:21 +0100
Date: Tue, 17 Dec 2024 10:38:21 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <Z2FGjeyawnhABnRb@pengutronix.de>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <20241211154109.dvkihluzdouhtamr@skbuf>
 <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
 <f8e74e29-f4b0-4e38-8701-a4364d68230f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8e74e29-f4b0-4e38-8701-a4364d68230f@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Dec 17, 2024 at 12:24:13AM +0100, Andrew Lunn wrote:
> > Considering patch [0], we are still offloading the Qdisc on the provided
> > DSA switch port (e.g. LANx) via the port_setup_tc() callback available in
> > dsa_user_setup_qdisc(), but we are introducing even the ndo_setup_tc_conduit()
> > callback in order to use the hw Qdisc capabilities available on the mac chip
> > (e.g. EN7581) for the routed traffic from WAN to LANx. We will still apply
> > the Qdisc defined on LANx for L2 traffic from LANy to LANx. Agree?
> 
> I've not read all the details, so i could be getting something
> wrong. But let me point out the basics. Offloading is used to
> accelerate what Linux already supports in software. So forget about
> your hardware. How would i configure a bunch of e1000e cards connected
> to a software bridge to do what you want?
> 
> There is no conduit interface in this, so i would not expect to
> explicitly configure a conduit interface. Maybe the offloading needs
> to implicitly configure the conduit, but that should be all hidden
> away from the user. But given the software bridge has no concept of a
> conduit, i doubt it.
> 
> It could well be our model does not map to the hardware too well,
> leaving some bits unusable, but there is not much you can do about
> that, that is the Linux model, accelerate what Linux supports in
> software.

Hi,

You are absolutely correct that offloading should accelerate what Linux already
supports in software, and we need to respect this model. However, I’d like to
step back for a moment to clarify the underlying problem before focusing too
much on solutions.

### The Core Problem: Flow Control Limitations

1. **QoS and Flow Control:** 

   At the heart of proper QoS implementation lies flow control. Flow control
   mechanisms exist at various levels:

   - MAC-level signaling (e.g., pause frames)

   - Queue management (e.g., stopping queues when the hardware is congested)

   The typical Linux driver uses flow control signaling from the MAC (e.g.,
   stopping queues) to coordinate traffic, and depending on the Qdisc, this
   flow control can propagate up to user space applications.

2. **Challenges with DSA:**
   In DSA, we lose direct **flow control communication** between:

   - The host MAC

   - The MAC of a DSA user port.

   While internal flow control within the switch may still work, it does not
   extend to the host. Specifically:

   - Pause frames often affect **all priorities** and are not granular enough
     for low-latency applications.

   - The signaling from the MAC of the DSA user port to the host is either
     **not supported** or is **disabled** (often through device tree
     configuration).

### Why This Matters for QoS

For traffic flowing **from the host** to DSA user ports:

- Without proper flow control, congestion cannot be communicated back to the
  host, leading to buffer overruns and degraded QoS.  

- To address this, we need to compensate for the lack of flow control signaling
  by applying traffic limits (or shaping).

### Approach: Applying Limits on the Conduit Interface

One way to solve this is by applying traffic shaping or limits directly on the
**conduit MAC**. However, this approach has significant complexity:

1. **Hardware-Specific Details:**

   We would need deep hardware knowledge to set up traffic filters or disectors
   at the conduit level. This includes:

   - Parsing **CPU tags** specific to the switch in use.  

   - Applying port-specific rules, some of which depend on **user port link
     speed**.

2. **Admin Burden:**

   Forcing network administrators to configure conduit-specific filters
   manually increases complexity and goes against the existing DSA abstractions,
   which are already well-integrated into the kernel.


### How Things Can Be Implemented

To address QoS for host-to-user port traffic in DSA, I see two possible
approaches:

#### 1. Apply Rules on the Conduit Port (Using `dst_port`)

In this approach, rules are applied to the **conduit interface**, and specific
user ports are matched using **port indices**.

# Conduit interface  
tc qdisc add dev conduit0 clsact  

# Match traffic for user port 1 (e.g., lan0)  
tc filter add dev conduit0 egress flower dst_port 1 \  
    action police rate 50mbit burst 5k drop  

# Match traffic for user port 2 (e.g., lan1)  
tc filter add dev conduit0 egress flower dst_port 2 \  
    action police rate 30mbit burst 3k drop  

#### 2. Apply Rules Directly on the User Ports (With Conduit Marker)

In this approach, rules are applied **directly to the user-facing DSA ports**
(e.g., `lan0`, `lan1`) with a **conduit-specific marker**. The kernel resolves
the mapping internally.

# Apply rules with conduit marker for user ports  
tc qdisc add dev lan0 root tbf rate 50mbit burst 5k conduit-only  
tc qdisc add dev lan1 root tbf rate 30mbit burst 3k conduit-only  

Here:  
- **`conduit-only`**: A marker (flag) indicating that the rule applies
specifically to **host-to-port traffic** and not to L2-forwarded traffic within
the switch.  

### Recommendation

The second approach (**user port-based with `conduit-only` marker**) is cleaner
and more intuitive. It avoids exposing hardware details like port indices while
letting the kernel handle conduit-specific behavior transparently.

Best regards,  
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

