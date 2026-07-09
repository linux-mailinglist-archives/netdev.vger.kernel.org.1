Return-Path: <netdev+bounces-306282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GpZqDp+8T2oangIAu9opvQ
	(envelope-from <netdev+bounces-306282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:22:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E26F5732C86
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:22:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sap.com header.s=selector1 header.b=qqPCIbQJ;
	dmarc=pass (policy=reject) header.from=sap.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306282-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306282-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D541E304B911
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBF6315D53;
	Thu,  9 Jul 2026 14:46:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011068.outbound.protection.outlook.com [40.107.130.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79AE31E82A
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 14:46:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608413; cv=fail; b=USYIvSh1CeBBhnLawPkDjNGsH3x/WzIJVosPGPu3E1k2MZeWCcA0GSg5SK6o9xxUZ0RsPJv2bF7/vFDZxKbOjxHSxGuaNLUZcqp0yO/XkGe+kSdMQQCYp5jooiRRb5KQCUW3wGydiiQYFzcT7/qYCB3dJZALmYK0zP14b2E0zXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608413; c=relaxed/simple;
	bh=sPGplVBdP++R52IdNruKaIjEiznM10KXfVIsW5Kzy4M=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t6HDDEJ/DRjmymJO54HHORPSS8l0lwG/fwyPUApXoYXmZ4Rr3Ls3KvKD0FJvg1zLAeRTPnbRjYi0Ob+ABUFYC1aHJWfb+4HDVQpOBYZEzKlVaawgZhxNGUPZX81C7GMjQvR1EL5sbKIobS2QZa7BxfuA5EMNkS0I+ys8n6ZFPXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com; spf=pass smtp.mailfrom=sap.com; dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b=qqPCIbQJ; arc=fail smtp.client-ip=40.107.130.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrQ+s+Su+693xLCWk/swZzn0QwkW5EasDq7r2FsMpaECIuAOy8/cif8GbdKGDJpKj/tkNGhRfy92wODUMmXrDztePm5Gv87Kl27/ItfjLK4iaijAqKTS0UHI+nFutPGjYlp+/4WRQtSAG9GGpRGZIkAGyoO5yaVlB2R5gWFt5CpQ5t3j9xhtwhht7otK3NWm71llm3QBTe9UXSA+/xLb0L++NX9F13ZgJBInbp3TrBKhEreh3TveFohfEOr3YVZ6k9Q4r89vNB7Px1mMmpqJRuXoJW074Ii0QSqRm16TSJRwz1+qfmh5c0vM8rXQbVSLCuePfnfwzXhy9CNVaKsNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPGplVBdP++R52IdNruKaIjEiznM10KXfVIsW5Kzy4M=;
 b=MwniNnQ4GJX3r9WnKv6Pag/TC/LF1Hz7CG5V5DTBj7xoGqD9A1S721io7P+sNFqrW6HEoPolXKbzNwePt0UfdZsjDqH+uCpQnYu5F4mUVlKfUmHvL8z4WkmTxxP/CPXsxOcdMQCML50FVRCFl1AWosBW+cAoaFWyydWgdc2GcOYAiiH38JILucGLaIgw8dAj/p14y/LagG6M2wyI1aEBiUZSPcVPCoFHlhApA6KmCMoxR9E83kxC8geavCSwFCnSOt/75+LHkOuuU9OAKGmyEWaZpL3V7Ji2za9Jrk2nkNy5gkCaplcEqQXwKvOQ6ccXRBEH0w3T56aI/D0K5O5WXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPGplVBdP++R52IdNruKaIjEiznM10KXfVIsW5Kzy4M=;
 b=qqPCIbQJkRtHWukNDa7ZCq8AgxS6L/ScFgJ3CmlPcNlWu2dMAtDsuz+6kOqejG1QSrTn6xg7d0noQXgSXL5GWW0DVstaauDBipKgOpynF+kpW4mZjDZTXzk+lDESSq1taSX9qHN62KfgOGRgMUZD9r7ITcPWY5STU1YlJroXiRWr7mMQPccWEME4DtjuxWAgGXnJ4WdFaWfbdJuKaoVf6BA2uuIY+3gGMIuBl2LC45OEBHEN7362vfCIAUdq+YjoJljLQqR6CLGluKwdVRgqfBijQCiAQScsvum2Xt1SuxJfYzyRL5IYUWX0chWwO0ilFqZYcnK+ZtwSBXaQ7XZ0og==
Received: from AS2PR02MB9582.eurprd02.prod.outlook.com (2603:10a6:20b:599::21)
 by AS1PR02MB7893.eurprd02.prod.outlook.com (2603:10a6:20b:4a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 14:46:47 +0000
Received: from AS2PR02MB9582.eurprd02.prod.outlook.com
 ([fe80::f8a8:54a4:e828:9cd8]) by AS2PR02MB9582.eurprd02.prod.outlook.com
 ([fe80::f8a8:54a4:e828:9cd8%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 14:46:47 +0000
From: "Froehlich, Dominik" <dominik.froehlich@sap.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Questions about resilient next-hop groups (6.18.35)
Thread-Topic: Questions about resilient next-hop groups (6.18.35)
Thread-Index: AQHdD7CfbbP0WA5b3UOcjBTXQ/Bxlg==
Date: Thu, 9 Jul 2026 14:46:47 +0000
Message-ID:
 <AS2PR02MB95821AC8417044B6529728DAE2FE2@AS2PR02MB9582.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR02MB9582:EE_|AS1PR02MB7893:EE_
x-ms-office365-filtering-correlation-id: 7a209766-16fc-4f7b-7651-08deddc8e6f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|10070799003|366016|18002099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info:
 bEd7jFpJb71Iii53Tr+Vs5tPgZakgXa5oenHFO+709ubH1DC36tCKP7eG2cqK8hoXjs7PgnZuz2AceUcvsIEajNEG352eF8hmGkwS81HCzkppIZkn3TNwmfgKOToVnhxkxxGruLbm0//bTCRm/DiW9aD6GNvZZ3Ck/ud3USg9iAt1Oth09MwgSgCv/TMlSSxkKN4VCiO/SzPE0q2z5/gdpnAlegwM3ZZk7lfy6b2msfBI13ROMYB6XkuD+iH+2UbmaW85JtHeStJUy2cp9RnnDPVcs0oi8wPACYX3mT0IF8YmWczff7WMMw/dvnVnSHPyAreZB9o6ZzSVL51AfCqZunwn1VZAdgZwe93Tg+E59wbmd4+0mAO6aEfjIt/znfn2mBGAJ2OWOAZFA8X+2SY1SOf8wDQ1+LNOjJXrwKP5VSHCRIBVI9Ff7QxJNoZrck33YXTdTS88iEwOz1ck5zbxkiQYtsAp+ERm2tF/rC5gjEn9c1puojloWMcyLspkxLuiN90Q4bcpPMugSxEGsaRffZGE2Q/gyZMP4CZbt5+4WXUrhEm+nLrRNCqW1+3yFQxOHMf18RsaHKsfWGjFySMSWNL3n/Y9UskmmxpEy3yBz/FgN/UCW3ZRyPDD4s4KrnWavDIj0BZ7jgVXALQF48v8oZZFrbqgyUXeMRwXDWH9whOgcCiZLHIAKmVueFf2dcxTRpCG9i+YQou1VUdEdrQY/EIj1HTw/PDoRmH/8JxXvs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR02MB9582.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(10070799003)(366016)(18002099003)(38070700021)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFR2NlU3YzZSZzhwYzFYdG1aUEEyVUlpTlB3alVZQTF2b294STFXcjh1TWhR?=
 =?utf-8?B?U0tvbjBiblJNSURWYTE3Vm10cUVDOW4yajhhaVljWmxsMkNhZ25GcDVuUnRJ?=
 =?utf-8?B?cVZKbkdOSVdNc3FySGxQYTdqVmRyWmVKQmlubHY5akRZSFB1ZTQ1ZzY3eTVs?=
 =?utf-8?B?TGlTc3h0bkpnMTRqWktPNElITzJVQUNhK1k1VnBBdjRMNE56bGh3eVU4WFVO?=
 =?utf-8?B?cHJ1eU91Ym5JSjZpc1dqVExUMVFETnN4YTFQM1F0aFIvTysrTVJNZVNlTC9S?=
 =?utf-8?B?dGZOZDVMTEhONFZwUW4rU2pnWEdkb3hYZGJjQTRRVG1GaHVqZFRmOGI5bEw2?=
 =?utf-8?B?WFpZekNzNTZDb2h3UGNlM0dib1NTYlRjSlIraDl1ajF5R0JCVzVoZCtHYVJp?=
 =?utf-8?B?UDc3eTJKTkVtTXhpRXF0ZVRTYU1IR0RteXE0M0xsWi9SWnJrN3JlOUZvdlFh?=
 =?utf-8?B?bmFncGxnMUZxRVhYd2VVY3VXeDJCdVhLR25IM2JJVnRkc2hCRnNLalNWNEtO?=
 =?utf-8?B?RnRZYThEdlFqQm1hRVRsQjJobVc2ZUIvSVRYUmRHKzZWTmRRYStFRDI5czFn?=
 =?utf-8?B?ZTF1UDVNZkljOXIyWHpEellHOHpiVGtveTcwanJiUGFPdFYyR1FXQUlDektZ?=
 =?utf-8?B?Ylgzbk5wU3A2RDdWVFlaVU9wYXN1dHdETXNmMDJQQTRuS0RobVpGUjVDand4?=
 =?utf-8?B?ZWJQSVJqcTdzWVUxUU92aEhhT3lPSGNoSHp3eEh0Y25TT2hVNG9LMGJGcWRo?=
 =?utf-8?B?YktBaTU3bnhMZmFFbTJGOWtxd2JCUmxLYVd5TlJONDltT3hCVUczeTdvZDli?=
 =?utf-8?B?eG84VllDZGp6UnRaMUNabndYZUN6UVdtSkVTdlRtalhPbG1MMXlhMllKNUxk?=
 =?utf-8?B?S2tKL1hseTVlVHEvWVQzaElZS09taklDUTR2aXRUbVJHL011NUR6dHk2WUp6?=
 =?utf-8?B?TXJ2cCtoUW5rdy83OGVPVk1VSUhib2hRTUwzRHFnNWdXc1dEa0lnN3dKaUtq?=
 =?utf-8?B?NUptSXdRcHZLMERKUG9ZNVZBVFNxMThXRm1OKzhlM1VGT0MrdVNPam0ybUFk?=
 =?utf-8?B?S2JMUlNYSmlVS0JxbU1rZjdsZWc2c1htaXErRFZtM3ZWQUVEeEt2RFRuamZr?=
 =?utf-8?B?MS8ybnBVMHRSMTB4WnlmQlJFWDZ0OUJxMEV5aXpmMWNhRXBPVWRtL1BlM2xm?=
 =?utf-8?B?WXRnYTVYN3I5dXhCUUhlcitheDFqZE1QaUV0Vk1aWmxST2dybWdrejN4WHVl?=
 =?utf-8?B?MUhjQnRVeG5CQVJRUmo3STI2QnlmcEE2UHFHTVlFYnZnTVgzc1p1TE43ckFq?=
 =?utf-8?B?ZzRpM21mQ01KdWN5WFFnN1NpTHY4NXhmalhMcjd0U0p4MjQ0b3l6aU9paHJq?=
 =?utf-8?B?cTBqTFNLNlIyay9sb21sMk9pVlFaeWJmcXB2aDVPNTdOTGgvY0Z6OFlSOXBH?=
 =?utf-8?B?TTg1RlEwakt2aldwWjRkMjVGSTBNZkxqNFVQSkVkNyswQ0FNbXV1NXhWbSt3?=
 =?utf-8?B?aWorTk1vK2RCM3NMelg2Y3N3akRhYXpHcFA4bVBlT1hWbUVlUDFqVSthbGNZ?=
 =?utf-8?B?djZRd0NWOXZQNjNvUkNuMThtK1p5aCt0WlJGYUgzZE9NQ3JnRXZuWWpTUmFi?=
 =?utf-8?B?bWxOUTdPTTBWRnBWb1hUWWlWU3VMZVBzNFFUZEt2bTJ6RUwwR0tSeG9Ibmpk?=
 =?utf-8?B?TGk4b2tvK0p2WlFUZjdwTzM2ZTFTUVdPYWFNbTF0NW9ndU8zd2xYbGVMajA4?=
 =?utf-8?B?WVNENFFyZXhxTHZxeUdMYUdaL3lwdnVtV3BJTGNqU2ROZzVtdGNIL2ZWZ0Zr?=
 =?utf-8?B?Z29YMFZXcVlpbFNlOHdsZm1UQjVyei8vcTdsZFVETjdBeUNqNUtmdm1wUHpL?=
 =?utf-8?B?NkJXSVVOaFZuWUVrdW44ZkRZNHFmSk11NVUvNmhtKzFpSUNGTEt3dmFJdFd0?=
 =?utf-8?B?WFhsNHhxQkRLZzc2aVFDRDBXTmd6MER3MDgxVmFNcmdWeFlZYzBTUVorQjZo?=
 =?utf-8?B?S2dyQVFBeUQrNjNOTmR4Q2IrZ2pVRjhFRTdlVWhEOUdTYWF5MEE5R3VmUjJp?=
 =?utf-8?B?R3RFcmU5U0habFlUNFBmbzVnVmhHbE9zdkt0dUNTb0lyZVJuY1NZYVNBOXJQ?=
 =?utf-8?B?QWtRNmdyOWY3cFA1SktWYjRiWWlDQzlneTVyaUhzaEU5V21OaEpPR2hNK0dJ?=
 =?utf-8?B?UldFOTFyOFlHNVNvcWovOFpwYm50Y0NGUlZlbUlRdlJxS1pzMzBmTUhoTU04?=
 =?utf-8?B?Q1VGSXlNK0lJdDViamhkMUdwd1RNMGF3Yk5UMWtybzRVKzJMNnJoTS9FZnFl?=
 =?utf-8?B?Y010UkxPU3Jsa3p4TGtSYnZEUTFxMSsxV2dubElrRnpya2xPL0owSUVEOGVE?=
 =?utf-8?Q?/Xpg4jKdm7U1xSQGRo9xjHhQHeF+BBwrp4P0lZOrjVQYL?=
x-ms-exchange-antispam-messagedata-1: hkey2fQ0aCT/Cw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR02MB9582.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a209766-16fc-4f7b-7651-08deddc8e6f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 14:46:47.0531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHd9rwPODCszGCmTgdhAKDXgvB7gJuqVcwgJOzfx8FLvo/DFGynY2qICPyeNINTQhA1Yx8wdSTqh7kbRuLjiHbljJZAZ+2cPTFg/Ti0MygM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB7893
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[sap.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sap.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306282-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dominik.froehlich@sap.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dominik.froehlich@sap.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[sap.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sap.com:from_mime,sap.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E26F5732C86

SGVsbG8gZXZlcnlvbmUsCgpJIGFtIHJ1bm5pbmcga2VybmVsIDYuMTguMzUgYW5kIEkgaGF2ZSB0
aGUgZm9sbG93aW5nIG11bHRpIHBhdGggcm91dGUgc2V0dXA6CgoKMTAuMTgxLjAuMC8xNiBuaGlk
IDQwMArigILigILigILigILigILigIJuZXh0aG9wIGRldiBib25kMC1pcDZ0bmwwIHdlaWdodCAx
CuKAguKAguKAguKAguKAguKAgm5leHRob3AgZGV2IGJvbmQwLWlwNnRubDEgd2VpZ2h0IDEKMTAw
LjgwLjAuMC8xMiBuaGlkIDQwMArigILigILigILigILigILigIJuZXh0aG9wIGRldiBib25kMC1p
cDZ0bmwwIHdlaWdodCAxCuKAguKAguKAguKAguKAguKAgm5leHRob3AgZGV2IGJvbmQwLWlwNnRu
bDEgd2VpZ2h0IDEKMTAwLjExMi4wLjAvMTMgbmhpZCA0MDAK4oCC4oCC4oCC4oCC4oCC4oCCbmV4
dGhvcCBkZXYgYm9uZDAtaXA2dG5sMCB3ZWlnaHQgMQrigILigILigILigILigILigIJuZXh0aG9w
IGRldiBib25kMC1pcDZ0bmwxIHdlaWdodCAxCgoKVGhlIGxpbmtzIGFyZSBpcDZ0bmwgZGV2aWNl
cyBzZW5kaW5nIHRyYWZmaWMgb3ZlciBhbiBJUHY2IHR1bm5lbCB0byB0aGUgb3RoZXIgZW5kLgoK
SSBhbSB1c2luZyBMNCBFQ01QIGhhc2ggcG9saWN5OgoKfiAjIHN5c2N0bCBuZXQuaXB2NC5maWJf
bXVsdGlwYXRoX2hhc2hfcG9saWN5Cm5ldC5pcHY0LmZpYl9tdWx0aXBhdGhfaGFzaF9wb2xpY3kg
PSAxCn4gIyBzeXNjdGwgbmV0LmlwdjYuZmliX211bHRpcGF0aF9oYXNoX3BvbGljeQpuZXQuaXB2
Ni5maWJfbXVsdGlwYXRoX2hhc2hfcG9saWN5ID0gMQoKSGVyZSBhcmUgdGhlIG5leHQgaG9wIGRl
ZmluaXRpb25zOgoKaWQgNDAwIGdyb3VwIDQwMDAsMTI4LzQwMDEsMTI4IHR5cGUgcmVzaWxpZW50
IGJ1Y2tldHMgMTAyNCBpZGxlX3RpbWVyIDYwIHVuYmFsYW5jZWRfdGltZXIgMCB1bmJhbGFuY2Vk
X3RpbWUgMAppZCA0MDAwIGRldiBib25kMC1pcDZ0bmwwIHNjb3BlIGhvc3QKaWQgNDAwMSBkZXYg
Ym9uZDAtaXA2dG5sMSBzY29wZSBob3N0CgoKU28gSSBoYXZlIHR3byBlcXVhbCB3ZWlnaHRlZCBu
ZXh0IGhvcHMgd2l0aCA1MTIgYnVja2V0cyBlYWNoLgoKTm93IEkgYW0gcnVubmluZyBhIFRDUCBj
b25uZWN0aW9uIGluIGEgc2hlbGwgb24gYSBob3N0IGluIHRoZSAxMC4xODEuMC4wLzE2IG5ldHdv
cmsgb3ZlciBvbmUgb2YgdGhlIG5leHQgaG9wcyB0aGF0IGNvbnRpbnVvdXNseSBwcm9kdWNlcyB0
cmFmZmljIHRvIGtlZXAgaXRzIGJ1Y2tldCBidXN5OgoKd2hpbGUgdHJ1ZTsgZG8gCiAgc2xlZXAg
MC4xCiAgZGF0ZQpkb25lIAoKClRodSBKdWwgIDkgMTM6Mjc6MDMgVVRDIDIwMjYKVGh1IEp1bCAg
OSAxMzoyNzowMyBVVEMgMjAyNgpUaHUgSnVsICA5IDEzOjI3OjAzIFVUQyAyMDI2ClRodSBKdWwg
IDkgMTM6Mjc6MDQgVVRDIDIwMjYKKOKApikKClRoaXMgcm91Z2hseSBzZW5kcyAxMCBwa3RzL3Mu
Ck5vdyBJIHdhbnQgdG8gZHJhaW4gbmV4dCBob3AgNDAwMCB3aGljaCBpcyB3aGVyZSBteSB0cmFm
ZmljIGlzIGZsb3dpbmc6CgoKaXAgbmV4dGhvcCByZXBsYWNlIGlkIDQwMCBncm91cCA0MDAwLDEv
NDAwMSwyNTUgdHlwZSByZXNpbGllbnQgYnVja2V0cyAxMDI0IGlkbGVfdGltZXIgNjAgdW5iYWxh
bmNlZF90aW1lciAwCgpBc3NpZ25pbmcgaXQgYSB3ZWlnaHQgb2YgMSBzaG91bGQgcmVkdWNlIHRo
ZSBudW1iZXIgb2YgYnVja2V0cyBhc3NpZ25lZCB0byBuZXh0IGhvcCA0MDAwIHRvIDQgYW5kIG1v
dmUgaWRsZSBidWNrZXRzIHRvIG5leHQgaG9wIDQwMDEuCgpIb3dldmVyLCB3aGF0IEkgYW0gc2Vl
aW5nIGlzIHRoYXQgdGhlIGNvbm5lY3Rpb24gaXMgaW1tZWRpYXRlbHkgdGVybWluYXRlZC4KCgpX
aGVuIEkgYW0gY2hhbmdpbmcgdGhlIHdlaWdodHMgbW9yZSBzbG93bHkgaXQga2luZCBvZiB3b3Jr
czoKCn4gIyBpcCBuZXh0aG9wIHJlcGxhY2UgaWQgNDAwIGdyb3VwIDQwMDAsMTI4LzQwMDEsMTI4
IHR5cGUgcmVzaWxpZW50IGlkbGVfdGltZXIgNjAgdW5iYWxhbmNlZF90aW1lciAwCn4gIyBpcCBu
ZXh0aG9wIHJlcGxhY2UgaWQgNDAwIGdyb3VwIDQwMDAsNjQvNDAwMSwxOTIgdHlwZSByZXNpbGll
bnQgaWRsZV90aW1lciA2MCB1bmJhbGFuY2VkX3RpbWVyIDAKfiAjIGlwIG5leHRob3AgcmVwbGFj
ZSBpZCA0MDAgZ3JvdXAgNDAwMCw1LzQwMDEsMjUwIHR5cGUgcmVzaWxpZW50IGlkbGVfdGltZXIg
NjAgdW5iYWxhbmNlZF90aW1lciAwCn4gIyBpcCBuZXh0aG9wIHJlcGxhY2UgaWQgNDAwIGdyb3Vw
IDQwMDAsMS80MDAxLDI1NSB0eXBlIHJlc2lsaWVudCBpZGxlX3RpbWVyIDYwIHVuYmFsYW5jZWRf
dGltZXIgMAoKSSBjYW4gdGhlbiBzZWUgdGhlIGJ1Y2tldHMgcmVkdWNlZCB0byBqdXN0IDQgb3Zl
ciB0aW1lIGFzIGV4cGVjdGVkOgoKRXZlcnkgMS4wczogaXAgbmV4dGhvcCBidWNrZXQgbGlzdCBu
aGlkIDQwMDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMjAyNi0wNy0wOSAxMzo0NDoyMgoKaWQgNDAwIGluZGV4IDQ0
NyBpZGxlX3RpbWUgMTM1LjUxIG5oaWQgNDAwMAppZCA0MDAgaW5kZXggNjMxIGlkbGVfdGltZSAx
MTcuNTYgbmhpZCA0MDAwCmlkIDQwMCBpbmRleCA3MjAgaWRsZV90aW1lIDczLjExIG5oaWQgNDAw
MAppZCA0MDAgaW5kZXggNzQyIGlkbGVfdGltZSAxMzYuMTkgbmhpZCA0MDAwCgoKTXkgZ3Vlc3Mg
aXMgdGhhdCBteSBjb25uZWN0aW9uIGlzIGluIGJ1Y2tldCBpbmRleCA3MjAgYXMgaXQgaGFzIHRo
ZSBsb3dlc3QgaWRsZV90aW1lIHJlcG9ydGVkLiAKCk15IHF1ZXN0aW9uczoKLSBXaHkgaXMgdGhl
IGlkbGVfdGltZSByZXBvcnRlZCBzbyBoaWdoPyBUaGVyZSBzaG91bGQgYmUgcGFja2V0cyBmbG93
aW5nIHRocm91Z2ggdGhhdCBidWNrZXQgZXZlcnkgMC4xIHNlY29uZHMsIHNvIEkgd2FzIGV4cGVj
dGluZyB0aGUgaWRsZV90aW1lIHRvIGJlIG5lYXIgemVyby4KLSBXaHkgZG9lcyBteSBjb25uZWN0
aW9uIGdldCBjdXQgaW1tZWRpYXRlbHkgd2hlbiBkcmFpbmluZyByYXBpZGx5IGJ1dCBraW5kIG9m
IHN0YXlzIGFsaXZlIHdoZW4gY2hhbmdpbmcgd2VpZ2h0cyBtb3JlIHNsb3dseT8gU2hvdWxkbid0
IGl0IGJlIGEgYnVzeSAodW5kcmFpbmFibGUpIGJ1Y2tldCBlaXRoZXIgd2F5PwpCdWNrZXQgbnIg
NzIwIGFscmVhZHkgaGFzIGlkbGVfdGltZSBoaWdoZXIgdGhhbiA2MCBzbyBJIHRoaW5rIGl0IHdv
dWxkIGJlIG1pZ3JhdGVkIG9uIGFueSBmdXJ0aGVyIHdlaWdodCBjaGFuZ2VzIC0gd2hpY2ggd291
bGQgZGlzcnVwdCB0aGUgZXhpc3RpbmcgY29ubmVjdGlvbiBhZ2Fpbi4KLSBXaGVuIC8gaG93IGlz
IHRoZSBpZGxlX3RpbWUgb2YgYSBidWNrZXQgdXBkYXRlZD8gVGhlIGRvY3MgbWVudGlvbiB0aGF0
IOKAnEV2ZXJ5IHRpbWUgYSBwYWNrZXQgaXMgZm9yd2FyZGVkIHRocm91Z2ggYSBidWNrZXQsIHRo
aXMgdGltZXIgaXMgdXBkYXRlZCB0byBjdXJyZW50IGppZmZpZXMgdmFsdWUu4oCdIEkgZm91bmQg
dGhhdCB0aGUgYnVja2V0IGlkbGVfdGltZSBpcyByZWZyZXNoZWQgbW9yZSBmcmVxdWVudGx5IHdo
ZW4gZmV2ZXIgYnVja2V0cyBhcmUgdXNlZC4gQnV0IHdoeSBkb2VzIHRoZSBudW1iZXIgb2YgYnVj
a2V0cyBldmVuIG1hdHRlciBoZXJlPyBGZXdlciBidWNrZXRzIG1lYW4gbW9yZSBmbG93cyBwZXIg
YnVja2V0LCBJIGdldCB0aGF0LiBCdXQgaWYgdGhlcmUgaXMgYXQgbGVhc3Qgb25lIGJ1c3kgY29u
bmVjdGlvbiBpbiBhIGJ1Y2tldCwgc2hvdWxkbid0IHRoYXQgYmUgZW5vdWdoIHRvIGZsYWcgaXQg
YnVzeT8KCgoKQmVzdCByZWdhcmRzLApEb20=

