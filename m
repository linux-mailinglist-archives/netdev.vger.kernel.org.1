Return-Path: <netdev+bounces-296311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kj0mAWDeJWrZMwIAu9opvQ
	(envelope-from <netdev+bounces-296311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 23:10:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A67F365199F
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 23:10:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=J4iugIne;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296311-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296311-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 688BD300852D
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 21:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3573328E6;
	Sun,  7 Jun 2026 21:10:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E96C331A76
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 21:10:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780866649; cv=none; b=VBL/6oByE8OqJWiEdy7kY5ZAS2RoMmh0For/ZWgANRhm5djlMfDdTFym+BRRhpnX46YKz8CnuLkF9Bcm91OcBm8wxZaXfVrHnkndpDjedczaltVesrzytmmkCINNHv3x8l4KgoTJQyPYZOFNWeAi6h14yuNNMCksSElfDyNNuu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780866649; c=relaxed/simple;
	bh=IFMh2IC1xf6kxXZUyg4ZsgOxchLsmBNa1tSoloYO1yo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=lrVwVUvrKHfsu9mZZJR5K6Q2HbpMVQJHnmCiPUhxCYKXXHlMdG7rdRYpTyNaMjNS+3XX0RNTchgproRPjFhQqQ9SiaNZ402bi/CMfio6PYm/hmUED73O4Zq++cl6q9Cvragewb3YuUig/+aWDuNYSCvgYdb58UwBTgCZSpDTDfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=J4iugIne; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780866647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IFMh2IC1xf6kxXZUyg4ZsgOxchLsmBNa1tSoloYO1yo=;
	b=J4iugIne4XralLp5MqoOsHD4fhEaqjHQSK27ePuTY9Puf4/do3v6tOL3pw8gbc/bohdvfn
	JNw+bvsudn01gSYLuPN2LxoiHtuCAosAUi57s1UWF0c31DbFW6mjxJUkNjow4QTruBngO2
	LPOOSKJ/Q7aWWY9QSj689W01j91wzjuAjRb96U/POTus5OY9IDFxb5Dk0KFnUCFo4UX08v
	JCacwu18TEtCrU1dSkUcl6mFTJZYchskXhWZW9V8B26RvJF1HZ6ERsBrkZvi5JxI9uyq29
	DuyaPFDdSlFNl3QjySvZUcweBv4mtH6iC7jb2MosQ1knXuWSqX1MzSZcXKT5tA==
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012007.outbound.protection.outlook.com
 [40.93.195.7]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-52-0Dr1Mk_BM0KlwIdMTBY4RQ-1; Sun, 07 Jun 2026 14:10:41 -0700
X-MC-Unique: 0Dr1Mk_BM0KlwIdMTBY4RQ-1
X-Mimecast-MFC-AGG-ID: 0Dr1Mk_BM0KlwIdMTBY4RQ_1780866635
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by BL3PR02MB8939.namprd02.prod.outlook.com (2603:10b6:208:3b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 21:10:30 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 21:10:30 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Randy Dunlap <rdunlap@infradead.org>, Andrew Lunn <andrew@lunn.ch>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Richard Cochran
	<richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray
	<jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v4 16/16] Documentation: networking: Add
 timestamp related APIs to OA TC6 framework
Thread-Topic: [PATCH net-next v4 16/16] Documentation: networking: Add
 timestamp related APIs to OA TC6 framework
Thread-Index: AQHc9XdYqyenjPnuP0avpxdMHovoULYyl8UAgAEBGuA=
Date: Sun, 7 Jun 2026 21:10:30 +0000
Message-ID: <CY8PR02MB9249DA24FC3E3292FC2D7628831F2@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
 <20260605-s2500-mac-phy-support-v4-16-de0fbc13c6d8@onsemi.com>
 <cf3d6937-1ffa-4d81-8e19-b3f607a7e1d1@infradead.org>
In-Reply-To: <cf3d6937-1ffa-4d81-8e19-b3f607a7e1d1@infradead.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|BL3PR02MB8939:EE_
x-ms-office365-filtering-correlation-id: 29b84b88-8999-4926-01fb-08dec4d934a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|18002099003|921020|4143699003|56012099006|11063799006
x-microsoft-antispam-message-info: I665StqrlFPi93aMEOrv/jWkVUY3u+P1gIXMsjNZ+jaJKzstGt/ngTH3xUHhaA9yg9Ku5vTR5Q70D1F+PZoA8VwaWaxXJDPQg4KF+j7GvacBL2IPd12TrtRi6bWPB+1yWoOAAJeKRYd19PsJrkimrfEbGL3YiyQRJLwhZK5wzF+bRSC3J2pzblQA/6BCPSRZj4X5Toy8JSoQ/r6AgUGf167Ln7Yx1o3RnHfCilK4Vk3xyXgK0P5EaudrE9JzVt4oYjocirW24rH81FsiKIR+WzPvQmjp9O1XcoXBfKfu87kU6WejKgumV0qiUhhdP3QLKZCj4/ONexDbm03ePd/oF4tF1WNN5pisSMRY0QbIl5HHfaQv4+Ao4StMVbm1vpj/d3C/oCgYjcP/5349wIvcKTUnAoxanzujeTuNFN+FYDChbNd5T6Tkb8PEnafwwo6yZIsel5soLfyfsX62vLiqxt6GkkxmuEtMybMIWwWbqgK5NP9jVmn39BADfNP3HXUArRDeIonXp4EAcKPDfcopZpuyzWJN8hkj9U/8/g2f9ww4qF/Q88dUjxvs3W5MkwFp5gQbgwIjLRcFKdo0AZYs51HpVDBxnghdZfDpdeoY2BUwOHKEC8VEpjjlmfhOa/wwYMwTORn/dT1EWkEkPrLnYta/FmO+yUFlAIr/KzgrZoCB490jLBmqcEu8sPr6B1pdnzMVs+cO+LJqqWeRRqQ28Z5rP3yrjyjZHFz+sc9pce8jcrQnj2LcFb1hP/1uANeFCBPP7l+tJLGsfaaWqi+KEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(921020)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHQ4WG1MVnNLRmZjazJQREpHZVBLTFd3T2t0aHZ2SDRTajVwM2ZraFZkNTdU?=
 =?utf-8?B?YVFCTk9vY1dzdXZ1L1FCcTdkMUtxUlFYL2JEWnZyczI4Z1QwTkgwa1VLV3BB?=
 =?utf-8?B?V2xMZWFqUVdURVBCUE5TMnhscEZWNTFRZUo2RlF1QzBoSzdJamJHYWhIY2VB?=
 =?utf-8?B?bjJGZDdIMngwR2VGLy8xMkJDaDNzdElHU05VWGxlMHU5blh5dkNEMXIvcGo2?=
 =?utf-8?B?eEs4a3hUT0RFTkNtSTE0eTdhRmZOSWNTeXgzdVk1amJQRnovWHkwQUFCQXJP?=
 =?utf-8?B?LytuV3JDQmRoUk9XNzF5SDZXdEt4U0IyZHpicGZ2RFRLbHNsTTRNczFXVnZk?=
 =?utf-8?B?Y0JsS3NwVFZTOUZNSEN0VmRCZTNvODVCVi9HNG1SVG5SN2R2SGJzZ0Mra3R4?=
 =?utf-8?B?U0tkVFJhdHQxTE5lNmlUUHlvU2hzZWhqQWJYOTdweE9lOUZUYzRMN3Nzci85?=
 =?utf-8?B?MDdMWDk3c3ZXZVhnM3NyUEFEckI3ZENXV0hPdUExUVFGcVprVHpuY1B3RXB5?=
 =?utf-8?B?UU5jRm5XU1RqMlVKVko0NmY4RVVabDhad3o3Y3FSMWg4UHdPM0t4NU5WRnVK?=
 =?utf-8?B?b2dOZEY5eEdXamFlZFFUSm0wRSs1UjhROG9IczJMa1NnSFdheEdSRzN6Tjkx?=
 =?utf-8?B?SStUd0thQWZHTjV1a0RrK3ExdVRNZHdIWEt4eHhXR0REWUs5K1JRMTFyQlB4?=
 =?utf-8?B?anVoTHVLRVNqUDM3ZVg5OUxWUmZoRUFDTy9YaUtGQ1R5UnJXWUhIRy9CUzcv?=
 =?utf-8?B?dER5YlhnWVhKMVJCSmNpU0EydHY1QUJSOHpNV3k4eTNlc09RVjFrRmw2VFFw?=
 =?utf-8?B?bWNCM1Z4b0k2Qkt3Ryt6WWh2T1BwK1lKUXVrcGgrVGJUSTk4YTNKNUNFaXRD?=
 =?utf-8?B?dVRoelgvMFFxZTBTOGFmT1czdXIxQmNzaHdRZ3M1YUFhTTRjSWJORU85OVF4?=
 =?utf-8?B?dGtYNUZsbFNEL0x0N0tEbHlkYnFZSC9VSDdpcHJGdnQxUlJUY2RJa1RMOXhh?=
 =?utf-8?B?MFJuWm12dnJuN2VuYXpqakRxVStiU2RMWHNtYW1lSGgxNitzbEJpU0RZZVhS?=
 =?utf-8?B?MzVhZG5JdEdTLzh6bENUcXdlQzNoaTRTRTcyVEFURXl6ZUQwci9KOGlGRDE2?=
 =?utf-8?B?ai9FdGxSa0tFb2F6dmltWGxvb3VJZU44N09teUo0K0FXZTlFempadnY5NUFU?=
 =?utf-8?B?NjBmQWpIaE14bXZtbjFlZGt0a2hKREZUKzlQNzB6dTdMQWV3UlZWVEJpcWVX?=
 =?utf-8?B?OHkvVlFTV2FVbVNSQlJDUnZSdUp4TEtZNmJBNFNMMENrTE9FQVJpT3dWa1RC?=
 =?utf-8?B?R3dVVzEyL2ZXQkNiaDFEVEJHUHcvbjZTbHJweUJIeTkvZjF5bGdtN1RMdktq?=
 =?utf-8?B?dE5YUWJpVDV2SktySUx1bUtNVEFUMGUxYTJMbDltbGpIZ1AvcVBhaXBDanVw?=
 =?utf-8?B?WGtINEtHZ0FsYmJ4T3BSM1UyTWR3UmZrUE5hMXRDVUlIV2ZWL3QxUDU1YURN?=
 =?utf-8?B?Yk9JbVVyV3ZMS0srTHlEZ25FQTZvV29rL3BBTTByVlVBTjVNOXdXUkJPMlJ6?=
 =?utf-8?B?RDZBeTBtTXpWRnNDNzNKYVZSWDNLVnpQbGhqQ2x3cHVJT3J2WjJ6MXdZTUVO?=
 =?utf-8?B?TWpOdXhtdlBETy9WSjRuQjhaLzhBMVJRKy95bEZJbHIySHo4dU9nVlN6YXFY?=
 =?utf-8?B?OHlpM1dteGpDeEZLcHoyQWdLMi9KRzh1M2lrUG02MVZlUXJoaVAydzlKWGlI?=
 =?utf-8?B?aU9GSm5GdzZZODdvNUYrUnphUnRDa0FuRkVVd0YzeEVlQ21QV1o4U2JUUm1q?=
 =?utf-8?B?QUUrSnVyQkJSNUtZZGRvSWhTRklmYU1LZGxRWFJBZHhmNFVGaHBkSnVoR0h3?=
 =?utf-8?B?a3kzY01uV0ZQemRYaHhQV2JUZkdxVVZSc1R5a1kyMFRnMVdrZFowd0hNdVhQ?=
 =?utf-8?B?VHJZREhHc0hvaEJTYk1mbmV6bXhZVWNhTWpQSzlMWWxJL0VsWmRIakVYTGtr?=
 =?utf-8?B?M01lV3lMVW5jNWRoMVN2eTMwUlJEUVFIRHJRUnYzcWVqdm1MaGErazVLc2JY?=
 =?utf-8?B?RFVuY1lTRFljUFMrZzd5d2orME9pMkF6TkVXaUVockhIdGxYTHpmU0w4N0R1?=
 =?utf-8?B?ODJGQlBxNXFjSFVLUE9DOUNBSjkwUFRhSUhFRDBTR2oxU1NTbEppN0YxSEp6?=
 =?utf-8?B?QUJpTzE2V0JoU2RGb285Z1lERit6SS8yYVk5d21uSkhZdWFiNUd0dFo4bDVx?=
 =?utf-8?B?cWZqSnJIRHR2NVh5S0pNR3VmMmJYdkczOUZjR2JsbWk4N3pBZElubUhMK3R0?=
 =?utf-8?B?UWZaR2paQUhPT0lWYzliVkgrMjRxMGRXb3RsZ1EzVFBMZCtPaWo5L0ZKWitP?=
 =?utf-8?Q?rOsYz0z5AFB2Q6hs=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l8nYRJMqwGtmTP3FAAHt3C+s7l8d65aqamWtI1IAp1Wi/Lk2T1g47GPogBEF2X8s3AOA5B//VFWsewTI07ghmBICBRKhL84zrcgbiRXUf/3CL/yIr0NGf1/qiSef1vVUmZOUPbaPGiLUEvgLDytONZ2w5pZo8xJTPI5WrlquqkDbksZChvulFa0Gz/+xdZ7YKklNhkSki8thMzYmuQc12+bzHszSt5sWsQgKzM8ZegESPF7mrlPlTqIUwH1H61k+ZkBOf+w0WgiTFe1npNUBVwTx51ShRputtlnH7ZraslCh5k+jsgXDGAI33uEZELfBTRzCle5MpnRQ1GTsF+FqPA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b84b88-8999-4926-01fb-08dec4d934a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2026 21:10:30.2563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQ6WJ4BfAaDz3Oa2XMc+BNpU+8Bwv33dhfDZ944R9SCfrPFseWccWFR8tZighgUNJ8srlwyGqZzJK4tY7mm8bBTSM4b3Gh6Iow+bUTn6Zzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8939
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sQmbR84DhlnY0T61gpbrT4pEA5db_tL9t_x1JebX72I_1780866635
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
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
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296311-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rdunlap@infradead.org,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[infradead.org,lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CY8PR02MB9249.namprd02.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,onsemi.com:from_mime,onsemi.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A67F365199F

PiANCj4gSGksDQo+IFRoZXNlIG5lZWRzIGEgZmV3IGFkZGl0aW9uYWwgYmxhbmsgbGluZXMgdG8g
YXZvaWQgZG9jcyBidWlsZCB3YXJuaW5nczoNCg0KV2lsbCBkby4gTXkgYmFkIHRoYXQgSSBkaWRu
J3QgdmVyaWZ5IHdpdGggbWFrZSBodG1sZG9jcyBhZnRlciBlZGl0aW5nIHRoZSBmaWxlLg0KDQo+
IA0KPiBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvb2EtdGM2LWZyYW1ld29yay5yc3Q6NTU0OiBX
QVJOSU5HOiBFeHBsaWNpdCBtYXJrdXAgZW5kcw0KPiB3aXRob3V0IGEgYmxhbmsgbGluZTsgdW5l
eHBlY3RlZCB1bmluZGVudC4gW2RvY3V0aWxzXQ0KPiBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcv
b2EtdGM2LWZyYW1ld29yay5yc3Q6NTYxOiBXQVJOSU5HOiBFeHBsaWNpdCBtYXJrdXAgZW5kcw0K
PiB3aXRob3V0IGEgYmxhbmsgbGluZTsgdW5leHBlY3RlZCB1bmluZGVudC4gW2RvY3V0aWxzXQ0K
PiBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvb2EtdGM2LWZyYW1ld29yay5yc3Q6NTY2OiBXQVJO
SU5HOiBFeHBsaWNpdCBtYXJrdXAgZW5kcw0KPiB3aXRob3V0IGEgYmxhbmsgbGluZTsgdW5leHBl
Y3RlZCB1bmluZGVudC4gW2RvY3V0aWxzXQ0KPiBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvb2Et
dGM2LWZyYW1ld29yay5yc3Q6NTczOiBXQVJOSU5HOiBFeHBsaWNpdCBtYXJrdXAgZW5kcw0KPiB3
aXRob3V0IGEgYmxhbmsgbGluZTsgdW5leHBlY3RlZCB1bmluZGVudC4gW2RvY3V0aWxzXQ0KPiAN
Cj4gU2VlIGJlbG93Lg0KPiANCg0K


