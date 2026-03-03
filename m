Return-Path: <netdev+bounces-263365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBINBm4pp2nSfAAAu9opvQ
	(envelope-from <netdev+bounces-263365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:33:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1211F5594
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAA85302927A
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3656436CE0B;
	Tue,  3 Mar 2026 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BXM3BeSK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2363537FE;
	Tue,  3 Mar 2026 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562790; cv=none; b=QxHSmH51zkyU/MyBs1bC0COI/A3K1mytI4zCVQq+LQq+V+0wKKUlFPyQJ8qlqLkd2r+NsyLJ2r+Ia4rx+FXjfJpUJayLAoDAm0glg+w+t4qZHEk/CV7QyzTJWKUxLaiGMxDTwy4rxJlEWPjwbmiA2AXohprCMphX70MCZplsPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562790; c=relaxed/simple;
	bh=SlrQmIWPXISQwLLnfg2z3fhCI4oY4j5UhgPu/McQR/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHWSloPVYyEsyAZ7RSiWPTYQRED+5zHgEkQu1pKDr1l0d1nBpL0W9uREIGghlkLuOh1v7LoGW0PZ5JLsQr8qWaBZ0i0szl2Zn8r4zCAkBKc33A1q6lN85Pw7UlUOssY6Iv/s5SLwPl9KyUmSbLO/xDdqC5SUbr/RRkJgXFl2cV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BXM3BeSK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=crr9vRhed4VYA3LgqIRZBEl2pJuXbw/ImKhphen09wc=; b=BXM3BeSKTVHvjSsvVpunSa8h1z
	tQ8un+F+dqsGwleBnASS0zw4HIrUwMgH4G1FYVx8+Vr6FtipqvhLpfCZhi2vsQyKjHo2PctOKwYP5
	VtCfQCbkY+FxNy7cSRAn0GHeGYRqjtCTwXNRS1bM7EFQxMH+f/fNOSXGkCjZRJLEHXeZX2G97Hc7h
	Ka4m5u+oYbHFNmtqlPxyCtTxlhxATg/kdd+SZq91XxUBy9ZiN3qqw+P1SNDkcbQbYDKEw6RTzlaSh
	fQ/UZdNTvxinPoK2LMyJdx82QHURGP7gj9BL3RRcyOyWsxX7/r8veTwbd6lquoA4Ry3wbLrh1Ltq4
	De8otqiQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42714)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vxUYB-000000005UK-0OIf;
	Tue, 03 Mar 2026 18:32:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vxUY8-0000000078x-1Sf8;
	Tue, 03 Mar 2026 18:32:52 +0000
Date: Tue, 3 Mar 2026 18:32:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: sfp: manage receiver and transmitter
 regulators
Message-ID: <aacpVFhH8eV7dxHV@shell.armlinux.org.uk>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <20260303-sfp-regulators-v1-2-7101ae34cb84@bootlin.com>
 <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
 <aab6Tqo1z-8YQ4j6@shell.armlinux.org.uk>
 <536e57fe-9738-4026-a9c9-fdb7135cbe2f@sirena.org.uk>
 <aab9bwKSubR6zxKG@shell.armlinux.org.uk>
 <1dbc679e-ad6d-49c5-86bd-3b319b899584@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dbc679e-ad6d-49c5-86bd-3b319b899584@sirena.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: 6D1211F5594
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263365-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.236];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,armlinux.org.uk:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 05:31:36PM +0000, Mark Brown wrote:
> On Tue, Mar 03, 2026 at 03:25:35PM +0000, Russell King (Oracle) wrote:
> > On Tue, Mar 03, 2026 at 03:14:02PM +0000, Mark Brown wrote:
> 
> > > Sorry, what's the breakage here?  The log messages, or something else?
> 
> > ... which then caused someone to "fix" DT by disabling devices to shut
> > up those log messages, including for platforms where those devices were
> > being used, which ultimately caused a boot failure.
> 
> > ... and your argument that SATA PHYs need these supplies, which is false
> > when the SATA PHY is integrated into the SoC and there's no details on
> > what those supplies are or where they come from, or even if they are
> > controllable.
> 
> The supplies don't need to be controllable or have any other information
> to be specified, it sounds like this hardware has a fixed voltage
> regulator that's supplying the PHY which is representable without any
> changes, though I do agree it's annoying.
> 
> Though having said that with your description above I'm really not clear
> that the regulator support is in the right place in the SATA framework
> at all, it sounds like the supplies are being requested by the SATA
> controller but the expectation is that the SATA controller is the thing
> that is supplying power rather than consuming it.  I think that's where
> things are going wrong here?  There are some SATA implementations that
> don't include the power delivery part of SATA and only those require the
> supplies?  The logs you posted looked like it was controllers requesting
> the supplies which does look like the bindings and associated requests
> aren't what I'd expect for something describing the hardware.

The setup here as far as can be derived from the SoC documentation is:


----------------------------------------------------------+ External
 SoC +--------------------------------+                   | World
     |             .---- SATA port 0 --- COMPHY SerDes <-----> port 2
<-bus-> AHCI SATA controller          |                   |
     |             ^---- SATA port 1 --- COMPHY SerDes <-----> port 1
     +--------------------------------+                   |
----------------------------------------------------------+

The COMPHY SerDes is a multi-protocol SerDes, which supports PCIe, SATA,
and Ethernet, and is driven optionally by firmware via the generic PHY
driver. This is entirely separate from the SATA ports in the AHCI
controller. The external world are the two pairs of data pin
connections to the SATA drive per port. Nothing more - no power pins.

Drive power is up to the user. In my case, I've plugged in a 12V ATX
format power module that provides the +12V and +5V through normal PC
style wiring to the drives - none of that has any business being
described in DT because it's out of scope of the board itself.

The AHCI SATA controller and COMPHY are integrated into the SoC.
Internally, these components would be provided power by the internal
SoC design.

So, let's go through the supplies for the AHCI controller. The binding
documentation states:

  ahci-supply:
    description: Power regulator for AHCI controller

First, this is not listed as a required property. In this case, the
AHCI controller is internal to the SoC, and no details are given in
the documentation what that supply is, where it is derived from, or
whether it's controllable.

  target-supply:
    description: Power regulator for SATA target device

The board does not provide power to the target device, that is derived
off-board and completely up to the user. Thus, this can't be specified.

  phy-supply:
    description: Power regulator for SATA PHY

The PHY is an entirely separate device (the COMPHY) from the AHCI
controller. Thus, specifying a PHY supply for this AHCI hardware is
not relevant at the AHCI controller layer. Sure, other AHCI designs
where the PHY is not generic may require a separate PHY supply which
may be controllable, but here is one example where this just isn't
relevant.

So, as a result of commit 962399bb7fbf ("ata: libahci_platform: Fix
regulator_get_optional() misuse") we have now ended up with kernel
boots issuing messages at warning severity (which means something is
wrong and requires attention) for supplies that are not relevant to
this SoC hardware design.

The side effect of that commit was commit 30023876aef4 ("arm64: dts:
marvell: only enable complete sata nodes") which disabled the ports
to shut up these warning messages, but the hunk for
arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi was incomplete,
only enabling one SATA port, despite the board having three SATA
ports. This caused boot failure as SATA drives that were previously
accessible became inaccessible due to the SATA ports missing until
I fixed that in 2aeadea47f5b ("ARM64: dts: mcbin: fix SATA ports on
Macchiatobin").

We're now left with the annoying warning messages that - as I've
stated above - are certainly in one case just not relevant to the
SoC design.

> For SFP my understanding is that SFP has a physical specification which
> includes power inputs and that these supplies are being requested by the
> devices that consume them.  If some part of that is not the case then it
> sounds like the bindings aren't describing the hardware (or at least are
> a bit unclear about how they're doing so) and should be revised.  The
> series doesn't seem to do anything at all with the supply side either,
> I'm guessing there are some SFP controllers with integrated power
> provisioning.

First, please scrap the idea of "SFP controller". There's no such
device. There's a SFP cage, which is a physical connector and a
specification of the signals on the pins. How those signals are
provided, or even whether they are provided is outside the scope
of the "specification".

This includes the high-speed SerDes pairs for transmit and receive
data. There are also low-speed pins - I2C and state pins. Finally,
there are power pins. State pins end up being connected to GPIOs, or
appropriately tied to their inactive levels or left open depending
whether they are an input to the module or output.

There is no specification that power pins will be controllable.
The only requirement is the voltage on the pins and the stability
of that voltage.

SFP modules have two sets of power pins, one set for the transmitter
and one set for the receiver.

1. Modules are allowed to tie these two sets of power pins together.
2. The recommendation in the SFF documentation is that these are
   derived from a common supply via filtering, and that common supply
   is also used for the signalling pin pull-ups.
3. It is unspecified which of these supplies is used for the "low-
   speed" signalling interfaces.

Given (1), it is unwise for a board with a cage to present two
controllable supplies, as turning one supply off can result in
power being back-fed via a module tying both together. Thus,
specifying separate supplies could be dangerous.

Removing power from a module while plugged in, while keeping the
low-speed signals at logic high levels may result in damage due to
backfeeding power through the ESD protection diodes in the silicon
devices. If the I2C bus is shared, then powering down a module may
corrupt communication to other devices on that I2C bus.

So, given all that, every design I've seen so far connects the SFP
cage power pins to the board's 3.3V supply that is active when the
board is powered.

Now, if you're going to say "ah, so it has power pins, you need to
describe them using a regulator" then I would say to you, when are
we introducing regulators for every device we describe in DT such
as LEDs, switches, GPIO pins, RAM, etc? Every device needs to have a
source of power after all.

- A LED may be wired between a GPIO and a supply.
- A switch that pulls a GPIO up to logic 1 state needs to be connected
  to some sort of supply to do that.
- A GPIO controller requires a source of power in order to signal a
  logic high.

We tend not to describe those because they aren't relevant to the
OS, because they tend to be "always on" supplies that the OS can't
control, and have no effect at all on the kernel itself. DT is not
about translating every single wire and component on a schematic for
a board into a firmware description.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

