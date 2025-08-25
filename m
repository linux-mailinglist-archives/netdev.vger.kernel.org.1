Return-Path: <netdev+bounces-216438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0EAB339DB
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 10:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D9E16552D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385D729D283;
	Mon, 25 Aug 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1XR0yl1R"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89974D599;
	Mon, 25 Aug 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111672; cv=none; b=HrckrXeUep7HJ0scNO8yyk9QFrJKSFDz5Xge7zV7S70GdFbBDisObUlzZ20ynoVMiSr8ASsFaNNtlnJd1o/8a8ctUJsF87LliAZmWpcGkLBOTOvWoXP/JZfh3P2n8BrbrEs1GWHAJZ2P/hffHvAwSFUyG4Hu08ob34BzO2Dz1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111672; c=relaxed/simple;
	bh=6/zd2oe4tQuTmgARpJtHt62iSQycVM6PzrqxAZU4Reo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icack3vAvmnUkmtUVTuDHdFEz/HgUYQ1wfq/ByisYsHjv9TDkUGkPXgXEcsYhPmYRCePAEoVCCrd3Sfkuc+akk6RaGytU1H7YnG8C/x+RbKqcCVCcm8vGjDHNcWehXGrDRoHuJfhFZfcM7j9AWu4h2+8i41aNPbZfjF7NMmUym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1XR0yl1R; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8BDE21A0666;
	Mon, 25 Aug 2025 08:47:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A556605F1;
	Mon, 25 Aug 2025 08:47:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C45C01C22DBF3;
	Mon, 25 Aug 2025 10:47:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756111664; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6/zd2oe4tQuTmgARpJtHt62iSQycVM6PzrqxAZU4Reo=;
	b=1XR0yl1RAKAsVxzi15g6YD2g1MurVf5QJ2qUaQn4GgcT51s545puimGwSlrxTkhVYsJd21
	yN9HUMD0ioas3zw1ZGGzCA+1nEUobI+yNQaVpkhNP47OOudGFTccZeF+E7pV9PnJSaE91s
	DlrivWeiMNJAZE0eupdl2HOwnIoWJm67ijADF9CgxwnsYROCG8X67bivSJTbTZPDZ5rgh2
	/y2EhGdlca9H9vbdmIFlYJVVlt3U5we07LMDU8OUVufc/V/BF9PK2u8iLd0MY9J1th4DCA
	E4AIBBRcDkS6CT0NK1J+wftdiO3SL299+tgruvM30Wec0D4N7sgSV0U0tCvPZg==
Date: Mon, 25 Aug 2025 10:47:21 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, kernel@pengutronix.de, Dent Project
 <dentproject@linuxfoundation.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next 2/2] net: pse-pd: pd692x0: Add sysfs interface
 for configuration save/reset
Message-ID: <20250825104721.28f127a2@kmaincent-XPS-13-7390>
In-Reply-To: <d4bc2c95-7e25-4d76-994f-b68f1ead8119@lunn.ch>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
	<20250822-feature_poe_permanent_conf-v1-2-dcd41290254d@bootlin.com>
	<d4bc2c95-7e25-4d76-994f-b68f1ead8119@lunn.ch>
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

Hello Andrew,

Le Fri, 22 Aug 2025 19:17:55 +0200,
Andrew Lunn <andrew@lunn.ch> a =C3=A9crit :

> On Fri, Aug 22, 2025 at 05:37:02PM +0200, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Add sysfs attributes save_conf and reset_conf to enable userspace
> > management of the PSE's permanent configuration stored in EEPROM.
> >=20
> > The save_conf attribute allows saving the current configuration to
> > EEPROM by writing '1'. The reset_conf attribute restores factory
> > defaults and reinitializes the port matrix configuration. =20
>=20
> I'm not sure sysfs is the correct interface for this.
>=20
> Lets take a step back.
>=20
> I assume ethtool will report the correct state after a reboot when the
> EEPROM has content? The driver does not hold configuration state which
> cannot be represented in the EEPROM?

In fact I assumed it is an EEPROM but it is described as non volatile memory
so I don't know which type it is.

Yes ethtool report the current configuration which match the saved one if i=
t has
been saved before. No the driver doesn't hold any state that can not be
represented in the non-volatile memory.

> Is the EEPROM mandatory, or optional? Is it built into the controller?

It is built into the controller. It seem there are version of this
controller that does not support it : "This command is not supported by
PD69200M."

> How fast is it to store the settings?

2 i2c messages and a 50 ms wait as described in the datasheet.
=20
> I'm wondering if rather than having this sysfs parameter, you just
> store every configuration change? That could be more intuitive.

I have not thought of it. I don't know if it is a good idea. We may need
feedback from people that actually use PSE on field. Kyle any idea on this?
In any case we still need a way to reset the configuration through sysfs or
whatever other way.

> I've not looked at the sysfs documentation. Are there other examples
> of such a property?

Not sure for that particular save/reset configuration case.
Have you another implementation idea in mind?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

