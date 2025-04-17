Return-Path: <netdev+bounces-183599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A56A9133A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FBA3A72DA
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 05:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6931DBB0C;
	Thu, 17 Apr 2025 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MpbBw2fg"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34255179A7;
	Thu, 17 Apr 2025 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868818; cv=none; b=rKSWU6yLo2XIjyrbKVb+1BKeFWUYDgXbEzFM0PgnSK8+BFKmvfiuhljP8XboxaDWtyInDMDNYAeGudL3hjD3QK+BRQ2IDVx2EKiB7a9pVdgH8oPryXmKqhFb3YmVyuFprNqlHgQPFW8vtAp19zi8GV6T3nrc8PjbLk+Hto181Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868818; c=relaxed/simple;
	bh=4oYgM5MCWKU1QZFM9ucaKlFA+1SLFEymDkr9y2UXtGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uKUHpK/pdTDswzAH77Mm5fu7ldOfsOC9nOtRb6um3A7rsDMzcvxS/nHRv8EjHOaod0mKdudMgIs1YZb1AOBZUYCS/zr1MWaqVdmxoDPUcQoYRrsEWmsetws0YYH7n5F/f6EwCmbKwRuiu/xT3FFWb2XAVUUzOOERleKx6bkDOY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MpbBw2fg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53H5kBp05370839, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744868772; bh=4oYgM5MCWKU1QZFM9ucaKlFA+1SLFEymDkr9y2UXtGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MpbBw2fg9mpTniqSkEyHgL/8joTtsTmpyLO8dB3WBpt7RKwNFSEeYPsKPmyLP+tKt
	 0YbXRYxYZMeIYbDl/aGdK6z0jMzyJ2Rkp2cxx3i1QwUY1L20a2vcfxOSzuGU5ESdqx
	 s4mQ5Vqao7Dwh6wJxXywnvx4BFtPOeHvT8aSD+aKxF92q1fcvMFsD1+YgDzdZy0RoI
	 JkhJNFRllmbeKlf4MNtA1fWl+8y7KWk7fYMg8pn23BLsUI9I7ItoH2fGEMM5JbqlNB
	 ILKjaJacNJdheY5jpLR0Iw7cQE8+TRkaFj1UKbWUAFJZFI+7ojWmYbPLPexg2Z1VSi
	 XHgkOzQ22MRGw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53H5kBp05370839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:46:11 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Apr 2025 13:46:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 17 Apr 2025 13:46:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 17 Apr 2025 13:46:11 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>,
        kernel test robot
	<lkp@intel.com>
Subject: RE: [PATCH net v2 1/3] rtase: Fix the compile error reported by the kernel test robot
Thread-Topic: [PATCH net v2 1/3] rtase: Fix the compile error reported by the
 kernel test robot
Thread-Index: AQHbrs2Kq1M05GT8LEGJNWsOuQL6jbOl0KSAgAGJHbA=
Date: Thu, 17 Apr 2025 05:46:11 +0000
Message-ID: <ae94b522ec23485e88f8a01a3e09c57c@realtek.com>
References: <20250416124534.30167-1-justinlai0215@realtek.com>
 <20250416124534.30167-2-justinlai0215@realtek.com>
 <152c9566-a1bd-4082-9f66-6bbe8ab1eb47@lunn.ch>
In-Reply-To: <152c9566-a1bd-4082-9f66-6bbe8ab1eb47@lunn.ch>
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

>=20
> On Wed, Apr 16, 2025 at 08:45:32PM +0800, Justin Lai wrote:
> > Fix the following compile error reported by the kernel test robot by
> > modifying the condition used to detect overflow in
> > rtase_calc_time_mitigation.
>=20
> The Subject: line is not very useful. It is better to talk about what you=
 are fixing,
> not that a robot reported an issue.
>=20
>     Andrew
>=20
> ---
> pw-bot: cr

Hi Andrew,

Thank you for your response. I will modify the subject and post a new
version.

Thanks,
Justin

