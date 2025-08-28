Return-Path: <netdev+bounces-217750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B546AB39B8B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753B43B8396
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DBA30DD29;
	Thu, 28 Aug 2025 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oOdUFrwu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2AE4A23;
	Thu, 28 Aug 2025 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380581; cv=none; b=Pw9W3rlsC09kwkiq9gRMko+QK41Lv0grHbwjCLTbI3y1EcDpdixu+VttTIWSFWZCimVTMhWgOSuOlxhAuRoKyc0vrUN4j2ADabLzTqhPFL3kg+hCHOwiPbvRSPa4JxEdInsnAPRf3N2NjWqkG4YBvnUGzajMQcmHREuxiyB5/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380581; c=relaxed/simple;
	bh=Pv4VUj2wCBMAgw+seqfZfk8iWIB5devyBITIfTLkAGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diIPYVn81f0LkKvVJ08P+H20MlV5iKRAKBBujGeFFHtsMKYGFXI5Z3gtSoiCNkwGhOsHiTzQkeug2wQC9Rvy/wLHhPeT31xQqsXbqjj+73VQ0MzSUHja3LvlsNi6TBv2TTAR4Aw1YFRLfkc6CvPhNS+fPTdNcExllhZHxXTvA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oOdUFrwu; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7E020C6B397;
	Thu, 28 Aug 2025 11:29:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0FB160303;
	Thu, 28 Aug 2025 11:29:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EACF1C22D47B;
	Thu, 28 Aug 2025 13:29:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756380575; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xIuFPPUPrhl7PDL7/YYcz0kAtKYrnGmWBaCnz+SNmuA=;
	b=oOdUFrwu0m0fCoJ78R0uL1f7cVi72EWzN/otA12gto72L1Or2uvDZd6YMYUlPKMEbeKYf/
	0r94bWFMUVGRDAiEzP21WGc1rnpQJZilv9fIHZ5Mj2Wo+1MhYhIx0eZexgM6IAwOYv1Cwm
	bQ5LvYA6umVggCh0CJtPcd7tLLSRYDyYgD4HNCQctv0a+GDs89ho4xmKaZL7DxlWaj/jt0
	a8r98lV4tXu1yDFkVH5LAwZ6UA21760MQ/9MZ71liSktcHVHaH4patR6sDUyus7aHKhQds
	FfWkInat1anW/sEDKNaz5KTPfmBQY6Ub33C5OWO021zIYQHG1IcB7zqxR0jaAg==
Date: Thu, 28 Aug 2025 13:29:01 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, kernel@pengutronix.de, Dent Project
 <dentproject@linuxfoundation.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next 2/2] net: pse-pd: pd692x0: Add sysfs interface
 for configuration save/reset
Message-ID: <20250828132901.76e00334@kmaincent-XPS-13-7390>
In-Reply-To: <20250825151422.4cd1ea72@kernel.org>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
	<20250822-feature_poe_permanent_conf-v1-2-dcd41290254d@bootlin.com>
	<d4bc2c95-7e25-4d76-994f-b68f1ead8119@lunn.ch>
	<20250825104721.28f127a2@kmaincent-XPS-13-7390>
	<aKwpW-c-nZidEBe0@pengutronix.de>
	<6317ad1e-7507-4a61-92d0-865c52736b1a@lunn.ch>
	<20250825151422.4cd1ea72@kernel.org>
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

Le Mon, 25 Aug 2025 15:14:22 -0700,
Jakub Kicinski <kuba@kernel.org> a =C3=A9crit :

> On Mon, 25 Aug 2025 14:18:25 +0200 Andrew Lunn wrote:
> > On Mon, Aug 25, 2025 at 11:14:03AM +0200, Oleksij Rempel wrote: =20
> > > On Mon, Aug 25, 2025 at 10:47:21AM +0200, Kory Maincent wrote:   =20
>  [...] =20
>  [...] =20
> > >=20
> > > My personal preference would be to use devlink (netlink based)
> > > interface.   =20
> >=20
> > Yes, devlink also crossed my mind, probably devlink params. Although
> > saving the current configuration to non-volatile memory is more a meta
> > parameter. =20
>=20
> This is a bit of a perennial topic. Most datacenter NIC vendors have=20
> a way to save link settings and alike to flash. None bothered with
> adding upstream APIs tho. If the configs are fully within ethtool
> I think we should be able to add an ethtool header flag that says=20
> "this config request is to be written to flash". And vice versa=20
> (get should read from flash)?

In fact there is the managers power budget parameter taken from the devicet=
ree
which is not in ethtool config. It could be reconfigured after each reboot =
or
conf reset but it is an example of non ethtool configuration and more could
appear in the future. Talking about perennial, ethtool is then maybe not a =
good
idea because we still will need a way to save these new global configuratio=
ns
saved to the non-volatile mem.
I am not really familiar with devlink but indeed after a quick look devlink
seems more suitable for the PSE global configurations.
I don't really know if we should use devlink param and devlink reload or on=
ly
devlink param or a new devlink conf.

Or we could save the configuration on every change but it will bring 70ms (=
I2C
read/write + store waiting time) latency for every command.

> Resetting would work either via devlink reload, or ethtool --reset,
> don't think we even need any API addition there.

Is there no way for NIC to reset their configuration except through ethtool
reload?

PS: got a client mail issue so you might have receive two mails. Sorry for =
that.
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

