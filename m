Return-Path: <netdev+bounces-133752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FAB996F2A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EDEAB284D3
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A554A1A0AFA;
	Wed,  9 Oct 2024 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wr1SNHRW"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3DE1A070D;
	Wed,  9 Oct 2024 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486253; cv=none; b=tbLIKbMjZkTJuoIvVMLZJIBtCihXmf06AcD0F/5ZNtgnNoJ6zlvwu78jyom2OtLTRXHr7Kay3A2261MGoetNqqyL/cmHimQ3lnM0jS7dbrSrDE7UvBfio4ZOtPchKyhx52iCkzHJCEOvLgLafZWWAkumJeSVr8vCq6Z+xUdTiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486253; c=relaxed/simple;
	bh=bKIcvQUy8WMdIAm6C6WJ61OnDfoqPH27UagpXtPpork=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXx3AIYWN7M7OL+a69Ft8c2mj6EPQAlwNhxuPJ8P2FSAqLvzsHMKqXuJRFKwsvi3ftkrP5w15DvjPt7mevnRoRC4OT2g8Yw95i7R2mTLgb2CWb+FkylHqXq/8lXCWHGck+ganzlc0OYJa/8tG4qD+7bTRxjapGF/CCqAruElTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wr1SNHRW; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B083240004;
	Wed,  9 Oct 2024 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728486242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ie2PgRzn8m1kOriOpNVQSt76EWBuZBIfrODwjPlTR7o=;
	b=Wr1SNHRWnaI7oacMbDz6+CBg0aLbBVCd28XSmkn7kUzWC0IvelZQg8J2GxHxwa7y6Irv+p
	6hCJJNUEpTW2StF/bFOzrtKxdDgQv92MT5ROpAs3oRWbT/Zmrpb04CpmQpZ7uNEYSah/wP
	K52jQW7uf7FrZyyukhSX4r9/GMip+gl79r63h+yu0HICQ7GsqVW8sa/BirdAv4j1KZpbNA
	OGhs25lAf6Ga22+7MDcgctyNyyTg2gABkZwfXJmwrD+h+MwSSrpaqB/xXA/7L97CpnbV7V
	fpazSR+mS1duWfyn65tig/oHdxOK3yzMtJ5SHIwBw6757cwz0smOKKa/ttCnug==
Date: Wed, 9 Oct 2024 17:04:00 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, Dent Project
 <dentproject@linuxfoundation.org>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>
Subject: Re: [PATCH net-next 00/12] Add support for PSE port priority
Message-ID: <20241009170400.3988b2ac@kmaincent-XPS-13-7390>
In-Reply-To: <ZwaLDW6sKcytVhYX@p620.local.tld>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<ZwaLDW6sKcytVhYX@p620.local.tld>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

Hello Kyle,

On Wed, 9 Oct 2024 13:54:51 +0000
Kyle Swenson <kyle.swenson@est.tech> wrote:

> Hello Kory,
>=20
> On Wed, Oct 02, 2024 at 06:27:56PM +0200, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > This series brings support for port priority in the PSE subsystem.
> > PSE controllers can set priorities to decide which ports should be
> > turned off in case of special events like over-current. =20
>=20
> First off, great work here.  I've read through the patches in the series =
and
> have a pretty good idea of what you're trying to achieve- use the PSE
> controller's idea of "port priority" and expose this to userspace via eth=
tool.
>=20
> I think this is probably sufficient but I wanted to share my experience
> supporting a system level PSE power budget with PSE port priorities across
> different PSE controllers through the same userspace interface such that
> userspace doesn't know or care about the underlying PSE controller.
>=20
> Out of the three PSE controllers I'm aware of (Microchip's PD692x0, TI's
> TPS2388x, and LTC's LT4266), the PD692x0 definitely has the most advanced
> configuration, supporting concepts like a system (well, manager) level bu=
dget
> and powering off lower priority ports in the event that the port power
> consumption is greater than the system budget.
>=20
> When we experimented with this feature in our routers, we found it to be =
using
> the dynamic power consumed by a particular port- literally, the summation=
 of
> port current * port voltage across all the ports.  While this behavior
> technically saves the system from resetting or worse, it causes a bit of a
> problem with lower priority ports getting powered off depending on the
> behavior (power consumption) of unrelated devices. =20
>=20
> As an example, let's say we've got 4 devices, all powered, and we're clos=
e to
> the power budget.  One of the devices starts consuming more power (perhaps
> it's modem just powered on), but not more than it's class limit.  Say this
> device consumes enough power to exceed the configured power budget, causi=
ng
> the lowest priority device to be powered off.  This is the documented and
> intended behavior of the PD692x0 chipset, but causes an unpleasant user
> experience because it's not really clear why some device was powered down=
 all
> the sudden. Was it because someone unplugged it? Or because the modem on =
the
> high priority device turned on?  Or maybe that device had an overcurrent?
> It'd be impossible to tell, and even worse, by the time someone is able to
> physically look at the switch, the low priority device might be back onli=
ne
> (perhaps the modem on the high priority device powered off).
>=20
> This behavior is unique to the PD692x0- I'm much less familiar with the
> TPS2388x's idea of port priority but it is very different from the PD692x=
0.
> Frankly the behavior of the OSS pin is confusing and since we don't use t=
he
> PSE controllers' idea of port priority, it was safe to ignore it. Finally=
, the
> LTC4266 has a "masked shutdown" ability where a predetermined set of port=
s are
> shutdown when a specific pin (MSD) is driven low.  Like the TPS2388x's OSS
> pin, We ignore this feature on the LTC4266.
>=20
> If the end-goal here is to have a device-independent idea of "port priori=
ty" I
> think we need to add a level of indirection between the port priority con=
cept
> and the actual PSE hardware.  The indirection would enable a system with
> multiple (possibly heterogeneous even) PSE chips to have a unified idea of
> port priority.  The way we've implemented this in our routers is by putti=
ng
> the PSE controllers in "semi-auto" mode, where they continually detect and
> classify PDs (powered device), but do not power them until instructed to =
do
> so.  The mechanism that decides to power a particular port or not (for la=
ck
> of a better term, "budgeting logic") uses the available system power budg=
et
> (configured from userspace), the relative port priorities (also configured
> from userspace) and the class of a detected PD.  The classification resul=
t is
> used to determine the _maximum_ power a particular PD might draw, and tha=
t is
> the value that is subtracted from the power budget.
>=20
> Using the PD's classification and then allocating it the maximum power for
> that class enables a non-technical installer to plug in all the PDs at the
> switch, and observe if all the PDs are powered (or not).  But the importa=
nt
> part is (unless the port priorities or power budget are changed from
> userspace) the devices that are powered won't change due to dynamic power
> consumption of the other devices.
>=20
> I'm not sure what the right path is for the kernel, and I'm not sure how =
this
> would look with the regulator integration, nor am I sure what the userspa=
ce
> API should look like (we used sysfs, but that's probably not ideal for
> upstream). It's also not clear how much of the budgeting logic should be =
in
> the kernel, if any. Despite that, hopefully sharing our experience is
> insightful and/or helpful.  If not, feel free to ignore it.  In any case,
> you've got my

Thanks for your review and for sharing your PSE experience.
It indeed is insightful for further development and update of this series.

So you are saying that from a use experience the port priority feature is n=
ot
user-friendly as we don't know why a port has been shutdown.
Even if we can report the over-current event of which port caused it, you s=
till
thinks it is not useful?

We could have several cases for over power budget event:
- The power limit exceeded is the one configured for the ports.
  We should shutdown only that port without taking care about priority.
  TPS23881 has this behavior when power exceed Pcut.
  I think the PD692x0 does the same. Need to verify.
- The power limit exceeded is the global (or manager PD69208M) power budget.
  Here port priority is interesting.
  Is there a way to know which port create this global power limit excess?
  Should we turn off this port even if he don't exceed his own power limit =
or
  should we turn off low priority ports?
  I can't find global power budget concept for the TPS23881.=20
  I could't test this case because I don't have enough load. In fact, maybe=
 by
  setting the PD692x0 power bank limit low it could work.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

