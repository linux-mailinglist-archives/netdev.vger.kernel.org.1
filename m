Return-Path: <netdev+bounces-69784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B526684C99B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B0B1F23817
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 11:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2FF18EBF;
	Wed,  7 Feb 2024 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DNRweZIG"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC17C1D528
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305331; cv=none; b=Q0UseAoYiwhiz/UYzkcetmfGTN3oz4Es88SRCks2sCJfv1NAPEGzQ2Zri2wnTaVOrv3+A8Di73a65RPxNcrSsWXoKZcUZE1UENFa19I+37LaXLYjLIPMmvXcse2Heh34eKzmgM3YJ+UOkQTOUv58azdR3lDefeZ8OYRbxfYWAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305331; c=relaxed/simple;
	bh=C5DvaEHoSMeatRly/COi+FQoLDKQbAo0pRsQb7xxJvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3291BLJab3tXxR+x1C9I2DyXZWYEHc+79eV/uQQXAglcBIG3o4TLJ9NTfjdgp9aN0lyZm1IblA4IL8OUCodc4XeUkKE7vLS5+0Mrh+ZHkh1Yp5mNZ6TSjhfvuvGSkl0NjILxsCEHEQ/4svnnCd9+Ya5s55L0gkAvhM7vjDEStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DNRweZIG; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BCD10E0006;
	Wed,  7 Feb 2024 11:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707305320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQJ6PmALTBQ2hfZPUY+Q2vI8lvfYCzJAB5/EoBmMYAs=;
	b=DNRweZIGDGK5HQ9TQWm0GWx/c6UqssGmxtxOK63Yr5rX/PpoiKKhevmJ0bE8iS44QK49de
	CWRiPPA5yFK2/fgvdhcXjFr/dzKTKPYEPVexeyOzYzz46tcwuVNJ5FKdDQjX9trv+iZSaU
	F6kTcTB2RsB5k9E1MhrSIlnVJ3yY4dblLZlckwg6T0/BpcF+T7ekUgrYeRV2w/5iVwYDbo
	i5MtqObFFS+XeLnSa+q4L2/rq/QfoSzNilUyy3YwX8PKIkHnrt983MsAQy6tzn6D+NrJWm
	b8XE9CUM2yAXBGgADszBUJo8AU70HKscH41iQrla6IWj2ZzdzhC8vxJ3II5SoA==
Date: Wed, 7 Feb 2024 12:28:38 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Elad Nachman <enachman@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Taras Chornyi
 <taras.chornyi@plvision.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [EXT] Prestera driver fail to probe twice
Message-ID: <20240207122838.382fd1b2@kmaincent-XPS-13-7390>
In-Reply-To: <BN9PR18MB42510F2EA6F4091E5CA3B409DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240206165406.24008997@kmaincent-XPS-13-7390>
	<BN9PR18MB42519830967969DEA4E329EFDB462@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207112231.2d555d3e@kmaincent-XPS-13-7390>
	<BN9PR18MB42510F2EA6F4091E5CA3B409DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 7 Feb 2024 10:56:29 +0000
Elad Nachman <enachman@marvell.com> wrote:

> > -----Original Message-----
> > From: K=C3=B6ry Maincent <kory.maincent@bootlin.com>
> > Sent: Wednesday, February 7, 2024 12:23 PM
> > To: Elad Nachman <enachman@marvell.com>
> > Cc: netdev@vger.kernel.org; Taras Chornyi <taras.chornyi@plvision.eu>;
> > Thomas Petazzoni <thomas.petazzoni@bootlin.com>; Miquel Raynal
> > <miquel.raynal@bootlin.com>
> > Subject: Re: [EXT] Prestera driver fail to probe twice
> >=20
> > On Tue, 6 Feb 2024 18:30:33 +0000
> > Elad Nachman <enachman@marvell.com> wrote:
> >  =20
> > > Sorry, that's not how this works.
> > >
> > > The firmware CPU loader will only reload if the firmware crashed or e=
xit.
> > >
> > > Hence, insmod on the host side will fail, as the firmware side loader
> > > is not waiting For the host to send a new firmware, but first for the
> > > existing firmware to exit. =20
> >=20
> > With the current implementation we can't rmmod/insmod the driver.
> > Also, in case of deferring probe the same problem appears and the driver
> > will never probe. I don't think this is a good behavior.
> >=20
> > Isn't it possible to verify that the firmware has already been sent and=
 is
> > working well at the probe time? Then we wouldn't try to flash it. =20
>=20
> Everything is possible, but that is the way the firmware interface was
> initially designed. Changing this will break compatibility with board alr=
eady
> deployed in the field.

I don't understand, why fixing the probe by not flashing the firmware if it=
 is
already flashed, will break compatibility?
Do I miss something?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

