Return-Path: <netdev+bounces-140794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304229B814E
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 18:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49821F25766
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF323198A16;
	Thu, 31 Oct 2024 17:33:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4C41C2DB4
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396015; cv=none; b=cicB5FqccVMtVdAhiN9TNaPGQXE/qVmgch/4pjWYCMfg/U5L8+s+moxccmQq+tsiX7XVOr3ocUfNquGLr+KypWguN2uAwpEWDUzANwzvB+MYSe10j4eIF3zCqji1GolhJkr5zswxDn5QddhblsYoLCSZXkLrMFDAKL2V0b1kRiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396015; c=relaxed/simple;
	bh=Ert0mHUbaRsNQ6biPmh//hNtFM+72TJEV28aPZ+D5N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm4JIGBtjbm+21UCiFhctLr/ljvp7b56xHenJV8UQNwhEfZPizttPBChG/rPsDz3SHFLePx/Q6BfcKnooIEJEOVJa3lDUaTijoV8knLoFLJlkYvhFuRlmWXAATLUJKWn7Ig+MqHJ1dZyqWDPYGrhi0uXmJK5K+muUw3OXixE31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t6Z2H-0002lx-NB; Thu, 31 Oct 2024 18:32:41 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t6Z2F-001O7s-1j;
	Thu, 31 Oct 2024 18:32:39 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t6Z2F-006Gv8-1L;
	Thu, 31 Oct 2024 18:32:39 +0100
Date: Thu, 31 Oct 2024 18:32:39 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 15/18] net: pse-pd: Add support for
 getting and setting port priority
Message-ID: <ZyO_N1EOTZCprgMJ@pengutronix.de>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
 <20241030-feature_poe_port_prio-v2-15-9559622ee47a@bootlin.com>
 <ZyMpkJRHZWYsszh2@pengutronix.de>
 <20241031121104.6f7d669c@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031121104.6f7d669c@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Oct 31, 2024 at 12:11:04PM +0100, Kory Maincent wrote:
> > This part will need some clarification about behavior with mixed port
> > configurations. Here is my proposal:
> > 
> >  * Expected behaviors in mixed port priority configurations:
> >  * - When ports are configured with a mix of disabled, static, and dynamic
> >  *   priority modes, the following behaviors are expected:
> >  *     - Ports with priority disabled (ETHTOOL_PSE_PORT_PRIO_DISABLED) are
> >  *       treated with lowest priority, receiving power only if the budget
> >  *       remains after static and dynamic ports have been served.
> >  *     - Static-priority ports are allocated power up to their requested
> >  *       levels during PD classification, provided the budget allows.
> >  *     - Dynamic-priority ports receive power based on real-time consumption,
> >  *       as monitored by the PSE controller, relative to the remaining budget
> >  *       after static ports.
> 
> I was not thinking of supporting mixed configuration but indeed why not.
> The thing is the Microchip PSE does not support static priority. I didn't find a
> way to have only detection and classification enabled without auto activation.
> Mixed priority could not be tested for now.

No, problem.

> "Requested Power: The requested power of the logical port, related to the
> requested class. In case of DSPD, it is the sum of the related class power for
> each pair-set. The value is in steps of 0.1 W.
> Assigned Class: The assigned classification depends on the requested class and
> the available power. An 0xC value means that classification was not assigned
> and power was not allocated to this port."
> 
> We could set the current limit to all unconnected ports if the budget limit goes
> under 100W. This will add complexity as the PD692x0 can set current limit only
> inside specific ranges. Maybe it is a bit too specific to Microchip.
> Microchip PSE should only support dynamic mode.

No need to fake it right now, you came up with nice idea to have
"configurable" method, wich in case of PD692x0 is only a single build in
method. Since user space will be ably to see available and used
prioritization methods - i'm happy with it.

> >  *
> >  * Handling scenarios where power budget is exceeded:
> >  * - Hot-plug behavior: If a new device is added that causes the total power
> >  *   demand to exceed the PSE budget, the newly added device is de-prioritized
> >  *   and shut down to maintain stability for previously connected devices.
> >  *   This behavior ensures that existing connections are not disrupted, though
> >  *   it may lead to inconsistent behavior if the device is disconnected and
> >  *   reconnected (hot-plugged).
> 
> Do we want this behavior even if the new device has an highest priority than
> other previously connected devices?

Huh... good question. I assume, if we go with policy in kernel, then it
is ok to implement just some one. But, I assume, we will need this kind of
interface soon or later: 

Warning! this is discussion, i'm in process of understanding :D

/**
 * enum pse_disconnection_policy - Disconnection strategies for same-priority
 *   devices when power budget is exceeded, tailored to specific priority modes.
 *
 * Each device can have multiple disconnection policies set as an array of
 * priorities. When the power budget is exceeded, the policies are executed
 * in the order defined by the user. This allows for a more nuanced and 
 * flexible approach to handling power constraints across a range of devices
 * with similar priorities or attributes.
 *
 * Example Usage:
 *   - Users can specify an ordered list of policies, such as starting with
 *     `PSE_DISCON_STATIC_CLASS_HIGHEST_FIRST` to prioritize based on class,
 *     followed by `PSE_DISCON_LRC` to break ties based on connection time.
 *     This ordered execution ensures that power disconnections align closely
 *     with the system’s operational requirements and priorities.
 *
 * @PSE_DISCON_LRC: Disconnect least recently connected device.
 *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_STATIC
 *   - Behavior: When multiple devices share the same priority level, the
 *     system disconnects the device that was most recently connected.
 *   - Rationale: This strategy favors stability for longer-standing connections,
 *     assuming that established devices may be more critical.
 *   - Use Case: Suitable for systems prioritizing stable power allocation for
 *     existing static-priority connections, making newer devices suitable
 *     candidates for disconnection if limits are exceeded.

 * @PSE_DISCON_ROUND_ROBIN_IDX_LOWEST_FIRST: Disconnect based on port index in a 
 *   round-robin manner, starting with the lowest index.
 *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_STATIC
 *   - Behavior: Disconnects devices sequentially based on port index, starting
 *     with the lowest. If multiple disconnections are required, the process
 *     continues in ascending order.
 *   - Rationale: Provides a predictable, systematic approach for static-priority
 *     devices, making it clear which device will be disconnected next if power
 *     limits are reached.
 *   - Use Case: Appropriate for systems where static-priority devices are equal
 *     in role, and fairness in disconnections is prioritized.

 * @PSE_DISCON_ROUND_ROBIN_IDX_HIGHEST_FIRST: Disconnect based on port index in a 
 *   round-robin manner, starting with the highest index.
 *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_STATIC
 *   - Behavior: Disconnects devices sequentially based on port index, starting
 *     with the highest. If multiple disconnections are required, the process
 *     continues in descending order.
 *   - Rationale: Provides a predictable, systematic approach for static-priority
 *     devices, prioritizing disconnection from the highest port number downwards.
 *   - Use Case: Suitable for scenarios where higher port numbers are less critical,
 *     or where devices connected to higher ports can be sacrificed first.

 * @PSE_DISCON_STATIC_CLASS_HIGHEST_FIRST: Disconnect based on static allocation
 *   class, disconnecting higher-class devices first.
 *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_STATIC
 *   - Behavior: Disconnects devices in order of their assigned power class,
 *     with higher-class devices being disconnected first.
 *   - Rationale: This strategy can be useful in scenarios where the goal is to
 *     preserve lower-class devices for minimal essential services, possibly
 *     sacrificing higher-class, power-intensive devices.
 *   - Use Case: Fits scenarios where power classes represent power-hungry or
 *     non-essential devices, allowing essential services to continue under
 *     constrained power conditions.

 * @PSE_DISCON_STATIC_CLASS_LOWEST_FIRST: Disconnect based on static allocation
 *   class, disconnecting lower-class devices first.
 *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_STATIC
 *   - Behavior: Disconnects devices in order of their assigned power class,
 *     with lower-class devices being disconnected first.
 *   - Rationale: Ensures that higher-class, more critical devices retain power
 *     during constrained conditions.
 *   - Use Case: Fits scenarios where power classes represent priority, allowing
 *     the system to maintain higher-class static devices under constrained
 *     conditions.

 * @PSE_DISCON_STATIC_CLASS_BUDGET_MATCH: Disconnect based on static allocation
 *   class, targeting devices that release enough allocated power to meet the
 *   current power requirement.
 *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_STATIC
 *   - Behavior: Searches for the lowest-priority device that can release
 *     sufficient allocated power to meet the current budget requirement.
 *     Ensures that disconnection occurs only when enough power is freed.
 *   - Rationale: This strategy is useful when the goal is to balance power
 *     budget requirements while minimizing the number of disconnected devices.
 *     It ensures that the system does not needlessly disconnect multiple
 *     devices if a single disconnection is sufficient to meet the power needs.
 *   - Use Case: Ideal for systems where precise power budget management is
 *     necessary, and disconnections must be efficient in terms of freeing
 *     enough power with minimal impact on the system.

 * @PSE_DISCON_LOWEST_AVG_POWER: Disconnect device with the lowest average
 *   power draw, minimizing impact on dynamic power allocation.
 *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_DYNAMIC
 *   - Behavior: Among devices with the same priority level, the system
 *     disconnects the device with the lowest average power draw.
 *   - If multiple devices have the same average power draw and priority,
 *     further tie-breaking mechanisms can be applied, such as disconnecting
 *     the least recently connected device.
 *   - Rationale: Minimizes disruption across dynamic devices, keeping as many
 *     active as possible by removing the lowest-power ones.
 *   - Use Case: Suitable for dynamic-priority systems where maximizing the
 *     number of connected devices is more important than individual device
 *     power requirements.

 * @PSE_DISCON_LONGEST_IDLE: Disconnect device with the longest idle time
 *   (low or no recent active power usage).
 *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_DYNAMIC
 *   - Behavior: Disconnects the device with the longest period of inactivity,
 *     where "idle" is defined as low current draw or absence of recent data
 *     transmission.
 *   - If multiple devices have the same idle time and priority, a tie-breaking
 *     mechanism, such as round-robin based on port index, can be used.
 *   - Rationale: Optimizes resource allocation in dynamic-priority setups by
 *     maintaining active devices while deprioritizing those with minimal
 *     recent usage.
 *   - Use Case: Ideal for dynamic environments, like sensor networks, where
 *     devices may be intermittently active and can be deprioritized during
 *     idle periods.
 *
 * These disconnection policies provide flexibility in handling cases where
 * multiple devices with the same priority exceed the PSE budget, aligning
 * with either static or dynamic port priority modes:
 *   - `ETHTOOL_PSE_PORT_PRIO_STATIC` benefits from policies that maintain
 *     stable power allocation, favoring longer-standing or higher-class
 *     devices (e.g., `PSE_DISCON_LRC`, `PSE_DISCON_ROUND_ROBIN_IDX`,
 *     `PSE_DISCON_STATIC_CLASS_HIGHEST_FIRST`, `PSE_DISCON_STATIC_CLASS_LOWEST_FIRST`,
 *     `PSE_DISCON_STATIC_CLASS_BUDGET_MATCH`).
 *   - `ETHTOOL_PSE_PORT_PRIO_DYNAMIC` supports policies that dynamically
 *     adjust based on real-time metrics (e.g., `PSE_DISCON_LOWEST_AVG_POWER`,
 *     `PSE_DISCON_LONGEST_IDLE`), ideal for setups where usage fluctuates
 *     frequently.
 *   - Users can define an ordered array of disconnection policies, allowing
 *     the system to apply each policy in sequence, providing nuanced control
 *     over how power disconnections are handled.
 */

PD692x0 seems to use @PSE_DISCON_ROUND_ROBIN_IDX_HIGHEST_FIRST disconnection
policy.

ETHTOOL_PSE_PORT_PRIO_DYNAMIC and ETHTOOL_PSE_PORT_PRIO_STATIC seems to be the
source of information which should be used to trigger the disconnection policy.
Correct?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

