Return-Path: <netdev+bounces-133106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54AA994CB4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197B81C2160B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A471DF964;
	Tue,  8 Oct 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HYbN/Mop"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785A1DE8A0;
	Tue,  8 Oct 2024 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392189; cv=none; b=HhHn6FD86bCyHstMv56fv8Ps5u40rFBnr6VoDYdYqSRdhJam1PHP1PhD4+ykyAc9rnp2semtEcFSO2B/Lmz69/tbkaMWaYylwtcidc74iSipVEL8pyItsAFcwr7B9hPBP640hMavLZOCQUBIIdGmG/bqjft1OH+papH1vGZzpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392189; c=relaxed/simple;
	bh=BJav8e+HcALTipfP/NLFD+NrSKZ2vTYocgEXeZdKx3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ip1kDDi/L0rv6OigBmMm43RUaq5JASD3HBW1p5a2VgMjEKU1qxnCXSukZlEPYAo9dfhA03nxVAEHeQ3XhTeE9ro6rGV+q+c6iGpQF/sJPBdPlm8qYrZ31svLuiuGvrFHJZbY5DmE6TU+0A7JMt7Msf2QRQp15MJCxOVJNI0Ivho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HYbN/Mop; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D32820005;
	Tue,  8 Oct 2024 12:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728392179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJav8e+HcALTipfP/NLFD+NrSKZ2vTYocgEXeZdKx3U=;
	b=HYbN/MopgVOwhbm94jUtKR3niX7PPJ0/GQfIoI5KcrRc2eZol/OFPY1TA73qzramgLsS3p
	JP5MG9rDv7jGu+/P7YaUR+k/ic65bSoML8+JuAb/XseyWvn3PxviiV0jiWtuEIli7TU5mG
	MRKaWOxmRhm/9ntz1Lz2/+zBB0Pimfoj3DzE62zoHRujPUS2HNB3NOSTsns37kCy5okXI4
	Cn/jEQ+qDCz5i7Kr+1IgNSJJUY+eQqnhjeenc2i6lR7MZ2meX5u7NrzAp2DNfqw7wOPt37
	yiy8RE424U7Db1AqAluXZdNzlUohnQ8zD6TmnazEjLdHf350OCwOrkK16XkeiA==
Date: Tue, 8 Oct 2024 14:56:17 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next 06/12] net: ethtool: Add PSE new port priority
 support feature
Message-ID: <20241008145617.23254843@kmaincent-XPS-13-7390>
In-Reply-To: <20241008122300.37c77493@kmaincent-XPS-13-7390>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-6-787054f74ed5@bootlin.com>
	<ZwDcHCr1aXeGWXIh@pengutronix.de>
	<20241007113026.39c4a8c2@kmaincent-XPS-13-7390>
	<ZwPr2chTq4sX_I_b@pengutronix.de>
	<20241008122300.37c77493@kmaincent-XPS-13-7390>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 8 Oct 2024 12:23:00 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Mon, 7 Oct 2024 16:10:33 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>=20
> > User will not understand why devices fail to provide enough power by
> > attaching two device to one domain and not failing by attaching to
> > different domains. Except we provide this information to the user space.
>=20
> What you are explaining seems neat on the paper but I don't know the best=
 way
> to implement it. It needs more brainstorming.

Is it ok for you if we go further with this patch series and continue talki=
ng
about PSE power domain alongside?
It should not be necessary to be supported with port priority as the two PSE
supported controller can behave autonomously on a power domain.
I hope I will have time in the project to add its support when we will have=
 a
more precise idea of how.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

