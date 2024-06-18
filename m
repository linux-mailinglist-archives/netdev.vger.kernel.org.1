Return-Path: <netdev+bounces-104325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D4E90C288
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD79A284556
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA6D71742;
	Tue, 18 Jun 2024 03:41:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2B1B94F;
	Tue, 18 Jun 2024 03:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718682076; cv=none; b=FEp69e8Lf/cvwtywYiudIiM93u5lz5oal7bRfix9kTfZRWuetNgDJyHEVV70jAR3J6MRSID+vKg/sdfhGFOS3OzzwbWEQoludo287hw/4Bi6JLkO6GS6ft5CiW6x4p5Mk4L4t/e6M0v9tBPbG/Mp/HJnICZtw3nSagMdmS1cGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718682076; c=relaxed/simple;
	bh=ziUrejSzHDykAJo7x1q55UApmcjovxBAJEGf+smDefk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eeH1TB6+OFpi1DuY6TehpBD/3vTVxOZ03iQOTEnvMXslIDOdLfY5PG/Xyv1Vc8SGkUnmUrld3qtkMG5MkmYporh20cJpqbJ9U9TvCGWOPdnPTZPE4CexLwIBxE1E8BKBQ+j1HI0B03+Td9OctEt4EKAhq2CQxxrCSbP68x+Xuck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45I3eYzoD4138549, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45I3eYzoD4138549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 11:40:34 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 11:40:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 18 Jun 2024 11:40:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 18 Jun 2024 11:40:34 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "rkannoth@marvell.com" <rkannoth@marvell.com>,
        "Ping-Ke
 Shih" <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v20 07/13] rtase: Implement a function to receive packets
Thread-Topic: [PATCH net-next v20 07/13] rtase: Implement a function to
 receive packets
Thread-Index: AQHauLd4tRuhQEAKAEKC1qb81QW9fbHEXcqAgAEXKfCABiJDAIABWNcQ
Date: Tue, 18 Jun 2024 03:40:34 +0000
Message-ID: <5835ed19887d4b5fae93c54c1704fa2b@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
	<20240607084321.7254-8-justinlai0215@realtek.com>
	<20240612174311.7bd028e1@kernel.org>
	<5115e5398ce742718a24ec31a0beaff5@realtek.com>
 <20240617080232.620a2452@kernel.org>
In-Reply-To: <20240617080232.620a2452@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> On Mon, 17 Jun 2024 06:44:55 +0000 Justin Lai wrote:
> > > > +             /* make sure discriptor has been updated */
> > > > +             rmb();
> > >
> > > Barriers are between things. What is this barrier between?
> >
> > At the end of this do while loop, it fetches the next descriptor. This
> > barrier is mainly used between fetching the next descriptor and using
> > the next descriptor, to ensure that the content of the next descriptor
> > is completely fetched before using it.
>=20
> What does it mean to "fetch the next descriptor"? The prefetch?
> Prefetches are not ordered at all.

Let me explain again, at the end of the do while loop in rx_handler, we
have changed the address pointed by desc to the next descriptor.
Therefore, the main purpose of this barrier is to ensure that both desc
and cur_rx have been updated to the next entry.

