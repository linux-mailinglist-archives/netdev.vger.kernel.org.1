Return-Path: <netdev+bounces-286953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOpSCS6zAmpvvwEAu9opvQ
	(envelope-from <netdev+bounces-286953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:57:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7274519B1C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EEBD3028C14
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF97330662;
	Tue, 12 May 2026 04:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="i05dvhn/"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A90304BCB
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561833; cv=none; b=QbSZ5XDvTM+3D8+DHfkzM0/NZlRuDPpt8g3HPlhNq6Kxz8ZUzdLRSvOL7OQnIu0Em2XGzu7bLaOYUq1zsG3mn1KWRuPgKazIn64HNj9dRVe5whkFvICHfOHEnCJMdKmOjhqzhC/diO4NtLvJBYr/32XMLhXNiuDUUveGlq/h094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561833; c=relaxed/simple;
	bh=NT1WKO/n6l7HR4rM82f1x8QBG12cuSvIihVaaekvfNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=cU9ck3EX48dgwWlfFMyhIXnOmnVVuWiMJwa59A2/JVqz++Ucdr5oWmqoAZwWDQv/C2EUMRg9ktLMd0RXgg66QosrdeYjuqCEx9NsXcGgEP56H9DJjAD02I4w3hqynbH+88esH8yed/Xoia0eTN+UFT+n7K7Iszx0/ydBJ9BigUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=i05dvhn/; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778561830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NT1WKO/n6l7HR4rM82f1x8QBG12cuSvIihVaaekvfNg=;
	b=i05dvhn/yB67+zE6/oLL0r+0UaRoUAenb+tkfnsJJXLi+U4Ho4agVieQq1yYLbJbMFIbp/
	s/B4CWnBamQK2qFXejkGC4UrOAVukuBMRApC1kvBY6eieuwqbHS+tGJZ1ciowhhuAEuOv2
	0xTOQ3tsCcqZgTbqg+5qebo+/t2EmykbUfgv3TReIIHBbXEejJMk4cVizpB5QNGXLIZ9Bm
	xW5wMjdLYJ+ITwQejNPhyzcmULsUzaIRkfZ5mfu5F6OoAq2yUyHz8eOnTkmYl3468CgeXS
	tdG3KlRUOyVsUk+SV5iSOTi9Ol6PZ3aTl0SYdW7Fg5DZSiH4BEi+6HWOOM98fw==
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-23-RejURG9wN7CIYGElltqLLg-1; Mon,
 11 May 2026 21:57:06 -0700
X-MC-Unique: RejURG9wN7CIYGElltqLLg-1
X-Mimecast-MFC-AGG-ID: RejURG9wN7CIYGElltqLLg_1778561823
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DS0PR02MB10736.namprd02.prod.outlook.com (2603:10b6:8:1f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 04:57:02 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 04:57:01 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 5/9] net: ethernet: oa_tc6: Adding vendor
 specific MMS
Thread-Topic: [PATCH net-next v2 5/9] net: ethernet: oa_tc6: Adding vendor
 specific MMS
Thread-Index: AdzhcQEsu1akVKsfT+6eMGz6knnw5gADF/mAABOCMSA=
Date: Tue, 12 May 2026 04:57:01 +0000
Message-ID: <CY8PR02MB92490ED7D572EB0C124E4C1F83392@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB924967FCDC5FE1A541D4DDC683382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <066bf036-715c-45d3-a817-f2719eb5d9d6@lunn.ch>
In-Reply-To: <066bf036-715c-45d3-a817-f2719eb5d9d6@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DS0PR02MB10736:EE_
x-ms-office365-filtering-correlation-id: 1042e6ba-ac07-45d9-2932-08deafe2e7a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|11063799003|56012099003|18002099003
x-microsoft-antispam-message-info: +rdiM44U8tpl+wb9BO9a/zbPkrW2yCgVQUvrqcD2Xov2PYiaYf+QdHWCtwO9tJx1h9ShF/Boe23EJbqTH70zBI07XjsikBmLfQsW0Ks/AFK6+3kb5VOACUiJAXwUiOz8SbTIboZNqM5C3ihp5MpGSIi38gON99vSeaZntBkm8TlrPYzwa0nlctct/W6BNxISp4DC+xVDKrvuIA32uPW6mtNjnoPnUS26jw3K2Q/e0zPWQ5A7dPVmoF1CwrZmZSWMIFzfRhLga7SbclSX89LQnCIMFk6r29lzC0s/S8/1YrJ8QBeTI8bnHj9z1CIcloETbH2vUheR+RtelddU9yg+7dPCunXIHVdNy30HUpfWBKRbWioEIwUKNgVwN167sBfIjbktrnhL3h+8akiROjDi3ZoDOBP6xLdAVLjbdZjjMu0ZbyfmXdsJj36Cqhmqy47KmCC50ne2TbCSPBVvWUnDQoXphI+lBUBZjxy2KVL/7vqJHdczTrDiNaXrGjzYHFlS2S3gZi10FEobYtRkdXDMoecIRsRJd1054Rnda4A4R0PXbdnUudLyI/my1/Ht8So225oqwcw/vRtSTouq1wjAarEIp5wiJ8OSEZSgIqPC+br21VjOCOZndgo27iek3+TpqcFJhlVd5SVfXMVr3VhmK0EVmWGe/gG4lqQoUpOvNtj9lNKTPXNIhCBky6XfuGaQMZQ30Sah5iIbHy87mi4w2SFpwL6Kq/PLaG3mnZeV3ETOYiFsLmidYgNeQGygKIOE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(11063799003)(56012099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWdtS3JLUk1jY2Rpa2hPNnEwNFFpTFFqYnQ4blhnVTcySmd2c1FuWGlQTERn?=
 =?utf-8?B?T1JzdVBHanNtekxVNUhrZzJiR25jZmFCSStxVVllT25iQnU0MnFEVzdQQmdV?=
 =?utf-8?B?M25VblRvYVZPYU5kQi96bnJVTXhYNHpYRW8zMFFoOWVKY2szKzdwdFFZRnlz?=
 =?utf-8?B?QjNxdXZaVDY5V1ZXcDE3dE9pOU8xTmNpbHBaM0VHNTBqSlBFaXhHRTMzY2NK?=
 =?utf-8?B?MWt5UDNrRWRHSFhXQk5pL1JQN0YrUmF0cm9ZZzZWb25odEVOSGZvWnYwaHN4?=
 =?utf-8?B?V2VJdncycTcxaDR0eEdqOVNhZVg0YVZWcGh6NFh4VUFEa0k5UUFYaWU4clpJ?=
 =?utf-8?B?MGRGOGl5WURtVk5wYnRMUThIK2pTanFqWVEwL1ZQeGkzcFZreUg1SGkrOFpB?=
 =?utf-8?B?VTFKckMyUFBtVWlkSEp5NFo0L3BJclJmeDducXdWV0NuZzVZR0kzUlBReTNx?=
 =?utf-8?B?V0ZhRkFabU9qYmhyQlhvUnp1eDdBQjNoMG9mMm14WndWaXVsWDVBU1lkSVhO?=
 =?utf-8?B?cm9HcGN3RDU4S01XQTdibmNxbUd1TTBQbENYNHlHMzN3RW1QczN5ZkhCcE9M?=
 =?utf-8?B?djd4YlkyOFdSU2ZDNlRsMUNwRU56NUZhRjh0TlRhSW0vcjlJRlJNTCtjRXEw?=
 =?utf-8?B?Tm1kaUFOVkZ0KzQzUkEyYjZTOXV0eis5RitUQnhWVXJPRVNnbHpoNUNiNmxR?=
 =?utf-8?B?M0w3T3hwVEhCU213Wlg0TGJOeFZaR1NjSGVFQThya0l3ZW9BZnVwbEVKVGt3?=
 =?utf-8?B?dzF2bHB1TEUxQ2dtcWwzWmV0eGNUYlhNdGphSTdMTkJCeEhVT3BsT1o1eWZR?=
 =?utf-8?B?amhoQ1hodm95SXJFSytEL3k2ZW11WEgyVGZtUVlnd1Z5SEZWVklLQk8va3I3?=
 =?utf-8?B?ZGl0WER0WDlNK2NaRTh1NHRQb2ZDZk0zOC9BM3Jpd2dxRFlTbktwRENUZEc3?=
 =?utf-8?B?SjkvQm0zZklQMmJJU3FJSExTU0xkOGlDVVc2dnlGdUpQVjVGRHp1cUZIS25n?=
 =?utf-8?B?dlJLR2RwWDE3eUNGdHlHT1FyS1cxSTNrMnlodFVMeWNObDFCM002ZXNNYTBC?=
 =?utf-8?B?RjRhRkFvdS9acHRGVWpmTDNRRVBLWHJVczN4RHZOcitwa1A4WCtwUjJnblN5?=
 =?utf-8?B?RjJKV1RqR2J0azhaYTVvVkNkdUxQNVl5N3pTdEtWZmF5WllJbTNqQlpkTURp?=
 =?utf-8?B?VHBNZFVzZ1JyY2VwTVZJaXpGQzQ3b3grUnp6b2hwcFczZ2c4SEVUT2J6UkZL?=
 =?utf-8?B?amdyemNpSDRhOTRZS1R0dlhUOVVmZVRwT3R2MnNORmJ4aUZEc1A1Q2o4QXhY?=
 =?utf-8?B?R0pHcnVsSVd2ekZPZW01c3h0ZkcrbmZLOHVBV3d6VEx3ZDNWbGNwV0oyR0JT?=
 =?utf-8?B?dnNacU1MUUhCL2k0cnJqcncwbWpSV2ZhVE1ZYXRidm1NYlJCUGVId0xMYXBn?=
 =?utf-8?B?ZUhad1h1V3dsRW9mYzFsMStzUUY4Mm9EZy8rRkZsS2hLTGJUOHh6MDBHS0Nh?=
 =?utf-8?B?OE1MR1R3ZnNVek5qOUxlT1ZEMW9hU2VaUkJXQTNWL1U2K05BakFoVDVxclNo?=
 =?utf-8?B?dVFHS0QrVzJJTTJ2YU1FVzhoaVd1M3RSN1lTeU5MeVBCcFdBWUEvOG4rZUdx?=
 =?utf-8?B?d3FjMzR5Nnh2SE91dUxReXFFSldpcUtnQzF2UkdpZ2FOUFBtL3JDYXRNQVE4?=
 =?utf-8?B?NHRTS2ZmUkZVa1Rqc3o1ZEw2ajVOTThkeFFSQnVQRUI4b0tvU1JQdlFXUmxB?=
 =?utf-8?B?MXVEVFp2cWpscnNxdk16TFovNEhDOXgvQmN1bWxjaHA0MWVYMVFRMkV2NFN3?=
 =?utf-8?B?Mk5iZFlvNmVyYU9qb21LOUszU1NHUHVnK3hvTDh6am0rRGtGTHVOanROejFQ?=
 =?utf-8?B?bnI5NWExWDJnRyswY3RlNzYxYzFyTkUva3F4aUpmbXJ4VDArVU9UZklUT3oz?=
 =?utf-8?B?TnN5andyem5yenlLSkJLdmc1MFJtcHRmdW5ISHUrVi9ZNm5XT1lRL01ib3oz?=
 =?utf-8?B?S2pmd3ZZbXowc050SWRqS2k1bkF5UHAzMXdXZUljcW5naHhpSDh2NXVyV0F6?=
 =?utf-8?B?R284V0JsT0VKUFFCSnV1dlZBWE5PQmFhZXlqUlI0M0dmc0hKTk5MQVp5R0NN?=
 =?utf-8?B?L2QvMjF1WER5bVN3eStzdzNWTE9pZk5hSHR1MFVzVmZVYllackM4M3lySWFH?=
 =?utf-8?B?MzF2L0dkOUFVazZJOGxCRVBlQTVkcndmcTdIVnRTMnBsbzZwaU16WXhGaWIx?=
 =?utf-8?B?SXU1QzR0ZkhWWEZVWU1Sd2ZsajNGdDQyWkdld0RHVG1KQXlGUlZrK0lwRUI4?=
 =?utf-8?B?VWs4aUhLc0ZIZnp3TFNjMXRwYXFMWmhFSFNrbDYvdWRnVzlxTDlXM2lIa3hq?=
 =?utf-8?Q?4dCMhDebDk1jUpsE=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Oy1W5FW4Pxq07kjPcpPFB1T15TX9PsfzRMjkzBMCgPbSf9vDdAVj4mMFlWETOTWePrPExEfHXyHjFIR9iOyWD7MnfDj/1MOaMo9JerEaVEBZtkfMAiLFLih3iBC4DH2mCyRUrpUnyfRe1LjBvSyPvEjCvpgMy6U1NSsRxAmhmXf8rFFV7HvZ+B9bfbE0QqBqd6pheomGQdBmgC1BRC9mMRTziMA5fiJPEISKxh0bGrZZ+rdR6B0miIs6yRSnQd08j4crhEi259z2+uowXtsmehW6s+T9tfqWvPflINwsa/YawYO2/4njyiKjPo5lqePpo5hsIn77YtpT53z3CH4jIQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1042e6ba-ac07-45d9-2932-08deafe2e7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 04:57:01.6482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7KLwF9lyAuI6Jqt01hDEc1Sq6csdgjfm0Q7RrElwLzdIddeSKql1MGA9ViIsHGpzXis7YZ84DWUriRYCKrye91lSOXcg0HetAe5q38xoH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10736
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E0_TRMfqOfjsjA6cUCIMVLJBmUTOwrOgwi-F0jffdRA_1778561823
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: A7274519B1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286953-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,onsemi.com:dkim,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Action: no action

Wy4uXQ0KDQo+IA0KPiA+IC1zdGF0aWMgaW50IG9hX3RjNl9nZXRfcGh5X2M0NV9tbXMoaW50IGRl
dm51bSkNCj4gPiArc3RhdGljIGludCBvYV90YzZfZ2V0X3BoeV9jNDVfbW1zKHN0cnVjdCBvYV90
YzYgKnRjNiwgaW50IGRldm51bSkNCj4gPiB7DQo+ID4gc3dpdGNoIChkZXZudW0pIHsNCj4gPiBj
YXNlIE1ESU9fTU1EX1BDUzoNCj4gPiBAQCAtNDU2LDYgKzQ3MCw4IEBAIHN0YXRpYyBpbnQgb2Ff
dGM2X2dldF9waHlfYzQ1X21tcyhpbnQgZGV2bnVtKQ0KPiA+IHJldHVybiBPQV9UQzZfUEhZX0M0
NV9BVVRPX05FR19NTVM1Ow0KPiA+IGNhc2UgTURJT19NTURfUE9XRVJfVU5JVDoNCj4gPiByZXR1
cm4gT0FfVEM2X1BIWV9DNDVfUE9XRVJfVU5JVF9NTVM2Ow0KPiA+ICsgY2FzZSBNRElPX01NRF9W
RU5EMToNCj4gPiArIHJldHVybiB0YzYtPnZlbmQxX21tczsNCj4gDQo+IE1NUyAwIHdvdWxkIGJl
IGFnYWluc3QgdGhlIHNwZWNpZmljYXRpb24uIFNvIGkgd291bGQgZG8NCj4gDQo+IGNhc2UgTURJ
T19NTURfVkVORDE6DQo+IGlmICghdGM2LT52ZW5kMV9tbXMpDQo+IHJldHVybiAtRU9QTk9UU1VQ
UDsNCj4gcmV0dXJuIHRjNi0+dmVuZDFfbW1zOw0KPiANCj4gVGhhdCBzaG91bGQgY2F0Y2ggdXNl
cyBvZiBWRU5EMSB3aXRob3V0IGZpcnN0IGRlZmluaW5nIHRoZSBtYXBwaW5nIHRvDQo+IHRoZSBN
TVMuDQoNCg0KdmVuZDFfbW1zIGlzIGluaXRpYWxpemVkIHRvIC1FT1BOT1RTVVBQIGluIG9hX3Rj
Nl9pbml0LiBTbywgaXQgd29uJ3QgYmUgMCBieSBkZWZhdWx0Lg0KSG9wZWZ1bGx5IHRoaXMgaXMg
b2ssIHVubGVzcyB5b3Ugd2FudCB0byByZW1vdmUgaW5pdGlhbGl6aW5nIHdpdGggLUVPUE5PVFNV
UFAgYW5kIGFkZCB0aGUgY2hlY2sgeW91IG1lbnRpb25lZC4NCg0KPiANCj4gQW5kcmV3DQoNCg==


