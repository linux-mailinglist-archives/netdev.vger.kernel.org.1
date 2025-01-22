Return-Path: <netdev+bounces-160173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69DCA18A3B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 03:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863A27A1DAF
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 02:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676D1494AD;
	Wed, 22 Jan 2025 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a2AiVl5p"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72114885B;
	Wed, 22 Jan 2025 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737514244; cv=fail; b=ff9lZehoyOePydrPntizPvsvHdRI86b5KiUfG2Y/km0y7DOP6wokaZ/CnDX3Uf5zmpuhULMFc2TpJP5r1p59lJ3A8rz7F9MSdVfQi703p5J/QGxoOeBjsaGSRbBg5qT/gfXfVCqWxnL2xtjHsCjwzLCijWBmhlImWCB5qUkca2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737514244; c=relaxed/simple;
	bh=dHBBC24SUfu8E95gbirrtQboDneBQGmCxgZrZ4GgQfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vC+G2IMCoWB7ZIpxeezjTmpGEp4RU3BGhMW0RXTG4lrn8OMLkFtIQMaE6ydQX/cH6TiefF1g4DL2jcyO8XpI02jMx+W6tKTNideI8BpZ8FwSzX+MthZKEZEaWhm58mCQHgcKNCuknz+wlUHdgXIHyjHHJkgRbfl/O5SS63f4Das=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a2AiVl5p; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDs8GdoR6VO6DASWbOzdjSx6em+/3kYEmlaRstBB7dc0io33cpi3x0OMczRJEcKMnW29Pq9KPfF8z/BKTygxjbimHAw7YsofCvJGxmctU2uGIbmXNUaJujwurddHy8aCkPtXVKFXtngn0tPYoZFZW9Cc22QaXCyD2uE9A2qk4PBdYyFDDnTiekF5SGLb0AL1bpCUevBtHZGiTh9VKhEqNWy8QEbmj466BLpX3DSab32mcYWnFnW6naEe62LiOdnkfNc+mADAKFZkzq1xFDIz6ruY9JdldOBQ9Bymj+rZBC1LDYcV2Ya47iBzwn9x5J7OcilqsSbd7HqOWXp/FeP/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHBBC24SUfu8E95gbirrtQboDneBQGmCxgZrZ4GgQfs=;
 b=hgumUTKtRg1ZUzRX7hAtZIo1uSRa0lpRV4Xpc9V+bg6IrQwQmCmttztewpX7cpNNMtFqqKQYtkEoblp2GeRBVHqnyYbYgiscKC2P5wMyN/DeMEqqT5lIn/STIUxFAx/fteK1DF6c+lqd+LnrCZPrzwkB+fGrP8OCRoVkajQ2KAY/h528TTljRn2VZ3fImQDkoMcYnpPm9MP47c5cel8V/7JofaRloC6nUKXNmuvBDNDPgpLzmsNnWYGYip0iMZo0mHo7cH8i0d1Be/8miyIt/2t3DmjlTHglOa0ZC0EFuZsQy9hQaZu5sv69lyn1Nc3UkD1UOirio3/56cLKmWuvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHBBC24SUfu8E95gbirrtQboDneBQGmCxgZrZ4GgQfs=;
 b=a2AiVl5pC/DdLPGUZsjsQIUDWfriA1sIkKGLTmix5eRQTpQDhtSNvkzG1xN08x8dJPgm02PVKv/iqVRHqULzUS2KLMP2Dl4z0LUEASAqSOaEe4xp4rfXanohr2FzwKrEInvcVnQHwuLQuzQCT4QEyJE3HUvPae5xffC5BLdlBkLJyHHcOz/tK29QxbaRAs24V53VhmjbtIuAfIfFKX4/0sYRQ0g5OG5NtyGTyzUnlkEnlYz/DMOeQhkoCY09EFPMi+QFO6c2AFogC+TS/B+uauQ0k91iFhsxJi1qC+Hbc/NumivyRV1LVV4TKAOf1SgnxZII2a2AHi/iGIgZsJx5Sg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10357.eurprd04.prod.outlook.com (2603:10a6:102:452::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 02:50:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 02:50:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: =?utf-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>, Jakub Kicinski
	<kuba@kernel.org>, Laurent Badel <laurentbadel@eaton.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH] net: fec: Refactor MAC reset to function
Thread-Topic: [PATCH] net: fec: Refactor MAC reset to function
Thread-Index: AQHba/DYthtfnQG0IESWM+DbI5gUR7MiE13g
Date: Wed, 22 Jan 2025 02:50:39 +0000
Message-ID:
 <PAXPR04MB8510A8D8807A4EB3188E935788E12@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250121103857.12007-3-csokas.bence@prolan.hu>
In-Reply-To: <20250121103857.12007-3-csokas.bence@prolan.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10357:EE_
x-ms-office365-filtering-correlation-id: 7fff080c-5884-4721-b33b-08dd3a8f8e07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1dEU3BpVjJIdTFZdUJpdlNndktRbHJZckZZMVRIVEIzK3lOOVJKcGs4Qkc2?=
 =?utf-8?B?RXhaNG9MdHMvbmhrKzFTRWM5SHJydmpSQnh3alZlcVpIOUlFWDVHRFNFMkto?=
 =?utf-8?B?M3NRTTFMOW9vYnFxNUhjWHo5ME9rZW0yYmJmczNwa2xhWEdOVkc2ay9memJC?=
 =?utf-8?B?YWVJMkp4YnBJWXN4cWpxWHRzVmZUbE84eG9pajZTeittTitJL0xGZE1HdFlk?=
 =?utf-8?B?dWNiTDNKYmNMNTFuM0RMdFJGZDdMM2YreCsyYjlIVVZoZTkrbmpyblYxMHhx?=
 =?utf-8?B?L0VaRUlQVWMrRXMvN1dMMXFqQXlFaTVyb241VytGV2txTWU0bS9TWkdHOFJE?=
 =?utf-8?B?TkVDWjZPeXdsWUNUTWE4dGNSVDVsRnRWQzlYOEgrdUdYWjJTTWVlMlVqRE80?=
 =?utf-8?B?MUFGbHZxa01pQlozMTZaRnIxLy9GSzJyT0p0ZmVBL1ZNUzBsTkdHR3gwT1A4?=
 =?utf-8?B?VWl4MkN0bC9BajRkU2lIUjIyeHdrcWJrcm96bDJNV2pJUmV0RmhTbm1EQkRI?=
 =?utf-8?B?TWd0dWNnR052ZDVUMmM0bkJTWmlMRmJNYXc0dEdCTXZ2VmJTTHlDb0JFTFV4?=
 =?utf-8?B?V01mMStaWEcvVDJCd3dzSWlDQVhNMHp2ekhDSzZhNEIzU1kxWGxCdTNqd3lh?=
 =?utf-8?B?cVJWOC9wZjIyQm91ZXNUUHZYc2ExR2Q2ZDdJNXFYMFJoRFJaK1VXTjNtTWpQ?=
 =?utf-8?B?b084VnR0TFVHVmEzZEdOb3JVY3hlenNUYndwbndCMDFMTWxCdEcwR0FLQWpD?=
 =?utf-8?B?dm8zY2ZRbzB4M2pYL1pJaGxTMTBTa1hlcXJkZnU2VEU1TlJ6eDdsYVV4UXZZ?=
 =?utf-8?B?OG02VHp3M2FTY2ozTEJQcSt5a3VxMmxDT1p1MzAzdXN0aEtyaWI2M0FHdXJM?=
 =?utf-8?B?ejRkSkM2dUV5ejZubGNRNjRldGliTTlDaE1JTGtMSnR2Ly9SOTRnTHRiR1FT?=
 =?utf-8?B?SXpjRTFMaW90QmZFQmhMK1gxL1BMVWQ2ZWRTMmM1Q0JSN3ExeXZJbzU3bS91?=
 =?utf-8?B?T1NOYjdrZjVRQTVNcy9keEpOTTdOdGFUaUZrbXoyYWF2N0pEUlJlN0NPWnE0?=
 =?utf-8?B?dGQxL2JldFlCd0cvelpVakN0ZkpRdmFEOEFXeTJROHlqRzh3QmlXYkZCWFdP?=
 =?utf-8?B?QlF4Nk16SkRJVVJTUzFuZU5PV0dEMml2WGxFSXNvVU1UUCtiVWIrMHZoanVF?=
 =?utf-8?B?SytOZzNvY1l1cmdXaDVrYXlxYUpINWtaNlQwa3BSZWp0TU5aRjN5UjVERmNo?=
 =?utf-8?B?NTM1YkV1L3BQb0dRdUFYeGRyQ3doalRMOE5ZZXhRRjNBTDJhTGdZRkFQZFIw?=
 =?utf-8?B?dTVtTnViUmgxRi8xUmNWelVIR3pMcmlyOVZ1UXVZenRYV0hINjlDSXVrTFll?=
 =?utf-8?B?a2c4ekY4aEFhMUx2ZFNDaVpZRU9RTUtITXBhRDZUVUxxYWNiUExjWWhTRmpu?=
 =?utf-8?B?MDkyNXdBTHhsUy8wWXlzbFdtTlRROUNFd2RYVkJJZFIyMUUrMEFHOFV0eEJp?=
 =?utf-8?B?dkZpeXdKdm9iLzQwSXJGVHRhWkhxMGtLbDNLTUhoMzNXSEtrcFFXTXA1Uksx?=
 =?utf-8?B?L2ZoWVB0amQrbkN6UkQxUU8xQWQzditPbldVbTR4K0UxczNwZFNySnIvZGVD?=
 =?utf-8?B?Z2twbVJqaFZSUmw3SEdxR0U1eFF2dm82WmpzZ0JhVlpPL0xsdDhidFVOZXlJ?=
 =?utf-8?B?ZHRYSG5mVkVBZmdVblUvc1ZBZVJURWhEM3JTQlprY1FLbWplZDNlaW1tZ0ZR?=
 =?utf-8?B?NEZuMGhXaW1RSWZFYnMxdHllZjVyNzAyZ3FNODVqaTNjSXJFZEJyeXBXYm9n?=
 =?utf-8?B?N1AzejBSRVNOc0NVMVRaa1Y0Z255dnUzNjJOK0RzbEJMSUY4bGV0WGlnanE1?=
 =?utf-8?B?Q2l4a3lPbEdnank1UUZKTGJBK2lSMUZRSE1xZlFCcEV4RFFDbSt4cHN2eTNR?=
 =?utf-8?Q?q1Zb3Zu2/FQAo+1zphXA1AaznbX8VNC7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTBDSnpLVlNIeWcxRmFKV2FtYVJQZ05NbC9CMUh5KzZ1QjlnSzIyenZ6VHB3?=
 =?utf-8?B?KzRIZlZOb3NDVlpnQVBUbjdvOFhlY3dXd2RIdVlTZnBBZHgyanRoY3l5Tlhr?=
 =?utf-8?B?TlhYbmZpOEdjNUllaWJ1MXNWajZ5UWtHZHBOTkV5TEJoZ2FaSkQ4c3J1MnNX?=
 =?utf-8?B?SGhqcEhvbENqUSs2MEVic00yMWdSRmFjZVNEVndGbkZiOXhTM01aWXRoa3Bk?=
 =?utf-8?B?TDVUckpLZXFkZHNKUjFNUmZkb1ZXemJsaW5rZEdjZXM1NnVCenlIQ2h5eHFD?=
 =?utf-8?B?YzRGUnlwaC9uWjA5N1U1R0M4UkFxZFlTTnF1aVR3S1JjdFZRMlNUdG13d2ND?=
 =?utf-8?B?cXVvc0N0QWxrMFNCNVVqaVcrekQxMkcxTlRHbHhKajJaU0VqOVhLemdPMVkw?=
 =?utf-8?B?RVZjN0FyNThzb25EQUFwOFhWZHVFRCtRbCtKTlVhRkxlWGhQdi81RTZ5ZnNO?=
 =?utf-8?B?bjI0UTBnT3I4UnVjcllqWmR0TXgvOEhNNWwyVzZyOG5XL3BlS1ZEblNKaHIw?=
 =?utf-8?B?SWk1R0xmL3l1TzJMV2JXMGthbkNrN2RvTk9jbFRvV3gveFQ5YVh0VDhVYlNG?=
 =?utf-8?B?RXhwZmhKbmQ5TGRCV29SQWNpNEp6NjVRNGRLalNyZUVZZXlaSUdzWGhkN3NM?=
 =?utf-8?B?N1UyMStLNFVGYXZXR0tlQis4NUF3ajcvRktrNVBKT3pzcnJRWWFQS2g4R0RK?=
 =?utf-8?B?U3kwWW9tMWVYZDA5cnB4OVdKYTFvU0JSN0dCUHJXbENWWGRDeEdZdlora21L?=
 =?utf-8?B?WXE1NTM2WTJyRWdleFlLS1FVb3RNRm5BbWdJd3JHcGtuTXhQRjYyTDZZci83?=
 =?utf-8?B?RHVPRmxLTjUrcGlqM1cyYVgrTkpaZndMUG12cGRVMWRlN01FR0IvdXNYMS9o?=
 =?utf-8?B?YWRvUmtwWXZEU3JSL000b0dnQnBlZFBjcEJDK0xTVDNDM25lM1hHbHRGZ0VQ?=
 =?utf-8?B?a0FKMzZaVWpia2d4citFQ1pWVGx0TEZPckcvUVd1YUsxMUM4VEtOdVlGVUN3?=
 =?utf-8?B?K2VvU1lLUDc1MFRtNithZDF5ZHJYUlBldXJWN3daM1FYemZ2dENFOS9mNWlD?=
 =?utf-8?B?QjJvZ1NTTFVOeGRYeklvRW5kc1VyYmtUczZDNFRFeUJCM29ncnJWUzhhbWp0?=
 =?utf-8?B?WXFmZWhaaUorWHVQd0pCQjdObjFDMm1GSllYNXRkWnp2bk5veTRxdzdrR0E0?=
 =?utf-8?B?Z040L1JPUHp6OE9DTDI3enhVOEtidGlLZ083UEpCd0xLWXVRZCtzcmdESDRO?=
 =?utf-8?B?QlVuLzE4RFBJZWV5R1JxM0JiTUwzSVM3UmQ4TnFmZVFpd2dJUTZiSkNJRjFr?=
 =?utf-8?B?ZFYxZ3pjSXFNN3kxV0x0WjVjQnlnOXNucHZ1U3Jpb080S0tXT1llOVpiVUJW?=
 =?utf-8?B?L2RjWVZjYjdJLzhUV1pTK2tydDBOS3NOQ2doU2lhdHBva3dEVWR6Y1FIQmR5?=
 =?utf-8?B?RWJzT2hVZTgwcVFrdjBNejdjTFYwN1JPelVGTnVVdHZHN2pnajJwNnFwMFpL?=
 =?utf-8?B?bjdoVEcyeDFtTFFrZERqMEFMSHFHTi9qZzE4L05pUGNCQ3RtVWowK3ppbHdO?=
 =?utf-8?B?WnFkdEljdzVDbE5YQ0pPUDllV01IdklYQkU2N0piN2dEMXdSdG1yV2w3YkJR?=
 =?utf-8?B?RWNtOG4vOURKc3lVRFgveGJocGRGMUI3OGlOUG4wS2R3TC9lNGM3WUNnVjU5?=
 =?utf-8?B?LzhJVC8rcEhNdWdlRDkycmJBUDBPVjA4WFJpREtpeDd2RlNKd1B1cCtEUVNp?=
 =?utf-8?B?anM5b1d1QlJmclYrK2xiM2dUR05XNC9XQnJyQjRNSURVU016UDcxSWlMSE8y?=
 =?utf-8?B?QVJ5NkZuSjVMNjZXWFZESys2cUREMklFUDBocFBRZlZwbzBOVzB1T1BETm81?=
 =?utf-8?B?RDl5b3M3dTF1d2s1YXRjRXh2Vld3THFZUXhib2RRNzcvV2F5djNhQThxVUNp?=
 =?utf-8?B?ZnBpT25DZXh5NnYzRTg3WjQzS1A0V002aVBhL2NGYlB3RllHVVBZeC9SRndS?=
 =?utf-8?B?enFmTnRKLytBY0RNbjJhMUQva28vczlMR2dlWXBBWDM0ZnZIWkFpd1hHd0tq?=
 =?utf-8?B?clVBUm8wM211TUlxQUVweGttbThVQkpMQzZKR0EwZ0swUHRoMUF4T2FKOXFN?=
 =?utf-8?Q?XNyI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fff080c-5884-4721-b33b-08dd3a8f8e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 02:50:39.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRYLnq/bronsKOTsjTRmNQTzZIk4wyVt2g+uUUu//bb+zPy0i8ST9whjFsBJy8z14j36HIq5zVFxVJ3MokJLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10357

PiBUaGUgY29yZSBpcyByZXNldCBib3RoIGluIGBmZWNfcmVzdGFydCgpYA0KPiAoY2FsbGVkIG9u
IGxpbmstdXApIGFuZCBgZmVjX3N0b3AoKWANCj4gKGdvaW5nIHRvIHNsZWVwLCBkcml2ZXIgcmVt
b3ZlIGV0Yy4pLg0KPiBUaGVzZSB0d28gZnVuY3Rpb25zIGhhZCB0aGVpciBzZXBhcmF0ZQ0KPiBp
bXBsZW1lbnRhdGlvbnMsIHdoaWNoIHdhcyBhdCBmaXJzdCBvbmx5DQo+IGEgcmVnaXN0ZXIgd3Jp
dGUgYW5kIGEgYHVkZWxheSgpYCAoYW5kDQo+IHRoZSBhY2NvbXBhbnlpbmcgYmxvY2sgY29tbWVu
dCkuDQo+IEhvd2V2ZXIsIHNpbmNlIHRoZW4gd2UgZ290IHNvZnQtcmVzZXQNCj4gKE1BQyBkaXNh
YmxlKSBhbmQgV2FrZS1vbi1MQU4gc3VwcG9ydCwNCj4gd2hpY2ggbWVhbnQgdGhhdCB0aGVzZSBp
bXBsZW1lbnRhdGlvbnMNCj4gZGl2ZXJnZWQsIG9mdGVuIGNhdXNpbmcgYnVncy4gRm9yIGluc3Rh
bmNlLA0KPiBhcyBvZiBub3csIGBmZWNfc3RvcCgpYCBkb2VzIG5vdCBjaGVjayBmb3INCj4gYEZF
Q19RVUlSS19OT19IQVJEX1JFU0VUYC4gVG8gZWxpbWluYXRlDQo+IHRoaXMgYnVnLXNvdXJjZSwg
cmVmYWN0b3IgaW1wbGVtZW50YXRpb24NCj4gdG8gYSBjb21tb24gZnVuY3Rpb24uDQo+IA0KPiBG
aXhlczogYzczMGFiNDIzYmZhICgibmV0OiBmZWM6IEZpeCB0ZW1wb3JhcnkgUk1JSSBjbG9jayBy
ZXNldCBvbiBsaW5rIHVwIikNCj4gU2lnbmVkLW9mZi1ieTogQ3PDs2vDoXMsIEJlbmNlIDxjc29r
YXMuYmVuY2VAcHJvbGFuLmh1Pg0KPiAtLS0NCj4gDQo+IE5vdGVzOg0KPiAgICAgUmVjb21tZW5k
ZWQgb3B0aW9ucyBmb3IgdGhpcyBwYXRjaDoNCj4gICAgIGAtLWNvbG9yLW1vdmVkIC0tY29sb3It
bW92ZWQtd3M9YWxsb3ctaW5kZW50YXRpb24tY2hhbmdlYA0KPiANCj4gIGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIHwgNTAgKysrKysrKysrKystLS0tLS0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4u
Yw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGluZGV4
IDY4NzI1NTA2YTA5NS4uODUwZWYzZGU3NGVjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiBAQCAtMTA2NCw2ICsxMDY0LDI3IEBAIHN0YXRpYyB2
b2lkIGZlY19lbmV0X2VuYWJsZV9yaW5nKHN0cnVjdCBuZXRfZGV2aWNlDQo+ICpuZGV2KQ0KPiAg
CX0NCj4gIH0NCj4gDQo+ICsvKiBXaGFjayBhIHJlc2V0LiAgV2Ugc2hvdWxkIHdhaXQgZm9yIHRo
aXMuDQo+ICsgKiBGb3IgaS5NWDZTWCBTT0MsIGVuZXQgdXNlIEFYSSBidXMsIHdlIHVzZSBkaXNh
YmxlIE1BQw0KPiArICogaW5zdGVhZCBvZiByZXNldCBNQUMgaXRzZWxmLg0KPiArICovDQo+ICtz
dGF0aWMgdm9pZCBmZWNfY3RybF9yZXNldChzdHJ1Y3QgZmVjX2VuZXRfcHJpdmF0ZSAqZmVwLCBi
b29sIHdvbCkNCg0KJ3dvbCcgZ2l2ZXMgbWUgdGhlIGZlZWxpbmcgdGhhdCBpdCBpbmRpY2F0ZXMg
d2hldGhlciB0aGUgV09MIGZ1bmN0aW9uDQppcyBlbmFibGVkLiBBbmQgdGhlIGVsc2UgYnJhbmNo
IHdpbGwgYmUgdGFrZW4gaWYgJ3dvbCcgaXMgdHJ1ZS4gQnV0IGluIGZhY3QsDQpldmVuIGlmICd3
b2wnIGlzIHRydWUsIGl0IG1heSBnbyB0byB0aGUgcmVzZXQgYnJhbmNoLiBUaGlzIGlzIGEgYml0
IGNvbmZ1c2luZy4NCg0KSG93IGFib3V0IHRoZSBmb2xsb3dpbmcgY2hhbmdlcz8NCg0Kc3RhdGlj
IHZvaWQgZmVjX2N0cmxfcmVzZXQoc3RydWN0IGZlY19lbmV0X3ByaXZhdGUgKmZlcCwgYm9vbCB3
b2wpDQp7DQoJaWYgKHdvbCkgew0KCQl1MzIgdmFsOw0KDQoJCXZhbCA9IHJlYWRsKGZlcC0+aHdw
ICsgRkVDX0VDTlRSTCk7DQoJCXZhbCB8PSAoRkVDX0VDUl9NQUdJQ0VOIHwgRkVDX0VDUl9TTEVF
UCk7DQoJCXdyaXRlbCh2YWwsIGZlcC0+aHdwICsgRkVDX0VDTlRSTCk7DQoJfSBlbHNlIGlmIChm
ZXAtPnF1aXJrcyAmIEZFQ19RVUlSS19IQVNfTVVMVElfUVVFVUVTIHx8DQoJCSgoZmVwLT5xdWly
a3MgJiBGRUNfUVVJUktfTk9fSEFSRF9SRVNFVCkgJiYgZmVwLT5saW5rKSkgew0KCQl3cml0ZWwo
MCwgZmVwLT5od3AgKyBGRUNfRUNOVFJMKTsNCgl9IGVsc2Ugew0KCQl3cml0ZWwoRkVDX0VDUl9S
RVNFVCwgZmVwLT5od3AgKyBGRUNfRUNOVFJMKTsNCgkJdWRlbGF5KDEwKTsNCgl9DQp9DQoNCj4g
K3sNCj4gKwlpZiAoIXdvbCB8fCAhKGZlcC0+d29sX2ZsYWcgJiBGRUNfV09MX0ZMQUdfU0xFRVBf
T04pKSB7DQo+ICsJCWlmIChmZXAtPnF1aXJrcyAmIEZFQ19RVUlSS19IQVNfTVVMVElfUVVFVUVT
IHx8DQo+ICsJCSAgICAoKGZlcC0+cXVpcmtzICYgRkVDX1FVSVJLX05PX0hBUkRfUkVTRVQpICYm
IGZlcC0+bGluaykpIHsNCj4gKwkJCXdyaXRlbCgwLCBmZXAtPmh3cCArIEZFQ19FQ05UUkwpOw0K
PiArCQl9IGVsc2Ugew0KPiArCQkJd3JpdGVsKEZFQ19FQ1JfUkVTRVQsIGZlcC0+aHdwICsgRkVD
X0VDTlRSTCk7DQo+ICsJCQl1ZGVsYXkoMTApOw0KPiArCQl9DQo+ICsJfSBlbHNlIHsNCj4gKwkJ
dmFsID0gcmVhZGwoZmVwLT5od3AgKyBGRUNfRUNOVFJMKTsNCj4gKwkJdmFsIHw9IChGRUNfRUNS
X01BR0lDRU4gfCBGRUNfRUNSX1NMRUVQKTsNCj4gKwkJd3JpdGVsKHZhbCwgZmVwLT5od3AgKyBG
RUNfRUNOVFJMKTsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIC8qDQo+ICAgKiBUaGlzIGZ1bmN0aW9u
IGlzIGNhbGxlZCB0byBzdGFydCBvciByZXN0YXJ0IHRoZSBGRUMgZHVyaW5nIGEgbGluaw0KPiAg
ICogY2hhbmdlLCB0cmFuc21pdCB0aW1lb3V0LCBvciB0byByZWNvbmZpZ3VyZSB0aGUgRkVDLiAg
VGhlIG5ldHdvcmsNCj4gQEAgLTEwODAsMTcgKzExMDEsNyBAQCBmZWNfcmVzdGFydChzdHJ1Y3Qg
bmV0X2RldmljZSAqbmRldikNCj4gIAlpZiAoZmVwLT5idWZkZXNjX2V4KQ0KPiAgCQlmZWNfcHRw
X3NhdmVfc3RhdGUoZmVwKTsNCj4gDQo+IC0JLyogV2hhY2sgYSByZXNldC4gIFdlIHNob3VsZCB3
YWl0IGZvciB0aGlzLg0KPiAtCSAqIEZvciBpLk1YNlNYIFNPQywgZW5ldCB1c2UgQVhJIGJ1cywg
d2UgdXNlIGRpc2FibGUgTUFDDQo+IC0JICogaW5zdGVhZCBvZiByZXNldCBNQUMgaXRzZWxmLg0K
PiAtCSAqLw0KPiAtCWlmIChmZXAtPnF1aXJrcyAmIEZFQ19RVUlSS19IQVNfTVVMVElfUVVFVUVT
IHx8DQo+IC0JICAgICgoZmVwLT5xdWlya3MgJiBGRUNfUVVJUktfTk9fSEFSRF9SRVNFVCkgJiYg
ZmVwLT5saW5rKSkgew0KPiAtCQl3cml0ZWwoMCwgZmVwLT5od3AgKyBGRUNfRUNOVFJMKTsNCj4g
LQl9IGVsc2Ugew0KPiAtCQl3cml0ZWwoMSwgZmVwLT5od3AgKyBGRUNfRUNOVFJMKTsNCj4gLQkJ
dWRlbGF5KDEwKTsNCj4gLQl9DQo+ICsJZmVjX2N0cmxfcmVzZXQoZmVwLCBmYWxzZSk7DQo+IA0K
PiAgCS8qDQo+ICAJICogZW5ldC1tYWMgcmVzZXQgd2lsbCByZXNldCBtYWMgYWRkcmVzcyByZWdp
c3RlcnMgdG9vLA0KPiBAQCAtMTM0NCwyMiArMTM1NSw3IEBAIGZlY19zdG9wKHN0cnVjdCBuZXRf
ZGV2aWNlICpuZGV2KQ0KPiAgCWlmIChmZXAtPmJ1ZmRlc2NfZXgpDQo+ICAJCWZlY19wdHBfc2F2
ZV9zdGF0ZShmZXApOw0KPiANCj4gLQkvKiBXaGFjayBhIHJlc2V0LiAgV2Ugc2hvdWxkIHdhaXQg
Zm9yIHRoaXMuDQo+IC0JICogRm9yIGkuTVg2U1ggU09DLCBlbmV0IHVzZSBBWEkgYnVzLCB3ZSB1
c2UgZGlzYWJsZSBNQUMNCj4gLQkgKiBpbnN0ZWFkIG9mIHJlc2V0IE1BQyBpdHNlbGYuDQo+IC0J
ICovDQo+IC0JaWYgKCEoZmVwLT53b2xfZmxhZyAmIEZFQ19XT0xfRkxBR19TTEVFUF9PTikpIHsN
Cj4gLQkJaWYgKGZlcC0+cXVpcmtzICYgRkVDX1FVSVJLX0hBU19NVUxUSV9RVUVVRVMpIHsNCj4g
LQkJCXdyaXRlbCgwLCBmZXAtPmh3cCArIEZFQ19FQ05UUkwpOw0KPiAtCQl9IGVsc2Ugew0KPiAt
CQkJd3JpdGVsKEZFQ19FQ1JfUkVTRVQsIGZlcC0+aHdwICsgRkVDX0VDTlRSTCk7DQo+IC0JCQl1
ZGVsYXkoMTApOw0KPiAtCQl9DQo+IC0JfSBlbHNlIHsNCj4gLQkJdmFsID0gcmVhZGwoZmVwLT5o
d3AgKyBGRUNfRUNOVFJMKTsNCj4gLQkJdmFsIHw9IChGRUNfRUNSX01BR0lDRU4gfCBGRUNfRUNS
X1NMRUVQKTsNCj4gLQkJd3JpdGVsKHZhbCwgZmVwLT5od3AgKyBGRUNfRUNOVFJMKTsNCj4gLQl9
DQo+ICsJZmVjX2N0cmxfcmVzZXQoZmVwLCB0cnVlKTsNCj4gIAl3cml0ZWwoZmVwLT5waHlfc3Bl
ZWQsIGZlcC0+aHdwICsgRkVDX01JSV9TUEVFRCk7DQo+ICAJd3JpdGVsKEZFQ19ERUZBVUxUX0lN
QVNLLCBmZXAtPmh3cCArIEZFQ19JTUFTSyk7DQo+IA0KPiAtLQ0KPiAyLjQ4LjENCj4gDQoNCg==

