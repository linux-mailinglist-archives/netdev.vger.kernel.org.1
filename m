Return-Path: <netdev+bounces-286166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFbqFVUl/2lG2wAAu9opvQ
	(envelope-from <netdev+bounces-286166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 14:15:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC704FF8D0
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 14:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CC82300FEF9
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681E2346A07;
	Sat,  9 May 2026 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="AdW+ySo6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969A519E819
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778328913; cv=pass; b=Rqnt5yamCBz8EVi2gjOuTzlzzNPkOfScG/L3XbS37uLgweHtTlST8f7bNkGhovcMbgfPVv4SJFS67fMasIgEU+M9mRIEGYjHZGdwllHpvhtAaU9TdDsyvDAmX/cvZA0e1KSobIK0JzvpjYuZVbiBCejufycCm3KEUsQ8tcaMd6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778328913; c=relaxed/simple;
	bh=Itow17MzFukEt7ifHoaNsv4OPf3Ma4//CA5gLqy5YGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiRceKsXNdLZVcGHB/zdh38R2GqReNm+i4vWTFio1TXkyQ9l+a0apOjILtm0Miyl4zjgjnW9PB2HgP/tuOSgiq99uZdsJrJg46A/5ltSQ8/fvFOxRTwI3pXs9FIS1QMtrQ3sZeApqyFYEz+ahA1QB/eSFMDnqwZPBfhFIUo0vQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=AdW+ySo6; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so5017512a12.0
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 05:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778328910; cv=none;
        d=google.com; s=arc-20240605;
        b=Dm3uN3PvLNZhSsLBMFMeBtCxOS8Ba0Khz28jQKWZ+dpfX940S8ZnCzB9LCJyetg5sp
         qZtiE3WOV+nuLBXXboGiDBBNAQ4PtTpks+JE+K0QEduWepBdiOKyDjDd0NPJIs+bFSVb
         Ngp6z02Uc+0I3spi76dvyYmeYgLuHWYC+tVrY9TSuTJTlpAmUMbREYbAOkBoF01zerHj
         2yoW9i0J6225Himj0EPtFMwApllQ91alZw1vpF6+jerkJcZuBWudv9faIVrhbz/5R239
         TtjWa8L/EOveWeXD42ScmWwCgt+Fg7aW3Idl6EpRuX+pFAFI7Cq13ONI5qu2rmsUdBbn
         SalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Re63cumpinwgUi7Va5ZJHXAsgWoRotUfZvlC8g9cGW8=;
        fh=1ZEEO5G6mZ8gK07z6ooi1Sc6HkpRV5QeH+kV79O5ElI=;
        b=eJnvbDB5LcX1SCPWVwETk1l1IH6yo3AwnDo4iG3sTZJzIFVEMhjUaMkU0WZextBVos
         4NvQKxHuIOMGOcb9/+QvblqCtAGxQsrFRitNmTOvYZ3R1VKw+WUGPY8RjsTJHLsXq21H
         XmzMrO5xIaZH3rWrK6e1BH21LHMLUc/kFM033cRQiZ5/hEGhj+T1ugZo87p77jDM6+ID
         FLtYMPjv1eVNYMgZ7+LxOAT1FxVnRjBhlxQT+Mn9tgywnDqT/E4xHHk+JwvDfQ5V8wGV
         nZhztH+21mClwnPZj3OK2qqxD2ZTUuKo00p38wsHSnbyiBlGcZ3UMXSRQC9TFpkY+112
         CzfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1778328910; x=1778933710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re63cumpinwgUi7Va5ZJHXAsgWoRotUfZvlC8g9cGW8=;
        b=AdW+ySo6HUerOTjee6cOpeRICaSESANsZNgZH32ncr2XC+TqWSC45lYYzJzo03yXc6
         t8MsFCK7kuhjXfBtFdCJh7MnNTMdRv8FQAnBNDncc2e4YNnR1Vm5lZyj5i49P69tVK4x
         H1CYTtzFAxCl8tR4txYRBbHRdn9Dzrtl72lMucHE3aVm+ahyCnP8m+qqT84U1Od3VdPB
         jQ3guH6o56tRKT8MFLKIGuYWkRTzOuAJ84jN5dF3zUY10J3eB0lhS+eo96u68bN+FUAm
         f7pWgMz/3qg1IMYjNKZEkmgIMWWKbzUw8Pd+Hf2tWA+8tqpKGwnRJ3YByCfrociYtxUz
         ULRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778328910; x=1778933710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Re63cumpinwgUi7Va5ZJHXAsgWoRotUfZvlC8g9cGW8=;
        b=O+NchJ018enZt7M61aP2GB0KIN9NE7DloHdOQfA3pbeQTNUxzVk9VOuOX6EJddrBVV
         Xm5Aq4VzlLDbIPXkV6KDytKoWeSBMYlQXWhm2+AsWoQCQ4Cy8vaWjsEiMQLYwba0KVhi
         qiaKJU22DLkdaMnJVQn0YbfSu4Brcg/rOgSPIiImcn7zpyj9MRJocQseqDxEKWTapYYb
         DPhgN6FDkdvMmHx0Hd0QeMPPEyUsc7wFBKgr/Z3MawKgIR9Uy9lBOt5pzzWiJ1IMR5aw
         q0dFbhYnXzuATm0hqqaFb4XL66taig1nER+ry6VMmvDz4KhCxutAuu4BdZACWPzifE1f
         G3Rg==
X-Forwarded-Encrypted: i=1; AFNElJ/AknweBujwz66D+H5ubYw5KbZBE8feEh9F63j0VMQTYsKO0Wq/1+qhhZ7dyOyIwrYJkmgiXQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPENbeMjYmSJTGNEgHP2R7e9eQxIMI2+KMpMe7fw1UniCtkuU
	u26JkQd/wKpNZqMo6bR+wy58IyMucQw2vZQ7HCjW5xDVFwhBolEzv4UgTO+WrpvEsYypyfs5Wgg
	Ue5lWTM02TA9LFXoCTxcHThZ2sRJquBnFUe8CQ13AOQ==
X-Gm-Gg: Acq92OFp75waLIkwRY7ZfdI4VLwxAiDJtMEd6q6LvYlZ8ifYmnUMspfrqCY2dGv0223
	TKmMBNuO7XrHjWOM98dp1J9z1Pb15KglWr7sEK/myePge7piha0QU2dkgb0wbt1NIkFYZ5waJBv
	bMBK4pMsQh6seQkcfMTRLNLjBLVeG9LoPjaamD2BneIiz0qKNE6EVSF0ouSFX3SrVBV+L6w5vVp
	rd/0lQUbHrKGW4wDNrq+xzKc9JNrhjNX1s+5MZUY9BYrQXvRhpdQactBGrVlE4Y7dfCzfHgAuCy
	9+bArnXb6gt/QWke60wL8j4ZRB/uXDWdpxdwcwaQTlWTOQ/cEww3fCoe50HR3Q==
X-Received: by 2002:a05:6402:28c5:b0:672:c169:606a with SMTP id
 4fb4d7f45d1cf-67f718d8069mr970288a12.23.1778328909636; Sat, 09 May 2026
 05:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507104720.262641-1-robert.marko@sartura.hr>
 <20260507104720.262641-2-robert.marko@sartura.hr> <af3RiyMRM56b3DJM@pengutronix.de>
In-Reply-To: <af3RiyMRM56b3DJM@pengutronix.de>
From: Robert Marko <robert.marko@sartura.hr>
Date: Sat, 9 May 2026 14:14:58 +0200
X-Gm-Features: AVHnY4LMl0Qq0M5DdTOnDlRqvm30Pk81M5SDvEFE3NF8fMkUdJxNh9fk2GhKd4A
Message-ID: <CA+HBbNFwL+BsOoVpP4zTS14W2aZweiM1=52L8FTXxCBaiAGqXw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: pse-pd: pd692x0: support disabling
 disable ports GPIO
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kory.maincent@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AAC704FF8D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286166-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[sartura.hr:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sartura.hr:email,sartura.hr:url,sartura.hr:dkim]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 2:06=E2=80=AFPM Oleksij Rempel <o.rempel@pengutronix=
.de> wrote:
>
> On Thu, May 07, 2026 at 12:46:55PM +0200, Robert Marko wrote:
> > Microchip PSE controllers have a dedicated disable ports input that lik=
e it
> > name says disables PoE on all ports.
> >
> > So lets support parsing that GPIO and using the GPIO flags to set it to
> > output high by default and enable PoE on all ports during probe.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/net/pse-pd/pd692x0.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.=
c
> > index 44cf9f97be67..670656abd16f 100644
> > --- a/drivers/net/pse-pd/pd692x0.c
> > +++ b/drivers/net/pse-pd/pd692x0.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/delay.h>
> >  #include <linux/firmware.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/i2c.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -1781,6 +1782,7 @@ static int pd692x0_i2c_probe(struct i2c_client *c=
lient)
> >       static const char * const regulators[] =3D { "vdd", "vdda" };
> >       struct pd692x0_msg msg, buf =3D {0}, zero =3D {0};
> >       struct device *dev =3D &client->dev;
> > +     struct gpio_desc *disable_ports;
> >       struct pd692x0_msg_ver ver;
> >       struct pd692x0_priv *priv;
> >       struct fw_upload *fwl;
> > @@ -1808,6 +1810,11 @@ static int pd692x0_i2c_probe(struct i2c_client *=
client)
> >       priv->client =3D client;
> >       i2c_set_clientdata(client, priv);
> >
> > +     disable_ports =3D devm_gpiod_get_optional(dev, "disable-ports", G=
PIOD_OUT_HIGH);
>
> I guess this signal is active low. Since gpio framework operates with
> logical values, more natural would be here to use GPIOD_OUT_LOW to
> signal that disable-ports mode is disabled. And in the devicetree use
> GPIO_ACTIVE_LOW.

Yeah, you are correct, the signal is active LOW, I will update to your
suggestion in v2.

Regards,
Robert
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

