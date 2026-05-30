Return-Path: <netdev+bounces-293353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJghOQ8OG2q/+ggAu9opvQ
	(envelope-from <netdev+bounces-293353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 18:19:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D18060E140
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 18:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4C3C3032CDB
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFB03431E3;
	Sat, 30 May 2026 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="c6UdMOw5"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE0341AC7
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157711; cv=none; b=qglZLfK1BGhXwlyIkEHUGD71kmB60Sbu+d+TuVLthrihczi2HPEs0xX7dHG7r4rJk2e0LZl7tYQAWcfNlsDNEGC2lGqdtd+jKonMkPaiKPeLfYy8VXeSMf7v2sqr+3pfRA3emNK1Jyntq/mlgYR5VJAjLRmgP7mWsbIEVnZtqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157711; c=relaxed/simple;
	bh=QVLddUTTe3/Lzc2TdPehqVakNSW+X6NEoBHDx0Izw9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=pgNIkoL8dQGzieVST41Sx5AHVcFFs5Ed4MJdMl/xRVeZP3wnUdr6fLJ9zMZrvffNQdQ27mWtLd+QhsZxysYuc9+R7P+jZIWlnGUWFvtYcW+TKcyYX++2+pt45KkMeYs3AUfssWorpDYo4Y3gilbepRBy6Vss+v2t/6KStW92vZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=c6UdMOw5; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780157709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVLddUTTe3/Lzc2TdPehqVakNSW+X6NEoBHDx0Izw9E=;
	b=c6UdMOw59nHHrB2WCwFFmkWYwRNXhs1HpTmT0lKHgOA0jHYij/b7AOd2A4B2QM82lPZV8J
	QgI9IhTfgnP0qsxtEqRtFkr9IeWqaTjHt2UPCmQELwx+vyEM5QvOEyccHGic/LG+MCmXU6
	Ys8z5QmahmdA1CsO+dRrNj92FGbwgEnekltPI8eHgeAUG9vJ7wXNxZYRvEMSYiixTXhkVY
	IHL6TrtohWHgcqMyKTeUCAxeq6UFQ9nq7Uj1QMIQF8jqbRLAW0eoC+8Dh0/kexloKQQYmC
	88lhcvtpjci+fC5NV/e3Z0zHX2AhCH1DT1f6fLlsXGn9jineuJktgpYA9wkEiA==
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-27-h3juOqWYMDWbHrOQl0ei6w-2; Sat,
 30 May 2026 09:15:06 -0700
X-MC-Unique: h3juOqWYMDWbHrOQl0ei6w-2
X-Mimecast-MFC-AGG-ID: h3juOqWYMDWbHrOQl0ei6w_1780157705
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by MN6PR02MB10654.namprd02.prod.outlook.com (2603:10b6:208:4f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Sat, 30 May
 2026 16:15:03 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.014; Sat, 30 May 2026
 16:15:03 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk@kernel.org>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 13/14] dt-bindings: net: add onsemi's S2500
Thread-Topic: [PATCH net-next v3 13/14] dt-bindings: net: add onsemi's S2500
Thread-Index: AdzvmfEIy4ETAEJuRtKKpddsqy3CTgAeMIcAAAwu9oAAAt9boA==
Date: Sat, 30 May 2026 16:15:02 +0000
Message-ID: <CY8PR02MB9249BE8825A1E867F84B8D3383172@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB92494D02A1209BC9BC72EAC883162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260530-adventurous-venerable-buffalo-edd6d4@quoll>
 <4f109e08-9260-452b-8f09-97894faa6e8b@lunn.ch>
In-Reply-To: <4f109e08-9260-452b-8f09-97894faa6e8b@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|MN6PR02MB10654:EE_
x-ms-office365-filtering-correlation-id: 33f89fdd-b599-4fb2-50ba-08debe669b12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021|56012099006|4143699003|5023799004|11063799006|18002099003|22082099003
x-microsoft-antispam-message-info: AtPsWkulODoKLR2T+eQrp+cH4Tqffb2ZTEtmgOIbS/q3TFW5yJWa0JIXfzkLFQz0FF8lKKjtxHXu+iDxqAQI9cIX7n1uvmZ1PfDHcpcrw76kEoXIjaRpYfFUhGbjDgHD+epTzKyYeAqXyym2ENIIdWtXac2vOzUgUKbxKruFeQrc4+89CloCLzkI5GluWa/DSwJeIFhdlp5MpffFVRgtMYw4uPYsBC6QR7SJSnxONQYUfF8XDmMUggBajT0n3JLlEp3Xstv93Vs+PrvJIJwjnaaRRboMHo0uIgA9VQVwROJW9LiaTZmzhPDL9Ly0fZbYVb0dvP4+diSEq8iFmDajENCetIuq9CHzOKPyQcW89JXJ8PJt/Yzgk2LroqCn9Juee631vphEux9KXQ3nRkRSn5/iOeZAmf1+yCzUBSGAGy30w/yiB3vnNoO0IL6V2Lyo95+Wba5P7RMcwHUWbr+Y79KbThXUfqi8MqM2Qh0IX+g8SRiCH21av3g42mv7r7FV6irR5cOAs6Km6uwRHOrlVaG1RL3tkKilig+9rtS0e1bXRjMvAZ0cgl4FI+rKeZ7AFbrdQpss7z5cDHfqMnvZzoP4lCnhLneU3GTtVpqIftvixVK6lFz8H19ztY78yN09Ryt1CXC84atDBpRFFOy/xlDNJxBSY/oQq7AbUMFy/FwE/QzysaJJ4LDiFDm+4+eLF6FYN7d1UUXzq3BuXJf7wi+EkDKBr4IdMokuGTthNi1wIaUWK7zxtyRucFCxtJYc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021)(56012099006)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW1XVm8vWmZFeXFqTWhmYmMrcVZnazlTWHhuc1hJcnJNeWZrZ0VOdUMyd2FI?=
 =?utf-8?B?ZDJRUWtnMVNZOVY0aFVYTXU4elE1K1ROdkpSZGhna1FNM3RMYXordDA1Tklw?=
 =?utf-8?B?NHZMcytrNTA2cWZPbzFCdFJ3TmkrankvVk9TNzZGMjBldUFzVUFwMWh6bk9h?=
 =?utf-8?B?ZktreDdJdUd3R25VTUFTVmlETlNjQWlpNUNlbXVoMHhOcnNuR2lCdW1IVW1X?=
 =?utf-8?B?ZmdSN0hmemYwUXJtSmN5dm5sZmtOcXhlMEtlUHlNUkNwN2pTbHdRcmc0Q1hk?=
 =?utf-8?B?V2R1U2ptTk1LaUM1dmREMkZsZUpSZ2x6TW85cDV4N0tveUI4TEw4MUcwZ1Jk?=
 =?utf-8?B?RzFDdmJiRFVHbG5XbHNvaWZVcUVjZnpUMTk2ZnI2UVBUelhmOTFndHlGMGxJ?=
 =?utf-8?B?N01xK3ZlbjYzTzg5OUhyaUpMemJEUXRiK25RazB4SWs5Z2l4UnFXeXNjNlRM?=
 =?utf-8?B?N0xzRHlZcFYxazRwVGpFaFhPby94NVZOWW1aNG1TbHVCSXF3Ulg3b1ZwMmhx?=
 =?utf-8?B?MjlRNmtrUytJc2xCWjNuVlVRNUFFZzNMbTdndG9Gd3RZNnRSVFJ4eTdUZHEx?=
 =?utf-8?B?UmhZdDJwSGw0Vi9XQTlZZnFxV2w0WWJad2RieDg3Mk0xMVBodlg3NG5mTnBw?=
 =?utf-8?B?ajliT0tVbGM2MlF4Y2lxZzZ0bENPWGpFNTVqWkcyY0xPOElNSDlYQlYydHQv?=
 =?utf-8?B?WnJvWE16SG9oMm1XVkVUTEF4TDcycW51RXRKNGl5YzY2Q0NFaFdma0ZML0RO?=
 =?utf-8?B?STlwd21vek9nUnFnNHBabHo4dCtlUXd2MnR6Z2JYb0g0dFgrQ1BKaTZERC94?=
 =?utf-8?B?bzYrRzU2RWFsdlN4N2ZzT3NPTGdVRnM4UW9kVmszOWI4dXFqb0VCZFJyM0gr?=
 =?utf-8?B?VWd6T2VSemcwV2tWNmxIZlBReWtCUkUyMjVIcDJ6SDVhbG9iUElDQzFGNnlM?=
 =?utf-8?B?allOUWk5Qm1vL2g1bEdYOXpLcWZIZkx5ZXZFREZyRERDYWVRUWk0UUc5Qm1s?=
 =?utf-8?B?SnJaeWdqcndQZ2dEbmY0bkpEZlcxRlY1N295cjVJZE94Ymg1VHRTN2EwS1JQ?=
 =?utf-8?B?UUdYMlpVd0NQNDU3Nkdjb0p4N2RLU2FJSHRBRlltdjZRaWFqUWNHeG9Ga2dN?=
 =?utf-8?B?YXJVaUhpUUR5aHFTNUZsQVhZL1lTRCtNZENpTGtRdlllcFV1RjRCL1NJeU9l?=
 =?utf-8?B?aUtvKzBXSkRwR1JhWnMraFAzNm5IMWNaVDczRm5NRVBhUUU0V01rS3QvQjI5?=
 =?utf-8?B?MzV2UGt1YVdKNHQ1Z0kwcmM0OUo2N2pGdWdsdVd3di9FS0NKV3Z5ZEtYKzBK?=
 =?utf-8?B?UkFVajl6cGQyczBJL2hTd3hjRHpTejl6SnhGczMzK3c0QUkybUpjem5IUENN?=
 =?utf-8?B?cFl3eElHelJDemlPYWgxZDFwRyt1amgwTnhhSEI3dlpYeE1kVE9IdVkrUkVv?=
 =?utf-8?B?N3Y1NVRqdzV4bzBzcFRoVmg2NEI0LzNQYUozcXVsQXJjUTlnTHRZV3NPNU5Z?=
 =?utf-8?B?WHBSNG8zTzN6WlZ0UWxNeU9DN1RpMU8zOEtiNTY4djJudjJuSWFRRC9ySW82?=
 =?utf-8?B?OG42TUdYUGZGaVdzd0x4cUw4ekNlTnhNZUsxTVVRalorMFV0U0pRVzFQaHdF?=
 =?utf-8?B?cmpWVmxRRW0vUzRweFV6RHViWWJUbjAyZjl4VUlDUGxWVEhlSyt0d2tVNTdF?=
 =?utf-8?B?QmdiOEJMcmFGcmRwditDSzAwVHN2dWM4K2p5cU1BeVpSL2hZTU5QTjJtZlFE?=
 =?utf-8?B?YW1mZkNvRWhsZGxoU1JoM2dVRm5JYzgxU1hXbDNQa2pEK2MvVFR2YlhNakF1?=
 =?utf-8?B?MW1ZeUNVaW5NRzY4NGNPWWNqM0lNUGJ5RUd3Nml1cG9zNzBZZW5wZ3k3WFhP?=
 =?utf-8?B?R0N2YzRBdzJxeExsSTNjdUxkSm1uMjg3dVQvaU9OUVUra2h0bVdYcFgzTGxv?=
 =?utf-8?B?enV3dThnRU9SZkIyazl6bWY2NFVsQ1RWNVA0L2kyT1RobTk3akxuR2gxd0FL?=
 =?utf-8?B?NTkzSTF6aE5DZUFTVm5TdkMxSjBGWFArQmhHMUloTGpNU204bHZsVzBNdGk5?=
 =?utf-8?B?MnBRaTB4WWJWTHRMMTRXNzhqd1BKbDNOeHY3MGJwc2pxeTE0YTNicXduSmZO?=
 =?utf-8?B?cFhPREovWGpnb09nSVF1YXJ4ZVpGMXNNOGp5Ky9OdGpFTm94SWowMmZhUFJJ?=
 =?utf-8?B?QmZjSkdWTDlKVVJIclhHcFBBeGVJMFhuNTZlWFgwV2ZiaEdiMExHTU90MEkz?=
 =?utf-8?B?V1N3TjdnMHRqWUhHRFVFZHUzeTNLSUVDOHErLzllU3Nja01VYks1V0VoTUlC?=
 =?utf-8?B?UkZDdWI1M2ttTDN1M1FSc0RFSFYvTjl4RUIrQWZDN2dlYUFOYy8ra3o0c0Y5?=
 =?utf-8?Q?9+zxptnyBWyO1qpA=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K6IPzn9b5iKnUu5OachcNJZHhISLLwveCOzs7L023COJTlIW6IIpHefVG8DftLzbGEo40pPBSUYoSi3vRpSl91v4ogsZYyqW5jmvBOw9vfOKq43MamNiIbqF2oNSDCurZ/OvOBvjRh6n3qRFXU5WRqiga3POQw7F8jx3gRo2D3bD2BjV2Oin04aewywIYpSvGWsh6rPPjM6DUGH40btoOUgQmoJWU6ybRXfmq+KAxOLxjEGoGWKJHG1qXNPxxe5Bd6l3HNJ3XR+2mNXT48HCRFnDGukq2qQduy5fSmYU0zkd4ogIqgjpDxM8spg6in/gFUB5ANBnMx+H4GMwxXC8EA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f89fdd-b599-4fb2-50ba-08debe669b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2026 16:15:03.0149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rHKNreIgQnvEWn7tum7P+pdYhMZ+JdAT63xzOwvt6ppOIVSc28IiuLGfcBoZQ6faJ+tTKjCw/ouy4Rlr9IzkfrfxMF2ouUtRysemm0rAm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10654
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3P58FG7zE88aviA2zPcdBpujWvhO_yappBlgxDApU9U_1780157705
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293353-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,onsemi.com:email,onsemi.com:dkim,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 4D18060E140
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNlbHZhbWFuaSBSYWphZ29wYWwgPFNlbHZhbWFu
aS5SYWphZ29wYWxAb25zZW1pLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gLi4uL2RldmljZXRyZWUv
YmluZGluZ3MvbmV0L29ubm4sczI1MDAueWFtbCB8IDYyICsrKysrKysrKysrKysrKysrKysNCj4g
PiA+IDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspDQo+ID4gPiBjcmVhdGUgbW9kZSAx
MDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9vbm5uLHMyNTAwLnlh
bWwNCj4gPg0KPiA+IFdoZXJlIGlzIHRoZSByZXN0IG9mIHBhdGNoZXM/IFdoZXJlIGlzIGFueSBj
aGFuZ2Vsb2cgb3IgY292ZXIgbGV0dGVyPyBJDQo+ID4gZG93bmxvYWRlZCBlbnRpcmUgdGhyZWFk
IGFuZCB0aGVyZSBpcyBub3RoaW5nLg0KPiANCj4gSGkgS3J6eXN6dG9mDQo+IA0KPiBUaGUgdGhy
ZWFkaW5nIGlzIGJyb2tlbi4gQW5kIHRoZXJlIGlzIG5vIGNvdmVyIGxldHRlci4gVGhlcmUgd2ls
bCBiZQ0KPiBhbm90aGVyIHZlcnNpb24sIHNvIHlvdSBjYW4gd2FpdCBhbmQgcmV2aWV3IHRoYXQu
DQoNClRvIGFuc3dlciBmZXcgcXVlc3Rpb25zIGluIHRoaXMgc3ViamVjdCwgSXQgaXMgZHVlIHRv
IHRoZSBmYWN0IHRoYXQgSSBkb24ndCBoYXZlIGFjY2VzcyB0byBTTVRQIG1haWwgc2VydmVyLiBX
aXRoIGxpdHRsZSBzZWFyY2gsIEkgZm91bmQgdGhhdCBJIGNhbiB1c2UgYjQgdXRpbGl0eSwgLiBX
aWxsIHJlLXN1Ym1pdCB3aXRoIGI0Lg0KDQpXaWxsIGFkZCBhIGNvdmVyIGxldHRlciBhcyB3ZWxs
Lg0KDQo+IA0KPiBBbmRyZXcNCg0K


