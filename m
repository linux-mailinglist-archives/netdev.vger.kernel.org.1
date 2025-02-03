Return-Path: <netdev+bounces-162025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4008EA255EC
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAAD3A8981
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4581FF1DA;
	Mon,  3 Feb 2025 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="S5JZV9EH"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEB41D798E
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575086; cv=none; b=E2HuhedGpKjPwkm8dnikwAf45i07rAU9D5GJ7SBXHyEVMLMR6gwuprw1MZ8a0i91kXes5GEx/hczFROzWfsIVtnUR8obYWehXc3/emmQLyvd0FKHegt2YpjFblGzP5iZDzIDqUvcL6RQSIs3+WYKLcbIsvjyr2gbifIPURRdAeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575086; c=relaxed/simple;
	bh=LKHvK8tBLWF3KqdmMSzxHrTGl32JspvsZEbQUfAQOrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwKsdSJ1TVGbNCUxmAXW3o7H6+0MKoKoBM8es5nCPlqeV4zjvDINrsOCjTTEnId9+IqKiv7n0yvy+VBXwQhhoCUrt/RUivRmBxtT59hd5se0XqKwwbyw8Ao2lEou7rQ+o5CYjciuxwEBAteTBFbUd19M7ewcrvHyGFJ2Pl6Yce8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=S5JZV9EH; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CADBF10382D08;
	Mon,  3 Feb 2025 10:31:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738575076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=87iK9BHPnpQs+19NyAfODppPvRIOhut4EuEMpBR4aXE=;
	b=S5JZV9EH8hCsTrjV+C3HHny71/yKkt0FDC0BPa3LyJwH5nYDLtPh18olwCBEsukhybB9Tf
	I++pWmouzECsow2reauMG4j0LGFi4MiXQYN2reVoFEetbgkacsR6FqMuVhiTOAJ1vrU0rS
	wUIHx6EWQvpfvYoGS1fY+QJl4LaidddBlmvufkVV002m7k8ugzfRdVSjNY5A0fg8JgZQaR
	pc0cCXtQQOCZASKlaL4GvrzYBMyaRbNv4dZ+Pq5mLKLQ68S1hztPjrTps1Pale1bXihbMi
	SRKcu0hRePrM7d9GInTx2wgyJxGswSubgckIuCznh9G8h9x0SRNGnN8kZ/aYQA==
Date: Mon, 3 Feb 2025 10:31:13 +0100
From: Lukasz Majewski <lukma@denx.de>
To: <Woojung.Huh@microchip.com>
Cc: <frieder.schrempf@kontron.de>, <andrew@lunn.ch>,
 <netdev@vger.kernel.org>, <Tristram.Ha@microchip.com>
Subject: Re: KSZ9477 HSR Offloading
Message-ID: <20250203103113.27e3060a@wsk>
In-Reply-To: <BL0PR11MB29130BB177996C437F792106E7E92@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
 <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
 <20250129145845.3988cf04@wsk>
 <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
 <BL0PR11MB2913C7E1AE86A3A0EB12D0D7E7EE2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <1400a748-0de7-4093-a549-f07617e6ac51@kontron.de>
 <BL0PR11MB29130BB177996C437F792106E7E92@BL0PR11MB2913.namprd11.prod.outlook.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eFHq7k_Urgg_6hN.uzLOhvA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/eFHq7k_Urgg_6hN.uzLOhvA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Woojung,

> HI Frieder,
>=20
> Thanks for the link. I reminded the support team this ticket.
> Please wait response in the ticket. Hope we can get the solution for
> you.
>=20
> Thanks.
> Woojung
>=20
> > -----Original Message-----
> > From: Frieder Schrempf <frieder.schrempf@kontron.de>
> > Sent: Thursday, January 30, 2025 3:44 AM
> > To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>
> > Cc: andrew@lunn.ch; netdev@vger.kernel.org; lukma@denx.de; Tristram
> > Ha - C24268 <Tristram.Ha@microchip.com>
> > Subject: Re: KSZ9477 HSR Offloading
> >=20
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > Hi Woojung,
> >=20
> > On 29.01.25 7:57 PM, Woojung.Huh@microchip.com wrote: =20
> > > [Sie erhalten nicht h=C3=A4ufig E-Mails von woojung.huh@microchip.com.
> > > Weitere =20
> > Informationen, warum dies wichtig ist, finden Sie unter
> > https://aka.ms/LearnAboutSenderIdentification ] =20
> > >
> > > Hi Frieder,
> > >
> > > Can you please create a ticket at Microchip's site and share it
> > > with me? =20
> >=20
> > Sure, here is the link:
> > https://microchip.my.site.com/s/case/500V400000KQi1tIAD/

Is the link correct?

When I login into microchip.my.site.com I don't see this "case" created
for KSZ9477.

> >=20
> > Thanks
> > Frieder =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/eFHq7k_Urgg_6hN.uzLOhvA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmegjOEACgkQAR8vZIA0
zr3X2ggA4lLfyFvQ/2tFD5Mp1urmw1sAbQKReBzl19cIqT1p3rTrVL/WduJvxv3x
Cyox8CnyR8q4s1XJ0aEoYDClAGvuUiyNsF4hRYBzwYqOfXnN5uHaMwWvPT6bRCsv
El/3RFmT4WrBe1tH5qfZt1cJjyCdD0b5Ynbe2atbo8RKJaD/ZcSkFddcRU+ssZ53
eJzT4sAP4IT4/b0MweGYZh/aagei6C+YYV7dIn33NpXpM9lDuVLXAr3rT9EHX31U
rwzbKc9zUIbjadmYkrEPZVnOGti+ln9jJNTg/VyxSC/D55V86Wusecg4WovcmXjf
lphfK2SJ3VmOAMQb29rtURt7bwu+iQ==
=npFU
-----END PGP SIGNATURE-----

--Sig_/eFHq7k_Urgg_6hN.uzLOhvA--

