Return-Path: <netdev+bounces-68148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D20A845EBC
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2999A2936CB
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A949A6FBBB;
	Thu,  1 Feb 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YlicNA9Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CCF6FBB1
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809217; cv=none; b=lIWWPgRv24oQhNGDwa4X2PSyFEKnLse0VFNhHTne2AtfkfpuKGttovwJFUo6Y6tQ69cQWeL7fXEk5IETxG+V2KIaQnY583+zLIBDaAAFQdr4ZZUQQxiXQ2C3TIV1U1cFLCB6VsF2IqyCsdKXarywCRLIvkF7HFw9aPF7jZExqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809217; c=relaxed/simple;
	bh=bLQSpEKwtOYafivV8aerDIQCa1RzXD8QI1z2YecrdOk=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IITnViZfBiqd/Ao7zb5BVLJfGrP9YFgu+H0Djy82pJHDAbUzMFtnTDY68NRKhzscDlt+5HpGHU8BTFmpizhfYfgDz5rwByLfwMG3jw6m0NW6E2zveUgfLDYIYzW0KVJ7tvNN5yt4SqEPHjnUCjz7iPW3r/sGVYIYB9SnWIX5oVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YlicNA9Z; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706809216; x=1738345216;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=iR7xsbmK/9AqDvH5OAHhMcxabjVuDeRRfZDATbmN4bI=;
  b=YlicNA9Z0pufVLxYA5GenjtTOAlME6dqs3wldo6cF5RnNy07W7nRUkDv
   NW/I+N8UMSx939A1ZKuno9V2P0woyHzfe1qt5GgRPF6Hz+YeoIIZCUC0C
   fZE1KsHCMpfMp+Z+aPpT82HygehegnkKuz1761oL4f2DGUGz/4SKeNI24
   8=;
X-IronPort-AV: E=Sophos;i="6.05,234,1701129600"; 
   d="scan'208";a="62963947"
Subject: RE: [PATCH v2 net-next 11/11] net: ena: Reduce lines with longer column
 width boundary
Thread-Topic: [PATCH v2 net-next 11/11] net: ena: Reduce lines with longer column width
 boundary
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 17:40:14 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:1674]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.233:2525] with esmtp (Farcaster)
 id c4e30381-b0a6-46cf-a712-860f34cd3e1a; Thu, 1 Feb 2024 17:40:13 +0000 (UTC)
X-Farcaster-Flow-ID: c4e30381-b0a6-46cf-a712-860f34cd3e1a
Received: from EX19D030EUB004.ant.amazon.com (10.252.61.33) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 17:40:13 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D030EUB004.ant.amazon.com (10.252.61.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 17:40:12 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1118.040; Thu, 1 Feb 2024 17:40:12 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Nelson, Shannon" <shannon.nelson@amd.com>, David Miller
	<davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky, Zorik"
	<zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Koler, Nati" <nkoler@amazon.com>
Thread-Index: AQHaVSmar/NbYxirMEmLC4nvA8Zhy7D1wE4A
Date: Thu, 1 Feb 2024 17:40:12 +0000
Message-ID: <97161a1877f548f19403fa89bf31e379@amazon.com>
References: <20240130095353.2881-1-darinzon@amazon.com>
	<20240130095353.2881-12-darinzon@amazon.com>
 <20240201081230.6db58028@kernel.org>
In-Reply-To: <20240201081230.6db58028@kernel.org>
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

> On Tue, 30 Jan 2024 09:53:53 +0000 darinzon@amazon.com wrote:
> > -     sq->entries =3D dma_alloc_coherent(admin_queue->q_dmadev, size,
> > -                                      &sq->dma_addr, GFP_KERNEL);
> > +     sq->entries =3D dma_alloc_coherent(admin_queue->q_dmadev, size,
> &sq->dma_addr, GFP_KERNEL);
>=20
> To be clear - we still prefer 80 chars in networking.

Thanks Jakub, we'll take that into account in future patchsets.

David

