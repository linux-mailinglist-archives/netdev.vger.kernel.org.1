Return-Path: <netdev+bounces-192753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3E1AC10B9
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7FB501663
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D26B299A89;
	Thu, 22 May 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="cM0FA98t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F3819F461
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747930033; cv=none; b=vA4vz9rSjGkuf6qRgPplFxnt7TABXCQi++Nxfl/Xbf7FMLDMjR0CKAATT9VD8oGJ1QuJ4fkZI1oz86UdrTZQdo87O4aw/05pzZduPsupYlkALTcYld6UwQ0uyj9bTHpQz1OVeeN+OvruGkHFMQ1cjA3b9M28ikTQc7YWwMsZmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747930033; c=relaxed/simple;
	bh=d1G+RB5zjH+3m7ofo+4pkM17bSUlwDOkOYqstgQtDtY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s87euvIaso9TGwQZ218jQCcg8XT6uOL9AFTosE3yp7FqTnKao+MwxcV//EkDCruesGh5tmHnSwEo+vySpDd1HzJFE3fNbV55V4O1aYAAqQ75WxMNsR6zc2VkgbZ4nBPsGJnYepguQP7VG2pduu7zcK2g8/aommmqJGHrMOrAgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=cM0FA98t; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747930032; x=1779466032;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=oTcbiLwofn3Jq7qWXSO0CSxRTPn8eaaFzsA9OpkvhmY=;
  b=cM0FA98tFMdD7nITNFoDi2Y9hHUnTDrbhGN4fT1STUqBqw4dybKHHgj8
   s02atN29nLst848zbbhpETVu4wG77n3ont7uJ/wFbDtdOD1sUKbILU9JH
   qUeaJPDMUxkpx1vJGbofAUR0xBCDCDX0DqR1w43I+miPwqDd7WtS3M1uA
   yNcaLMH+so5SquTcsPx0/iF+hgYQVw+ixNagIlLlyEU29Rz0YGMlfI1Nr
   hrQOb4ifdicjUnlHnfpPFe1E6uCba5ZGp/aPFrLPt2JAtYRzvXTKxI4d3
   FUkj0e9PJvDRFzrW1GgFteyVSKHzbRfDnnCkNn6YW2kebuZIaGfTr2Sfo
   w==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="523369021"
Subject: RE: [PATCH v10 net-next 4/8] net: ena: Control PHC enable through devlink
Thread-Topic: [PATCH v10 net-next 4/8] net: ena: Control PHC enable through devlink
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:07:06 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:13878]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.135:2525] with esmtp (Farcaster)
 id 2a77b10d-8458-4a37-a882-6cc78f0b85ab; Thu, 22 May 2025 16:07:04 +0000 (UTC)
X-Farcaster-Flow-ID: 2a77b10d-8458-4a37-a882-6cc78f0b85ab
Received: from EX19D006EUA002.ant.amazon.com (10.252.50.65) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 16:07:04 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D006EUA002.ant.amazon.com (10.252.50.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 16:07:03 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Thu, 22 May 2025 16:07:03 +0000
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
Thread-Index: AQHbyyB0M9vwly4JDkatslAI5bthobPerL2AgAAGR3CAAAOigIAAArCwgAAPzACAAATcoA==
Date: Thu, 22 May 2025 16:07:03 +0000
Message-ID: <44f411e08eec474394794ac892f12554@amazon.com>
References: <20250522134839.1336-1-darinzon@amazon.com>
 <20250522134839.1336-5-darinzon@amazon.com>
 <aq5z7dmgtdvdut437b3r3jfhevzfhknf5zr5obaunadp2xkzsh@iene76rtx3xc>
 <11eaa373bb894946bc693d9a1e112ca5@amazon.com>
 <76xnvcmdkohjxui2e2g7xe4b4iaxiork5e3k4n6inniut63a5s@6voxc4okdixd>
 <6469535d9f814e238b371f56e91da4ad@amazon.com>
 <7bs2olcdw5bgti74lhbqubcbvj4y5lezakt3jxwfiyamyj6x7e@tigvi3vp5i5c>
In-Reply-To: <7bs2olcdw5bgti74lhbqubcbvj4y5lezakt3jxwfiyamyj6x7e@tigvi3vp5i5c>
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

> >> >> >+enum ena_devlink_param_id {
> >> >> >+      ENA_DEVLINK_PARAM_ID_BASE =3D
> >> >> DEVLINK_PARAM_GENERIC_ID_MAX,
> >> >> >+      ENA_DEVLINK_PARAM_ID_PHC_ENABLE,
> >> >>
> >> >> What exactly is driver/vendor specific about this? Sounds quite
> >> >> generic to me.
> >> >
> >> >Can you please clarify the question?
> >> >If you refer to the need of ENA_DEVLINK_PARAM_ID_PHC_ENABLE, it
> was
> >> >discussed as part of patchset v8 in
> >> >https://lore.kernel.org/netdev/20250304190504.3743-6-
> >> darinzon@amazon.co
> >> >m/ More specifically in
> >>
> >https://lore.kernel.org/netdev/55f9df6241d052a91dfde950af04c70969ea2
> >> >8
> >> b2
> >> >.camel@infradead.org/
> >> >
> >>
> >> Could you please read "Generic configuration parameters" section of
> >> Documentation/networking/devlink/devlink-params.rst? Perhaps that
> >> would help. So basically my question is, why your new param can't go i=
n
> that list?
> >
> >Thanks for the clarification.
> >This is a topic that has been discussed in the versions of this
> >patchset, specifically in
> >https://lore.kernel.org/netdev/20250304190504.3743-6-
> darinzon@amazon.co
> >m/
>=20
> Where exactly?

The discussion is from https://lore.kernel.org/netdev/20250304190504.3743-6=
-darinzon@amazon.com/ and split into two sub-threads
The suggestion to use devlink is from https://lore.kernel.org/netdev/202504=
02092344.5a12a26a@kernel.org/

>=20
>=20
> >Other modules in the kernel enable PHC unconditionally, due to
> >potential blast radius concerns, we've decided to not enable the feature
> unconditionally and allow customers to enable it if they choose to use th=
e
> functionality.
> >As this is a specific behavior for the ENA driver, we've added a specifi=
c
> devlink parameter (was a sysfs entry previously and changed to devlink in=
 v9
> due to feedback).
>=20
> Why is this specific to ENA? Why any other driver can't have the same kno=
b
> to enable/disable PHC?
>=20

If there are no objections, I can add a generic command instead of a specif=
ic one.


