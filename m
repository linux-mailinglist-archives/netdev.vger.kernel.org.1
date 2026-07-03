Return-Path: <netdev+bounces-304446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +AVWL6luR2rPYAAAu9opvQ
	(envelope-from <netdev+bounces-304446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:11:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D186FFED9
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:11:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=c94QTcp1;
	dmarc=pass (policy=reject) header.from=altera.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304446-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304446-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD394300E2AA
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A512E36BCCC;
	Fri,  3 Jul 2026 08:10:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C32FE0F;
	Fri,  3 Jul 2026 08:10:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066254; cv=fail; b=Al2HXgRkz2UYc7zf/IBXC1sIscZHJPaQv01FaR8rqViKfu7YrVlG6hWngrfUpAGr4d1emL7Ytd2MorRYh1jn1TcHUiFwf3bbRuQa/HOhTVzEv43HjHdZy0+uaw3PFvhgUZeE5DpG1T1Y2Fap6JfpsWwgXb4dIlWl33clr4upvE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066254; c=relaxed/simple;
	bh=Ku9+kETehZfKRY78SGCXr+TjwAGt9qdh8V7PnVcARUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YQ2siyCmPc9m4A5u7q6oXVtYDAF8cVhZnTrL5UW2Af3dHtx6YdJY7dIwJOHAHvu7a66SGI3zg5j+qRhRFU/vYP559taRskDOQ0evV3j7da8J+VU3DX7cBTBJxLeu/0nVeBtmOs60ucibt+tQF+tUxWwHTOnPHPR32ULzPT/3NS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=c94QTcp1; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt25zm0cxzbB6kSxqBps87jOOYSG6CgWD0eyLHb1wePJRMdAIo+WGnVBkKCCKcrmvf6RjTLT7jCj8JVhrA6GPjZrhU2m5y+pu8AMQxA8HuR+1heBmDF6DQXtTxwYvWcNdsoc0mDFc/AVLYKeB1+RhdEQjPZxmG0SRS5W5x66xdaaJyIlhsoshH8q/ynMr7SziofPGPQbegTfoDWflp/n9Ti/WByWyl3v0wuNbGLOD04pkYT4LKP2cQJ00xejgmj1CPRabwc5u2jAU2fO7cSFm2NevWVeGOBpWcffsM41JF8AmbG8hlYxaAbk97SAItPfuPskYzmFMOmewIRqCcr7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku9+kETehZfKRY78SGCXr+TjwAGt9qdh8V7PnVcARUQ=;
 b=YOQU4wqZabhdS95E7I3mZ1/HP1qNw6eoAsNbE327aRk5mLkB9HszeoYz/VoZxeUpL2PRGfVVEe58//VOBTZseybtOaZ4jNl0v//GAO3fTeS6nIMv08LPpEfHeSJSd8Is/a5IK97UPVMQSdZpAarMKxUEKspWqSR3L6JLhYdbro+UaqgxU4htbltUdEF7wTl0zIsm4EELO+84seNMYqKijMqS546TojUaPMQA3E5RX9SgSVR8bCUZVkkmvauR/pjbgyDEIFMCfWf3EpErkniPbkCntRy4nsMyC4m8/EAGJDiAOYCNV/LoMBXScuv8H4A92kIRZcKEjLOkQ72uvdBHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku9+kETehZfKRY78SGCXr+TjwAGt9qdh8V7PnVcARUQ=;
 b=c94QTcp1QVjO5ciVoqmevGfQu/i01KCleBXh3tlCP+aLOAdCAM5YiqweSSbnAnrGFiE6hcbmbWXtcVhV/2Fj3jBeJ2Dn92JeEcCMdt5LhYH1vfIFWnw2CfTII7j402tx59R33ApaKMr1UVQ9qVosJNpB2q5W8UbXLuJhu5yb7m7YgBzKHBUkb5Iua1Cuo40Jrdq3Ej2QIt2J6uRnLx9vwRZgS1Jfbw41sYviF8C5hyYRfam0P3FQ6I/U87L4dQIspN0BORsL4u+wk3zj5mfgzwVAwfHwma9roMr4Xzn92eYylH8H5kRc3XqBmZ2L3MC7L89vuFOTASLfVl5Z3b3t+A==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM6PR03MB5225.namprd03.prod.outlook.com (2603:10b6:5:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 08:10:49 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 08:10:49 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "dinguyen@kernel.org" <dinguyen@kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-socfpga: Add mac-mode DT property
 support
Thread-Topic: [PATCH 3/3] net: stmmac: dwmac-socfpga: Add mac-mode DT property
 support
Thread-Index: AQHdCJS3s6rWWjcH10Ox3xzcAVXL37ZYvq2AgAK3EAA=
Date: Fri, 3 Jul 2026 08:10:49 +0000
Message-ID: <f31704f2-cd98-481f-8290-203e3052b738@altera.com>
References:
 <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <e489be4a-5940-46e5-ae06-b78f1c919352@lunn.ch>
In-Reply-To: <e489be4a-5940-46e5-ae06-b78f1c919352@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|DM6PR03MB5225:EE_
x-ms-office365-filtering-correlation-id: a51d2739-1a62-46c4-74c0-08ded8da97ce
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|38070700021|3023799007|56012099006|11063799006|4143699003|6133799003|55112099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 LpaEgTlPkepip3Z0oWJ2vyB+xFI9mKy9v4sfcGF2eqVkDOs6K0Ph2yCLG12xNn4LS1eAvKM8B8rqVqokk68EYH2+S7FjQxATtXqzWIpXW3WQzA36T5E2cHyMneHtup7WvtpvIQVSQz29eQ+DMLu4VPP2Hs5sBUbLbrg9fML2MtJ5/ngJPCf1yyd6l35wHKX+3BFgF7pqebAIaT9uNnZag0mdHTqH+deeEIk9BepzKEwRPSUD+IgaL51o6SWGLPf0QjyDZ1b39cgpFVKB9MOX9USQAy0HF3ND9JxGTwTNatpg30YCdbOKR+NNZzLEWhJlcnLTnkoSyvB/sU2s40KSynTkxFf3N6SjS/fDmjbEglEkfiIl0i6xsqTDiNXl843QCae4FwZdDNqQK7sMzsJJx80uzeupaAV9JXdVSp93YuUYkdd9TXZZt0hNgFjDkroT0W975yRbNchwxCoCDj00hebuMcpFK7kSoxIDkN1EP0jJDQ0Br58CcfsyvsgMABD4dIqW+fQe2+W/GT93xqHJt+ethMPpnwR2eGsYMBGqqcjV960rbtwW8MsGxLpGTDi0dt88Ik7rsrYSIz11y8MV/PV3dA3HmflhUn4/jNZdqOxHDQo7CAqyrDJQX5n3oZxWVADufzXfihrkQg4k58dbnMq6s26B38SVlCalylZnbqXJIpClJmufn9xD/0yury6RNO0NnvaURjy3SyI/oyYCCK7heTz5KlJQiAFGseBfkYE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(38070700021)(3023799007)(56012099006)(11063799006)(4143699003)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDZGOTF5aGlQNkNIaTFKRmsxRUU1dFgwMHFkdVI5MnlmZnR4TUhiU250S3VY?=
 =?utf-8?B?TlFWL2JEUGY0MjB4VmtJbEpFRE91dHZEWG1ZQzF6dnV4V1BNSzJmZGE2LzFV?=
 =?utf-8?B?ekk2bFBIc1pTb0RKY2lBZTFwT1NmNDdnMTVycTRtMmFtRHR5UWdnRkN3M2RG?=
 =?utf-8?B?SzhDWFpZZE4zTEV5c1g3K29WanZvaXBhN05oaWsxWlg5WS9HaTV0aEgwaWlQ?=
 =?utf-8?B?UXBGd2RQclUxQUhzNHVpS3RZbFFUR0dEeldRMW0vcnFVY3JzTng1dlJVQ2hn?=
 =?utf-8?B?dE1PZ2wrVlc4ZnVFaS9DVXZiUDkxMnMyVWcwcWVhVVg0S2Z3ODZzOXdqWVNy?=
 =?utf-8?B?SUFaOCtxcXFhZDEwemtIeENTamM3dlMvNDVwR2g1SjFqRnR0WHR0THErdld4?=
 =?utf-8?B?eHZKOUFMeVloY0lhUVlvd25xck5UQkNUT1ZOSm05Z1VJTHZVMDAyZFBONlFY?=
 =?utf-8?B?dDlOc242VXJRQzdVQmtEbDc5ejM5Nk9FVmdmb09ZZ0hVR1ExamRzcmVsTkQ1?=
 =?utf-8?B?ekpBd01OcEVpeGQ4NW5qOXgyTHJPOEs5bzdESjdoanh0cTRmdmZEUjliV3BC?=
 =?utf-8?B?bnlOWnpPNk9kSFhXOG1qU0VHYU4wUWFvQjFZRVZONDVCY3NXcEh4RS8yZ2Nq?=
 =?utf-8?B?YUZBV1Rnb2tkMkh2TjVBMzBKdEJkbXBLWngzazNIWGJWUDhNdHhTOStYYnpG?=
 =?utf-8?B?YjhMTjZaU295NU9lRHQyZS9iL2NTbVZSV0FqUjhpUGpEdnVVUjVJd1cwamhY?=
 =?utf-8?B?Z1RmNDl0VWZTcWw3WUh3Zmw3UjM2VnduZWNTb3BLNGR2eFA2RHFaVWNzN2or?=
 =?utf-8?B?OVR2K2tvYWlubTdrWXFuVWUwaXdFREViOTF6OHJTdGhYSnBWekd5d0tsdzln?=
 =?utf-8?B?cEtKVDZiTk9mRUVrMWkwdGZoWVhWWEM4V2FPQzIxZFF6SmpiMWFiYSsrYStV?=
 =?utf-8?B?UU1sRytNNzBPVkNRSHlLcW1hbnFrZXZOTWRLQUlDY1NqM2hBNDA4OFFnOXpM?=
 =?utf-8?B?ZTFLSCthaWhUTUFSRnRtTkpGOVZjWU1oK3VkcDhSamkzNHNLakIweFduMEI4?=
 =?utf-8?B?QzV2T0o3eGZmRUhVcW9iWVgvUUpWVnkxK2hmVmNZb1BLUGxNWkswcnZwUWlM?=
 =?utf-8?B?VDlMT2Z3SGRhL3hiZHZScCtrcjRZWDZHdWVvclZmUUVWdEhucWpVZ2tKZGFD?=
 =?utf-8?B?cnM2VVQvSVNmeFkwZE5zYWx4RWRISWF4OWdKa0doR21Tb2FSWTRHME5qZHJK?=
 =?utf-8?B?QzVSQ2VxT0diNzRVbm1OWDFOWmpnd1lESVRhSExqN21WbGFHTEFQZE9hazJE?=
 =?utf-8?B?aWRNamtXK1lBSTladzVlbDRLRzVnNDRLQ096ZzJrUGxtczlCblRUZy9VcVIx?=
 =?utf-8?B?VHFMRDllREhtQmUzUVFjUVVlb1NXSUNYUHN5Z3Ivc0VBT20ySm9VTFlSWC81?=
 =?utf-8?B?b1J4U0pRTlUwMzFkWDVPRC9aZFMvM0dtQVJLY0g1SW5pK0lmQThKL2dQTGhs?=
 =?utf-8?B?TU9iVm5yVkRsc2ZYcmROcjZwOWd6REhWa0JYdWhMZGo4VjBXVTJEN3luS2Nk?=
 =?utf-8?B?dzEvN1pJRFJZT1IwLzE2RzN1a0YvSkRnRXk0WjZCcVVlN3FRMzNOcnBrRnBp?=
 =?utf-8?B?M0J2TTdueWNLMFdMM1FoWU1ONVBIS2Vtd1lXVXFTVU14NEk3bkw1YXJXM2pH?=
 =?utf-8?B?N3Y4b2YvQ1k1b0tGUmNHSTZNRmRYNEY3cTFVb0dzRkNzd2grd3B6L3pGcW9x?=
 =?utf-8?B?VGdOQm9BbUpDNzJYWGxTZTNJVUxZWkpkRnZvaUpUdnpMS1VFb0Y2M1NBVEEy?=
 =?utf-8?B?RlFERUhtd1BHaVg1SS9KNEdacExFMEpvR091dzBBVHFUdTA3bU5nVFY0V2xE?=
 =?utf-8?B?MHpQNFZVckdoOFpnUmUvbkVVeFg4ZU1YYlpEWkRFWURYc1JiZ1VSbzkvUlN1?=
 =?utf-8?B?VFY4LzZNZ0lhWldCbi8xQWF0cFpMQlFmRXMwQjZmVWZBeWliYzVwNXBtcTlX?=
 =?utf-8?B?NEowdjdVczl1TGtoeis2NnBsYjRxWjBra0FGVVJMdE9oY1NhbzF2cGVrSlZr?=
 =?utf-8?B?Z1JLM1ZVdTRoOWQ3Mklyc3R6L2pLdGZsSjRNanlnaCtOc3Y0MkNnNGdCOENt?=
 =?utf-8?B?YjRWQ2hDZXVBbGJndVpIdlNZeVlHWWNMMGZiTU4vam5NL3ZPbEdBRWloazVi?=
 =?utf-8?B?SDE0S0cyckVjSlgrdk5lRHVHbktCMDBvVEkwN1c1MSsrZGtsVDY3T2tzdXl3?=
 =?utf-8?B?WW9yMWlsVTFHY3JVM0tUcngwUVVTR21xMzBvQkpnOUVKek56Y29kQUlXZHA3?=
 =?utf-8?B?aUlZTVRWcmswZ2hhOGFKR28rNXlJNkJXQlBtaVEyY0JNRndhU0gvS3p4eFFZ?=
 =?utf-8?Q?zBzx3K7g21jZSUEo4Rgza36khYhB4Lss2RSQLKbeI8Qc7?=
x-ms-exchange-antispam-messagedata-1: zM2tflYZdlhXxRlQnNndwWBBr8bftQkUqvM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1066DC117C32AC43B325A10FAE21CDF7@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51d2739-1a62-46c4-74c0-08ded8da97ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 08:10:49.3942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhQ9CoUdBVBAhEBw5PSu6LsY8gk2OPY9u8wado5lU0bKPtxJANFx9yvPeA2Nd6k7JLwqZ4tY2W/nRVwQ+TzYZ9QSDJawLoad2xXdBzKeOt6V1kuehVi/FVW6SJ9qYM935KkgldlUcYiKEZIiKwjiFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5225
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304446-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:from_mime,altera.com:email,altera.com:mid,altera.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56D186FFED9

T24gMS83LzIwMjYgMTA6NDMgcG0sIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBPbiBUdWUsIEp1biAz
MCwgMjAyNiBhdCAwNjozMTowOEFNIC0wNzAwLCBtdWhhbW1hZC5uYXppbS5hbWlydWwubmF6bGUu
YXNtYWRlQGFsdGVyYS5jb20gd3JvdGU6DQo+PiBGcm9tOiBOYXppbSBBbWlydWwgPG11aGFtbWFk
Lm5hemltLmFtaXJ1bC5uYXpsZS5hc21hZGVAYWx0ZXJhLmNvbT4NCj4+DQo+PiBSdXNzZWxsIEtp
bmcncyBjb21taXQgZGU2OTZjNjNjMWRjICgibmV0OiBzdG1tYWM6IHNvY2ZwZ2E6IGNvbnZlcnQg
dG8NCj4+IHVzZSBwaHlfaW50ZXJmYWNlIikgcmVwbGFjZWQgbWFjX2ludGVyZmFjZSB3aXRoIHBo
eV9pbnRlcmZhY2UgaW4NCj4+IHNvY2ZwZ2FfZ2V0X3BsYXRfcGh5bW9kZSgpLCBub3RpbmcgdGhh
dCBubyB1cHN0cmVhbSBEVFMgZmlsZXMgc2V0IHRoZQ0KPj4gIm1hYy1tb2RlIiBwcm9wZXJ0eSwg
bWFraW5nIHRoZSB0d28gdmFsdWVzIGlkZW50aWNhbC4NCj4+DQo+PiBUaGUgQWdpbGV4NSBTb0NE
SyBUU04gQ29uZmlnMiBib2FyZCBpcyBhbiBleGNlcHRpb246IGl0cyBnbWFjMSBUU04NCj4+IHBv
cnQgdXNlcyBHTUlJIGludGVybmFsbHkgaW4gdGhlIE1BQyB3aGlsZSB0aGUgUEhZLXNpZGUgaW50
ZXJmYWNlIGlzDQo+PiBSR01JSSwgc28gbWFjLW1vZGUgYW5kIHBoeS1tb2RlIGRpZmZlci4gV2l0
aG91dCByZXN0b3JpbmcgbWFjX2ludGVyZmFjZQ0KPj4gc3VwcG9ydCwgdGhlIE1BQyBpcyBjb25m
aWd1cmVkIHdpdGggUkdNSUkgaW5zdGVhZCBvZiBHTUlJLCBjYXVzaW5nDQo+PiBjb25uZWN0aXZp
dHkgZmFpbHVyZXMgb24gdGhpcyBib2FyZC4NCj4+DQo+PiBBZGQgc29jZnBnYV9vZl9nZXRfbWFj
X21vZGUoKSB0byByZWFkIHRoZSBvcHRpb25hbCAibWFjLW1vZGUiIERUDQo+PiBwcm9wZXJ0eSBh
bmQgc3RvcmUgaXQgaW4gYSBuZXcgbWFjX2ludGVyZmFjZSBmaWVsZC4gV2hlbiB0aGUgcHJvcGVy
dHkNCj4+IGlzIGFic2VudCwgbWFjX2ludGVyZmFjZSBmYWxscyBiYWNrIHRvIHBoeV9pbnRlcmZh
Y2UsIHByZXNlcnZpbmcNCj4+IHRoZSBleGlzdGluZyBiZWhhdmlvdXIgZm9yIGFsbCBvdGhlciBi
b2FyZHMuDQo+IA0KPiBJIGRvbid0IGFjdHVhbGx5IHNlZSBhIG5lZWQgZm9yIG1hYy1tb2RlLiBG
cm9tIHdoYXQgeW91IGFyZSBzYXlpbmcsDQo+IHRoZXJlIGlzIG5vIGNob2ljZS4gVGhlIE1BQyBp
cyBoYXJkIHdpcmVkIHRvIHRoZSBjb252ZXJ0ZXIgYmxvY2suIFNvDQo+IHlvdSBjYW4ganVzdCBs
b29rIGF0IHRoZSBjb21wYXRpYmxlLiBZb3UgYXJlIGdvaW5nIHRvIG5lZWQgdG8gdXNlIHRoZQ0K
PiBjb21wYXRpYmxlIGFueXdheSwgdG8gbWFzayB0aGUgcGh5LW1vZGUgdG8gaGFuZGxlIHRoZSAi
TUFDIiBkb2luZyB0aGUNCj4gUkdNSUkgZGVsYXlzLg0KPiANCj4gICAgICAgIEFuZHJldw0KPiAN
CkhpIE1heGltZSwgQW5kcmV3DQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MhDQoNCkhpIEFuZHJl
dywNCg0KVGhlIGNoYWxsZW5nZSB3aXRoIHVzaW5nIGNvbXBhdGlibGUgaXMgdGhhdCB0aGUgVFNO
IENvbmZpZzIgYm9hcmQgaGFzIA0KdHdvIHBvcnRzIOKAlCBvbmx5IGdtYWMxIHVzZXMgdGhlIEdN
SUktdG8tUkdNSUkgY29udmVydGVyLCB3aGlsZSBnbWFjMiANCmNvbm5lY3RzIGRpcmVjdGx5IHRv
IGl0cyBQSFkuIEEgYm9hcmQtbGV2ZWwgY29tcGF0aWJsZSBjaGVjayB3b3VsZCBuZWVkIA0KYWRk
aXRpb25hbCBsb2dpYyB0byBrbm93IHdoaWNoIHBvcnQgdG8gYXBwbHkgdGhlIEdNSUkgb3ZlcnJp
ZGUgdG8uDQoNCldpdGggbWFjLW1vZGUsIHRoZSBjb25maWd1cmF0aW9uIGlzIHBlci1wb3J0IGlu
IHRoZSBEVFMg4oCUIGNvbnNpc3RlbnQgDQp3aXRoIGhvdyBhbHRyLGVtYWMtc3BsaXR0ZXIgd29y
a3MgdG9kYXkuIEkgYWxzbyBhZGRyZXNzaW5nIE1heGltZSdzIA0KZmVlZGJhY2sgaW4gdjIgYnkg
dW5pZnlpbmcgdGhlIHNwbGl0dGVyIGFuZCBtYWMtbW9kZSBjb2RlIHBhdGhzLg0KDQpCUiwNCk5h
emltDQo=

