Return-Path: <netdev+bounces-73144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C9D85B2EF
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 07:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE2A286D17
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 06:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC4E1DDFC;
	Tue, 20 Feb 2024 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="gGQmBhZa"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208A17740
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410678; cv=none; b=o6iDDUawbtIxYkzZ5gq152bKfQa+Lr35Q+2VA8mc2BnO5Dy3iL1k0K3g0rz4+mfNNXdgBZXTEc/FhTytRfdWwoTzC3fiaeCl6vT5gfgZx+Hz0V5AXg30X8V2ZzI9X0u/BNPGCWC6aLEAEVp3I7a1TbqlQ3I88dpx9kdTeST51dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410678; c=relaxed/simple;
	bh=R6Zhfa5I3cBJOYPLOma72yszCyzV5+QDltINN2T/1wI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bHX48or2IlP47PB3kM+EHh6j2q1zPufHeU95C2muz7fhtZZWm60H537dS1Ubfv//sJTuKj7iHtGuRhC9+KIo7kvF6r5u2EE/MKTt59znItE7S9p7BIclfBZ61X4RRPnpi0jUbsw/hnEgkMS6gf6neH4w8h3baQtrXOQ/c2xvYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=gGQmBhZa; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 412732009F;
	Tue, 20 Feb 2024 14:31:13 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708410673;
	bh=Me9rxM5N3iWUmwjHi0jz3vpuny1zY7rRWXQ2K4zUS/M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gGQmBhZaYiobSGgTPrCfZWfI1IkJ0Y9cEUgGzakhYs0vBbi1yiXoALIBnvMcHxJda
	 3k3ywLEW75AmJFzhyn/jxLA/tvKa+RQfuvnNBapgGE7Mb7gHVQHwg2Yo1E00xmBchV
	 qru2oX27jEJw4cpU0A0tErLSB8JZKFRZ29CmlRWsLLTOx1iaUKqTHBDY/wiG3i8x2t
	 mek8Lcp4Qdu8pGwvZDAaJTRUfZaSLuW2avERXAIpV3aH/F9v2j+ljeE2EIrgYu1Jai
	 pMX58nF0GG5QlTBtst6zr0cPkxhNiZXBa4SVVQXRygpFEgvIJa4UVqnLilpmTT0HpO
	 fYrR596UeSReg==
Message-ID: <fbf0f5f5216fb53ee17041d61abc81aaff04553b.camel@codeconstruct.com.au>
Subject: Re: MCTP - Socket Queue Behavior
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: "Ramaiah, DharmaBhushan" <Dharma.Ramaiah@dell.com>, 
	"netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "matt@codeconstruct.com.au"
	 <matt@codeconstruct.com.au>
Cc: "Rahiman, Shinose" <Shinose.Rahiman@dell.com>
Date: Tue, 20 Feb 2024 14:31:12 +0800
In-Reply-To: <SJ0PR19MB4415EA14FC114942FC79953587502@SJ0PR19MB4415.namprd19.prod.outlook.com>
References: 
	<SJ0PR19MB4415F935BD23A6D96794ABE687512@SJ0PR19MB4415.namprd19.prod.outlook.com>
	 <202197c5a0b755c155828ef406d6250611815678.camel@codeconstruct.com.au>
	 <SJ0PR19MB4415EA14FC114942FC79953587502@SJ0PR19MB4415.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dharma,

> Thanks for the reply. I have few additional queries.

Sure, answers inline.

> > We have no control over reply ordering. It's entirely possible that
> > replies are
> > sent out of sequence by the remote endpoint:
> >=20
> > =C2=A0 local application=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 remote endpoint
> >=20
> > =C2=A0 sendmsg(message 1)
> > =C2=A0 sendmsg(message 2)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 receives message 1
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 receives message 2
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sends a reply 2 to message 2
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sends a reply 1 to message 1
> > =C2=A0 recvmsg() -> reply 2
> > =C2=A0 recvmsg() -> reply 1
> >=20
>=20
> Based on the above explanation I understand that the sendto allocates
> the skb (based on the blocking/nonblocking mode). mctp_i2c_tx_thread,
> dequeues the skb and transmits the message. And also sendto can
> interleave the messages on the wire with different message tag. My
> query here regarding the bus lock.
>=20
> 1. Is the bus lock taken for the entire duration of sendto and
> revcfrom (as indicated in one of the previous threads).

To be more precise: the i2c bus lock is not held for that entire
duration. The lock will be acquired when the first packet of the message
is transmitted by the i2c transport driver (which may be after the
sendmsg() has returned) until its reply is received (which may be before
recvmsg() is called).


> Assume a case where we have a two EP's (x and y) on I2C bus #1 and
> these EP's are on different segments.

I assume that by "different segments" you mean that they are on
different downstream channels of an i2c multiplexer. Let me know if not.

> In this case, shoudn't the bus be locked for the entire duration till
> we receive the reply or else remote EP might drop the packet as the
> MUX is switched.

Yes, that's what is implemented.

However, I don't think "locking the bus" reflects what you're intending
there: Further packets can be sent, provided that they are on that same
multiplexer channel; current use of the bus lock does not prevent that
(that's how fragmented messages are possible; we need to be able to
transmit the second and subsequent packets).

To oversimplify it a little: holding the bus lock just prevents i2c
accesses that may change the multiplexer state.

From your diagram:

>=C2=A0 Local application=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0remote endpoint
>=C2=A0 Userspace=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Kernel Space
>=20
> sendmsg(msg1)<epX, i2cbus-1, seg1>
> sendmsg(msg2)<epY, i2cbus-1, seg2>

Note that "i2cbus-1, seg1" / "i2cbus-1, seg2" is not how Linux
represents those. You would have something like the following devices in
Linux:

 [bus: i2c1]: the hardware i2c controller
  |
  `-[dev: 1-00xx] i2c mux
     |
     |-[bus: i2c2]: mux downstream channel 1
     |  |
     |  `- endpoint x
     |
     `-[bus: i2c3]: mux downstream channel 2
        |
        `- endpoint y

Then, the MCTP interfaces are attached to one individual bus, so you'd
have the following MCTP interfaces, each corresponding to one of those
Linux i2c devices:

  mctpi2c2: connectivity to endpoint X, via i2c2 (then through i2c1)
  mctpi2c3: connectivity to endpoint Y, via i2c3 (then through i2c1)

- where each of those mctpi2cX interfaces holds it own lock on the bus
when waiting on a reply from a device on that segment.

(you could also have a mctpi2c1, if you have MCTP devices directly
connected to i2c1)

> Also today, MCTP provides no mechanism to advertise if the remote EP
> can handle more than one request at a time. Ability to handle
> multiple messages is purely based on the device capability. In these
> cases shouldn't Kernel provide a way to lock the bus till the
> response is obtained?

Not via that mechanism, no. I think you might be unnecessarily combining
MCTP message concurrency with i2c bus concurrency.

An implementation where we attempt to serialise messages to one
particular endpoint would depend on what actual requirements we have on
that endpoint. For example:

 - is it unable to handle multiple messages of a specific type?
 - is it unable to handle multiple messages of *any* type?
 - is it unable to handle incoming responses when a request is pending?
=20
So we'd need a pretty solid use-case to design a solution here; we have
not needed this with any endpoint so far. In your case, I would take a
guess that you could implement this just by limiting the outstanding
messages in userspace.

Further, using the i2c bus lock is the wrong mechanism for serialisation
here; we would want this at the MCTP core, likely as part of the tag
allocation process. That would allow serialisation of messages without
dependence on the specifics of the transport implementation (obviously,
the serial and i3c MCTP transport drivers do not have i2c bus locking!)

Cheers,


Jeremy

