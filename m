Return-Path: <netdev+bounces-156817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8768BA07E6E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920A83A8229
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D895E18A6A6;
	Thu,  9 Jan 2025 17:13:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE3918D634
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736442812; cv=none; b=oE78xgkkKnuMMeTm2v9+W57GyNFAH2vHiJOHs8HiU2yn5QJoRwV/FYl/4kdC8ehiepLNd7ume5vM5NP7kPf4wUitiHIYuC8dIVHrWnfqUw/K4G6ULOhXMvKtiKOxZqzV19P0L8yJdF6QJH9jVxkpnnRnq5xIuCrbupcSvaGB6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736442812; c=relaxed/simple;
	bh=zUFDBHh2HjfW0iDvcBHXOiwQxQyP1FpQ88kufbyz9Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1A2CDut+hw0DwWRRCmKRqBMMqcFkiBERsya3544ckyemrV3kRGRpoJaFmP3Nvln4MGwQRHOOOlHUjpS/AE4vOg3LymVFWJ4fU+BCeU84/Bqi34TtBFpozeYLR4tgh/Op8cvd6FUe8RDC2jj0N7/3U7glPhRuZZIA17/wAZsPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVw5n-0004Us-Ue; Thu, 09 Jan 2025 18:13:11 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVw5n-0001Ci-0B;
	Thu, 09 Jan 2025 18:13:11 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVw5m-0001rQ-34;
	Thu, 09 Jan 2025 18:13:10 +0100
Date: Thu, 9 Jan 2025 18:13:10 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <Z4ADpj0DlqBRUEK-@pengutronix.de>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
 <20250108121341.2689130-8-o.rempel@pengutronix.de>
 <Z35z6ZHspfSZK4U7@shell.armlinux.org.uk>
 <Z36KacKBd2WaOxfW@pengutronix.de>
 <Z36WqNGpWWkHTjUE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z36WqNGpWWkHTjUE@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Jan 08, 2025 at 03:15:52PM +0000, Russell King (Oracle) wrote:
> On Wed, Jan 08, 2025 at 03:23:37PM +0100, Oleksij Rempel wrote:
> > Yes, otherwise every MAC driver will need to do it in the
> > ethtool_set_eee() function.
> 
> I've had several solutions, and my latest patch set actually has a
> mixture of them in there (which is why I'm eager to try and find a way
> forward on this, so I can fix the patch set):
> 
> 1. the original idea to address this in Marvell platforms was to limit
>    the LPI timer to the maximum representable value in the hardware,
>    which would be 255us. This ignores that the hardware uses a 1us
>    tick rate for the timer at 1G speeds, and 10us for 100M speeds.
>    (So it limits it to 260us, even though the hardware can do 2550us
>    at 100M speed). This limit was applied by clamping the value passed
>    in from userspace without erroring out.
> 
> 2. another solution was added the mac_validate_tx_lpi() method, and
>    implementations added _in addition_ to the above, with the idea
>    of erroring out for values > 255us on Marvell hardware.
> 
> 3. another idea was to have mac_enable_tx_lpi() error out if it wasn't
>    possible to allow e.g. falling back to a software timer (see stmmac
>    comments below.) Another reason for erroring out applies to Marvell
>    hardware, where PP2 hardware supports LPI on the GMAC but not the
>    XGMAC - so it only works at speeds at or below 2.5G. However, that
>    can be handled via the lpi_capabilities, so I don't think needs to
>    be a concern.
> 
> > The other question is, should we allow absolute maximum values, or sane
> > maximum? At some point will come the question, why the EEE is even
> > enabled?
> 
> As referenced above, stmmac uses the hardware timer for LPI timeouts up
> to and including 1048575us (STMMAC_ET_MAX). Beyond that, it uses a
> normal kernel timer which is:
> 
> - disabled (and EEE mode reset) when we have a packet to transmit, or
>   EEE is disabled
> - is re-armed when cleaning up from packet transmission (although
>   it looks like we attempt to immediately enter LPI mode, and would
>   only wait for the timer if there are more packets to queue... maybe
>   this is a bug in stmmac's implementation?) or when EEE mode is first
>   enabled with a LPI timer longer than the above value.
> 
> So, should phylink have the capability to switch to a software LPI timer
> implementation when the LPI timeout value exceeds what the hardware
> supports?

No, i'll list my arguments later down.

> To put it another way, should the stmmac solution to this be
> made generic?

May be partially?

> Note that stmmac has this software timer implementation because not
> only for the reason I've given above, but also because cores other than
> GMAC4 that support LPI do not have support for the hardware timer.

There seems to be a samsung ethernet driver which implements software
based timer too.

> > The same is about minimal value, too low value will cause strong speed
> > degradation. Should we allow set insane minimum, but use sane default
> > value?
> 
> We currently allow zero, and the behaviour of that depends on the
> hardware. For example, in the last couple of days, it's been reported
> that stmmac will never enter LPI with a value of zero.
> 
> Note that phylib defaults to zero, so imposing a minimum would cause
> a read-modify-write of the EEE settings without setting the timer to
> fail.
>
> > > Should set_eee() error out?
> > 
> > Yes, please.
> 
> If we are to convert stmmac, then we need to consider what it's doing
> (as per the above) and whether that should be generic - and if it isn't
> what we want in generic code, then how do we allow drivers to do this if
> they wish.

I'll try to approach this from a user perspective. Currently, we have a single
`lpi_timer` interface for all link modes. If I start using it, I'm trying to
address a specific issue, but in most cases, I have no idea what link mode will
be active at any given time. To my knowledge, there are no user space tools
that allow users to configure different timer values for different link speeds.

So, what problems am I really trying to solve by adjusting this timer? I can
imagine the following:

1. Noticeable Speed Degradation:
 
   This happens when the timer is configured to a value smaller than the time
needed to put the hardware to sleep and wake it up again. For interfaces
supporting multiple link speeds with EEE, the most plausible configuration to
avoid degradation would be to set the timer to the maximum sleep-wake time
across all supported EEE link speeds.

2. Other Use Cases: 
 
   Most other scenarios involve trying to work around specific constraints or
optimizing for particular use cases:

   - Maximizing Power Savings: Setting the timer to the smallest possible
value to achieve aggressive power-saving. Why would a user do this? It seems
niche but might apply in low-traffic environments.

   - Reducing Latency for Periodic Traffic: For example, in audio
streaming, frames might be sent every X milliseconds. In this case, the timer
could be set slightly higher than X to allow the interface to enter LPI mode
between frames. As soon as the audio stops and no other traffic is present, the
interface transitions to LPI mode entirely. If the hardware supports timers
with values ≥ X, no additional complexity is needed. However, if the hardware
timer is not supported or the supported range is lower than X, a
software-assisted timer would be required. This might introduce additional
latency, and users should be made aware of this potential impact.
In my expectation HW timer based latency can be different to software based
timer.

From my current user perspective, I would expect the following behavior from
the existing `lpi_timer` interface:

1. Subtle Disabling of LPI Should Be Prevented: 
 
   If setting the `lpi_timer` to 0 effectively disables LPI, then this value
should not be allowed. The interface should ensure that LPI remains functional
unless explicitly turned off by the user.

2. Maximum Timer Value Should Align with Timer Implementation: 
 
   The maximum value of the `lpi_timer` should correspond to the timer
implementation in use:

   - No software and hardware timer should be mixed, otherwise it would
     affect latency behavior depending on the timer value.

   - If a hardware timer is supported but has a lower maximum range than
     required, the interface should support either:

     - Only the hardware timer within its valid range.
     - A fallback to only a software timer (if feasible for the system).  

   However, for hardware like switches, software-based LPI implementations
are not feasible.

3. Sensible Maximum Timer Values: 
 
   Setting the timer to excessively high values (e.g., one or two seconds or
more) makes the behavior unpredictable. Such configurations seem more like a
"time bomb" or a workaround for another issue that should be addressed
differently. For example:

   - If the use case requires such long timer values, it may make more sense to
disable `tx_lpi` entirely and manage power savings differently.

4. Errors for Unsupported Configurations: 
 
   If a configuration variation is not supported - whether due to hardware
constraints, a mismatch with the current link mode, or a similar limitation - the
user should receive a clear error message. EEE is already challenging to debug,
and silent failures or corner-case issues (e.g., a speed downshift from 1000
Mbps to 100 Mbps causing configuration to fail) would significantly degrade the
user experience.
   Some HW or drivers (for example dsa/microchip/ driver) do no support
LPI timer configuration. In this case the error should be returned too.

5. Separate Handling of LPI Activation:

   Some MACs support both automatic LPI activation (based on egress queue and
EEE/LPI activation bits) and forced activation for testing or software based
timers. Some PHYs, such as the Atheros AR8035, appear sensitive to premature
LPI activation, particularly during the transition from autonegotiation to an
active link. To address this:

   - The MAC driver should expose controls for managing automatic versus forced
     LPI activation where applicable. This will be needed for common software
     based timer implementation.

   - The PHYLINK API should provide separate control mechanisms for LPI
     activation and link state transitions. (done)

6. Consideration for Link-Independent Modes: 
 
   Certain EEE-related configurations can be applied without a PHY, while
others are entirely dependent on the PHY being present. The system should
differentiate between these cases and handle them as follows:

   - EEE On/Off: 
 
     Enabling or disabling EEE at the MAC level should be allowed without a
PHY. This can be treated as a user preference - "I prefer EEE to be on if
supported." If a PHY becomes available later and supports EEE, this preference
can then take effect.

   - LPI On/Off: 
 
     Similar to EEE on/off, enabling or disabling Low Power Idle (LPI) can be
managed at the MAC level independently of the PHY. This setting reflects the
MAC's ability to enter LPI mode. In SmartEEE or similar modes, this could
potentially involve PHY-specific behavior, but the basic LPI on/off setting
remains primarily MAC-specific.

   - LPI Timer:  

     The LPI timer is implementation-specific to the MAC driver and does not
inherently depend on the PHY. Yes, it depends at least on the link speed,
but this can't be addresses with existing interface.

   - EEE Advertisement:  

     Advertising EEE capabilities is entirely dependent on the PHY. Without a
PHY, these settings cannot be determined or validated, as the PHY defines the
supported capabilities. Any attempt to configure EEE advertisement without an
attached PHY should fail immediately with an appropriate error, such as:  "EEE
advertisement configuration not applied: no PHY available to validate
capabilities."

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

