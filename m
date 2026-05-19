Return-Path: <netdev+bounces-289588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGp2FfG0DGrClAUAu9opvQ
	(envelope-from <netdev+bounces-289588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:07:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 605AC584036
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66D29300A5A9
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BD33DB30B;
	Tue, 19 May 2026 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="e/BXyjqE"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810631F99D
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217642; cv=none; b=YZ52Lm92Fk4Tx8eZc8nsTIZjTS90j7pZqNs2hd04osXy+qkJyxnHcbJjEhAepIOFQBT4WbpQR5mHc2USToCHxkn8PA57++bTCpC7u1Aa20OPIcJxHzsPVozDZq1/FJqu48aWiUVtzHKsqCrxWy05sIYyLvsIk7MzxgeIkKsbdSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217642; c=relaxed/simple;
	bh=BeF+AdnuO+tMYqYKwmN6er2YevgBEm4OVZlnK3A92DQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=YHWghY050Hyy4gNrnkj6au1WLrxHNAfwgM8vgz0zmqiLgJhxlC1AlZZIM6zutniY1LtGWeYW5uIaSqcoamBRy7aY8oCdSZJMtWKlD9kO+xo/eMcLOdSubbgeq3/y9U3Gq2QEu02XtMa6qN9VIm8gG//hNT/6LVj9USJf4eOEBU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=e/BXyjqE; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779217602; x=1779822402;
	i=markus.stockhausen@gmx.de;
	bh=BeF+AdnuO+tMYqYKwmN6er2YevgBEm4OVZlnK3A92DQ=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=e/BXyjqEQUXkEKQurQvQ9NOZBM/HXHokoVS7F8wLieeb65wQek3kP2XJ0Or/MumR
	 AlTI05UjsA60bXZdy5li6me89DpPPSd4OaG/RSlP4/vcHt/aZnxkrxc4/4QDgqIUR
	 CJ/qojDykCig+U46Prk15/hov7hAS7prljiqXmZkdiEfvFGo1MN2Lwg8fCDQJVQ0K
	 tjoUhh8Cl4SnRwng9VlJmr5sJo1ZkCPNlepJJZ2/oNsVySCiYp6OgH1wY2J0v9wxd
	 f+aw3cw5szbw9DCldcKnnItQD95zCEf7DCHmSxZUi7JyzKdAnrd8rV4ocqIJhaPuh
	 t6g48DfDwRu1Xuz8tg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VHG-1xReOJ3uLS-010UFO; Tue, 19
 May 2026 21:06:42 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>,
	"'Daniel Golle'" <daniel@makrotopia.org>
Cc: <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de> <20260519165747.1288903-4-markus.stockhausen@gmx.de> <agydm8V25M-jy5o6@makrotopia.org> <85d5f162-8999-43d4-b879-6e5e686246f7@lunn.ch>
In-Reply-To: <85d5f162-8999-43d4-b879-6e5e686246f7@lunn.ch>
Subject: AW: [PATCH 3/9] net: mdio: realtek-rtl9300: Add ports to info structure
Date: Tue, 19 May 2026 21:06:30 +0200
Message-ID: <01d801dce7c2$a0a08ba0$e1e1a2e0$@gmx.de>
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
Thread-Index: AQGwSt0WOf381P4OW8TiHCSlUsVjdQM24EKZAmkhHfYC6BYN17YqoP0Q
Content-Language: de
X-Provags-ID: V03:K1:hyz7lJMRAWfBYEtV0aEu2lJgDv8uSluQKLSb+D3Uy64BmaYx1jZ
 mK+1A64vycDjdujmhYLWAoYllDiwsOFvQIW+x+K2WFRMV2tDGt0s5O0ZwRIxE4QOyAZq7cA
 473oJrUKfgWi0S5g6OlwyFcZzcxhoDx3Yc14vOvepxqlIXNlLAKtyfJNzOTs83tu0xEY6TC
 rLog+XaaI8wYJ5Hu+SsAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m1QpAOFyCqk=;dv04L2yoUUMK+qF7l1hyaD3bWei
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289588-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmx.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmx.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:email,gmx.de:mid,gmx.de:dkim,bootlin.com:url]
X-Rspamd-Queue-Id: 605AC584036
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Dienstag, 19. Mai 2026 20:00
> An: Daniel Golle <daniel@makrotopia.org>
> Betreff: Re: [PATCH 3/9] net: mdio: realtek-rtl9300: Add ports to info
structure
>
> On Tue, May 19, 2026 at 06:27:55PM +0100, Daniel Golle wrote:
> > On Tue, May 19, 2026 at 06:57:41PM +0200, Markus Stockhausen wrote:
> > > Each Realtek SOC series has different number of MDIO ports.
> >=20
> > I don't think the term "MDIO ports" describes it well.
> >=20
> > I'd say "switch ports", also because RTL9300_NUM_PORTS includes ports
> > used for SFP+ cages which aren't going to be (directly) associated
> > with any MDIO-connected PHY at all.
>
> Hi Markus
>
> It would be good to take a step back and explain the concepts here in
> the commit message. An MDIO bus as 32 addresses, as defined by
> 802.3. Why do we need the concept of a port when we have addresses?
>
> Once you explain the concept, we can maybe suggest a better name. Or
> throw the whole concept out because it is not needed.

I'm just trying to give the properties in the info structure the right=20
name that resembles its function. The driver already builds upon
the "port" naming.

Where does this come from?

- The hardware has 1-4 SMI busses
- Each bus serves up to 32 addresses
- A switch has X physical ports
- The mdio controller can only be fed with "physical port"

To make this work:

- port->bus/address hardware mapping registers are set up. [1]
- Driver exposes bus/address to kernel as usual
- During access driver converts bus/address to port [2]
- Driver issues command towards hardware via port
- Hardware maps that back to bus/address

So basically the driver needs an "port-like-index" for all
its operations. Looking at the initial PR history [2] I assume
this design was already hard enough to implement.

Markus

[1]
https://elixir.bootlin.com/linux/v6.18.1/source/drivers/net/mdio/mdio-real=
te
k-rtl9300.c#L319=20
[2]
https://elixir.bootlin.com/linux/v6.18.1/source/drivers/net/mdio/mdio-real=
te
k-rtl9300.c#L66
[3] https://marc.info/?l=3Dlinux-netdev&w=3D2&r=3D3&s=3Dadd+rtl9300+mdio+d=
river&q=3Db




