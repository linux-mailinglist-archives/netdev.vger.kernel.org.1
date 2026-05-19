Return-Path: <netdev+bounces-289608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCIFLE7KDGrAlwUAu9opvQ
	(envelope-from <netdev+bounces-289608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:38:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 336A1584C77
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C1523021E9E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E293BE62B;
	Tue, 19 May 2026 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="KvL6wvdS"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511773BD64B
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223031; cv=none; b=A3SnzmuHjejjU/4k4BVOFUiilLFY4YfppDW6PewNwYN4i++WOaXnadWktvqbBe4iVqLkSAyK45svMh2N6YCCCmn7X1HeedhbTnrkZq6Rf8uVVSOxgeMIBXZMIWISNj/C20tQvaRj+94xfAz3MTlTgQQqFa7deKRosKdRs37s7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223031; c=relaxed/simple;
	bh=++6l4/MOfpepqkuAKGlt1vChSnRG5vlYMqm5hm5AOAU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=tykjJTz4llSVuPmDfn4zX7+40hIzxXwBO2qANoqRPEfqxKLIGxsXghlSUjbMC3Bu5s6UZSkFGTLZHUjuphoTNJxjC0YsazFNdMAM+NxvbJoxzF0US6Y+h9/9y2m7ADw+YhxYlEYUfqIMo61+Srj4+mUNgu7x75syyb1cKsOU2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=KvL6wvdS; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779223004; x=1779827804;
	i=markus.stockhausen@gmx.de;
	bh=++6l4/MOfpepqkuAKGlt1vChSnRG5vlYMqm5hm5AOAU=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KvL6wvdSaZ2YIKbGJkg8DkzvXCP4Vv/uzbdFmwqQmRhg9zeet8fes6e7c7dkRI40
	 LV/hhGLqc5zN3Ds4raYoW2ZVQ+457fKbXVjKIJNLoh1JFfYR13pnB5Uk6hzc3w0Ex
	 19QmUaopJU/oTrFIOzFsTGrZsQhIfJOzmkvpqn4yLbpOmGuWq7JIvo5PQBEUsNvAp
	 KRBSRsSvxveL2fCf9xxXjLGzGj///YWHfZPdxZYANRBuUhkm1Je6RB2q63fMiALAo
	 aeooundjP+ArJTL+wVOoVZIudLd0expotVyOLap37jUhTMy1GUWYkuGHlcIQfJ/ks
	 gPKFlgqeo1ZdX45uiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf078-1x1G1x3B2A-00qEFU; Tue, 19
 May 2026 22:36:43 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: "'Daniel Golle'" <daniel@makrotopia.org>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de> <20260519165747.1288903-4-markus.stockhausen@gmx.de> <agydm8V25M-jy5o6@makrotopia.org> <85d5f162-8999-43d4-b879-6e5e686246f7@lunn.ch> <01d801dce7c2$a0a08ba0$e1e1a2e0$@gmx.de> <fff19211-a41a-481d-a6a6-4429a6901129@lunn.ch>
In-Reply-To: <fff19211-a41a-481d-a6a6-4429a6901129@lunn.ch>
Subject: AW: [PATCH 3/9] net: mdio: realtek-rtl9300: Add ports to info structure
Date: Tue, 19 May 2026 22:36:34 +0200
Message-ID: <029f01dce7cf$34595af0$9d0c10d0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGwSt0WOf381P4OW8TiHCSlUsVjdQM24EKZAmkhHfYC6BYN1wKAihL1Abxy/sq2CNpx4A==
Content-Language: de
X-Provags-ID: V03:K1:9JO8EY0HRHQ7a/fRUOVZW4gGnUIRjFBSxiSnR4TCY7yTd/IG7uG
 x/KPmcyHKkfA29ilYGpxAELYg5MFiwyAQYb+q3XSLxbEnOjXDAuUvFjKyVM34xncr/nRP7h
 L8gEj0LHqBYNvAk6SUi4AzI6NKniZZk+CDP4qJC1a2yaVVrYMjmwtw1bBdQyoplmCzHklLA
 WqekBtduz6kUKjizKXWnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vteIKZ2JZu0=;V0bPKqXhpApaGKZfvW57dXAGxjD
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289608-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[makrotopia.org,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmx.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmx.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 336A1584C77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Dienstag, 19. Mai 2026 22:14
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH 3/9] net: mdio: realtek-rtl9300: Add ports to info
structure
> .
> > Where does this come from?
> >=20
> > - The hardware has 1-4 SMI busses
> > - Each bus serves up to 32 addresses
> > - A switch has X physical ports
> > - The mdio controller can only be fed with "physical port"
>
> So in general, the MDIO API uses an address in the range 0-31, as
> defined in C22/C45. I would try to do any sort of mapping of ports to
> MDIO addresses in a layer above MDIO. Maybe that is not possible, i
> only partially remember the discussion about this hardware. But if it
> is going to get more complex, i really would suggest pulling it out
> into a layer above, and let the MDIO driver simply do MDIO.

Having spent a few months to get all this sorted out I can
say that the port concept is quite easy to understand and
is already quite simple implemented. One only needs to know=20
the chain

bus/address -> port -> bus/address=20

Current upstream codes uses 220 lines of code for only one=20
target. Downstream serves 4 devices with same quality and
error handling with the following metrics:

- 80 lines of code for central command runner
- 160 lines for all 16 SOC specific read/read_c45/write/write_c45 function=
s
- 80 lines of code for 4 generic command feeder functions

I finally want to add myself as maintainer for the driver.
Just in case that helps for the descision. =20

Markus


