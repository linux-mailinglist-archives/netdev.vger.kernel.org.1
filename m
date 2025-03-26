Return-Path: <netdev+bounces-177767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F70DA71A68
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A7C1888099
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A71F4177;
	Wed, 26 Mar 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p1JApxXJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4B1F416A
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003131; cv=none; b=DPdTi3QAuqE2b3RFVcwzwlcwL1kZmKuEFqL2RkPd9FwwiLnvsYySW9bd8XrSLUEpd4Ll7FzslN3D1n0LCbwzP2SJVzmfJ3YRW57gieYz2f+RCO/QlM8iaO6AyHR2XSb4Fsk1fL4TBImI+Qh/4+krxSY+jlWDzhtN/wAJXVuVdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003131; c=relaxed/simple;
	bh=0KPnQUm/AkAcbgKk0HY8xG5eIjknzkrRHYHMYD5ivKY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AWqMRyhmyi9a8ONOS7XJVALpiJv0hQS/mcJ5QSJY0cd9j7Z46ZIkCBfHaJnw4GEFQECjZyuSLIbbEIx+gcAtrJcnA/2W7XwcxPt43Nxb82OgrIFHWE8akSTtB8N9bJn82ToPhaSLbvHqrsi05SNz4bDEWEpDPnWPMz+FRFGrtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=p1JApxXJ; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743003130; x=1774539130;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=kAgBQ71kyypREeDjgf6cKiI9udd5OrDVohkDSTAbghw=;
  b=p1JApxXJxHWSFJdglEYxtYdcDmHR3LbAbvqeX55hMc2buwYvpLlz1JjP
   jX1wCsYTnlbfaOcTHsm2oktCXVjfkuoWBSQbnndJLuf7npKQOYi0SNF4G
   95Yv2WxI3FZpv2eqE+0JqVD+x1kcSI+GcwtZRoK5Luy2xgTPoT3VPtt1P
   A=;
X-IronPort-AV: E=Sophos;i="6.14,278,1736812800"; 
   d="scan'208";a="4730575"
Subject: RE: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Thread-Topic: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 15:32:03 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:51177]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.242:2525] with esmtp (Farcaster)
 id 840c95b2-520b-4e35-98ed-72c6fc5ecded; Wed, 26 Mar 2025 15:32:01 +0000 (UTC)
X-Farcaster-Flow-ID: 840c95b2-520b-4e35-98ed-72c6fc5ecded
Received: from EX19D011EUA004.ant.amazon.com (10.252.50.46) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Mar 2025 15:32:01 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D011EUA004.ant.amazon.com (10.252.50.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Mar 2025 15:32:00 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Wed, 26 Mar 2025 15:32:00 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC: David Woodhouse <dwmw2@infradead.org>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, "Machulsky, Zorik" <zorik@amazon.com>,
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
Thread-Index: AQHbjThyr28YLVH3LkCG4RZT31KA07NjeSoAgAEGKrCAAAMjgIAAK6EAgAAmQYCAINeZ0A==
Date: Wed, 26 Mar 2025 15:32:00 +0000
Message-ID: <db859110a34d440fb36c52a7ff99cb65@amazon.com>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-6-darinzon@amazon.com>
 <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
 <a4be818e2a984c899d978130d6707f1f@amazon.com>
 <65d766e4a06bf85b9141452039f10a1d59545f76.camel@infradead.org>
 <be15e049-c68a-46be-be1e-55be19710d6a@lunn.ch>
 <20250305175243.GN1955273@unreal>
In-Reply-To: <20250305175243.GN1955273@unreal>
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

> > > If you read the actual code in that patch, there's a hint though.
> > > Because the actual process in ena_phc_enable_set() does the following=
:
> > >
> > > +   ena_destroy_device(adapter, false);
> > > +   rc =3D ena_restore_device(adapter);
> > >
> > > Is that actually tearing down the whole netdev and recreating it
> > > when the PHC enable is flipped?
> >
> > Well Jakub said it is a pure clock, not related to the netdev.

The PHC device is a PTP clock integrated with the networking device under t=
he same PCI device. =20
As previously mentioned in this thread, enabling or disabling the ENA PHC r=
equires reconfiguring the ENA network device,=20
which involves tearing down and recreating the netdev.=20
This necessitates having a separate control knob.

Thanks,
David

>=20
> So why are you ready to merge the code which is not netdev, doesn't have
> any association with netdev and doesn't follow netdev semantics (no custo=
m
> sysfs files)?
>=20
> Thanks

