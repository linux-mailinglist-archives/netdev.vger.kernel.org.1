Return-Path: <netdev+bounces-250886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAF6D39718
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 15:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 668B3302C869
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E167233291A;
	Sun, 18 Jan 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="i9ZTJO9S";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="i9ZTJO9S"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023090.outbound.protection.outlook.com [52.101.72.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E127E05E;
	Sun, 18 Jan 2026 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.90
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768745292; cv=fail; b=e+q0iO/5moWxW8PvUGuULnhi0oDaCzIPl6wgDH/VPxCC3eL0/gHV7lpTH3Cbgy57vgEGKX6tItz8mZuCn3yADJifEEKn/2DmJivoOItxu9vpoXk4hv6CfWz1k4VBnHqVjP0nye5Ji4XJ7bqpGEzMQldH6AFulDZvc2edjUoEuSg=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768745292; c=relaxed/simple;
	bh=4X6MxjFKqtebOWV+pJNshiXVyGiNsLV6GvOIy6PmzXU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AerxzXcVHXKlxB80EymXuy9UGSwvKph1vA7/TzSPUoYeBqPDDr/YoNA967tlUvZZEEO8ez1+9ty+SrHUB2jP0PKPopPrNBlLtOHTq8Gv585MMN0fbl5XLw2a3mou74YsmDZbc5jRrwGhuUJjFwKfrCG9f6yLBqTqcdl2oYPQOK0=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=i9ZTJO9S; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=i9ZTJO9S; arc=fail smtp.client-ip=52.101.72.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vCeXy0KfgVqjmLBmcOCXOVzNllTiZvYQrvbLZZ9HKKWXo3KKC3hdZekCvsoqJXqIRkTEjeXJkq1BwJfe3rwEGNmOkD20DRG/eLDMWH2e5glX5ZWqUHkPF7CRl04xt1YRTS5B4gE3tOTVeTajj4wQpN8XphPnLToH4t8lIMl6MzRsme2hZ2+haKonO0ApwL1J8WANC8yTxZOV11dVSjps3ZMsJtJGhEcnzseiZccoJ8gnIDMKYoCg7t07sr02Duky4//mxo+px8ovaoCKjf05J5md++9LXEG6b0phowVTzG05GOkigWGCYjlsaIUACLMxDNN2zCdf3z62U3uaHn3llw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFuebESS4DuD8BU6q9dCwLB5jKePaDENvbziS8BO5Zc=;
 b=GXKzdkvru/XQrpLRx2qHFzH5rXPzdvoXRYUuMBN4SXbqLyFnbjLB/YlIJTEgSMZCPmZOd8gARDM3gMSG6xhdffCFJDXj1XP4FY69biq3ztko9HOANixHdk0Vvki3Ed4mql6rhJrTTabCMnDDcUx/s+MzinIffzS1+4qp4EZce52Ql6wrb5FQ9M8VmUrSFW9/m5pKsZOxIwowCvtT4mJCFIUgmOAkeDJd5xbhm19nWj0KRCqSlVofktXB/xE2aQDPiwkhRa4y3GUcYvQNkb1TL2Jy6UK21IlUowxN/3ziEoYyLQTF3sL0R+UyYa3GzRNxY+lX32yZiLju6IlsR/F4WQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFuebESS4DuD8BU6q9dCwLB5jKePaDENvbziS8BO5Zc=;
 b=i9ZTJO9SCf/kFg/SXe+dzAQHv5le7fzz0vgmqUBU5ul5M1sdB+Ogf5wrpzy3eurPZ8tE5SY0s3w5VkZhIWxzznXxXMFrRUY2td4I9gXBcVRh0HhxNmS/MgzGRxK446NXeIjlcxHIbCRrsCJZz4Q05L4Rtv06bRQyymaaSPQ00r0=
Received: from DU2PR04CA0153.eurprd04.prod.outlook.com (2603:10a6:10:2b0::8)
 by DU4PR04MB11816.eurprd04.prod.outlook.com (2603:10a6:10:626::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Sun, 18 Jan
 2026 14:08:08 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::dc) by DU2PR04CA0153.outlook.office365.com
 (2603:10a6:10:2b0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Sun,
 18 Jan 2026 14:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via
 Frontend Transport; Sun, 18 Jan 2026 14:08:08 +0000
Received: from emails-3054501-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-103.eu-west-1.compute.internal [10.20.5.103])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 5468F8000E;
	Sun, 18 Jan 2026 14:08:08 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768745288; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=hFuebESS4DuD8BU6q9dCwLB5jKePaDENvbziS8BO5Zc=;
 b=LocXrgasHQQeTC6xj+iQ+9nLh0lcFH4rdTXP4ebFg9niw1u1oFRRFPbVwnba9BWdGkQxI
 Kt0wM03aZM4ORLRLLp3qBOxKhXLwdtTbav2tZ77thUU5HyCqf1rR4RBQFrAkpIARt5QVLkA
 LEdtI7BerJdZGH4vF8akd76tp4sVy2M=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768745288;
 b=Ml92nxtwHR164iWKNoLXYrk5NuH1mAMCkpNLrOIYA7x+fhayGgjBmHEOGqHLM7dKM0ovp
 vWgfCcc2r/tDB0yJBbJjhRc7v2s/xecEeAYqQZl4zNfM71qBOl9yp2APyta3a7pHrZwm7Xu
 VzyDW9imo+NPqYmycMXl/VtvM5bz9VQ=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+2wq/tSp41UQXy4DzjE2Q+rYIOTL8lXlS1ldMhNemugDRRGQhwOjpiKprPDkhgRE9di6kg4MLnVSw5qgniBq0RbRomQbqKXkwqnacbpKnD5AS7xK59GIoG0ffSPO07phi9tiNonl2LsPdGLC/PKa3Rapo3LImBIokQUiuSY8ehB19CzihJHYr2jri8KwaPBKZ+hNnyAufsnEcuB1IJI3MZbz0WBkvhiNt8N2OlnZyY9Hptj5zyhMaTGPf0h4t653EWdeAXMiz4ZSnkgbqNsdJpv0Q/ppmym3Nnf9mK28nWemM1pmubCnmy6e30RZEPnEhMAn5xiQZ/w8oKGJ33UWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFuebESS4DuD8BU6q9dCwLB5jKePaDENvbziS8BO5Zc=;
 b=viFp8gaeDRyN9O3oRROYbNkmZe0KDEAgpxDr2KeWJhTJzEAEXIF8log7ks0RP1pkmQfqSmd8EGg12jSrIOc+bE9UWkDiuJrFljsktBc6ByQt9rA4MjbuHQssVO3/3JP+jpKLU//b7L9pO1tFjQas6ACkO3xks4gxnyCWu77ITE5xyKqL1fS3FCkKeWWTKWOwY5DCX3l9VKvj1eQx+NV/NgBIxnU42E29VU5bl8w1dU0CHDrqn/jkxOFmCfV62UyvTMbdbtXzkymmf622gEO8Rjpp88K9oYBfq2fjh9tC1NxyI/HK4T7sa0pL/9Ml8V+8E1eo+JImRv+gfQOFZnPXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFuebESS4DuD8BU6q9dCwLB5jKePaDENvbziS8BO5Zc=;
 b=i9ZTJO9SCf/kFg/SXe+dzAQHv5le7fzz0vgmqUBU5ul5M1sdB+Ogf5wrpzy3eurPZ8tE5SY0s3w5VkZhIWxzznXxXMFrRUY2td4I9gXBcVRh0HhxNmS/MgzGRxK446NXeIjlcxHIbCRrsCJZz4Q05L4Rtv06bRQyymaaSPQ00r0=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI2PR04MB10977.eurprd04.prod.outlook.com (2603:10a6:800:271::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 14:07:58 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9520.005; Sun, 18 Jan 2026
 14:07:58 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 18 Jan 2026 16:07:37 +0200
Subject: [PATCH 1/2] net: ethtool: Add link mode for 25Gbps long-range
 fiber
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-sfp-25g-lr-v1-1-2daf48ffae7f@solid-run.com>
References: <20260118-sfp-25g-lr-v1-0-2daf48ffae7f@solid-run.com>
In-Reply-To: <20260118-sfp-25g-lr-v1-0-2daf48ffae7f@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Rabeeh Khoury <rabeeh@solid-run.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|VI2PR04MB10977:EE_|DU6PEPF0000A7E0:EE_|DU4PR04MB11816:EE_
X-MS-Office365-Filtering-Correlation-Id: a21c4042-ab7c-4477-8966-08de569b01e0
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?czIxWnA3b2h5aTBPNWoyTW5mVlNEdWNUUWlEczBZcUswOFhONXlpZFNmcGli?=
 =?utf-8?B?UGhJMmppQ3pMOE54Mmt4dlYwMU1kczY0UlhueUw4V3Z3UGRPTGozRzRuYVdt?=
 =?utf-8?B?V3lSVWR6TVNLR0g0UVhZaElIMEordHFFd0h3ZGFnV2pDTFRJdnY5Y014aWZl?=
 =?utf-8?B?YWRSVHk0Z0FUVmVkZVZTS0cybGE2TTk1UFpxQ3RTOWNFTlgzU0ZJcjkzQW5F?=
 =?utf-8?B?WXRWYWJWb2svak5LSG5sT2ZpRzkrek9peHdQTGV2SWRNZ1BBb2xnbjFhV3Q0?=
 =?utf-8?B?aE1YK0J0RmhUUDlUTXBma2VYd3RBVkJ5OFN5N0huT0FKM1RaRk1XQVlnQjBL?=
 =?utf-8?B?UjkySitFK0IyanhRUmoveWlFelc3STBQNEt0dmh3S1R0Mlp0TG5MbGNjWlE0?=
 =?utf-8?B?RnBJT25BUTI4cm56WXRZYXFTU29ZRlVmWnhqOUpLazBHUS96SmhKOHVGY1RK?=
 =?utf-8?B?RE43TE9sODhFalMzcHU1RjNxVlhXcThlOUZvTnZIRnZ3Mmk0UTNrTWJzcmtp?=
 =?utf-8?B?ZDdIdUNjYkdhS3pZL2diY0dVdUVLbnVMeGlzRGNCVFpHRVh1dG55TjVablVp?=
 =?utf-8?B?ekQ1Q2owL0JtTkcrMHBMV1BUQTJwZ21xWnRDVnNDM0c5WDNJditIVnZ0WWJZ?=
 =?utf-8?B?L1YzWnJjUXV0ZTZUa2tTQ0szV0MzVXlOZUZ2YWpYL2NWQUVXNGlnN3dsNWNP?=
 =?utf-8?B?M2ZNMTJ4U05zamNqOWQ2QzNsQkY5bkJNTUl1NDJpdlpqUjh4WlpPVndLcW8v?=
 =?utf-8?B?RWVhaUJqV0x3alBqQURtQmc4UnRqSW54ZDNXWGxDV0VnOG9hZkFuUk16dHl5?=
 =?utf-8?B?ZlVySnNKdk5CRHlOaG1vOFVBTVR0Q3JwTEtNQ0RBSjliSU1MUkptUFNrYUpl?=
 =?utf-8?B?M001RkpvU09xRkpFdmdlM3Mxdk0za2dERTdCdEpRTEc1djRIUlAyNGlZVFlh?=
 =?utf-8?B?bURiU1hTMTZ4dFJVdStsRmRsVm9ldVE0V0xrem1TbGpyZi9xbllxVitORVFL?=
 =?utf-8?B?MHpYRjNzKzlBNEVUR0dRS3cxOTAvV0Z3YjFGdVhkSmVPR1ZVbE12SithdGxa?=
 =?utf-8?B?aGJKWXB6ZFJPMW5VMFF5TkdEOXpNbXRGazBsYlV4cmZnRExUdERKYlhjWVVE?=
 =?utf-8?B?OTdocTd4eFI1R3ljUnNiaW00czBzbFpsajhnbW5EUGRXRUQ1UGNFZ0RaTGFI?=
 =?utf-8?B?TkMxRGZxWmRmRTlRR0x1RjdqR1h4YWMrQXVyUGJxODB4MzdmSEx5OFI4WTlO?=
 =?utf-8?B?YURJVTNJWUpQdHBVNml2RUhLek9jREd4Sk1uM25LK3FYZDU0NXk0aEFzLzdv?=
 =?utf-8?B?KzU2bStkSUdRYUxkL1Q2SFRvT2UvcW5GZUM1WlgyOU1XajkxYkhNaXMyYkJk?=
 =?utf-8?B?TjVZMzdwc01qamJwK0I1dXIwTnhJMy91bFRpeXVQRjM0eTBCbDEyUWJSUTdN?=
 =?utf-8?B?czBIckJENThRY2J0VWdqejRVR0pWLy9jSmRjNlpVT1ZqZXZ1Y2x5UjFiOWlJ?=
 =?utf-8?B?cUg5MXJ4VVYxaXRpLzd4c3BEVzUxMXJRY3VZWjVkeFdsYTAxKytZVjVaMDl0?=
 =?utf-8?B?cCs0MTZBbUpNdnk2cC95aUJEWlVEeUtxMkZTa1pjdEVzVUhCbGkxY3N1Q05v?=
 =?utf-8?B?c1VGZGxLWFRaOFc1UkFZM3dJOU10R0hGeEgrZXYwZ0xyTVJucTRRZHNKNjN5?=
 =?utf-8?B?V2ZlQXJpa2x1WXFCbG1XemdKUVJUTVYvdGIvYWJoOGJISlFKcW50QW9yM1h1?=
 =?utf-8?B?TkZyUU1oZ0J6UlpDWWVGSEl4ZlVDNnJsMVhiV0ZINU16YlZRcGZEdjFEaVVZ?=
 =?utf-8?B?SGpHMS9IOVhsNHhIdzdCWnR6UjFuSWJGc2x2TWlxVVlZVnNjNDZjRFNJYUNS?=
 =?utf-8?B?K3QrVnZuZ0NOaUdhUXp6UE5lOEVZeDJQNEVPY0pFaVowSFBiOXVydmIwdGdL?=
 =?utf-8?B?MUMxMHVXR3lKbTFoWEt3TVlFeXpuRnljOGdjYzVNYXRWSWttNG82S3poOERE?=
 =?utf-8?B?SjYrVmhMeVBEVStKUktUWDFEQVdiV0dKT3c3QlQ5MjBEOEtUU1krRyt6eVZ6?=
 =?utf-8?B?bmFrTzZubUREUzE1R25Gdi9kbkJIWGtEWkRycEh2VmVJL29CeTM4UzQzQUlr?=
 =?utf-8?B?elNYWlgzZUxXSGZTLzdiZDhxUUlQT3kxbUNvSWxHSS9NU3hVc0sreEw1OTQ0?=
 =?utf-8?Q?+jAFw9WhrI1rk1yxVlzVQp0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10977
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 28bedd65d2374df8ad2de6b68c88d9cd:solidrun,office365_emails,sent,inline:49edc22648e717370c50bbc2ad127be7
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6c392594-69a9-46c0-d49d-08de569af845
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|35042699022|7416014|376014|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzU2YlFhYWcyR2htYWNZL1FVVEp5N0cwR0tUY1J3bTZJZUJXeUJWeklLSFRR?=
 =?utf-8?B?d3dBOFZGeklkTlA3b2tzUml6aWdkUThRWmtHRFFZVmtVYmRSU0lremlDNllW?=
 =?utf-8?B?WWlvMUJFWnQ1TWpGSVRPaXNxWkkvaHdxUVJVZEZVWk5HTGdJZzhPSTYxNU50?=
 =?utf-8?B?TklPc21GWDVwNVFjRzFtbW5WTlkwVWd0ZG1jcHYxMnhMeGkybUlTcmFJeWp6?=
 =?utf-8?B?SmQvZFNEaXFWdnV0WWRicWEzMjdna2I4Y0kyRWVmVzI1V3RkdW14dFhZRVQ1?=
 =?utf-8?B?VmpVS1kvKzJQZWJOdzZOMEEvcFdCUUs5aXpHNWxTSFhWcU1EWks1TlQ3QnBN?=
 =?utf-8?B?eGRYaWhWcHdLU3FjNUg2d0VJUjNWOWozUjljTUN0d0xLUUhsS3creTBlQkZn?=
 =?utf-8?B?VDBWemN2dUtHNVhYNjJNRDlNVFY0SDFiekxTWWVrY21CQkdpQWlWZjBWVWRT?=
 =?utf-8?B?Y2tNMWxzMVRzRzFZRkd1T2wvbDJ6UVAyZlA3ZitlU3hHU3A1NW1FbGsxR3B5?=
 =?utf-8?B?djhXcFhIaUNyUU9GL3pLWWpzWDIvQWtIaWcxZk5WSU14RE1yZFUwZVFjbmhs?=
 =?utf-8?B?L2dmRDZxeXJsWGtPTW14Z0FaM3ByYS9lL2ViWkdBL001RWh3VFdMSjF6NzUr?=
 =?utf-8?B?N2NoTzl6d20weUFPQmRSU2hhU3RGU2tqYUgrbHVRTjEyZFBFOFdpOFlQbmx0?=
 =?utf-8?B?SFBTZ0hHTURrUUZ3c2NzQVNMQWh1cnlmTmIyMDZBcWYvVS9pN3M5dkJLak15?=
 =?utf-8?B?UStRTkhXSFlUT2FHQXB3UWJUbnp3eUNKSi9XUkloc1pHVzNENTNCckZ3czVB?=
 =?utf-8?B?UFRWSGdGZitiM1pKS3JLSTFQc3BMNDUwbFJpQStjSUVodVFXUk1xYzlVUHdx?=
 =?utf-8?B?Ky9acEVKaEFGSkhUcFJrTnZFTXU0MWUzdDl2WEJmcjVodTdYV3hOL2lPK2NC?=
 =?utf-8?B?RlJmNU1RNUUveVlVYzhob1plU0ZZQVI3QlNsM1NWNUU4dEF6VUZWOTQ2ZXZO?=
 =?utf-8?B?TVdXd1lGQTFaNmdOWkhZckxld1U0RnFNVGV1UnJtQnhBKzR0RnlFM0hFRFFB?=
 =?utf-8?B?ZHN3MkIxY01neGdhSWtmbEUzbnJSQWllQ3Y1OUZkNFFpUko0Z3Y5YXJQT3l6?=
 =?utf-8?B?eDVLemNsWWhObmdUVk5pMjNFTCszeG9nM2hwTmlkU1ZLdHY3d0p1NFhkakor?=
 =?utf-8?B?TVl3M2drWUxXVVVMOHhON2tuWTJUZTBWdExpZUlGNmRMUnRURGhWYnFlSGcz?=
 =?utf-8?B?OFdMM2tlY1ZJMGRsaVRtbmJheURDRkFpZjVrUG1Zc1BkSG9tUzRXNjgyU1Rv?=
 =?utf-8?B?T3FHQ2lZWHowVythSTB1UXRTNzc1cFZhYU10SDRSOCtJVGJhOCttamhDZU9P?=
 =?utf-8?B?MHFzNVlPVDdGdzNnbmtPc21XQmZtZlUyaVNub0lNS1hIc1VnVEFsN1B4NXFX?=
 =?utf-8?B?akpQM3p3SW16ZTZiOEJQVWJaUERyeW5vVVRYY0ordVB3R2VFRVE3TytBR0hZ?=
 =?utf-8?B?NGtVS1h3VDZRRUowWEs0Q2tDSGdXNnR6OXBLK3lGcU9xMkhJUHRaZ1FhRndH?=
 =?utf-8?B?S1g0KzdNRXJYSE0zSFBGMDh5QTRBUGpwT3RmMEJGVzFTTnBqUTN3VDh0cjRO?=
 =?utf-8?B?VHNZSC84Q2l2NlZ4TGdqZ2tYODZqMFdWV29ZK3NDeG81UU9Nc1hXQmJaMVFa?=
 =?utf-8?B?Q3R2azhSUXZiaUZyVWMzMlViNWFKKzlyNGF4d1E5MVpUUU0rTjhqNVpCR2My?=
 =?utf-8?B?L2NiNWsrMkxhR0JKSXFhNDNYZlBRL0VIN014TGd5R3lhNHRwWmlxWG9RS3FU?=
 =?utf-8?B?c0dYTFo1ZVdaZGNpSWVZVHdQUG0rcm9KOG1zcHp1cHozYVJvdjJDY3pEUGF0?=
 =?utf-8?B?Rm5INVVxRVF0aVFpQjlMMGxiQm1lTTQ5dzU2UlFDZUpIL1JObkwvaHRDQVVq?=
 =?utf-8?B?VDFrVUIxMTRPQTNwRjk4U3IzRE5DMUJQTWp5dlUyYWxlUnV1V2pRaDNXemxq?=
 =?utf-8?B?aWNXeVBUbitMUTcrdWkxR0dxNUF6TWw1UzVFcklPUnQ5WkNlbTl0eGZ6OUIr?=
 =?utf-8?B?Y1VFblh0MlRUb3g0RHVXVWpheVd4a0ZTYitRd3lwVU1UMmh4NWwrbDZDYnRm?=
 =?utf-8?B?S2kxTWNYRytuSjcra1Z0aC9kdDVHZnNBNGNjRGkrMUNkeWpKbkhoQ3hDVHJE?=
 =?utf-8?B?S3JSa2NFNVFWbHBMQU53bFBvTXB1THhHMlU0ZUlRVGVBTVFDMVhhNDFWbXl2?=
 =?utf-8?B?a2FhNHJXN2Y2ZFJrUmtmU1EvbktRPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(35042699022)(7416014)(376014)(82310400026)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 14:08:08.4149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a21c4042-ab7c-4477-8966-08de569b01e0
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11816

ethtool.h header already has a link-mode bit for short-range (SR) fiber.
but missing the long-range (LR) variant.

Define link-mode bit for 25Gbps long-range fiber (25000baseLR_Full).

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/net/phy/phy-core.c   | 2 +-
 include/uapi/linux/ethtool.h | 1 +
 net/ethtool/common.c         | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 3badf6e84554..cccd1316e145 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -18,7 +18,7 @@
  */
 const char *phy_speed_to_str(int speed)
 {
-	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 125,
+	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 126,
 		"Enum ethtool_link_mode_bit_indices and phylib are out of sync. "
 		"If a speed or mode has been added please update phy_speed_to_str "
 		"and the PHY settings array.\n");
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index ce9aeb65a8e1..51929f3e00d9 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2094,6 +2094,7 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_1600000baseKR8_Full_BIT	 = 122,
 	ETHTOOL_LINK_MODE_1600000baseDR8_Full_BIT	 = 123,
 	ETHTOOL_LINK_MODE_1600000baseDR8_2_Full_BIT	 = 124,
+	ETHTOOL_LINK_MODE_25000baseLR_Full_BIT		 = 125,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 4036561b078b..0010debce4e6 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -237,6 +237,7 @@ const char link_mode_names[][ETH_GSTRING_LEN] = {
 	__DEFINE_LINK_MODE_NAME(1600000, KR8, Full),
 	__DEFINE_LINK_MODE_NAME(1600000, DR8, Full),
 	__DEFINE_LINK_MODE_NAME(1600000, DR8_2, Full),
+	__DEFINE_LINK_MODE_NAME(25000, LR, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
@@ -464,6 +465,7 @@ const struct link_mode_info link_mode_params[] = {
 	__DEFINE_LINK_MODE_PARAMS(1600000, KR8, Full, K),
 	__DEFINE_LINK_MODE_PARAMS(1600000, DR8, Full, D),
 	__DEFINE_LINK_MODE_PARAMS(1600000, DR8_2, Full, D),
+	__DEFINE_LINK_MODE_PARAMS(25000, LR, Full, L),
 };
 static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 EXPORT_SYMBOL_GPL(link_mode_params);

-- 
2.43.0



