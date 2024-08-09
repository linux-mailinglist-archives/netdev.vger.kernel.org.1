Return-Path: <netdev+bounces-117158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D1F94CF0E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE399281CE5
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09021922C7;
	Fri,  9 Aug 2024 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FQLyymmP";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wDYqfiYS"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C617993;
	Fri,  9 Aug 2024 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201107; cv=fail; b=uKctBNWr+RUtMYUIPvZOEWS0eyGYu/OSqAj+G5g6cILT9UkvWEgb2qPgk1vunn75dGZRk3yy03ZYFUdS32dDiAiQL4scdjA+hEjrj3U1ZV9qfqPBjLEg4MO0KGUQ42JyvO8tz3U4pBa6aN2GrYSq5PwEKh3CiXWD8U2iffHQZ+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201107; c=relaxed/simple;
	bh=sZTA1J2hj2M+9D5yBzgu+SowOhU41SoNDTJgf3FZrV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nssh4RDM8ehgta/kcptXpJFZlnBTBG6CCoM2URTI/ri6MB65m52m5OGGg9tJvc99XfKPELu8n3vitsbDNb+FXUoXu3oz88F/yAke6rtcjIfavSTbYxMQXbPrct6lnbc7WNzQo/9pmLrGfWD/IvR4F7L1FOyDO9NWsYrbSqaGA08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FQLyymmP; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=wDYqfiYS; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 43ca92a2563e11ef9a4e6796c666300c-20240809
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sZTA1J2hj2M+9D5yBzgu+SowOhU41SoNDTJgf3FZrV8=;
	b=FQLyymmPHOtURriz2WCf9jqPc1OqXHvM+MrH7A5YldWHb306aPN6hn35RVY7oRkGKgPETjfixtCBMdwDaHST1rABgbzibiExstnfHQHUQ0aG33qTHn1oOh+p4WUESDIw4/NJyrTtg1q4ekipLxHyrti3otyNkxjLootIah0juQs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:0b8178f8-18cf-46bd-8b45-19f0abb0be6a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:e834ef3e-6019-4002-9080-12f7f4711092,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 43ca92a2563e11ef9a4e6796c666300c-20240809
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1104297774; Fri, 09 Aug 2024 18:58:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Aug 2024 18:58:10 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 9 Aug 2024 18:58:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cm1rxI8kIu9Yj+10sQfMlM0PxhsswlCSLsnLPrnOwDQHiJM67res7nPEvwKggl7GdlBK67iyN8PQP8uSeW2G9z0K/QlkFhGbptjF4IWZC2SXcZduQ4WputFcWMftLnPOd1YXTd5QmdaDJlbDhEPfiQtUx7307gG/23/qulM2XRnFKbOjcQ7EQqWTlfxhQQaxkszxuTwRREMPtVRliUgwAssT+22H14JADOnjXWQwWoVz52xlx5KvXsiaWV9E9ucbnZyOeDDNTL2zvyApE782UgW/byCjZUJrAwQ8lIHPoIy3Kl0fUjsf4u+mM3erH23U6VkxvI+xVS+h/9KTx0QmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZTA1J2hj2M+9D5yBzgu+SowOhU41SoNDTJgf3FZrV8=;
 b=cjeTv0tfGB6Uw2A0J6kkG1itYTGPWeCREQV+iF0jASh7mceE1Xh1dDqrHefDS1Tic2U1sOJnIldVqcHg2raBN1/RR9yfL9jJEY6wZHMzJh9w/rLelFr5ziPMnePDsn2SfLPNbcp9i+bLtPS5bdFqq4pnV7jZ3WuqHcT3vKRnmOoZSDWbhLjnyrNSFpPJTcKtJvC4RHnBMSfr1BF2Tp4beUEKjXMhZsZoT0ZUkg08Z8wlVQhI9HBg7uOW2PR3BAeHZ3seWKD8Zm4C3tNl9ewyGpURnh0VT2hE2t5gN2Z/9Rop5NKB+ygAyfoLY9gQP0gsaJz+ZE2T8/i5VGCiyeAXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZTA1J2hj2M+9D5yBzgu+SowOhU41SoNDTJgf3FZrV8=;
 b=wDYqfiYSdd2qHsa909dlWkSVTpX9H+dHn5/QITs/6eDZw12EqoFOfFmVRdIRcLzwmKkEWxwH5U82lzKgPxdQfeJGR2Q3+SR/VsiuEFGEH/Y6v/fjN/3YlrHnq+GFisbT+o2CgcuNxUPkOY5rvKexjLn1g8S//b2flzdHwDrC3a0=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TY0PR03MB6679.apcprd03.prod.outlook.com (2603:1096:400:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 10:58:08 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%6]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 10:58:02 +0000
From: =?big5?B?U2t5TGFrZSBIdWFuZyAotsCx0r9BKQ==?= <SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: =?big5?B?U3RldmVuIExpdSAovEKkSLuoKQ==?= <steven.liu@mediatek.com>
Subject: Re: [PATCH net-next v10 00/13] net: phy: mediatek: Introduce
 mtk-phy-lib and add 2.5Gphy support
Thread-Topic: [PATCH net-next v10 00/13] net: phy: mediatek: Introduce
 mtk-phy-lib and add 2.5Gphy support
Thread-Index: AQHay6UIK15WyHKxQEyRACJD3XBCyLIe/rUA
Date: Fri, 9 Aug 2024 10:58:02 +0000
Message-ID: <0935426d09f3bf83b119e8f6bf498479a62845c0.camel@mediatek.com>
References: <20240701105417.19941-1-SkyLake.Huang@mediatek.com>
In-Reply-To: <20240701105417.19941-1-SkyLake.Huang@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TY0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: 0c68d98f-c2c2-4bdb-be5d-08dcb8622375
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?big5?B?ekpLNE5vWE1pU2tkY1FaZG4vdUR5MHZKZ29SZU1KdWVEdGtUNHpyT1djN2hqZVpI?=
 =?big5?B?akpKOGwrNlNLYjFHb3lYV2xDK3dPVkVSVTBKUUdaa1NRYnJLMVkyendpSFBvRXNI?=
 =?big5?B?MllDTmpxK2xvTTVuazlWTENPODNQZC9QM2djbElLc1dRS0NobFZVeks0aCtXRVZR?=
 =?big5?B?V0hUT2dJWlUyOE0xTkM2UkJqQU0zRHVZeUJwRjE3RXo3WU0rd3d2N1dYNnppWWNh?=
 =?big5?B?eXNQbFo1NXp0TmVLVVBQelpweG1QaVlDSGtUVXJBR2hUUGxHa3htV0hhNFBxb3g1?=
 =?big5?B?Qml5VnFtSVF3QjJjaWI4cGpLbGsydTl1UXlkdFRuaitZQjlUaWdvRXJINC9wdWlW?=
 =?big5?B?ekYvamhlVmpVYUxLZi9PRFJnYnJneGRGYkIwcmx1TE0yTUc2MGhtd1dHWHc2anpk?=
 =?big5?B?dFQ1ZjNGNGFBQjJ1MlcrdmR4aU9rampaeTFRSXRUNSsyWjQyemttZ2Vpam5RRDZn?=
 =?big5?B?T1hRdFljazB5QzNOeEc4VENFUVlxNmUyZFZCVktFQ3B1T2xQeTNrZEh6SVI0WXN3?=
 =?big5?B?b0dxdWp4ckt6VG1TMnpYZTFpaUNCdjV5encrUmlzREJ2QUJIdUJ6eXZxQWMySW9S?=
 =?big5?B?ODc3YlRHMjZRSmpxOEJDd243RTc4N2VCVWcwV1JEaTl1NUFPUnJZa2lWUkhKZWZr?=
 =?big5?B?NGJETkQxK3RLd0ZiZ2wrTGl4ZXd1RzkwaGdDZ0huc1hZYlRvNDdoTzQzOTZLT2Jm?=
 =?big5?B?c0xPV1BreTFzNUtZUnBkVkw1N09DQzcvYXRHR1VOdngwOTA4TTJ5WVl6UHp6WFM3?=
 =?big5?B?STRFUUpGclI1cGw3U0svTnVDZE1XNVBrOG9kSHVMaG1rLzhuYktiVEZsRnVXRGRs?=
 =?big5?B?K3ZlVG82UThnSXZ1NUNwcVIxTFh4YmthRjZBM3psSzFVYjFveTNtalJWbHFVdzJp?=
 =?big5?B?a0ZvQ3RSbnh3aGtOMGlnaXE3cHBHcERYM3krS3E4Z1RlallPdnJSQzA5M1ZBMkg1?=
 =?big5?B?cjRGTnc4SFkrMXRRRk9CdkFrYlZJd1V0V3l6T1o4TXJBb2oyZ0NsdzdQaUM2cTVW?=
 =?big5?B?Unp2eDFwdDJ3M01rb05mRGVIRWZpOVEyd0pla3pHOGNlalRyZzdPUTFFSVY1WXlK?=
 =?big5?B?TzVuVXAxb1hldkIzaDRMVXNlOVJ5eWxNVW4zR1BjUmJlMDFvSE5xTU1HWmc1VGhu?=
 =?big5?B?MjZBcHdjQkRqcEkra296N3oxbjZpajRQLzNwcDlSSnprTUlRNHE1WXk4UUJqWWxh?=
 =?big5?B?NmRyY0tXSDZvb2YyYzdtb1RjTWN2dU5FT0NHWUVxVGIvUlM0c0hBdnRicDJ5dy9z?=
 =?big5?B?RHZpMWdlMExzMXhoUzl0bTJ0MWo4VVBRZDJwemZPdTFaVFEvYThmNnRSd2Y1T0Za?=
 =?big5?B?eCsrNlZ0SnlDVlZCY1lqQmhrekU4SnBjTjgzNHFPcHcyNmZiU0RNQ3A5UHpkYmxJ?=
 =?big5?B?MW4zSnlPUXZFd1M4aTk0U2ZUaDFpM1BGNWk1ckQwd1JhT2ovc251aHNqUlpqa0lZ?=
 =?big5?B?dnB1WlRUaG9na3NMVVlQQkw0MXZpbnNlR09USmFjbFdUVGZtd0FaUFV3M2E2L3hw?=
 =?big5?B?bHRXS1hqMytoQ0NVcnRwSVd1algvcCs3QW1DbHpSR21iQ1ltWEIyR3k1WmxzN3Yw?=
 =?big5?B?R25HNjdlT3FMbmpFVGN2R1Jub1ppM3pSWlZLeDJTeG5tVHFzdUdxdk52SVR6dGJM?=
 =?big5?B?M1lOaVV6aFJwdHJveXNjMWNCTlUvU2FMeURnTzRQZGwrMDNlRGxJMTdaS0pUb0xS?=
 =?big5?B?WkVxclMvTUVQRjBxVTJ4V3B5WVFndHNJWFV5RGZBUzJJcTNONldrS2FHTzlYZHBK?=
 =?big5?Q?heeyM0SWn69coQME?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?U0ZUOUlZZGZIK1N2VnJ4QTdUZTZVZi9HcGtvbDJjcFlIdjJyWXFTQVdkdkVtdmly?=
 =?big5?B?R1Bqc0MxUW1HNWpHNXZhYTZpZThVZ0lWNTZTZUV2d2hoeVNWbTI1eGoreWVDMjAz?=
 =?big5?B?UmZFSSs5Tm9XWDFCcnAwQkd3b1ZWNEtVb0x3M0xFTlBMditJTlRkMXp3Nm91QVh5?=
 =?big5?B?cUt1MGdHMG44Wi9xSTh0R0JCdDZWbi9FVWl5MGtoM2JSRnFVUElURHhlWG1KVFlN?=
 =?big5?B?WFdXV2NqS0xVVXZOTzJTOVorN2w1d21nYU1nNmhZNFovQzhVaUFLYlBrdUw0RUpK?=
 =?big5?B?WUVjRGdCUGtXTHEzTFp5TXBHMDkwY2lsdVFENGMvZGREekhPZWl4OG16UWZDelps?=
 =?big5?B?ajhYMlJIRjNUKytxcHdQOG9sOVJGeGJVd0FmL1VDQ0NRdExIdmJVQW9kRWNQSTFS?=
 =?big5?B?ZFE3VHFlYzRTRTFDVlBjcnNnVnRlR3oxenhaTDRYcHVYQS9DZStTUTBrR25BOGpj?=
 =?big5?B?eUwzcTdSTUhkNGQ2NXJkMWI4aFQvUDk2bDYxYlkwYmM3M1h1Tk1vNi8ybHBxcGZX?=
 =?big5?B?VmVhTjJPL0hYdGRNOUtleEMrb0xTYVcxMWlOb1lGSTFLV09XZ3BrbUdGVS9BalpP?=
 =?big5?B?V2QwV0pCQ2FOaEora1BzNVl6NFZHUGNZNGErbkVhY0lRcEtHRFpzSzZUeENuQWxY?=
 =?big5?B?cWJnVlMrTDJrb2RYMFAzdVR0akpieEFiZy8wemZVSk9KZUlTWlNxd0lGRUNwaEMy?=
 =?big5?B?WVB0a01EQ3BScjdGVG1NblQ3MFA0Q1FYU2NCNXkwVmlYUkVoQ043ZXN2TVJpYm9u?=
 =?big5?B?QWtnb2puNXVIMGlRZm5nSEt3WklIcW5sbnhQc0t6N2ZiaE1oMENCNTZPa0ZhN2N1?=
 =?big5?B?U2xXUlE3dmZoM0JXM3dmUUdqSnRPRlZwaFVGbXhva0hOdlVoYVBhR0dDUkwyaFkv?=
 =?big5?B?YVk5bVhPN1ZBcVlybDlVNnNOWk8wcloyaFlFeTBlaEl3TTdWZDROZkZMNDRSY3Zy?=
 =?big5?B?YmRoRVczWXJ1emVOKzk5WDVLOHkzS3A3ajl6WVRock0xUlQ1eHNsKzBrY21rNXZH?=
 =?big5?B?N2FreGxYV2lKcnlQMnlQSU1DV3NYSDExM21WUWN0VDlGeHVWV1FPeDlnaHNzR2VE?=
 =?big5?B?NmR2dHg0Vjd4TzVucFIxR2RQdkt2OTFWOXJhV29nUGVJMzJ1K1VyVVVndEJUYUJN?=
 =?big5?B?c3N5dVhrNThrUEZXOU9RUjlCaHlkWXI3VkZhQkRIWmM2M3hyOWU5SEZ3R1dHN3pw?=
 =?big5?B?bHl3SGJGWWVnVENodUNUb09SemZwNk9QQWlwOFZBODJnb3VPU1BhdjhHTGo0YTE3?=
 =?big5?B?N0xzYm1JQ0dyVjh2UEhWOVNYSXRjYUZrZDlVTXZaTER5c243VGxnMzRXTWhoa1p4?=
 =?big5?B?dGlkcW10Nnp3akNrZXRQY3ZoSklkSVJLSWtCb01MQTg1NVZPK2ExVVpHRzJtQWFY?=
 =?big5?B?M0E3MkoxbndaK3hkRlhlNzFiMXpwS0VyZlJSSVVETFBBNkdmM0k2RzFkV0VTTVNN?=
 =?big5?B?Mjd5bU8raDJBeDRDSTBVM3YyQVBEdE9lOHN4NnJRNlZvRTNVU1c4WGVlMnBzd055?=
 =?big5?B?UnRXRVd2N0lxeFJ6U2VxSEFFTnZrVzMzSjdEeHVFalhXd0tDN2tKRFM1WTZUb1FO?=
 =?big5?B?QzgyNmorckNGWWQ2Szh4aURiNlppT0xLR04xZWM3TEN5aE1DZkhJYUZBNjJDUkdP?=
 =?big5?B?bFpEK0lXZ1d6eStadTJsWUhIcFpQQVl2VUNJbjVYem9qNGJGRzNmT0poMVdMcHNa?=
 =?big5?B?c1VRaDhHcnNoZERqTTUwQ1hBTCt6L004cjlFRFhINnYxTXJvdjhKVVF3bDd3dnlV?=
 =?big5?B?RHFDZW9YMmhmTGlDaHo0NEgrOVpLd1dYcnA3a1MvckFFeFdJODZZZTZUTUVTU3o2?=
 =?big5?B?SDJZeFoxOHE0QlJLRWdJWHRuOGVkYlM1NUxiVzVlVnhZTzdVL2J1SFRJVWNOQnJi?=
 =?big5?B?VHA4aC90b0dmS1haQlZZV2NILzYyMmtSRUlZbnB3cGhid2M5T2xqQ1JSZENrSDlH?=
 =?big5?B?QTQ1MGxMNG5HSmYxeGtTLzArNTErWEZkaTFZd0x0bDZGbEZPTFg1R2d0MHpvM0o2?=
 =?big5?B?bS8rc1l6VFdUdUlBUE1CajZka3VwZ2NFSVVvNHNJaGlYamVla2c9PQ==?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c68d98f-c2c2-4bdb-be5d-08dcb8622375
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 10:58:02.0540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E8pIG+uSizBtHD8HuqCiAs8UzV91nwCQIJa1usaU/yPnkPKj/Y5fkHe9mxxA8WGb+VbtqrXDqEBfiJMZxMPHALYQQEMo9AdzpK6ifcdpzCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6679
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.294900-8.000000
X-TMASE-MatchedRID: yKmWqH0vkXXUL3YCMmnG4p4CIKY/Hg3AwWulRtvvYxSFGrY+cdMEa/kz
	XiIPyMVeL7hsabndv2sT9vR5JzPjCWpxNWG2/ceF9xS3mVzWUuAojN1lLei7RXwqRGgEShXu90k
	+XAiQqBweh3/b9W5KDm5MR8vIbdlyc5aMULnZRU/151MnN5JL2+LrmKODPqToYIYsWIazu7+Iok
	ojtxW985RMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.294900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	7EE7EBAC218868627E323190A4EC80E75F0397D491707CBEB68C7C7875B598B22000:8

R2VudGxlIHBpbmcuDQoNCkJScywNClNreQ0K

