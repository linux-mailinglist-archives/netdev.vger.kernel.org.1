Return-Path: <netdev+bounces-284469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vEuzDHQM+mntIgMAu9opvQ
	(envelope-from <netdev+bounces-284469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:27:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4F84D0303
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B8DA300CBF7
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B10A480DC9;
	Tue,  5 May 2026 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="Rr3CgsAV"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627EE47DD5A
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993877; cv=none; b=KYoDrL9+0M+B6iKM8cvjl0HPUe+xttLVrU0I2kTborTsV/kum033LsO8Na4nO5t/HI6C9aNaQWZtsYDezzA9PkEuJlcaSz/EMSlM8a5W9ke/48jlxP+UMRgg55AEtQ30u2+LeSPwVFEy+qr0/s1qi/qQiSx81YIu2Gn6elZoE7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993877; c=relaxed/simple;
	bh=3voLv6+RVYc7OWGlwbjEPe2tHKgQfCuFljmKcIrakYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=qFUYTjX5TPtw1VrfgXg0DH7DeQM/vj1qJVVPbNis+yBzwDg5M6ovo0LHAGpLC1ze8bblxfmRAtgtG1M4Mif5KfIkgx2UpkpyrJhT3KI6nh8iT4CNvo8777U8AgjCEfxnB8i7Lhjc9dsjO2C229uA3cF1MDantVETxkarXKi4osI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Rr3CgsAV; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1777993874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3voLv6+RVYc7OWGlwbjEPe2tHKgQfCuFljmKcIrakYw=;
	b=Rr3CgsAVoHDeI0rQ0W3l2za0x39+Wd51NXQLZTCMQE5mxzIHFf+B5qVLqACOqeflA1LMau
	/y/oTx0Ndt359mp558IPiHDDP5Hj4nAMZ+ElZYiS6tw0egDAiJ3fVYsSvXw4Yllh3qDEHy
	rWmiJdPqOFqEs4RZ6LshDXIDU/0wi/e/P5UQkBLoKFrVEMkIScY44R5nMCrPqfj04e98A5
	Yl4Fu32/3/9l3royVTaqkVucXgEdCv5VTuXFAWaC6caXqP5EqKo1Vn6Hd6N6SHRnVooaPi
	qssaffxPT3+7sMWBqVthllQE78kfnUPwhmLJXvs5IZVlmKziMe2cihPLzjlvhw==
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-69-9owRa-YfM32C7ySoYWGQ6w-1; Tue,
 05 May 2026 08:11:07 -0700
X-MC-Unique: 9owRa-YfM32C7ySoYWGQ6w-1
X-Mimecast-MFC-AGG-ID: 9owRa-YfM32C7ySoYWGQ6w_1777993863
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by SJ0PR02MB7342.namprd02.prod.outlook.com (2603:10b6:a03:299::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:11:00 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:11:00 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Rob Herring <robh@kernel.org>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/5] dt-bindings: net: add onsemi's
 TS2500/NCN26010 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next 1/5] dt-bindings: net: add onsemi's
 TS2500/NCN26010 10BASE-T1S MACPHY
Thread-Index: AdzZlV5WH2ywWnNEREiWlMiVKhqFigC//AwAAALiIeA=
Date: Tue, 5 May 2026 15:11:00 +0000
Message-ID: <CY8PR02MB924915930E62AE03DF05C2DC833E2@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260505134434.GA2493310-robh@kernel.org>
In-Reply-To: <20260505134434.GA2493310-robh@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|SJ0PR02MB7342:EE_
x-ms-office365-filtering-correlation-id: 3401c598-72ac-4c76-a95b-08deaab88449
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021|18002099003|56012099003|22082099003
x-microsoft-antispam-message-info: atMJktdgEc7eBArHPxFuHB0hfsos1grVyuFuFB/WfKBNnMiaT9Zxg30pjAZx2SU5Lv0eCs/cyYEovtWNFRUMOKsHLN/h4v33xusJaM3X+fnaZF/R6Ey35REJiTogKpnZ24mlRFbylg2FjY2yO0ASuifILcteBmEhxuoBW5oIFueKWmnBwKObX/6ALg2Q+DDQ5frjK+lFuXV6+n1HG2zCgnjkpEnje5LDO8FTE5vTxcUEARDsy7HSehJvxXrrN/ijLJlqDirxLO5qna7UMgqC7zcL+ayuF1GZ3bsotwNxrNnjY7Hn0IhLIM8aH9EHLnhMwz4nbDoPHzDCQN9BeITBC3U43hw+KzgB2J+yE2C0BYiDOFv7hEexOa+VN3AU+Knw4aPPMlLgT4BOkjRwvhhfcHZPPchnckYXW5jJvWNLiavz9WAUMrIcAbAif9drH/h0ECdeYgSqgy+uAbv2V1n5FQVYgnr0VkUVdDxVD261ass+NWkdCGx4Elg+sE/svXJ3coAXcB3E4gAesJl4DrdYdeBaW8fOnetvDfVQg/BIaGoAW1IPtayHmqP4zcxnfGR29B5qitzjlsjSGqLx/4g+nblq7+FmnEJSX6/jHWDIBeWxUSQYa73npRi52JCeZhrca5t3/HhkVDUUGbmk6Jar9BqO4b0/w3q9UjeZdPfK+cAvl3PW0DuNPI7x6+4oCb1WoHh4k7MMebRMcZAZeodZKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OStpVFRTTm9HZXlIVi8xS0ZVU2M1UERDOVI2MGFXWmpIU0pZSWcwTzZQOVJn?=
 =?utf-8?B?NVhxUTE3V0ZuVC92ZzVYRUFsRGdVVENBZDR3WXB5cGhla3QwSzRhTEVsYlJx?=
 =?utf-8?B?cm1pbGdOVCsyeU5xVTExYk5Xa1FYQ1Rjd20yZzliTUVFODM2bGV3VThsZk5t?=
 =?utf-8?B?T2ZMUG1aaDJkaEJKNGxoVlZFOGRsV0pPSTg5bDJDekE0dmRyV0Ntc0ljbndF?=
 =?utf-8?B?c2d3RXYwbkhwcFovYXlJa1ZLN3ZHNTlMWThtdWhZMWdxMVRqTVppOUpQcHo4?=
 =?utf-8?B?Q09ZT3JLWFkvWDVKQi9LVTVrbnNXcHlWMFU5OC81ZFRybWhyYmYyL1lLWjAx?=
 =?utf-8?B?Z0NsY1dIVzhwZzl2TmtFelpwTUJBY3lPK0JzS0VBQmMxOWdkUytnZENSZjRl?=
 =?utf-8?B?YUFDc1ExcjYzZWREZTgxYitIWW1PNmtIamN6L3o3NytTOGRLejM5UmZDNTht?=
 =?utf-8?B?V0Y1Qlg3L0Y1TnFlR3VnM0VYeFVkUmRMWTk4dzdtUW9qaWhyUkVSNWhERERo?=
 =?utf-8?B?YWFuMjhETFluS2R1T1F3SEFOMWprUnNXd3lBNldHRHZHbXV6QjE0ZFpuZURy?=
 =?utf-8?B?Q29mcWV0NW1pSjRadHdTZk1tQ2FVT21MWU40eFFDenM3RXg1eVpVajRINmtn?=
 =?utf-8?B?bDgybHhkUC9qZ01yV1lOeFp5bGtsekgvTTdIRnZhUk9zOVpBNmxmc2ZSWTJw?=
 =?utf-8?B?ZXB5eCsveE9UcDlIT2xScDVWZktic1BTQU9LR3hDcGwxOEtlYy9XMHRnZWZi?=
 =?utf-8?B?TmhZTXV2Z3JydmhndDhLRGNuMU1CZDVtazJuM2dOVXJwT0NkM0VIcVdEY2g5?=
 =?utf-8?B?aGlmdXRhUDhtd2hMaVlmMUg3N05IZHlKa3BkOGRqZktBUjNXcDVjUGVLZ3p5?=
 =?utf-8?B?Nk0vSW9LRnNNSk1pdTMrUkY0VWRuL3VUVUo0bEZLNXJLMC83U1JyeVBaMGxk?=
 =?utf-8?B?cDJhczF1UFhzMTFDL0ltZGJPai9MVG56dU92WkJVUWJFVXZDdGpYR0lZdHV0?=
 =?utf-8?B?Q1FDUklQeHpxelVzdVlmaHd2M2M3eFI3TkE3b1h5VE9jK2JxY3Y3NHFzKzJY?=
 =?utf-8?B?bWhsRmUyQjN6L3IzbTNCb1FVdnhueFF0RkE1OUVHT1ZLZlUzbW5QWHJzbGhX?=
 =?utf-8?B?MCtWY3JmbXd6NmJGUml2NlkrdmFxSmJtejR4eE83ZzVwY3VuWE8yTEJ6VHdw?=
 =?utf-8?B?c1E5RVpRTlNvdVI2b3gvVFJWbXhDanZ6NGM5citTSEZWemJ6R0hPS21mRUdU?=
 =?utf-8?B?Y0IzaXRtM0NzUHVLbUg5amVLY3paOE1DVmVRWGUxVWpaUnVCUzVnZFNZQWc2?=
 =?utf-8?B?KyszbFZnMlRYWm9EamdKWVVuMlBIajBZYStUdGJDVTJ5RWkxOXVxbFIxUGlI?=
 =?utf-8?B?aGd3UXprenRFeUNSWEF2TmpFZXpmSGU0VFRLb3oyeVRBTzZVNDg1K1VvNldF?=
 =?utf-8?B?aW02UVFBbndjNXNQWml3ZDRPSEJCRGsrRjdocTdsb1NzQXBCUGlwcWZVYnZH?=
 =?utf-8?B?b2JHWkFnT2ZuT3pzMzdBY1RnWmdlZGxsR0M4eDJ4d2xHOUQrcDVrcXRoZVA1?=
 =?utf-8?B?YjJnZzl6WXlFZEh2bDB6RURBRDY3eG1TK2tKaENJUmI1Zm9yVUhRbWtrY1JC?=
 =?utf-8?B?YUxWbEpwUE9lVEFOVU9pYjducEpneDJQeXRJZXIvTzRob2RRYmJkRVZ1djZs?=
 =?utf-8?B?emZ4WUtsSDVWWUphUTNVd3habnc4a3dZNWF6S3JYV2NUVG0xckdzSEtFeFh0?=
 =?utf-8?B?VmYzN1FhYjFLaXZlV1EwOGh1SndiYm1JaGUybmc1Z2t5WUhJRng2eENrbThy?=
 =?utf-8?B?b1A5YUdsc0JmcjVodlRDSXZtYmpHaTl4eU8wTTBoSEpQZG0zTDQ5VGFjWEJI?=
 =?utf-8?B?WnZLMGRUWUY4emYzeEpKOThGcGx6eEpVdWZoOFIvTVFON2tyQkkwNmVrN29s?=
 =?utf-8?B?dnJqRlBiRmlFdVRnam1LYnZpTnBZazYwMWlsVzlkbjJWUWp0RXpIZFVmWUVX?=
 =?utf-8?B?T3FpNTFhTm1pM2hpYjVmTUhEcnlzQ3JFQVNkMFFGMWlCdnJmNjdjMnRKckFN?=
 =?utf-8?B?aFdmZEVjajJTTDlObTlMTUVOU3JjTUEzaG5VeHdPQUpvdHZ5RnZpK0RkNU1x?=
 =?utf-8?B?MmIvU0x6bHVCSlRmeVpCbnVqTHVqUS96ckdvKzYwVnlKRGJkWi9rRHVXa21M?=
 =?utf-8?B?UU85VHEzc3l5QlRBblBYYlpQVmNjaUJYaGNoSmE1d1JvWlJ2N0JuUkViYzg0?=
 =?utf-8?B?eGdmdFMwSy9MVjkyb2M0L2ptU29EWlBycWRhK3FTbE0xbXZyZVRHeml0S3Rs?=
 =?utf-8?B?Mzh5TDV2TnVWa2JkVE5qNFg0Sk9yMnRNV21rWEVIdnM0aUdkUUhFR2x2ZFox?=
 =?utf-8?Q?CEqz9xE2vU5FHQVA=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wY0rMpBcHFoOO36dXryymqUM6Jx0pcGO1IhPlI6uvbv5fnM7B96lJk9eIheTjK6JoTHvIrW/isKtWokjfQQrt5iVOvjmbguCryEfZQ9mEtMnTDTTRap3f3A2kbNqUDe2I6hPMvCntBUM04CcdvG29JJNXhxU40mJ7AFO5ZxwvoeyHaeCVgjmfqAqvpHZqQl+Vk2b1sIt/LvCm2eZF1sxjLQGOrMgSGEleqeG13emDiwqLyNgSHYQeN0/RLY/pTaL8iTPxbP0giZKha0Z5ZssCcsV1DXZbs6XbHUive5G5jbGo7E26pke2WIUHxwgW0IVXefxqnE1a5xUYamrAW9pzQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3401c598-72ac-4c76-a95b-08deaab88449
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 15:11:00.3021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9O8jINny6M0fnWWEvi9I4mEBGDgY0Af4WtHph2YyMhHwQAFq4LPRcDAR6vuvm8WfjQByPEo3jByJlLUzFgX23jtGwX+JeSj/LeRy+McDqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7342
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jpjjfXyyxixweKXm0_l0KZ2Ik1_IsVR8UXbHrukiYjM_1777993863
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 6E4F84D0303
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.94 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284469-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[onsemi.com:s=mimecast20250127];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_POLICY_ALLOW(0.00)[onsemi.com,reject];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	NEURAL_SPAM(0.00)[0.835];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgTWF5IDUsIDIwMjYgNjo0NSBBTQ0KPiBU
bzogU2VsdmFtYW5pIFJhamFnb3BhbCA8U2VsdmFtYW5pLlJhamFnb3BhbEBvbnNlbWkuY29tPg0K
PiBDYzogUGllcmdpb3JnaW8gQmVydXRvIDxQaWVyLkJlcnV0b0BvbnNlbWkuY29tPjsgYW5kcmV3
K25ldGRldkBsdW5uLmNoOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUu
Y29tOyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOw0KPiBrcnprK2R0QGtlcm5l
bC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgMS81XSBkdC1iaW5kaW5nczogbmV0OiBhZGQg
b25zZW1pJ3MgVFMyNTAwL05DTjI2MDEwDQo+IDEwQkFTRS1UMVMgTUFDUEhZDQo+IA0KPiANCj4g
VGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+IFRoaXMgbWVzc2FnZSBj
YW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4NCj4gDQo+IE9uIEZyaSwgTWF5IDAx
LCAyMDI2IGF0IDA3OjE1OjE3UE0gKzAwMDAsIFNlbHZhbWFuaSBSYWphZ29wYWwgd3JvdGU6DQo+
ID4gQWRkIFlBTUwgZGV2aWNlIHRyZWUgYmluZGluZyBmb3IgdGhlIG9uc2VtaSBOQ04yNjAxMCBh
bmQgVFMyNTAwDQo+ID4gSUVFRSA4MDIuM2NnIGNvbXBsaWFudCBFdGhlcm5ldCB0cmFuc2NlaXZl
ciBkZXZpY2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2VsdmFtYW5pIFJhamFnb3BhbCA8
U2VsdmFtYW5pLlJhamFnb3BhbEBvbnNlbWkuY29tPg0KPiA+IC0tLQ0KPiA+IC4uLi9iaW5kaW5n
cy9uZXQvb25ubixuY24yNjB4eC55YW1sIHwgNzEgKysrKysrKysrKysrKysrKysrKw0KPiA+IDEg
ZmlsZSBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspDQo+ID4gY3JlYXRlIG1vZGUgMTAwNjQ0IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvb25ubixuY24yNjB4eC55YW1sDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25l
dC9vbm5uLG5jbjI2MHh4LnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbmV0L29ubm4sbmNuMjYweHgueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4g
aW5kZXggMDAwMDAwMDAwLi4xOThjZDdlOWQNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9vbm5uLG5jbjI2MHh4LnlhbWwN
Cj4gPiBAQCAtMCwwICsxLDcxIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChH
UEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ICslWUFNTCAxLjINCj4gPiArLS0tDQo+
ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbmV0L29ubm4sbmNuMjYweHgu
eWFtbCMNCj4gPGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL25ldC9vbm5uLG5jbjI2MHh4
LnlhbWwjDQo+IHZpY2V0cmVlLm9yZz4NCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+IDxodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0
YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gbj1kZXZpY2V0cmVlLm9yZz4NCj4gPiArDQo+ID4gK3Rp
dGxlOiBvbnNlbWkgTkNOMjYwMTAvVFMyNTAwIDEwQkFTRS1UMVMgTUFDUEhZIEV0aGVybmV0IENv
bnRyb2xsZXJzDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArIC0gUGllcmdpb3JnaW8g
QmVydXRvIDxQaWVyLkJlcnV0b0BvbnNlbWkuY29tPg0KPiA+ICsgLSBTZWx2YSBSYWphZ29wYWwg
PFNlbHZhbWFuaS5SYWphZ29wYWxAb25zZW1pLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9u
OiB8DQo+ID4gKyBUaGUgTkNOMjYwMTAgYW5kIFRTMjUwMCBjb21iaW5lIGEgTWVkaWEgQWNjZXNz
IENvbnRyb2xsZXIgKE1BQykgYW5kIGFuDQo+ID4gKyBFdGhlcm5ldCBQSFkgdG8gZW5hYmxlIDEw
QkFTReKAkVQxUyBuZXR3b3Jrcy4gVGhlIEV0aGVybmV0IE1lZGlhIEFjY2Vzcw0KPiA+ICsgQ29u
dHJvbGxlciAoTUFDKSBtb2R1bGUgaW1wbGVtZW50cyBhIDEwIE1icHMgaGFsZiBkdXBsZXggRXRo
ZXJuZXQgTUFDLA0KPiA+ICsgY29tcGF0aWJsZSB3aXRoIHRoZSBJRUVFIDgwMi4zIHN0YW5kYXJk
IGFuZCBhIDEwQkFTRS1UMVMgcGh5c2ljYWwgbGF5ZXINCj4gPiArIHRyYW5zY2VpdmVyIGludGVn
cmF0ZWQgaW50byB0aGUgTkNOMjYwMTAuIFRoZSBjb21tdW5pY2F0aW9uIGJldHdlZW4NCj4gPiAr
IHRoZSBob3N0IGFuZCB0aGUgTUFDLVBIWSBpcyBzcGVjaWZpZWQgaW4gdGhlIE9QRU4gQWxsaWFu
Y2UgMTBCQVNFLVQxeA0KPiA+ICsgTUFDUEhZIFNlcmlhbCBJbnRlcmZhY2UgKFRDNikuDQo+ID4g
Kw0KPiA+ICsgU3BlY2lmaWNhdGlvbnMgYWJvdXQgdGhlIE5DTjI2MDEwIGNhbiBiZSBmb3VuZCBh
dDoNCj4gPiArIGh0dHBzOi8vd3d3Lm9uc2VtaS5jb20vZG93bmxvYWQvZGF0YS1zaGVldC9wZGYv
bmNuMjYwMTAtZC5wZGYNCj4gPGh0dHBzOi8vd3d3Lm9uc2VtaS5jb20vZG93bmxvYWQvZGF0YS1z
aGVldC9wZGYvbmNuMjYwMTAtZC5wZGYNCj4gbj1vbnNlbWkuY29tPg0KPiA+ICsgaHR0cHM6Ly93
d3cub25zZW1pLmNvbS9wcm9kdWN0cy9pbnRlcmZhY2VzL2V0aGVybmV0LWNvbnRyb2xsZXJzL3Qz
MGhtMXRzMjUwMA0KPiA8aHR0cHM6Ly93d3cub25zZW1pLmNvbS9wcm9kdWN0cy9pbnRlcmZhY2Vz
L2V0aGVybmV0LWNvbnRyb2xsZXJzL3QzMGhtMXRzMjUwMA0KPiBzZW1pLmNvbT4NCj4gPiArDQo+
ID4gK2FsbE9mOg0KPiA+ICsgLSAkcmVmOiAvc2NoZW1hcy9uZXQvZXRoZXJuZXQtY29udHJvbGxl
ci55YW1sIw0KPiA+ICsgLSAkcmVmOiAvc2NoZW1hcy9zcGkvc3BpLXBlcmlwaGVyYWwtcHJvcHMu
eWFtbCMNCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyBjb21wYXRpYmxlOg0KPiA+ICsg
Y29uc3Q6IG9ubm4sbmNuMjYweHgNCj4gDQo+IERvbid0IHVzZSB3aWxkY2FyZHMgaW4gY29tcGF0
aWJsZSBzdHJpbmdzLg0KPiANCj4gPiArDQo+ID4gKyByZWc6DQo+ID4gKyBtYXhJdGVtczogMQ0K
PiA+ICsNCj4gPiArIGludGVycnVwdHM6DQo+ID4gKyBkZXNjcmlwdGlvbjogfA0KPiANCj4gRG9u
J3QgbmVlZCAnfCcuDQo+IA0KPiA+ICsgSW50ZXJydXB0IGZyb20gTUFDLVBIWSBhc3NlcnRlZCBp
biB0aGUgZXZlbnQgb2YgUmVjZWl2ZSBDaHVua3MNCj4gPiArIEF2YWlsYWJsZSwgVHJhbnNtaXQg
Q2h1bmsgQ3JlZGl0cyBBdmFpbGFibGUgYW5kIEV4dGVuZGVkIFN0YXR1cw0KPiA+ICsgRXZlbnQu
DQo+ID4gKyBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArIHNwaS1tYXgtZnJlcXVlbmN5Og0KPiA+
ICsgbWluaW11bTogMTUwMDAwMDANCj4gDQo+IEEgbWluaW11bSBpcyBzdHJhbmdlLiBXaGF0IGlm
IHlvdSBoYXZlIGEgYm9hcmQgaXNzdWUgcmVxdWlyaW5nIGxvd2VyDQo+IGZyZXF1ZW5jeT8NCg0K
SGFkIHRoZSBzYW1lIHF1ZXN0aW9uIGluIGludGVybmFsIHJldmlldy4gRGF0YXNoZWV0IHNheXMg
dGhlIG1pbmltdW0gc3BlZWQgMTUgTUh6IGlzIG5lZWRlZC4gVGhhdCdzIHdoeSB3ZSBoYWQgcGxh
Y2VkLg0KDQo+IA0KPiA+ICsgbWF4aW11bTogMjUwMDAwMDANCj4gPiArDQo+ID4gK3JlcXVpcmVk
Og0KPiA+ICsgLSBjb21wYXRpYmxlDQo+ID4gKyAtIHJlZw0KPiA+ICsgLSBpbnRlcnJ1cHRzDQo+
ID4gKyAtIHNwaS1tYXgtZnJlcXVlbmN5DQo+IA0KPiBOb3JtYWxseSB0aGlzIGlzIG5vdCByZXF1
aXJlZC4gSXQncyBvbmx5IGZvciBib2FyZHMgd2hpY2ggY2FuJ3Qgb3BlcmF0ZQ0KPiBhdCB0aGUg
bWF4aW11bSBmcmVxdWVuY3kgb2YgdGhlIGRldmljZS4NCj4gDQo+ID4gKw0KPiA+ICthZGRpdGlv
bmFsUHJvcGVydGllczogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgLSB8DQo+
ID4gKyBzcGkgew0KPiA+ICsgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAjc2l6ZS1jZWxs
cyA9IDwwPjsNCj4gPiArDQo+ID4gKyBldGhlcm5ldEAwIHsNCj4gPiArIGNvbXBhdGlibGUgPSAi
b25ubixuY24yNjB4eCI7DQo+ID4gKyByZWcgPSA8MD47DQo+ID4gKyBwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOw0KPiA+ICsgaW50ZXJydXB0LXBhcmVudCA9IDwmZ3Bpbz47DQo+ID4gKyBpbnRl
cnJ1cHRzID0gPDI1IDI+Ow0KPiA+ICsgc3RhdHVzID0gIm9rYXkiOw0KPiANCj4gRHJvcC4gRXhh
bXBsZXMgYXJlIGFsd2F5cyBlbmFibGVkLg0KPiANCj4gPiArIHNwaS1tYXgtZnJlcXVlbmN5ID0g
PDI1MDAwMDAwPjsNCj4gPiArIH07DQo+ID4gKyB9Ow0KPiA+IC0tDQo+ID4gMi40My4wDQo+ID4N
Cj4gPg0KPiA+IFB1YmxpYyBJbmZvcm1hdGlvbg0KDQo=


