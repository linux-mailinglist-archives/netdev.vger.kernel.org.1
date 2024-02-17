Return-Path: <netdev+bounces-72654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6685F859167
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 18:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904D91C20CA9
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 17:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8A7D3F6;
	Sat, 17 Feb 2024 17:53:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B917CF1A
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708192384; cv=none; b=hByEE4zgR/8qzrvy4fTD/ww7cW/MWQewFwSpUCsvKx+UAWeekYTtmE6gddrA7lQRoPjwi+hh9aeEvcvN6EwVX57B01BGce3KNXvRA7zQ+o+RxUX4IOyJ8zPrANZoynJXHQi1BgNvQul4IrOD5ljKI9rMkds0zxof0ZbioKR3Xrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708192384; c=relaxed/simple;
	bh=lPVUgpDOU9vMuOOKO11RyMYbH09KmAlvytNh37qKcec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NjyiqLuC8sRI3jXCrtgMyF716p2IiuWx68ffW4ZFcGVYwCOJhTCZkvB1Bt9Du0QrepJzJRZZ434bShwKpwF1OQVG5RaqDImha5ycTKoailUP7clt5oQFkVbX6UMAtJkLvX4/CX9/Rmm1NQwatw3rNVNHL/Y1D+tTz9AmzEf9FJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-139-Mb2TighnPTCAwxvWNM6bnQ-1; Sat, 17 Feb 2024 17:51:23 +0000
X-MC-Unique: Mb2TighnPTCAwxvWNM6bnQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 17 Feb
 2024 17:51:01 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 17 Feb 2024 17:51:01 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Denis Kirjanov' <kirjanov@gmail.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Denis Kirjanov
	<dkirjanov@suse.de>
Subject: RE: [PATCH v3 iproute2] ifstat: convert sprintf to snprintf
Thread-Topic: [PATCH v3 iproute2] ifstat: convert sprintf to snprintf
Thread-Index: AQHaX0VrtUtuOJpIs0Oa5Ism5hp3qrEO1K6g
Date: Sat, 17 Feb 2024 17:51:01 +0000
Message-ID: <369729fa83564583acbb5c7903641867@AcuMS.aculab.com>
References: <20240214125659.2477-1-dkirjanov@suse.de>
In-Reply-To: <20240214125659.2477-1-dkirjanov@suse.de>
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

From: Denis Kirjanov
> Sent: 14 February 2024 12:57
>=20
> Use snprintf to print only valid data

... to avoid potentially overflowed the temporary buffer.

Also probably worth using scnprintf() to avoid another change
when snprintf() is removed (because the return value is dangerous).

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


