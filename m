Return-Path: <netdev+bounces-98438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42218D16EE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D914E1C2200B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9E213CA8C;
	Tue, 28 May 2024 09:09:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCB58AB4
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887375; cv=none; b=ZgK+1UdDWd6FLQjQCyD/wD8wa+ft3THchWf9ouIJRX9fmX4/db0S5twi4EnM1JKsmrzGXdWfAxqjDQMXHbcbL65MVhIGB0LEORNwUmkIX3SvH2mvFufmOXwl6TAMTZcISA5GH6A4eLdHxErk0v2FNLdrgtAtiUEv9YylHUH1DJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887375; c=relaxed/simple;
	bh=Dr1plMUq5SgjOG7qrt2sIx2BmogjkjMwKC+p5yj89Bs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VEfW5HH1+vWMqOmz45kbdH1dmgRslVmejavG7IARW0TKEPPczEz/qWrlmLamEnzUOQJLDM/x8t5TpKugWbrQtd3S/ksgth8Ndq1ZrcJDQ1z+RPSQtghSF0q7Qedx9d8weqGslSwZhUnBW24DeWOuocNZoGCXax9iBUJveVoJ7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-78-mjR8z24COTGZ-4NyVWXsmg-1; Tue, 28 May 2024 10:08:14 +0100
X-MC-Unique: mjR8z24COTGZ-4NyVWXsmg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 28 May
 2024 10:07:42 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 28 May 2024 10:07:42 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Sirius' <sirius@trudheim.com>, Gedalya <gedalya@gedalya.net>
CC: Dragan Simic <dsimic@manjaro.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: iproute2: color output should assume dark background
Thread-Topic: iproute2: color output should assume dark background
Thread-Index: AQHarRQG3CtEVsT2WEiJhmhC0DtZ4bGsYfMA
Date: Tue, 28 May 2024 09:07:42 +0000
Message-ID: <9e1badfc5d3d47afbdd362c9e6faa01b@AcuMS.aculab.com>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <Zk9CehhJvVINJmAz@photonic.trudheim.com>
In-Reply-To: <Zk9CehhJvVINJmAz@photonic.trudheim.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Sirius
> Sent: 23 May 2024 14:20

>=20
> In days of yore (Thu, 23 May 2024), Gedalya thus quoth:
> > Yes, echo -ne '\e]11;?\a' works on _some_ (libvte-based) terminals but =
not
> > all. And a core networking utility should be allowed to focus on, ehhm,
> > networking rather than oddities of a myriad terminals.
>=20
> Then it perhaps should not add colour to the output in the first place an=
d
> focus solely on the networking.
>=20
> A suggestion would be the iproute2 package revert the option to compile
> colourised output as default, sticking to plain text output as that
> require zero assumptions about the user terminal. Carry on offering the
> '-c' switch to enable it at runtime.

+42 :-)

An alias in .profile can add -c - leaving it easy to turn off.
Especially for those of us who get fed up of garish colours.
gdb is pretty impossible to use these days - blue on black ???
Syntax colouring in vi make the code look like paint has been
spilt on the page - wouldn't be too bad if it was subtle (and correct).

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


