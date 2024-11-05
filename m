Return-Path: <netdev+bounces-141928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFDC9BCB07
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0091C228E2
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855591D2B2A;
	Tue,  5 Nov 2024 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rLdW60+Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D581D2B10
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803939; cv=none; b=JoDYla8tka1BI0QbjcIgTCVmNd2oxEsLKcv2D3ZeLrTRH/iAZvXPq9soS90y2kGrsjNM7riMssZOwziyk5dV5cVMC8l6vRrAZ9lxPQD4NwiAujyYimopgznEhuVnAcD6WevlVT5Kd229Jiq13u88mBJunbGi63yY3kty4dovVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803939; c=relaxed/simple;
	bh=uml3xT/cjeVSPzvxexKI/qaBi8SixCmb2Ve5D/8yXR8=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K+CfSYY1T6ZYin0edhpBh6lyQMkLgDdFlfSHyzMcPvirfuw7o/2qFDHbV8GGRTfQIwpHJtYf5UccsFDvVDAZkB3QA8jNXIqkd4OAlWlunXQeKEA+TFaSC/+hi1m3Q39MJi4v0Gq62dDQlyTDILqF5ltVQDeDHllyh/PP8GvXNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rLdW60+Z; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730803938; x=1762339938;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=xhR7ux1wmpnHKWclBW6duwopiMa6fnkVnyjftSayO9g=;
  b=rLdW60+Zq7K8KOcBtmjT5YamU2aJDehGTOcCILvlDiiHGqTu6EOy/LZ5
   jC4lRYw4tq4bFOeu6lgnIsyW0bhLde0kHm5mZYBakK8JWucxoXLqYFOHW
   dni2m5/QSGG4avbkoIRjKWRRo7l7xXfkWf3OmiMtoSGjVX81+tfygT7ma
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,259,1725321600"; 
   d="scan'208";a="245006104"
Subject: RE: [PATCH v3 net-next 3/3] net: ena: Add PHC documentation
Thread-Topic: [PATCH v3 net-next 3/3] net: ena: Add PHC documentation
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:52:15 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:28521]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.104:2525] with esmtp (Farcaster)
 id f894540c-d86f-4262-aa9d-634e0e257781; Tue, 5 Nov 2024 10:52:13 +0000 (UTC)
X-Farcaster-Flow-ID: f894540c-d86f-4262-aa9d-634e0e257781
Received: from EX19D010EUA002.ant.amazon.com (10.252.50.108) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 10:52:13 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D010EUA002.ant.amazon.com (10.252.50.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 10:52:13 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Tue, 5 Nov 2024 10:52:12 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Woodhouse,
 David" <dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Agroskin,
 Shay" <shayagr@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
	<ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>
Thread-Index: AQHbLeQGl7kxu2fA00SYfY6yxcXfg7Kn9ekAgABNu5A=
Date: Tue, 5 Nov 2024 10:52:12 +0000
Message-ID: <4ce957d04f6048f9bf607826e9e0be5b@amazon.com>
References: <20241103113140.275-1-darinzon@amazon.com>
	<20241103113140.275-4-darinzon@amazon.com>
 <20241104181722.4ee86665@kernel.org>
In-Reply-To: <20241104181722.4ee86665@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > +**phc_cnt**         Number of successful retrieved timestamps (below
> expire timeout).
> > +**phc_exp**         Number of expired retrieved timestamps (above
> expire timeout).
> > +**phc_skp**         Number of skipped get time attempts (during block
> period).
> > +**phc_err**         Number of failed get time attempts (entering into =
block
> state).
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>=20
> I seem to recall we had an unpleasant conversation about using standard
> stats recently. Please tell me where you looked to check if Linux has sta=
ndard
> stats for packet timestamping. We need to add the right info there.
> --
> pw-bot: cr

Hi Jakub,

Just wanted to clarify that this feature and the associated documentation a=
re specifically intended for reading a HW timestamp,
not for TX/RX packet timestamping.
We reviewed similar drivers that support HW timestamping via `gettime64` an=
d `gettimex64` APIs,
and we couldn't identify any that capture or report statistics related to r=
eading a HW timestamp.
Let us know if further details would be helpful.


