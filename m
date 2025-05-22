Return-Path: <netdev+bounces-192669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9FAAC0C44
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A7B175C55
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4022F85B;
	Thu, 22 May 2025 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="L1xG5pD2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D092AEF5
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747919329; cv=none; b=t2U/DC3M0BQri7nRIE+hjAgobkZ95alr5z2CvXYeJ26H7S6qjxVbbwMaHIkfjl54MviBBK6OdDLXxtGMs+VYznbxYwSN8JlIw9wKpfLlC636wjidTHtPTCjkTF2bM/msplZS2dUS2GW302akE4aOGhihyoA16/8CvCrh90EnSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747919329; c=relaxed/simple;
	bh=n6mFlHV4nWeovbxxu1NaybUzjZ5rpq6WdXi9QAEmQEM=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t+xg3mWtX37QtcRdUOLrOfj7ya43mwk4NgOM94fyHWVfcaDN0vbl/Do3BIs5y4s38MPoPF0XR6QjkVqydgwKU+vQYbfHIgmzwRedZjIjxlPeJU+obeAuxEu7lGNSZkompQUi1/H41GTqTtiWNW+9LjezB/nDzTqLEPBAGfg6F1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=L1xG5pD2; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747919328; x=1779455328;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=bDZdhFa9BrQCO8OZwk04aU41cbWQfGvmZ/SRyNHWTzo=;
  b=L1xG5pD29TgaleG7L7Aak3Ympz4gBEUIVraxr0srOha4JjCZVK7YpnQt
   qP9MR7l9MDhPltsCSmwnpmrU3a3Ce8SiAuOxhEnDkeH9YVeBb1ie0pQhh
   5LnkQKVq79v5ugFcsst6anDGSFYQ8JVsGK7epZ+ktvba/yiVnpL68oMrH
   UaZHlEojCFpVpeWGnRR/mZZJZ6uce9bhNF9eUznOoM9Pfw+B5ZekpTuDW
   Gr9dfYo6upmDWuXaFRWjYd0XhxJVto0Jq5bEiDiK7c2CV/fi9t6qVC9uZ
   pB9wNRN2UPGoFXWMMDRe6M2Is9a9MeJp+N/WObTUo9hc5SLqT00SeME6C
   g==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="22699026"
Subject: RE: [PATCH v9 net-next 5/8] net: ena: Add debugfs support to the ENA driver
Thread-Topic: [PATCH v9 net-next 5/8] net: ena: Add debugfs support to the ENA driver
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:08:40 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:36154]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.182:2525] with esmtp (Farcaster)
 id c3f89e8e-43ff-4b54-b6c7-692487cdca83; Thu, 22 May 2025 13:08:39 +0000 (UTC)
X-Farcaster-Flow-ID: c3f89e8e-43ff-4b54-b6c7-692487cdca83
Received: from EX19D004EUA001.ant.amazon.com (10.252.50.27) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:08:36 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D004EUA001.ant.amazon.com (10.252.50.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:08:36 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Thu, 22 May 2025 13:08:36 +0000
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Leon Romanovsky
	<leon@kernel.org>
Thread-Index: AQHbykXC/pcoceaWVUWzJVWiZP+4L7PdBhYAgAEXmGCAAHg+AIAACqBQ
Date: Thu, 22 May 2025 13:08:36 +0000
Message-ID: <1c040fc58c7347269ef904d8f1dc6024@amazon.com>
References: <20250521114254.369-1-darinzon@amazon.com>
 <20250521114254.369-6-darinzon@amazon.com>
 <0754879f-5dbe-4748-8af3-0a588c90bcc0@lunn.ch>
 <8b4dc75950b24bd6a98cb26661533f70@amazon.com>
 <42091367-4dce-4c6f-8588-ffad8a66de3b@lunn.ch>
In-Reply-To: <42091367-4dce-4c6f-8588-ffad8a66de3b@lunn.ch>
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

> > > > +void ena_debugfs_init(struct net_device *dev) {
> > > > +     struct ena_adapter *adapter =3D netdev_priv(dev);
> > > > +
> > > > +     adapter->debugfs_base =3D
> > > > +             debugfs_create_dir(dev_name(&adapter->pdev->dev), NUL=
L);
> > > > +     if (IS_ERR(adapter->debugfs_base))
> > > > +             netdev_err(dev, "Failed to create debugfs dir\n");
> > >
> > > Don't check return codes from debugfs_ calls. It does not matter if
> > > it fails, it is just debug, and all debugfs_ calls are happy to take
> > > a NULL pointer,
> > > ERR_PTR() etc.
> > >
> > >         Andrew
> >
> > Thank you for the feedback.
> > We were looking to get a failure indication and not continue creating t=
he
> rest of the nodes (patch 6/8).
>=20
> That will automagically happen, because when you pass the ERR_PTR from
> debugfs_create_dir() to other functions, they become NOPs.
>=20
> If you look around, you will find bot drivers submitting patches removing
> such checks, because they are not wanted nor needed.
>=20
>         Andrew

Acknowledged, thank you for the guidance.

David

