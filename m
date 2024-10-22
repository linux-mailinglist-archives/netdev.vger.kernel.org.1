Return-Path: <netdev+bounces-137897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49D19AB0B7
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37E71C20ABD
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6C719F424;
	Tue, 22 Oct 2024 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UNFI7uZZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4900B19DFB5
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606970; cv=none; b=W40adloQlHxiDz9MNnP9Gnl+bBClRQb6lqxSaSSB/8i0iHuriLw3QXxNNaKef9YHmiq7Dc7z4ewJJs8udWL9e7VxFHpzpZkBdbxH3OzRvcf+dNEpOSeTzD7vsz/d4jlsWaXzoV7qEZzzOLchPWAVW8rQmSLDg13vttva+SqPVC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606970; c=relaxed/simple;
	bh=WwoCZ5X1zwsoptZ1KZXHMR/BmT4oKY/vHDjW7LyRTKw=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LEQEnUuJ5CcqPA/NM/QcKFxHLW9wkzAhm7mlxFz0vDkM/QYq6aWI8pK3u6t+kP3RpVJtR2b/1/pAwWpOPPT2kw5Ue9OrZLlbWI9HCZesSRTvTOv8hT5xGpc81bI4nCzlfBc6em5QCbFPCPSII6g9Cxt1P4Xqfrg54f+zT+LI/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UNFI7uZZ; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729606969; x=1761142969;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=WwoCZ5X1zwsoptZ1KZXHMR/BmT4oKY/vHDjW7LyRTKw=;
  b=UNFI7uZZvm3oEFIsyn/hrjI6h3MC2YBPtqd7oH+k5F6gUuJrZss2GQ+h
   qYe0pvTa1OG3uKRMC+dm5suJ4k5bTQbcU+7U9Fe1v89EiTEOkICyJHpLb
   G/Hv7AvDL9CvVf9PyYOrOUDiby5eMNIjLSbrUvzhqH8AJoWK+F66eBxh8
   g=;
X-IronPort-AV: E=Sophos;i="6.11,223,1725321600"; 
   d="scan'208";a="442941800"
Subject: RE: [PATCH v1 net-next 1/3] net: ena: Add PHC support in the ENA driver
Thread-Topic: [PATCH v1 net-next 1/3] net: ena: Add PHC support in the ENA driver
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 14:22:43 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:62492]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.143:2525] with esmtp (Farcaster)
 id 6d516c9e-eaea-4b7b-8bfe-f14983496f48; Tue, 22 Oct 2024 14:22:31 +0000 (UTC)
X-Farcaster-Flow-ID: 6d516c9e-eaea-4b7b-8bfe-f14983496f48
Received: from EX19D010EUA004.ant.amazon.com (10.252.50.94) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 14:22:31 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D010EUA004.ant.amazon.com (10.252.50.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 14:22:30 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Tue, 22 Oct 2024 14:22:30 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Simon Horman <horms@kernel.org>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David"
	<dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky,
 Alexander" <matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson,
 Matt" <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara,
 Nafea" <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>
Thread-Index: AQHbI3jyHzM+s43mz0CcBaQPZI77TrKRaMWAgAFrxkA=
Date: Tue, 22 Oct 2024 14:22:30 +0000
Message-ID: <cd78a56636034961997214e418747d77@amazon.com>
References: <20241021052011.591-1-darinzon@amazon.com>
 <20241021052011.591-2-darinzon@amazon.com>
 <20241021163955.GL402847@kernel.org>
In-Reply-To: <20241021163955.GL402847@kernel.org>
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

> > The ENA driver will be extended to support the new PHC feature using
> > ptp_clock interface [1]. this will provide timestamp reference for
> > user space to allow measuring time offset between the PHC and the
> > system clock in order to achieve nanosecond accuracy.
> >
> > [1] - https://www.kernel.org/doc/html/latest/driver-api/ptp.html
> >
> > Signed-off-by: Amit Bernstein <amitbern@amazon.com>
> > Signed-off-by: David Arinzon <darinzon@amazon.com>
>=20
> Hi David,
>=20
> As it looks like there will be a v2 anyway, please consider running this =
series,
> and in particular this patch, through:
>=20
> ./scripts/checkpatch.pl --strict --max-line-length=3D80 --codespell
>=20
> And please fix warnings it emits where that can be done without reducing
> readability and clarity. E.g. please don't split string literals across m=
ore than
> one line just to make lines short.
>=20
> Thanks!

Thanks Simon,
We'll resolve the issues in the next patchset.

