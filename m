Return-Path: <netdev+bounces-164796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D63A2F1B5
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED8D1695D1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA81F24BCE7;
	Mon, 10 Feb 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OIM6JWM+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248EF24BCE9
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201306; cv=none; b=kHLqsBj8W2FLmfmAA2EWepppva5a8iPQzi7gNd4JFnlNHqmbsQGfSgKrRYmTGf+aCzb6jWT6SkmJ/D32i87UebWyM1Rb4UtnzI1rw7mBN4TVFO2yFly5N3RGoOPqOd7+fKVawHm0+5YOOAT5PRAWX0+GwvacB7cjUUaIwdMV5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201306; c=relaxed/simple;
	bh=KTvu/WLUY1wWydIbUxAjoabwotyRkj5g16IaOCiVabg=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RvvCFMST9Cdizd4wEH0XNxnpvSsira1NXsNxL2ewvAwpCgS8SxaMF13sIq7Zw9cURoMw6EpsGdulMGXDNnhNsOfM+qVKgfg/sB+/1QfUD3xI9svsvPWk7Iv6D85uByVmpGb69IKznG3PJdh9dz8l7urQ6EZZkvAnbfb+oR4Gews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OIM6JWM+; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739201305; x=1770737305;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=FEAWD9VqmJlFXns1jyJrqSgPl3VeodqYoxpMajs4K28=;
  b=OIM6JWM+VFNe1Jyz4nwsPvZK7o0rf5m0VHLCvhE+rFmiPZwyjKN5u+tu
   W1u7tmMpBe7m3nQ+rij97VnwyhCsS+461vwZhQqGYlT879LkvRgE3BpPp
   H6fRF8YNO2SfJuVl0FUQdiXHanklIaHPnlVF8E48qdyLzsFoffFVGBZFj
   c=;
X-IronPort-AV: E=Sophos;i="6.13,274,1732579200"; 
   d="scan'208";a="376063862"
Subject: RE: [PATCH v6 net-next 3/4] net: ena: Add PHC documentation
Thread-Topic: [PATCH v6 net-next 3/4] net: ena: Add PHC documentation
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 15:28:22 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:24065]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.94:2525] with esmtp (Farcaster)
 id 53306492-e9fc-41c4-aa27-479caa606007; Mon, 10 Feb 2025 15:28:20 +0000 (UTC)
X-Farcaster-Flow-ID: 53306492-e9fc-41c4-aa27-479caa606007
Received: from EX19D004EUA002.ant.amazon.com (10.252.50.81) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 15:28:20 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D004EUA002.ant.amazon.com (10.252.50.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 15:28:20 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.039; Mon, 10 Feb 2025 15:28:20 +0000
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
Thread-Index: AQHbeKGvfULVz4EhOUW1QOSyLY+8YrM8lvgAgAQX1OA=
Date: Mon, 10 Feb 2025 15:28:19 +0000
Message-ID: <01fd0c4d50c7493986d80e22b0506fdf@amazon.com>
References: <20250206141538.549-1-darinzon@amazon.com>
	<20250206141538.549-4-darinzon@amazon.com>
 <20250207165516.2f237586@kernel.org>
In-Reply-To: <20250207165516.2f237586@kernel.org>
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

> > +PHC can be monitored using :code:`ethtool -S` counters:
> > +
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
> ethtool -S is for networking counters.
> --
> pw-bot: cr

Hi Jakub,

You are right in the regard that it is not a network specific functionality=
.
Having said that, PHC is a network card capability, making it a network-rel=
ated component rather than purely a timekeeping feature.
Moreover we failed to find an existing tool which would allow users to get =
valuable feedback of the system's overall health.

Researching its existing support in the kernel we noted that:
- PHC is embedded in network NIC and is supported by multiple NIC vendors i=
n the kernel
- PHC information is visible through ethtool -T
- The Linux networking stack uses PHC for timekeeping as well as for packet=
 timestamping (via SO_TIMESTAMPING).
  Packet timestamping statistics are available through ethtool get_ts_stats=
 hook

We have found `ethtool -S` as a suitable location for exposing these statis=
tics, which are unique to the ENA NIC.

We'd appreciate your thoughts on the matter, is there an alternative tool y=
ou can recommend?

