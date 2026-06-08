Return-Path: <netdev+bounces-296544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MmMwN2q/JmoKcQIAu9opvQ
	(envelope-from <netdev+bounces-296544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:11:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D43656786
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:11:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=IIweEAdI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296544-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296544-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6666C302B764
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E822DCF61;
	Mon,  8 Jun 2026 13:04:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FAA2DC79B;
	Mon,  8 Jun 2026 13:04:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923856; cv=none; b=atq4L9ojfsTwMRjhlgN/pZ3cabUAm1p2rUmFkViAKdThoTidXcI4OQzw36bU2VGIkl7815oRXGcn9j06eGmLRjndGBvaSO6e4Jovboo6w3d7RzAH5rVZQB2K2UvNwPJa6HTBvGxhjd2mu4Dva9Xh8SazBkW2IqpGmukA51jaJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923856; c=relaxed/simple;
	bh=qXUg+nteWtBPUnVYVPWZBMAvhYW+7GCoSCkc3vpztYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFVd0pJVuwIddAXPtEfF1OXvX9oyXaWxQY2OQ5MCmbEd9bngHtig/pEYZiyltEtIeqqqaW5W7j1U9VyKvcc6ftCleZ1xWu7WHnxE1irVqQgug9DW1iU3WFz2aFI0utE2MBIOhsPbvrh/+iqOxPrrxOkqD6af9CLpsR8GplJoFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IIweEAdI; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 680444E414F7;
	Mon,  8 Jun 2026 13:04:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 34E965FFB7;
	Mon,  8 Jun 2026 13:04:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 167E7106A2897;
	Mon,  8 Jun 2026 15:04:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780923847; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=l8wOaZQWYEt9bY1fDzjXvlREIzzrPGWG25SfEY5AtJs=;
	b=IIweEAdIqYEWu3IRmRy+Sn4cKgSnOn6lIS8EiTlvuKm+Jl3Q8CJBFuMeZhGBAIRYVdio1h
	3fVkai8XOPK0x98GlR8VlCiH5LW0p+ZRqgACGxqmzEvRuU3O3+66v00SvyO/dWsP4/8FDN
	iTDA7Oy2JMttiW214KEq3OwbyoAYV8a0dGD5GlwrU9BfiTsemYDQGjafKy0aLENRfnDheL
	eTHAFEGQRcP5l04MmP6pIB8+hZatTERQIek/weLSwqkZDc3gWHXPGmwazZF6gO+MF1iSkV
	ZBIWB0RfEr+9CCFIVYX/UkSpEAECGjUkJgK+JowYQ7dUVg5guvZn0FDmSJN73w==
Date: Mon, 8 Jun 2026 15:04:02 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Robert Marko <robert.marko@sartura.hr>
Cc: o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.machon@microchip.com, luka.perkov@sartura.hr
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd:
 microchip,pd692x0: add port disable GPIO
Message-ID: <20260608150402.5dec0207@kmaincent-XPS-13-7390>
In-Reply-To: <20260607165600.1260210-1-robert.marko@sartura.hr>
References: <20260607165600.1260210-1-robert.marko@sartura.hr>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296544-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robert.marko@sartura.hr,m:o.rempel@pengutronix.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel.machon@microchip.com,m:luka.perkov@sartura.hr,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:url,bootlin.com:from_mime,bootlin.com:email,sartura.hr:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7D43656786

On Sun,  7 Jun 2026 18:55:35 +0200
Robert Marko <robert.marko@sartura.hr> wrote:

> Microchip PSE controllers have a dedicated port disable input that like it
> name suggest, will disable PoE on all ports.
>=20
> So, lets document that GPIO.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

