Return-Path: <netdev+bounces-284252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNOTGFSn+WnF+gIAu9opvQ
	(envelope-from <netdev+bounces-284252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:16:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE71D4C87FC
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06C743024AB1
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171783ECBE3;
	Tue,  5 May 2026 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="aXIiDLvx"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F5A3E95A9
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968877; cv=fail; b=c8/CM+7MNotubDlY82z3i+Gk9uDVdNdARhqLmqMRm79ChkcX+qOuYcBc4tyRvYIxVX7f8ykmxjnpTyX6PWCqmUkYhpIwiKo06Qtd3WJ+hnWo6Mi63fkY6ss3RFPd+xGFJ5Rz+EGuHIy4QR3x6BxRjyP4o/M+Vk9m4mj75aaLNgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968877; c=relaxed/simple;
	bh=Cw3rN2gispdeF4C1+MpRbkcDI0WOsyyW2IHHUQccPqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S+4zQpc0jAf7DGPxbUcMCBTMcCic0OlFX4KwNbjwMOl1PkCIo7JdPBVzxpUucpF0HJkbb+ai6CMe8srU2HG47zPqVHWsxO4617+KG+Rh7XcFZcJWGVdo8XWlIOFh/Chz8tLHH3J95xsS32mNCari/1PLLssix68HkhJ1G/Jwac4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (2048-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=aXIiDLvx; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBnnC3DhtGfZKC2mwbB4qYkrIJMs6xFcOBq+V1c6me4Vi+bC2Av/sojs11RNZuUFTJBrltbeI+wlpH+18wTAkCaKxUdAIFl26W/poNeFqi7aClf/4oiivyAP9wuwZeCsUjJmOmken7tA3kqYH5Ot40NaGcdYRh29AVCF0vCybrYj0HnWJzAI6YdTr6u+vlHI7qPdO2Oz5Tw8vthv4aHPYBAP/2t5kkdhbAOsS40xBTB2bXz0+kwmNJPNv4ShuDn2ArKdWMGOcn+LDhYRMSpJEHuPnTdEcQbxhdD5bPET+mIyjOsGVPV0QJr6QiON7aCni+CQM0/5mNPAkZ8JRuvTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw3rN2gispdeF4C1+MpRbkcDI0WOsyyW2IHHUQccPqY=;
 b=GCoZw/NdOVrX/y+9K2IdWhoOxMpy4S98G6QwXILJweZvw4takr6LGGSLuA9GP4oWKVlXIhsSJ9eUlDMKr2ZSxZk/9xMuD718sfL4Aatlpz1gLc4UhZ/zG+a+6rClfxaU38K937/MCAw0gKQxoDpym4GMIKJqhnjL3I83jwNchj1xFivKyDifKawWWMj5nK3i4jT9gEkqwRcwTDZ5/qfdV1vUa29uevCvyqea4UHFvg9LDmNle0Ae/cUEKxdcXThhNvX1skQGtzXO1bNRXemRNveaUVaeedzd+H/JVPU4G7NP461gF5fn+Q0p9IFZV5VSxgmG+Sav3c6vsPzhBpFJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw3rN2gispdeF4C1+MpRbkcDI0WOsyyW2IHHUQccPqY=;
 b=aXIiDLvxD4sIINsSd3FdVL3ShQq2ite1zYqMs81it4CbHRJVtXq/hZTYTZj9/7EUH1mqLwTFQArlRlo0ShxyvTsd6cpfcaJlmQMu1ycUm8vWH0kgUu0u4Xi5fRr0GogbwnrdCMEKWODSFRF4q8HTyUnoATlm3H+W09zH2hk0YF0GGf36k/Mvhh+qyaM7/gmpkyr6UGkBRmV2+L3Pq5mRnhCKIrNWmOD4ijlVuM+qBlD5BgJbt8aTqmCm/K6gPdn0tq55EC7c41WyFG2+BLuoAYQWRVruAXqiS3yw2DD7tGzAAhtJ8TLG8Pa3PD00c7ePe48zKxMArCplw0a3oYKeLg==
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com (2603:10a6:20b:6fd::9)
 by AM8PR06MB7361.eurprd06.prod.outlook.com (2603:10a6:20b:367::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:14:32 +0000
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f]) by AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:14:31 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "qiang.zhao@nxp.com"
	<qiang.zhao@nxp.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net] net: wan: fsl_uhdlc_hdlc: fix dma_rmb usage in
 hdlc_rx_done
Thread-Topic: [PATCH net] net: wan: fsl_uhdlc_hdlc: fix dma_rmb usage in
 hdlc_rx_done
Thread-Index: AQHc2960xmhVPMAKekKnNexcW8lvMrX+6IyAgAAqBeA=
Date: Tue, 5 May 2026 08:14:31 +0000
Message-ID:
 <AM0PR06MB10396920527D0B69CC9D9BDFEF73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260504155642.2216040-1-holger.brunck@hitachienergy.com>
 <d6957853-9d24-4f35-8ea7-ef4376de991e@kernel.org>
In-Reply-To: <d6957853-9d24-4f35-8ea7-ef4376de991e@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB10396:EE_|AM8PR06MB7361:EE_
x-ms-office365-filtering-correlation-id: 8a0af3ed-483a-4dcf-f0bf-08deaa7e55fe
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 YHuSbEcX2/56iaARJyywZYTR+N2aT5bb3oNA1e12ssQ3kVe7HBgL9c2guBXdIiQxaLs+rG9Cq4mJ0k2doP8behpakSi9X+GjKzwrAbGdflPQ/5dxzSOSjyfjfpNRSu9APtic7abRR+p1EVTVNdMk6SAXc1Q2d2G+vBV5M0e0qpkWBzE8N96oZRtClDB1MDhboctKvFQqX1dMWeQETxpRD7reKtRqrRn3y8VUncyrFGpb0I+53d0JwbYZuhUD1u+OO09UHjSrc/iExCNA6fa7TkEYQFqiaBxu/TGbRCVm1asyrs/XCBR8hvPUVyp6JgBwej2D+4XS1n8V4t0UVsEKUefgKVyDhY7n5vH+bN9qdRLslt2Wf+6JeKf6xXGBC+pw2YcPB48pq34CbFdbuyAMENBTAIU6ql7jMuOlYF9qfVeTS4IHlZG11+gnsyZAke8mmijpPGPueR4GuFoPLkJgVUqDsHzfH0AqY8Rl87BC17ZvrHMhVzRmdo5u+pgwh3/YT3JuuPVYTXx0azs+PSt83UBIaPRs1FZp+CwREqs8m0ITVEoXE/bIwRm3Y4KfHBkBGnBdgOQ0x588FJDE6xNVW0XO+EsqI/dZTkQX0q1F4kiI8AVAO3CVErzF8cI62toQiBpI75L8Iceis1H6KPVDPVjRKIMm5SPMCgjnVc3U9TXGIyeFjWye+Rz7ejdEK8NwgBqSm2epiI1pjDD5O7el+zeBhKLTyEFFqEtQSENVIekzvS19EsRMxsl4EnOwV7JH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB10396.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZSt5K0IyTm5VMng3cjhiS0t5dDVmc1dNRHluc1NrWGt6SFhWYUJoV1RXM3ZI?=
 =?utf-8?B?dTc4dUlscWZNWkJGcVhYYy9pU0YzeDVwbFFMWFVJQ2xUTE9oTmpWRGc3M01I?=
 =?utf-8?B?SXE1bW10RnlpbWJQejQ1MkV4TGF6TnhMRVo3Q0tlNkJJVFdRZWVLMWpUc1hy?=
 =?utf-8?B?aHhZamlaclBmR2djS0hYYUc4ZXRNcC9ldS9mY2pyakJ2N3lHenpTS0thRTdk?=
 =?utf-8?B?SGlOU2RpZlZvb3BicS9zWm1RSGtUSnRYYWVCNWR3b0JIdXBGSXJjUnNwSHFK?=
 =?utf-8?B?c0JvbVV0ekh6ZDJZTVRLM3NwSVk4TFhIUUg1UC83c2xtZHBiMHV3MU1GVnZF?=
 =?utf-8?B?ZGhPbFlyRStwa0wzOVZhR3RDMDM3Y0NvdURuTFUrQmozNzJZSWwwUXkxS3Nz?=
 =?utf-8?B?RENYVVVaOHpGVlFxaldWZE45TE4vekxXTzJ1U2FWQWNTd211ckkvSDZjeUor?=
 =?utf-8?B?MzJhMHlOaGN2aU0zMno5MGN2UFNmTUh6eFpVOHB5ZWIyOGVQL2hlanFOcG81?=
 =?utf-8?B?eWJ2THFPSjVCSGtSc0pnekg2WXhlOGlOSnd1UFNtZmF3RkR3ZWN2cTFSeXJU?=
 =?utf-8?B?OTQ1TE1Ha2dic204WVBhSnNjMHowbDVmVTFUZDcxc2NsYXE5Yk5CcWlVeGpj?=
 =?utf-8?B?dUVvaldkbUdYUm0yakZwQW1WQUVkNk52cjZ1TjYyU3JaWElxSzVsZ2VqeHR5?=
 =?utf-8?B?RWN1OWovYXUxUGpNbVU4WUlnNnZudHNxQ0ZoQnJ5MTdVZHA1enZBNDBVaCt2?=
 =?utf-8?B?NjlJWTVsQ285YmQ0Mnp3YXlwd0ZpZUwwekR5YXhTMWRjYncvdXBwT1dVRFhY?=
 =?utf-8?B?b0dTU3hnM1ZDMnR2Uk14aFh4S0kyU2FMZ0M1TFdvclo4L2FoRHJxOTJ0clBK?=
 =?utf-8?B?V3BzRjU1M1NmRTNXekVDclBXbXJ3SlNPOVlHS3h1c0RDcjhrNSt6YS9PTzNO?=
 =?utf-8?B?QWt5Z2RySDJSKzBFbWs1bGxZMkxWeUlJSmNzV0xHRk56eS9zTWppa3pHNkw4?=
 =?utf-8?B?aWdTWm1aR1pnWnRObldhZ3RCbVBSS2V5QldrV3RaOU15NlRRTitkUlRiRlp5?=
 =?utf-8?B?d2dOS0pYeWo1SnF3LzdwK0lXMzQySHRQOWtiRUtrd0VqZlNSM01CM29IR2dC?=
 =?utf-8?B?OGFHMW5xaGNpbHdzOFRjTzdwUlVzUVF2RkUrRm5RVkFmK1FGWXJ3WHZKWXgx?=
 =?utf-8?B?MlNnUjhPL0xnTkVVWm9uR3phaStsSEFjNjFMeXdlZUExcGpSTWNDa3kxQ3RQ?=
 =?utf-8?B?NjRlc0xudmRtZk9CeERmSTFCMkNVeEhmSjFHVGZCTWE4NlpzWThXcU9MZ0tP?=
 =?utf-8?B?THRsMlRVblV2VXN0WXZCQ3Nxb2d0UkVidk9zME0rczk0ZkRsa2tqQzRDbEQx?=
 =?utf-8?B?N3k5aTFHTnZCNzBWeWZZSFhCVXNHcWRmRnR5ZzNheUpiMkZLTjdzd0hsNWIv?=
 =?utf-8?B?Yi83UHVpdFJWL1JrZGwvU1lNM2krbnQzNXRYcFkrRVR6cTZXd1VnditxM0d6?=
 =?utf-8?B?NHczSUZ1Y2wzcW5xMHBaRHBkaE1vcGN0N0NlQnYvTUF3aWpmQkkwMDNsbzlD?=
 =?utf-8?B?SEhPeTZ2d2Q0RXhLVlA0VHZIVmFXZ1J4cUhjWjVxLzVTSDFWREp4Zm40d0RN?=
 =?utf-8?B?R2F6QjlyK1I0ZnBzc3hmejB6MlRiRkFTTHZ1K3BUbkR5eTQwMGNhclJObXI2?=
 =?utf-8?B?SG5YZW9wQ1hpT0NCa2h5RU9FTWlPQmNqMk1lUDliWWFtaWRPQXFkTm1ZeWsw?=
 =?utf-8?B?aVZvcHFnMWpGYStmcjFIdTBheFZkM3dHY1lXWFlXZ0xZWU1uNEM4SzZPZmo4?=
 =?utf-8?B?TVR2dVF0S0JBckJPMHZKeFBsMkFWTEltZUhjaktDNjZ3OTYweTZQa0swUlhR?=
 =?utf-8?B?UENDL05xS2dOVDdPaHhGdGhyVUVBTzVGWFloMWtCbmdBdVp5bkNWUkpOSjlK?=
 =?utf-8?B?ZGVmUDhYTXYyN2lBM3RUVWJ2Ym9Hd2k2Zzc3dEF3SDlpRUZYZVk1QmZvZ3NC?=
 =?utf-8?B?VW10Z3JvOGEvMmkzN1laTjRMZm5QeXFvcW5pNG5mcy9Kd205eTBkZEw4Yy9x?=
 =?utf-8?B?NGJBN2xnYnJoQmllZHlNVnFHWlMyOHN2MGc1VzYrWlh5bjZsUFl3bEhMTDAz?=
 =?utf-8?B?OGUwVDQ5UVRqNTFXVTJSRENoVDZTT01NQ1JYNVduQnNkY2NIckEwazFsV1Ft?=
 =?utf-8?B?STFBNFhpZENwTmxGNSsyRDdtaHExQXFqcXNlcFQ5aktwTUZXOHhGbFJLd1hJ?=
 =?utf-8?B?d1h2QVAwc0lBMVhYTiswME5WTklMYU5LdmFqOEE1VGE3WmhOUmkrMm1EcVdn?=
 =?utf-8?B?bmoyNE1Vcjl4M1o0WktLQSt1ek1IMy84Zk16cjl5V2FtaFp6b3V2R1FlMWg3?=
 =?utf-8?Q?qPOcjutOL4gdWBzA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB10396.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0af3ed-483a-4dcf-f0bf-08deaa7e55fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 08:14:31.8091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OutrD3hbJ4+TfQETj8hzZ5e+Sl0q0r90MHq1X2m7NAYhSdhraxP8V33bcJoALlVEK6R0Gs+i22lAM/faqmJ5EWWzzLRRRCgyxSq1iA01WAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7361
X-Rspamd-Queue-Id: EE71D4C87FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hitachienergy.com,quarantine];
	R_DKIM_ALLOW(-0.20)[hitachienergy.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284252-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[holger.brunck@hitachienergy.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[hitachienergy.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]

PiANCj4gTGUgMDQvMDUvMjAyNiDDoCAxNzo1NiwgSG9sZ2VyIEJydW5jayBhIMOpY3JpdCA6DQo+
ID4gSWYgZG1hX3JtYiBpcyB1c2VkIGl0IGhhcyB0byBiZSBkb25lIGFmdGVyIHJlYWRpbmcgYmRf
c3RhdHVzIGFuZA0KPiA+IGNoZWNraW5nIGlmIFJfRV9TIGlzIHplcm8uIFRoZXJlZm9yZSB3ZSBu
ZWVkIHRvIG1vdmUgaXQgaW50byB0aGUgd2hpbGUgbG9vcC4NCj4gDQo+IENhbiB5b3UgZ2l2ZSBt
b3JlIGRldGFpbHMgPyBXaHkgZG9lcyBkbWFfcm1iKCkgaGFzIHRvIGJlIGRvbmUgYWZ0ZXIgcmVh
ZGluZw0KPiBiZF9zdGF0dXMgYW5kIGNoZWNraW5nIGlmIFJfRV9TIGlzIHplcm8gPw0KPiANCg0K
d2hlbiBSX0VfUyBpcyB6ZXJvIGluIHRoZSBzdGF0dXMgb2YgdGhlIGJ1ZmZlciBkZXNjcmlwdG9y
IGl0IG1lYW5zIHRoZSBidWZmZXIgaXMNCmZpbGxlZCB3aXRoIGRhdGEgZnJvbSB0aGUgZGV2aWNl
LiAgTm93IHRoZSBDUFUgb3ducyB0aGUgZGVzY3JpcHRvci4gTm93IHdlDQpzaG91bGQgZXhlY3V0
ZSB0aGUgZG1hX3JtYiB0byBiZSBzdXJlIHRoYXQgd2UgcmVhZCB0aGUgZGF0YSBjb3JyZWN0bHku
IA0KQW5kIHRoaXMgd2UgbmVlZCB0byByZWRvIGZvciBlYWNoIGJ1ZmZlciBkZXNjcmlwdG9yIHdo
aWNoIGlzIGZpbGxlZCB3aXRoIGRhdGEsDQp0aGF04oCZcyB3aHkgaXQgbXVzdCBiZSBkb25lIHdp
dGhpbiB0aGUgZm9yIGxvb3AgYW5kIG5vdCBiZWZvcmUgYW5kIGFmdGVyLg0KDQpUaGlzIGlzIGFs
c28gY29uc2lzdGVudCB3aXRoIHRoZSBleGFtcGxlIGluIERvY3VtZW50YXRpb24vbWVtb3J5LWJh
cnJpZXJzLnR4dA0KDQpCZXN0IHJlZ2FyZHMNCkhvbGdlcg0K

