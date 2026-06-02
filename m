Return-Path: <netdev+bounces-293976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UILpFtxDHmraiAkAu9opvQ
	(envelope-from <netdev+bounces-293976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:45:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F76275E2
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E0243010527
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A493624C9;
	Tue,  2 Jun 2026 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="KorIIDAf"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F72233B6D6
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368023; cv=none; b=eIVj6CTyMMfZ8IrmqqiuI5qHL63tnArQeKx9vim3Ec5ZTYMeWOruL8QfEV7X72QYKW4uBaGgIaks+IDNkUHLdVQa94/gIO643qHPM+kzbWnTticcYXtXbAMpvWVErmpBF3WSk4+F8Ems9EgfREJyID2yb4/9wngohISszaUc2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368023; c=relaxed/simple;
	bh=ONXZBgOhW2z9AFunjcqHKB+iWLh5dNluUB2miOmpO7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=gPGuHlJLDIE9lPQjsYJrY9XpEWxiyvde1PRtqPwzqnZoyVykxBqjaOHJfZFFwE0CaQytpPXbO2UXIznEyyqGhQB5TMnlCQCWA/yxW+o7YyjPsVxvzxKbYT80/Clx1G4kWgywiKjhIHWs96sOPIfx61j1S+flMsfWa21ZbiJEk+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=KorIIDAf; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780368022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONXZBgOhW2z9AFunjcqHKB+iWLh5dNluUB2miOmpO7w=;
	b=KorIIDAfgrI3eBty/k0LH/jR4JaWk7rbQpBoUuXZ23MsGbN4Yg56quO6F9oW3CSkisYs3g
	jFHQWd3iZubklpNthlBYA8qvhLP4Atv/5oYlwdbTve3MaEF31JefwWGVo8sIwwHRVqc09l
	P4al+fuSvVpPxoKwwH91j1SghDw+VldOFDyngGhViL6AkUmi4wmMcHxvKHYkLLEOiuR8ml
	njT3Zs5sC6tQp4OvnEtA/4jnMGvr67hnE0lFwYMykPRp3dZoEfG3PLBtWCXNBVpMSPjS53
	MtS3nTMzSGAihdpmUtIQa/csPTgIL1C7ia/6UiqZwf3kND/KizoPX6rxUk78Nw==
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-76-GF5CraJBND6KkOfy4QPnwA-1; Mon,
 01 Jun 2026 19:40:18 -0700
X-MC-Unique: GF5CraJBND6KkOfy4QPnwA-1
X-Mimecast-MFC-AGG-ID: GF5CraJBND6KkOfy4QPnwA_1780368015
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DM8PR02MB8005.namprd02.prod.outlook.com (2603:10b6:8:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 02:40:13 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 02:40:13 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
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
Thread-Index: AdzvmRIV9Yc6XZqaQq2ja4j42ca11ABc8QiAAErSfpA=
Date: Tue, 2 Jun 2026 02:40:13 +0000
Message-ID: <CY8PR02MB92495E274D4194CF06B1048783122@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <cf87ad90-6ba4-4132-a1eb-beedd796c168@lunn.ch>
In-Reply-To: <cf87ad90-6ba4-4132-a1eb-beedd796c168@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DM8PR02MB8005:EE_
x-ms-office365-filtering-correlation-id: 9d8e5f12-7c3a-4483-535b-08dec05045fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099006|4143699003|5023799004|11063799006
x-microsoft-antispam-message-info: NT41K1tuRleHcSYz/gKf5mtQRHc/Hn1oOb0zimYBZNb581TbCPrW0H37pOzBJ+UPgMud16HmeHBBTCxAMqRosqbxUJg+5SxVxrxPqMfS1qvlrof4VmJtB60kfrfZws17QuVRjaf9qf5Mo+ymf2Wq3Cdbd3KfGLciEga/0XQgW6bcKanknoWiHRuPi/b40m3XcpqAQPrNG7FEl+2jhvnJS/RNOuTAfBBsvnuUopStcD48G3MRoymVeQVkNbOA6N9kjO37UtDCh+RWt0bEe5+ML9wc43Rh0XQag9Bm1fMbSlyarTg46fcb5LCVk072UT6sBVrQLtoJJ6D0LH2nlB8rKkNSc+MhvwRB07pU6l/LYijRCUpddntciheytEZY/Vihala3ueUHEBiV6GLPl6k9+PpSrCM3H2hodxi5dAHv/d191dmAPSF3CHt0vEvJTjJnWerMIoyUWhz2hycWnT65q4lPx2zN4vXF+epv91+/Rn910pE63FwrDJJ7T4ItxAuMu83bO13RCr4fno3QgKUlJUVJyI0STA9k9OkGS8G3MrA2a2LgQ17AjTuHoVOCOYczX2fCgSgPAucpwWnj5qxiCaEeb1x9E/D2PabIA5q8A0mGGqI/BtyNM+udctQXRz4S38fWneEqpwWpgK3W6UJKyLMm97++cYVdbjZS26vVjGyV3QAlt3YrUBsWyUsRZxUiSnIQeFlOH3zPSGsxNC854pX5j41wd64Sa5i3yve+avhANmh4xMqRZ9rbS9E9fMFE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlQvdlZ2dHJXWHRQM0Jnc1Q1d3JMTzRJS2ZDbSs3SmRqaDRJQWRYdC80QVlQ?=
 =?utf-8?B?dnlxTy9xZEI4Vk9iQ2VVUG0rdmU0Y3N6Wm9SV3Ntd1ljUTlBTHloSDF5Yyt1?=
 =?utf-8?B?SzhnU2syTWczSVNuRm1pZzB2OHpDTkxkNXhGV0ZCUlJJRnMyeFdBTy84VEY4?=
 =?utf-8?B?NDZRRHFwd1JZY2N1ZCttQzFwV1ZuVHNwenRJZ0NHZFlXY0NOTHk4bWRSbUQ5?=
 =?utf-8?B?VmNaSTdISWJPR09kS2dSN2RiS3E5WkRUMGxlZVhBTUhwZm9rVmZuV1Q3azM4?=
 =?utf-8?B?Z25XQ3gvNDlkWi9qQUY4dHF6MkhHbUdhY2o1dG1nUFpQcFgyNGoxWHRHeFBk?=
 =?utf-8?B?aHhNYVYrOHlkQVVCdzlVNzFJM3lZb2dtSTNMNmU3NDVreCtjZXEzY0JqbnZv?=
 =?utf-8?B?VlB3dHI5QmRSYjgxdWNwNjF2eEd3MnJNVUs2QXdsUjc1M2N3TjkyRFIwNzBZ?=
 =?utf-8?B?VGRjVTNTTjQrRWw2YjZlbVlqN3JIZjI4Z3JWQ09jUjV1akVndWZCWlBoT0xk?=
 =?utf-8?B?V1QxZnEvN3dIc0JEVjFvLzZ5TXhZd1ZpL0hqdjJQeHhVNXhDZ2NCc3p1aXdT?=
 =?utf-8?B?aTgvYy8vT3pxNklHOUxkalJvYkJCU1BNSEpaRHBoSDA2WUl0TStIZWZZUGpT?=
 =?utf-8?B?MGV5Y3BPcnBHTkZKR3oyUDNRYS81Zk52VXdrSUJiL2h0U3BMU2ZQbnhuRUZn?=
 =?utf-8?B?Yzgzd05QbjhVSk0xdGEyVnc2TEJ6bW1sYklaRDRkOXgwQ0hCWmUrY3IxQnU3?=
 =?utf-8?B?VWJ4UDdjNUdkYlM5RktrbFhNQUlxU3BtT2c2L0FEK2E0aTl2ZnIxN0djZFRW?=
 =?utf-8?B?SytvaEZvczA0KzNiM21meVZ6QWVmTWhHSWVXak9UaDdISVBWMVVIZFdmM2wy?=
 =?utf-8?B?Q1VVcnhiR3pFOTM0WnVzWG9VQ05Vc3pLZ1duNjN5OXNKT01UTGd2end6KzJi?=
 =?utf-8?B?YTZDLzFBejFvMUVIMTV3eGt0UWVveFIwb1NhckNRUnB2ZHRSTnFsa1hqOEZO?=
 =?utf-8?B?R1Nnb2FpNW4xR0d0dHZxbnRGeDdvbzZQYnJHREc1N1NvN2JpM0owd1RsY0xp?=
 =?utf-8?B?YjU0QlVKVVVkdWsyUUIxQWFQMVYwN2VxTnJ5aDJLd2lDRkpKUzEyWE01T3VK?=
 =?utf-8?B?VTh1ZUwwa1luUGc5b2NOZW15RHRVMGdkdHd6UWpNQ3lHUG0yc2daemo2UlZp?=
 =?utf-8?B?eUthYXpOdjdBdDVXSlNiWDluWURyb1UzSWw3MWJqdWtMQlNGQ01yTGNmemQ4?=
 =?utf-8?B?WlNacVFaWFVXNG1PLzZKS2M2aUN2QmJxZDFrUVBwdlpmVkhobm1NNE9lekcw?=
 =?utf-8?B?YWdkZy83ZEdMbEEyTWVab0FuZzQwSHc4eDIzVHpmRGM5djhaTWpmUFR6d1la?=
 =?utf-8?B?ZFM3RlBvOG83WUFtdVlpeUIxSTVQYTBkQ0I2OGU5OTh2WUtjZXdWcjlJbmho?=
 =?utf-8?B?aVJTR1dSazhoOVFlK21qQUU2c2NRRm9YdW9uUVJSMFBMYjdySUI3Tm5GNkpP?=
 =?utf-8?B?U00wMTVON1BMUWRpOFZZcFpFbThaMmx2K3lMdyttK3h6bmZaWkpiWkRRcFpy?=
 =?utf-8?B?cUVPVUJyNkVwVEJQTjYxUGJuRXBZUHVRMkVEN0lCQUpZUzZxMkJ0VWdjSXd0?=
 =?utf-8?B?Qk13Z2hEbU5ublVZVlZ6am53d1pRcjBaRDVxRkU1MFoxcEl1bXVCQXBZSkdr?=
 =?utf-8?B?a0JMbGlrWjJsaHQ2OUFrWGFVWGErOVFOR1ZNSEJCd3c1SEZLbXhseld3OFRq?=
 =?utf-8?B?U1NNTFQ5NzlSMkxTQzVnb3hkUmkzb3ZVcldsMUZwZmMzZ0ZsYlFuR0pUOEVy?=
 =?utf-8?B?UE5Eeitub3RsVlZQWFRYTmdVUnRDVnRlcTZGTFBoS3QzOWszNE1iZGhGNnNx?=
 =?utf-8?B?eVRhUnNudVJ5SEo5UjhONlZtTWZjcFRDczVrMURpWUQ4MlhIL0NXMyt0MTJs?=
 =?utf-8?B?MXByMXFQS1VRYnN3RUl0NXREM2IwZDh1Z3Mwc05pQ29ETUtGRDRqbm1nSmJB?=
 =?utf-8?B?T3BCTSt0UUxOU2RGYmtnUzZvOU1oby9RTk8wMDQ3RDVyOExKdlFhR1lrb1JW?=
 =?utf-8?B?bzJ6VkpPZ2JlbkIrVzFDMkVVSXgxYXpOekZrVko0WVZHNXozVHhybjFLbjRt?=
 =?utf-8?B?a1BsUjZSdDE3amp2akhoS2QyQ2pTaVZRUXJVTGpUcU1URlpacEEybGorMDhY?=
 =?utf-8?B?MVRrY2dwVjJnTEplaHVPNUowaVdxZ0E0SWdYTUpmR2ZRNHQ5WWxpdmhhc2pw?=
 =?utf-8?B?WmpudkhSZ0dYZVZyS0RXVnhJVjNrb3ZTWnUvYXdRVEZOYlJZeElvWlRXVVhk?=
 =?utf-8?B?S2hCOE0rOHRJNWRybGhOa2hFQlduc2N4Myt1ektDRGxZOE1aSHQ2a2IybmJy?=
 =?utf-8?Q?eo5/ScRdGLBqt7Ro=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fgh/j5Xv0Vx5zcnZAELz3tuuPo6nqfixKBGRvjurwfDXraeLUG/x3Icf1CIUINjDEj0MCqsNlLVDhLwwyvtr8mG1i5k00UWq89UBlPfFkEjFGMZ77+ZinWSkgPdjE+Rf+cxZ5+yW7FrjuCV8zNGFaSfHNZcWI/WrTLPXeGhpw7yaMpSo4xznUfg75W6TlC9Wf750bLpO7eFuDoLAktHqfPcLpMDTuk1UJhHaxltw8c9rm80iDdZZxkSqaa2HIM5XNjgjBsHX3naxu7YBiNYuGTVLWnM6K54UAL559aTeVnHP998ktEMBsANSsnbZvnWWmhX7WbI0FYremZQPj5ZKew==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8e5f12-7c3a-4483-535b-08dec05045fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 02:40:13.7034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpWllJv/73c0EV384THIRZo1ZjvGw2S/J02VylIw213ZQEJ0WxRmaXVJxW5KJBKzlzKIglaVxEzmmz2Ik85nojmgF/+cw/A9/4woAz4oeDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8005
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HKVqTEg5rmfwFVx_MpJ5ZGQKZBPIUsPGlKR5vRpKNns_1780368015
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293976-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,onsemi.com:dkim]
X-Rspamd-Queue-Id: B52F76275E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiANCj4gT24gRnJpLCBNYXkgMjksIDIwMjYgYXQgMDY6NDE6MDBQTSArMDAwMCwgU2VsdmFtYW5p
IFJhamFnb3BhbCB3cm90ZToNCj4gPiBXaGVuIE1BQy1QSFkgYXBwZW5kcyBGQ1MgdG8gdGhlIGlu
Y29taW5nIGZyYW1lLCBGQ1MsDQo+ID4gaXQgaXMgcmVtb3ZlZCBmcm9tIHRoZSBmcmFtZSBiZWZv
cmUgcGFzc2luZyBpdCB0byB0aGUgc3RhY2suDQo+IA0KPiBXaGF0IGlzIG1pc3NpbmcgZnJvbSB0
aGlzIGNvbW1pdCBtZXNzYWdlIGlzIGFuIGFuc3dlciB0byB0aGUgcXVlc3Rpb24NCj4gIldoeT8i
LiBEb2VzIHRoZSBzdGFjayBkbyBzb21ldGhpbmcgd3JvbmcgaWYgdGhlcmUgaXMgYSBGQ1MgYXQg
dGhlIGVuZA0KPiBvZiB0aGUgZnJhbWU/DQoNClRoYXQgd2FzIGEgbGl0dGxlIG15c3RlcnkgdG8g
bWUgYXMgd2VsbCB3aGVuIG91ciBTUUEgYWxlcnRlZCBtZSB3aXRoIHRoZSBpc3N1ZS4NCldoZW4g
SSB0ZXN0ZWQsIHBpbmcgd29ya2VkIGZpbmUgd2l0aG91dCBhbnkgaXNzdWUgZXZlbiB3aXRoIHRo
ZSBmcmFtZXMgd2l0aCBGQ1MgYXBwZW5kZWQuIA0KQnV0IHN0cmFuZ2VseSBwdHA0bCB1dGlsaXR5
IGZhaWxlZCB3aXRoIGludmFsaWQgZGF0YSBzaXplLiBPbmNlIHdlIHJlbW92ZWQgRkNTLCBpdCB3
b3JrZWQgZmluZS4NCg0KV2lsbCBhZGQgdGhpcyByZWFzb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdl
Lg0KDQo+IA0KPiBBbmRyZXcNCg0K


