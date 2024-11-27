Return-Path: <netdev+bounces-147576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451B99DA4C7
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 10:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047D9283013
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 09:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B07018E373;
	Wed, 27 Nov 2024 09:31:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49113A888
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699865; cv=none; b=NfJOyvqz7dXBWwHEJgUEOxx4Zu/gNq842ps58eQ0kzCMn1puGXe6Ai1C0rgi+E558sx/y0idt8tEkles7LByo2d+hPA/ZZm51yK/ypfMXnF/pwG5PcwEDvbaY9koBi13osPntlyjT1yyADPZ4XKvthvaCwQ/ICuygV0Bvz5hZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699865; c=relaxed/simple;
	bh=Z+FSG9DKa1spc5aFD37+CLnskVpJIstqdHvbrjcIuN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFNDkp/4E7qWJfNmt8orZ0ds5eXUYK8zDkwBVVDmv4ED5VTVjea4WIBT1ma4sPz5NXrlse77IGumsG924UGiYR56hMFb+h7S794Ms3Ok4Q/+UGmN43UxPKbi3kLGZP++S83wgh/3l40XYMR56YjnpdBDvXEok69ek36vr1orhQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tGENi-0002ks-7y; Wed, 27 Nov 2024 10:30:46 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGENe-000Ozh-2i;
	Wed, 27 Nov 2024 10:30:43 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGENf-000ulL-1a;
	Wed, 27 Nov 2024 10:30:43 +0100
Date: Wed, 27 Nov 2024 10:30:43 +0100
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
Subject: Re: [PATCH RFC net-next v3 21/27] net: pse-pd: Add support for
 getting and setting port priority
Message-ID: <Z0bmw3wVCqWZZzXY@pengutronix.de>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
 <20241121-feature_poe_port_prio-v3-21-83299fa6967c@bootlin.com>
 <Z0WJAzkgq4Qr-xLU@pengutronix.de>
 <20241126163155.4b7a444f@kmaincent-XPS-13-7390>
 <20241126165228.4b113abb@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126165228.4b113abb@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Nov 26, 2024 at 04:52:28PM +0100, Kory Maincent wrote:
> On Tue, 26 Nov 2024 16:31:55 +0100
> Kory Maincent <kory.maincent@bootlin.com> wrote:
> 
> > Hello Oleksij,
> > 
> > Thanks for your quick reviews!
> > 
> > On Tue, 26 Nov 2024 09:38:27 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > 
> > > > +int pse_ethtool_set_prio_mode(struct pse_control *psec,
> > > > +			      struct netlink_ext_ack *extack,
> > > > +			      u32 prio_mode)
> > > > +{
> > > > +	struct pse_controller_dev *pcdev = psec->pcdev;
> > > > +	const struct pse_controller_ops *ops;
> > > > +	int ret = 0, i;
> > > > +
> > > > +	if (!(prio_mode & pcdev->port_prio_supp_modes)) {
> > > > +		NL_SET_ERR_MSG(extack, "priority mode not supported");
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > > +
> > > > +	if (!pcdev->pi[psec->id].pw_d) {
> > > > +		NL_SET_ERR_MSG(extack, "no power domain attached");
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > > +
> > > > +	/* ETHTOOL_PSE_PORT_PRIO_DISABLED can't be ORed with another mode
> > > > */
> > > > +	if (prio_mode & ETHTOOL_PSE_PORT_PRIO_DISABLED &&
> > > > +	    prio_mode & ~ETHTOOL_PSE_PORT_PRIO_DISABLED) {
> > > > +		NL_SET_ERR_MSG(extack,
> > > > +			       "port priority can't be enabled and
> > > > disabled simultaneously");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	ops = psec->pcdev->ops;
> > > > +
> > > > +	/* We don't want priority mode change in the middle of an
> > > > +	 * enable/disable call
> > > > +	 */
> > > > +	mutex_lock(&pcdev->lock);
> > > > +	pcdev->pi[psec->id].pw_d->port_prio_mode = prio_mode;    
> > > 
> > > In proposed implementation we have can set policies per port, but it
> > > will affect complete domain. This is not good. It feels like a separate
> > > challenge with extra discussion and work. I would recommend not to
> > > implement policy setting right now.
> > > 
> > > If you will decide to implement setting of policies anyway, then we need
> > > to discuss the interface.
> > > - If the policy should be done per domain, then we will need a separate
> > >   interface to interact with domains.
> > >   Pro: seems to be easier to implement.
> > > - If we will go with policy per port, wich would make sense too, then
> > >   some rework of this patch is needed.
> > >   Pro: can combine best of both strategies: set ports with wide load
> > >   range to static strategy and use dynamic strategy on other ports.
> 
> We already talked about it but a policies per port seems irrelevant to me.
> https://lore.kernel.org/netdev/ZySR75i3BEzNbjnv@pengutronix.de/
> How do we compare the priority value of ports that use different budget
> strategy? How do we manage in the same power domain two ports with
> different budget strategies or disconnection policies?

Good question :)

> We indeed may need a separate interface to configure the PSE power domain
> budget strategies and disconnection policies.

And a way to upload everything in atomic way, but I see it as
optimization and can be done separately

> I think not being able to set the budget evaluation strategy is not relevant
> for now as we don't have PSE which could support both,

Both can be implemented for TI. By constantly polling the channel
current register, it should be possible to implement dynamic strategy.

> but being able to set the disconnection policies may be relevant.
> If we don't add this support to this series how do we decide which is the
> default disconnection policy supported?

Use hard coded one ¯\_(ツ)_/¯

Anyway, assuming you will decide to implement everything per port. Here
how I assume it would work.

Budget Evaluation Strategy: We have following modes for now: disabled, static, and
dynamic.
- Disabled: In this mode, the port is excluded from active budget evaluation. It
  allows the port to violate the budget and is intended primarily for testing
  purposes.

- Static: The static method is the safest option and should be used by default.
  When the static method is enabled for a port, the classification information
  (such as power class) is used for budget evaluation.

- Dynamic: If the dynamic method is used, the software will start with the
  classification as an initial step. After that, it will begin monitoring the
  port by polling the current information for the related channel. The system
  will likely use the maximum detected current and a threshold to update or
  reduce the budget allocation for the related port.

Right now I'm not sure about manual mode - for the case where classification
is not working properly.

Disconnection Policy: can only be applied if the Budget Evaluation Strategy
is not disabled.

- Disabled: The port is not subject to disconnection under any circumstances.
  This can be used for critical devices that need to remain powered at all
  times, or for administrative purposes to avoid unexpected disconnections.
  Possible use cases include testing, allowing user space to implement a
  disconnection policy, or pinning certain ports as the highest priority that
  cannot be overwritten for critical devices. Another use case could be
  temporarily addressing misconfigured priorities: an admin could set the
  policy to disabled, adjust the priority, and use a disconnection policy
  resolution status interface (currently not implemented) to verify if the
  port would be disconnected with the updated priority settings, and then set
  the policy back to a non-disabled state.

- Port Index-Based Policy: "I Know What I Do, but I Do Not Have Permission to
  Configure Software"

  Behavior: With this approach, the port index becomes the way to determine the
  priority of connections. Users can manage priorities simply by deciding which
  port they plug into:

    Lower-Indexed Ports: These ports have higher priority, meaning devices
    plugged into these ports are protected from disconnection until absolutely
    necessary.  Higher-Indexed Ports: These ports are more likely to be
    disconnected first when a power budget violation occurs.

    Use Cases:
	Structured Environment Without Full Control: Ideal for situations where
        users understand the importance of the devices but do not have admin
        access to configure software settings.

        Mechanical Administration: Users can simply re-plug devices into
        different ports to change their priority, using the port layout itself
        as a mechanism for priority management. This allows an effective but
        simple way of reassigning criticality without touching the software
        layer.

- LRC-Based Policy: "I Have No Idea About the Architecture, and I Just Enabled
  This One Device"

    Behavior: In this case, the policy targets recent user actions, assuming
    the user has minimal context about the system's architecture. The most
    recently connected device is likely the least critical and is therefore
    disconnected first.

    Use Cases:
        Chaotic Environment: Suitable for environments where users do not
        know the priority structure and are randomly plugging in devices,
        often without understanding the power budget implications.

        Immediate Feedback: If a user connects a device and it is quickly
        disconnected, they are more likely to notice and either try connecting
        at a different time or consult someone for guidance.

- Round-Robin (RR) Policy: "I Do Not Care, but I Want You All to Suffer Equally"

    Behavior: In the Round-Robin policy, all ports are treated equally without
    any specific prioritization. The disconnection burden is distributed evenly
    among all eligible ports, ensuring that no specific port is repeatedly
    penalized. This policy ensures fairness by giving every port an equal
    chance of being disconnected.

    Use Cases:
        Fair Distribution in Shared Environments: Suitable for environments
        where all devices are of similar importance, and fairness is key. This
        ensures that no single user or device consistently bears the impact of
        a budget violation.

	Non-Critical Setup: Ideal for situations where there are no critical
        devices, and all ports should have an equal chance of being
        disconnected. It provides a simple and fair mechanism for managing
        power resources without requiring specific prioritization.

Regarding the mixing of disconnection policies within one power domain, I've
thought more about how we could implement this, particularly when we focus on
three primary types of policies: Least Recently Connected (LRC), Port
Index-Based (Index), and Round-Robin (RR).

Defined Priority Order:

To make the system straightforward and predictable, we could define a hard
execution priority order for these policies:

- LRC - Highest priority: If a port has LRC enabled, it will be considered for
  disconnection first. This ensures that the least recently connected device is
  always targeted first, which works well for devices that are likely temporary
  or less critical.

- Index-Based - Second priority: Once no more LRC ports are eligible for
  disconnection, the system evaluates Index-Based ports. Ports with a higher
  physical index will be prioritized for disconnection, allowing for some manual
  control by re-arranging device connections.

- Round-Robin (RR) - Lowest priority: Finally, Round-Robin is applied to ensure
  fairness among the remaining eligible ports. This policy cycles through the
  ports to distribute the disconnection burden evenly.

User Configuration

In terms of user configuration:

Users only need to set the top allowed priority for each port. For example, if
a port is set to LRC, it will always be considered first for disconnection
during a budget violation. The connection order of all LRC ports should be
preserved.

If a port is set to Index, it will be preserved until all LRC ports are
disconnected.

Setting a port to RR will make it the last in line for disconnection, thus
ensuring the fairest distribution when other more prioritized policies have
already been applied. However, in practice, it may never be executed if all
ports have higher priority policies.


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

