Return-Path: <netdev+bounces-118538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5106951E9B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426301F2151F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F0E1B580B;
	Wed, 14 Aug 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="L7kywoeb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC21B4C5F
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649519; cv=none; b=cetel/3U9Ppc1cV+loWNbJ1cyZ3l2IhW1QoopQNfymiG2FKcXuTJ77ska43FgSuZGAedcf4+8pGe2CcGrUgxpowM8SbSvemIpN1EZNIJipOmEK/dzOgZGG8HNL7LC9bX2A9PMrVPCQsSKj5VPyxHRlQ2vNN1GwYUf9S5kc9WUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649519; c=relaxed/simple;
	bh=E+2Pw5hxbES/0EglkCm5CiwV6EZJY1YFGz6Dpoh0RI0=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aJIhQewbDKc4YQn9NiqrIko5eZnIt5ndaRmgkmHd4r1iAPF8oEXoOy5q5LM+TGDGujO1PlVd5Icm8xKhSRM7nJXHHFIvJHPQiwBH3om+qTw5QQls1/Arkiiuw48R/DepXZzlVmoWLvpFiXrEzVNvC2jYJ/INInQgM2N7wRanX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=L7kywoeb; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723649519; x=1755185519;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=E+2Pw5hxbES/0EglkCm5CiwV6EZJY1YFGz6Dpoh0RI0=;
  b=L7kywoebGiL/ezil7SkMTY9qpgOrOf+eXWAhxFxlkxg3xYiXcv1lRugG
   lSbaFTmsYO13hsFQpMgM13vJV05/vClkXGFeVjYbRKxWYdO4LKZdW6PeI
   Yhp0y0nnKBGoKwwfhpf43P0hdnZJZW03dl5SFWfgTh5MfjrtrW4knjWOG
   Q=;
X-IronPort-AV: E=Sophos;i="6.10,146,1719878400"; 
   d="scan'208";a="443911327"
Subject: RE: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics reporting
 support
Thread-Topic: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics reporting support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 15:31:52 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:23688]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.42.231:2525] with esmtp (Farcaster)
 id 5d82139a-37fa-4758-bfb8-1b5f1fe415b9; Wed, 14 Aug 2024 15:31:50 +0000 (UTC)
X-Farcaster-Flow-ID: 5d82139a-37fa-4758-bfb8-1b5f1fe415b9
Received: from EX19D030EUB004.ant.amazon.com (10.252.61.33) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 14 Aug 2024 15:31:50 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D030EUB004.ant.amazon.com (10.252.61.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 14 Aug 2024 15:31:50 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1258.034; Wed, 14 Aug 2024 15:31:50 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky,
 Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Beider, Ron" <rbeider@amazon.com>, "Chauskin,
 Igor" <igorch@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>
Thread-Index: AQHa7SRj5VISt7WkiEq52al7KaOO2rIlC6FwgAA/3QCAAZZYsA==
Date: Wed, 14 Aug 2024 15:31:49 +0000
Message-ID: <8aea0fda1e48485291312a4451aa5d7c@amazon.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-3-darinzon@amazon.com>
	<20240812185852.46940666@kernel.org>
	<9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
 <20240813081010.02742f87@kernel.org>
In-Reply-To: <20240813081010.02742f87@kernel.org>
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

> > I will note that this patch modifies the infrastructure/logic in which
> > these stats are retrieved to allow expandability and flexibility of
> > the interface between the driver and the device (written in the commit
> > message). The top five (0 - 4) are already part of the upstream code
> > and the last one (5) is added in this patch.
>=20
> That's not clear at all from the one sentence in the commit message.
> Please don't assume that the reviewers are familiar with your driver.
>=20
> > The statistics discussed here and are exposed by ENA are not on a
> > queue level but on an interface level, therefore, I am not sure that
> > the ones pointed out by you would be a good fit for us.
>=20
> The API in question is queue-capable, but it also supports reporting the =
stats
> for the overall device, without per-queue breakdown (via the
> "get_base_stats" callback).
>=20
> > But in any case, would it be possible from your point of view to
> > progress in two paths, one would be this patchset with the addition of
> > the new metric and another would be to explore whether there are such
> > stats on an interface level that can be exposed?
>=20
> Adding a callback and filling in two stats is not a large ask.
> Just do it, please.

Hi Jakub,

I've looked into the definition of the metrics under question

Based on AWS documentation (https://docs.aws.amazon.com/AWSEC2/latest/UserG=
uide/monitoring-network-performance-ena.html)

bw_in_allowance_exceeded: The number of packets queued or dropped because t=
he inbound aggregate bandwidth exceeded the maximum for the instance.
bw_out_allowance_exceeded: The number of packets queued or dropped because =
the outbound aggregate bandwidth exceeded the maximum for the instance.

Based on the netlink spec (https://docs.kernel.org/next/networking/netlink_=
spec/netdev.html)

rx-hw-drop-ratelimits (uint)
doc: Number of the packets dropped by the device due to the received packet=
s bitrate exceeding the device rate limit.
tx-hw-drop-ratelimits (uint)
doc: Number of the packets dropped by the device due to the transmit packet=
s bitrate exceeding the device rate limit.

The AWS metrics are counting for packets dropped or queued (delayed, but ar=
e sent/received with a delay), a change in these metrics is an indication t=
o customers to check their applications and workloads due to risk of exceed=
ing limits.
There's no distinction between dropped and queued in these metrics, therefo=
re, they do not match the ratelimits in the netlink spec.
In case there will be a separation of these metrics in the future to droppe=
d and queued, we'll be able to add the support for hw-drop-ratelimits.

Thanks,
David

