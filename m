Return-Path: <netdev+bounces-254809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ds0Dblke2l2EQIAu9opvQ
	(envelope-from <netdev+bounces-254809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:46:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94527B08E3
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D90D3011F35
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CA82868B2;
	Thu, 29 Jan 2026 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BFhh/9Lk"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033AB3A1CD;
	Thu, 29 Jan 2026 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769694219; cv=none; b=gN34pBHcL6rq6i/NVEM3pNwtp9oUa8A7BrLRRp0fG+QMTU0cHuf89wOx5LgvNXssnvXScWMYzXnvcxE9KQi354u1T28IgwmTeFKkfcMekh/akrDaLcAJR2HZL3xotp/KoB//wlt64+Q1avhBTt6PCRdDkr0Mi/cCFSl/diU5nkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769694219; c=relaxed/simple;
	bh=mcJS9C87+K5tbv4t1sPnNZdQCMYqgIX5w9Sr9bv0ezE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QnHbcjpYZTy/DgpBkhYUr0xZgii/L7lerHaxUP/BD0+Om053Mb+S407G9R+i7B4Dn8speoejC6bAbrJpwME3k+gSXt9HQU0KZOyHU95ZDxpVcGthIRDY55RT2An8WHxU69e0q4ghPJr2EaqTDDSpVZUruCNOPJkH+kIkT2kgA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BFhh/9Lk; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1769694209;
	bh=cqbwRhoH+gHh8BHTPN0cIk2URG7raiuuJ2m6fyZxtlE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BFhh/9LkLMQ7Ln4nTVx14j4d2BjUoNDuJD71UgERiLDfs039A+QcrkkVhKkshVB6R
	 dQ8NKbLBxtnWpqSJuRNiDuXY/6oIF5sxl4yndyY41ukTEtnJFTrN/EFpME2Y6xEUJ7
	 TUcZLFD7uI8BIL0pLzipdjDC3aL7aNnx3hI4DVE4SU2jhLYvH1arCUeMCRqxnQNlo3
	 0PwScWCFc2Gysr0jtVTEDOCgo/2aSgHpXJ8+sKg+KXFFxNbA/aKnU1LLFpp8iQR1Ly
	 JVoD6Q0mlFRroY0qauyrVLiYJ1EqLMS+ziAMVcpx4j9Hzcbw3LRDsKKx2NDEZEdN1o
	 3IcqHy2DsVfrQ==
Received: from sparky.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B957960011;
	Thu, 29 Jan 2026 21:43:27 +0800 (AWST)
Message-ID: <547a1a5fd7238897b35b26e83ac27db452e6a5f7.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/4] i2c: SMBus ARP support
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Matt Johnston
 <matt@codeconstruct.com.au>, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 29 Jan 2026 21:43:26 +0800
In-Reply-To: <aXokxtlFTeZK8lP8@kuha>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
	 <30ad166e2b3d7f10080356ec232e604f3ac9ea2e.camel@codeconstruct.com.au>
	 <aXdyll4KVOF6SWni@kuha>
	 <6ca4bc87620bb0c2e5bfb264ec88189f32b53757.camel@codeconstruct.com.au>
	 <aXjDENOsmWe5_VqS@kuha>
	 <189d4a03f32ace3fd995596e8b5415ced6ae9c3a.camel@codeconstruct.com.au>
	 <aXokxtlFTeZK8lP8@kuha>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254809-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,codeconstruct.com.au:mid,codeconstruct.com.au:dkim]
X-Rspamd-Queue-Id: 94527B08E3
X-Rspamd-Action: no action

Hi Heikki,

> There seems to be another a bit more severe issue with ARP and
> i2c-dev. Right now it seems that anything that can access the i2c
> character devices can silently (without the kernel having any idea
> what's going on) assign a conflicting address to a dynamically
> addressed ARP-device. Perhaps more importantly, the user space can
> remove access to an ARP-device by silently assigning a new address to
> it or simply by resetting its state with Prepare to ARP.
>=20
> That can happen accidentally, but it can also be done intentionally.
>=20
> Unless I've missed something, this really is a major threat that we
> have to solve. Right now the only idea that I have is that we simply
> prevent the i2c-dev from using the SMBus Default Address.

I don't necessarily see this as an issue; access to the chardev somewhat
implies full access to the i2c bus, and so arbitrary interactions with
devices to alter device states. Including the i2c address as part of the
affected state doesn't seem like a huge difference in access.

There may be a specific case that is interesting though:

 - an ARP-able device is in use by a kernel driver, which excludes
   access through the chardev

 - interactions with that device are possible using ARP commands to
   address 0x61 over the chardev

 - so, the device may be re-addressed, now allowing accesses through
   the chardev

However, I am not sure there are existing cases where access to the
chardev is a distinct privilege domain to not just unbind the driver
anyway.

> I'm sorry if I sounded arrogant, it was not my intention.

No problem, just trying to keep things collaborative!

> We don't control the user space, so we can not rely on it to enumerate
> devices like this. We will not be always even able to wait for user
> space with them.

Could you give some details on your intended use-case? That might help
to understand the constraints you're facing.

> The kernel will also still need to be in full control of the
> device, also with the ARP protocol, in order to deal with things like
> conflicts. So consider for example hotplugged devices that are not
> ARP-capable. If the device has a conflicting address with a
> dynamically addressed ARP-device, then kernel really has to be able to
> assign new address to the ARP-device completely independently.

Yeah, managing the bus addressing would definitely be simpler in-kernel.

So I think there's sufficient justification for your approach here, but
I would have a few requests:

 - that ARP is enabled explicitly. I'd be interested in having a DT
   property on the controller node that allows us to enable ARP on a
   per-bus basis.

   Otherwise, I'm pretty sure we'll break someone's existing platform
   by assuming we can start interactions on the SMBus default address.

   Is there some equivalent facility for ACPI based config?

 - I'd need to ensure that the i2c_client doesn't conflict with the MCTP
   transport's use of the device, post-ARP. I'll get a test setup sorted
   here, but I think that requires some changes to the controller driver
   that I'm using.

> > > So why would you want involve the user space at all since it would
> > > just add complexity and limitations without any benefits?
> >=20
> > Because we have fewer risks implementing this in userspace.
> >=20
> > As an example, you currently seem to have a stack information leak in
> > the proposed Get UDID implementation, which would be much less of an
> > issue for the equivalent protocol handling implemented in userspace.
>=20
> If there are bugs in the code then we need to fix them. Can you please
> comment to the patch that has the problem?

Of course, yes. I'd just like to sort the structural things before
dealing with implementation.

> > Is that possible at present? how are you planning to represent ARPed
> > devices in the DT - or more importantly, correlate DT (or other fwnode)
> > nodes to discovered devices?
>=20
> I don't know about DT, but with ACPI the devices are expected to
> either be fixed address devices or just use target address that
> matches to the address in the I2C Serial Bus Connection Resource
> Descriptor. The mapping is not yet done, but the idea is to just
> assign the detected UDID to the i2c-client that was already created
> from the fwnode.

OK, but how do you map the UDID to the resource descriptor? I don't know
much about ACPI, but the descriptor seems to be only keyed on a target
address, which is now dynamic.

(same with DT, devices are keyed by target address)

> > Assuming we go with a kernel approach: For the MCTP case, for full ARP
> > support of MCTP endpoints, we would still need to consume a hotplug
> > event that indicates that the device is available at its new address
> > - there is no kernel driver bound for the remote MCTP endpoints. This
> > event would be consumed by the (existing) MCTP infrastructure in order
> > to start MCTP enumeration. Is this something you have looked at
> > already? If so, if you can send an example of an actual event, I will
> > look at the mctpd part of this.
>=20
> We will have the address attribute file that the user space can use.
> If the address changes uevent will be send it.

Sounds good, but for MCTP there is no struct device bound to the remote
i2c device/address. Are you proposing we change that?

Cheers,


Jeremy

