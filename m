Return-Path: <netdev+bounces-46685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 049CF7E5CDF
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 19:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98018B20EBC
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 18:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2F432C86;
	Wed,  8 Nov 2023 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666F321B7
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 18:08:52 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB961FEE
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 10:08:51 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A8I8bdC6977188, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A8I8bdC6977188
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Nov 2023 02:08:37 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 9 Nov 2023 02:08:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Nov 2023 02:08:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 9 Nov 2023 02:08:36 +0800
From: Hau <hau@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>
Subject: RE: [PATCH net 0/2] r8169: fix DASH deviceis network lost issue
Thread-Topic: [PATCH net 0/2] r8169: fix DASH deviceis network lost issue
Thread-Index: AQHaEMOGsg9B8V3/DEWJYan9wMB2UrBunwmAgAIcbqA=
Date: Wed, 8 Nov 2023 18:08:36 +0000
Message-ID: <76d2201bbfb7431f85cb8a0dff37fc1b@realtek.com>
References: <20231106151124.9175-1-hau@realtek.com>
 <20231107095339.49309193@kernel.org>
In-Reply-To: <20231107095339.49309193@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
x-originating-ip: [172.22.228.56]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

> > This series are used to fix network lost issue on systems that support
> > DASH.
>=20
> Please use get_maintainer on the patch files to make sure you CC all rele=
vant
> people.

I will do this before submit patch. Thanks.

