Return-Path: <netdev+bounces-69854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B409E84CCC8
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89C31C25559
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D69A7E791;
	Wed,  7 Feb 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fw6WuOcu"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFABF374E0
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316310; cv=none; b=sI86AftqFK051wcXqajs3qhr/0DEUjXeetY2JvtU4ZUlWPdln8eZW1Ob3DJ/Wpf+AEinTUYxa0sbkARpZH9HoILOa8ZG0US79FmwqwkBfGEScj1Y/Cddye2DqnwAXui1dvNL6FFP/cnddHjAqNwu6fJ0oKhM9L78pNUFAfwZcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316310; c=relaxed/simple;
	bh=aIDKgHVlE62xv3WCnwOJ/N9CDtEKAfk6VOY0pgKBzzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNAPdgck41tzImzf8TKhfXvh9haVjNSnwmSDBI4obPY5oYaYCD4YUS53/syFG/QkD7PXWYyTX/XLAQLgzPnSV6S0rXelI3iLR0siRarFIsUyASVYhXBxGK7Kvw4+vXJDzr9hp72PJfNXF1N8AhQeP3YwIUdIXJAnzHyVO1/aPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fw6WuOcu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E14CD24000B;
	Wed,  7 Feb 2024 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707316299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y46VQEpUp9PGmEYBOoV/e0gsPjjWFVf/i7i6PVK9jeo=;
	b=fw6WuOcuFTEkYODnwdPSjYGu3tAcXWwxRiBIsM6K3LGuIKlOjO2R2BJ3GHKIVvUGH4+rZD
	tU7jSjdfns1rLVHh0hOWYjIDS52x8Hgpfag74ZPwoxK8DDku96AWEck6mPSpPCzvKL7ukQ
	3P/vfaHZjVitLqdpWDowXgHhs4fX+SU1OGxt59o+9Qj4EmomTi6wXTkpOoC11mZ9kLxV9r
	qteJ/aUjCn7O9g5SCOQnhwru9iklAs0exjDwoWrxYOibD6zlHTJUCYc2pKmQCKaHItCLdp
	uxvek0LDDTRCX96m9PQVJfbtp9IMF8JyRfO+ADF9wwYLnOliK6YBeecKnfsNHA==
Date: Wed, 7 Feb 2024 15:31:36 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Elad Nachman <enachman@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Taras Chornyi
 <taras.chornyi@plvision.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [EXT] Prestera driver fail to probe twice
Message-ID: <20240207153136.761ef376@kmaincent-XPS-13-7390>
In-Reply-To: <BN9PR18MB4251F1904C5C56381FE976C4DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240206165406.24008997@kmaincent-XPS-13-7390>
	<BN9PR18MB42519830967969DEA4E329EFDB462@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207112231.2d555d3e@kmaincent-XPS-13-7390>
	<BN9PR18MB42510F2EA6F4091E5CA3B409DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207122838.382fd1b2@kmaincent-XPS-13-7390>
	<BN9PR18MB4251F1904C5C56381FE976C4DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
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

On Wed, 7 Feb 2024 12:24:16 +0000
Elad Nachman <enachman@marvell.com> wrote:

> > -----Original Message-----
> > From: K=C3=B6ry Maincent <kory.maincent@bootlin.com>
> > Sent: Wednesday, February 7, 2024 1:29 PM
> > To: Elad Nachman <enachman@marvell.com>
> > Cc: netdev@vger.kernel.org; Taras Chornyi <taras.chornyi@plvision.eu>;
> > Thomas Petazzoni <thomas.petazzoni@bootlin.com>; Miquel Raynal
> > <miquel.raynal@bootlin.com>
> > Subject: Re: [EXT] Prestera driver fail to probe twice
> >=20
> > On Wed, 7 Feb 2024 10:56:29 +0000
> > Elad Nachman <enachman@marvell.com> wrote:
> >  =20
> > > > -----Original Message-----
> > > > From: K=C3=B6ry Maincent <kory.maincent@bootlin.com>
> > > > Sent: Wednesday, February 7, 2024 12:23 PM
> > > > To: Elad Nachman <enachman@marvell.com>
> > > > Cc: netdev@vger.kernel.org; Taras Chornyi
> > > > <taras.chornyi@plvision.eu>; Thomas Petazzoni
> > > > <thomas.petazzoni@bootlin.com>; Miquel Raynal
> > > > <miquel.raynal@bootlin.com>
> > > > Subject: Re: [EXT] Prestera driver fail to probe twice
> > > >
> > > > On Tue, 6 Feb 2024 18:30:33 +0000
> > > > Elad Nachman <enachman@marvell.com> wrote:
> > > > =20
> > > > > Sorry, that's not how this works.
> > > > >
> > > > > The firmware CPU loader will only reload if the firmware crashed =
or
> > > > > exit.
> > > > >
> > > > > Hence, insmod on the host side will fail, as the firmware side
> > > > > loader is not waiting For the host to send a new firmware, but
> > > > > first for the existing firmware to exit. =20
> > > >
> > > > With the current implementation we can't rmmod/insmod the driver.
> > > > Also, in case of deferring probe the same problem appears and the
> > > > driver will never probe. I don't think this is a good behavior.
> > > >
> > > > Isn't it possible to verify that the firmware has already been sent
> > > > and is working well at the probe time? Then we wouldn't try to flash
> > > > it. =20
> > >
> > > Everything is possible, but that is the way the firmware interface was
> > > initially designed. Changing this will break compatibility with board
> > > already deployed in the field. =20
> >=20
> > I don't understand, why fixing the probe by not flashing the firmware i=
f it
> > is already flashed, will break compatibility?
> > Do I miss something? =20
>=20
> First, firmware is loaded to RAM and not flashed.
> Second, there is a certain control loop which dictates when the firmware
> loader expects new firmware by ABI, and that can only happen when the
> previous firmware code has terminated.

I still don't understand why it will break the compatibility.
You never entered the second times probe as you would have faced this issue.

I haven't tested it yet but wouldn't this do the job:

--- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
@@ -457,16 +457,21 @@ static int prestera_fw_init(struct prestera_fw *fw)
        fw->dev.send_req =3D prestera_fw_send_req;
        fw->ldr_regs =3D fw->dev.ctl_regs;
=20
-       err =3D prestera_fw_load(fw);
-       if (err)
-               return err;
-
        err =3D prestera_fw_wait_reg32(fw, PRESTERA_FW_READY_REG,
                                     PRESTERA_FW_READY_MAGIC,
                                     PRESTERA_FW_READY_WAIT_MS);
        if (err) {
-               dev_err(fw->dev.dev, "FW failed to start\n");
-               return err;
+               err =3D prestera_fw_load(fw);
+               if (err)
+                       return err;
+
+               err =3D prestera_fw_wait_reg32(fw, PRESTERA_FW_READY_REG,
+                                            PRESTERA_FW_READY_MAGIC,
+                                            PRESTERA_FW_READY_WAIT_MS);
+               if (err) {
+                       dev_err(fw->dev.dev, "FW failed to start\n");
+                       return err;
+               }
        }


Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

