Return-Path: <netdev+bounces-298444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z9H7I+lyK2o+9wMAu9opvQ
	(envelope-from <netdev+bounces-298444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:46:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DE667651C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:46:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=lOhy9B7S;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298444-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298444-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12C7D3135BD8
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0A21F0E29;
	Fri, 12 Jun 2026 02:45:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4FB1E8826
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:45:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781232339; cv=fail; b=hgOqDckfJj6EmegVzBW+kEaR2TX9D5gu+QnRC4mAMktmRdNhZOjhsObv6t5s2C5UonYbW7FOOT6gVoVqqB0tMG5eopi3hSv0rJWrNncTmN0HGscF3l5cELsMUH2U1L+wiGJmutdD7go0I9H73PcEqDnogmC/+yDDd+aoJXbPdUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781232339; c=relaxed/simple;
	bh=qDcnJ8HBnosuiYR3uZWD+ddldXkIrKMnJ/iS/0Lu6o8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iO8GURE4xmfWNYbQq7hoVciSkrRgZbbY7xRgnsMja18ChL7p+/5ttl1oOrncXfDWDNqSDkWiObA/BiHcFr13eywgDCJ0EMby6NAvMeQbvx/ffMtv+TYjlsH3Eh5oZoxenZFGYJfxAhOkXKenGRvuVGYyGm9dULwukWcALso5TEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lOhy9B7S; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxMycX4aoXp3MxLFWycUP1h5MPOpj1qCMg+b9wTvvs+yITREsMgVyHm42Y6fPP8xNRp1pmx2h/s9hDdzC9Dn7NVwrRlSORRPxwKSQi3joTduiFqN4qqsyo6GvTeBVKFfnOmueNK+2sBy2X4ctpcEwz15Mt5TH9+P3hD0Sir7ed0X16tAvXfLMYqDTFZ5p6CqUbLuR29NkIDekhSuQroFFRYVKCTYHEB4HbxUfEhlMLSdncMcwiB75qIeolBkGEofz1MQ5315eWpWp/9QQCTy+RVFoCIE6HksjVp4wt9rwvwCEPZ7HoUphOYS4+Mkc5Uj0Sf3o6lssqEu2OijcTljHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDcnJ8HBnosuiYR3uZWD+ddldXkIrKMnJ/iS/0Lu6o8=;
 b=ex/cBHirYfFOdrvMQ+ZR76bZ5zMATkMKpFYpiOb4CdGpuUMMl/cxitAYh5NtBophXZEnBg5evO+uEdDzbON0LViMabwiq7373jRq6O7PSrEyHWS1sxHPpGD1niBdH2orz1fcUEGK4BemtR+Jf2pX0xWkVjMy0DR6qZ5TYUXRsHV1ykDaLrexRCS3rmseqm4TLoOQtjfrfmJFI3aERF3jPbota4oOvzAkdgobdNqC91T7Jyk2hoKuQ/LknZpfOyCGmjwQZ9qcXojkDrXRZBAeCQNElzBGP6XN5Qwo/bcC0bVlrEQe77z0dsismhXqTlXpgjXMdDNNRjO64gX8Aq2DzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDcnJ8HBnosuiYR3uZWD+ddldXkIrKMnJ/iS/0Lu6o8=;
 b=lOhy9B7SKjad04PY9p5YnGL0F+YOkz6fjYUL7yVZZ4DzLTBVzgQ1d/kNIpmzw9fimafglPLpzuJTYZuLEBnwFOHqhrXlS4HtmQucIdDhkE9fTV0rO/uRAD1K8mhRz1CdZfm55f/nRZUkueFxDGhOglJzZLUsCMixsGx50Nqc3IlonM121ffmGLBSj27MWOwyY6SS6mCTQ9xzS1mdBWEmaEEHmSqYqjaGFS6OnTUfg9HQp+s/y2sOKijcJIZ29zo1F4GboewuESBp8LGBjNDC8HoNJEo+IR7ymdLT4G/CPQPADu9h2+PMSV/EgaUp9n8/dhYg2AYtn46/PZTVHzGjhw==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by GVXPR04MB12343.eurprd04.prod.outlook.com (2603:10a6:150:2c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 02:45:34 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 02:45:34 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 13/15] net: enetc: implement
 ndo_set_rx_mode_async for ENETC v4 VF
Thread-Topic: [PATCH v2 net-next 13/15] net: enetc: implement
 ndo_set_rx_mode_async for ENETC v4 VF
Thread-Index: AQHc+L4fwHZQ/14/qUu6asWCgSM5trY5HTSAgAEcYaA=
Date: Fri, 12 Jun 2026 02:45:34 +0000
Message-ID:
 <DU2PR04MB8629D4C72C0C6830C2B9E93388182@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260610091844.3423693-14-wei.fang@oss.nxp.com>
 <20260611094741.EA56B1F00893@smtp.kernel.org>
In-Reply-To: <20260611094741.EA56B1F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|GVXPR04MB12343:EE_
x-ms-office365-filtering-correlation-id: e8d412f6-698f-43c5-e147-08dec82cad27
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|38070700021|6133799003|18002099003|22082099003|3023799007|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 5ahGfRpO9Jvj3si7aILwB9Lfmvx3q9uJOxGVs5GmUUq2HfiLgrf01+Ibkgd7bCMdIIiirtQBC5trhQHKb0xz1JVDUuRG0Zpr0OiVkWMhS09yuU60UEs9c/x/SIS0XDr2kWbqC5npZOg6MntbJgGsCRSYRcZoegT2JTD7nBezUiPolF/PXOpMr8XdT2SNvvwmbtzfz15RFKOL1rRpU5OvIfS3+b4SWywA1uMbq25bzEsnYqqaRCTQ0ZL9eRJInr2u63xx4boZoh7JrvS8yu7mM1yor8pP8N+HlaUKcehQwh083+huv28ePRDulJSQEVJPxg8tUBMgDOrfDMPpWk+ERKFhMTQPfgXQkeEfzxEo7Qgzv+4J5TT/lUIvizlsSFRNhcVOMNDqHJOZNYrdtkA+QqqT4/u0Gt1Zg2illZxK6xcPE3rMuRVv/FivtTbftzNBlgUaxLba6oXqu1MNXbwC/QmCq7HJK11rRQsSN3QPHBOMkA5aY//MxJHvEhvQrHudZtg+Eg/vAgnTkldceBZfDVBRYBA7py5H0n1Zx293umgEfM8LHhVUhnx7k8mtQkJ2FQCYB1/pyJ6nY7vc5Ervb3wKIbby3s0yVdGytU/GW8H248Gm5F+eyj5Tsb0s5Efha4V3Una/gKUgKvPOhW8OgNUxSW0xrJwafVe+EsQLxWqCc21FOx11dGFHy7wLkXXo3MARu8QV2cOYpHH+Mu1Zxoa8D35NPIM1wE4qQvAI6L355TiRMpukFCYC1G+C5MJs
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(38070700021)(6133799003)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEtWWk1BVjduWGVxaVh5V0U2NTZHVzAvSEN0UHVtREpFSEdiT09BTU94WjZT?=
 =?utf-8?B?Uzdzc2hSbENWZjIxWWdPRTlCaEhLaktKNFRpTzhXb2JHNXRacXI4dEVCNzhP?=
 =?utf-8?B?bkY3enZiUXcrMFQ1R3dQS0JGNmZPc1d0Qy9QRERYQk9JRFlwU25mcmtvS1Fy?=
 =?utf-8?B?WmR6cnZMdW41NzUwa2NYc0M2c1QvejJ1ejJyUkV0MHR6VE5jbk0rS2VTV1Rh?=
 =?utf-8?B?dFYwRnNTRGR0Q0dvVzNTa1VKNXV1NUJUd1ZuQlQ3VVBRb0QrVi83OGJPV21z?=
 =?utf-8?B?ajYxbXEwNFJ0RjMrNnNjL01mVU54b3E0V2Y5emhLWGg5MnA1RGZnbVE1OEdo?=
 =?utf-8?B?QkxxT3lUWGc1WTREMTJLcDRMZWNmV0xGcmplUy9mcXA2cHBNU1hvMTV6Rk5U?=
 =?utf-8?B?SmltRkNBRWxjdnZ5dGVBcVRVY1lGMUNzekU5cWw3Q1ovMHhQZStjZ05Ia2Nr?=
 =?utf-8?B?TXBzQUR6K1crSFU0MXFjQ0RQSTlGUDRiQzBaMHhvcHAzK3k2a2RTS3ppT2pH?=
 =?utf-8?B?ODVQa1lIOEtrVUpLTjkxdEdMdlZwS29HeEcrcmw0S3IxSGFGOTNEQnlaSW1L?=
 =?utf-8?B?L2Q5S3hzVDA1MXZLQkhNZG1FUGtmcEhKTi9TRDVucmpnVG9LbDZYVHZXR1M2?=
 =?utf-8?B?NFFaVWVEM3NjUkkwN1RVcVNKOVlncXNPWEFBaVg1UGp6ZUNkVTUwaGxhMlFF?=
 =?utf-8?B?WEFURVZDMy9xM20xM3FpWjhmTUI5RXprWURZdWtYaUhFbXlwMXdDN1NMVWpU?=
 =?utf-8?B?aFZKZkphSFBXWGJ3THdvSitjL2E5amhzOGJqckwzZFMyeFh4STV1NFpiM1kr?=
 =?utf-8?B?SjluZEZDZGkxQmV1aDhVaDM1aWVqb3JVMC95MERqNzlqUi8xZ3NxSVRWdUhm?=
 =?utf-8?B?ajd5bmMvU2VrWVR4TEVPNVJLcTN0NG1mR1ROYkJkbjM5cS9Eald4MHFoQXBV?=
 =?utf-8?B?ZXNGUE9IMW9mb3RXU2dEbVVzZ29xa0FJRjlCY1c2UHRibDRhTU5mYjhjNEd3?=
 =?utf-8?B?ZHNqbWhyZDBkMktybE9DMXJhK1RveWJqa1RCT3RncmlHcmRZTjJzM0toZVlD?=
 =?utf-8?B?SklqckdpdUk4R04vYWQ1Y21yMTlXVWZtMHBLcUxXZ1pWcmhGaDdQc2s3N3VB?=
 =?utf-8?B?dmFGOHErMnhvTVNXdktjcnNCV283QUorUktJbzFPQko2TllKWThZVjZqMWc1?=
 =?utf-8?B?aHBncGU3ZnJ2QWZwWERteGhlY1g3STMwL0xCb2pDQ253V2ZsOVROLzRtL0wv?=
 =?utf-8?B?MG9uZGhhakVsU1pDc2xZU3o3NFdMYkF6V1FPeC95bjRSZnVhb2UycWV1OEdj?=
 =?utf-8?B?Z3FTWHJKT3dtTzRwWnRxam5UR0g0cDlaYkhyV3lkQXpNUGxiQ3Ztc1JnUlRF?=
 =?utf-8?B?eTlQOTNmUlRGRGlyRHYwbDVrbWFIdmdPQnQ3bUxOQlUxMGJLd21oOUxOS21x?=
 =?utf-8?B?S1BkOFFNYlQxUktLN1BrUVlVTzJNNVNNZDlCL1VXTlZvVDFCYW9iMmpCczhk?=
 =?utf-8?B?eXA5aHc3VWxjK3JSK3B5bHI5T1d4RmQ2WWlpREpWQjdnMmpLa1FMYjBza05Y?=
 =?utf-8?B?RWZRbzJPUXZHK2VaSUprK0ZMYXRHUUZXdTh2N2taZ21SQkRJRjJjMFJTS0xS?=
 =?utf-8?B?MmZUcGZlejA0M2lDUHBIK3grNVJCL0F1WDN2ZDdjZnhDT2p1ZVhmWTNmL2dx?=
 =?utf-8?B?TktUdnZEQmFldUVTdHRJTFBpd3FObm0xZzloa0FGc3VieVd4NFlxQS9leExC?=
 =?utf-8?B?N2dvM3lRby9nWGZYMnJxdUlzMjNJMGRPc2t5QkxZY3ZVenJrWXFLTU50SzFI?=
 =?utf-8?B?SnM2S2o3ZTd4STE1RHorKzg1OVo0ZXcwOUxXTE5VWHF1QlhzYXZnL2kxbjBi?=
 =?utf-8?B?cHFVMkRDamtOdTZuRXkwWFAxSHRnSEc0SGpmSVhRaFRyUTUwbFhONzZPaE9m?=
 =?utf-8?B?NTFwNFRGVG9OODlocFJxc1FCWDdtMXByT2o0WU4rZlNpbXFwemY4TW10RTlp?=
 =?utf-8?B?dXVMYUI1TTNidTV0MlpvaU9TcVhMK2l0S0xvOHc4VFBUSkc0VjFIVTZ5QVBj?=
 =?utf-8?B?blRjNWROV1Mvd1QybnVQbDVteXZzVXZUMUZGV3hIN1VSajlQZXQyTTB3V0pz?=
 =?utf-8?B?bnhVVTg2Rmc2aU5jOUNrRjlBWWwwQ0pUQ1pFLzdhRXZiMHhSajJueE9kTnlu?=
 =?utf-8?B?NkZ3cUd5TGFEWklDNDBvdklVVHRxS0t4akxhZmFxK3lSbzhOemRNc1NESXJY?=
 =?utf-8?B?NHhQdnQvQ2xrRi9hSDBvMEJmZGpoRmxxeWJUVGhJRzViME41K2NxSXdnOXA0?=
 =?utf-8?Q?2B/AQHT3Z5mGsss2ca?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d412f6-698f-43c5-e147-08dec82cad27
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 02:45:34.2078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sffslj0HYbVZlhSOJsalF/HeSQKft3tgofEF88m/UNQtEqQ8c4QUvWPbUudqZBntlqAtvR7WE0//Yi0aVc+y8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12343
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298444-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4DE667651C

PiA+ICtzdGF0aWMgaW50IGVuZXRjX3ZmX3NldF9tYWNfaGFzaF9maWx0ZXIoc3RydWN0IGVuZXRj
X25kZXZfcHJpdiAqcHJpdiwNCj4gPiArCQkJCQlzdHJ1Y3QgbmV0ZGV2X2h3X2FkZHJfbGlzdCAq
dWMsDQo+ID4gKwkJCQkJc3RydWN0IG5ldGRldl9od19hZGRyX2xpc3QgKm1jKQ0KPiA+ICt7DQo+
IFsgLi4uIF0NCj4gPiArCWlmIChtYWNfZmlsdGVyX3R5cGUgJiBFTkVUQ19NQUNfRklMVEVSX1RZ
UEVfVUMpIHsNCj4gPiArCQltYWNfZmlsdGVyID0gJnNpLT5tYWNfZmlsdGVyW1VDXTsNCj4gPiAr
CQllbmV0Y19yZXNldF9tYWNfYWRkcl9maWx0ZXIobWFjX2ZpbHRlcik7DQo+ID4gKwkJbmV0ZGV2
X2h3X2FkZHJfbGlzdF9mb3JfZWFjaChoYSwgdWMpDQo+ID4gKwkJCWVuZXRjX2FkZF9tYWNfYWRk
cl9odF9maWx0ZXIobWFjX2ZpbHRlciwgaGEtPmFkZHIpOw0KPiA+ICsNCj4gPiArCQltZW1jcHko
Jmhhc2hfdmFsLCBtYWNfZmlsdGVyLT5tYWNfaGFzaF90YWJsZSwNCj4gPiArCQkgICAgICAgc2l6
ZW9mKGhhc2hfdmFsKSk7DQo+ID4gKwkJbXNnLT5oYXNoX3RibFtpKytdID0gaGFzaF92YWwgJiBH
RU5NQVNLKDMxLCAwKTsNCj4gPiArCQltc2ctPmhhc2hfdGJsW2krK10gPSBoYXNoX3ZhbCA+PiAz
MjsNCj4gPiArCX0NCj4gDQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBXaWxsIHRoaXMgbWVtY3B5
KCkgY29ycmVjdGx5IGhhbmRsZSBiaXRtYXBzIG9uIDMyLWJpdCBiaWctZW5kaWFuDQo+IGFyY2hp
dGVjdHVyZXM/DQo+IA0KPiBBIERFQ0xBUkVfQklUTUFQIGlzIGFuIGFycmF5IG9mIDMyLWJpdCB3
b3Jkcywgd2hlcmUgd29yZCAwIChiaXRzIDAtMzEpIGlzDQo+IHN0b3JlZCBhdCBsb3dlciBhZGRy
ZXNzZXMgYW5kIHdvcmQgMSAoYml0cyAzMi02MykgaXMgYXQgaGlnaGVyIGFkZHJlc3Nlcy4NCj4g
DQo+IFdoZW4gbWVtY3B5KCkgY29waWVzIHRoZXNlIDggYnl0ZXMgaW50byBhIHU2NCB2YXJpYWJs
ZSBvbiBhIGJpZy1lbmRpYW4NCj4gc3lzdGVtLCB3b3JkIDAgYmVjb21lcyB0aGUgbW9zdCBzaWdu
aWZpY2FudCAzMiBiaXRzIGFuZCB3b3JkIDEgYmVjb21lcyB0aGUNCj4gbGVhc3Qgc2lnbmlmaWNh
bnQgMzIgYml0cy4gVGhlIHN1YnNlcXVlbnQgYml0d2lzZSBvcGVyYXRpb25zDQo+IChoYXNoX3Zh
bCAmIEdFTk1BU0soMzEsIDApIGFuZCBoYXNoX3ZhbCA+PiAzMikgdGhlbiBleHRyYWN0IHRoZSBo
YWx2ZXMgaW4NCj4gcmV2ZXJzZSBvcmRlciBjb21wYXJlZCB0byA2NC1iaXQgb3IgbGl0dGxlLWVu
ZGlhbiBzeXN0ZW1zLCB3aGljaCBzaWxlbnRseQ0KPiBzd2FwcyB0aGUgaGFyZHdhcmUgZmlsdGVy
IGNvbmZpZ3VyYXRpb24uDQo+IA0KPiBTaG91bGQgdGhpcyB1c2UgYml0bWFwX3RvX2FycjMyKCkg
aW5zdGVhZCB0byBzYWZlbHkgY29udmVydCB0aGUgYml0bWFwIHRvDQo+IGEgdTMyIGFycmF5IGFj
cm9zcyBhbGwgYXJjaGl0ZWN0dXJlcz8NCg0KRU5FVEMgb25seSB1c2VkIG9uIGFybTY0IGxpdHRs
ZS1lbmRpYW4gYXJjaGl0ZWN0dXJlcywgYnV0IHRoaXMgbG9naWMgY2FuDQpiZSBpbXByb3ZlZC4N
Cg0KPiANCj4gPiArDQo+ID4gKwlpZiAobWFjX2ZpbHRlcl90eXBlICYgRU5FVENfTUFDX0ZJTFRF
Ul9UWVBFX01DKSB7DQo+ID4gKwkJbWFjX2ZpbHRlciA9ICZzaS0+bWFjX2ZpbHRlcltNQ107DQo+
ID4gKwkJZW5ldGNfcmVzZXRfbWFjX2FkZHJfZmlsdGVyKG1hY19maWx0ZXIpOw0KPiA+ICsJCW5l
dGRldl9od19hZGRyX2xpc3RfZm9yX2VhY2goaGEsIG1jKQ0KPiA+ICsJCQllbmV0Y19hZGRfbWFj
X2FkZHJfaHRfZmlsdGVyKG1hY19maWx0ZXIsIGhhLT5hZGRyKTsNCj4gPiArDQo+ID4gKwkJbWVt
Y3B5KCZoYXNoX3ZhbCwgbWFjX2ZpbHRlci0+bWFjX2hhc2hfdGFibGUsDQo+ID4gKwkJICAgICAg
IHNpemVvZihoYXNoX3ZhbCkpOw0KPiA+ICsJCW1zZy0+aGFzaF90YmxbaSsrXSA9IGhhc2hfdmFs
ICYgR0VOTUFTSygzMSwgMCk7DQo+ID4gKwkJbXNnLT5oYXNoX3RibFtpKytdID0gaGFzaF92YWwg
Pj4gMzI7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJZW5ldGNfbXNnX2ZpbGxfY29tbW9uX2hkcigm
bXNnX3N3YmQsDQo+IEVORVRDX01TR19DTEFTU19JRF9NQUNfRklMVEVSLA0KPiA+ICsJCQkJICBF
TkVUQ19NU0dfU0VUX01BQ19IQVNIX1RBQkxFLCAwLCAwKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4g
ZW5ldGNfbXNnX3ZzaV9zZW5kKHNpLCAmbXNnX3N3YmQpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtz
dGF0aWMgdm9pZCBlbmV0Y192Zl9zZXRfcnhfbW9kZShzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwN
Cj4gPiArCQkJCSBzdHJ1Y3QgbmV0ZGV2X2h3X2FkZHJfbGlzdCAqdWMsDQo+ID4gKwkJCQkgc3Ry
dWN0IG5ldGRldl9od19hZGRyX2xpc3QgKm1jKQ0KPiA+ICt7DQo+IA0KPiBbU2V2ZXJpdHk6IEhp
Z2hdDQo+IERvZXMgdGhpcyBmdW5jdGlvbiBzaWduYXR1cmUgY2F1c2UgYSBDb250cm9sIEZsb3cg
SW50ZWdyaXR5IChDRkkpIHBhbmljPw0KPiANCj4gVGhlIG5kb19zZXRfcnhfbW9kZV9hc3luYyBj
YWxsYmFjayBleHBlY3RzIGEgZnVuY3Rpb24gcmV0dXJuaW5nIGFuIGludCwNCj4gYnV0IGVuZXRj
X3ZmX3NldF9yeF9tb2RlKCkgaXMgZGVmaW5lZCB3aXRoIGEgdm9pZCByZXR1cm4gdHlwZS4gVGhp
cw0KPiBtaXNtYXRjaCB3aWxsIHRyaWdnZXIgYSBDRkkga2VybmVsIHBhbmljIG9uIGFyY2hpdGVj
dHVyZXMgd2l0aCBDRkkgZW5hYmxlZC4NCj4gDQo+IEFkZGl0aW9uYWxseSwgYmVjYXVzZSBpdCBy
ZXR1cm5zIHZvaWQsIHRoZSBjYWxsZXIgX19kZXZfc2V0X3J4X21vZGVfYXN5bmMoKQ0KPiB3aWxs
IHJlYWQgdW5pbml0aWFsaXplZCBnYXJiYWdlIGZyb20gdGhlIHJldHVybiByZWdpc3Rlci4gSWYg
dGhhdCBnYXJiYWdlIGlzDQo+IG5vbi16ZXJvLCBjb3VsZCBpdCBjYXVzZSBjb250aW51b3VzIHBv
bGxpbmcgcmV0cmllcyBpbiB0aGUgbmV0d29yayBzdGFjaz8NCj4gDQoNCkkgd2FzIG5vdCBhd2Fy
ZSBvZiB0aGUgbmRvX3NldF9yeF9tb2RlX2FzeW5jKCkgaW50ZXJmYWNlIGhhZCBiZWVuIGNoYW5n
ZWQNCnJlY2VudGx5LCBJIHdpbGwgZml4IHRoaXMgaXNzdWUgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+
IFsgLi4uIF0NCj4gPiArCWlmIChuZGV2LT5mbGFncyAmIElGRl9QUk9NSVNDKSB7DQo+ID4gKwkJ
ZW5ldGNfdmZfc2V0X21hY19wcm9taXNjKHByaXYsIEVORVRDX01BQ19GSUxURVJfVFlQRV9BTEws
DQo+IHRydWUpOw0KPiA+ICsJfSBlbHNlIGlmIChuZGV2LT5mbGFncyAmIElGRl9BTExNVUxUSSkg
ew0KPiA+ICsJCWVuZXRjX3ZmX3NldF9tYWNfcHJvbWlzYyhwcml2LCBFTkVUQ19NQUNfRklMVEVS
X1RZUEVfTUMsDQo+IHRydWUpOw0KPiA+ICsJCWVuZXRjX3ZmX3NldF9tYWNfcHJvbWlzYyhwcml2
LCBFTkVUQ19NQUNfRklMVEVSX1RZUEVfVUMsDQo+IGZhbHNlKTsNCj4gPiArCX0gZWxzZSB7DQo+
ID4gKwkJZW5ldGNfdmZfc2V0X21hY19wcm9taXNjKHByaXYsIEVORVRDX01BQ19GSUxURVJfVFlQ
RV9BTEwsDQo+IGZhbHNlKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwllbmV0Y192Zl9zZXRfbWFj
X2hhc2hfZmlsdGVyKHByaXYsIHVjLCBtYyk7DQo+ID4gK30NCj4gDQo+IFtTZXZlcml0eTogSGln
aF0NCj4gQXJlIHRoZSBlcnJvciBjb2RlcyBmcm9tIHRoZXNlIG1haWxib3ggY29tbWFuZHMgaW5h
ZHZlcnRlbnRseSBiZWluZw0KPiBkcm9wcGVkPw0KPiANCj4gQmVjYXVzZSB0aGlzIGZ1bmN0aW9u
IGlzIGRlZmluZWQgYXMgdm9pZCBhbmQgZG9lc24ndCByZXR1cm4gdGhlIHJlc3VsdHMgb2YNCj4g
ZW5ldGNfdmZfc2V0X21hY19wcm9taXNjKCkgb3IgZW5ldGNfdmZfc2V0X21hY19oYXNoX2ZpbHRl
cigpLCBhbnkgaGFyZHdhcmUNCj4gY29uZmlndXJhdGlvbiBlcnJvcnMgYXJlIGRpc2NhcmRlZCBp
bnN0ZWFkIG9mIHByb3BhZ2F0ZWQgdG8gdGhlIG5ldHdvcmsNCj4gc3RhY2ssIHdoaWNoIGJyZWFr
cyB0aGUgZnJhbWV3b3JrJ3MgcmV0cnkgbWVjaGFuaXNtLg0KPiANCj4gWyAuLi4gXQ0KPiA+IEBA
IC0yMjUsNiArMzQxLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBuZXRfZGV2aWNlX29wcyBlbmV0
Y19uZGV2X29wcyA9DQo+IHsNCj4gPiAgCS5uZG9fc2V0dXBfdGMJCT0gZW5ldGNfdmZfc2V0dXBf
dGMsDQo+ID4gIAkubmRvX2h3dHN0YW1wX2dldAk9IGVuZXRjX2h3dHN0YW1wX2dldCwNCj4gPiAg
CS5uZG9faHd0c3RhbXBfc2V0CT0gZW5ldGNfaHd0c3RhbXBfc2V0LA0KPiA+ICsJLm5kb19zZXRf
cnhfbW9kZV9hc3luYwk9IGVuZXRjX3ZmX3NldF9yeF9tb2RlLA0KPiA+ICB9Ow0KDQotLQ0KcHct
Ym90OiBjcg0KDQo=

