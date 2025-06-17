Return-Path: <netdev+bounces-198445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11319ADC30C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B382F1715BE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 07:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A5528C84A;
	Tue, 17 Jun 2025 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fUvIbnOi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8133328C5CB
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750144643; cv=none; b=pCTTFRtQHSAunq1UNPlNF6ot3fpr2QPQc8/9md5A0aJSDELSwumFawIoKw6EWnfSkMknahWH1IuzRd7sCy5w3KmEwFwtGt+n6OZpc2BOHpxTrNyCKm8DCx+9VD4NChc9EmUS3grXXR1pIlZno+qqsJl9EgmzgmITF6p8UNhWpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750144643; c=relaxed/simple;
	bh=tHhhIwl3c1sdm8uLIehmnpvDeqygJ6AVWfWrHwCgizE=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=naA8530fO9+IPYOfDyOAjUIQsscQQPM/GExm4R8pTZx3Qz9bed+btzJw/vaYMIbT5ldBL+bWPryghwl0hXtxXhcHoU6RMf/oO14fHnds2JJuz25H5CrWzVBXTpnmPhqLmb1fVwDalMXT5gLkTLhnyLra4+xItR18H1KwMYjAQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fUvIbnOi; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1750144642; x=1781680642;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=S7mtE75Ltr+IjlrJYk/4JQDqzCJ96F9mHQk1ALhVti8=;
  b=fUvIbnOidnmTS0sld9X31aYakKm3+j5jdUuitomIh/dsYU6O9wVpju3g
   bzWs0R6Bl6G814ZS98NKjpDrzOnrtho/WYoWpIcceSlxry8pAvJK+GCF9
   CyL48ude0H4O/z+QWjEe8JuEMrdDNIpDY+l8Rwq2dZN2N+Ter4z5h77KL
   csy1800je1+qPOeqDfLDzbakeO5/h+7T9K39nkDenQ+5ZnPRDXnkmCe4b
   1D91zmCsE6QobjsZRDGLQwCYN/da4LRE5V+CIat6MOW/m6KjzvrK9t+qj
   Lh03qSBce2OuWh0zD7mUvH5aSIolgB2Rc1OJ2bB/mfJecNs90Rj8LjgJl
   g==;
X-IronPort-AV: E=Sophos;i="6.16,242,1744070400"; 
   d="scan'208";a="510717155"
Subject: RE: [PATCH v12 net-next 3/9] net: ena: Add device reload capability through
 devlink
Thread-Topic: [PATCH v12 net-next 3/9] net: ena: Add device reload capability through
 devlink
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 07:17:16 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:15151]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.18.47:2525] with esmtp (Farcaster)
 id d860e375-f97f-46ad-a7a6-af066a885370; Tue, 17 Jun 2025 07:17:14 +0000 (UTC)
X-Farcaster-Flow-ID: d860e375-f97f-46ad-a7a6-af066a885370
Received: from EX19D022EUA004.ant.amazon.com (10.252.50.82) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 07:17:14 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D022EUA004.ant.amazon.com (10.252.50.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 07:17:13 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Tue, 17 Jun 2025 07:17:13 +0000
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
	<amitbern@amazon.com>, "Allen, Neil" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky
	<leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Thread-Index: AQHb2rKM3kLAXMwbu0yTALZCBMtEjbQGh9MAgAByPRA=
Date: Tue, 17 Jun 2025 07:17:13 +0000
Message-ID: <a841114688ac4ec3a65da55f2ce32a40@amazon.com>
References: <20250611092238.2651-1-darinzon@amazon.com>
	<20250611092238.2651-4-darinzon@amazon.com>
 <20250616172730.5545c02e@kernel.org>
In-Reply-To: <20250616172730.5545c02e@kernel.org>
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

> > +In order to use devlink, environment variable ``ENA_DEVLINK_INCLUDE``
> needs to be set.
> > +
> > +.. code-block:: shell
> > +
> > +  ENA_DEVLINK_INCLUDE=3D1 make
>=20
> This part of the doc refers to building the driver out of tree?
> We probably don't want to make a precedent for adding OOT docs to the
> tree.
> --
> pw-bot: cr

You're absolutely right, I missed this.
Thank you for noticing. Will fix it in v13.

