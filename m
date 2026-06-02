Return-Path: <netdev+bounces-294444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SKg7BSFYH2pHkwAAu9opvQ
	(envelope-from <netdev+bounces-294444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 00:24:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 790B863265C
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 00:24:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=fI7yGefh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294444-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294444-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F91A304C342
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6788C3B83F8;
	Tue,  2 Jun 2026 22:24:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A513BAD96
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 22:24:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439069; cv=none; b=GjfmSFl3FA85Xcj+wEvwlRkZkxAAOG38XmL0dDKIrrmdkahcwP8wHfwGfCcU/vytP7+qvn9QGl+es7w4A9Tmk7Dw3V7lnsvFQeU+1W2h113O/eg02mMOhNlEvSZLFV4tKthldtFIbv90GmxaHGlVbQ3wopsLrcyQNXZuxODkWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439069; c=relaxed/simple;
	bh=Acmc3MgUL59HqtPwOfn+qzs6XtjyymOKnbITI0f19kM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=He+n2448W2EovZ2yFFJrOJ/vbSN8AM3uuuS6vmqBdBtq8pKBLHDw63zhO7ddpFutrP/8j/pXa72lLIi2NOxy4kFbEnfsdieRV6gEX22RHuZDwXAoMMA0t5tXmsvP8zQylbhyOg2Nph/x1Ci5ndzOkdk6BrxSmHX8d8C3pYjJnvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=fI7yGefh; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780439061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Acmc3MgUL59HqtPwOfn+qzs6XtjyymOKnbITI0f19kM=;
	b=fI7yGefheA91htwAVnQoziB8GKXYePITubio9irMtOQZx7PCG2AWS6H5ZXqTgutOKoSWyR
	yWpqrlChPmw53XoAoAMBU9ponIz587uEyAwOP4WVfMsHui6SqVwGpQHaf61D66+B5Syt2q
	B6KSjIj9nSpXhtPhAtVEU9r//emImBvCUhiJNqrP/MYF+9+0sg2lCIdWjpxWh8RlZkvwpU
	8VL8M60QuCL3Hh/7+jGsWutOyTne5twySGeiICJ30EgXRllUUdZ0Fg9Z4BX7sYu6tHnG3W
	0tz/jPe9zTsiZopzmUfkABzv8uu4N3YvMvtSQgJjr+6cpe8kMPRh2CwoxP+eww==
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-24-lopHDoUtOdyGuNHIuo6uQA-1; Tue,
 02 Jun 2026 15:24:17 -0700
X-MC-Unique: lopHDoUtOdyGuNHIuo6uQA-1
X-Mimecast-MFC-AGG-ID: lopHDoUtOdyGuNHIuo6uQA_1780439054
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CH3PR02MB9259.namprd02.prod.outlook.com (2603:10b6:610:152::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 22:24:10 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 22:24:09 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: David Laight <david.laight.linux@gmail.com>
CC: Andrew Lunn <andrew@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Thread-Topic: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Thread-Index: AdzvmRIV9Yc6XZqaQq2ja4j42ca11ABc8QiAAGMRVAAAArOLIAANC/eAAAEdomA=
Date: Tue, 2 Jun 2026 22:24:09 +0000
Message-ID: <CY8PR02MB92490419EA61E8FAD38C1F5383122@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>
	<cf87ad90-6ba4-4132-a1eb-beedd796c168@lunn.ch>
	<20260602150712.5b28d58b@pumpkin>
	<CY8PR02MB9249B26D4B4344064A582A3C83122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260602223807.1ac76456@pumpkin>
In-Reply-To: <20260602223807.1ac76456@pumpkin>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CH3PR02MB9259:EE_
x-ms-office365-filtering-correlation-id: 980df882-7a77-4325-09b2-08dec0f5aad8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|38070700021|11063799006|4143699003|56012099006|3023799007
x-microsoft-antispam-message-info: wx8Fsjh3T72YKznUVhMU4jA2lmkFM3NVnZ74DQ3yMO3mMplGxeeKf3AjtWnxdkx+AaFXr6tcqeiTUw1s2v3/SNcDM9DxSSwbVOmURuUOIX3xyHPUxJzIvJTnht3lp/rs/nNRAigNVRNgMmTxyEMpzGtl/BjLIaiKZsdEzg1zw8GphB4FlXhFkVTCujxhv0LvXRYM6H3Ox/IccDxvJMaF1hmgD78pvsFDFlDXWMWbNv7Zp3AXaTp14+ah5+ufvuK6How/Z8lQmV9lZJgRI37xRnYMLkAdvjJxrlpkbbmYGjZTkZ9Prhz3e2K0Hb0ADpFHE0yuVZ5lCtIsdo8QnxYdILNZ5zLHW9L8PIEs3nGfUPpJqiA/IYYVW4H2Wyj8MTaHWPxK+G/HXvvEwzpycrdD2V9PxS6/86K8Y0H9loKS6JQqTxn9AkzMs7k13DTcW3kgMu+qwzs3URw8Iv5vdZZDwmPH+/y3azlkvldwRoQ2ca5S/pWhv1dzIspmUWixeKQoeCnLcLWlhRzmOPVdcEV9OxdeImKHkqWFoJCWJ4+R3QV8pF2anZbykwMT3zyXEuhR8HpkcJrnhfV34FgDWFK75w3VqDtQkwDIjk1UBPJa2icmBkkKaTJclTH7QMnf3tS0FiSd/OA70HOlvgIXYSZc9qzfttZnRXDKtMlbFlK9O460Q4FCQXgZ3Ytfiquq6L4W0h5m13eKtvD2qkCsvLEm4Yz1Mk7ffM7xx4X6ip63HttLnFNjNCgS94XgbNszVnJJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(56012099006)(3023799007);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDRQRjhEZjRuNFZyQ2tnZUVOTFM4TFc1aGd3cTZqc1hrQUtuU1B6R3poUHE2?=
 =?utf-8?B?TjA3RStXcm1XMlhHTzJNTHl3QnAxcTJRMnJxZEpWRENNaHhDN3RkZnhPTXAv?=
 =?utf-8?B?VUt6MHowZmFEQm1CT2o4OFcycUFxQUROeFN1ZFgzcGxYQ29EcjYzYysvcGtM?=
 =?utf-8?B?YStsbGJ2dFNEbVBBQW9yTUJpb3VFS3NaalpTei80RlZyN25KOUlwbVk1NUtj?=
 =?utf-8?B?VXErdWtkREJwbythSGM5Nmx0R1Z3NWtrWVJOczNOaENncDZnS0xRMjM4SUpU?=
 =?utf-8?B?cVBBMUlNbUNUV3FoM0hhdDN0SWVTclh2NC8wNU9JNlNRVTMzZGQ3Vi80cWpU?=
 =?utf-8?B?bXlYTHNELy9zTG5wNEZoY0F6eUc0bENGZjIveHVGcFh2ZDVaS0VjRDd3MmxN?=
 =?utf-8?B?UzkxZ0dqRTl1Uk9HMEVJeUIxcVJzMWMxWEV5ZENkR0tZRGlGeE93cUpiams5?=
 =?utf-8?B?eDVLcEp4emNPUm40TVJteHJvOEE3cFBtN0lCeG91WEI3d2dMQm1ReFh1T25s?=
 =?utf-8?B?aEd2dDZtZ2puZWM2S3Q3bFduc0c1Rktzd25jaEZ4RUdkK0xpMVlLejdkeVQ3?=
 =?utf-8?B?Nm1BcHRlbFdaRXNqYSs5NzUvdWk0ZjRyaUxhbm9BeUFjTEd2NTY3UUN2M0FZ?=
 =?utf-8?B?L24xQkcrV0N1ZXNGUFRvMmRDVGppZWRId3RMOGxaelJPTUJPTlc4ZmdYMzhi?=
 =?utf-8?B?clBLL0dLeGxQODR3cUZkNFFMZXFiM1IyTWcwaitYbExLdkFPb3BoYzhJWjNL?=
 =?utf-8?B?UjVDZkZyK3BUQmlRQllmNHp6UWNsSXJoMGRSOFRFM2VPLzZrRGxmR0Ftbklk?=
 =?utf-8?B?Q3RYejM1VTNDbnNFaGdSN3M3RXVBa0JHcTFJNVE4Q2pCRnVSMkRvZ2hrOTV0?=
 =?utf-8?B?YU8rNS81UE1zTmVLYkhmdHRsTlVaZHpCRWJnV3UybzUrMUNsclB5akJBYlph?=
 =?utf-8?B?cHJuVHp1V2VxT0kwS3puaCtSNENCWUZDSUpPNmtxa1NTQnRqVHQyelgvUXV1?=
 =?utf-8?B?aDB2RXlseCtaNkE1VVVXTjhPSm54R1BqbHR3cE8zMW5aTkNGOUdlcmRHQkc1?=
 =?utf-8?B?OGdyZ25zbGdGWFRtTzFoTTFZUGhxZllHMGpOS1lnNWNYTEV5cmRCVDFLM3BQ?=
 =?utf-8?B?Mm9ESGdqY3cvRnorRVdJTnMxS3d6a0I5QlVPV1luZTNHRzVZWDh2T2xjcyta?=
 =?utf-8?B?K3JNTktzRVVNanEvNDZ0N3ZEQU5BZEpoSVJrNi9uTExYZE9vZTl4cEh6OUtt?=
 =?utf-8?B?L0VCMmVuUlAwVkR4TVVSWlEwV3kvejhxSmdvVmFMZTB2RVg4Nk1wbm9wVm11?=
 =?utf-8?B?VSsrWXJzV2w5Nm8xSjlacVZNYU9ZdHBBN0UweDZLRFVEUjViazZDNnFwd1My?=
 =?utf-8?B?cjBUb3BrSTd5QjRoajVWUjJZVEJTV0hQbjdJcFdYVnRXZU13NWNiTi9jUVJq?=
 =?utf-8?B?QXAwK3dJa2NKN3huTXRNd0NRWjF6c3hKSFlLeVhJK1FDTzV0ckFDUmFvWGVJ?=
 =?utf-8?B?c0NYOGV2WFpucWlaK1pqbnQzTHdHNVp4NXl5UEpyNk9UZmdheTBnRVRBc3I2?=
 =?utf-8?B?YldMYmJCd0M3am1lTVNXdWk4Rm4yV3B3aGVxK1Q4UnpiMWpTQkk4eG1NOFJw?=
 =?utf-8?B?d2FhRzliV3hHSlhtWEdlNERyRzFnZGcvcitYRlVOTGdmQTNYZEtxUFZIUG1W?=
 =?utf-8?B?VGxCRTZQVVovQ2hLbnFnQjhmMXlSOVZKT1Y5aGxzWjBqUVFFeFdsbm5pSUFL?=
 =?utf-8?B?eGhxTlZqL0s0UDlUU3JBWnpZVHZITCtkZjROeGIvM1UycEROakhtam50SG8z?=
 =?utf-8?B?OVI0M3J5TUFLRnQxWW1ab1QzbGhESlU5NUhXcUhqRlhiTGdNaHVmWThYRmtK?=
 =?utf-8?B?TTZjTm9sL0E2dFJRV1lQUWFGTjR3Wm1haldkb2hrRS9URlE2ZFQvejVBYXhZ?=
 =?utf-8?B?OGR4dUN4YUhHZ0hXcWxhangzK2ZHbmkyYi9OSU52K28wK3RkZkU4QkhaN0M5?=
 =?utf-8?B?R1BxejJMMk8vK0ZZVEFoamYvNGVDV3lYQ3dpOUszYzN6c0ttMG1ST0lXYTho?=
 =?utf-8?B?VFVaaHpSdjJUMHFCVkgvNG5KRUJkS0Q3dTRFL0NPbFZpSzVvc3RDQnpYaFhp?=
 =?utf-8?B?ajlyejZ6Z3B2TndaR2hySlBhYklNZ0JLRFNIeks4MHpsMm9ERlEzTGZJTEJS?=
 =?utf-8?B?eWp5b3ZRQzMvVjFKdHE1NW5EOVBzaEkvZGhESE9mdEZTYkp5Rmw3VW0yd056?=
 =?utf-8?B?TzR6WFNuVVVaNUdUQXlMUXNjSHhDdlBUVTAvVjZJUnp3NXBUc083K0Z2Q20v?=
 =?utf-8?B?cE1YT0h6emNoL2JPQXFIUkxiSTBZc1ZyeDJUaHRJK3lOU21kTEFONXVaTThp?=
 =?utf-8?Q?Kkk3Bv+z/xXyKbOk=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rt1fHjbey1bWO96ZVSV0U8jKkb37AdmLX20hnYWkvdXWt14GTYymSj7QzDRCQAz7G6vjT9SpphHjrP0gWQ2ph8Rc8ofPHEHIEefcqmFw7k7y9kM6V4gYv3ZofbxsmQ+axxdhteRNyPstP+hkifhqZ+jCcOZgdANXkUs2wuDnAC96zuANGtbPnIj7UZCvXlFFhVRrTCIxTlhRg3s1N3F1WUY3Rhao+DV3TYj0Dcyp5INT2wj4jEDg87o+uJV19Ihy6i8azRIeMugUQM+95BhqVnav2cOOLeda/f1OOYPwiLJLtdu/Y9wlmuOnmimiP8+M9KbX3fDk8wtQxr+ghkWc6A==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980df882-7a77-4325-09b2-08dec0f5aad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 22:24:09.8436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4tepnZNQtQB15i6Qt5mfCKG32slz9GwByghT044/qcTmNuLEfl4yOLx3vvX9q6VtwXxffUKmCNNxDXlsPXlLgUz/Dg/R4JvFVM6VulDgOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9259
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2-pcUF9MgLfbgzeS63bnCaV1T8utWd-CY14xXK4CcPY_1780439054
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294444-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 790B863265C

PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2MyAwOC8xNF0gbmV0OiBldGhlcm5l
dDogb2FfdGM2OiBSZW1vdmUgRkNTIHNpemUgaW4NCj4gPg0KPiA+IE15IHVuZGVyc3RhbmRpbmcg
aXMgdGhhdCBpbiBUWCBzaWRlLCBNQUMgd2lsbCBwYWQgRkNTIGF1dG9tYXRpY2FsbHkuDQo+IA0K
PiBUWCBwYWQgaXMgc2VwYXJhdGUgZnJvbSB0aGUgRkNTLg0KPiBUaGUgZnJhbWVzIGFyZSBwYWRk
ZWQgdG8gYSBtaW5pbXVtIHNpemUgc28gdGhhdCBjb2xsaXNpb24gZGV0ZWN0IHdvcmtzDQo+IG9u
IG1heGltYWwgbGVuZ3RoIDEwTSBjb2F4IHNlZ21lbnRzLg0KPiAoT3IgcmF0aGVyIGNvYXgrbGlu
aytjb2F4K2xpbmsrY29heCBhY3RpbmcgYXMgYSBzaW5nbGUgY29sbGlzaW9uIGRvbWFpbi4pDQo+
IFRoZSBzYW1lIG1pbmltdW0gZnJhbWUgbGVuZ3RoIGlzIHVzZWQgb24gbW9kZXJuIG5ldHdvcmtz
IHdoaWNoIGFyZSBhbGwNCj4gcGh5c2ljYWxseSBwb2ludC10by1wb2ludCBhbmQgYWxsICdodWJz
JyBhcmUgc3RvcmUrZm9yd2FyZCB3aGVyZSBhIG1pbmltdW0NCj4gcGFja2V0IGxlbmd0aCBpc24n
dCBzdHJpY3RseSBuZWVkZWQuDQo+IA0KPiBWTEFOIGhlYWRlcnMgY2FuIGdpdmUgdW5leHBlY3Rl
ZCBhbW91bnRzIG9mIHBhZGRpbmcgLSBWTEFOIGRpZG4ndCBleGlzdA0KPiB3aGVuIEkgd2FzIHdy
aXRpbmcgZXRoZXJuZXQgZHJpdmVycyENCg0KVW5kZXJzdG9vZCBhbmQgYWdyZWUuIE1lbnRpb25n
ICJwYWQgRkNTIiBtYXkgYmUgdGhlIGNhdXNlIGZvciB0aGUgY29uZnVzaW9uLg0KTUFDIChhdCBs
ZWFzdCBvdXIgTUFDKSBkb2VzIFBBRCArIEZDUy4NCg0KPiANCj4gDQo+IElzIHRoaXMgYW4gU1BJ
IGludGVyZmFjZSB0byB0aGUgZXRoZXJuZXQgTUFDPw0KDQpZZXMuIENvcnJlY3QuIFR3aXN0ZWQg
cGFpciBFdGhlcm5ldCBvbiBvbmUgZW5kIGFuZCBTUEkgaW50ZXJmYWNlIG9uIHRoZSBvdGhlciBl
bmQuDQoNCj4gWW91IG1pZ2h0IHdhbnQgdG8gcGFzcyB0aGUgRkNTIG92ZXIgdGhlIFNQSSBsaW5r
IGFuZCB0aGVuIHZlcmlmeSBpbiBzb2Z0d2FyZQ0KPiBiZWZvcmUgdHJlYXRpbmcgdGhlIGZyYW1l
IGFzIHZhbGlkLCBkZWxldGluZyB0aGUgRkNTLCBhbmQgcGFzc2luZyB0aGUgZnJhbWUgdG8NCj4g
dGhlIHByb3RvY29sIHN0YWNrLg0KPiBUaGlzIHdvdWxkIGdpdmUgZXh0cmEgcHJvdGVjdGlvbiBm
b3IgZXJyb3JzIG9uIHRoZSBTUEkgbGluayB0aGF0IG1pZ2h0IG5vdA0KPiBvdGhlcndpc2UgYmUg
ZGV0ZWN0ZWQuDQo+IChBbHRob3VnaCBpZiB5b3UgZGlzdHJ1c3QgdGhlIFNQSSBsaW5rIHlvdSdk
IHdoYXQgdG8gcGFzcyB0aGUgVFggRkNTIGFzIHdlbGwuKQ0KPiANCj4gVW5sZXNzIHlvdSBhcmUg
ZG9pbmcgSVAgY2hlY2tzdW0gb2ZmbG9hZCB0aGUgSVAgY2hlY2tzdW0gd2lsbCBwaWNrIHVwIFRD
UC9VRFAgZXJyb3JzLg0KPiANCj4gQnV0IGlmIHlvdSBhcmUgcnVubmluZyBJU08gdHJhbnNwb3J0
ICh3aGljaCB3ZSBkaWQgMzAgeWVhcnMgYWdvKSB0aGVyZSBpcw0KPiBubyBvdGhlciBjaGVja3N1
bS4gU28gaWYvd2hlbiB5b3UgaGF2ZSBhIFZNRWJ1cyBjYXJkIHRoYXQgc3VmZmVycyBncm91bmQN
Cg0KDQpPdXIgTUFDIGRvZXMgZ2l2ZSBFdGhlcm5ldCBmcmFtZSB3aXRoIEZDUyB0byB0aGUgU1BJ
IGhvc3QuIFRoYXQncyB3aHkgdGhlIG1vZGlmaWNhdGlvbiBJIGRpZCB0byBvYV90YzYuYywNCnN1
YnRyYWN0cyBGQ1Mgc2l6ZSBiZWZvcmUgZ2l2aW5nIHRvIHN0YWNrLiBCdXQgSSBkaWRuJ3QgYWRk
IEZDUyBzYW5pdHkgY2hlY2sgYXQgdGhlIGhvc3QgYWZ0ZXIgYXNzZW1ibGluZyBFdGhlcm5ldA0K
ZnJhbWUgZnJvbSBTUEkgZGF0YSBjaHVua3MuIERvaW5nIHNvIHdvdWxkIHRha2UgZ29vZCBDUFUg
dGltZSBhbmQgcGVyZm9ybWFuY2UgbWF5IHN1ZmZlci4gDQoNCkF0IGxlYXN0LCBPQSBUQzYgZnJh
bWV3b3JrIGRpZG4ndCBpbXBsZW1lbnQgdGhhdCAoeWV0KQ0KDQoNCj4gYm91bmNlIHdoZW4sIGZv
ciBleGFtcGxlLCBwYXNzaW5nIGEgcmVwZWF0ZWQgMHhmZiwgMHhmZiwgMHgwMCBzZXF1ZW5jZSB5
b3UNCj4gZ2V0IGNvcnJ1cHRlZCBmaWxlcyBmcm9tIGFueSBmaWxlcyB0cmFuc2ZlciByZXF1ZXN0
Lg0KPiANCj4gLS0gRGF2aWQNCj4gDQo+ID4NCj4gPg0KPiA+ID4NCj4gPiA+IC0tIERhdmlkDQo+
ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBBbmRyZXcNCj4gPiA+ID4NCj4gPg0KDQo=


