Return-Path: <netdev+bounces-72336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6D68579B2
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 11:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4BA28B6F2
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3681BF5C;
	Fri, 16 Feb 2024 09:59:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC901CA86
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077540; cv=none; b=CqSCqxKc4f6j4WTtS+S1CLl5dimBeuKRcANiqK9t9u0ib59aNu9MJxNe62d8zD4PoAnZN2jV2zdKPOfqo2/kNtfmzWG5D+GefW+oqp9fIpFOL8n9axmyiazNC4LUkftIPdHHHY/j62crpXd6P8+MyzOct0/Vzns7Mf/05nRPAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077540; c=relaxed/simple;
	bh=uyJHS2n1btZzZ2kRdyRyPgT3Vn71RCfcjqFxRArcEZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=TG3Qack4NBH+NcVRuR+fQGvD9/mdIvOrH6pr4BH1H226+xoiTBSt9IiynX/hUGev7XVdiXXhsAPYLKhbJ9Jkuy259UUeHBz85Kkos1O8P7cocAkmiIPpblRM8KWI1nTrHMBRUEjNfjyb6J7wrH/M/Wm4ziBf1O4PKC7JnKGbRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-66-cudMmRfIPyiKRZbCmGEt2Q-1; Fri, 16 Feb 2024 09:58:42 +0000
X-MC-Unique: cudMmRfIPyiKRZbCmGEt2Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 16 Feb
 2024 09:58:21 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 16 Feb 2024 09:58:21 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Stephen Hemminger' <stephen@networkplumber.org>, Hangbin Liu
	<liuhangbin@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>
Subject: RE: [PATCH iproute2] tc: u32: check return value from snprintf
Thread-Topic: [PATCH iproute2] tc: u32: check return value from snprintf
Thread-Index: AQHaXdSDeqhOhdCKpU6C+J1fTxlVKbEMv3Pg
Date: Fri, 16 Feb 2024 09:58:21 +0000
Message-ID: <28c9af6b1ddf4664bbfed973e2f01874@AcuMS.aculab.com>
References: <20240211010441.8262-1-stephen@networkplumber.org>
	<ZcnHwRCr6s3T8VXt@Laptop-X1> <20240212085358.22be1db6@hermes.local>
In-Reply-To: <20240212085358.22be1db6@hermes.local>
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

From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 12 February 2024 16:54
>=20
> On Mon, 12 Feb 2024 15:24:49 +0800
> Hangbin Liu <liuhangbin@gmail.com> wrote:
>=20
> > On Sat, Feb 10, 2024 at 05:04:23PM -0800, Stephen Hemminger wrote:
> > > Add assertion to check for case of snprintf failing (bad format?)
> > > or buffer getting full.
> > >
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> >
> > Hi Stephen,
> >
> > Is there a bug report or something else that we only do the assertion
> > for tc/f_u32.c?
> >
> > Thanks
> > Hangbin
>=20
> No bug, it is not possible to trigger with current code.
> Return of < 0 only happens with improper format string,
> and the overrun would only happen if buffer was not big enough
> The bsize is SPRINT_BUF() which is 64 bytes.
>=20
> It is more a way to avoid some code checker complaining in future.

What are you testing?
If you are testing snprintf() then maybe a check for <0 is sane.
But otherwise it is a waste of time.

FWIW do you know what (any) printf() function should return for (eg):
=09int len =3D MAXINT;
=09len =3D snprintf(NULL, 0, "%*s %*s", len, "abcd", len, "1234");

My brain doesn't think that a 'bad format' generates -1.
You can get -1 from fprintf() (if a write() fails) which largely
means that code looking at the result of fprintf() is broken.
(You need to do fflush() and ferror() if you want to know
if a write failed, and you can't reliably assume it is the
length.)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


