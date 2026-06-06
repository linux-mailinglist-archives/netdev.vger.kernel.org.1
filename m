Return-Path: <netdev+bounces-296102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id atVxLZMMJGo42QEAu9opvQ
	(envelope-from <netdev+bounces-296102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 14:03:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDA764D4D3
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 14:03:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=IcvkpkKr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296102-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296102-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75A02300FC6D
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 12:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A743A05E5;
	Sat,  6 Jun 2026 12:03:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9C39DBE0;
	Sat,  6 Jun 2026 12:03:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780747401; cv=none; b=dAn6J3hFhk0DCJzRWTdEHbptGfQ37gGgR6wqbKirCuLLR2uWcsupR8KaUm/8+om825Rvz6OyCooiI/dleSUobndas35GAWUDN55aZb1nlZ2r6NvuikOr/df3sH/nxpzIB0CgKRNuPvhy9vPbs/kIIGJx5KET/47RQo1gWbyR1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780747401; c=relaxed/simple;
	bh=nHGBurcIUF67LJvrhQ+KIQA2Rsd3qCjQO1RafX1Kntw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMUQZIrp2CcNRi5YO9+cvblzh13TuKu6DvTSTg26i9sgYTJPqVmoqTkjAmulfxUVMl7xbMFkXlWD+QleIn9ool07pnqg/Tqyq1wZ5Wj7EzCLX07r/3atzvh55Pl4d0H5uevrj5xBczCgtDdiiemPyMLLGWTz6s0Uj6wKOVoZAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IcvkpkKr; arc=none smtp.client-ip=109.224.244.123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780747395; x=1781006595;
	bh=nHGBurcIUF67LJvrhQ+KIQA2Rsd3qCjQO1RafX1Kntw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IcvkpkKrp2Qyk+JMx+nIkCJmGnQcWG2ALAbMn6j7AeS7vgiSkcBdwb7MehEZqeySr
	 XyZsDMcIKvaIIGrKCCfdo/DRTXt/iGksR8KDm4CQekb82xXYwp48JFEmXsHExUXwW0
	 VWGNvqvu6QH1cE8nxQyMDzL/d4WAjWioXn4saUmlM+uKIt2FIeqkZGsEdHZcAWTpKp
	 6gVEVEQAXd8mmt7mHLDh9JepRGGHnyLmKCFGyFJ0+NmGIOwZYWAEijDHUrYCu/w16m
	 td35kJVZ14h58rApz5FtqzBRG+jAN0+CLMA6/AywBhlAUcaqFP1QVm2Hntmo8XL7ci
	 3qxJkreuxuZPw==
Date: Sat, 06 Jun 2026 12:03:11 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: =?utf-8?Q?Leonardo_M=C3=B6rlein?= <leo.moerlein@proton.me>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>, Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, Buday Csaba <buday.csaba@prolan.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: mdio_device: leave PHY reset deasserted on unregister
Message-ID: <uq8ChQ1OcJp0_nDVZuQ4xinQjP5UbPYysTtMrxJWvw5VCKmOUzDIJVjV9dcN2HTqWroeIAAdCAXiTnHns2GBA7v3C_iNop5DnDPHZVyslro=@proton.me>
In-Reply-To: <5b7e9dad-d346-40a8-8c7b-cfe10f8388a7@lunn.ch>
References: <20260520151355.1371163-1-leo.moerlein@proton.me> <57b43ade-2c7b-4eaf-b9fa-406edee0fe44@lunn.ch> <hRNIpXMBtfUH-OrabbMVvOWAZ5J4O1XNTvx0lMYIDdSLqFL9hhZKdb3CzPo7VgUrwKi6MD3qlj2li6eHybgzFBB_Wfqu5Lc4dABXt9mpL2s=@proton.me> <5b7e9dad-d346-40a8-8c7b-cfe10f8388a7@lunn.ch>
Feedback-ID: 198615653:user:proton
X-Pm-Message-ID: ea82292b0b8f9d1c857606b508c5949764e2d083
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296102-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[leo.moerlein@proton.me,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:hauke@hauke-m.de,m:linux@armlinux.org.uk,m:pabeni@redhat.com,m:buday.csaba@prolan.hu,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[proton.me:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leo.moerlein@proton.me,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:email,proton.me:mid,proton.me:from_mime,proton.me:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CDA764D4D3

On Thursday, May 21st, 2026 at 1:39 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> Can we take a step back, and look at your actual hardware. What is the
> state of the hardware when Linux boots, but before the MDIO bus is
> enumerated?
>
> Is the GPIO is configured as an input, and there is a resistor keeping
> the PHY out of reset?

I tried to check the state input/output state of the GPIO before the kernel
initializes it by using the GPIOD_ASIS flag.

Unfortunately, the xway pinctrl gpio driver does not seem to implement
get_direction() here:

https://elixir.bootlin.com/linux/v7.0.11/source/drivers/pinctrl/pinctrl-xwa=
y.c#L1352

Therefore, the only thing that I can tell is that the level of the gpio is
corresponding to "reset not asserted" before the kernel starts to initializ=
e
the GPIO and I could not get information if it is an input or output this
way.

> Maybe when we probe the PHY we need to ask the GPIO subsystem how the
> GPIO is configured. On unregistered of the PHY we need to put the GPIO
> back into that state?

I like the idea that our code should take the responsibility to bring
devices into a defined state that works for us irrespective of which the
state the hardware was left in before (by whoever).

Turning it into an output and controlling its level is the thing that=20
currently feels the most simple to me. Especially respecting the fact
that not every GPIO driver seems to allows to query it's full state.

I think, this also the direction in which Buday Csaba is arguing. I will
respond to his mail in a separate reply.

Cheers,
Leonardo


