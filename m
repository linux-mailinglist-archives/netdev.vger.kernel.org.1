Return-Path: <netdev+bounces-298445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AkUNGDh0K2qc9wMAu9opvQ
	(envelope-from <netdev+bounces-298445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:51:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD9C676544
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:51:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=WAnY6E70;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298445-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298445-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64BF6300FB37
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B55C37FF41;
	Fri, 12 Jun 2026 02:51:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F762E7BD9
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:51:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781232691; cv=fail; b=RSxce4gLq01wJ4z60AuP0v69kgPaxxrjQfOzkN4Nohs38+PN+X4gOPIHdlO2jURxappSPnhyij0W0qe8sV5vUxR7IEV7lyDPP+SzkaBvgfFSLXYzCGhvet701SbKKQtxrAF9kpYB3Zk3vfP1Cr8zmvswC9NFw2Bb5uKIaz5irE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781232691; c=relaxed/simple;
	bh=3Uhp7dIOg0zlmrzGH1lHKCiRl+8CPnYcBu7X3at4KVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A5f9EdI2ywDv6CtSiUJtKN1oS9lyiaPrRsgA9v9xaxqNQADoLx1Bo99HR8uclGraplEUG4bubk20a40goxbAhcjhRH3tWyzEzpXgBBQnqJryetotNUF1KETafww7lP88SbpSbChYmlxYgmN8jjqBzSBtofG/dkLm55jJbiH/Pzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WAnY6E70; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgtuzBA0EgsF3AJS9tPnR28q28a6YSVuS0g6HTgI2esb/iZG91ueRDb7FJeSxTiDRSWR4CwLHe7LIRgIWWMiooqqUDZDElQBM3etVliai2vnE2R+CcWvUc3nex0PeeoU+FO4YKYDXDwVv1nusv3/yFgD+qsA4b5GjCg74d7F/Rhh+V7rgVOElohbClBnhUlKH11w3ovUKcJQITnNDWFZj7q9tjzd5GL2SXW8PcyS148lfKMnaUVupdD0e+7y70i/qbxrMPGKh2RCdHdBD+1RmE3rDN3c6YZ0KXYdw1IkG3jCsMozBfWXqaXQogn4xAccCefqiE69gDFOsJHttGxb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Uhp7dIOg0zlmrzGH1lHKCiRl+8CPnYcBu7X3at4KVE=;
 b=qfr9LlKTUiVRwTHWWFYJbf7B3Zlbz5YioQw5O3nCX3+1kOS9STuBAlldm3tQcLNt8weJRurGwYtVeHAUmFxA8d9glqzL+Jf8dx+Sg8jqZ5cAuwx6VjhfWS/MQ4kUyEKshQt4Gi2HVD+2Ce2fz42sq6LZKKisizKIdVITYpU5OkM/7E+dwK35wPA/1Vshz/4OHeXxZDasjRMqRTVR5O3SsBbZ8WmJD/4X0xBpyjHB8Ym8Q3iRpHIakMqtp7P7oln1geBR7FbZ2EnLE9MH15HNfBOXW5I24JpLl+75AgmrVBY5TvNYlerCgYgMpHZUn7uwM+Yy1au/d6dj8i7vBHyEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Uhp7dIOg0zlmrzGH1lHKCiRl+8CPnYcBu7X3at4KVE=;
 b=WAnY6E70VCcMesdiLanokGbxK7PTlt/dzYI2JLZIl9y7pfS+a18BzlPkYFc1337Xb4M+mqkU+h9kHskRzoYwQdAVZTvhE5g/fOlLDSNE+r3rMc1cuiTAYbpXhCsM4nnkc1FeYXqmJieZIdBijU6/Z/pqTecwmGEHXTtnO+mpEOr6urnHE1xZI5wFXg5J2S3k752mFPbyXXCemvNQoKFMkit6rkWFcx0YHUeY4zZ5/XXsR1DToKSMrP7hUIjJoEy4t1BiZ+GSuY7/YTatphH2R33I4Vr9oJr07un+fRNKzG63O6tZPYtqh4UaGZ3KBxQoKQaURiHNKINTGqLjlujLag==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by DU0PR04MB9348.eurprd04.prod.outlook.com (2603:10a6:10:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 02:51:26 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 02:51:26 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 09/15] net: enetc: add MAC address filtering
 support for VFs of ENETC v4
Thread-Topic: [PATCH v2 net-next 09/15] net: enetc: add MAC address filtering
 support for VFs of ENETC v4
Thread-Index: AQHc+L4THLnFLIGUp0in9Y+EnX7b4bY5HS+AgAEeCQA=
Date: Fri, 12 Jun 2026 02:51:26 +0000
Message-ID:
 <DU2PR04MB86299E7933C0359C842DB5F588182@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260610091844.3423693-10-wei.fang@oss.nxp.com>
 <20260611094738.30AD21F00898@smtp.kernel.org>
In-Reply-To: <20260611094738.30AD21F00898@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|DU0PR04MB9348:EE_
x-ms-office365-filtering-correlation-id: c368a2d4-c195-4d96-3643-08dec82d7f28
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|19092799006|56012099006|4143699003|11063799006|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 HVf7ctkqJsqOZRuZg/zbRgjdN5AGirGA/DXfnFPcS5bIXpnJxIotB9xzd1ZK58+5EcTcCKbQl5vjGIze770Wn2kuypT2uBqpPtzUY5RIYBo2TnxsyaSz0jQWDeA8rKzjjAT7luIlc+i6X1+eh7MHoCrkYadsreiG1YLBKab4ocdwFUGHwF31Qq0FOROf23AxwSdZv6b2g5KxsrzXCUuebFufJOmSbtJokcxxzLcj+0zjX9qkruO1jk4SllKWNRUmDfe9PkbHPSqRynxiCRmV76YmSL4srG9SggRgKD0foTjBeF0m5iTZYLPxFinpn1pSm6338JS1ZIlk7i7exI9E3kv2C49cdMWOrcdYg1molj+m8dycPirVHn0b3mMdJz7x4JNbIRp5bT+zQpXDep2FEJD51wnTixImNACW4SVrtFdjW+pQWMeB6nqcHrDykKy/kY7f0AiY87EI4fIHMVoEiEioNHLpv4UTE3QbsO08/G3wgFWHpru5nTOu/XlkelbqSIkch967MMSJRo8viMaecotqZF7on0i+erPLaLBF9rc75zJiiSB1frJxpLz6BHcPaouo5jByB1x8oL4NrHPCkd+20hK8JnosBPYwZ2qgmt7i5SOc0/12aB8BV1F3AMp8oMgYdNuKa9fN9aobT1K5Uxf55wsIQPHWVCSn8ecNdbgoKRpZ6o2UR0DfMfc1f1T9eEpjc82kdl0tLuv3ogTxdffvaKa+GLCzTA+l5aqoUp/32Nf5ekwU9b2a8JzebUT2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(19092799006)(56012099006)(4143699003)(11063799006)(6133799003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTBHR2M5NkFqOFo3QW8wSno4UWpqMDY2QkdGaTBFU3hZdDF5T1RmRVhxL2J5?=
 =?utf-8?B?YmhzSWpEQWVSNEFuRmdOWUQ0L0RJMDVvYzd6a0prTHcwQXVuMXZFeWJTY1Mv?=
 =?utf-8?B?eWxWSjl2ditXMkx0dkJJS2h5RXk4Mkd5Y0FqOUdaRlRJaCttbGt6eFdZNHpS?=
 =?utf-8?B?OUpsbUlaSHkxYmNiT016MFhpQktEYURlNUhsYjM2cWVQWHIwOUU1K1QxRTls?=
 =?utf-8?B?c1p0WVgvNmY5bmN6d3NNNkN4TTJlRkwvUmxkTVdZWVB2WGNTQklyZ08wUVpZ?=
 =?utf-8?B?VWZYUTBaY3BzSEhWVWtFUkM3NHU4VGtFbXZQOVZwZ1VIQkN3S2RCTjJheVFv?=
 =?utf-8?B?Q2IzZmE5dlFxVEFDa3lPa0hUUEVub2ZSZlJHZ085M2VaTHMwSDRqVC9hSFpO?=
 =?utf-8?B?SWhFaG15TUxVZm51blRueDFPVTNzYUlBMVpPTU9FZE1wR2p1NllwWWFRR1c2?=
 =?utf-8?B?TkxURHJkVjNRa0w3SjNtNkRCYncyNzRjT3Vva0x2UGcxYkVualJraWd2dzRl?=
 =?utf-8?B?Wng5SldiMmoxcjloY1k3U1JkMnVJcFNRUi9wWEFuV3cxS2VoYmZXRmhITVdI?=
 =?utf-8?B?QUU0K3FGK2xuYndkY0Z5bGJmOS9vV25EbldiZzRWMlJFTThKbjM1NjQ0elpj?=
 =?utf-8?B?YW5DbTZ2cHVCRzQ5bTJoandYM2N6UHZkbFM3bVpQd2xkTXpNbmRPc3lXQ0Zr?=
 =?utf-8?B?bVBObTk5eU9BUjA0d2RlRjdLRUVaV1AxMDRrQml0TEFUQzlhR0pickxCbWdq?=
 =?utf-8?B?Mk5mM3JzeEFVMzlnK2tTcnducUNzZUM1QllCdWxPakhjVTJQSEhhQzBTc1FO?=
 =?utf-8?B?SWdmQTVXWGI4dVJnak5LMUZTVU1NSDI4YVNWWWZ3a1VOd2V5bVpoTDU0RVRi?=
 =?utf-8?B?UW9DWEhadGJLaWFyRjQ5dXF4bWNwQTRHK3RlVkRDNDlFSDFmak8rcWN6eTln?=
 =?utf-8?B?VUI0ejNVTlpzZDVJRElUd05Xek0ySlpOZis1UHRFV3pqZmcyOW9YUzVpSXRk?=
 =?utf-8?B?ZGR1Yk5NZmZISnBWT1BBUUJDV3NOajU2cVpCbUY0dnczQ3dBcmlRWmtESCtB?=
 =?utf-8?B?M2RMVDFTWGhUZ0hQZEdEbk10c1I5S2kzdTRGY3hzRDU1NVBUSGxOQ0ZIYVdm?=
 =?utf-8?B?bHAwUC95TG1MYkFBYSsxREtCVzdGeW1hR0N4d3p2NUg4SWVPcWI3NW1mQWhD?=
 =?utf-8?B?TytlSWMvQ0VnS0g4RGRuWHdlL3NjOVZheEJrbUhSOHl2azVwd3dLQlZkRWRw?=
 =?utf-8?B?bURQaFBBWDcwdjk3NmxPVy9iTlROQnd3Z0dSUzB4bSt6d0l5ZFBsNWNSSjly?=
 =?utf-8?B?bHdsbFpxaGVWUWs2MzZ1UktPNnpUTGJFOEF1dlZqR05HS1Q0L3QxMUdxeSsy?=
 =?utf-8?B?a2FDS0ZnVFd1T2ZabHZZMUo0V2cwSUVTSnl6aFplL3dpZDNpMkZOZU5nRlBI?=
 =?utf-8?B?M3VaSXM0YXVXK3AyYSsyemlIdWM2QWZkc2E4ZkhHWWM1eDh1ZTNYdFNIcUxv?=
 =?utf-8?B?RTVJc0tza0I1a2VVRGg4Z2gyMHdyeUV0cGJzSHNsdDhUaFR5YzcrM2d1djAv?=
 =?utf-8?B?SnhlTXhrNDhwbC85cENqaVlTM3BqZWliYis0bVJicVZhYzIrbzBPT3VYTU4y?=
 =?utf-8?B?Y0hnYUlaVXNxTGRTNE15eENGQ0Q1QjJVeXZOT0Q1R0s4MnJyTldqZDBrVzk5?=
 =?utf-8?B?QWlPSGFKeE8wcjVERGcxSmEvZ3NIYVFDQjF4SnA5aEJ5WktkbWVDbStrQ2pC?=
 =?utf-8?B?SjBGcU1MMVg5bDlYQ1pockVOWUZBa1YzM293UUF2eDBzOXJMT0x0amZId0FD?=
 =?utf-8?B?eUdnYm5wUDlING9qL3labElxSlhackNxeFhBN1pISldEdU5YaTJUUFJZb2h6?=
 =?utf-8?B?eXMvV003UFE4R2RwSVZSMmJpOGNOQTlzMnNQMEFBb0xoQ0VpUXUwUEpwbFFa?=
 =?utf-8?B?ZktoYThYNS9pTXp6MUlrZnBtY0xCU3ZSVVk3cVhmamw0aEJLdXJpUitpQ2dk?=
 =?utf-8?B?L1hhQlFLZ044eE9PQlJNZXo3a2lBTGJLTW1scVJjNTJFZXlUeCtLNHJFTTZx?=
 =?utf-8?B?dHNGU01hOFNlZjJGOE4reUNWQjFsbThoSlNUUW9SMW5IOHRkYVFsWUwyOTF5?=
 =?utf-8?B?eTJKRE0xTzRVSWo3a1dycTkzOXIvWWRac1VYT3lneDF4NmV6V25FZXljdEtj?=
 =?utf-8?B?T2NDVlFDaFJTV242bldSeFl3UFRlL2dOL2E0Q0ljbXgycEZDTWZyR1ZPTmh5?=
 =?utf-8?B?a242dVE0NnN0LzlXTDU5Y09JdWU3dzNZWFkvZXJ3bWpvNlVMeXNkNUdkMlYw?=
 =?utf-8?Q?0NC+JPEg3zkNPkpaEt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c368a2d4-c195-4d96-3643-08dec82d7f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 02:51:26.5115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5b3dy+WoEZPEfdkeFO7jo2NN0YUzxjddJV4WU+SvRYA2pVYGLru6ELK/hRf1zxhxuhqFsULQuTLdyl0IDFxPjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9348
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298445-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.nxp.com:from_mime,DU2PR04MB8629.eurprd04.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BD9C676544

PiA+IEBAIC0xMTEsNiArMTEzLDEzOSBAQCBzdGF0aWMgdTE2DQo+IGVuZXRjX21zZ19zZXRfdmZf
cHJpbWFyeV9tYWNfYWRkcihzdHJ1Y3QgZW5ldGNfcGYgKnBmLCBpbnQgdmZfaWQsDQo+IFsgLi4u
IF0NCj4gPiArc3RhdGljIHUxNiBlbmV0Y19tc2dfc2V0X3ZmX21hY19oYXNoX2ZpbHRlcihzdHJ1
Y3QgZW5ldGNfcGYgKnBmLCBpbnQgdmZfaWQsDQo+ID4gKwkJCQkJICAgIHZvaWQgKnZmX21zZykN
Cj4gPiArew0KPiBbIC4uLiBdDQo+ID4gKwlzd2l0Y2ggKHR5cGUpIHsNCj4gPiArCWNhc2UgRU5F
VENfTUFDX0ZJTFRFUl9UWVBFX1VDOg0KPiA+ICsJCWlmICghdHJ1c3RlZCkgew0KPiA+ICsJCQlw
Zl9tc2cgPSBFTkVUQ19QRl9NU0dfUEVSTV9ERU5ZOw0KPiA+ICsJCQlnb3RvIHZmX3N0YXRlX3Vu
bG9jazsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCXVjX2hhc2ggPSAodTY0KW1zZy0+aGFzaF90
YmxbMV0gPDwgMzIgfCBtc2ctPmhhc2hfdGJsWzBdOw0KPiA+ICsJCXBmLT5vcHMtPnNldF9zaV9t
YWNfaGFzaF9maWx0ZXIoaHcsIHNpX2lkLCBVQywgdWNfaGFzaCk7DQo+ID4gKwkJYnJlYWs7DQo+
ID4gKwljYXNlIEVORVRDX01BQ19GSUxURVJfVFlQRV9NQzoNCj4gPiArCQltY19oYXNoID0gKHU2
NCltc2ctPmhhc2hfdGJsWzNdIDw8IDMyIHwgbXNnLT5oYXNoX3RibFsyXTsNCj4gPiArCQlpZiAo
IXRydXN0ZWQgJiYgaHdlaWdodDY0KG1jX2hhc2gpID4gOCkgew0KPiANCj4gW1NldmVyaXR5OiBI
aWdoXQ0KPiBEb2VzIHRoaXMgcGF0aCBtaXNzIGEgbWVzc2FnZSBsZW5ndGggdmFsaWRhdGlvbj8N
Cj4gDQo+IElmIG1zZy0+aGRyLmxlbiA9PSAwLCB0aGUgYWxsb2NhdGVkIGJ1ZmZlciBzaXplIGlz
IDMyIGJ5dGVzICh2aWENCj4gRU5FVENfTVNHX1NJWkUoMCkpLiBUaGUgaGFzaF90YmwgYXJyYXkg
c3RhcnRzIGF0IG9mZnNldCAyMC4gUmVhZGluZw0KPiBtc2ctPmhhc2hfdGJsWzNdIGFjY2Vzc2Vz
IGJ5dGVzIDMyLTM1LCB3aGljaCBpcyBhbiBvdXQtb2YtYm91bmRzIGhlYXAgcmVhZA0KPiBwYXN0
IHRoZSAzMi1ieXRlIGFsbG9jYXRpb24uDQo+IA0KPiBUaGUgRU5FVENfTUFDX0ZJTFRFUl9UWVBF
X0FMTCBjYXNlIGV4cGxpY2l0bHkgY2hlY2tzICFtc2ctPmhkci5sZW4NCj4gYmVmb3JlIGFjY2Vz
c2luZyBoYXNoX3RibFszXS4gU2hvdWxkIHRoZSBFTkVUQ19NQUNfRklMVEVSX1RZUEVfTUMgY2Fz
ZQ0KPiBoYXZlIHRoZSBzYW1lIGNoZWNrIHRvIHByZXZlbnQgdW50cnVzdGVkIFZGcyBmcm9tIHRy
aWdnZXJpbmcgS0FTQU4gZmF1bHRzDQo+IG9yIGxlYWtpbmcgYWRqYWNlbnQgaGVhcCBtZW1vcnk/
DQoNClRoaXMgaXMgYSBidWcgaW50cm9kdWNlZCBkdXJpbmcgdGhlIHJlZmFjdG9yaW5nIG9mDQpl
bmV0Y19tc2dfc2V0X3ZmX21hY19oYXNoX2ZpbHRlcigpLiBJdCB3aWxsIGJlIGZpeGVkIGluIG5l
eHQgdmVyc2lvbi4NCg0K

