Return-Path: <netdev+bounces-134066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3566E997C91
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 07:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72924B236A7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 05:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C2C19E7D0;
	Thu, 10 Oct 2024 05:42:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14AC19DF81
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 05:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728538964; cv=none; b=twFJDSmkGG1sbqe1soR9PfaPPE8NP9vtHNBtFsICszF3MOEcZ2adYaRNkaArvMcXGq5ZW/Crp7nOMUEG31VKXLWZWrMfVxLHEU9HsB5euv7WbI3xCAXSMcRPpAI6AQNRvELSQD3RiPTYLXwRCIcmRRACSh+TpsTyZJuE2CldFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728538964; c=relaxed/simple;
	bh=Hd0HjPX4rBzEf/HyP+QvJ/eLnOjFb4VNL05LZZ0LIr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvQpccagAYjxy/bHYrFXF5Q8BrEAi5PQM5Qg8hCVD7tZSEfD3gdi0a9CuD6f+86qSp2goAVnl8IpwCaPuwpOhuD2OGgFaUz0AzdEc4ph6uTHF3e2VhuaaWsSCqbu/FO7JjJba7DdrrgtHjbfoM4ArIWPQYSVCQ65FdJDObTWxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sylwR-0002Ks-FN; Thu, 10 Oct 2024 07:42:27 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sylwP-000lnx-70; Thu, 10 Oct 2024 07:42:25 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sylwP-003mPs-0M;
	Thu, 10 Oct 2024 07:42:25 +0200
Date: Thu, 10 Oct 2024 07:42:25 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Dent Project <dentproject@linuxfoundation.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH net-next 00/12] Add support for PSE port priority
Message-ID: <ZwdpQRRGst1Z0eQE@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <ZwaLDW6sKcytVhYX@p620.local.tld>
 <20241009170400.3988b2ac@kmaincent-XPS-13-7390>
 <ZwbAYyciOcjt7q3e@est-xps15>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwbAYyciOcjt7q3e@est-xps15>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hello Kyle,

On Wed, Oct 09, 2024 at 05:42:30PM +0000, Kyle Swenson wrote:
> Hello Kory,
> 
> On Wed, Oct 09, 2024 at 05:04:00PM +0200, Kory Maincent wrote:
> > Hello Kyle,
> > 
> > On Wed, 9 Oct 2024 13:54:51 +0000
> > Kyle Swenson <kyle.swenson@est.tech> wrote:
> > 
> > > Hello Kory,
> > > 
> > > On Wed, Oct 02, 2024 at 06:27:56PM +0200, Kory Maincent wrote:
> > > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > > > 
> > > > This series brings support for port priority in the PSE subsystem.
> > > > PSE controllers can set priorities to decide which ports should be
> > > > turned off in case of special events like over-current.  
> > > 
> > > First off, great work here.  I've read through the patches in the series and
> > > have a pretty good idea of what you're trying to achieve- use the PSE
> > > controller's idea of "port priority" and expose this to userspace via ethtool.
> > > 
> > > I think this is probably sufficient but I wanted to share my experience
> > > supporting a system level PSE power budget with PSE port priorities across
> > > different PSE controllers through the same userspace interface such that
> > > userspace doesn't know or care about the underlying PSE controller.
> > > 
> > > Out of the three PSE controllers I'm aware of (Microchip's PD692x0, TI's
> > > TPS2388x, and LTC's LT4266), the PD692x0 definitely has the most advanced
> > > configuration, supporting concepts like a system (well, manager) level budget
> > > and powering off lower priority ports in the event that the port power
> > > consumption is greater than the system budget.
> > > 
> > > When we experimented with this feature in our routers, we found it to be using
> > > the dynamic power consumed by a particular port- literally, the summation of
> > > port current * port voltage across all the ports.  While this behavior
> > > technically saves the system from resetting or worse, it causes a bit of a
> > > problem with lower priority ports getting powered off depending on the
> > > behavior (power consumption) of unrelated devices.  
> > > 
> > > As an example, let's say we've got 4 devices, all powered, and we're close to
> > > the power budget.  One of the devices starts consuming more power (perhaps
> > > it's modem just powered on), but not more than it's class limit.  Say this
> > > device consumes enough power to exceed the configured power budget, causing
> > > the lowest priority device to be powered off.  This is the documented and
> > > intended behavior of the PD692x0 chipset, but causes an unpleasant user
> > > experience because it's not really clear why some device was powered down all
> > > the sudden. Was it because someone unplugged it? Or because the modem on the
> > > high priority device turned on?  Or maybe that device had an overcurrent?
> > > It'd be impossible to tell, and even worse, by the time someone is able to
> > > physically look at the switch, the low priority device might be back online
> > > (perhaps the modem on the high priority device powered off).
> > > 
> > > This behavior is unique to the PD692x0- I'm much less familiar with the
> > > TPS2388x's idea of port priority but it is very different from the PD692x0.
> > > Frankly the behavior of the OSS pin is confusing and since we don't use the
> > > PSE controllers' idea of port priority, it was safe to ignore it. Finally, the
> > > LTC4266 has a "masked shutdown" ability where a predetermined set of ports are
> > > shutdown when a specific pin (MSD) is driven low.  Like the TPS2388x's OSS
> > > pin, We ignore this feature on the LTC4266.
> > > 
> > > If the end-goal here is to have a device-independent idea of "port priority" I
> > > think we need to add a level of indirection between the port priority concept
> > > and the actual PSE hardware.  The indirection would enable a system with
> > > multiple (possibly heterogeneous even) PSE chips to have a unified idea of
> > > port priority.  The way we've implemented this in our routers is by putting
> > > the PSE controllers in "semi-auto" mode, where they continually detect and
> > > classify PDs (powered device), but do not power them until instructed to do
> > > so.  The mechanism that decides to power a particular port or not (for lack
> > > of a better term, "budgeting logic") uses the available system power budget
> > > (configured from userspace), the relative port priorities (also configured
> > > from userspace) and the class of a detected PD.  The classification result is
> > > used to determine the _maximum_ power a particular PD might draw, and that is
> > > the value that is subtracted from the power budget.
> > > 
> > > Using the PD's classification and then allocating it the maximum power for
> > > that class enables a non-technical installer to plug in all the PDs at the
> > > switch, and observe if all the PDs are powered (or not).  But the important
> > > part is (unless the port priorities or power budget are changed from
> > > userspace) the devices that are powered won't change due to dynamic power
> > > consumption of the other devices.
> > > 
> > > I'm not sure what the right path is for the kernel, and I'm not sure how this
> > > would look with the regulator integration, nor am I sure what the userspace
> > > API should look like (we used sysfs, but that's probably not ideal for
> > > upstream). It's also not clear how much of the budgeting logic should be in
> > > the kernel, if any. Despite that, hopefully sharing our experience is
> > > insightful and/or helpful.  If not, feel free to ignore it.  In any case,
> > > you've got my
> > 
> > Thanks for your review and for sharing your PSE experience.
> > It indeed is insightful for further development and update of this series.
> 
> Excellent, glad to hear it.
> 
> > So you are saying that from a use experience the port priority feature is not
> > user-friendly as we don't know why a port has been shutdown.
> > Even if we can report the over-current event of which port caused it, you still
> > thinks it is not useful?
> 
> Well, not quite.  I think the concept of a "port priority" is useful,
> but I don't know that the PD692xx's concept of "port priority" is what
> we want.  The issue is the PD692xx's budgeting algorithm is based on
> dynamic power used (i.e. the total power used at any given time).  Since
> this is, well, dynamic, it makes it confusing when a lower priority port
> is powered off due to the runtime behavior of higher-priority ports.
> It's even more confusing if the implicit or default port priorities are
> used.
> 
> Instead, we found that using the maximum power that is allowed be drawn
> by a particular PD's class (set by the IEEE standard) is more user
> friendly, because the set of devices that are powered won't change
> (unless priorities are changed, or the system budget is changed).
> For example, if we've got 4 devices plugged in, and the three highest
> priority devices consume all the power budget, the lowest priority
> device won't ever be powered.  There isn't a case where the lowest
> priority device will be shut down because a higher priority device
> starts consuming more power at some point in the future.
> 
> > We could have several cases for over power budget event:
> > - The power limit exceeded is the one configured for the ports.
> >   We should shutdown only that port without taking care about priority.
> >   TPS23881 has this behavior when power exceed Pcut.
> >   I think the PD692x0 does the same. Need to verify.
> 
> These conditions I'd not call "over power budget events".  I'd call them
> "port overcurrent events" and I agree, those only affect the specific
> problem port.
> 
> > - The power limit exceeded is the global (or manager PD69208M) power budget.
> >   Here port priority is interesting.
> >   Is there a way to know which port create this global power limit excess?
> >   Should we turn off this port even if he don't exceed his own power limit or
> >   should we turn off low priority ports?
> 
> I think it's important to make a distinction between an "overcurrent"
> condition and the condition where we've exceeded the system power
> budget.  An "overcurrent" is port-specific, and can happen if the PD
> consumes more power than the classification of the device allows.  For
> example, if a Class 3 PD (i.e. 802.3at, also referred to as a Type II
> PD) consumes more than 15.4 W at the PSE, it will be shutdown
> immediately.  This support is required by all the IEEE 802.3 standards
> around PoE (.af, .at. and .bt) and is a safety thing.  The TPS2388x
> implements this with Pcut, the LTC4266 impliments this with Icut
> register, and the PD692xx implements it with the port power limit
> registers.  
> 
> The condition where we've exceeded our system-level power
> budget is a little different, in that it causes a port to be shutdown
> despite that port not exceeding it's class power limit.  This condition
> is the case I'm concerned we're solving in this series, and solving it
> for the PD692xx case only, and it's based off dynamic power consumption.
> 
> So I guess I'm suggesting that we take the power budgeting concept out
> of the PSE drivers, and put it into software (either kernel, userspace)
> instead of the PSE hardware.  
> 
> >   I can't find global power budget concept for the TPS23881. 
> 
> This is because this idea doesn't exist on the TPS2388x.  
> 
> >   I could't test this case because I don't have enough load. In fact, maybe by
> >   setting the PD692x0 power bank limit low it could work.
> 
> Hopefully this helps clarify.


Thank you for your detailed insights. Before we dive deeper into policies and
implementations, I’d like to clarify an important point to avoid confusion
later. When comparing different PSE components, it's crucial to note that the
Microchip PD692x0 operates in two distinct categories:
1. PoE controller (PD692x0)
2. PoE manager (PD6920x)

Comparing the PoE controller (PD692x0) with TPS2388x or LTC4266 isn't entirely
fair, as TPS2388x and LTC4266 are more comparable to the PoE manager (PD6920x).
The functionalities provided by the PoE controller (PD692x0) are things we
would need to implement ourselves on the software stack (kernel or userspace).
The budget heuristic that is implemented in the PD692x0's firmware is absent in
TPS2388x and LTC4266.

Policy Variants and Implementation

In cases where we are discussing prioritization, we are fundamentally talking
about over-provisioning. This typically means that while a device advertises a
certain maximum per-port power capacity (e.g., 95W), the total system power
budget (e.g., 300W) is insufficient to supply maximum power to all ports
simultaneously. This is often due to various system limitations, and if there
were no power limits, prioritization wouldn't be necessary.

The challenge then becomes how to squeeze more Powered Devices (PDs) onto one
PSE system. Here are two methods for over-provisioning:

1. Static Method:
 
   This method involves distributing power based on PD classification. It’s
   straightforward and stable, with the software (probably within the PSE
   framework) keeping track of the budget and subtracting the power requested by
   each PD’s class. 
 
   Advantages: Every PD gets its promised power at any time, which guarantees
   reliability. 

   Disadvantages: PD classification steps are large, meaning devices request
   much more power than they actually need. As a result, the power supply may
   only operate at, say, 50% capacity, which is inefficient and wastes money.

2. Dynamic Method:  

   To address the inefficiencies of the static method, vendors like Microchip
   have introduced dynamic power budgeting, as seen in the PD692x0 firmware.
   This method monitors the current consumption per port and subtracts it from
   the available power budget. When the budget is exceeded, lower-priority
   ports are shut down.  

   Advantages: This method optimizes resource utilization, saving costs.

   Disadvantages: Low-priority devices may experience instability. A possible
   improvement could involve using LLDP protocols to dynamically configure
   power limits per port, thus allowing us to reduce power on over-consuming
   ports rather than shutting them down entirely.

Recommendations for Software Handling

Both methods have their pros and cons. Since the dynamic method is not always
desirable, and if there's no way to disable it in the PD692x0's firmware, one
potential workaround could be handling the budget in software and dynamically
setting per-port limits. For instance, with a total budget of 300W and unused
ports, we could initially set 95W limits per port. As high-priority PDs (e.g.,
three 95W devices) are powered, we could dynamically reduce the power limit on
the remaining ports to 15W, ensuring that no device exceeds that classification
threshold.

This is just one idea, and there are likely other policy variants we could
explore. Importantly, I believe these heuristics don’t belong in the kernel
itself. Instead, the kernel should simply provide the necessary interfaces,
leaving the policy implementation to userspace management software. At least
this is a lesson learned from Thermal Management talk at LPC :D

Best regards,  
Oleksij

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

