Return-Path: <netdev+bounces-296114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7rutB9kiJGo03gEAu9opvQ
	(envelope-from <netdev+bounces-296114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 15:38:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 707B964DA98
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 15:38:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=JWBKY6pb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296114-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296114-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A20DD302012F
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 13:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4848E3B0ACB;
	Sat,  6 Jun 2026 13:37:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18604071FD
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 13:37:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780753041; cv=fail; b=enq0//Rv1ieP7/T1aBjld0hAvz/z0gL/gOXAdYSUEJwgnIVFmEdZIv5o9kpS7f/6FGlAXp913/mVf04STXfyjcQdSgOwkuqtjn2kyVzc5OfD0cpUASopoCrHKHhcUg2JTy0/l4qEAohZdpdJoJ+8myVWZqTlta7RXJrS5YGCAhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780753041; c=relaxed/simple;
	bh=DBgk/XoJT2BaF3wYcqGx8G1TRbN8mIeivCYQOhFT6Dg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mv9Y8oRGCACFgw2FmnH1oPGWCRCEapDJ3AYaOtXKm/a4ZRUCy4wxC9E4p2HGAxCzvQhxixiQC2TqLVXD+fBGNdeLmo7aLOittHGWc/rVLLPCTt99KUYmd56/ZkPCdcIoQnis9xlVLG5nskzXEtgWeIKRH8Glkn2IpofrDzHPip8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JWBKY6pb; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMryOTPigIGImmx3fh15xHSH2cW/QAbp6lR447sp+/3OYLULibyi+T/DHBSXQpJByhFwNF7/IR6eaQtx4899O/dPFBCwGeDMngaBS6kY0cU5aAIEIiLjhzmSigPzgWfIxN+ixo2ePjBS3e72Q8d3rUzFzHmwhcib01fJWJ98BXPaUa0ajeG/cNWU5/9U/y/uFEdCarUB5jDqBhL4eiUBxEvjC6QYv0vQ9wM+VKujuM6UKQ+u8CvvNj1bUv3OUKQG0RCHAaObUTIFJAVjkWVWJaitihIUwc0G2lHgwnhA2XbcF9Z8gsrEN8+EQPCOtgGbPOZXXOpISiEqe3J1qfOsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBgk/XoJT2BaF3wYcqGx8G1TRbN8mIeivCYQOhFT6Dg=;
 b=lZcYAygBxhnTJ3QfZZs30LgytktDnWVn5w7xUzRgNt8gd/kiZ0Xmexy76hOj1sxz1etaxJLB+o5NJwlKYSD1YdSrLG2+N7+dOvxu9kKkKKpS3ikP4HPIdqaAf3KU92c0NJq8YeXKN8I/yu8FX2JX2c03fZl/3FR16pduuBcjSxDA/NcJWUQgvwEB0bDY2JGAXuue+c+pFvHvpGrUA3r+xto1+X01ZjMWs0/QepOmiBm2m3e/qtLZ5gGFEIjpnUWMoF6QlvaFNMEOAkLJCOLtv/WE0zCcl3Z82vKV1htUHaPsRa1lXAWvxzigOA1+4xMDYjOgzwLFCA/RCyekfIWINg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBgk/XoJT2BaF3wYcqGx8G1TRbN8mIeivCYQOhFT6Dg=;
 b=JWBKY6pbTV6iQFAClsSqFnxVOY796mkFggrEu0+DnEYrbJOG5jF/3g9zvN3mrUZLzryTQZHgIQ9My3EW7DElsCAQ2VefJVU/9ayGMPTZ7WSskUQqJWngO4xkhlrNolTvMVywjAbkH5OHq8cDcez9XD2LpZfODxtg+J9x4Yh2ITXSvIJGJMJP8VOpC0nR2R7PnSAvzZmhcowwRzlEJOPrWYKcyTHhqkNPIloYp63yHvzBJgylML9XyfehndMospsB36o/E0KRU0ZMfEqLXbO+FbFni+FuvaXFix1Beo7mPGEC4lnejbIBibTS8+Sg/ItDrHXkBTUugf6zScu0nxhEzw==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by AM8PR04MB8004.eurprd04.prod.outlook.com (2603:10a6:20b:248::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Sat, 6 Jun 2026
 13:37:15 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0092.010; Sat, 6 Jun 2026
 13:37:15 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, "Wei
 Fang (OSS)" <wei.fang@oss.nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next 01/15] net: enetc: add trusted VF support
Thread-Topic: [PATCH net-next 01/15] net: enetc: add trusted VF support
Thread-Index: AQHc9LwlSntGxeFL5UmNlI0+pNTl5rYxIZgAgABoGWA=
Date: Sat, 6 Jun 2026 13:37:15 +0000
Message-ID:
 <DU2PR04MB86295E0E909F73CDC32821BA881E2@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260605065550.3038579-2-wei.fang@oss.nxp.com>
 <20260606072438.8E70F1F00893@smtp.kernel.org>
In-Reply-To: <20260606072438.8E70F1F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|AM8PR04MB8004:EE_
x-ms-office365-filtering-correlation-id: 9e1f2523-8dca-405b-3433-08dec3d0b8e4
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700021|22082099003|18002099003|3023799007|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 2Vc6A228eN8bYUB8dUSne7uRUfReuUA9dM9A8XgAZCoBLMn19dzcZ3rD4lJ0AoegRK3sPrHFZI/NEe7EzQkSr6c6Hnog1CcZrBTMb3TiMg5KOydriBl/nP6ItSKzKOeST7k3XpUZf9sw10r2u7TKl60Mg56eN+y97RT2F3dYWI2nBdrtlNKzGHiVTxehfAC/S7p9JhXZfxr5QTH1POQpB6QjHgyuBGqzFhKNd8MsKmPqmm+mKejBoRiwn8stlQguT3XRfZrcR22Be9P/d3nI+iOVVN78Fn4zZp0gR/w7M2zNqMLfXzPMHyp7AkSeBgk7qUkuvvmBB3vGcjc4LDHE3aBZFTkhUUzGtvED6NZiwrBbDrszBlKMzVVgES6xPzk8SobSc9D6nhYpq3hlxxM17o7O2PK3DDEEwwLzLQOBO9RyRuxpy4/Mm/bM0MviV3Jqr+UfDt0/L9u7d9YLisQwkY9/jdrmM4drF/TR9N3E5Wdveca51GSiw82F4eAbWYgfneZWdlWLmKkBQsc+8i+bsoSXubYWWQxBCZhQwPjsjQFcV+hlzSKEsC4de6eeleZXkq1mYcNE0YKymltTQXiQiDQcH/Fh6O78mSofPnF6Zemq3uZjtTv1/kxMcNWBuD8QPhNErrQ2L/McwlX/euW+B9FzEM5sFCIwaWW5et6mw+4Whi9/OaQ/RblZ5db4MlH6RZNmly3Q28uqLc97gB0bw845RKvi7s5aiStI9dah+FtnWafS7zdbxtjqcR/xyHUO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2F2dHJaZUNQYjJqS3A5VmpUdlR5dnd1M3cvLzdDWE5BWEdLdlJ5MjRKZG1r?=
 =?utf-8?B?OFBDbk5RV2Y4cXEyaGgvUGRjWjlGdHdGNUk2bnU2RlI0eWpzZG50aU85cU51?=
 =?utf-8?B?V0NSVGJjdUFVKzFKaWRjUDFhRFFXeUhTTTlOSjU0ZUJZUkUwVHFBcmErRVdP?=
 =?utf-8?B?Q1FYMjBJQnF4eFQrWVM4bEI2eTlTeDBZTmtXM0xScGhUczMrMC9DTVRBN21l?=
 =?utf-8?B?Umo0MDdnYXRid21mQzAyNXkveFBNb2FlM1BRUVIxZ21Bb2FBWkgzd2w2ODQ3?=
 =?utf-8?B?R2dsVkNVRkpYUzJ6dzUrYU4rM0pHUWNadm9vci9jY2MrL085M3NFZFhkTVd4?=
 =?utf-8?B?Ny9RRkFmaDlWQXcxTm5rMi9DYUowcFo3a25SY2RjQUEyWWVVUTYwZkFyR2F5?=
 =?utf-8?B?T1ZDUlExc1V6RTVwQ01ScjZWS25YdFgwdTVkYzVvUG5YbzZHQUdhajV4bnB0?=
 =?utf-8?B?SXJEUkpJTUx2UU5SKzhRY1JJVUtiRE50WkNVU3AxVmNGRTQ0cGFFZGhTUm90?=
 =?utf-8?B?bHNZcmZOT0h5SXlnS21NeUJ6L0ZuMU9rdjNyUENEYnhCcFFCcDJmWDZaQWhy?=
 =?utf-8?B?b0oxN1cvcHN4cFc0NkRnVTNiZkIxblRPeUNnbVRWbkFyRXZuRDg1TGZiTDkw?=
 =?utf-8?B?aFAwNWEzbjF4aitJR05NRlJWb1V0bkhTa3p1V0JPamRQdUFMRjhDS2M2SFg1?=
 =?utf-8?B?NTlCWGlHRWVYT2lsblhxODBHOU1wb2x5UDlSa2c4SUpNd2dtUXBVZHRqcjZm?=
 =?utf-8?B?OUpUREEvblNobVcyTHgrV21LdWxTbGxXU0t1bnpSSFVUdXc5cm10N1BvcEQv?=
 =?utf-8?B?NzE1UFBmNUVjdnREVDJUVXFwY1BVeDV3L0svMjVCdDBxcC9lOXUrSVpXR3F6?=
 =?utf-8?B?eFhsN3hpU2JiVnZkZ3pxN0p0TmRRYUJPdXhqdW9YcUpCS1BES3BzZFFBV1NX?=
 =?utf-8?B?YjdUMnQxWEFydUNtS1FZSVBlQUpWSmZUWVZhN3lBeG95SGRHL2pLT3Fad2JX?=
 =?utf-8?B?Mko4UEJvZTFNVlYrWjlvVkhUUFhjYWpVZ3BycjBhbG9IWkJtMnFFc2dsV2Zh?=
 =?utf-8?B?SlRQSm51Z0F4NEFlbHFTT3FKTWlBMGZ2L0RoMTN0MTlic0tCdXhaU1VnOVli?=
 =?utf-8?B?TVNhWXFWVTlweW43OVlqQTZBLzkyaFF0bURaVXIrT2xkVVR1MnBrV2I3M2s4?=
 =?utf-8?B?R296elZZNGdQSk1CZWdzenllNjUvUnJKVUQ3bWtlenlGb3JWRXpkcXBMS3d6?=
 =?utf-8?B?SW1xNmdMOTY4RmlGbi9DU2NhUE1EU1dtR1FHSWZZUWUzNlBWM25kdWlzMmJ3?=
 =?utf-8?B?SnJRc3NYZGZFOGg2a05zRktsbWVmdm1QNDliZmIzZUNiUmxhd1QvNnRIaGhM?=
 =?utf-8?B?Mm1mQXVUaVBOcWMrNVN2Nkg4Nk15aE1acHo0Q0Z4VW9XUWVDTUJCR01OSDhL?=
 =?utf-8?B?MG52U1ZXY24vUzBHRjJoRzhDbTRNREkwUjYxR0cxbk51VGlkbVNWa1FuNWo2?=
 =?utf-8?B?SEtnSTVJMTFXQUU5bGNvMmNUU3hnc2plWktvdFNOYS9YWi9DTkZXSWt1Mzht?=
 =?utf-8?B?SHFDNGNXdTBBL1A1Y0xSTlAzR0thdk9MLzZmMFBaaVB5OXpDcTdxaThLdVpJ?=
 =?utf-8?B?SitpN1VGTldXemgvelk5c1UyWXJqL1NNRHlwemtqWU9JMTN5WDNxNVZIOTVP?=
 =?utf-8?B?UmN6Y1d2bUViZDVFdktGMWgxZE9mSmIwZGxORHlZSGQyYTkweUNjM3Y5VXEx?=
 =?utf-8?B?NCtwL1RJWFp2UkxZZDN0bmM0MWJ2VlhIU1BpTXova0UvbHJYRm02VW5veVRR?=
 =?utf-8?B?Nk8rS3I3dmRObUcrZXZxSDljK0x0aXllS3dJeUtXOTZrU0tKektVcDUxd09a?=
 =?utf-8?B?ZDl0OUloUjBpa1R3VVlFK2FNc3NhcEJ6NUhPdXZ4dzJYTTBNTnRoSk5iZVVv?=
 =?utf-8?B?QXN1bGhzRG9sTWxrbGt1ZmNDQkQvS2MycXBBNFh2b2tGZHQ5S05aS1dSTFlt?=
 =?utf-8?B?MUpIZTVNRXBzUDJHVFJBZGRRbW1URWRIaXExYVp2RjQvTGRhVkM1emxHYXc5?=
 =?utf-8?B?MXFESitCN3RKb1EraGFqaW9RSUdUNVZ3UDV4VnlTdFJ5eFRhTXNGUUlqZ01D?=
 =?utf-8?B?K2ppbjFLbHFDaE9DVHdVakhSUmdsM0VYVC9lZ1JpRWowc0lXTm1aVVhSY2gx?=
 =?utf-8?B?SVZQZGVRT05nQXJMRGV4b2FCdmxkeVVCL3NucWhPS0lxSkoxcmVpR2s1eTJ0?=
 =?utf-8?B?cXFyTDduUGh1QWxZV24wVWFCVEEwVE9NNk5iN0VsOFkzU3Z2UFpGeUVyRTM3?=
 =?utf-8?Q?ggTW9Jq6p2Wi3EEFrL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1f2523-8dca-405b-3433-08dec3d0b8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2026 13:37:15.5319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtfaE8DFfH0GJBKs75c3Nbp3C3cOXCQbxinC5EiOX/bbYCgoIN4Xk7Eij+wMtSTPBa9gYjRB9mYYoBU9nwywjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8004
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:wei.fang@oss.nxp.com,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296114-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 707B964DA98

PiA+IEBAIC02MSwzMSArNjMsNDEgQEAgc3RhdGljIHUxNg0KPiBlbmV0Y19tc2dfc2V0X3ZmX3By
aW1hcnlfbWFjX2FkZHIoc3RydWN0IGVuZXRjX3BmICpwZiwgaW50IHZmX2lkLA0KPiA+ICAJc3Ry
dWN0IGVuZXRjX3ZmX3N0YXRlICp2Zl9zdGF0ZSA9ICZwZi0+dmZfc3RhdGVbdmZfaWRdOw0KPiA+
ICAJc3RydWN0IGVuZXRjX21zZ19tYWNfZXhhY3RfZmlsdGVyICptc2cgPSB2Zl9tc2c7DQo+ID4g
IAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGYtPnNpLT5wZGV2LT5kZXY7DQo+ID4gKwl1MTYgcGZf
bXNnID0gRU5FVENfUEZfTVNHX1NVQ0NFU1M7DQo+ID4gIAljaGFyICphZGRyID0gbXNnLT5tYWNb
MF0uYWRkcjsNCj4gPg0KPiA+ICsJbXV0ZXhfbG9jaygmdmZfc3RhdGUtPmxvY2spOw0KPiA+ICsN
Cj4gPiArCWlmICghKHZmX3N0YXRlLT5mbGFncyAmIEVORVRDX1ZGX0ZMQUdfVFJVU1RFRCkpIHsN
Cj4gPiArCQlwZl9tc2cgPSBFTkVUQ19QRl9NU0dfUEVSTV9ERU5ZOw0KPiA+ICsJCWdvdG8gdmZf
c3RhdGVfdW5sb2NrOw0KPiA+ICsJfQ0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBVbmRlciBz
dGFuZGFyZCBMaW51eCBTUi1JT1Ygc2VtYW50aWNzLCB1bnRydXN0ZWQgVkZzIGFyZSBhbGxvd2Vk
IHRvIHNldCB0aGVpcg0KPiBvd24gTUFDIGFkZHJlc3MgcHJvdmlkZWQgdGhlIFBGIGhhcyBub3Qg
YWRtaW5pc3RyYXRpdmVseSBsb2NrZWQgaXQgKGkuZS4gd2hlbg0KPiBQRl9TRVRfTUFDIGlzIGZh
bHNlKS4gRG9lcyB0aGlzIGNoZWNrIHVuY29uZGl0aW9uYWxseSBkZW55IGFsbCBNQUMgY2hhbmdl
cw0KPiBmcm9tDQo+IHVudHJ1c3RlZCBWRnM/IElmIHNvLCBjb3VsZG4ndCB0aGlzIGJyZWFrIGJh
Y2t3YXJkIGNvbXBhdGliaWxpdHkgYW5kIGJyZWFrDQo+IGd1ZXN0DQo+IE9TZXMgdGhhdCBhdHRl
bXB0IHRvIGFzc2lnbiBhIHJhbmRvbSBNQUMgb24gYm9vdD8NCg0KSSBkbyBub3QgdGhpbmsgYW4g
dW50cnVzdGVkIFZGIGNhbiBzZXQgaXRzIG93biBNQUMuIElmIHNvLCBpdCBjYW4gc2V0IHRoZQ0K
YWRkcmVzcyB0byB0aGUgYWRkcmVzcyBvZiBhbm90aGVyIFZGIG9yIFBGLCBhbmQgZWF2ZXNkcm9w
IG9uIHRyYWZmaWMgc2VudA0KdG8gb3RoZXIgbmV0d29yayBpbnRlcmZhY2VzLiBGdXJ0aGVybW9y
ZSwgYSBtYWxpY2lvdXMgVk0gdGhhdCBhcmJpdHJhcmlseQ0KY2hhbmdlcyBpdHMgTUFDIGFkZHJl
c3MgY2FuIGFjaGlldmUgTUFDIGFkZHJlc3Mgc3Bvb2ZpbmcgYW5kIGJ5cGFzcw0Kc2VjdXJpdHkg
cG9saWNpZXMuDQoNCj4gDQo+ID4gKw0KPiA+ICAJaWYgKCFpc192YWxpZF9ldGhlcl9hZGRyKGFk
ZHIpKSB7DQo+ID4gIAkJZGV2X2Vycl9yYXRlbGltaXRlZChkZXYsICJWRiVkIGF0dGVtcHRlZCB0
byBzZXQgaW52YWxpZCBNQUNcbiIsDQo+ID4gIAkJCQkgICAgdmZfaWQpOw0KPiA+IC0JCXJldHVy
biAoRklFTERfUFJFUChFTkVUQ19QRl9NU0dfQ0xBU1NfSUQsDQo+ID4gLQkJCQkgICBFTkVUQ19N
U0dfQ0xBU1NfSURfTUFDX0ZJTFRFUikgfA0KPiA+IC0JCQlGSUVMRF9QUkVQKEVORVRDX1BGX01T
R19DTEFTU19DT0RFLA0KPiA+IC0JCQkJICAgRU5FVENfTUZfQ0xBU1NfQ09ERV9JTlZBTElEX01B
QykpOw0KPiA+ICsJCXBmX21zZyA9IEZJRUxEX1BSRVAoRU5FVENfUEZfTVNHX0NMQVNTX0lELA0K
PiA+ICsJCQkJICAgIEVORVRDX01TR19DTEFTU19JRF9NQUNfRklMVEVSKSB8DQo+ID4gKwkJCSBG
SUVMRF9QUkVQKEVORVRDX1BGX01TR19DTEFTU19DT0RFLA0KPiA+ICsJCQkJICAgIEVORVRDX01G
X0NMQVNTX0NPREVfSU5WQUxJRF9NQUMpOw0KPiA+ICsJCWdvdG8gdmZfc3RhdGVfdW5sb2NrOw0K
PiA+ICAJfQ0KPiA+DQo+ID4gLQltdXRleF9sb2NrKCZ2Zl9zdGF0ZS0+bG9jayk7DQo+ID4gIAlp
ZiAodmZfc3RhdGUtPmZsYWdzICYgRU5FVENfVkZfRkxBR19QRl9TRVRfTUFDKSB7DQo+ID4gLQkJ
bXV0ZXhfdW5sb2NrKCZ2Zl9zdGF0ZS0+bG9jayk7DQo+ID4gIAkJZGV2X2Vycl9yYXRlbGltaXRl
ZChkZXYsDQo+ID4gIAkJCQkgICAgIlZGJWQgYXR0ZW1wdGVkIHRvIG92ZXJyaWRlIFBGIHNldCBN
QUNcbiIsDQo+ID4gIAkJCQkgICAgdmZfaWQpOw0KPiA+IC0JCXJldHVybiBGSUVMRF9QUkVQKEVO
RVRDX1BGX01TR19DTEFTU19JRCwNCj4gPiAtCQkJCSAgRU5FVENfTVNHX0NMQVNTX0lEX0NNRF9O
T1RfUEVSTUlUVEVEKTsNCj4gPiArCQlwZl9tc2cgPSBGSUVMRF9QUkVQKEVORVRDX1BGX01TR19D
TEFTU19JRCwNCj4gPiArCQkJCSAgICBFTkVUQ19NU0dfQ0xBU1NfSURfQ01EX05PVF9QRVJNSVRU
RUQpOw0KPiA+ICsJCWdvdG8gdmZfc3RhdGVfdW5sb2NrOw0KPiA+ICAJfQ0KPiANCj4gW1NldmVy
aXR5OiBIaWdoXQ0KPiBEb2VzIHRoaXMgaW5jb3JyZWN0bHkgZGVueSBNQUMgY2hhbmdlcyBmcm9t
IHRydXN0ZWQgVkZzIGlmIHRoZSBQRiBoYXMNCj4gYXNzaWduZWQNCj4gYSBNQUM/IFNpbmNlIHRo
aXMgRU5FVENfVkZfRkxBR19QRl9TRVRfTUFDIGNoZWNrIGhhcHBlbnMgYWZ0ZXIgdGhlDQo+IFRS
VVNURUQgY2hlY2sNCj4gYW5kIHVuY29uZGl0aW9uYWxseSByZWplY3RzIHRoZSBvcGVyYXRpb24s
IGl0IGFwcGVhcnMgdG8gdmlvbGF0ZSB0aGUgc3RhbmRhcmQNCj4gc2VtYW50aWNzIHRoYXQgdHJ1
c3RlZCBWRnMgY2FuIG92ZXJyaWRlIGEgUEYtc2V0IE1BQy4NCg0KUEYgaGFzIGhpZ2hlciBwcml2
aWxlZ2VzLiBJZiBQRiBoYXMgYWxyZWFkeSBjaGFuZ2VkIHRoZSBNQUMgYWRkcmVzcyBmb3IgVkYs
DQpWRiBpcyBub3QgYWxsb3dlZCB0byBjaGFuZ2UgdGhlIGFkZHJlc3MgdmlhIG1haWxib3ggbWVz
c2FnZXMsIGV2ZW4gaWYgaXQgaXMNCnRydXN0ZWQuIFRoaXMgaXMgdGhlIG9yaWdpbmFsIGRlc2ln
biBpbnRlbnRpb24uDQoNClRoZXNlIHdhcm5pbmdhIGFyZSBmYWxzZSBwb3NpdGl2ZXMuDQoNCg==

