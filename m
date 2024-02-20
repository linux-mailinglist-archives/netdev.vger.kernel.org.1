Return-Path: <netdev+bounces-73481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B085CC46
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54872810D0
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 23:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A384154BED;
	Tue, 20 Feb 2024 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="GGxQTVxw"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14B9154430
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473175; cv=none; b=PxBRHbARbj6c72FM8dkcQuCqexHqkO/1h6i/xMC3/HQhChtwg5mce635BwdwKwCecct4a6p9wzip30phGx9GCTIDAd2a+6p6qQBT06qY9Jo2Hope4S65hpWcT3snJG0cN9rp6lFwGUzE8myGIfLJ1aA3GJJOQgdy7zWb74ZVcc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473175; c=relaxed/simple;
	bh=evIjVdbMd6dVtvJjKC877kvHBB9NSzewYdRIqfaHJIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KCDh5swatgOmgz9u7pLWe/ARoQeEbZQy2MMDE+3OIT96ezj4R+tiq2GgdLLmuKimFHR/X4lXoKB517LIXhc+Ro1u7ZW0+Lg39Esuie+XiTWvIYBqi79oVbgwfKJ+bKoUGpBDVG8n38rB5IxQcuMxwUjW3Zl3sObsFgy8QsdZe64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=GGxQTVxw; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3025320154;
	Wed, 21 Feb 2024 07:52:50 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708473170;
	bh=DZi/wzfFddazO9OygUYaDs4JaoKVIjPT/KM0SvXuG3c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GGxQTVxw0xMTHZzlqUt6T0Lk28OHXuluDMHYH61637Kb2ke+moDwSoLg/yFDg5+qd
	 g/YrivI/tog8ysk49/4IdRFGrxvlca+DdYJdT8Pf40PZT1Sn2bpaB7BQRGIJMNg8yl
	 RL3W+qndgn2tDEUmIyBb/L1YXH23ZzS4MWt72Y7BTihQ7ga12KzfeNoPd20eA8QrUY
	 MyPI9tj+Yips20EFGmzMoCwh3y1vXDgfYtMi53ogpwip+Gt9DewZnP/YlecDgZe5DE
	 YHcOr+2KqiAVSi/Necm20UC2TxYsExfwvNcaiHvQ55pUhEoLrS+CS4Ua3w+a3S/SEz
	 G1KM8dqamxlHg==
Message-ID: <da7c53667c89cb7afa8d50433904de54e6514dde.camel@codeconstruct.com.au>
Subject: Re: MCTP - Socket Queue Behavior
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: "Ramaiah, DharmaBhushan" <Dharma.Ramaiah@dell.com>, 
	"netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "matt@codeconstruct.com.au"
	 <matt@codeconstruct.com.au>
Cc: "Rahiman, Shinose" <Shinose.Rahiman@dell.com>
Date: Wed, 21 Feb 2024 07:52:49 +0800
In-Reply-To: <BLAPR19MB4404FF0A3217D54558D1E85587502@BLAPR19MB4404.namprd19.prod.outlook.com>
References: 
	<SJ0PR19MB4415F935BD23A6D96794ABE687512@SJ0PR19MB4415.namprd19.prod.outlook.com>
	 <202197c5a0b755c155828ef406d6250611815678.camel@codeconstruct.com.au>
	 <SJ0PR19MB4415EA14FC114942FC79953587502@SJ0PR19MB4415.namprd19.prod.outlook.com>
	 <fbf0f5f5216fb53ee17041d61abc81aaff04553b.camel@codeconstruct.com.au>
	 <BLAPR19MB4404FF0A3217D54558D1E85587502@BLAPR19MB4404.namprd19.prod.outlook.com>
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

> > To be more precise: the i2c bus lock is not held for that entire
> > duration. The
> > lock will be acquired when the first packet of the message is
> > transmitted by the
> > i2c transport driver (which may be after the
> > sendmsg() has returned) until its reply is received (which may be
> > before
> > recvmsg() is called).
> >=20
> From what I understand from the above bus is locked from the point
> request is picked up for transmission from SKB till response of the
> packet is received.

That's mostly correct, but:

> If this is case, then messages shall not be
> interleaved even if multiple application calls multiple sends.

"locking the bus" doesn't do what you're assuming it does there.

When an instance of a transport driver needs to hold the bus over a
request/response, it does acquire the i2c bus lock. This prevents the
mux state changes we have been discussing.

However, that same transport driver can still transmit other packets
with that lock held. This is necessary to allow:

 - transmitting subsequent packets of a multiple-packet message
 - transmitting packets of other messages to the same endpoint; possibly
   interleaved with the first message
 - transmitting packets of other messages to other endpoints that are on
   the same segment

> Since the locking mechanism is implemented by the transport driver
> (I2C Driver), topology aware I2C driver can lock the other
> subsegments.=C2=A0 E.g. if a transaction is initiated on the EP X, I2C
> driver can lock down stream channel 1. Please do correct me if the
> understanding is correct.

That is generally correct, yes. Typically the mux's parent busses will
be locked too.

The specific locking depends on the multiplexer implementation, but is
intended to guarantee that we have the multiplexer configured to allow
consistent communication on that one segment.

> > An implementation where we attempt to serialise messages to one
> > particular
> > endpoint would depend on what actual requirements we have on that
> > endpoint. For example:
> >=20
> > =C2=A0- is it unable to handle multiple messages of a specific type?
> > =C2=A0- is it unable to handle multiple messages of *any* type?
> > =C2=A0- is it unable to handle incoming responses when a request is
> > pending?
> >=20
> > So we'd need a pretty solid use-case to design a solution here; we
> > have not
> > needed this with any endpoint so far. In your case, I would take a
> > guess that
> > you could implement this just by limiting the outstanding messages
> > in
> > userspace.
> >=20
> We have seen a few devices which can handle only one request at a
> time and not sequencing the command properly can through the EP into
> a bad state.=C2=A0 And yes this can be controlled in the userspace.
> Currently we are exploring design options based on what is supported
> in the Kernel.

OK. There are some potential design options with the tag allocation
mechanism, and marking specific neighbours with a limit on concurrency,
but we'd need more details on requirements there. That's probably a
separate thread, and a fair amount of work to implement.

So, if this is manageable in userspace (particularly: you don't need to
manage concurency across multiple upper-layer protocols), the sockets
API is already well suited to single-request / single-response
interactions.

> > Further, using the i2c bus lock is the wrong mechanism for
> > serialisation here;
> > we would want this at the MCTP core, likely as part of the tag
> > allocation
> > process. That would allow serialisation of messages without
> > dependence on
> > the specifics of the transport implementation (obviously, the
> > serial and i3c
> > MCTP transport drivers do not have i2c bus locking!)
> >=20
>=20
> Serialization at MCTP core can solve multiple MCTP requests. But if
> the same bus is shared with Non MCTP devices, bus lock must be from
> the time request is sent out to reply received.

Why do you need to prevent interactions with *other* devices on the bus?

Cheers,


Jeremy

