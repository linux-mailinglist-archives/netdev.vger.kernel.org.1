Return-Path: <netdev+bounces-74958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB686792C
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86CD291338
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5F1145FE5;
	Mon, 26 Feb 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="JpBUoPUa"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62350145B25
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958254; cv=none; b=mTTCBbm7gLNJrpDPZLAugHOoS6pVlszVFWXDakIk+bd91iX6DSz6+8G2okWkVxDByNKsnt7a9ozb7d7PpNtUIG5eZ1CaXB1FZuayFdXn5klECxyxZRl++IL11zMOYrgv+EGlfJXilps1si9oH/WcjBsma4asEHZAMYvTuZRmTmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958254; c=relaxed/simple;
	bh=BllqSZzFzm46ETRRb7f/ZnInxNzbvLNTReNdXBub+3Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iYYpe1rWmXQQkqtWAKWbRsmJgpWJk8lT+TninC/cqxSOI5jYZJAiTJkNaPH5rt4Xg2MYQb8vvZmmk5KsHyzSQvEp2DT2secoVIiINIDP7Y2PNpMMTt+DBaD11X7lcMXEzG+k1zQp05RR2XIEURj88wQc6jhObmSQzpp0RPx4u20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=JpBUoPUa; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from sparky.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0B50D201B5;
	Mon, 26 Feb 2024 22:37:29 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708958249;
	bh=Ifv1HbBODQ6Nb2yJVN7DXJhNi5ZN2BXA4Vdp39eB79M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JpBUoPUaODoJKl+4r8XxbpeGTxYQ35XP/Bsp2KdPHjPwND44GQekw7yBzWHki+36D
	 2TukI1OopOaTIjyTuQUL6Y/rSg/PC8tC+bG2l/vqMIfghYkGJZcJa5dkijPODNX70A
	 oZhGXV5LeV99p04asA3jl1LbbAtk5ArQU+3MRNH7gUjS3nohmcC4ezubEo9WY8R/D2
	 hl35iIEMi0UBp9oF+SgFI5sz14SSu22eX+Q3g++ejVqN2AmkYPoH3AbPTKP2rGMBEg
	 Eex7yvBsSRRHH4kjAo0blH/sh6PtFDp0TOIPZG6lU7c7zNIBnu5YKNCDBolMQLDuvQ
	 nbqdm7DYT0wYw==
Message-ID: <6aaffdd81feeb1cf6ff374a534f916410c106cf6.camel@codeconstruct.com.au>
Subject: Re: MCTP - Socket Queue Behavior
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: "Ramaiah, DharmaBhushan" <Dharma.Ramaiah@dell.com>, 
	"netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "matt@codeconstruct.com.au"
	 <matt@codeconstruct.com.au>
Cc: "Rahiman, Shinose" <Shinose.Rahiman@dell.com>
Date: Mon, 26 Feb 2024 22:37:28 +0800
In-Reply-To: <SJ0PR19MB4415097526AFE55EC0EE2714875A2@SJ0PR19MB4415.namprd19.prod.outlook.com>
References:
	 <SJ0PR19MB4415F935BD23A6D96794ABE687512@SJ0PR19MB4415.namprd19.prod.outlook.com>
	 <202197c5a0b755c155828ef406d6250611815678.camel@codeconstruct.com.au>
	 <SJ0PR19MB4415EA14FC114942FC79953587502@SJ0PR19MB4415.namprd19.prod.outlook.com>
	 <fbf0f5f5216fb53ee17041d61abc81aaff04553b.camel@codeconstruct.com.au>
	 <BLAPR19MB4404FF0A3217D54558D1E85587502@BLAPR19MB4404.namprd19.prod.outlook.com>
	 <da7c53667c89cb7afa8d50433904de54e6514dde.camel@codeconstruct.com.au>
	 <SJ0PR19MB4415097526AFE55EC0EE2714875A2@SJ0PR19MB4415.namprd19.prod.outlook.com>
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

> Basically, interleaving of the messages completely depends on the I2C
> driver.

To clarify: it completely depends on the MCTP-over-i2c transport driver
(as opposed to the i2c controller hardware driver). This is the entity
that is acquiring/releasing the i2c bus lock during MCTP packet
transmission.

> If lock in the transport driver is designed to block the I2C
> communication till the existing transaction is complete, then
> messages shall be serialized. If transport driver does the locking in
> the way I have mentioned does this in anyway effect the Kernel socket
> implementation (time out)?

This approach would need some fundamental changes to the core kernel
MCTP support.

The transport drivers do not work on a message granularity; like other
network interface drivers, they deal with individual packets from the
protocol core. The driver has access to hints around which "flows" may
be active (which the i2c driver uses to acquire/release the bus lock),
but in order to implement your proposed message serialisation, the
driver would need to re-order packets back into messages, otherwise we
would be prone to deadlocks.

... then, given MCTP cannot accommodate reordered packets, this would
also be prone to packet loss in all but the simplest of message
transfers.

That is why the MCTP-over-i2c transport's use of the i2c bus lock is
nestable: we need to prevent loss of MUX state, but need to ensure we
can make forward progress given multiple packet streams, and their
expected responses.

> > So, if this is manageable in userspace (particularly: you don't
> > need to manage
> > concurency across multiple upper-layer protocols), the sockets API
> > is already
> > well suited to single-request / single-response interactions.
> >=20
> If we can manage concurrency in the Kernel this would provide more
> design options at the user space,

Sure, a kernel-based approach would probably make for a cleaner overall
design, and would cater for multiple applications attempting to
communicate without requiring their own means of managing concurrency.

> > Why do you need to prevent interactions with *other* devices on the
> > bus?
> >=20
> When bus the is shared with multiple devices and requests are
> interleaved, responses are dropped by the EP points due to bus busy
> condition.

So this specific endpoint implementation needs a *completely* quiesced
bus over a request/response transaction? this is a little surprising, as
it restricts a lot of bus behaviours:

 - it requires a completely serialised command/response stream

 - it can only operate as a responder

 - it cannot correctly implement any upper layer protocols that do not
   have a strict request-then-response model (there are components in
   all of NVMe-MI, PLDM and SPDM that may violate this requirement!)

 - it cannot be present on a bus with other endpoints which may
   asynchronously send their own MCTP packets, and/or participate in
   SMBUs ARP (and so are not serialisable by the kernel's MCTP
   behaviour)

Given these limitations, it may be more effective to improve that
endpoint's MCTP/SMBus support, rather than add workarounds to the kernel
MCTP implementation. Of course, I understand this may not always be
feasible, but may make things easier for you in the long term.

Cheers,


Jeremy


