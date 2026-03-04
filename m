Return-Path: <netdev+bounces-263573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNe3LY2np2kHjAAAu9opvQ
	(envelope-from <netdev+bounces-263573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 04:31:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F7E1FA5C3
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 04:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B53FF3018E17
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 03:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4173033122D;
	Wed,  4 Mar 2026 03:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="K1WEVuMx"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023119.outbound.protection.outlook.com [52.101.127.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B90200110;
	Wed,  4 Mar 2026 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595079; cv=fail; b=iruIkOrTXX+uRgaL4n1g7RKE8Js8/Y5YQUR+q2baF1IRLI2g8cK5fJsuGX+CoD7NySFlgC5nn3Cnat63aWgawg3gC7m5DVokq4xlNlWE68iv3PlkUrGrLevQX+N4by/USVIBQ1OVlxxLa+/Iv6zoEua5dXCGeNcq0dHh2B75OFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595079; c=relaxed/simple;
	bh=lLXZFp4giiOdX25VZQU4hbSU6ApSY/6+7IV76geJBwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ey19iCebIni4V3UbrzjT4UZe7cHaP1UAKKj5ZFp+c3u7tcvwtJeZfDnfAkCwEHk1X5fAhyFgzPQg5Q5VNsg0sbwMYw12vPlcY8g61Pjqur2KiCGHQdpLMFfqFlYYc9h/HoKsh8fVhX4EKxrdxmoARNxHm5FILzPJ4RlU8DENkKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=K1WEVuMx; arc=fail smtp.client-ip=52.101.127.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoNlM87K8Y1iKG8GBF0Qtdxzgp1ebp6nE0nJ/QXnPPeYM58tLcglbRLqVmtLxYgsaZSxzTyX72SoP/8z9KzCX8IFk/ah0D1IcAaddPQnOuUQUeiDdHVZuU5RZF+gm6VFWe47kqcH/RfDNnVJXH1Q9LoNK4hkxXuYVabJvwx8pLOeba5gpV77HTT3lvV/qrm22A+I8KedqNsNemdjmUjqVzyDrEAfXoLbIOzlVMos+qbA8eZexsYt43nhnRh1vqVht1cq/2vtxgr+gJnBzTZK0UIqUnpW9EHVslPwcXpIv34Y8ip6KfDuuArbhaeUd0cYkRDAoUoI5sdY8VSfz5+/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLXZFp4giiOdX25VZQU4hbSU6ApSY/6+7IV76geJBwk=;
 b=C7A0OllfBMgOWOogXPQf2Q4KLY5kBJl4ONk0EDS4sUW/5fmfRZTfCLIzlnk5N8YLC4r0OdHweK5up1LRdC1ejJQvj8h/OYmcwjiQDzOkQ14CkROBbD6LRFTf7uM1ZAztURILaQRZbJe20nZDWrm7Bk7FtyLl85FwWrkPFYgN01jtZMN4IFVJTfepueNSAoBdVZ8IQiGxPfBiziLkChptyhw8OoSVhYX9KFeBgmw+HaP98SFahy/xtuZ+2wIw616HHcMsFjS4F32ymL87qWM50XdqJXHj8OfG6n0ZkH9zLgJCYw9v7VXmxvxQDBBKGRgBKYRWaTHwzcd1Hu9pwfPRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLXZFp4giiOdX25VZQU4hbSU6ApSY/6+7IV76geJBwk=;
 b=K1WEVuMxSjw26nt2o4pd2sX18qcDZRc8tNxdGLFG+30+jY86LrzqbkoKrJTDofQBtd2DPmyb+Dz4uFqWubIfjRcKW/7dvVoEY6gC7aG8lvl8/jTm2Gm5guNyzep1pWRUqwf5wN/1p1KaKH+fXfFy+uemf0dXfk76aSZu2mxOiSpiEUmJ3/xXlnCjAbYANJrbm+lyjVdQXT56pZNLSH7TDuGiMR7Jf4HRr5RMtH/7QhBPeX/HY39lK4QxIJ7LCsIW9vvuZCBI1QzstcxbuY8ZAy6x9HDhBRhxjpHqICA7tJyrVDS12oKUNaHifjWAEipKuqZKOZb9ERToTccnQtEsaQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB6189.apcprd06.prod.outlook.com (2603:1096:400:335::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Wed, 4 Mar
 2026 03:31:12 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9654.020; Wed, 4 Mar 2026
 03:31:12 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIG5ldC1uZXh0IHY2IDMvNV0gbmV0OiBmdGdtYWMxMDA6IEFk?=
 =?big5?Q?d_RGMII_delay_support_for_AST2600?=
Thread-Topic: [PATCH net-next v6 3/5] net: ftgmac100: Add RGMII delay support
 for AST2600
Thread-Index: AQHcqi7FC/oppUWfPEmkr2x9UzsYpLWbhPKAgAIzpTA=
Date: Wed, 4 Mar 2026 03:31:11 +0000
Message-ID:
 <SEYPR06MB5134E02B840BA59CA81C21389D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-3-68319a4c4110@aspeedtech.com>
 <ae88d56a-04c9-4a50-af22-5e439acd59c7@lunn.ch>
In-Reply-To: <ae88d56a-04c9-4a50-af22-5e439acd59c7@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB6189:EE_
x-ms-office365-filtering-correlation-id: 39aa4852-ab29-45b2-183c-08de799e7bcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 766kQNlfOcj0snNAUZ0Tf4bxoDkV8qTjFRVxDX9u56373Du4A6OGqyHe0YGKcqW8GDLRHBlRtxWRMchrJkYPEQh1GGz3Y4wmMbYeHXwz10mojrtnYIE4VKTqyLGCNeM2tvpCk5Dc3KCuxAwNt5I3AGuZ5+033toZPBiRCt/fGZa0bXCeCHxRFmbc42LQ/mbvzwRSxYeUsC46+RvRQG0tp5zOb4jkzAMbGbX/zvxH26ipzm7YjgwmzTKflizn0D2YFrD3/CQqg+0bgSJMDHnl5thzzK4F0EManvio/a9MzeO2eINadjBavCwR3Jdt6BkvF0Jxc42+LWjLotcJzidvKYkO6tgXVNirz25FrklaPgNwKKH4XVrVJvvAPcVpVUwDAFJr98njiR/7qmtl4kJhtxLPgEoQVa+3iVt55tlEiUvhuqTn+Q1UW1B46riG8qJhpbcmCBcV73xcvKe14+L1d8oX37MFaTMC2Etz/WM2iPmwP38sHM3ksXpbWxO/ZjiZm6A0Q7/2vZfFfN9ojJSYBtrcuRpK4AaP2W/o8+yUPymEwTPkDRfKFRJh001cAVRkQBIsZ+OPL/tFeVJ9yTa1zT8JcPGRfxB8xRvJLGErb6IERp41w4uFTcp+KNokYh6ai5GDyg6UBboAo/VBJHgKuya149+aMqWfXCGXm3wXvUIYY6PxM34lkoqpgBvwcx0/yB+8hO+4dhYpc+yTD/0oOMcfeehf5RaJavr/6Vqq+Dot3zOLOyFwNExavaDCfWuU8VzV0z0wAK6252hxNdayR9CKm7rOUlK93rwFrL9Vc9E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?ZHJwWVM4NjdScTlPem9zcGQvTVhHUjlzL3V3dHd0eStGZWkwNThrUkU4d05qdU5F?=
 =?big5?B?YlpUMUw5K3VrZnFXaTRQV09nV1RadTY4aDlyMk85VFMvclJLN21NRCsvbmVJTTJL?=
 =?big5?B?VloxTGhLM2ZLZGZhai96QkY5YzNET1pGaW1jeHAveHA2REs4TmhHblROR3lIaldG?=
 =?big5?B?Y3FiSkREM3NSMjl1MFkrT3FWR2ppZGttZ0c3cHRIVm9aQTZLT0RlS1ViNDVSNGRK?=
 =?big5?B?OFpRTXJzb25nWkdwY0NnSmR3SGpjbmx3Ykd3czVLbllJWUdUVFJUZFN1TkdpbnBx?=
 =?big5?B?RUN1aU1WSVVKZjI4a0hoYVRoc0dYMi9BV0IxTlpoaE1kZHNpUUJjTVIwM200TmRN?=
 =?big5?B?akRRZ1g2MUxCVENEZTQwdnQxTWRaWXV1VkFCcE5oOWZRYU1Pazl4SFNFWER1YmE1?=
 =?big5?B?VkQyNEhkWllteXkrZHhPa1FsOEtjQ3dWa3JGb2R2cUJYazlsUUZZRzZMTTlzdy9x?=
 =?big5?B?RTlkdVlENC9ZWWpZV3ZBbXNSMklOQ3pZazB4dENUSUduS05DYS9OWFhSK2hhd08x?=
 =?big5?B?aWVHR2VjRXd0alN4Si9qZW5KRHlCMnpMd0RMdExDSFBNWDJCNHBSdVZNQzlqSmpo?=
 =?big5?B?WndYOGFNb2F1Uk5rZ3VkOFpIVXFIbWVESm93TDVqWEUxejRGaDQyZEx2d3JrUG5P?=
 =?big5?B?eWVGOEdiZmR5MFduZ2p6MyswZ01oMkpDQjFJeXFhWldqcDRpRmZ4bXNzNzlwalFQ?=
 =?big5?B?a3BiY3cwTVBmQ1N0SkNnZXBxN1NkbVowazRrVENjY1JaQ3NwN0FxWitIdEV6OSs4?=
 =?big5?B?UFVteHV5SEpYdXdzeXplRHZJcTd1Z2NpSnMvQjNnNEI5dExNbkRJTGhnSlFkZGor?=
 =?big5?B?UVRlQVNtbHIwblk4WHIvb1ZaZDNCaXpIQm5Ta09XYnErQk0rbWc1L0tZMXU2YzR6?=
 =?big5?B?b2paZnRleEYxOHRmNmhtUjFXL1E1Qm5yVkVya1VXTVl3cHVSby9XZm56Qmdwck5I?=
 =?big5?B?WVA4WWpYRWR5SC9kRENJVFEwdDB4N2VYSml1OWlMS00rUGJuY0hmbkkxT1FrWlJh?=
 =?big5?B?NVBGVmszWHF4SXR5NEtkN1Z4SGJWMGFKc2NQU1NOMDFJVkRIMGRJYmRyb0FnN2F6?=
 =?big5?B?VCtDTjhieVZGc3dNSlZxT1U5bCtKUlNGSE5JbERZWlRjUDhOKytqaUJBZm5IOXlV?=
 =?big5?B?U1d1TEVmTDFPK09xRFlQVjNwN1VWUzFHVlZrRGJFdDc4aDlhbW0vRk8wMVpEM0kz?=
 =?big5?B?L1didVFUaldHak9tN0ROV3F2STFXZ0hUMHB2QzVzZjh2ZGNEenFzWGlEZDRxOGtn?=
 =?big5?B?U2F5ZVZMQTYrTnZac2Vqczc1TVUxM0s1WCtBZmdqVmlXNmI2TFRtaGRXMk94V2Fr?=
 =?big5?B?eVhVUHkreFpNNnNLN1ArRy91NzVZdmRMdlJ0c2ZkN1A5VlFGeHJlSS9GbWZldFVu?=
 =?big5?B?MTBhVEorUktlU3RhY1gwbUxPOHNxbmlZcDkxaERwb2E5NlVHZDhKbEwrVGZaVWZC?=
 =?big5?B?QktHUit5cWhLMHErNVZTVy9sU3J5enZZa1B4WFJPdWJpUVdSQS8rRVhvbUFtaVpX?=
 =?big5?B?YUZiVWVPd3JMaENkZHl4Q1VUMi9Ba2VvVmlYc3k0Z2ZUV0hQZGNZVVd5M1UwZ01B?=
 =?big5?B?cHVMMFVjcU1YUzg5Y1Y0cmpDR2Jydkg1NkY1R0pnQlRYTVNRVHNwd0ZsblV0RGxO?=
 =?big5?B?TU5sSmwwQ3QyRlo0Q1R1MWJOVWJyM1U4SjRZRzBFU0p5Sk93Szl2aG1XMzZWRjg2?=
 =?big5?B?d2Rvc1VQM3lxV21lZ0JqTDRGaVlGemJWQWI2bThGdGNrMldjVzE2ay96SUZjNWxx?=
 =?big5?B?SEZ0TUxUejArMU1NZHZ6NlpuaXlXS2pBT21KMXh6MVBycFhoeWpTL0dGWXBNY0Nn?=
 =?big5?B?S2xrZTJ0TFdINlQ1S2Y0bFgxN0o4cjZHcDFNVXVnQnF3SHpEZ3RtN2RKczBuWW9N?=
 =?big5?B?U04yWFBXS3MwRFF1VjZUTHpRYTcwRVNYa3V4ME03bE9iOFlpbUhNU09NNTJjNGhY?=
 =?big5?B?a0I5THJ0Wmg0ZHh6ZnpZTUVBQlZ4Z2ZuOHUxazlGRjUrMFlpWmc5S05OeERwYVdH?=
 =?big5?B?VVJRQWJXend5M1hqSXZCUVo0WW5ONnN2N3BrSWN3d29lU3lPcStWVVpxZkJWSjlo?=
 =?big5?B?bjRqMXBFekZkdlJUbC85aDhaeHNrN0FReFBJNDh0RnZmN1Zzckd4dWpSSFFibXY4?=
 =?big5?B?U1pLam4rMWVucnFFVUMybHNzQXNkamRoS2lWd2tDbGxTWHYrazY5RmtOUk1TOEtn?=
 =?big5?B?TjY1WUVwdU5jTFpoVUgrZXN0WUlOdz09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39aa4852-ab29-45b2-183c-08de799e7bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 03:31:12.0923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKJIH0WJiP7Vos45fBQGg0occtdpL24HHHNh+xKHeKU/IZ9KNKXPKmuiGpdZWAICMT59pMruvYH0Yv+vA6tVPCiWGpudx6HF2/ZIDS8pOQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6189
X-Rspamd-Queue-Id: B7F7E1FA5C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[aspeedtech.com,quarantine];
	R_DKIM_ALLOW(-0.20)[aspeedtech.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263573-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[aspeedtech.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aspeedtech.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,SEYPR06MB5134.apcprd06.prod.outlook.com:mid]
X-Rspamd-Action: no action

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiBPbiB0aGUgQVNU
MjYwMCBwbGF0Zm9ybSwgdGhlIFJHTUlJIGRlbGF5IGlzIGNvbnRyb2xsZWQgdmlhIHRoZSBTQ1UN
Cj4gPiByZWdpc3RlcnMuIFRoZSBkZWxheSBjaGFpbiBjb25maWd1cmF0aW9uIGRpZmZlcnMgYmV0
d2VlbiBNQUMwLzEgYW5kDQo+ID4gTUFDMi8zLCBldmVuIHRob3VnaCBhbGwgZm91ciBNQUNzIHVz
ZSBhIDMyLXN0YWdlIGRlbGF5IGNoYWluLg0KPiA+ICstLS0tLS0rLS0tLS0tLS0tLSstLS0tLS0t
LS0tLSstLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0rDQo+ID4gfCAgICAgIHxEZWxheSBVbml0
fERlbGF5IFN0YWdlfFRYIEVkZ2UgU3RhZ2V8UlggRWRnZSBTdGFnZXwNCj4gPiArLS0tLS0tKy0t
LS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tKw0KPiA+IHxN
QUMwLzF8ICAgICA0NSBwc3wgICAgICAgIDMyIHwgICAgICAgICAgIDAgfCAgICAgICAgICAgMCB8
DQo+ID4gKy0tLS0tLSstLS0tLS0tLS0tKy0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0rLS0tLS0t
LS0tLS0tLSsNCj4gPiB8TUFDMi8zfCAgICAyNTAgcHN8ICAgICAgICAzMiB8ICAgICAgICAgICAw
IHwgICAgICAgICAgMjYgfA0KPiA+ICstLS0tLS0rLS0tLS0tLS0tLSstLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0rDQo+ID4gRm9yIE1BQzIvMywgdGhlICJubyBkZWxheSIg
Y29uZGl0aW9uIHN0YXJ0cyBmcm9tIHN0YWdlIDI2Lg0KPiA+IFNldHRpbmcgdGhlIFJYIGRlbGF5
IHN0YWdlIHRvIDI2IG1lYW5zIHRoYXQgbm8gYWRkaXRpb25hbCBSWCBkZWxheSBpcw0KPiA+IGFw
cGxpZWQuDQo+ID4gSGVyZSBsaXN0cyB0aGUgUlggZGVsYXkgc2V0dGluZyBvZiBNQUMyLzMgYmVs
b3cuDQo+ID4gMjYgLT4gMCAgIG5zLCAyNyAtPiAwLjI1IG5zLCAuLi4gLCAzMSAtPiAxLjI1IG5z
LA0KPiA+IDAgIC0+IDEuNSBucywgMSAgLT4gMS43NSBucywgLi4uICwgMjUgLT4gNy43NSBucw0K
PiA+DQo+ID4gVGhlcmVmb3JlLCB3ZSBjYWxjdWxhdGUgdGhlIGRlbGF5IHN0YWdlIGZyb20gdGhl
IHJ4LWludGVybmFsLWRlbGF5LXBzDQo+ID4gb2YgTUFDMi8zIHRvIGFkZCAyNi4gSWYgdGhlIHN0
YWdlIGlzIGVxdWVsIHRvIG9yIGJpZ2dlciB0aGFuIDMyLCB0aGUNCj4gPiBkZWxheSBzdGFnZSB3
aWxsIGJlIG1hc2sgMHgxZiB0byBnZXQgdGhlIGNvcnJlY3Qgc2V0dGluZy4NCj4gDQo+IFBsZWFz
ZSByZXR1cm4gLUVJTlZBTC4gQXNraW5nIGZvciBtb3JlIHRoYW4gNy43NW5zIGlzIGNsZWFybHkg
YnJva2VuLg0KDQouLi4NCgl0eF9kZWxheV9pbmRleCA9IERJVl9ST1VORF9DTE9TRVNUKHJnbWlp
X3R4X2RlbGF5LCByZ21paV9kZWxheV91bml0KTsNCglpZiAodHhfZGVsYXlfaW5kZXggPj0gMzIp
IHsNCgkJZGV2X2VycihkZXYsICJUaGUgJXUgcHMgb2YgVFggZGVsYXkgaXMgb3V0IG9mIHJhbmdl
XG4iLA0KCQkJcmdtaWlfdHhfZGVsYXkpOw0KCQlyZXR1cm4gLUVJTlZBTDsNCgl9DQoNCglyeF9k
ZWxheV9pbmRleCA9IERJVl9ST1VORF9DTE9TRVNUKHJnbWlpX3J4X2RlbGF5LCByZ21paV9kZWxh
eV91bml0KTsNCglpZiAocnhfZGVsYXlfaW5kZXggPj0gMzIpIHsNCgkJZGV2X2VycihkZXYsICJU
aGUgJXUgcHMgb2YgUlggZGVsYXkgaXMgb3V0IG9mIHJhbmdlXG4iLA0KCQkJcmdtaWlfcnhfZGVs
YXkpOw0KCQlyZXR1cm4gLUVJTlZBTDsNCgl9DQouLi4NCg0KVGhlc2UgY29kZXMgd2lsbCBjYWxj
dWxhdGUgdGhlIG5zIGRlbGF5IHRvIE1BQyBkZWxheSBpbmRleC4NCihyZ21paV9kZWxheV91bml0
IGlzIDI1MCBwcyBvbiBNQUMyLzMpDQpJZiBzZXQgdHggZGVsYXkgdG8gOCBucyBvbiBNQUMyIG9y
IE1BQzMsIGl0IHdpbGwgZ2V0IGluZGV4IGlzIDMyLg0KSXQgaXMgb3ZlciB0aGUgZGVsYXkgY29u
ZmlndXJhdGlvbiByYW5nZSwgaGVyZSB3aWxsIHJldHVybiAtRUlOVkFMLg0KDQpUaGFua3MsDQpK
YWNreQ0KDQo=

