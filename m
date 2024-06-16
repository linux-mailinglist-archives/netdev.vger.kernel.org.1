Return-Path: <netdev+bounces-103829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33A0909BC4
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 08:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588DE283067
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 06:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D09916D9A1;
	Sun, 16 Jun 2024 06:07:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D519535C4
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718518058; cv=none; b=bvT5RprAWVilwsu5h5mjs5AkXIc6KBEYe271BxmiffCwMN046CyZDXW/+DVS8zbdWRFOeFryany3hCPI+XxB6PuOE3Tc6ku/i+wjauyWRHjpZbXgZ4mz2AAe7M7oShWrUZ2P91NGk2GfRhN97yDX0VtrzecAp/7z/TP+WgLPmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718518058; c=relaxed/simple;
	bh=ZOaUURSedLapqy2s8nwqiwJKvSVsYpd9QKxBufVJBX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruQAJTbQWCA3GyLOBax7MP86SNooUtr/S4ejNcPRClrDWeDDAfEFzkfUREeoJwSAws7a/M/OC+I4hwwRs31jlqQtwlRA3sqzoXdNWJyg/TdXDexM/dV8xu4y5FOVr7ApDj9euXhVSoeeeri7QKfPPFD0NxsJfzNUTaqxsAYd7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sIj2x-0000jq-5u; Sun, 16 Jun 2024 08:07:23 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sIj2u-002flU-P8; Sun, 16 Jun 2024 08:07:20 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sIj2u-00E95Z-2B;
	Sun, 16 Jun 2024 08:07:20 +0200
Date: Sun, 16 Jun 2024 08:07:20 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next v3 5/7] net: ethtool: Add new power limit get
 and set features
Message-ID: <Zm6BGJxu4bLVszFD@pengutronix.de>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
 <20240614-feature_poe_power_cap-v3-5-a26784e78311@bootlin.com>
 <Zm26aJaz7Z7LAXNT@pengutronix.de>
 <Zm3dTuXuVEF9MhDS@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zm3dTuXuVEF9MhDS@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sat, Jun 15, 2024 at 08:28:30PM +0200, Oleksij Rempel wrote:
> > > diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> > > index 7dbf2ef3ac0e..a78b6aea84af 100644
> > > --- a/Documentation/networking/ethtool-netlink.rst
> > > +++ b/Documentation/networking/ethtool-netlink.rst
> > > @@ -1737,6 +1737,7 @@ Kernel response contents:
> > >                                                    PoE PSE.
> > >    ``ETHTOOL_A_C33_PSE_EXT_SUBSTATE``         u32  power extended substatus of
> > >                                                    the PoE PSE.
> > > +  ``ETHTOOL_A_C33_PSE_PW_LIMIT``             u32  power limit of the PoE PSE.
> > >    ======================================  ======  =============================
> > >  
> > >  When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_STATE`` attribute identifies
> > > @@ -1799,6 +1800,9 @@ Possible values are:
> > >  		  ethtool_c33_pse_ext_substate_power_not_available
> > >  		  ethtool_c33_pse_ext_substate_short_detected
> > >  
> > > +When set, the optional ``ETHTOOL_A_C33_PSE_PW_LIMIT`` attribute identifies
> > > +the C33 PSE power limit in mW.

Except of current value, we need an interface to return list of supported
ranges. For example a controller with flexible configuration will have
one entry 

Proposed interface may look like this:

  ``ETHTOOL_A_C33_PSE_AVAIL_PWR_VAL_LIMIT``  u32  Get PoE PSE currently configured power value limit
  ``ETHTOOL_A_C33_PSE_PWR_LIMIT_RANGES``     nested  Supported power limit configuration ranges  
  ======================================  ======  =============================

 +------------------------------------------+--------+----------------------------+
 | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_RANGES``   | nested | array of power limit ranges|
 +-+----------------------------------------+--------+----------------------------+
 | | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_RANGE_ENTRY`` | nested | one power limit range  |
 +-+-+--------------------------------------+--------+----------------------------+
 | | | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_MIN``  | u32    | minimum power value (mW)   |
 +-+-+--------------------------------------+--------+----------------------------+
 | | | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_MAX``  | u32    | maximum power value (mW)   |
 +-+-+--------------------------------------+--------+----------------------------+

The min/max values should provide ranges actually configurable by PSE controller.
If controller works with fixed classes, the min and max values will be equal.

The ethtool output may look like this:

$ ethtool --get-pse eth0

Power Information for eth0:
=====================================
Current Power Limit: 15000 mW
Current Power Consumption: 12000 mW

Supported Power Limit Ranges:
  - Range 1: 0 - 7500 mW
  - Range 2: 7501 - 15000 mW
  - Range 3: 15001 - 30000 mW

Port Power Priority: 3
Supported Priority Range: 1 - 5

Pairs in Use: 4
Pair Configuration Type: Alternative A (MDI-X) and Alternative B(S)
PSE Type: Type 4
Detected PD Class: Class 5 (40000 mW max)

Low-Level Classification:
  - Classification Type: Autodetected
  - Configured PD Class: Class 5 (40000 mW max)

Maintain Power Signature (MPS) State: Present


> > > +
> > >  PSE_SET
> > >  =======
> > >  
> > > @@ -1810,6 +1814,7 @@ Request contents:
> > >    ``ETHTOOL_A_PSE_HEADER``                nested  request header
> > >    ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL``       u32  Control PoDL PSE Admin state
> > >    ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``        u32  Control PSE Admin state
> > > +  ``ETHTOOL_A_C33_PSE_PW_LIMIT``             u32  Control PoE PSE power limit
> > >    ======================================  ======  =============================
> > >  
> > >  When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is used
> > > @@ -1820,6 +1825,9 @@ to control PoDL PSE Admin functions. This option is implementing
> > >  The same goes for ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL`` implementing
> > >  ``IEEE 802.3-2022`` 30.9.1.2.1 acPSEAdminControl.
> > >  
> > > +When set, the optional ``ETHTOOL_A_C33_PSE_PW_LIMIT`` attribute is used
> > > +to control C33 PSE power limit in mW.
> > 
> > 
> > The corresponding name int the IEEE 802.3-2022 seems to be pse_avail_pwr
> > in 145.2.5.4 Variables and pse_available_power in 33.2.4.4 Variables.
> > 
> > This variable is using classes instead of mW. pd692x0 seems to use
> > classes instead of mW too. May be it is better to use classes for UAPI
> > too? 
> 
> Huh... i took some more time to investigate it. Looks like there is no
> simple answer. Some devices seems to write power class on the box. Other
> client devices write power consumption in watts. IEEE 802.3-2022
> provides LLDP specification with PowerValue for watts and PowerClass for
> classes. Different product user interfaces provide class and/or watts.
> So, let's go with watts then. Please update the name to something like
> pse_available_power_value or pse_available_power_value_limit and
> document how it is related to State diagrams in the IEEE spec.

Here is proposal for documentation:

  ``ETHTOOL_A_C33_PSE_AVAIL_PWR_VAL_LIMIT``  u32  Control PoE PSE available power value limit

When set, the optional ``ETHTOOL_A_C33_PSE_AVAIL_PWR_VAL_LIMIT`` attribute is
used  to control the available power value limit for C33 PSE in milliwatts.
This attribute corresponds  to the `pse_available_power` variable described in
``IEEE 802.3-2022`` 33.2.4.4 Variables  and `pse_avail_pwr` in 145.2.5.4
Variables, which are described in power classes. 

It was decided to use milliwatts for this interface to unify it with other
power monitoring interfaces, which also use milliwatts, and to align with
various existing products that document power consumption in watts rather than
classes. If power limit configuration based on classes is needed, the
conversion can be done in user space, for example by ethtool.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

