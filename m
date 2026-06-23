Return-Path: <netdev+bounces-301263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /rLHES4eOmr11gcAu9opvQ
	(envelope-from <netdev+bounces-301263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 07:48:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A59F6B43FF
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 07:48:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=aM9jQqZl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301263-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301263-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B73B303D332
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 05:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DAA3A9616;
	Tue, 23 Jun 2026 05:48:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5350B369D65
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 05:48:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782193705; cv=none; b=DN3iW/bvT494abIiqY4gLvqh5TFc6uvYk98tZbWhCFwSijLI2s2YDnbYSxjrwglhxI0uje/pIhkAC+dXvVbmgiyaTo9t01bYP5CUjVddTU/SlrUJtYSzGbHsYaLAcqAExpURHEkqpBBrLkriM/YXyLP/KlJv9q5FQBxEQpPdV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782193705; c=relaxed/simple;
	bh=Ahqpoz09mO7HrQKC+1MK+E4Ir9NkPYkwg3eGODfCaO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VabM1casXIaGIIySxpeoxIh2B4MiXTNZhB7ZzVXh8qiLJ1t/eKRZqre44rGvW2WMeVDWKRfviEL9QVRlbenMegpRO3bTQ5fuZqrW/GpSsVNjLsXnnYLA/kOTdAn+V3C2ddO6/Q305hM3OBRKCBWa/KEz4kqnRTbowVHbOxaEJEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=aM9jQqZl; arc=none smtp.client-ip=170.10.151.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782193698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ahqpoz09mO7HrQKC+1MK+E4Ir9NkPYkwg3eGODfCaO0=;
	b=aM9jQqZl4bipkpbaSo8WczHYHtZZQJGAE9hht81gFfYMz+0xb7aCE3302YWnDhPep9d1pL
	XrtUkf9WqkUHVD3UcJiQRIEjworqDBmP2kNF6QRFZhmjcDmNwALlDQlIVT3ISU7HHk+MOT
	QwKswr0iqf7vRDCZxjBZOBhyU2wBk2sZ6PS0Hvg76NFcj7kEvOgcPZHpbNyOLDKWVP9BpW
	+LYR7C3MzmO85OYRWYKXHyQsoVQAObIfz1skd4zCXg2UpsIN6JViG2mdygVLE21vZAyUUN
	jhRgjqjuYpYWLaULKPAZwDqrWxlfyLevKOXuNk0goKVVDwwY+lril6oMY3yjiQ==
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-55-lgPmqTCLO-SqxrIGGBGOdA-1; Mon,
 22 Jun 2026 22:48:15 -0700
X-MC-Unique: lgPmqTCLO-SqxrIGGBGOdA-1
X-Mimecast-MFC-AGG-ID: lgPmqTCLO-SqxrIGGBGOdA_1782193693
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by CH0PR02MB8120.namprd02.prod.outlook.com (2603:10b6:610:10d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Tue, 23 Jun
 2026 05:48:12 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 05:48:04 +0000
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
Thread-Index: AQHc+e0nFxx0u09WdkC+bo9XNPrS8rZAt0OAgAMGobCABlg+EIABlccAgAAFtTA=
Date: Tue, 23 Jun 2026 05:48:04 +0000
Message-ID: <CYYPR02MB9828E1167750AEA090EC60CD83EE2@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
 <20260611-level-trigger-v5-1-4533a9e85ce2@onsemi.com>
 <7c89df6b-32ac-46c8-8400-945879037f2e@microchip.com>
 <CYYPR02MB9828CD98EEEB9B218A940E4483E32@CYYPR02MB9828.namprd02.prod.outlook.com>
 <CYYPR02MB9828A1434E6339A6CFCCA74283EF2@CYYPR02MB9828.namprd02.prod.outlook.com>
 <64f4f30e-a987-4289-b36a-1acc977a6764@microchip.com>
In-Reply-To: <64f4f30e-a987-4289-b36a-1acc977a6764@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|CH0PR02MB8120:EE_
x-ms-office365-filtering-correlation-id: 26108cd1-4005-43d0-8c47-08ded0eafec1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|56012099006|6133799003|11063799006|18002099003|22082099003|4143699003|921020|38070700021
x-microsoft-antispam-message-info: 5PqsQnD0s2X/dGJ0J5l4mjfpGQkNGSF5ByUaFY7r9qqmBW5eKKxuyqB59M6+D2RPakGLqd7QOrrNrMkPN04rfqkRb2k1jdK864sapU8qItrPi2s9ceUJdlEhW7pxZG7Ld0imNGSE4qT4CD2vBO9zAWB/6xl9iTsnPXrs9yMVQM29Ta23JknidJOqZ4Ijqv62S7rFnCd14Um/pG1fbeLz7FUjpJaT+wiLnxzJZ0X8nedpGVIOIhzCBFzeDG0d7Llf7+bXIrru23HCjcmdLG5tiQu1FZcqnl1QRRQfq6edwzfRv115FLxPGuiQClVyRIJ/YjW0Oj0oRHFrzHcBeK+ABFrRJFiNHSy1fBw/m9VJ4J2CFCkdqI9h+xqqQ8ELMlUeEbWULTKNKSx30ZM+7WsIhV19ZvPvgY52xb1jPdR+aDB1s/bVwdm05SHqzMT8JlYUKrt1iYXNvhxhy/uDRCfqpduP5NSBPj70O1Na6oBSTaQOhZ/HhGACKFrG13uYyL1WUVFpug8Iw9pK1v4w1MOACoRQpaTfN8LCXDs1Q6Yo7LNQ4ImNwbGGZ/VLSL9or0uXpFcjMKR4py/0hi2wiWLghhieUK/Xcog11rf5ztfa9a/ozT+sZFy5JV9JRXm8QuupDWmsE7SbsOupLomwBAN619jenGmTHJq/vnbfiaTLTSXntaxx0xzMais7u4/Ad5jyP7w+bxEQS8oH+ezKai6sYr269XXzgn/rDlzytaGKqftfujAjA6eKYs+NDCluySga
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003)(4143699003)(921020)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTBFMnlTRFJ0SDY3WkJpNDBPbk5WenNHdlE3YkkvWjhQQnA0WTBnMHdlT2h4?=
 =?utf-8?B?dFppZmlXVllwejZRMDV2YTdvSW9LVGFGeVNxWE5xdkpXVUpvWW1VTzZTWnp2?=
 =?utf-8?B?ME1xcndLcGVoK2tXRy9hS2h1elBudGt5TFRKL2R0a3k5YXdjWEZpWDN0d2dj?=
 =?utf-8?B?Sjk4WFdHME1LNWZTNTFXeUFCa240YkFaNUh1SVdmaVFTaSswOHVaaFh0Ni92?=
 =?utf-8?B?WmZXWWNKTDV2TUpybTNRQXYxYndrZDZjbHEwUkhrdEhGS25CRXMrYjFkV2lm?=
 =?utf-8?B?c3J5dTFmcUg1K2dDdXhOa2M2S05jZ2FHdm9ML1BQcUN1V0FuWGFZa0Y4RExM?=
 =?utf-8?B?dG1IMFVqNG5zMVYwM1FGbFg1WjBlUVdtOERETTNSQ0FkTitseXMwckppYndm?=
 =?utf-8?B?Y2xlK21BOGFKZ2NKbWdpYm50NmhENUdaODZmYi9lRDBhQjd5ZnRnaFRIVFlJ?=
 =?utf-8?B?Ykt5QS9TOXRHMWJHQjB0T0FFcDk0ajZ4aURiL1ZCam1hTkxKVm1pdEp4TkxK?=
 =?utf-8?B?blN2OGQwOG1qdDk0ZFFsZU9lRHBZTVR0dVQzQi9nWVZKcFc4UlhXK0xER044?=
 =?utf-8?B?ZjNFVkNFSWlSa3VKNVdvVEFrQ0QzVy9ZMjArNldrOWR0NENDOHQycEJCNGVu?=
 =?utf-8?B?RGcyV1hldEJqUXMzVzBaYXRUUHQ0Ym1GQ3VMVUI2R1JMQThUQnNIMWphY1lD?=
 =?utf-8?B?anVYTFF4c0J5dWx1RnlSYmZaNStHdFU4UXJGbXVmMko3TXAzS2FWODhzUTNn?=
 =?utf-8?B?YzNKQVVBbzhTdk50eFNwYXRQWHFWRHpiYTlyRW42SitTMzFIT3JOVTFEazlz?=
 =?utf-8?B?OVZqUUdudGZzNXhBU2dWSUxmZ2ZLMXFmZDZtc2gwS3Y5NjlPZHhSMjFTS3k3?=
 =?utf-8?B?eFBSTmU4TGhXZlIzdHJZSlJvQlJhTVk2V0J4WWZTTWI5U3JMVS9TbXpjdWhp?=
 =?utf-8?B?cy9DSEpzdHlLSytMSEkwQmRpOGVyRUZHTk4yL2taSTBCMjRzUjRFcTI5eXdm?=
 =?utf-8?B?VzBhTGFJM3pWVjZ4MnB6czJ3c0tHZmFWM1QrTS9OMk9SOERyak5JQlZkaEUx?=
 =?utf-8?B?Zk9mRnVTYmhwWExxOWNWWnFLbmpCeXZodTQ5TVozM1ExTjd3RjFuYkVTK1pt?=
 =?utf-8?B?bGNVVkUvS0FZK25xY3hxb3BHNFdxNVRqSHB3cE02Rk4yckNJbjVYbDBXRW1C?=
 =?utf-8?B?dktvVWpGVkF5VGNCVVI3aldrblNLS3VmMjUrSlJTd1hUbld4UHdDYjhYeCtC?=
 =?utf-8?B?T3NUcGczOXBtMHI1VkI0NWpBVXNPZ2VMRkhqbnZIQWI0V3gwQWdkY25yODV3?=
 =?utf-8?B?ZGUySTN4SS9GL0ZVT05iT2ZvS2JXaVJUMVlVWmc5aW0wWVpPR08welJzQ0sz?=
 =?utf-8?B?ZVVPdTdHc3g1VzVxUVcybXlkbTcwTDNJb3g3bDdTa2tYYnphUm8zKzB5WDRS?=
 =?utf-8?B?SCtiOUdSdi9nVS9Wc2svc1QrcEJMWnhJL3FhZVNDQUM3Y0F5OUpicUJCWUY2?=
 =?utf-8?B?dkVDdHBUWk0rU1prZXFsOXpZUkRyaHFwaFdJS3NaOE8zTWs4OThqK21aMGh1?=
 =?utf-8?B?YS8ycU9PSWpwOGI4cEhBQTRZY2YxN0l5OGlxVkU2VWxiMmRKRjZKcEFtNS9P?=
 =?utf-8?B?YWZNOHFzUnZaREpSMVMyT1hveS9EUk00UDBlVWFqTlpPQis4NThSTkpNa3pN?=
 =?utf-8?B?bVNUSkg5MkpHTUNVQWFMdWsvUm80WnRkVXBFK3BNK29hbC9jV2Q1WG1uV0J2?=
 =?utf-8?B?TkNkcXlxdFgwU2VEb3d4QTBCWm1NTzN1Y3VtT0xKbExQc1pzS0Zqb3NDUXlH?=
 =?utf-8?B?cVFFYVQ4UjVuOG9ZaERaOVlqWDc5dnc4TTNpL1ZkNVdRd00zcDN0UnIySjdS?=
 =?utf-8?B?VUp4S0pyamp6VkVXeU9UYytQMnJKdVpxSDAyZTdVS3VZNitOQlM4b3E3TGlL?=
 =?utf-8?B?L1lmV1NCVWlGSTRrWDEyT3lBc2hkZlcyMjJrSG9SWWRpZXY2RzlNK01vTG45?=
 =?utf-8?B?L2lBejQvcDFaeXpiK3gybHlTc1VuaVVocGJaMWhjZHBQSnFjMWx1UitaSmkr?=
 =?utf-8?B?YWt0bzdVNGxqV080UUEvcnp3bEhPcHd2ZHA1amo4TVRLRXNpcjNTM0VmSlA2?=
 =?utf-8?B?NUNJZnNaS2pCeWZ2ODBjeGJ5SW45aHNqUTd2QzVDUFR5Z2FuMVlyeUFoTkxq?=
 =?utf-8?B?RWZhaGdyeGM5TWswMmlQSHRVRnJHaWhDZDMwY29QcWt3Y1JianFCUzU1K0pF?=
 =?utf-8?B?dlhTdTExYVlUWUdjYkttTVZ6SThQZXFydE96cTZRN1RPTmY2c05rRU80Ymhn?=
 =?utf-8?B?SE5GWlRjdWVIMTRDTVJnYWgwRHNvVFdNcFNvUUdrc2tKVjEyak90QmRLMDRU?=
 =?utf-8?Q?idVGu6oHJmVMeqgc=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LdB1HyHTjkRg+XKwkLHJwzhAPfow5x62V9WBuD/BT4ZH4+X/G65YYBkPXWlNjN0JOZT0wgP2J4pvdcyLs/QQbyzMwYJk69+D86NU8/QKq9o5rZYxfR0pae3OWtOHzCKfBQ+b5z3/34WpSxxbOa/gmsvBel8uHgWQzKMaFN8Bd6+4TD6LujTPwAL8fwn6ID48iIaxWCotD29+12jo+6tbgSBOW4ZzoKmG+BrYizh9Izp2kPneFq4p0uzYZuDwARwRmrTTodAZ0HoE0atFfbxsdjSfi/QSWwqM1vx1/As+RQypyVbI1v0pDTdnZkX+1QT0u8sFn4IRudHlgR/CIcIwHQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26108cd1-4005-43d0-8c47-08ded0eafec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 05:48:04.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExjckTN6tcZfXcSS5CPN8MIjRl2fR5mlNTCdl1gJ0DpMuV9yUr5Icjs4/hucOlvEuJaJpHdihg4BSEnK9E0AbeL0j3Xrbb7/V2TGDBwUlrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8120
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -U2kFAXdNVD7wQDjOh5j-H22AGKP-CmLT3snjiWFERI_1782193693
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301263-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A59F6B43FF

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhcnRoaWJhbi5WZWVyYXNv
b3JhbkBtaWNyb2NoaXAuY29tIDxQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQgdjUgMS80XSBuZXQ6IGV0aGVybmV0OiBvYV90YzY6
IEludGVycnVwdCBpcyBhY3RpdmUgbG93LCBsZXZlbA0KPiB0cmlnZ2VyZWQuDQo+IA0KPiANCj4g
SSB3aWxsIGZpbmQgc29tZSB0aW1lIHRoaXMgd2VlayB0byB0ZXN0IGFuZCBzaGFyZSBteSBmZWVk
YmFjay4gSW4gdGhlDQo+IG1lYW50aW1lLCB3b3VsZCBpdCBiZSBwb3NzaWJsZSBmb3IgeW91IHRv
IHRlc3QgdXNpbmcgdHdvIGluc3RhbmNlcyAoVGVzdA0KPiBDYXNlIDIpPyBJIGRpZCBub3QgZW5j
b3VudGVyIG1hbnkgaXNzdWVzIHdoZW4gdGVzdGluZyB3aXRoIGEgc2luZ2xlDQo+IGluc3RhbmNl
Lg0KPiANCj4gSSBiZWxpZXZlIHRoYXQgdGVzdGluZyB3aXRoIHR3byBpbnN0YW5jZXMgaW5jcmVh
c2VzIHRoZSBsaWtlbGlob29kIG9mDQo+IHJlcHJvZHVjaW5nIHRoZSBpc3N1ZSBpbiB5b3VyIHNl
dHVwIGFzIHdlbGwuDQoNClBhcnRoaWJhbiwNCg0KVGhhbmtzLg0KDQpPdXIgRVZCIGRlc2lnbiBh
bGxvd3Mgb25seSBvbmUgYm9hcmQgdG8gYmUgY29ubmVjdGVkIHRvIG9uZSBSYXNwYmVycnkgUGku
IA0KU28sIEkgZG9uJ3QgdGhpbmsgSSBjYW4gaGF2ZSBhIHNldHVwIGxpa2UgeW91cnMuIFdlIGRp
ZCB0ZXN0IHdpdGggdGhyZWUgUmFzcGJlcnJ5IFBpIGJvYXJkcyB3aXRoIA0KbXVsdGktZHJvcCBj
b25uZWN0aW9uLiBDb3VsZG4ndCBzZWUgeW91ciAiTlVMTCBwb2ludGVyIiBjcmFzaC4gV2lsbCBr
ZWVwIHRyeWluZyB0aG91Z2guDQoNCkJ1dCBJIGNvdWxkIHNlZSBhc3NlcnQgaW4gc2tiX3B1dCBp
bW1lZGlhdGVseSBxdWlja2x5Lg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IFBhcnRoaWJhbiBW
DQo+ID4NCj4gPj4NCg0K


