Return-Path: <netdev+bounces-198502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAF2ADC734
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544283B19A6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378242DA762;
	Tue, 17 Jun 2025 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qCPLPjXQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638CB293C58
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153862; cv=none; b=qv1akgf2xajQa8RIVQhbJLtI6rogLFWDzNsJHL4IAAxGJdnEbFcqz7ObHS1+a6RmT0e68wawi+vImQoq7C6kCOrlSn1H2YnMY1L5nEey/8n8rG5+2aRmrH7HseSrWIjTBDea2eQMPS1S/hy2Dq/zQANmUA0IfwhuloJcJHKaqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153862; c=relaxed/simple;
	bh=o/i63lGI3n+pm7WqRpObyDvK4ulcH4GTnbdA1EE3BM4=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NzRf8wlzedbHPOqHNgdZkOS8pYLeYg7Y/okCiWd//Zr7mhIBBxDl5LhlOpafbbzbxP5ijr1oZEIjWraDmIAUvouOby5EhWFgXFTAwNSJibRmxJqeKz0fDV2BB4u/Szd+QU1IhmB4yngqRVYh9mUZ0VghUAU61oIYy/NVf4sLbFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qCPLPjXQ; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1750153861; x=1781689861;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=Xfrf6go7xJFSDRPCPMBMprQUhBz3EgsnNrMIu48NdkM=;
  b=qCPLPjXQ83Mbw1g0KwTLAr7W/xN1Wx7bus1mXxfe+tdmtiMluM6NmGnt
   zgVTYVlcsG+D/ysDNNvml5kLCrQ00fvEQmjS5vic1KMYtIx9nV4n99t87
   V0DhGBM/yOqxMNBMUjtzFMVE4n0gkwSlPkrhgM3d4l1eJlb9SoRfcZVSp
   D8SKqeo4KuS/SMggrkUoAFMEt00a7BSQiMUGUS7Ui1IzpAugAo9r+d5n0
   rrtVb6bYvUXBUOZRyz/F2kFNnnkgUrx2FOHBUYRtsQvCne8Z+vfyOFdUt
   qIOr9YoEuzaWNjltkNCSDRjM05iEjQe+A8ACdqbKnmiNC8NwhBToE3qFW
   w==;
X-IronPort-AV: E=Sophos;i="6.16,242,1744070400"; 
   d="scan'208";a="62463778"
Subject: RE: [PATCH v12 net-next 9/9] net: ena: Add PHC documentation
Thread-Topic: [PATCH v12 net-next 9/9] net: ena: Add PHC documentation
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 09:50:59 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:48649]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.45:2525] with esmtp (Farcaster)
 id e5a2b033-b35f-4bd8-b32d-e6542bdcb8e7; Tue, 17 Jun 2025 09:50:57 +0000 (UTC)
X-Farcaster-Flow-ID: e5a2b033-b35f-4bd8-b32d-e6542bdcb8e7
Received: from EX19D006EUA002.ant.amazon.com (10.252.50.65) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 09:50:57 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D006EUA002.ant.amazon.com (10.252.50.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 09:50:56 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Tue, 17 Jun 2025 09:50:56 +0000
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
Thread-Index: AQHb2rLm1xZY6sfSr0qYzucYC/0BcLQGiRQAgABx1WA=
Date: Tue, 17 Jun 2025 09:50:56 +0000
Message-ID: <94f10b5cac8f497ba168ea360461bd3e@amazon.com>
References: <20250611092238.2651-1-darinzon@amazon.com>
	<20250611092238.2651-10-darinzon@amazon.com>
 <20250616173200.103a5654@kernel.org>
In-Reply-To: <20250616173200.103a5654@kernel.org>
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

> > +- ``CONFIG_PTP_1588_CLOCK=3Dm``: the PTP module needs to be loaded
> prior to loading the ENA driver:
> > +
> > +Load PTP module:
> > +
> > +.. code-block:: shell
> > +
> > +  sudo modprobe ptp
>=20
> Again, I'm not sure that's true. If user insmods the ena driver and PTP=
=3Dm
> then sure, PTP needs to be loaded. But modprobe would load it
> automatically. So this appears to be an echo of out-of-tree docs.

I see your point and agree, thanks for noticing.
Will make the change in the documentation in v13.

