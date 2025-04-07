Return-Path: <netdev+bounces-179520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E6BA7D4E1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D454A3AC8FC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 07:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7F822425E;
	Mon,  7 Apr 2025 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XQyUyAfx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E04642D
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744009314; cv=none; b=kY2MIdE2bb66lIwwfOA5P4ZitELzUnoMDhhg9S0/MDfqDQOBXvbtvpKbyhk1w15fOMtr8Fw3ARndMkgJ33BcOSLPf4qtd5kkPqVFGJgMFvBL7Pq0IJtOYOocEchSMa28jzj3gu1TD/0miCpq9aHofY9/xqnBWen5j/mL97EDRJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744009314; c=relaxed/simple;
	bh=7YWtS0rcP9DQ5Hyaxo2s7lTfwUWKl8xo5nomKlQH5wM=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fDCsMsFUTyt5Hw5yyECIxbtCbn8Ss1v0K010R5tFLynGJT1mE18V1bC0VUhPxaZYeVnYYoTpHLW8dCDZ4CJMg1PPBi+fXwP+N8kaWGz+8c5y+igJ48WghmkagSBwYWzAjAl3LQUZ2xGKscjd44YB7YCvmuWr4EHA/9jO9KEBRwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XQyUyAfx; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744009313; x=1775545313;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=7YWtS0rcP9DQ5Hyaxo2s7lTfwUWKl8xo5nomKlQH5wM=;
  b=XQyUyAfx/pMgG3MCSzDYiv8/t8s13z0kID/1bmV/Rh7OZCVT76KwARyr
   qiN+EwOC/lkEULSyamIDQH2QjyuwQDRRLscVQTV4V5t/LUvIaGIUkZLJg
   1Szn5iwmj5g5uWfiVnadhq5DALNTiJSQKHwk57GtuXBwqRzueZz6T3g91
   o=;
X-IronPort-AV: E=Sophos;i="6.15,193,1739836800"; 
   d="scan'208";a="711623023"
Subject: RE: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Thread-Topic: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:01:49 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:64410]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.69:2525] with esmtp (Farcaster)
 id 4ecd2aa4-77b7-444e-9c97-a6645fceec52; Mon, 7 Apr 2025 07:01:47 +0000 (UTC)
X-Farcaster-Flow-ID: 4ecd2aa4-77b7-444e-9c97-a6645fceec52
Received: from EX19D004EUA001.ant.amazon.com (10.252.50.27) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 07:01:46 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D004EUA001.ant.amazon.com (10.252.50.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 07:01:46 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Mon, 7 Apr 2025 07:01:46 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Leon Romanovsky <leon@leon.nu>, Jakub Kicinski <kuba@kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>
CC: Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>,
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
Thread-Index: AQHbjThyr28YLVH3LkCG4RZT31KA07NjeSoAgCslKICAAAxjgIACEg4AgAA2UoCABwVh4A==
Date: Mon, 7 Apr 2025 07:01:46 +0000
Message-ID: <f37057d315c34b35b9acd93b5b2dcb41@amazon.com>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-6-darinzon@amazon.com>
 <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
 <55f9df6241d052a91dfde950af04c70969ea28b2.camel@infradead.org>
 <dc253b7be5082d5623ae8865d5d75eb3df788516.camel@infradead.org>
 <20250402092344.5a12a26a@kernel.org>
 <38966834-1267-4936-ae24-76289b3764d2@app.fastmail.com>
In-Reply-To: <38966834-1267-4936-ae24-76289b3764d2@app.fastmail.com>
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

> >> > I think the sysfs control is the best option here.
> >>
> >> Actually, it occurs to me that the best option is probably a module
> >> parameter. If you have to take the network down and up to change the
> >> mode, why not just unload and reload the module?
> >
> > We have something called devlink params, which support "configuration
> > modes" (=3D what level of reset is required to activate the new setting=
).
> > Maybe devlink param with cmode of "driver init" would be the best fit?
>=20
> I had same feeling when I wrote my auxbus response. There is no reason to
> believe that ptp enable/disable knob won't be usable by other drivers
>=20
> It's universally usable, just not related to netdev sysfs layout.
>=20
> Thanks
>=20
> >
> > Module params are annoying because they are scoped to code / module
> > not instances of the device.

Hi Jakub,

Thanks for suggesting the devlink params option for enable/disable, we will
explore the option and provide a revised patchset.

Given the pushback on custom sysfs utilization, what can be the alternative=
 for exposing=20
the PHC statistics? If `ethtool -S` is not an option, is there another fram=
ework that
allows outputting statistics?
We've explored devlink health reporter dump, would that be acceptable?

Thanks,
David



