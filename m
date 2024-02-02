Return-Path: <netdev+bounces-68436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EFC846F04
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E831B1C22FCF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D080977F06;
	Fri,  2 Feb 2024 11:33:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41D608FD
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873607; cv=none; b=JC0/KFWB6BN9TbcUmxD+CfSq9mU5sTEOFBpbqbCNzViPFAq2kPc+jyifq0e3h1ymdpZOtnoxLm/7e5nsnSGxdHWW1vuDvk1P7blxo2PymMU8LoQcvMmIxT+fgHNE9kg6+ZLgXqBC3v+arsHdLVIh4I5mr5WB4fJFQnkYZ3S4IB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873607; c=relaxed/simple;
	bh=wW6lfN8HR2B8NpHoZpBkDisaNmnR9DyltLZdkKz2E5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=CFh4zjbxGdFnf/RtiwUjXoWIOdxPaZHywPT4xOA43PPXfd7oMMU70MLnv34My2Ce7sll9/NqnU3oTNTUsw8gk8rPJGsZVEEL3Xt7PCqGUgtoBY+7X6bLAiSlWk8yCp1wsRhgxeBkq+JEm8yQ+3mI65fVMBAaQ429MeM+4Jz3A2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-83-vmDr5qu_Ms-jG3ywkU9u7g-1; Fri, 02 Feb 2024 11:33:17 +0000
X-MC-Unique: vmDr5qu_Ms-jG3ywkU9u7g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 2 Feb
 2024 11:32:57 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 2 Feb 2024 11:32:57 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Stephen Hemminger' <stephen@networkplumber.org>, Denis Kirjanov
	<kirjanov@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Denis Kirjanov
	<dkirjanov@suse.de>
Subject: RE: [PATCH iproute2] ifstat: convert sprintf to snprintf
Thread-Topic: [PATCH iproute2] ifstat: convert sprintf to snprintf
Thread-Index: AQHaVGCdMUuLtnf3K0G1n1AQJlh+tLD27kCA
Date: Fri, 2 Feb 2024 11:32:57 +0000
Message-ID: <913e0c6bb6114fdfaa74073fc8b6c2ee@AcuMS.aculab.com>
References: <20240131124107.1428-1-dkirjanov@suse.de>
 <20240131081418.72770d85@hermes.local>
In-Reply-To: <20240131081418.72770d85@hermes.local>
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

From: Stephen Hemminger
> Sent: 31 January 2024 16:14

>=20
> On Wed, 31 Jan 2024 07:41:07 -0500
> Denis Kirjanov <kirjanov@gmail.com> wrote:
>=20
> > @@ -893,7 +893,7 @@ int main(int argc, char *argv[])
> >
> >  =09sun.sun_family =3D AF_UNIX;
> >  =09sun.sun_path[0] =3D 0;
> > -=09sprintf(sun.sun_path+1, "ifstat%d", getuid());
> > +=09snprintf(sun.sun_path+1, sizeof(sun.sun_path), "ifstat%d", getuid()=
);
>=20
> If you are changing the line, please add spaces around plus sign

Isn't the size also wrong - needs a matching '- 1'.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


