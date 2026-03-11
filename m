Return-Path: <netdev+bounces-266689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLTHNLuQsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:56:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6697F266D9C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30820302D53D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D3A371892;
	Wed, 11 Mar 2026 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cKGmHOcY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F61370D64
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244555; cv=none; b=sq43bciL6ziSJdIGYP1k4UXWkV3IPw5rrR8gIBPYFQvOJ1E73trd5Ncw+5iuan+8K95oZNEgaIgGT8JHw6jI7oeIV+T07vFXDe8AaDJ9m1fn7CYmNtiAJfqmQFUoDvcZSt0/9ohQPkN6hfRjxJ+T+n9w9DUun6oSJaa+x6llqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244555; c=relaxed/simple;
	bh=W3YgSSxnbWfmg3f0dUMoKblLbCtkzqBBfLP8Gk99k+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nem0ZqFVWhpAhGIH/4wiVEAKgYn+1xbw7TqIyNH6bXFkgfggazeQ1KQ2wTvBK4adbOo5oMg4HCD/XnVz8hKMdDZB6S/EVOLM9iTrB74ByQ8K8I/uKYc9rUM4CSS2xHWTmcU4s4Oxtpva15OPnfC0SdfmkwR7SumGJz7VGEYqezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cKGmHOcY; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B3235C41585;
	Wed, 11 Mar 2026 15:56:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4CB9360004;
	Wed, 11 Mar 2026 15:55:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62C5710369141;
	Wed, 11 Mar 2026 16:55:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773244550; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zAbG30hk15tMQuuCoE+2yO4pcBiAVYc3VmHMKsR0o8M=;
	b=cKGmHOcYFIClUVPsXw6cdRHc70TZVhKNohqeLIWAZ4838cubBv61SYpVo3Nd/8cVaqCRdL
	qcsQtaUXpMZy2YUKdLSSFpfaJW3hG+E/GaW0lRuhBDgTd8+Uf+Bl/1JvmBcAAHjBQkLe6o
	Ej77FUr8+QLRN6jKwUnY8lsRwyVfLoTrdZrYRXWpinHtBJtnVeYRrFTrjdrhV2Zac+sVdK
	9KfGwjKSPxwVeHedaTHtQhWZfpHjU9PbFUVVi9VPLvO1FXjW0g3uwz/pQiBakNbIpl2PID
	OnkwjjJkIyBod6xJq3OZlxxVhV38R6bQUXlm4bb24EoRUoN11k6OeCkeCk/r4Q==
Message-ID: <eb6edd0d-36b6-416a-bf74-676421f12f2d@bootlin.com>
Date: Wed, 11 Mar 2026 16:55:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Disappearance of network PHYs
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>
Cc: Wei Fang <wei.fang@nxp.com>, netdev@vger.kernel.org
References: <20260311153421.u454m3e4blkstymt@skbuf>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260311153421.u454m3e4blkstymt@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266689-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,gmail.com,lunn.ch,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 6697F266D9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vladimir,

On 11/03/2026 16:34, Vladimir Oltean wrote:
> Hi,
> 
> This is a follow-up from this thread:
> https://lore.kernel.org/netdev/PAXPR04MB8510CB77C95D4D044FE62C64889BA@PAXPR04MB8510.eurprd04.prod.outlook.com/
> 
> I picked up from where Russell, Maxime and Wei left the discussion more
> than 1 month ago, and quickly prototyped patches that would mechanically
> remove the kernel crashes caused by invalid phydev dereferences from the
> MAC driver of phylib/phylink, when the phydev goes away.
> 
> (far from perfect, may still have deadlocks or lockdep splats) PoC patches at:
> https://github.com/vladimiroltean/linux/tree/phy-remove
> 
> I ran out of steam because I'm not really sure what we want given what's
> possible, and I don't want the effort/discussion to completely die away,
> so I'm asking the PHY maintainers and other interested people for advice,
> while explaining what I found to be (not) possible.

Thanks for keeping this discussion alive :)

> 
> Mechanically, what happens now in my branch, with a disappeared phydev but
> there's nothing that can crash the kernel, is that the netdev carrier state is
> in holdover mode. Meaning: if the link was up before, it still is up; if it was
> down, it still is down. Furthermore, traffic still works if it worked
> before. This is because the PHY is not an active component to the data
> path (I am excluding things such as PHY timestamping), and I've patched the
> state machine to preserve the last state and do no further work.
> 
> However, if I stop and start again a disappeared phydev, phy_start()
> leaves it in the PHY_DOWN state, to avoid some WARN_ON()s. This is
> admittedly inconsistent.
> 
> This serves as an illustration of the most complicated part of surviving
> the loss of one of your providers - what to do afterwards? The MAC driver
> may have done stateful stuff with the PHY prior to it going away.
> The netdev->phydev pointer persists, but even if the phydev later comes
> back - it's no longer the same phydev and those operations need to be
> repeated. But how to repeat those operations, when
> (1) no one kept track of them
> (2) the netdev->phydev that the MAC is holding on to is not the same as
>     the new phydev that gets created on rebind
> 
> So even if the netdev->phydev pointer lingers on, it is effectively junk and in
> everyone's best interest that the MAC driver gets rid of it ASAP. And then do
> what?
> 
> There are 2 distinct cases to think about:
> 1. MAC driver connects to the PHY at ndo_open() and disconnects at ndo_stop().
>    I can see something like a forced admin down from the kernel (somehow).
> 2. MAC driver connects to the PHY at probe() and disconnects at remove().
>    I don't see how these can survive the loss of netdev->phydev in a meaningful
>    way (meaning: have a way to recover when it comes back).
> 
> Actually DSA belongs to case 2, which complicates the discussion, since it is
> one of the reasons we don't consider device links as good.
> 
> However, I must point this out. Device links provide a very reasonable and clean
> answer to what should the MAC driver do when its PHY goes away. Unbinding the
> MAC makes sure that none of its internal assumptions about PHY state will be
> violated when the PHY later binds back, and it doesn't require complex tracking
> either. It also scales to multiple (and different kinds of) providers, which
> can also go away, in much the same way.
> 
> Sure, I don't like the side effects of that answer when applied to DSA either,
> but maybe that's something we can work on, while not fully rejecting it.
> 
> Some ideas, mostly listed as conversation starters:
> - Modify DSA to connect to the PHY at ndo_open() time.
> - Modify DSA to register a separate struct device (with generic DSA port driver)
>   for each port. Link the net_device parent device with this port device.
>   The PHY device link unbinds only the port device, which can be later rebound
>   via sysfs. Solution gets repeated for whatever other switchdev/multi-port
>   NIC driver is written that uses external providers. We modify
>   Documentation/networking/switchdev.rst to make driver authors aware of
>   the problem.
> - Create an optional notifier chain that the PHY is going away, which the MAC
>   monitors and informs phylib that it does. Drivers that don't inform phylib
>   get unbound via the device link mechanism. Those who monitor the notifier
>   don't get unbound.
> - A combination of the above

One other thing could be to rely on phylink to handle that ? It's the
one part of the net stack that already handles PHY devices suddenly
disappearing, with the SFP case. It has all the logic in place to
maintain the netdev's phydev pointer without the MAC driver having to
deal with that.

And for MAC drivers that don't use phylink, we could consider falling
back to the fw_devlink approach that was proposed, i.e. big hammer
solution that has nasty side-effects but that doesn't crash the kernel
ang gives user a chance to recover, provided the side-effects in
question didn't kick them out of their HW ?

Maxime


