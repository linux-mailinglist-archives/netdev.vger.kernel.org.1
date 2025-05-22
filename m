Return-Path: <netdev+bounces-192712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B793AC0DF4
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9553A513C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE4728C029;
	Thu, 22 May 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lS2XStR4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A02236E0
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923747; cv=none; b=Tm/xkqXB1w2zWiBtUc0dZgi3ZGOI9D9QOgTkL0Izj6+/BO/EpS/hpfMxEnuep1D+G4I/cQR3UEFki4WDqlHXNgA+YI0TA1ntkaUJyiXny1zPsBhUhlrECc3iJek6ashUA0G7J6FVHO/QdwbtAKkgJ0IAwOAr8I4dlnTcodFJKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923747; c=relaxed/simple;
	bh=zT5ds2Nwh01AMVgoGTsIgwyv8laycVo09BR5mdhh8tU=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mtv8abW9N4ZAYZiz+KLtEcZQf+IfidJPbdgeWXDpxepQMYkiFOIoFJpHWQkuGbt6PWs2hH9g7dR6L1llKAnljx9WpbwQcI3jR55U1kCeFUKcYHqIZL7RJnHC5Doe+hXT8oqx2o1fWEwIGQaROadYnc+ut/blcizug0bW9+hd7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lS2XStR4; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747923747; x=1779459747;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=XqZwo+oklcOih5xSdI+q4UiXsxWukC5OFt4zhz+6z9M=;
  b=lS2XStR4p0Oy+Wjtd54jntu5XXCU/RPWm7sgQrn/kWOCb6yTgmjreEdE
   I68+mnX0CbdAT97DuVyaHpVXx9Uc6c85IOiYfUL/4/MEMd7qrdIPT8cyF
   iuT69j3bpYb+WjDQisuOKZK49l73M2YqfiM7+XB1pXaoWCho1O5tAk6WK
   tfURGrvb1Y08Wao/zMAObGa2OCuxf+5dp1Dc366DHC+HY+1C+9gSH2HKD
   pIrmW4J4mET9flJwBYpOeaTU5qjA1+Dkq7uCu6TCZ4xLPxcVZ8QTIh9z2
   WzHyQSolNNtoq5fhOdh7Um1SpUfUYxS77sJsJ7vxG5oIHTBtC4ZnUC6SD
   w==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="495187991"
Subject: RE: [PATCH v10 net-next 4/8] net: ena: Control PHC enable through devlink
Thread-Topic: [PATCH v10 net-next 4/8] net: ena: Control PHC enable through devlink
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 14:22:23 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:6935]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id 58ec344a-a54a-43fa-b4d1-917911a6782f; Thu, 22 May 2025 14:22:22 +0000 (UTC)
X-Farcaster-Flow-ID: 58ec344a-a54a-43fa-b4d1-917911a6782f
Received: from EX19D022EUA001.ant.amazon.com (10.252.50.125) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 14:22:22 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D022EUA001.ant.amazon.com (10.252.50.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 14:22:21 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Thu, 22 May 2025 14:22:21 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Jiri Pirko <jiri@resnulli.us>
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>,
	Leon Romanovsky <leon@kernel.org>
Thread-Index: AQHbyyB0M9vwly4JDkatslAI5bthobPerL2AgAAGR3A=
Date: Thu, 22 May 2025 14:22:21 +0000
Message-ID: <11eaa373bb894946bc693d9a1e112ca5@amazon.com>
References: <20250522134839.1336-1-darinzon@amazon.com>
 <20250522134839.1336-5-darinzon@amazon.com>
 <aq5z7dmgtdvdut437b3r3jfhevzfhknf5zr5obaunadp2xkzsh@iene76rtx3xc>
In-Reply-To: <aq5z7dmgtdvdut437b3r3jfhevzfhknf5zr5obaunadp2xkzsh@iene76rtx3xc>
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

> [...]
>=20
>=20
> >+enum ena_devlink_param_id {
> >+      ENA_DEVLINK_PARAM_ID_BASE =3D
> DEVLINK_PARAM_GENERIC_ID_MAX,
> >+      ENA_DEVLINK_PARAM_ID_PHC_ENABLE,
>=20
> What exactly is driver/vendor specific about this? Sounds quite generic t=
o
> me.

Can you please clarify the question?
If you refer to the need of ENA_DEVLINK_PARAM_ID_PHC_ENABLE, it was discuss=
ed as part of patchset v8 in https://lore.kernel.org/netdev/20250304190504.=
3743-6-darinzon@amazon.com/
More specifically in https://lore.kernel.org/netdev/55f9df6241d052a91dfde95=
0af04c70969ea28b2.camel@infradead.org/


