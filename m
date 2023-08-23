Return-Path: <netdev+bounces-30016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C35785A47
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AD91C20C87
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7497C155;
	Wed, 23 Aug 2023 14:21:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4041C152
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:21:30 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A439E50;
	Wed, 23 Aug 2023 07:21:28 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37NEKPlrC011797, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37NEKPlrC011797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Aug 2023 22:20:25 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 23 Aug 2023 22:20:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 23 Aug 2023 22:20:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 23 Aug 2023 22:20:47 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jiri@resnulli.us"
	<jiri@resnulli.us>,
        "andrew@lunn.ch" <andrew@lunn.ch>
Subject: RE: [PATCH net-next v6 1/2] net/ethernet/realtek: Add Realtek automotive PCIe driver code
Thread-Topic: [PATCH net-next v6 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Thread-Index: AQHZ1KdKxMskTPV/qUeQjEQ9njC6tK/2D1MAgAHhTOA=
Date: Wed, 23 Aug 2023 14:20:47 +0000
Message-ID: <1cdd197b38804b4d95cf82a21d73aab1@realtek.com>
References: <20230822031805.4752-1-justinlai0215@realtek.com>
	<20230822031805.4752-2-justinlai0215@realtek.com>
 <20230822103750.6dbb6fc2@kernel.org>
In-Reply-To: <20230822103750.6dbb6fc2@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Tue, 22 Aug 2023 11:18:04 +0800 Justin Lai wrote:
> >  drivers/net/ethernet/realtek/rtase/rtase.h    |  372 +++
> >  .../net/ethernet/realtek/rtase/rtase_main.c   | 2432 +++++++++++++++++
> >  5 files changed, 2832 insertions(+)
>=20
> Please split this into multiple patches, I already asked you to do so.
>=20
> Individual ethtool ops and vlan support should be separate patches, perha=
ps
> you can separate other features out, too.
>=20
Thanks for your review, I will make this change in the next version.

