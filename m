Return-Path: <netdev+bounces-156189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59646A056D2
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA5E7A048D
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 09:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A201F1307;
	Wed,  8 Jan 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QlSr/Pwe"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE781F3D44;
	Wed,  8 Jan 2025 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736328469; cv=none; b=ZgXJvVwuehFOpNmTgNwM9ckNQHLWJcja9LLZIpkJXMDZXTtq3BSmCXMjuis+VJc/p/y0N3Z2a8tyQU5FnMONBhR29P5RBJjMIjhmbnG0HoiZUHdrWVE/wY8U0APe9/DvEkwPwU53otNSX54zKHuw4kbJtbUmYEUsA018SsD7lDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736328469; c=relaxed/simple;
	bh=pZcomBhouJ6VQhmjOkFoQEEpsMzyj4813Muh63AfX3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lo28cEPO+xxXBTrbVCcRP1mLrNrkxvv0E3El85KwzkhAlHJSz3n+mvsddWDUaneM3Xqrasdtv1HbVIxqcB2fc2sLI046CYZ14IAPna5iScja12BLCuHjVmR5jIITsIXTLwCcitIgc0T+cZDkB+wiIHjFqdki7cdjCbtcmooj/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QlSr/Pwe; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15BE320013;
	Wed,  8 Jan 2025 09:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736328458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIMizEF5YyjKGwtlZmSN2471pQGraK5/jtwuwDcwDhU=;
	b=QlSr/PweXuIEagPCUwDMcl+mKP/uyK4bAfpQ0MKy4VQgPm8sICU1F7zhxxRtnILO3anhVy
	COSnMHf9sPkz4rnZy87Ou6CtH27B2m1IDtpggenJFuFLXaVA8Stei+YhXl7Sy7B6TuNcL8
	S+biocYmLiyi0QT4aUe9ieZdswYiaEhjlgg1qxJfkxEOUEMOCBZci1bCHZdRkeCBv7PqE3
	D9iZlkklgaBpncL+/kQk4CKNgUwyK+i/FSRhW0EgYbf3edk8KohowLlfVLy7YmIcTPQZPv
	8+tmjUaqHESpi7z2Ty15u1LcFwhWAZpbsl5Lr6TnUdOAcCv8eAoJAQcJY71dHQ==
Date: Wed, 8 Jan 2025 10:27:36 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 08/14] net: pse-pd: Split ethtool_get_status
 into multiple callbacks
Message-ID: <20250108102736.18c8a58f@kmaincent-XPS-13-7390>
In-Reply-To: <20250107171554.742dcf59@kernel.org>
References: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
	<20250104-b4-feature_poe_arrange-v1-8-92f804bd74ed@bootlin.com>
	<20250107171554.742dcf59@kernel.org>
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

On Tue, 7 Jan 2025 17:15:54 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sat, 04 Jan 2025 23:27:33 +0100 Kory Maincent wrote:
> > diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> > index f711bfd75c4d..2bdf7e72ee50 100644
> > --- a/include/linux/ethtool.h
> > +++ b/include/linux/ethtool.h
> > @@ -1323,4 +1323,40 @@ struct ethtool_c33_pse_pw_limit_range {
> >  	u32 min;
> >  	u32 max;
> >  };
> > +
> > +/**
> > + * struct ethtool_pse_control_status - PSE control/channel status.
> > + *
> > + * @podl_admin_state: operational state of the PoDL PSE
> > + *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
> > + * @podl_pw_status: power detection status of the PoDL PSE.
> > + *	IEEE 802.3-2018 30.15.1.1.3 aPoDLPSEPowerDetectionStatus:
> > + * @c33_admin_state: operational state of the PSE
> > + *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
> > + * @c33_pw_status: power detection status of the PSE.
> > + *	IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus:
> > + * @c33_pw_class: detected class of a powered PD
> > + *	IEEE 802.3-2022 30.9.1.1.8 aPSEPowerClassification
> > + * @c33_actual_pw: power currently delivered by the PSE in mW
> > + *	IEEE 802.3-2022 30.9.1.1.23 aPSEActualPower
> > + * @c33_ext_state_info: extended state information of the PSE
> > + * @c33_avail_pw_limit: available power limit of the PSE in mW
> > + *	IEEE 802.3-2022 145.2.5.4 pse_avail_pwr
> > + * @c33_pw_limit_ranges: supported power limit configuration range. The
> > driver
> > + *	is in charge of the memory allocation
> > + * @c33_pw_limit_nb_ranges: number of supported power limit configurat=
ion
> > + *	ranges
> > + */ =20
>=20
> Is there a reason this is defined in ethtool.h?

I moved in to ethtool because the PSE drivers does not need it anymore.
I can keep it in pse.h.

> I have a weak preference towards keeping it in pse-pd/pse.h
> since touching ethtool.h rebuilds bulk of networking code.
> From that perspective it's also suboptimal that pse-pd/pse.h
> pulls in ethtool.h.

Do you prefer the other way around, ethtool.h pulls in pse.h?
Several structure are used in ethtool, PSE core and even drivers at the same
time so I don't have much choice. Or, is it preferable to add a new header?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

