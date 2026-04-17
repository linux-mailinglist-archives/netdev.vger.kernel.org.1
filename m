Return-Path: <netdev+bounces-279392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KBxNApy4mnR5wAAu9opvQ
	(envelope-from <netdev+bounces-279392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:46:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B04D41DABD
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69C57300B859
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B8038E129;
	Fri, 17 Apr 2026 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="QLOEjmhq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C403630AC;
	Fri, 17 Apr 2026 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447883; cv=fail; b=FLGf5zUhDK8dUOjw4IbwkyYTVj+HeYQPBVFFDQmQMsCx62JMaxxgBOo373ANwH4X+rGTgp8cQ9j7qE4oiz9LXMMbw3IyCDyze+mL1c0FJBxSZNkY4+L0zeE4w1DUbHKwEihyO9dT8opw4J/CUq1ZswJTElbQleEV2NOc9E+lVA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447883; c=relaxed/simple;
	bh=o6PvSCxL4130hHWj56No39jdjREVnpQ/kUHkmwl3+GE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tu1TcYcbTMnlvj6wl2xlB7ggt0mhxYBlxmlbc0AZyfobh2XHV2Rjf+S/kYFo6NRC+OqkWKiUbGOWmPI7CO3U0jxTjgX/gPVw/O2ypkvdMFdmRDTKSuqjPFBPeKcSvnNwwSbpYnry3xonqxU5Yyq+vRdIbyvUEE72R9+s/tePaes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=QLOEjmhq; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HG4Jqs602797;
	Fri, 17 Apr 2026 10:44:15 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023101.outbound.protection.outlook.com [40.93.201.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dkr2f07vx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 10:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TA/AvFCwEC+/sV6Nx0Amv7gyyDzhIT4ELnVF5quKFNfX/RnFE3xloFvuN6dAGCka59BFdQbJhyZ6Ym2LvhJ8anZ89cmnUbS5NRkrsyxxbZkqMntAUK9B+mMWsaZgq5J1xd3lpGoqqhhB5/b2/cVNmMUURP8arSU6J0TzARPp7Nz0w+JLl6gd7s2JEeShJVtqecW4paIxHD21orzmCucZUSX3ZS33BRw2gSIcoWK1PPTk0YX7/6KRwofcTw/WbbIf01MUPqZne89C56xyiILbM99HnpUNERIEX7JZFrk7ASxXHm8+vklWd55oT0b18ToZnxzznKRdqOdCqdf2SBbvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6PvSCxL4130hHWj56No39jdjREVnpQ/kUHkmwl3+GE=;
 b=xL+3uBwA4lRDHWrqtcRaNX/jyGgBCHxQrSS5kb6e7B/2jRECL+s9IKXXAy2AoGkhNtir0DpQbATG1CX+0vtv0IoOsb+BQrDx8fk7K4Sp9bYk7yb5dY4iEHA55xuIkzleSyLcm43/V+Au1GL6Q5hiGvBFdSRieCi31qtuHq8vdnV5bMIIyDYx8unHlArmsfjv+3nU8lscoIp8VycIo8X+/hm4slwGm2FeTILS7AePgVAorE8apWMwdWA/UC+WQ7kWXLqAvC/wxk6xqBx5x6RKBgg/Xci8sF9L7SBzeUq3GVd3HWyLCgO5FjIrnxJqsRSEqnf2X03Cc8TrBqXUUqj9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6PvSCxL4130hHWj56No39jdjREVnpQ/kUHkmwl3+GE=;
 b=QLOEjmhqEPb84kUM3zNvFuw7XYZyZ+LW9huujVu5WUE2pnlUdgDlg9ozFB4sAUgPd4ugQHpq5AHRjWDEfyXVn8iwpQtvUDb6TE8qyVkfiqDyTJ2I65qn+MFmT9c9BuVfNhLwZSVlcnSrC9+gwWyIvBehP5TlVV89Ci5cQUJE/Dw=
Received: from BYAPR18MB3735.namprd18.prod.outlook.com (2603:10b6:a02:ca::16)
 by BL1PPF96BC1DEAC.namprd18.prod.outlook.com (2603:10b6:20f:fc04::dab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.41; Fri, 17 Apr
 2026 17:44:11 +0000
Received: from BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3]) by BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 17:44:11 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Minda Chen <minda.chen@starfivetech.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S
 . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Emil Renner Berthing
	<emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE:[net-next v2 4/5] net: stmmac: starfive: Add JHB100 SGMII
 interface
Thread-Topic: [net-next v2 4/5] net: stmmac: starfive: Add JHB100 SGMII
 interface
Thread-Index: AQHczpHMqA13vmq1C0eXrEvQ6N/EqQ==
Date: Fri, 17 Apr 2026 17:44:11 +0000
Message-ID:
 <BYAPR18MB3735BA5A7D35AFFE8DF4BE67A0202@BYAPR18MB3735.namprd18.prod.outlook.com>
References: <20260417024523.107786-1-minda.chen@starfivetech.com>
 <20260417024523.107786-5-minda.chen@starfivetech.com>
In-Reply-To: <20260417024523.107786-5-minda.chen@starfivetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR18MB3735:EE_|BL1PPF96BC1DEAC:EE_
x-ms-office365-filtering-correlation-id: 3533cf81-f42c-4af7-d8f0-08de9ca8ef20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 pqqEpHTvdXvusHTIgZAsl0yHP4aqxaig7zzhIjSp9yLwydcHDn89e1PKf85BM3iDASQUUlA94Heg461Hhkc0E345A2rExDRQ1Umg604xWbbs03kX6MdBgqS9JexxJT7RPb0Lu45f+2Pd064GKevs53gBgyeX6GHrEjHYjA8HHfljkr6uUBvlqflmQSdrVlZHpPHrPVjVcjwtRpg8YxOIa90mwQa02e2x9+g7xc3bUAtHH2nS8Td953edTosM5QYkSyo2Wqi8eMAhi7Nn2+D3j26yrcsltwFxlolnXZPmRWd4d/3q6TQp5vNBwPJsZDXRK8ri/amTH6CxDZ4N9QhWi9Xbig8a3ZFAGSi6il1AYIVXp7Ll8W+RV5hXpPfpD0/86OT7qiWKpZUis4o96VTp8z55IkIff1wt9gyVZO/mFDJXVvNuiUIHNy1EvJI0ntHGLUyV7jOFSW3FhJIIUFuTwCEVWOhWmc9QzsL2MP43UBWyFq5uCCCTOxgMg072Fm5fYRM/Mjjt+4S66M9oDUoneB7cJdOjcTHJWkOMpIv0/xZ+410Mzyul+tcS66ZKjcakL9RyjXj2hWlUmPnUwvYr62RNZl6Ek1fSPMF/yMITz85/U9+/xpsHL/2LK+AKc+qLaPouvqzag4CfJfviKBr9j08jInl3CYGPbDN0EOfkAlGVDBdkAo5P0p9k/P0Gc3ccxbO4+muaCHCOVWAuaa0/veYSoQQV1xSWVvCAIyQ2i4OVT1AMVZ5OmzgKOm3iQIZ45qI0EiWYoScgmSnlfUojQPJYhQqf7Yy8gkmPPocwq5hdQ8M/L3TJjNoB2ab/bL4K
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB3735.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0RZYVF4Vi9YdjFYOWxYWTJtYmFHaVFYMmVxUGdOTEVSaW5wSjZ2ditsTEdq?=
 =?utf-8?B?QzlmRk9QNGF3OFJrU1E4SUpUT3IwQnc3NEF3RmtwYUtLQXZDYm16eTYxYUhE?=
 =?utf-8?B?ZUd4RE9QbVl0aDhad1pBTXZhNHNER2w4bTlzNnp3UWlQclY3cEJTTitid1Nv?=
 =?utf-8?B?WTZ6OTlQcDRVeSt6dWJtZW1CYzc2S3BGbUQ0SU1rQXNyQW1EQWlTaTg4UnhU?=
 =?utf-8?B?dHc5R3VVSlk3ZFV1T0haa3UwWldKMlExNkc0WUIxOWtQZ3RBTFFUZ2tWRDYx?=
 =?utf-8?B?ZlEwak5JWGtoOVJFMm5FNUxEZ29KVUhiY2F4M0Z4S2h5cHhoVjVrZFY0bElv?=
 =?utf-8?B?UW11dE5xS3NjMTcveGVIOTlSaTE4RGExYmZVWm55MEpSM2RlMVFzRWdVUitD?=
 =?utf-8?B?TEt1RjFCRXNJMFJOSUFlbXo5Z214ZGt2NE0xQ0VUSU9RUDNyMjNrclZRa0JH?=
 =?utf-8?B?c3hnUVl5cldCNC9RdXFDTEVZQ3pNQTZFVUpzVE15cGNLQnlrSUhBTWpWalA3?=
 =?utf-8?B?U2M3YmFnV3lac3BiZm5GUUpKQ1J3VkF3c3ZaMTY4QjBkaEVkWFl4c3YrWSs3?=
 =?utf-8?B?R0dETzNIYzFtb0hSZ29sRlpmMkUwNVU5ampkU1M0WHQvVFFoejhxamxObjl5?=
 =?utf-8?B?dzUxZFlvdUU4VzY1eDhEK1gvWDE0T2dXakVIWWdsSTllNGQ4THYzUExEcEh6?=
 =?utf-8?B?MHdPVTlFSmlQQkwwS1IveHdnNklQb01USlk2K3M4eVNnVWRnZW8wT0krUmh5?=
 =?utf-8?B?T2ZOVXV2RGFnTW5qTW5QYk5KY3hva3pCdmdncmNpYzU3RGtCZ216ZUFuUkRk?=
 =?utf-8?B?NHE1b2xiY0xjSnZOQWpGdFM1NDVtRDF5anFpbTNmb2k4aXVBcERjSXF3ZndV?=
 =?utf-8?B?bnRKN3FFZnFSTThwQlRwQ1Fic3lnZTFFUU9SYmdoQ0E5c08ya01xVUFtZEd4?=
 =?utf-8?B?VEZLb2ZzOTdMM0x6dmkvbWlneUpMRlR4NmxzMHlUcXRyVGZ6YnFZbjBSWkxm?=
 =?utf-8?B?dndYZHFFeFNFWXFySXVYUm5mb1RyTkZBaXZpMTBGMG1GL3RGMTNzRjRsWjJM?=
 =?utf-8?B?dUt1SWovdDNjRWZFL0R6RzhvMDNFcUZjM09QM2tTRXBsTnJmYWFYWEZWajZl?=
 =?utf-8?B?OHIvR0JsWWI5aGNSVEZlSVdYOG9CbC9jVE00MXoyckZ0a0hEZjFnRTc3c1Fk?=
 =?utf-8?B?a3FEY3BGQjNWSFJRa1VETUs4eDNXRzhZSUxvbmFiM1lRY3pXUnNBdjc0K2Fo?=
 =?utf-8?B?dkViK3RncytMN0F0cWhJWGFBVk16OUUrZStHVTNOSjN4WWFjb05mQ1JWMlFC?=
 =?utf-8?B?Z2pMb08vWEpmSEpNd01JUU9LNDM2aFRQTGtMaXF1OVVyVC8xQlZ1a2hhNHJv?=
 =?utf-8?B?SnJXRS8vV0VOQ0RKNjFPbXI0d2RvRE1wZGVPU2MyaU5CUGJzYkVuSEtVeElF?=
 =?utf-8?B?T01uVFhrZ2RFNWlFcEFNTXRTdkNNSEcyQkR4T0RNelJ5WmNCb1B2dEJMUEhp?=
 =?utf-8?B?dnhkTXY5NCs5eG40OEZVY3FmNWlBa0V5dXNyYWFSV2Z0dm11SFhJckYreXQ3?=
 =?utf-8?B?MkdsVE8wNGtOZXNLNjY0Q2xwOGIwbnU4KzNIMzA3UHk5TG5oY25FUVRxaWZW?=
 =?utf-8?B?bzFVWFZsWUhFYWdCWmdXRXFUQUhQM2h4YWZvd29DbDlRMER5RExTNit4WEVp?=
 =?utf-8?B?WEJVQlc5SjRTWXR1RmNsY1c1TCtjOWdaR1RzbDV3N3BERW5yR29rQ2JoWFV0?=
 =?utf-8?B?U01vTUQzemRpSVpuRitTL2E1ZlZBZVphd3VLbFh1VW9LNEwwWXltWW5kcllG?=
 =?utf-8?B?T1pmQUxHUXhHY0wwZURNaGttQnA3MEE2TjNvUTN3ZjBOeEV0RkhBRHkzYWd5?=
 =?utf-8?B?K0ljdVFGcEdiUDRjLzF5TVd1S0VSeUc4MWM2aklENUM0bk51WUl5eFVxZENm?=
 =?utf-8?B?b2tYdFk4L0FyS0FQckNvUUFiRHhEWVJ1eVBsa0NrMHJ4TUZCWlBwTHNRMTd5?=
 =?utf-8?B?dlg2YW1CWVlGNHdCaXY4ODR3U3IzZEd6MzlDVTFVbURIb29lNHJldjd4bGpQ?=
 =?utf-8?B?a1lRSE40Q3BBdGJHb3RVVTFueS9UdTVrb3o2dGtLR1RaU0ZwcEc5bExpOUxG?=
 =?utf-8?B?Q0k4a2k4YThyNkk2d05FNXp4L2VkdVU5dGQ1bFhUUVBNZ2p1a2tmZXUyQnZ2?=
 =?utf-8?B?NmpTVHk0S3l1TnlCUFF6MkxBKzUraEFXNFRiUnBLRU5STGcyZEg1VEdqNjUr?=
 =?utf-8?B?a3dhVks3dnRMUnBSTnFUWjIyME1NckFweW5nMHRJc3Z2MjZQVDVha0pmSkdO?=
 =?utf-8?B?dWpodkVqeFRUanYyajNzbEU1Q1dSZCtuTXRoWmFVTHZIdytRTXozZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hDE1ekwRlYY1DSWG/B+UUfjuKWlonJQ6hsmwHOZoJ0/ehkzl5s+tJ4cBZXXoTY+XlABOwWvB+kONPK9bR9t/jjaHtol4DQ5ZMcfYJ3mZBPvAPkphhDWpZpsQQrJZNARraOhI7zItWQ0SlqIasyQVHqU6uCXLfSD4flYoBg5J8i4eg1YM7wiF73nEuM90pShn28D4/5XfOs3RClse6zuXQKjm0W5bJ0pPP7Rimm+OkAjLJFonxZBxu7p/voEAjG5omGAch1eUVMKczqGZhfDuxwppchIwD3d1nkOr04/zDKZjvgqioMg+simQQmUISPRGFQusu/DrpHl6GbuNE7H6Gw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB3735.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3533cf81-f42c-4af7-d8f0-08de9ca8ef20
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 17:44:11.3002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKplryBNp3lpx0WPHSpqKxI4J8CYx7r+lnZtiSvgbUAknmZyUtDNQhtX5NWgua6IJ7fTiSIZ2+pJlDUDU5D5nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF96BC1DEAC
X-Proofpoint-GUID: cLw_dWgoUR-5tCJBjx61PYtBxIBSsXo7
X-Proofpoint-ORIG-GUID: cLw_dWgoUR-5tCJBjx61PYtBxIBSsXo7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE3NyBTYWx0ZWRfX2YDdywcAY/1f
 AbSF8mrc9Tm/22DPlYADdzitfaysyMhX+TTqhgWjNsmTBwyEBE8dwkEyuvGVfP5Hzk8x6hjX+MI
 7NSJOlwQR6uWL5XAsqrVE8aU6DzQFBJk4rVveVgbz6YJjt9IyrsofC9mKQloJ2vPs01mSsVorC4
 Gcro1w9AgVsKShNEGsN6UQoQVzwDWqo9nngBPMy3zNQH9egYX4zRrf0v6zZxK7IeTqBdoCSNkZ1
 nskmIHLFEJ9jd9ZRhnFownJDK6M6jt8kkpgRdhtZjH76viwQo8iUq4ugls300RSteEHg1Ja6TYX
 juWIqF/NE5hIuY5BpEE8bz/jhCyJ0fi3ZZqDrdbsuD9xzTe/nm3csM8YgqQfyUUBFdGMSsa1s4l
 y4Lq2HPju4QSn63du0YS+k7rAKro3uyRBkaW7dfv7q3uRDPJaJ+JcZqfwZYYshwkK64elVNxiir
 RtniH15nCwBVmhR3D/Q==
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=69e2716f cx=c_pps
 a=S0CpYmVZ9TPoM0rEAH/1JQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=Bq6zwJu1AAAA:8
 a=8b9GpE9nAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=DfNHnWVPAAAA:8 a=phlkwaE_AAAA:8
 a=M5GUcnROAAAA:8 a=3MEoauN7u4zEE-l-2g0A:9 a=QEXdDO2ut3YA:10
 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=rjTVMONInIDnV1a_A2c_:22 a=uKTQOUHymn4LaG7oTSIC:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-279392-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[starfivetech.com,foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[st-md:email,starfivetech.com:email,canonical.com:email,st.com:email,lunn.ch:email,marvell.com:dkim,marvell.com:email,davemloft.net:email,BYAPR18MB3735.namprd18.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[saikrishnag@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6B04D41DABD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pbmRhIENoZW4gPG1pbmRh
LmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxNywgMjAyNiA4
OjE1IEFNDQo+IFRvOiBBbGV4YW5kcmUgVG9yZ3VlIDxhbGV4YW5kcmUudG9yZ3VlQGZvc3Muc3Qu
Y29tPjsgQW5kcmV3IEx1bm4NCj4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMgLiBN
aWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0QGdv
b2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8NCj4gQWJl
bmkgPHBhYmVuaUByZWRoYXQuY29tPjsgTWF4aW1lIENvcXVlbGluDQo+IDxtY29xdWVsaW4uc3Rt
MzJAZ21haWwuY29tPjsgRW1pbCBSZW5uZXIgQmVydGhpbmcNCj4gPGVtaWwucmVubmVyLmJlcnRo
aW5nQGNhbm9uaWNhbC5jb20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsNCj4g
S3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5DQo+
IDxjb25vckBrZXJuZWwub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtc3RtMzJAc3QtbWQtDQo+IG1haWxtYW4uc3Rv
cm1yZXBseS5jb207IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBNaW5kYSBDaGVuDQo+IDxt
aW5kYS5jaGVuQHN0YXJmaXZldGVjaC5jb20+DQo+IFN1YmplY3Q6IFtuZXQtbmV4dCB2MiA0LzVd
IG5ldDogc3RtbWFjOiBzdGFyZml2ZTogQWRkIEpIQjEwMA0KPiBTR01JSSBpbnRlcmZhY2UNCj4g
DQo+IEFkZCBKSEIxMDAgY29tcGF0aWJsZSBhbmQgU0dNSUkgc3VwcG9ydC4gSkhCMTAwIHNvYyBj
b250YWlucyAyIFNHTUlJDQo+IGludGVyZmFjZXMgYW5kIGludGVncmF0ZWQgd2l0aCBzZXJkZXMg
UEhZLiBTR01JSSB3aXRoIHNwbGl0IFRYL1JYIE1BQyBjbG9jaw0KPiBhbmQgbmVlZCB0byBzZXQg
Mi7igIo1TS8yNU0vMTI1TSBUWC9SWCBjbG9jayByYXRlIGluIDEwTS8xMDBNLzEwMDBNDQo+IHNw
ZWVkIG1vZGUuIFNpZ25lZC1vZmYtYnk6ICANCj4gQWRkIEpIQjEwMCBjb21wYXRpYmxlIGFuZCBT
R01JSSBzdXBwb3J0LiBKSEIxMDAgc29jIGNvbnRhaW5zDQo+IDIgU0dNSUkgaW50ZXJmYWNlcyBh
bmQgaW50ZWdyYXRlZCB3aXRoIHNlcmRlcyBQSFkuIFNHTUlJIHdpdGggc3BsaXQgVFgvUlgNCj4g
TUFDIGNsb2NrIGFuZCBuZWVkIHRvIHNldCAyLjVNLzI1TS8xMjVNIFRYL1JYIGNsb2NrIHJhdGUg
aW4NCj4gMTBNLzEwME0vMTAwME0gc3BlZWQgbW9kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1p
bmRhIENoZW4gPG1pbmRhLmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gLS0tDQo+ICAuLi4vZXRo
ZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWMtc3RhcmZpdmUuYyAgfCA1NCArKysrKysrKysrKysr
Ky0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1t
YWMvZHdtYWMtc3RhcmZpdmUuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3Rt
bWFjL2R3bWFjLXN0YXJmaXZlLmMNCj4gaW5kZXggMTZiOTU1YTZkNzdiLi45MTY5OGM3NjNkYWMg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFj
LXN0YXJmaXZlLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMv
ZHdtYWMtc3RhcmZpdmUuYw0KPiBAQCAtMjYsNiArMjYsNyBAQCBzdHJ1Y3Qgc3RhcmZpdmVfZHdt
YWNfZGF0YSB7ICBzdHJ1Y3Qgc3RhcmZpdmVfZHdtYWMgew0KPiAgCXN0cnVjdCBkZXZpY2UgKmRl
djsNCj4gIAljb25zdCBzdHJ1Y3Qgc3RhcmZpdmVfZHdtYWNfZGF0YSAqZGF0YTsNCj4gKwlzdHJ1
Y3QgY2xrICpzZ21paV9yeDsNCj4gIH07DQo+IA0KPiAgc3RhdGljIGludCBzdGFyZml2ZV9kd21h
Y19zZXRfbW9kZShzdHJ1Y3QgcGxhdF9zdG1tYWNlbmV0X2RhdGEgKnBsYXRfZGF0KQ0KPiBAQCAt
NjgsNiArNjksMjQgQEAgc3RhdGljIGludCBzdGFyZml2ZV9kd21hY19zZXRfbW9kZShzdHJ1Y3QN
Cj4gcGxhdF9zdG1tYWNlbmV0X2RhdGEgKnBsYXRfZGF0KQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0K
PiANCj4gK3N0YXRpYyBpbnQgc3RtbWFjX3N0YXJmaXZlX3NnbWlpX3NldF9jbGtfcmF0ZSh2b2lk
ICpic3BfcHJpdiwgc3RydWN0IGNsaw0KPiAqY2xrX3R4X2ksDQo+ICsJCQkJCSAgICAgIHBoeV9p
bnRlcmZhY2VfdCBpbnRlcmZhY2UsIGludA0KPiBzcGVlZCkgew0KDQpwaHlfaW50ZXJmYWNlX3Qg
aW50ZXJmYWNlIGlzIGxpa2VseSB1bnVzZWQgaW4gc3RtbWFjX3N0YXJmaXZlX3NnbWlpX3NldF9j
bGtfcmF0ZSDihpIgbWF5IG5lZWQgX19tYXliZV91bnVzZWQgb3IgKHZvaWQpaW50ZXJmYWNlIHRv
IGF2b2lkIC1XZXJyb3I9dW51c2VkLXBhcmFtZXRlciBvbiBzdHJpY3QgYnVpbGRzLg0KDQo+ICsJ
c3RydWN0IHN0YXJmaXZlX2R3bWFjICpkd21hYyA9ICh2b2lkICopYnNwX3ByaXY7DQo+ICsJbG9u
ZyByYXRlID0gcmdtaWlfY2xvY2soc3BlZWQpOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwkvKiBN
QUMgY2xvY2sgcmF0ZSB0aGUgc2FtZSBhcyBSR01JSSAqLw0KPiArCWlmIChyYXRlIDwgMCkNCj4g
KwkJcmV0dXJuIDA7DQo+ICsNCj4gKwlyZXQgPSBjbGtfc2V0X3JhdGUoY2xrX3R4X2ksIHJhdGUp
Ow0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwlyZXR1cm4gY2xrX3Nl
dF9yYXRlKGR3bWFjLT5zZ21paV9yeCwgcmF0ZSk7IH0NCj4gKw0KPiAgc3RhdGljIGludCBzdGFy
Zml2ZV9kd21hY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSAgew0KPiAgCXN0
cnVjdCBwbGF0X3N0bW1hY2VuZXRfZGF0YSAqcGxhdF9kYXQ7IEBAIC0xMDIsMjQgKzEyMSwzNCBA
QA0KPiBzdGF0aWMgaW50IHN0YXJmaXZlX2R3bWFjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ICAJCXJldHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYsIFBUUl9FUlIo
Y2xrX2d0eCksDQo+ICAJCQkJICAgICAiZXJyb3IgZ2V0dGluZyBndHggY2xvY2tcbiIpOw0KPiAN
Cj4gLQkvKiBHZW5lcmFsbHksIHRoZSByZ21paV90eCBjbG9jayBpcyBwcm92aWRlZCBieSB0aGUg
aW50ZXJuYWwgY2xvY2ssDQo+IC0JICogd2hpY2ggbmVlZHMgdG8gbWF0Y2ggdGhlIGNvcnJlc3Bv
bmRpbmcgY2xvY2sgZnJlcXVlbmN5IGFjY29yZGluZw0KPiAtCSAqIHRvIGRpZmZlcmVudCBzcGVl
ZHMuIElmIHRoZSByZ21paV90eCBjbG9jayBpcyBwcm92aWRlZCBieSB0aGUNCj4gLQkgKiBleHRl
cm5hbCByZ21paV9yeGluLCB0aGVyZSBpcyBubyBuZWVkIHRvIGNvbmZpZ3VyZSB0aGUgY2xvY2sN
Cj4gLQkgKiBpbnRlcm5hbGx5LCBiZWNhdXNlIHJnbWlpX3J4aW4gd2lsbCBiZSBhZGFwdGl2ZWx5
IGFkanVzdGVkLg0KPiAtCSAqLw0KPiAtCWlmICghZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbCgm
cGRldi0+ZGV2LCAic3RhcmZpdmUsdHgtdXNlLXJnbWlpLQ0KPiBjbGsiKSkNCj4gLQkJcGxhdF9k
YXQtPnNldF9jbGtfdHhfcmF0ZSA9IHN0bW1hY19zZXRfY2xrX3R4X3JhdGU7DQo+ICsJaWYgKHBs
YXRfZGF0LT5waHlfaW50ZXJmYWNlID09IFBIWV9JTlRFUkZBQ0VfTU9ERV9TR01JSSkgew0KPiAr
CQlkd21hYy0+c2dtaWlfcnggPSBkZXZtX2Nsa19nZXRfZW5hYmxlZCgmcGRldi0+ZGV2LA0KPiAi
c2dtaWlfcngiKTsNCj4gKwkJaWYgKElTX0VSUihkd21hYy0+c2dtaWlfcngpKQ0KPiArCQkJcmV0
dXJuIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwNCj4gKwkJCQkJICAgICBQVFJfRVJSKGR3bWFj
LT5zZ21paV9yeCksDQo+ICsJCQkJCSAgICAgImVycm9yIGdldHRpbmcgc2dtaWkgcnggY2xvY2tc
biIpOw0KPiArCQlwbGF0X2RhdC0+c2V0X2Nsa190eF9yYXRlID0NCj4gc3RtbWFjX3N0YXJmaXZl
X3NnbWlpX3NldF9jbGtfcmF0ZTsNCj4gKwl9IGVsc2Ugew0KPiArCQkvKg0KPiArCQkgKiBHZW5l
cmFsbHksIHRoZSByZ21paV90eCBjbG9jayBpcyBwcm92aWRlZCBieSB0aGUgaW50ZXJuYWwNCj4g
Y2xvY2ssDQo+ICsJCSAqIHdoaWNoIG5lZWRzIHRvIG1hdGNoIHRoZSBjb3JyZXNwb25kaW5nIGNs
b2NrIGZyZXF1ZW5jeQ0KPiBhY2NvcmRpbmcNCj4gKwkJICogdG8gZGlmZmVyZW50IHNwZWVkcy4g
SWYgdGhlIHJnbWlpX3R4IGNsb2NrIGlzIHByb3ZpZGVkIGJ5IHRoZQ0KPiArCQkgKiBleHRlcm5h
bCByZ21paV9yeGluLCB0aGVyZSBpcyBubyBuZWVkIHRvIGNvbmZpZ3VyZSB0aGUgY2xvY2sNCj4g
KwkJICogaW50ZXJuYWxseSwgYmVjYXVzZSByZ21paV9yeGluIHdpbGwgYmUgYWRhcHRpdmVseSBh
ZGp1c3RlZC4NCj4gKwkJICovDQo+ICsJCWlmICghZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbCgm
cGRldi0+ZGV2LCAic3RhcmZpdmUsdHgtdXNlLQ0KPiByZ21paS1jbGsiKSkNCj4gKwkJCXBsYXRf
ZGF0LT5zZXRfY2xrX3R4X3JhdGUgPSBzdG1tYWNfc2V0X2Nsa190eF9yYXRlOw0KPiArDQo+ICsJ
CWVyciA9IHN0YXJmaXZlX2R3bWFjX3NldF9tb2RlKHBsYXRfZGF0KTsNCj4gKwkJaWYgKGVycikN
Cj4gKwkJCXJldHVybiBlcnI7DQo+ICsJfQ0KPiANCj4gIAlkd21hYy0+ZGV2ID0gJnBkZXYtPmRl
djsNCj4gIAlwbGF0X2RhdC0+ZmxhZ3MgfD0gU1RNTUFDX0ZMQUdfRU5fVFhfTFBJX0NMS19QSFlf
Q0FQOw0KPiAgCXBsYXRfZGF0LT5ic3BfcHJpdiA9IGR3bWFjOw0KPiAgCXBsYXRfZGF0LT5kbWFf
Y2ZnLT5kY2hlID0gdHJ1ZTsNCj4gDQo+IC0JZXJyID0gc3RhcmZpdmVfZHdtYWNfc2V0X21vZGUo
cGxhdF9kYXQpOw0KPiAtCWlmIChlcnIpDQo+IC0JCXJldHVybiBlcnI7DQo+IC0NCj4gIAlyZXR1
cm4gc3RtbWFjX2R2cl9wcm9iZSgmcGRldi0+ZGV2LCBwbGF0X2RhdCwgJnN0bW1hY19yZXMpOyAg
fQ0KPiANCj4gQEAgLTEzMCw2ICsxNTksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHN0YXJmaXZl
X2R3bWFjX2RhdGEgamg3MTAwX2RhdGEgPQ0KPiB7ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCBzdGFyZml2ZV9kd21hY19tYXRjaFtdID0gew0KPiAgCXsgLmNvbXBhdGlibGUgPSAi
c3RhcmZpdmUsamg3MTAwLWR3bWFjIiwgLmRhdGEgPSAmamg3MTAwX2RhdGEgfSwNCj4gIAl7IC5j
b21wYXRpYmxlID0gInN0YXJmaXZlLGpoNzExMC1kd21hYyIgfSwNCj4gKwl7IC5jb21wYXRpYmxl
ID0gInN0YXJmaXZlLGpoYjEwMC1kd21hYyIgfSwNCj4gIAl7IC8qIHNlbnRpbmVsICovIH0NCj4g
IH07DQo+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBzdGFyZml2ZV9kd21hY19tYXRjaCk7DQo+
IC0tDQo+IDIuMTcuMQ0KPiANClJldmlld2VkLWJ5OiBTYWkgS3Jpc2huYSA8c2Fpa3Jpc2huYWdA
bWFydmVsbC5jb20+DQo=

