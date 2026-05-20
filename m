Return-Path: <netdev+bounces-289769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOSFOXJPDWqgvwUAu9opvQ
	(envelope-from <netdev+bounces-289769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:06:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A04587FD5
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E043006B0F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16A8371D10;
	Wed, 20 May 2026 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="faxYt0CB"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230F342539
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257198; cv=none; b=NeyBv13GJu3Dl4xUD5+IJ+w99S0Jth++082c+6/YOc0CHHvYbKbcSNWc0kehFSHUvfcKKMyilldWheNgzgK3YB1rRwrTBNyX9rQKlAIG8OnC/KuEM8uUdL94d+XPGHZNi8A6pZ9BXNKJs4Cr+gFguIFRD6VicgZDPetAuaagifM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257198; c=relaxed/simple;
	bh=gaQlazosxXHrA3yo2ScSvrBe7V7+OuYpBAs+xjaLeyQ=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=H3uPOHEwEZV4/k0c8GFIYz1Ct1xhTir5qQ6SQt34B2QV+0o5fxonArGkiG+5CpEa+/XrvWKglsls04nUtRl8/Hgw162r85nl32S1AgHisMOH6AawiVP/OLr4y9JSR0oqPpb7q+kohO4nhJJAZT+daqriVy2+dmimCpLjXZ5ILdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=faxYt0CB; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779257193; x=1779861993;
	i=markus.stockhausen@gmx.de;
	bh=a4VCYkEXcj3rjOTmMOqJFGAkNsISOZX/nXo4avK0lyw=;
	h=X-UI-Sender-Class:From:To:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=faxYt0CBRRD8sHSsfWNbtaKjYwQIvVdatk3vgYNinmM4gMWjer8tW0m+QhVHl5PK
	 CrempoltXwDxhtP21qTIm+9F3Af9PUaCqYwFu8EbK6jpaTMzQrXklzhy0BVJ4dPHj
	 OHV8vcb8gXTzrbGkowqn5RxcahWs70dY9lpDMi3d74cCQtbaYc/BVHucEjLBJ5Mvq
	 4OzbLZYg1ZH7dOjbDqjKZy647LFpIWkwPt/MCX0r1u7XHVJfay7AZIfQr0yW0NvIk
	 lNxKqKjiA/dgaP0wXu+K3DHThCsYTFmyUXAhoLpPnZAHsrJDiUTPFN46yvMRMZa47
	 eGBnBN3rDfIvW732mQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1x5oVH3LUh-00erpc; Wed, 20
 May 2026 08:06:32 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Chris Packham'" <Chris.Packham@alliedtelesis.co.nz>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<daniel@makrotopia.org>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de> <31a47180-e0cc-4731-aca4-e5266aecb7a2@alliedtelesis.co.nz>
In-Reply-To: <31a47180-e0cc-4731-aca4-e5266aecb7a2@alliedtelesis.co.nz>
Subject: AW: [PATCH 0/9] mdio: realtek-rtl9300: Groundwork for multi SOC support
Date: Wed, 20 May 2026 08:06:26 +0200
Message-ID: <008201dce81e$ceeddbf0$6cc993d0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGwSt0WOf381P4OW8TiHCSlUsVjdQGkmkfQtmJ7GFA=
Content-Language: de
X-Provags-ID: V03:K1:6bXfRPeR74gNxjijNNFeCc27Dhwc7AfHQ4MAW+qB79LVbI59dk2
 AHVY2wMxfs+PW5ETxwynND8uORMy/8xFfaKWJkjIJThibGfZY9A2qM0j4QjKWPnOIhQsN2u
 3xkxWTQArOmT75tzz/Qph3cR6QuMa8w4/+reIguNRHZzTl4jU6blQF4OaaYyBRQfLAjF46x
 uTYcNfiqKI0EIEzVYSXyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TmAQC/2psZE=;1FxZ2UAzTxdYSL8BQaQK7Jw9+DT
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289769-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[alliedtelesis.co.nz,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,makrotopia.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmx.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmx.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:mid,gmx.de:dkim,marc.info:url]
X-Rspamd-Queue-Id: 44A04587FD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chris,

> Von: Chris Packham <Chris.Packham@alliedtelesis.co.nz>=20
> Gesendet: Mittwoch, 20. Mai 2026 04:05
> Betreff: Re: [PATCH 0/9] mdio: realtek-rtl9300: Groundwork for multi =
SOC support
> ...
> I see the MDIO(BUS,ADDR) -> PORT is still causing confusion. It is one =

> of the more annoying aspects of the hardware. The basic summary is the =

> hardware wants to own the PHYs but Linux wants to know about them too. =


Thanks fort he heavy lifting last year. As I was not involved I read =
through
all what happened. For me [1] sums it up nicely.

> The Realtek SDK bundles this all together with lots of tightly coupled =

> code oriented around switch ports. Linux wants PHYs and MACs to exist=20
> separately (IMHO this is the correct thing to do).  I don't know how =
the=20
> Realtek SDK would deal with exotic PHYs with specific requirements for =

> host/line side settings or non-PHY devices like we have with some DSA=20
> switches, I suspect it wouldn't

This tight coupling will kick in with future series. To make upstream
somehow production usable we need a place to at least

- setup port polling for ports that are not PHY but SerDes driven [2]
- classify port types [3]

So we must allow that the driver internally works on ports. And if we =
are=20
ok with this I want to remind of another challenge [4] that needs to be
solved.

Markus

[1] https://marc.info/?l=3Dlinux-netdev&m=3D174468002008100&w=3D2
[2] =
https://github.com/openwrt/openwrt/blob/d2fabb974c57cc96c12f783f2197cc263=
9e1ed5a/target/linux/realtek/files-6.18/drivers/net/mdio/mdio-realtek-ott=
o.c#L814
[3] =
https://github.com/openwrt/openwrt/blob/d2fabb974c57cc96c12f783f2197cc263=
9e1ed5a/target/linux/realtek/files-6.18/drivers/net/mdio/mdio-realtek-ott=
o.c#L793
[4] https://marc.info/?l=3Dlinux-netdev&m=3D176905734406837&w=3D2


