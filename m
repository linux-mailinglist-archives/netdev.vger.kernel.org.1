Return-Path: <netdev+bounces-172020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E6A4FEFF
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7C91885EAE
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F3D2441A0;
	Wed,  5 Mar 2025 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FR+UF7HQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D32813633F
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179021; cv=none; b=QtHjB/LLNVXAkWxSUqqAAj8MYeP90ub0L+NgII2SkytP7LEEtNvlWC31PkuBeMegnknxjRhI7MNF79gbrLamVFGzqoiFNNIDPkqpxAmYKTJlAK6f3LWSpxjQ81pvDGd04QTgghLs/x0MJVd4bM8Gu9E22S28Pj33BMVfQwnocBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179021; c=relaxed/simple;
	bh=zNwyls7hnRzCGrgw8LUSVsIQC0m9mT8/7moNhs4Kq3s=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CTf6Vvx6S+1XGHHhEWDJGVVvSGvwotLfdqhEhoUNNiMakqQBDcxyN4c71ffs3e5lSjchdepAll2FQKnJe8JS+jnaBuTXfoHiwzMc8w8RafJVeaJKk0DyfcbV11eaufVqHi45jir3/MxCiTF7lBUE9f3uPg/wlah+0yNp8iMq8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FR+UF7HQ; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741179017; x=1772715017;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=SsHT4lPrSn/PiKBlUYw2BqwKfos2DXy3sIj+3B4Qg4I=;
  b=FR+UF7HQ2a6DpNh3vePsRugrw+LJLFxqIzv0uOMMfYTKdRdiO3WVDLch
   B9ImKTlWjHphxHq9PWSi5Orsn++vj5Fp7KUe0fW1bWDXIqKOrN+qY7XbE
   GHtiNyDYUmU8sUR00Dh0ZWvXCH7pWe8A3G6OXIdOA/R2pFUlbX8lFNZKp
   s=;
X-IronPort-AV: E=Sophos;i="6.14,223,1736812800"; 
   d="scan'208";a="472257039"
Subject: RE: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Thread-Topic: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 12:50:13 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:28590]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.0.98:2525] with esmtp (Farcaster)
 id 3e1c7510-2127-4301-84bf-4e50ba8ca3e6; Wed, 5 Mar 2025 12:50:12 +0000 (UTC)
X-Farcaster-Flow-ID: 3e1c7510-2127-4301-84bf-4e50ba8ca3e6
Received: from EX19D004EUA001.ant.amazon.com (10.252.50.27) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 5 Mar 2025 12:50:12 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D004EUA001.ant.amazon.com (10.252.50.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 5 Mar 2025 12:50:11 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Wed, 5 Mar 2025 12:50:11 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>, "Woodhouse,
 David" <dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Allen, Neil"
	<shayagr@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Thread-Index: AQHbjThyr28YLVH3LkCG4RZT31KA07NjeSoAgAEGKrA=
Date: Wed, 5 Mar 2025 12:50:11 +0000
Message-ID: <a4be818e2a984c899d978130d6707f1f@amazon.com>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-6-darinzon@amazon.com>
 <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
In-Reply-To: <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
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

> > +The feature is turned off by default, in order to turn the feature
> > +on, please use the following:
> > +
> > +- sysfs (during runtime):
> > +
> > +.. code-block:: shell
> > +
> > +  echo 1 > /sys/bus/pci/devices/<domain:bus:slot.function>/phc_enable
> > +
> > +All available PTP clock sources can be tracked here:
> > +
> > +.. code-block:: shell
> > +
> > +  ls /sys/class/ptp
> > +
> > +PHC support and capabilities can be verified using ethtool:
> > +
> > +.. code-block:: shell
> > +
> > +  ethtool -T <interface>
> > +
> > +**PHC timestamp**
> > +
> > +To retrieve PHC timestamp, use `ptp-userspace-api`_, usage example
> using `testptp`_:
> > +
> > +.. code-block:: shell
> > +
> > +  testptp -d /dev/ptp$(ethtool -T <interface> | awk '/PTP Hardware
> > + Clock:/ {print $NF}') -k 1
>=20
> Why is not opening /dev/ptpX sufficient to enable the PHC?
>=20
>     Andrew

Hi Andrew,

The reasoning for the enablement option of PHC was explained in patch 3 in =
the series
https://lore.kernel.org/netdev/20250304190504.3743-4-darinzon@amazon.com/

David

