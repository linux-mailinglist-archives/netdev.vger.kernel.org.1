Return-Path: <netdev+bounces-290613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id G5blA6hyD2ryMQYAu9opvQ
	(envelope-from <netdev+bounces-290613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:01:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 928B05ABF7B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 543FB300B5BE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A15A2D8376;
	Thu, 21 May 2026 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="DfL1LpJw"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2952505AA
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779397283; cv=none; b=BpYjmnVUuWMdUuoRcrcTAt264+tN4i2b2iFGXVPX6xOK8FJo7PzHdb1pu1upB0irXgeNxtvH63gnGPBEpsBJvkT0kZ9grOE6Q4R67npd/++te7p+1ipMfCoqDDx2v/k1p8y1eB4Ihq5ibDlQIu3FmuclB5zj0XbpUFOQXET/nEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779397283; c=relaxed/simple;
	bh=V1BiBwywCbmlqDITM2zbLqMmN2rAT0pnfQx3oFpfi1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Z17HDIpcXUYe2aHBleB1Gwz6/xqs1CONFqWp1EOweqkzLSG5xL4Ypt/yhK6aPH4932i3w53vbvnz3utilkwWv2VwbpPrRFmpTfmKg3ht30MwEVrIAptPGJCkeQnYMiKs9liyvZkalkPJTIJ5W5NZ45FsJIdteeX25O6nGV93Q3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=DfL1LpJw; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1779397281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1BiBwywCbmlqDITM2zbLqMmN2rAT0pnfQx3oFpfi1U=;
	b=DfL1LpJw3Sm7a/AR1ViHP71VicqVJgBu7mcQieQglsU/VvjThMg9WyV8Eu7qOd5/N7PGyH
	g7ms/TGXI7vVi9eWnFtr4swmc1Nup//v3zCrrTPpeEGvTsZQ0vB9LFhPuH/7T3Ft0O4avc
	wxzxZCwBJYew1jRZjx7tJC9v6ugEXRPpgv7IYqhpsoNbAw3tO44lepHaLFtgtxHzOurZFa
	mtyVshmqPIlUxZBpPLK74JCQ9OXeYLioUt890R5gXEzHB9i+fm7rNY2ZjpH5DyAap94VrZ
	K9tXOF2keJ3Eul2/CsiTDCTaTfynz/aXUpVPxx7p7SnWw3zfWgjTt70d2ZXcsA==
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-43-5RjNkt-yPVO7dgDQ9-mjSA-2; Thu, 21 May 2026 14:01:19 -0700
X-MC-Unique: 5RjNkt-yPVO7dgDQ9-mjSA-2
X-Mimecast-MFC-AGG-ID: 5RjNkt-yPVO7dgDQ9-mjSA_1779397278
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by MN2PR02MB6973.namprd02.prod.outlook.com (2603:10b6:208:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 21:01:15 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 21:01:15 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Topic: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Index: AdzhcbEAp6Owv179R1mImunkqBeYBAAELzkAAT2eW1AAEUQMgACinjEwAAKipwAAA57FoA==
Date: Thu, 21 May 2026 21:01:15 +0000
Message-ID: <CY8PR02MB9249EA6F0B42A021F4AFE7B4830E2@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB924948C0BB8611D5A2618D3283382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <c9b1b559-f72e-46e0-8d71-57ea26f70bb0@lunn.ch>
 <CY8PR02MB9249BE304350D2FA7C196A6C83032@CY8PR02MB9249.namprd02.prod.outlook.com>
 <660d68f2-2e4a-4dad-a33b-9cbd1847c04e@lunn.ch>
 <CY8PR02MB9249AE486B23AD6637517436830E2@CY8PR02MB9249.namprd02.prod.outlook.com>
 <c5d56bce-2897-4185-b571-e33b25b95040@lunn.ch>
In-Reply-To: <c5d56bce-2897-4185-b571-e33b25b95040@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|MN2PR02MB6973:EE_
x-ms-office365-filtering-correlation-id: 4b608bf8-68d5-4ec2-24c7-08deb77c1900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|11063799006|4143699003|38070700021
x-microsoft-antispam-message-info: CatNKG02F/AdXJTubCDjRMII8j1qiYxEnnfMTY7jLPoFpKEfiWU19fuebXSzI0UKqqZK/UL7030E/cSiPaFK4JhnVSaa80q5a0syxE0V5aevAqAB1Cyv4RLIKSBzFhEiEdT1dLj7QdigKvrQ+rMEE6o3w7tKeDMXFqj9JXbu2WXDOZAcTdz4enRyjbWCpmJlJG7GTL9TIPpNU04AkBWHjtFPgLcl0HvGmlat29n9l8BuFLXQCffcj/eN70+XbjX/ilLDkM8bjKtNIOZPpVmUOFyK4+0wfYnDDApUp/LG0C2RE3USio3uajIupie9lBUufP72/Kp7EqL1nLa5QRG5jVK/06tteX67QfJSwqGxtD5n9aHS8OkeRy/k2rWMf7SNQdaAUepWKH2Fnr9IP4k/+TRQDSTFPqQASvgGl+uHGsQJtqaLmtXI5sX3CHnCsE6lnXoelNzVz51v+mfA0S/IiER3MlXsiKNKEo0qxbZejzOEI2VBlSZy5q4LM/fnkhC9VlLi2p0n+rwg3SQsgmCkVE/DdHdmgGooySLfkHT+/QkM6q2silUFDSvoBTNCaDyxXtN/cTMCXDuwyLpkeqrVreDKCxxOxkavwIzdrQ9PCTw9Sn2lJ9uWFNarLrYNrd9e90f1carkgLt5OUnjpl8Gg2a5k7ZQp/3KQBmIUtBX9LKwQSc5c3CvxwUst2/12t6APcLzYUoGbqaRjzoMur/j5UyJCvI20vHQdIp0wTdeA3lpE+bl3WMOqBHU93CJwT95
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1psaVZ3MTJ6UU5qNFJnd0h0aktjczhQYnhVUHB0TDJQUmp0NU44MGlBbXhY?=
 =?utf-8?B?eFZXZE5leks5RlN4cEJ2ZS8rQ1puSis1MnlxWjAzWjVOS0k1ejZvdGluZHc4?=
 =?utf-8?B?RER0TzdCdFJnWGVSYk5McGZuT1FYdHJsekMyZ1FsZE9nb2JzUGszOU5qRHc4?=
 =?utf-8?B?MTIyYU1PaktQd0xybDgxWGhDMWZITlFrOXpHYjJEcTV0NDQ0Z0NteE1UcW9B?=
 =?utf-8?B?enlJZDZONExmeGVqZzN2LzNMNExUV2lNb0Q3UHlqdmpsTjExdDRHNHVKakdL?=
 =?utf-8?B?RldiM3NpTzhGblN4dFIrb090bFIwZW5jczM3OUlFKzFZSmhjWTdPb05yTjdD?=
 =?utf-8?B?c0pORDgrV2U4QW1tWE9JUlQ4a2RZdi90WTlCSDlTTjB0ZFQyTnF0cnEyMnl2?=
 =?utf-8?B?UUhGQW82ZUNQb2IzeFlYTEp3YWVmWUVjaHZPcHFqVzMwZUlDemJaSDB4Vmtz?=
 =?utf-8?B?Vy9xWDdKWG1GamhyNHVMSVRsTTZYUnRPM3BPUnM0SStNL1FXcTZPdnRINmU4?=
 =?utf-8?B?OVNFRjY2dHVqSGQ5K0tGc0JUOW52YU1MN3doOWFwc2E2cXE1MEFtVFJMYjJI?=
 =?utf-8?B?RjE3VGNxdkpuSUtCbVZqekxCblRmSnJUdWc3NHdvbWVEZWZISmR0QlFhTkYy?=
 =?utf-8?B?OFd4Qmhjem1wK3AzcEgyanRTZ3I4ZjVIbWE4dk0vWDJLRzAwenJKVFZaeC9Y?=
 =?utf-8?B?UG1EaG0zc0hxTkl1cXdkQkVTRzVJb2txZjd6aWtJVjczSE8wNTBIenRlUnh6?=
 =?utf-8?B?SVlJR3RjenJ0ekljdkc2VXBHWHU0OVlJVFZISVpoUi9KN2RkdW4wNm9JWG1n?=
 =?utf-8?B?TWNxMzdFTVpLM2p1ZlQ2dHBkVTZCRFZjUEUyVWtJVnZwK2Z0MG5ObzFXalgr?=
 =?utf-8?B?cHdHaGMrWUQ3QnhJWURPYWVJWS9ZR04wVGJ6QmVwdHYyN1BTcjlzNEJPSGlD?=
 =?utf-8?B?U1ByRUU1Y3VLMHgxZ2JxME9KbUVXK01rWjFYVC9za2NXZFVOeVdJQTRyL1Jp?=
 =?utf-8?B?b1hFRDRHSXR1b01rTUhjUnlYcUJBN2pWSEJ0VENxRXMxQS9udDBmMjlsMnZQ?=
 =?utf-8?B?eWZNYXJBa1ZDRHJPdUR4TWZGUWFyV2FZcHNYTE0rTHF5cjRmZ094WVFkTmFj?=
 =?utf-8?B?dHRvdFU0QXIwYmZTTTZyMzFhK2IwNm9wZTFNOWFTU1RweG9iQzZ3eEEyYitk?=
 =?utf-8?B?WEFvNFcvQlBzNEtaaFlJOWpmQUlocENFZVpsa21SNE5pWDVSZ2NhV3dvcEMy?=
 =?utf-8?B?RFgxdm5GZXNYT3FDZlJnNUtpeXRMNFB1RUtSQ2F2UVR6bFhxMjJaZ3M0RVUv?=
 =?utf-8?B?QkU1cGpCTWRDYVI0VkxkQ3BZRGN5cEN3ZFUwYkxRbjBPdi9FNnZ5NXdjQWFK?=
 =?utf-8?B?U2U4aXkxZExLV25hRW1VcVZwTTBlOGJKYXVKaTg5RUJRYW1PQ0xka0hsQVJE?=
 =?utf-8?B?TnBCaFFOZ1dlR3YzSVo0c0crUVBWZ3pWUnJqd01RTVpVNzE0a0ZMZ3N4YUdx?=
 =?utf-8?B?dTFrbFFCajd4WjdSckFJUFlDbGMyTE1VcFNrSHFEcTB3QXAraCtiSzRzazhY?=
 =?utf-8?B?bGFBNDB3dlNmeTFLQ2VMYUtpSDNydU50WDhWQ1Z5YmQ5Vi9SdFJVN1IxVHB2?=
 =?utf-8?B?eTdLd2xFNEZTMC92SmNCS2Rvek9SZFk3UStBTTJQVHROa3NycmZ6dWV0SFQ4?=
 =?utf-8?B?dDZlRkNPU0hjbVM5T3hxVmZqNmpQakk5MGNlcjlTVVAyaS9YUmpacHFmLzNq?=
 =?utf-8?B?T0l2SGJPcVZ0ZFc0cGl3Qk1NTzdKZDBEaVo4K1g0c1Z0ZCs3c29mQWZxa0hx?=
 =?utf-8?B?aGNWS1M2clczQ1VOL0RoR1FkVTlIaG0zekRpcjBOVENSVmpHUWdrWlA2ZXJY?=
 =?utf-8?B?eENKZG0wbGF4V1YySHlxMXNDeDMrMXl3N3UzalViOFFxbHZVOUdyRGk1dDdn?=
 =?utf-8?B?RUFoMW1ZUmN6SE9pK3RncXFqMUNvczFObE42ZnJDMzRQeTRNUjllSnBVS1I3?=
 =?utf-8?B?ZW5lc1VKbWg2SEw5c3lwQ2F2MFp6Yk9yQWszbVJVdzdOSmpOeTduR3QrdGFs?=
 =?utf-8?B?SzQrclZjSXZvZGhxVWZYUmZnZmJEOUV1aXhGd1JlejZJbUdVYVl5NmNHNlFk?=
 =?utf-8?B?UFBCZ29BVkFUZjdpb3M2Wkw5ZldBUkJBV09vUEdOdDdUbkMrbXhiVm1yeXF6?=
 =?utf-8?B?UWxQK2NWTnZhaGNpek9nMEJYMC9UYXpTOXpORkgvbUN0WUc5NHFVMmpHbmlQ?=
 =?utf-8?B?dTZDQmwzaEgxME9aeTFNeldEdi9Lc3lqUk1tYytmS3pPVlhRMDZ5c004ZjVR?=
 =?utf-8?B?T01aV0c1QXk3SnNIZ2xETWV1ZjdyRk53eWZoQlNFRFlKRkg0c0k4SE91U1l5?=
 =?utf-8?Q?TvqH16vEILEI12us=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nlDGGwR008/C0kOxet3Xnlp88X3hwHLpN8bwB0WzeYquuLlFjltclOZBlyS82+dsrt+gSMoYe3N+QpuuK5NIZrJv7FjV7FHzvdYAbGRCmTlWtzPAAp/3MNPy6DcPflueX8D5QNg7XRMUdDZOmNNiUlbxPJSHxCMpgfg5+Dv2e8M4QNOANRmPQtJ222GadCxZGw+uQKP1p0fLbQiIhR1FYmiENMBbMInd3sw9CqDGSGmi/L5lFpnxTlJEcpIjNgNlOQA2T+nIN4U+WGlbr8lTwwoxxI0zckuJ+iQc7XFUbQ8JhPf9WaXymiLvAmrf+wNV1KA0yQbi6yEpKAQRdL8uOw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b608bf8-68d5-4ec2-24c7-08deb77c1900
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 21:01:15.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xthu2Bg43bReYidcJLfofLrfIsgWKKt+JB++qKXscdsA+qYJtZxaH7qU5S2W0JXpa3NoAqr26USYceoX51jp4vXJJsilfFy64ofxT+AlUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6973
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Aq0x_CfqiTRtAjOQ9cmgQmJYFosKqDcDgO7wHEsooKE_1779397278
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290613-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,onsemi.com:dkim,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 928B05ABF7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiANCj4gVGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+IFRoaXMgbWVz
c2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4NCj4gDQo+ID4gTGl0dGxl
IGNvcnJlY3Rpb24gdG8gd2hhdCBJIHNhaWQuIEFzIHRpbWVzdGFtcCByZWdpc3RlcnMgYXJlIGlu
DQo+ID4gdmVuZG9yIHNwZWNpZmljIE1NUywgcmVhZC93cml0ZS9hZGp1c3QgdGltZSBjYWxsYmFj
a3MgaGF2ZSB0byBiZSBpbg0KPiA+IHZlbmRvcidzIGNvZGUuDQo+IA0KPiBJJ3ZlIG5vdCByZWFk
IHRoYXQgcGFydCBvZiB0aGUgc3BlY2lmaWNhdGlvbiwgc28gbWF5YmUgaSdtIGFza2luZyBhDQo+
IGR1bWIgcXVlc3Rpb246DQo+IA0KPiBXaHkgYXJlIHRoZXNlIHJlZ2lzdGVycyBpbiB0aGUgdmVu
ZG9yIHNwZWNpZmljIE1NUz8gSXMgdGhlDQo+IHNwZWNpZmljYXRpb24gbWlzc2luZyBzb21ldGhp
bmc/DQoNCk15IHdyb25nIHVzZSBvZiB0ZXJtcyBtYXkgYmUgdGhlIGNhdXNlIGZvciB0aGUgY29u
ZnVzaW9uLiBTb3JyeSBhYm91dCB0aGF0LiBUaGVyZSBhcmUgdHdvIGtpbmRzIG9mIHJlZ2lzdGVy
cyB3aGVuIGl0IGNvbWVzIHRvIGhhcmR3YXJlIHRpbWVzdGFtcGluZy4gVGhlIHJlZ2lzdGVycyB0
aGF0IGhhdmUgdGhlIHRpbWVzdGFtcCBjYXB0dXJlIHJlbGF0ZWQgcmVnaXN0ZXJzLiBUaGVzZSBh
cmUgaW4gTU1TMCBhbmQgdGhlcmVmb3JlIHRpbWVzdGFtcGluZyBoYW5kbGluZyBjb2RlIHdvdWxk
IGJlIGluIHRoZSBjb3JlIGNvZGUuDQoNCkJ1dCB0aGUgcmVnaXN0ZXJzIHRoYXQgY29udHJvbCB0
aGUgcHJlY2lzZSBjbG9jayBhbmQgY29tcGVuc2F0ZSB0aGVtIGZvciBhY2N1cmFjeSBhcmUgaW4g
TURJT19NTURfVkVORDEsIChNTVMxMiBmb3Igb25zZW1pKS4gVGhlc2UgcmVnaXN0ZXJzIG5lZWRl
ZCBmb3IgUFRQIGNhbGxiYWNrcyAobGlrZSBhZGpmaW5lLCBzZXR0aW1lNjQgYW5kIGdldHRpbWV4
NjQpLiBUaGlzIHBhcnQgd291bGQgaGF2ZSB0byByZXNpZGUgaW4gdmVuZG9yJ3MgY29kZS4NCg0K
SG9wZSBpdCBpcyBjbGVhciBub3cuDQoNCj4gDQo+IEFuZHJldw0KDQo=


