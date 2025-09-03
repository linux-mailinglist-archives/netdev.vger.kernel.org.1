Return-Path: <netdev+bounces-219531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAFEB41C7F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D38C165CB4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFCE2F2900;
	Wed,  3 Sep 2025 11:00:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67C1B3935
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897200; cv=none; b=bOfspR0z/LY/e5ItogPAcgogDQ3y+lXRA+6NUCT0ZAxxs22Lup/N+ZSJYaGHUHncjxWz1GKQbEytlSR4qcTz6QQJwXr8FAtrovaVsU632HoThw22F+SoaKH/DmLCv7tsSCSvRwFl6Ouz0aI1AF3K4HkjNAEx0/ctVACn4mTPtb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897200; c=relaxed/simple;
	bh=pPBDxptN+pKBfE0OGyGISwGzXBA8VZHPd80i8goHzGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9lwseulfQB8rJW/EJ1U+skyjYCuxrZeC/ybuWML700hOnVknb57SekznJ0UE8xnhFw8zdLYmA761zPM1wNQvSo/oWmgIdZl5vDnzrLKRst0QM9oWtWf1s4MJMJxxsVm141HUtikN2BIDM7vch9qUnERtpd61kIVcFStZR1uMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1utlDO-0005zA-2Z; Wed, 03 Sep 2025 12:59:46 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1utlDK-003Xsx-0i;
	Wed, 03 Sep 2025 12:59:42 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1utlDK-00HZBt-0I;
	Wed, 03 Sep 2025 12:59:42 +0200
Date: Wed, 3 Sep 2025 12:59:42 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	Dent Project <dentproject@linuxfoundation.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next v2 4/4] net: pse-pd: pd692x0: Add devlink
 interface for configuration save/reset
Message-ID: <aLgfnia_ZlclCrdy@pengutronix.de>
References: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
 <20250829-feature_poe_permanent_conf-v2-4-8bb6f073ec23@bootlin.com>
 <20250901133100.3108c817@kernel.org>
 <20250902164314.12ce43b4@kmaincent-XPS-13-7390>
 <20250902134212.4ceb5bc3@kernel.org>
 <20250902134844.7e3593b9@kernel.org>
 <aLfp5H5CTa24wA7H@pengutronix.de>
 <20250903111025.4642efb7@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903111025.4642efb7@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Sep 03, 2025 at 11:10:25AM +0200, Kory Maincent wrote:
> On Wed, 3 Sep 2025 09:10:28 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Tue, Sep 02, 2025 at 01:48:44PM -0700, Jakub Kicinski wrote:
> > > On Tue, 2 Sep 2025 13:42:12 -0700 Jakub Kicinski wrote:  
> > > > On Tue, 2 Sep 2025 16:43:14 +0200 Kory Maincent wrote:  
> > > > > > Sorry for not offering a clear alternative, but I'm not aware of any
> > > > > > precedent for treating devlink params as action triggers. devlink
> > > > > > params should be values that can be set and read, which is clearly not
> > > > > > the case here:      
> > > > > 
> > > > > Ok.
> > > > > We could save the configuration for every config change and add a
> > > > > reset-conf action to devlink reload uAPI? The drawback it that it will
> > > > > bring a bit of latency (about 110ms) for every config change.
> > > > > 
> > > > > Or adding a new devlink uAPI like a devlink conf but maybe we don't
> > > > > have enough cases to add such generic new uAPI.
> > > > > Or get back to the first proposition to use sysfs. 
> > > > > 
> > > > > What do you think?    
> > > > 
> > > > If you are asking for my real preference, abstracting away whether it's
> > > > doable and justifiable amount of effort for you -- I'd explore using
> > > > flags in the ethtool header to control whether setting is written to
> > > > the flash.  
> > > 
> > > PS. failing that the less uAPI the better. Tho, given that the whole
> > > point here is giving user the ability to write the flash -- asking for
> > > uAPI-light approach feels contradictory.
> > > 
> > > Taking a step back -- the "save to flash" is something that OEM FW
> > > often supports. But for Linux-based control the "save to flash" should
> > > really be equivalent to updating some user space config. When user
> > > configures interfaces in OpenWRT we're not flashing them into the
> > > device tree... Could you perhaps explain what makes updating the
> > > in-flash config a high-priority requirement for PoE?
> > >   
> > 
> > I think the main use case question is: what happens if the application
> > CPU reboots?
> > Do we go back to “safe defaults”? But what are safe defaults - that can
> > vary a lot between systems.
> 
> In case of CPU reboot, the port matrix will be flashed, which means the
> controller is restarted and the ports get disconnected.
> Therefore indeed we will go back to default settings.
>  
> > In many setups, if the CPU reboots it also means the bridge is down, so
> > there is no packet forwarding. In that case, does it even make sense to
> > keep providing PoE power if the networking part is non-functional?
> 
> It depends, we might not want to reboot the Powered Devices if the switch
> reboot. I don't currently have specific case in mind which could need this
> behavior.
> Mainly, the Dent Project final aim was to support mainline all the features
> supported in their poed tool.
> https://github.com/dentproject/poed/blob/main/dentos-poe-agent/opt/poeagent/docs/Userguide
> 
> > Another angle: does it make sense to overwrite the hardware power-on
> > defaults each time the system starts? Or should we rather be able to
> > read back the stored defaults from the hardware into the driver and work
> > with them?
> 
> Yes that is one of the design proposition, but we will still need a way to
> reset the conf as said before.
> 
> > Does anyone here have field experience with similar devices? How are
> > these topics usually handled outside of my bubble?
> 
> Kyle any field experience on this?

I can confirm a field case from industrial/medical gear. Closed system,
several modules on SPE, PoDL for power. Requirement: power the PDs as
early as possible, even before Linux. The box boots faster if power-up
and Linux init run in parallel. In this setup the power-on state is
pre-designed by the product team and should not be changed by Linux at
runtime.

So the question is how to communicate and control this:

Option A - Vendor tool writes a fixed config to NVM (EEPROM)
Pro: matches "pre-designed, don't touch" model; PDs come up early
without Linux.
Con: needs extra vendor tooling; hard to keep in sync with what
userspace shows; Linux may not know what is in NVM unless we
read/reflect it.

Option B - Do all changes in RAM, then one explicit "commit to NVM"
Pro: one write; predictable latency hit only on commit; maps to a
"transaction/commit" model.
Con: what if the controller discarded some changes during the session?
We would need a clear commit status and a way to report which settings
actually stuck.

Option C - Write-through: every change also goes to NVM
Pro: if the system resets, config is always up to date.
Con: adds about 50-110 ms per change on this hardware; may be too slow
for interactive tools or batch reconfig.

From API side, if write-through is possible on this hardware, we can
likely make this per-port and per-setting:

ethtool per-port setters can take a "persist=1" flag. Driver applies the
change and also writes it to NVM for that port.

If a particular setting (bit/field) cannot be persisted by the
controller/NVM, the driver returns an error for the whole request. Userspace
then knows persistence is not supported for that item.

Factory reset:
If hardware supports per-port defaults in NVM, provide a per-port
factory_reset op.

Do PD692x0 supports per-port save/restore functionality?

Regards,
Oleksij

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

