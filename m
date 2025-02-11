Return-Path: <netdev+bounces-165057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC03A303BF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 07:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196353A57F9
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 06:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7B1E6DCF;
	Tue, 11 Feb 2025 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LVV9yuvb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF6433BE
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739256093; cv=none; b=R4yg3tRtnGD+qsQKXWhH02rMUUG2wgN2GD0RD/PqiR3nN47DadHPvZqOkwBqXMe2cjdRBZPuDbGBaRW/SsukP7JfvjxeFmPAyEdlWdA7FTkdJ+XaO/uNxqwAkVaaUWjAIIIltG/TkjuPYV5sNEp75CC/1XZq6DugLmu0MeSBGsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739256093; c=relaxed/simple;
	bh=GyCUMivS4VJlWOBBze0/WQTviEBkzALAjaWeS3LlRMw=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ie3NFPbWb/Y6znYBT0vYlcodo7DEB35Px+da625a+AIlrYNBb6yKGCZuBv+k+AY3tfHHuHFxNrZA1+nlqe1lewPmMK83lfEFdMZqAa9vOTsctamzimK/a8GkRpMjyIv5qXYRPqoLAaOF7+Tdxe2N0n8VI3SMnVHPIZLzbHFbE9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LVV9yuvb; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739256092; x=1770792092;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=kgEZXMTyNo/0vBWc6Ot4NuneWyKQNfqazBxrkuQHgkY=;
  b=LVV9yuvbLSJXtSNxedGvG69ZAgXXDPdb8qwcbjxKqzzq/pVmXhxGpszw
   EuR67s1Oj5m9HQMHRCA0ehpuZz7q/tm7j6Y945iRiB4vAPtL+uwoB3xRk
   7ArACBhlSPpAKzlrtY2jYkOA5s0El5IBlf77Hp/t2ivR8OJtZLAul2oAz
   U=;
X-IronPort-AV: E=Sophos;i="6.13,276,1732579200"; 
   d="scan'208";a="171400092"
Subject: RE: [PATCH v6 net-next 3/4] net: ena: Add PHC documentation
Thread-Topic: [PATCH v6 net-next 3/4] net: ena: Add PHC documentation
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 06:41:29 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:57085]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.229:2525] with esmtp (Farcaster)
 id ed518b41-7f26-4356-870c-cd93c9d093c3; Tue, 11 Feb 2025 06:41:28 +0000 (UTC)
X-Farcaster-Flow-ID: ed518b41-7f26-4356-870c-cd93c9d093c3
Received: from EX19D002EUA002.ant.amazon.com (10.252.50.7) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 11 Feb 2025 06:41:28 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D002EUA002.ant.amazon.com (10.252.50.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Feb 2025 06:41:27 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.039; Tue, 11 Feb 2025 06:41:27 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.co.uk>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>
Thread-Index: AQHbeKGvfULVz4EhOUW1QOSyLY+8YrM8lvgAgAQX1OCAAJwCAIAAY1Ow
Date: Tue, 11 Feb 2025 06:41:27 +0000
Message-ID: <796881fe22cc4129b69eadad7ff37a8b@amazon.com>
References: <20250206141538.549-1-darinzon@amazon.com>
	<20250206141538.549-4-darinzon@amazon.com>
	<20250207165516.2f237586@kernel.org>
	<01fd0c4d50c7493986d80e22b0506fdf@amazon.com>
 <20250210164358.11091722@kernel.org>
In-Reply-To: <20250210164358.11091722@kernel.org>
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

> > You are right in the regard that it is not a network specific functiona=
lity.
> > Having said that, PHC is a network card capability, making it a network=
-
> related component rather than purely a timekeeping feature.
> > Moreover we failed to find an existing tool which would allow users to =
get
> valuable feedback of the system's overall health.
> >
> > Researching its existing support in the kernel we noted that:
> > - PHC is embedded in network NIC and is supported by multiple NIC
> > vendors in the kernel
> > - PHC information is visible through ethtool -T
> > - The Linux networking stack uses PHC for timekeeping as well as for pa=
cket
> timestamping (via SO_TIMESTAMPING).
> >   Packet timestamping statistics are available through ethtool
> > get_ts_stats hook
> >
> > We have found `ethtool -S` as a suitable location for exposing these
> statistics, which are unique to the ENA NIC.
> >
> > We'd appreciate your thoughts on the matter, is there an alternative to=
ol
> you can recommend?
>=20
> We try to steer folks towards read-only debugfs files for stuff that's no=
t
> strictly networking related. You also add a custom sysfs file in patch 4,=
 I
> reckon adding stats there may also be a natural place for the user?
>=20
> Patch 4 FWIW is lacking slightly in the justification, would be good to c=
larify
> why it's disabled by default. Single sentence of "why" would be great.

Hi Jakub,

Thank you for the feedback and the recommendations, we will incorporate the=
m in v7.

