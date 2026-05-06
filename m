Return-Path: <netdev+bounces-284662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGQVBVui+mk1QwMAu9opvQ
	(envelope-from <netdev+bounces-284662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:07:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEEB4D58F6
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95B01308D9A6
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 02:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34712282F01;
	Wed,  6 May 2026 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="AOjVBfVT"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF22459DC;
	Wed,  6 May 2026 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032835; cv=fail; b=nrhwftrJ3f53ntGy1V8vIWxNcE929tuCK45PV64M5LdHwykDhwMe6SFPTxDkDBhgNrvp39d8xr0lpdApuokkLX2nlgSu3xdixz5wuueULNq4UGc1Ii72Z5xq4mxPlnI2NI9WQUgzS4yQ2nmEsAyczepcFOmJbee7b3u36sFISzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032835; c=relaxed/simple;
	bh=NQ7ebH7TplpX6sFaRL/Tofmg4r0h8OC59GERz1fTrNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s0hW51/IZsx3gj+9SWzlkrvHjvJAbDh3AZvtmOkHZu7NjOcSMRrV5ZN+8nZ2YrPbea1qrKu5Rnl7H7sqtusUUCQHdE459+UNs2JMOh0BdH8qwi+anIaI9A1JAqgE0guXnSzKOi2toP6JacWtJjt3o5UGwlIwCEMnQV1ctgfyzEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=AOjVBfVT; arc=fail smtp.client-ip=40.93.195.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVwG1w7HNBW8dppoKYyDJ3ukrIBz9WT1l8rPe7AyqXWPnP3BouBsn7Rk8RagqEJkowMCRjcykDbyf2v6fKXOmq1rY7MykdgceC8bkVBgpbF0aqAH7spRS+171xUKvqReKFqF9na0Xp2N0NgYnyg1jwlyS67spqb60Ivvy1G2tMHWtAxJVWGT98E+RbkPSku4J97eFXgCcr+SJHeFCeBH111EcQg7yQDDHJqr3vWCdI3ylLGMInVdzJCk+5TU1R8HixN4+STPQklIPH9igMdh9lJtwF2MTdNWj7xXOp+BHqBlEWHknzcWC07zXKc3E6viCKUSX/JysRCPR2y7jiZ9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQ7ebH7TplpX6sFaRL/Tofmg4r0h8OC59GERz1fTrNA=;
 b=ovOZH5hS6v68Mtobyk3NGQi8r6LxAtUcZXqu+F+FpeSVxTxir18jAEzt/nCstFgO3bxAmWvXBO+m+EESwJBvHm1ZrZJE7Psg+bvowhZA1Fl1GyUXQzFnJTu0XdwGH9scPuhobOQSPSV3+sbPaS7vJ/g8voeVc8KiVqy1+UWI6ZUp0wZlkic3Vk8xXvilNV1thRiBIk0tqcl3jOhysR3kyGyWcXvgG8ILRRhqe0HS3Z0Ysgp5peiPYw9okJyFxty9BIKcN/2b3iCN4OqZZA21li/tALwX+7jCR5AgHWuS1Jp6WqHKM33RlboUzljPLNL2dGIp/WfVqitsOnAEBGsqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ7ebH7TplpX6sFaRL/Tofmg4r0h8OC59GERz1fTrNA=;
 b=AOjVBfVTiIT4d51nJFLDug2Id2j1YaTgQCLnpyTbSiiKw9y1HCUkTHH0siH6uZhZCfVABQbFuLQBqczzLyjFD8rX8nUkuKJ4GkMvVbVa+Gh+i6XH+x2IjR757Fmeb3Tbz9NpgLI9TbGtO9MwDAoLtsesYMfFCT6wFk3CLVuo1iisXym4jZlOTNgCVDaY3sCfinD00ysNaltsRQUXOWZdvILeLSuigHgJTKDuUhg2TFAhKzZHz/T5DVsx8doB2ock847N/HB1ngo3wLL8Ho3pmfCPqLG6fs9gymVXs+GDy480QYeL7p3lM7C/8fHkA1MwyySoH66FxH8L2B+Gutyn1g==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS0PR03MB8200.namprd03.prod.outlook.com (2603:10b6:8:293::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 02:00:32 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 02:00:32 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: stmmac: Add support for TX/RX channel interrupt
Thread-Topic: [PATCH v2] net: stmmac: Add support for TX/RX channel interrupt
Thread-Index: AQHc3DkqIH1j3+A9BkGAoMY9iMeSMrX/YE0AgADffgA=
Date: Wed, 6 May 2026 02:00:31 +0000
Message-ID: <1af799c2-b435-45b6-9224-3d2186b2ab5a@altera.com>
References:
 <20260505024459.22463-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <c2996d3f-a8b8-4d70-9b2b-c800aac323c0@lunn.ch>
In-Reply-To: <c2996d3f-a8b8-4d70-9b2b-c800aac323c0@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|DS0PR03MB8200:EE_
x-ms-office365-filtering-correlation-id: f11e4e5f-b294-40d8-1c9e-08deab134138
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|55112099003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 g5mGVvlxMh/s/HZ/i4bDGoQaQ1NjsA8IAos8dEA3E+9p9g5FDsCECogt8sjRZ+/2DJ8gfgUPqG0BAQpw6SEevZsu9NMJv1mf6NWc7RQ+jZjUMLJpeTSWoKIPkjODIhpTKJJt3PXL/UwWOecO9OBvK4E2zOBbG1CalbSFVgSE0pkR15USNSj/ma/AWk10SPaTbkHoXwvb+gjZ9mpR3ggw/bjN52ROzCFW36SAKBSd90b8Mlh8xcwANSY8BDACMUzafumSxDhb17eUdxW3LzwRMqbR18JxZqnklcXGoi2bh1H/Jt7aSwaipBAGNJPBv+ZYNzzxFCJSG+hky0XNf0H17vB6BbVzcOcvCT5rsdiXFFYx71rG537sou/osrgxY0jE+vacGNpCTIKCllc9/+UAg2UFZIz/eAmIopvvFF7yH6DVywwYLJaUp8y9H7RTaS40nuWpYlAm3/33ycsaqwSLRqHGGahd7Uc+6MIHt/Xmr304/IYWQYHgYanYI9PkFr+oFup5ozftAxRs1tg/Pr1ivgqADXhYt9ugBOHl7aIjZH/Q6OkbHNZiBP/t/gKaOiJaJ7ZTTDEHYBRyJ7Uto6DePx4YLFH8ptW6JHTTf4E3PiZZsM3GldJ/S4EHHTVCGfA7JjXtFmCIKw4904orpfapgKNqrJfVdD/WDVfoSHmyze/32Y+T89LuX1pkKa3Yvu1bjkG0kBaxSRqbqbVIe7hy3yGC3fM0YJGNxb93MhoRHp1+TnUDiOF5TQuByDu4gpEi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkM2Qk5ScktBME5LQUFteGlxemN3R0Vvd0dPYzFxNGNZRVQ4UEhLeFNTSHAw?=
 =?utf-8?B?cHg5RXRUb0xkWE1jSnY3TmxJaDkwTGpKbUhXLzYyWjhJdG1UekVGdXVTL29V?=
 =?utf-8?B?U1BVMzJJRmowNXQwTDNBakQvUGp0Sk80cklBWWpJUHJNeWxIdnFkZGNlUjBF?=
 =?utf-8?B?Z0xqNVQxMUNwM2pFclE0TGo0ODBQdzVOT1NDQmNROTlETk5LK2lnTHNqeENp?=
 =?utf-8?B?ck95TVFmcHZRdUhrdHNxNVcrcXlYWHMzZnNPNEZna1VMNDZadDExSEtZbHpa?=
 =?utf-8?B?VjNzdXpoaVdndVJySlp5TSszK3Bsb0NVUithZHYwYnhZd3hqN2FCNCtFNlEx?=
 =?utf-8?B?NnMvR2FLN2NTNjJFbnZ1aFRCeEtoYUxhL3pHQ2NSdVJJWEJjNXg0dThwcVJ5?=
 =?utf-8?B?eXF3N3g0Y0dMczkyc0I2KzMzY3dLTWtBMWdFQXZndFQ4SGxmQ21QdUY3SFBx?=
 =?utf-8?B?Y2ZiUjVvc2p1MDJGMlRmeklQcmV0U01nZkpZMlFlQWpoNHk5Z0g2ZWFmMXNJ?=
 =?utf-8?B?dDFrTm4rb0c3eS9yVSs3dHB2anpZWFFyNXBCcWtjdGR6eVY1QmZVY1lPMFFs?=
 =?utf-8?B?SDFlS3B6L1lGT0Jqa2NXU0x3eFJxNFZUMzlwem5vZmtWK0MzYjJVbWQxSmtp?=
 =?utf-8?B?d1lJVmpMT2ZIMXkrYXd6TjlLUTFza0NFUWJNNUl0Q0UrWGtwWUhMOFVhQ3hs?=
 =?utf-8?B?cXJlTGsyWDBIcEZnTDkwWTQ3c0Y5cS9KY2xScDhGMlFINXcySFpJUmdLM3dw?=
 =?utf-8?B?TmpIV0hnRThGejA5VFJyU2g3K1dCcVNxcVEvRUhhaVVJdVVnQXBXNDFDdDNM?=
 =?utf-8?B?bzN3MDdXOFJjTEhrWDVGZ1R6emJyK0pZVC9EeHdMWEJaU0dRSE1kNERybWFw?=
 =?utf-8?B?V3JSb05SVHk0K1IxcHRtSkZsU0RaNjhwdkY3MWxSVVR2RUJsYld0azMxdUt2?=
 =?utf-8?B?T0x2SVErOFdlY0pmY2NXWVVRcVVFZEc1UkpSNVdHaVYvRXJ2dWRqU0s0OTZr?=
 =?utf-8?B?VXpvTjBBVVJ2S01DWmZaWjZod1FDSU4yeDl3d0VPci9oMEE3UWVXZkxqelVn?=
 =?utf-8?B?M3lKVFVjeXBGYllwZnYzZ0xhZUdQYyttRm5IRWZNT0M3TnpaSWIxNEZuK0p2?=
 =?utf-8?B?WHRZQjBMWERzOHNNaFI0R2pucC9HM1NBcWNFN2U1NEYrUWZ4MWhnUWRYWDZY?=
 =?utf-8?B?UXd2TjZTMUdaeE9zMHZqZVRJYldPWmo1Sy9ibTMyREhMRERqa043ZWhOTk5w?=
 =?utf-8?B?eHF6SDJ6SHJWcWRMdDRQT2hsOVExeE5SRWQ4V0l2cGF1TXdnVDJoVldxcjJu?=
 =?utf-8?B?Y1dCK09RZUxjTUlTa09PbWxXMEVEUDJObHpOU0pMc1VhN1F0Zks3TWFpcmpv?=
 =?utf-8?B?bGdLdWNiUGRFakJLUHpPNHJiZ1FnRVNLRDRaWUpCb1BDQ05BY3pMa0V0M3Bh?=
 =?utf-8?B?L2tVV1prRW1nYzczbEhFbnoyZnNaekoycklYT2ZSRkZ3Q1JHc0o1WmZJMytw?=
 =?utf-8?B?aDF5Y1JHbWIyUzhlK1VaR0JBamFnMnQ1cEc3ZnY2WnNaTXY5QVAxNFhCUXd0?=
 =?utf-8?B?dXo0OW5JODRpU1YrQ3d0SlA4QkFGS3F6UjRtS0pKWE1vc2RWRzdDUHRlS0xh?=
 =?utf-8?B?T2lOaHc1WHNlUHVmZ3JMcWJRa1AxdVRpemgxK0JwUkVyVUozRm1nL1FtdU0r?=
 =?utf-8?B?ZkdPOFc0RzViRFExQVhaWnZpakliVkMzWUpFOHhMSU8xcHBxWDZmWEdkN3lV?=
 =?utf-8?B?YmkraWRRR0hVT2pGMVlNNnQ5aFk3aUVDR293R0hJMEljTUQrb1NUOUV3VktE?=
 =?utf-8?B?MUdxd3dMQU1OSnJOMkM0N2F4cmJxWHI2Qmpjai9aMld0OHd2SklPUzNuNVpr?=
 =?utf-8?B?Tm5IZzg2aDd3NkpZQW1TLzgyd0xzd2RaRDNVY2s1V0dHcXkyNjQ5cFFSQ09J?=
 =?utf-8?B?a0pmRlFNQmhvcW1SOW5LOXowdFRqSXBQQk1YazkxRVRuendjTitJRUlBaW5J?=
 =?utf-8?B?REg0cm5JV2wzTUhObnlibS9UUnMyV0h4Z1g5M0R5d2Q4UjNjNjk5cFNDM0ox?=
 =?utf-8?B?ZzdJRE9VT3ZhM2l6bXZ6ajZOV3FwQktBWjRHQmgrQlZEMUlLRWhTL3Jkbmht?=
 =?utf-8?B?TGs2OTMycXovWFRodUNKL3llcWtTQkJLTmtrT0lWcDVTZ1ZIYUNTSXZlbmZi?=
 =?utf-8?B?cnpuZ3VhTm5qOVFxZ0JLbWFmck5VNEZORVlsN1F4alBXM1FjZWpNTjNJbjk1?=
 =?utf-8?B?dFA3UG8rSS96UU0xeEZVTWJNT1pnMVplb041YVJHbDkxYzhjSVk2QkFkN3N5?=
 =?utf-8?B?Sy91Q0puQ1NRcStrbmM0V0paSWVJV2xVeHJsNXppejZ5aVpEdWV0UEdGeGk4?=
 =?utf-8?Q?P8Wc3aex150hwEBiv6PhKzkPd9nv+Me89bdZhaa6jDwWu?=
x-ms-exchange-antispam-messagedata-1: mUXjpkuc6d23NlPp+8Le/4haSwHT/GAdZk8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27A5463CE997FF4693C3F3B0B9CF05A7@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f11e4e5f-b294-40d8-1c9e-08deab134138
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 02:00:31.9558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+lJLgUCMWJbAHKsiT3SjQD+Gf6/y6IsvhY+8GS64F2FUIkx/1m6IlJ/LuwXSlBeir9mIow2BCm4u6wSAfWzj6/zt+b0u8xnLaVZ53xMgaqRasegDzEI4gobeGeuQDSoM6M9D+d5GvuM92whysPYxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8200
X-Rspamd-Queue-Id: 6AEEB4D58F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284662-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[altera.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:email,altera.com:dkim,altera.com:mid,aka.ms:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

T24gNS81LzIwMjYgODo0MCBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IFtZb3UgZG9uJ3Qgb2Z0
ZW4gZ2V0IGVtYWlsIGZyb20gYW5kcmV3QGx1bm4uY2guIExlYXJuIHdoeSB0aGlzIGlzIGltcG9y
dGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0K
Pg0KPiBPbiBNb24sIE1heSAwNCwgMjAyNiBhdCAwNzo0NDo1OVBNIC0wNzAwLCBtdWhhbW1hZC5u
YXppbS5hbWlydWwubmF6bGUuYXNtYWRlQGFsdGVyYS5jb20gd3JvdGU6DQo+PiBGcm9tOiBOYXpp
bSBBbWlydWwgPG11aGFtbWFkLm5hemltLmFtaXJ1bC5uYXpsZS5hc21hZGVAYWx0ZXJhLmNvbT4N
Cj4+DQo+PiBFbmFibGUgVFgvUlggY2hhbm5lbCBpbnRlcnJ1cHQgcmVnaXN0cmF0aW9uIGZvciBN
QUMgdGhhdCBpbnRlcnJ1cHRzIENQVQ0KPj4gdGhyb3VnaCBzaGFyZWQgcGVyaXBoZXJhbCBpbnRl
cnJ1cHQgKFNQSSkuDQo+DQo+IFBsZWFzZSB0YWtlIGEgcmVhZCBvbiBodHRwczovL3d3dy5rZXJu
ZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL21haW50YWluZXItbmV0ZGV2Lmh0bWwNCj4N
Cj4gVGhlIFN1YmplY3QgbGluZSBuZWVkcyB0byBpbmRpY2F0ZSB0aGUgdHJlZS4NCj4NCj4+ICAg
aW50IHN0bW1hY19nZXRfcGxhdGZvcm1fcmVzb3VyY2VzKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc3RtbWFj
X3Jlc291cmNlcyAqc3RtbWFjX3JlcykNCj4+ICAgew0KPj4gKyAgICAgY2hhciBpcnFfbmFtZVs5
XTsNCj4+ICsgICAgIGludCBpOw0KPj4gKyAgICAgaW50IGlycTsNCj4+ICAgICAgICBpbnQgcmV0
Ow0KPg0KPiBSZXZlcnNlIENocmlzdG1hcyBUcmVlLg0KPg0KPiAgICAgIEFuZHJldw0KPg0KPiAt
LS0NCj4gcHctYm90OiBjcg0KDQpUaGFua3MgQW5kcmV3IGZvciBhIHF1aWNrIHJlc3BvbnNlISBy
ZWFsbHkgYXBwcmVjaWF0ZSBpdC4gQWxsIGNvbW1lbnRzDQpoYXZlIGJlZW4gYWRkcmVzc2VkIGFu
ZCB1cGRhdGVkIGluIHYzLg0KDQpOYXppbQ0KDQo=

