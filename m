Return-Path: <netdev+bounces-222504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417E2B548BF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50964A00E47
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D082E0938;
	Fri, 12 Sep 2025 10:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05912DFA46
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671692; cv=none; b=JbUNay0pT8aX1h0nJitwFZ7eO28D9jseTA+aZTk6zkYbxveRdr3Ud+tkPHeSFLVjfkrnS5lq2bpOL+f2EK/dRCHDH0xjeS4hYtThjl6Oi5Xhfcl0FWNWuqfw+XNqCcTFnv2v1vvXCCBypfCqOohWvEqSNaen7tZiY/TDu1ecejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671692; c=relaxed/simple;
	bh=EF0XbL6IlnaHE2qbTDiV/IN2E9A96iQ4Th57l3axgJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsyhKgF5ovHk9wgzIQVG27+NQ118YqcIu4aeZujiahpIcOmRscnRuQKhV+vaVtWAPIxLEHSwQKS64eMOxL8nhjSx+3k3UTDBU1Vf13s6jmYYwjrBU3kMJqrkBdBuWE7HQKqEcF0mIOXyOpi5PzAE/F/rZl3lYjZYbkP3jEBuiAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ux0gz-0003Fr-F3; Fri, 12 Sep 2025 12:07:45 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ux0gw-000umm-0n;
	Fri, 12 Sep 2025 12:07:42 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ux0gw-002yar-0I;
	Fri, 12 Sep 2025 12:07:42 +0200
Date: Fri, 12 Sep 2025 12:07:42 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk <roan@protonic.nl>
Subject: Re: [PATCH net-next v5 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <aMPw7kUddvGPJCzx@pengutronix.de>
References: <20250908124610.2937939-1-o.rempel@pengutronix.de>
 <20250908124610.2937939-3-o.rempel@pengutronix.de>
 <20250911193440.1db7c6b4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911193440.1db7c6b4@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Jakub,

On Thu, Sep 11, 2025 at 07:34:40PM -0700, Jakub Kicinski wrote:
> On Mon,  8 Sep 2025 14:46:07 +0200 Oleksij Rempel wrote:
> > diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> > index 969477f50d84..d69dd3fb534b 100644
> > --- a/Documentation/netlink/specs/ethtool.yaml
> > +++ b/Documentation/netlink/specs/ethtool.yaml
> > @@ -1899,6 +1899,79 @@ attribute-sets:
> >          type: uint
> >          enum: pse-event
> >          doc: List of events reported by the PSE controller
> > +  -
> > +    name: mse-config
> > +    attr-cnt-name: --ethtool-a-mse-config-cnt
> > +    attributes:
> > +      -
> > +        name: unspec
> > +        type: unused
> > +        value: 0
> 
> Are you actually using this somewhere?
> It's good to not use attr ID 0 in case we encounter an uninitialized
> attr, but there's no need to define a name for it, usually.
> Just skip the entry 0 if you don't need then name.

No. I'll drop it.

> 
> > +      -
> > +        name: max-average-mse
> > +        type: u32
> > +      -
> > +        name: max-peak-mse
> > +        type: u32
> > +      -
> > +        name: refresh-rate-ps
> > +        type: u64
> > +      -
> > +        name: num-symbols
> > +        type: u64
> 
> type: uint for all these?

I would prefer to keep u64 for refresh-rate-ps and num-symbols.

My reasoning comes from comparing the design decisions of today's industrial
hardware to the projected needs of upcoming standards like 800 Gbit/s. This
analysis shows that future PHYs will require values that exceed the limits of a
u32.

We see two different design approaches in today's PHYs:

- The "Quick Check" Approach (e.g., KSZ9477): This PHY uses a minimal sample
  size for a very fast check, capturing ~250 symbols over 2 microseconds.

- The "Detailed Sample" Approach (e.g., KSZ9131): This PHY captures a much
larger sample for a more statistically significant analysis, capturing 125,000
symbols over 1 millisecond.

Now, let's see what happens when we apply these same design decisions to an 800
Gbit/s link.

Applying the "Quick Check" (KSZ9477) Logic:  If a future PHY designer wants to
capture the same minimal amount of symbols (250), the required refresh interval
on an 800G link would shrink to just 2.5 nanoseconds. Since future standards
will be even faster, this demonstrates why picosecond-level granularity is
necessary. In this specific minimal case, the values (250 symbols and 2,500 ps)
would still fit within a u32.

Applying the "Detailed Sample" Logic: If a designer follows the "detailed
sample" approach or needs to run common diagnostics, the numbers become too
large for a u32.

- Scenario A (High-Granularity Sample): To get a dense sample over a 100
millisecond interval, the PHY would need to process ~10 billion symbols. This
overflows the u32 for num-symbols.

- Scenario B (Long-Term Monitoring): To run a standard 10 millisecond
diagnostic, the interval measured in picoseconds is 10 billion ps. This
overflows the u32 for refresh-rate-ps.

> > +      -
> > +        name: supported-caps
> > +        type: nest
> > +        nested-attributes: bitset
> > +      -
> > +        name: pad
> > +        type: pad
> 
> you shouldn't need it if you use uint
> 
> > +  -
> > +    name: mse-snapshot
> > +    attr-cnt-name: --ethtool-a-mse-snapshot-cnt
> > +    attributes:
> > +      -
> > +        name: unspec
> > +        type: unused
> > +        value: 0
> > +      -
> > +        name: channel
> > +        type: u32
> > +        enum: phy-mse-channel
> > +      -
> > +        name: average-mse
> > +        type: u32
> > +      -
> > +        name: peak-mse
> > +        type: u32
> > +      -
> > +        name: worst-peak-mse
> > +        type: u32
> > +  -
> > +    name: mse
> > +    attr-cnt-name: --ethtool-a-mse-cnt
> > +    attributes:
> > +      -
> > +        name: unspec
> > +        type: unused
> > +        value: 0
> > +      -
> > +        name: header
> > +        type: nest
> > +        nested-attributes: header
> > +      -
> > +        name: channel
> > +        type: u32
> 
> Please annotate attrs which carry enums and flags with
> 
> 	enum: $name

Sorry, I can't follow here. What do you mean?

> 
> > +        enum: phy-mse-channel
> > +      -
> > +        name: config
> > +        type: nest
> > +        nested-attributes: mse-config
> 
> config sounds like something we'd be able to change
> Looks like this is more of a capability struct?

Yes? mse-config describes haw the measurements in the snapshot should be
interpreted.

> > +      -
> > +        name: snapshot
> > +        type: nest
> > +        multi-attr: true
> > +        nested-attributes: mse-snapshot
> 
> This multi-attr feels un-netlinky to me.
> You define an enum for IDs which are then carried inside
> snapshot.channel. In netlink IDs should be used as attribute types.
> Why not add an entry here for all snapshot types?

Can you please give me some examples here? I feel under-caffeinated, sorry.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

