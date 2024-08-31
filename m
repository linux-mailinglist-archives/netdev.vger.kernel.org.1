Return-Path: <netdev+bounces-123979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DA69671A0
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 14:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C5DB21E06
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DD0183092;
	Sat, 31 Aug 2024 12:50:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2F181B8D
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725108637; cv=none; b=ZMhHl6+Wgc1GVQWnCaCrZxdK+hl2Mq1FVti3vXjQRHDh3crZw/OAmNfBr+dzRIsZ0V5cJoHtnAZ24iHYo+Jh0qffOCBNtOLDRSrH6V71ygcrFNR1jSbQQ+I38bjeUJA0ypq1NYuN4Ss/CNt2FxqTPVw3IiLH/58o7uK1ijGBr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725108637; c=relaxed/simple;
	bh=bQ5Sxn7JI2RLIiAX6U8qpIddB2Lher9DRJKFxT7UoQQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Ca9r0FI1Sx1HCaJS81W0Vq16IBdceodopPssRGGq0rN0mosLLOcKtlkljp7NrTKYxmW4QyEJHJ3digJsojHST4ZMAadeKnZ0ncLD0Xcda7V3Jpsisejkc+/Eugd3vRJZlhNvwA3LPu3AVFWPhuTrqu01xyUjTRNMjK9jShkEOKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-81-zQruYB7rPfiFBNlQ0B6Bhw-1; Sat, 31 Aug 2024 13:50:31 +0100
X-MC-Unique: zQruYB7rPfiFBNlQ0B6Bhw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 31 Aug
 2024 13:49:47 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 31 Aug 2024 13:49:47 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jakub Kicinski' <kuba@kernel.org>, Yan Zhen <yanzhen@vivo.com>
CC: "louis.peens@corigine.com" <louis.peens@corigine.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"oss-drivers@corigine.com" <oss-drivers@corigine.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel@vivo.vom" <opensource.kernel@vivo.vom>
Subject: RE: [PATCH v1] netronome: nfp: Use min macro
Thread-Topic: [PATCH v1] netronome: nfp: Use min macro
Thread-Index: AQHa+Iy7z9qF71A5HUm0+tauGhvQX7JBVuZQ
Date: Sat, 31 Aug 2024 12:49:47 +0000
Message-ID: <151a6133edc74d07a4488cdd83090d1a@AcuMS.aculab.com>
References: <20240827084005.3815912-1-yanzhen@vivo.com>
 <20240827072423.4540bed6@kernel.org>
In-Reply-To: <20240827072423.4540bed6@kernel.org>
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

From: Jakub Kicinski
> Sent: 27 August 2024 15:24
>=20
> On Tue, 27 Aug 2024 16:40:05 +0800 Yan Zhen wrote:
> > Using min macro not only makes the code more concise and readable
> > but also improves efficiency sometimes.
>=20
> The code is fine, you're making it worse.
>=20
> How many of those pointless min()/max() conversions do you have
> for drivers/net ?

Maybe someone who understands cochineal should change the pattern
so that is require one of the 'arguments' to be non-trivial.
(or perhaps just delete the script ;-)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


