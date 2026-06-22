Return-Path: <netdev+bounces-300958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lGvQJcfEOGpRhwcAu9opvQ
	(envelope-from <netdev+bounces-300958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:14:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C096ACB36
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:14:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=EC0L638Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300958-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300958-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A16AC3005A92
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 05:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350CB355057;
	Mon, 22 Jun 2026 05:14:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49E134EF1F
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 05:14:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782105284; cv=none; b=lt28xSXAymXr7X54i9hYNg+qWuvHgVZ4DfGe+kyq7dbDN3Brd1sT3lVTVzPecAnxBruh1FuDOUMKXID5SZrNFddPVy1eoCxbWrgICzA2GOY0qp2uo76CB5S6Bh/s6PWwVlbFO/HQjq2v+M6IGFL0DNNjc09goh2KR4+HLwC+MYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782105284; c=relaxed/simple;
	bh=9ejlHdcaB1ZgyyqN5Is8IdvJsx7/66zcbK8XqQAGRw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=is2w6TVtaGr2tNZCV5tdingJ7aCaXYKE00CAR87P2cTYQfFRr0iecnBQS3CQ+s9vXccoCIGe4MqM4PMCNrTlt56chwgw2wjjgAgCxx7L5StkTqkp5I5nXjszowf9R3BorcntMtrzjTzHAl9su2FNib1RADdlTell7rnZXgi/ftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=EC0L638Y; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782105275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ejlHdcaB1ZgyyqN5Is8IdvJsx7/66zcbK8XqQAGRw0=;
	b=EC0L638YLtfG2K4Bwim9oiO2ss938dBCCaTTMCefbfXn5Cwq5r8dx61fFIhvM3lFvRH1UU
	1UVEdomvhVMfNpmK/3Y7FhUS+epeyvWANTrdWeJJKOLvKxnSz64C2v59gluTVuDNDAUJW5
	A5ZGAzSyYESMKCjwMAjl/boNWzmVCvyYcjxf3nu2IrFkD6DWfJFOrnU1IEv6VtKbPGfafu
	EIfA2+fkgLSDBI97/WYVEJ2MFF9KcXFThbGn4D0PrZutTOAx7xkCCUQYa7DT9meZUUVfC3
	rYCJ8ajUK/HRfVStRLIdROHnF+ynAkk9Gw4UUK93msvzicVcBJMlZQ+C3/A2cw==
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-60--e_zDbMKPT-MyfLb4fN1aQ-1; Sun,
 21 Jun 2026 22:14:20 -0700
X-MC-Unique: -e_zDbMKPT-MyfLb4fN1aQ-1
X-Mimecast-MFC-AGG-ID: -e_zDbMKPT-MyfLb4fN1aQ_1782105256
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by PH8PR02MB10184.namprd02.prod.outlook.com (2603:10b6:510:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 05:14:14 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 05:14:14 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Conor.Dooley@microchip.com"
	<Conor.Dooley@microchip.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Topic: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Index: AQHc+e0nFxx0u09WdkC+bo9XNPrS8rZAt0OAgAMGobCABlg+EA==
Date: Mon, 22 Jun 2026 05:14:13 +0000
Message-ID: <CYYPR02MB9828A1434E6339A6CFCCA74283EF2@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
 <20260611-level-trigger-v5-1-4533a9e85ce2@onsemi.com>
 <7c89df6b-32ac-46c8-8400-945879037f2e@microchip.com>
 <CYYPR02MB9828CD98EEEB9B218A940E4483E32@CYYPR02MB9828.namprd02.prod.outlook.com>
In-Reply-To: <CYYPR02MB9828CD98EEEB9B218A940E4483E32@CYYPR02MB9828.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|PH8PR02MB10184:EE_
x-ms-office365-filtering-correlation-id: a4048293-ee99-4643-1789-08ded01d19e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099006|4143699003|11063799006|38070700021
x-microsoft-antispam-message-info: NG09v4gEgnsxfS7y7ucDDez5SonTZhgGuwyC9S7K627X+OT1/71VG7nQLd6dEBAu7Ij6kZhw22bUhSsN9VdjcuGoUBwD17ssY/eMs2OVJ58ivTkGJeJD1XUKMrqhhob9rw0bcm8SQpRNvXOPetJBct/9uWegD4V/VQrxShM6PVXntZu4s6HAwi4ShdVzDEbIbpc2EmVK3hyCaBNj18JdgdqGGAbjC+Y+VdAtNJSxN5fh3kd/Lj4reM15U+AIxaDvJt75m9trN0z+7krTy8UOL0pRrJlyM0eZGw0f0Ct4d7XEr21pE5eZqOS86HSeAZS8MknaosMC4jaLDg0AlhimTlQJGtUNGXnz+KUeEBZr7x9Nkx/qlBxDEZbV6Zqqu+ZO4zp9D6Gu8Hfqiw/Tyisq0k5XxQuQzZQ9lnKU1W2w+dbhEFAOLHb6vyGIZkaBmdzSXJ9UwuvdGLkOBGSPXX0ZymljVi4+uRdgB7sTqSRWFNXT6cPLxYDyFTFSULRkfyqHplnQvKPXmc7ONQWV3PCZD3XHZEs8omaDwAuot+n6OQSzJnR+j1N3+pXuyd6YtWdvTG59cYROobJM3PftwWYQEwHzY1IaokYMabEg+WD8jhRgxgczYHPuUMA+pW75HqBW3T6OM0t5HA0zDNAjJM6SDYAabOz8ZQihbsgB7XZgPNvthf24/dLEKnjVh+E1bpwdROLE4EGqv9I/a6i0cVW5jIQHss7KKDd8f2cX7ArsSplmyUYqTNrUJjKY59Xowxz1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dG9sREIrbXJSUDdKQWpVTEgrSXJhTDBUMC9xK1FvSE1jaHF0bTFEckZtaE1s?=
 =?utf-8?B?TmN0OE5DdER6Um1HUWtCd0tUVGJpNGd2R2ZVZUwweDdjT3lROWpaRERUcjJB?=
 =?utf-8?B?cmVMZERKd1p5emczK0tOc05jSzdSY20zQzExT2IzV0lXSFd2a1JxeWYya0w5?=
 =?utf-8?B?eTh2UGx0Y2FQcElmZ0x6ZSt6aGRQRlUvdmlST1pDc1FBcmRtZjhyMmIvak5R?=
 =?utf-8?B?WFlPTmk5RjN0aXc1SU1kRnpVcC83TmtMbmhpdGhrbTFkTnBNRWJvZDhtQVNq?=
 =?utf-8?B?Mkh1dlhwQk9leHBvY1E0UU1Ed1g3VXJSUDJXakpBMnhxYnVqUzVjQVFRQlht?=
 =?utf-8?B?Q256aml1Z3g5K3JOdWpReVpvcGNwY29JWHhrL0poeWFrZ2NNaTBsZTFvSzZT?=
 =?utf-8?B?VW96SFJaWnNUblBCc2xTbnovR1RDZVkydUNWa0duZUFpRmI2YUdFYlpQVHov?=
 =?utf-8?B?dkhoZnp1a2VWZnN4cG5UVXBxZUFwUUQ0dnFvNTFuMVlDT1pDYnYyZldRcHNh?=
 =?utf-8?B?dVl1L3ZVNjN2YXNCSis0QmpUN0kzVnVSVDBseU1LRCtqWWYxVEdENlFCVC9r?=
 =?utf-8?B?d3lmTFVxMHR4Q0hCWkxFeW5PbEE4TGhwUnlDd21IWkl5Q3JIakdhc2ZJR0Nn?=
 =?utf-8?B?SWljVkxmQ3RHTVFsYStVM3BxdUJKZUxBbnUzVWJMUy9lVHZ6cnp5TWM5RHA4?=
 =?utf-8?B?VUQwemQydVRobU1sU1BZYUo4SVNzdVMwdE43SnppSldBV0xvOEdIc3I1dWpJ?=
 =?utf-8?B?Wlc4cENFUmQrQk5CZzg3YlBuR1JZQzdId1FuWEI3Z0dyMFdOK1J6K2JFUlJt?=
 =?utf-8?B?NXI0RjlZdGRhQUVwZTdMTjd1eDA0MTJJM2Rma2pGbERuYUhaOWFjVGhlZWpY?=
 =?utf-8?B?OFBQRmxpZW5TZHcvUlk4Q0hPNGlidU9IMlc2WTZkZVFHeWUrZEFsdmc1bkdG?=
 =?utf-8?B?WVZua2MrRE12TVc3VzRXSVNtdnpJUGlleGl5TmFoRTd0T1J3QmdTWUFBRmp6?=
 =?utf-8?B?eURib0JGbi9OTXBlei8rLzcvSjg5SWp0dGlFNHNVUDVNaFJsREpGWVVxRENV?=
 =?utf-8?B?ejFEcE1PM0xhZXBQUlRDWXE2Q1dXaHZJakdZV2srMy9ISnZndG03U0VMempP?=
 =?utf-8?B?WnRxdXdadTFBd1FTU0JFMzZSZ0ZIS1g2V3pLeW1Yc2Z2UjNmYkE1L2U5Wmpj?=
 =?utf-8?B?QmQrSUJRMTRIL1B6WlNndjB0MnI0WTFSL29iYWwrejJPckxxWkRIcjZySllC?=
 =?utf-8?B?SG5YR2pFWUY4anU1cGV4TmRDUWVNNjBvZUcrK0hVS1JYQjhrdDFaZHUrTE56?=
 =?utf-8?B?NFhxY0V3UkxFVDNleUpnZGtEaENnSXd0bFJwSWp6VVJrOER6Nm1LdVFLRktm?=
 =?utf-8?B?Z2F0ZzNMZ0R4RWtLUzdBbmdvbjNNaWNVNlg5eW5Wc2d2Uk9wVVdXNHUwK0ts?=
 =?utf-8?B?VFVLMW55MXptbnAzZ2sxaVBiSjNhcTYrQ1ljU2dZQnovckN6eVM1UUdVZlBn?=
 =?utf-8?B?ZEsrbXZxekFiNGhpQXlTdHVXdllYL0huQjRFYnV6NjhGK2JGa2ZnWEhxdGdo?=
 =?utf-8?B?VkxtZEFVTStndTZSK2VJY3creStENjduZk5HTnlZMnF2NHp1dU1GeUZTamdV?=
 =?utf-8?B?MVpJZHcyS21XSG00OEZCNnN2OWRmOVZvR3FIWHl1NTdpVmVPS2xmNlhjdk1W?=
 =?utf-8?B?aUQ2c0FIYkFHekpNTzhpWVYvdDgveDZFV1hPL3NlYmplYjhTNHo3RXdVWGJB?=
 =?utf-8?B?RlBUa2pjRTBtcGZyOXF5QWs1ZXI4c2h3aGh1K1lSdjlEY3c3Vmk2czIwZUNG?=
 =?utf-8?B?UnJNZTVDNGFQUytZRUpwYmZPT1l2Y1crTjY3bGlPNGNGNllacjFGNUl3L21v?=
 =?utf-8?B?ZEF1T042dHBwUHdQd0s2RUZBN0NZMTlNckVVbU84TmdseXQ0KzBlam5FanZi?=
 =?utf-8?B?RWtZNTBzS0U4bW8rL1VoWDMydHpaRGJyYWFzTyttUFNEc3Q1L3JLS21VcVRO?=
 =?utf-8?B?RnBPT1J5YlpHcGVRdGo5M0ZNV0twUzExN3FJWjR5OUs5a3ZOY2dtallrbnh2?=
 =?utf-8?B?cmZmRUlYbVVhRS82V2k5MWhLTXJodVU1bG1Hd2lrSktwcGt5SjlhMHVCczVM?=
 =?utf-8?B?S1I4T1NpQ3BSNmpoeXhtYjlsUzFUZWlmYnZGcjcyb0NGZml2dU1vRERjaHNH?=
 =?utf-8?B?THFHTGlkTzBLV3FOSjkxc2lrRW1DTzBBNE0veXBOb3YyZmZmWHR3K0tsbW9p?=
 =?utf-8?B?a0d2aXJJUWNCSTA0MUI0YjB2dDV1aEFuZHVKOVV6dHhOZ0RVako2Z2V5QUdN?=
 =?utf-8?B?d1lLaEFDaHd5aTNNRVNtdThrUnhvN2lSTFBiaktxK2YvMVQxTkdiSkE0SjNp?=
 =?utf-8?Q?l9RiXJmYt8OV8HBc=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NrnTO4ClW/WUmj1g6RKMSR3Zcurh7CEyH4iQz5OznI/iRnNDpFqUSOhzIL2Nb1RlKognzR+7/N3JZ+kHFyPW/Qwg06OdHc3rT+24VCXD6k82PYqp6FVGjV/LWaMz9rvMb8VkCZOVjkudR7ue9ALY2plFFn54U2Ug0Tqt8OyAOa02dYLl85khWycx97ApcJeYpJnH7WRDw+yIvO8GsXVW04x+YscwosTGSZEpxHxcWeKgVw6JTGCUGBC8o3KBm/QcxTWGpt0WDn6oWTO6xbLYBkK8+uvyPjIdnRL9D4vwiFYG8l4zscxhpPJph2y3aENsPrdsMjOwCAvvGtPE1h07YA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4048293-ee99-4643-1789-08ded01d19e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 05:14:14.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WeGzE/OfedC9ZkrbatVaOBtUeGCrT0kOnLV+T+N8Bap4V6N7V30MSlYpu2jF6XTR+56VoN/12qyPuH8NrTi6XjKSCY4knyTOuTnb/IwMEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR02MB10184
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UjoXDgQq6rsyfG7cdlmCpilQzOZaLhxdEGjShuplKOU_1782105256
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300958-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,CYYPR02MB9828.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30C096ACB36

PiANCj4gQUkgcmV2aWV3IGJvdCBTYXNoaWtvIHN1Z2dlc3RlZCBvbmUgcG90ZW50aWFsIGlzc3Vl
IHdoZXJlIHNrYiBwb2ludGVycyBhcmVuJ3QgcHJvdGVjdGVkLg0KPiBCdXQgdGhvc2UNCj4gY29u
Y2VybnMgYXJlIGluIHRyYW5zbWl0IHBhdGguIFRoaXMgY3Jhc2ggc2VlbXMgdG8gYmUgaW4gcmVj
ZWl2ZSBwYXRoLiBJZiB5b3UgdGhpbmsgdGhhdA0KPiBtaWdodCBoZWxwLA0KPiBJIGNhbiBnZW5l
cmF0ZSBhIHBhdGNoIGZvciB0aGF0Lg0KDQoNClBhcnRoaWJhbiwNCg0KSSBqdXN0IHN1Ym1pdHRl
ZCBhIHBhdGNoIGZvciAibmV0IiB0cmVlLiBJIHdhcyBhYmxlIHRvIHNlZSBvbmUgY3Jhc2ggdGhv
dWdoLiBDcmFzaCBzaWduYXR1cmUNCndhcyBkaWZmZXJlbnQgZnJvbSB5b3Vycy4gQXMgSSByZW1l
bWJlciwgeW91cnMgaXMgTlVMTCBwb2ludGVyIGFjY2Vzcy4gTWluZSB3YXMgZHVlIHRvIA0KdHJ5
aW5nIHRvIHBsYWNlIHRoZSBkYXRhIGJleW9uZCB0aGUgImVuZCIgcG9pbnQuDQoNCkFueXdheSwg
aWYgeW91IGhhdmUgdGltZSB0byBzcGFyZSBhbmQgd2FudCB0byB0cnkgYW5kIHNlZSBpZiBpdCBm
aXhlcyB5b3VyIGNyYXNoLCBJIHdvdWxkIGFwcHJlY2lhdGUgDQp0aGUgZmVlZGJhY2suLg0KDQpo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL2xpc3QvP3Nlcmll
cz0xMTE0NDk1DQoNCj4gDQo+IFdoYXQgZG8geW91IHN1Z2dlc3Q/IFNpbmNlIHlvdSBhcmUgYWJs
ZSB0byBzZWUgdGhlIGNyYXNoLCB3b3VsZCB5b3UgaGF2ZSB0aW1lIHRvDQo+IGludmVzdGlnYXRl
Pw0KPiANCj4gU2luY2VyZWx5DQo+IFNlbHZhDQo=


