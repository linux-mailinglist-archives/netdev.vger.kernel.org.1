Return-Path: <netdev+bounces-192526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B22FAC03F5
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 07:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58EC1B60EC5
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 05:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636A4155A4D;
	Thu, 22 May 2025 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="FHvk431N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33DEC2E0
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 05:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747891480; cv=none; b=l6mgCDdyUWpk3PKmeVnyNib3no1NwpJVPKrhW5E/18oOEGTzoRReu9fnKS8Dj3sQfa1Vkz64HsOeIc2E6NSDestdlIDmEAqSba3pxFkeibl/mqe3ANaYMnvjP9QJk//owL5cbrhLLyEMMgpgwHGmaTJOK/YQu3uUois18cN/Hc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747891480; c=relaxed/simple;
	bh=SjElWUSj1X0bIqK2uUtcb8ruDhV57KKbWxDZNRh0H0E=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=irpJYI7C2QMUJ3Od4ObLmOgOU3dlZD/FVUUj00PNCVLNJ+PbT0W1ZKtLjiMs6S9DvzJIx4OmLRvamzWuvfl+fZ/o4EfJh+Aqbgpyx5iYhmA+ABK1CygIGELGnCwlo8LYWpUtw+qT/B/5fAcgYNBEgT4kodc20uKOMIv20UreqfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=FHvk431N; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747891479; x=1779427479;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=5BoZ1iD/svZAAMHUN346KX0pJTsacBYPo7Qqnj7fhks=;
  b=FHvk431NioIRB4ChEYHLZPbAsJBzOkW39L1G4LKZddaGeiQMVMV8RtlJ
   EuHCgPdhAa16TySZHV6eU0NfplBS0hDAdPuuS2mKc0nu+/jO5HtH2p30h
   fX8XIN3GWCIZq4TkvphcO4ziRqVXYxFVsWpy9x+C6bEGB6eywsQNKkpfF
   BsVbmNef1sKMAUGNq7OBgaVNvjoFIE4hT0e7Jx+4jOvvWPEqHdK9X96lh
   3PD9Hl0p+F6dRD+cehTwpPHan68iGsT0Obi0Lw5dDqwfgGXXu8LMePSK2
   tPCOK8HrPdSmy2aHiVBPL1v8mNmnHaZpyr8MkYb5P4M9D3Mk+mkc6yH0L
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,305,1739836800"; 
   d="scan'208";a="827298157"
Subject: RE: [PATCH v9 net-next 5/8] net: ena: Add debugfs support to the ENA driver
Thread-Topic: [PATCH v9 net-next 5/8] net: ena: Add debugfs support to the ENA driver
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 05:24:12 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:64536]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.17:2525] with esmtp (Farcaster)
 id 1e7142d6-6fa8-4ab8-aab1-20769db21acf; Thu, 22 May 2025 05:24:11 +0000 (UTC)
X-Farcaster-Flow-ID: 1e7142d6-6fa8-4ab8-aab1-20769db21acf
Received: from EX19D011EUA001.ant.amazon.com (10.252.50.114) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 05:24:10 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D011EUA001.ant.amazon.com (10.252.50.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 05:24:10 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Thu, 22 May 2025 05:24:10 +0000
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
Thread-Index: AQHbykXC/pcoceaWVUWzJVWiZP+4L7PdBhYAgAEXmGA=
Date: Thu, 22 May 2025 05:24:10 +0000
Message-ID: <8b4dc75950b24bd6a98cb26661533f70@amazon.com>
References: <20250521114254.369-1-darinzon@amazon.com>
 <20250521114254.369-6-darinzon@amazon.com>
 <0754879f-5dbe-4748-8af3-0a588c90bcc0@lunn.ch>
In-Reply-To: <0754879f-5dbe-4748-8af3-0a588c90bcc0@lunn.ch>
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

> > +void ena_debugfs_init(struct net_device *dev) {
> > +     struct ena_adapter *adapter =3D netdev_priv(dev);
> > +
> > +     adapter->debugfs_base =3D
> > +             debugfs_create_dir(dev_name(&adapter->pdev->dev), NULL);
> > +     if (IS_ERR(adapter->debugfs_base))
> > +             netdev_err(dev, "Failed to create debugfs dir\n");
>=20
> Don't check return codes from debugfs_ calls. It does not matter if it fa=
ils, it is
> just debug, and all debugfs_ calls are happy to take a NULL pointer,
> ERR_PTR() etc.
>=20
>         Andrew

Thank you for the feedback.
We were looking to get a failure indication and not continue creating the r=
est of the nodes (patch 6/8).
Will make the changes in the patches and send a v10.

David

