Return-Path: <netdev+bounces-283299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPjnGlQb9WkoIgIAu9opvQ
	(envelope-from <netdev+bounces-283299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 23:29:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 668804AFD08
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 23:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74C3F30069B7
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E716E36C9EC;
	Fri,  1 May 2026 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="ic4JlM2K"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1823E25B
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670509; cv=none; b=NO4qWdMK9KvS8PGMAsNL19EKrj/jrIY58lNpwdRwbhgptUvmEnd5j1ryuMrpI2ARvqAFKplqAcPfQmM86IpXe3oWX083QsaG3qlHSaIi3MU3Wk2osQLTYly7AUP4EkUApfUnuS+4J3HGCDCo2J/pf7oLQyMeTUMu/3qjBk2l/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670509; c=relaxed/simple;
	bh=pAc0aeeES1GwV/edPTdyMTin5UE74cike2dWRJ04onU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FTWl4vp1UWyzZFFgFrtIg4qgBG+NPxg6X5u2CxJOsYZO7lAIeR4EXHL3kdJv1T1+X1wMcR2s0p7d71wnAls7gveyWMapxEEIieWfLnAeNNZydQburQUqMlV1aLmE5IjJj8kaObM878aOJ+DS5nTSrzLsGSKmpZiMKaF1/r3Qzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=ic4JlM2K; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1777670508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAc0aeeES1GwV/edPTdyMTin5UE74cike2dWRJ04onU=;
	b=ic4JlM2KDNEB4ngiFb3W+ty6Bv0viZEkho1D8FFAte0+m018zz7FCHfLU6ADMlMpOsI6w5
	eswpZxtMSmrB8Oj4C19GGBZcr5FMK5/WNpssnnaHt0Lq0422NI7vh4hm8tuRsNjXdyrZ+E
	OQ2uAWDdb/+/hwf3k415VPR4+G+UEXIZJfiyNfPVN63MllQzj6eaZYPv3Dg33UP7Rnj+5l
	YSlaFlDjxRqbBh6xoEzq7ZiJewkMEOQWX+GG2dhm3Ld6KsaqnHjRvw5WRgbC62PihQGdUX
	dNWB/rksB68xPawl5sTKxpcTHjtQawEHpyBEyUVJJ5hAyRN9qKrWwix/OuI1KA==
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-11-FyiHj2-ZMYKmoJb-5eXx6Q-1; Fri,
 01 May 2026 14:21:41 -0700
X-MC-Unique: FyiHj2-ZMYKmoJb-5eXx6Q-1
X-Mimecast-MFC-AGG-ID: FyiHj2-ZMYKmoJb-5eXx6Q_1777670498
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CH2PR02MB6904.namprd02.prod.outlook.com (2603:10b6:610:83::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 21:21:36 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 21:21:36 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "edumazet@google.com" <edumazet@google.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/5] dt-bindings: net: add onsemi's
 TS2500/NCN26010 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next 1/5] dt-bindings: net: add onsemi's
 TS2500/NCN26010 10BASE-T1S MACPHY
Thread-Index: AdzZlV5WH2ywWnNEREiWlMiVKhqFigAFMS2AAAGQExA=
Date: Fri, 1 May 2026 21:21:36 +0000
Message-ID: <CY8PR02MB9249D3A9C1F649451618C80583322@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <177766776795.356932.18256256609588920036.robh@kernel.org>
In-Reply-To: <177766776795.356932.18256256609588920036.robh@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CH2PR02MB6904:EE_
x-ms-office365-filtering-correlation-id: 227aee77-f718-4308-27f5-08dea7c7a05d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021|56012099003|18002099003|22082099003
x-microsoft-antispam-message-info: i4mRU6Z+GHdSZ0ejLq45/6s6Arz8Jtu/NnZucNYe3T7jFD77vYAvAz4lGg6uU5ynQfvQvMV6yPO8RnK+mYZF/3Kq420haZZAoGrvXNIkb8XtRTHTI7q92gT03uR+rdTWlbZKNSYUQVZmKVFSHDrqgeEzTALrzZ/JBpj4sAz9Oz8BAABaGFGuYqzOfuRjeiNVktLPg1NhWHz1JU213yLam1AtnhRvYcqyvwAg8jUq/sAJ5JV+wTCmS6f2yvWKlcJeVXMpKGvSxl746QUQH3zVX51XGyrGCWirrniLHSMBrJPkn4snhXwnEx/PTQTDtbRu58xxFYouWrwiT4Z3dtHStdpTqf0/fIhYGJeQXcJ/hTjgfZ73UnPTMgz+aMppmviwt4AMxJO5ZYRafdlxCpk5WgPPo+epCNAgwiaDnO2/U9el+AHPbfPlQDhAb94PVjsnxU6LSEeyLmcoiQoa8xmqcjyMDlrz5ZE62AJ+gGOQ6ISx2vPB4byOuRlU7EEV2Wlr3yAuDH8K2SP8r+u5oe3k8J7CmeU1xQuA5XBe+9CQlTefDypaVMe8ekVCBcEzjXPeaezEJvsL9DPl+ctuz/A6EqfMY6vbwFcibZ3FfZAstaWiVVf8NUGaluvk2BDoZJ67cg8L1tbJYXwwKq+PCnx+RN5AapD3WCdVB0aIQZDqsMI2F+i2vOzHeSkvAhql3pbWNWnN4GSCh8UPr/AQ1H6aPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFdWVWNLTWp5dHl3U21pbDIyM29oR01STThCS2FDYmlIc1BlTSswbVRGSVJ6?=
 =?utf-8?B?K09aTnpsVlF0RDhWeWNNSmhQdHZkWWN2RmorUHhLYUVia0w5QXIxaEhkcmpN?=
 =?utf-8?B?WFE4NXN5SnJZRE1RZzBHOG1NNWVvalZaaXNWdnV2b1N1aUQwNjdPeTFzdWJh?=
 =?utf-8?B?MytUSE5BQWRyZXcvSkRTaW01R09QRWpRZGxVU1V0TXJmT210QkdEa2ZpNG8v?=
 =?utf-8?B?emlBbEdjbUlKWUQwU0xmQUpuTzB2Y0tMenlOUWJCNml4UTI0cFBVM3BmWSt1?=
 =?utf-8?B?ai9TaFFWTkVMa0ZWUXYyM3p3VW56MHQ3czczQXFhMlcrK2x1VElIMFBkM083?=
 =?utf-8?B?UEVoQnNFTW13WlpYb0lqZ2lyVnZZSnA1RHYraExGRFZaeXJuWmFLNE5KM0U3?=
 =?utf-8?B?akRmcnBuMFM1MDBIODZCdWhIRGNHc2tnTXN0MFVhYXNtdEg2bnMrcnJJNkQ5?=
 =?utf-8?B?RlA4OWkvU3UvZW1NQmtacG1SM1MyQ1Z3TDNUMThUSjh6SHVQVlRLRi85RHpj?=
 =?utf-8?B?SXhUeWJEVWVlRWtNK2JNTndFeEtvaHNJOGVBb2szbXlDT0cvdFpQT1QxeTVa?=
 =?utf-8?B?MXZkamNaRnNwaDJaZTJmTDYvdFpyUnJ1YnRtMmdZWWNpSnovdCs4WkttRjBZ?=
 =?utf-8?B?cTV5dXpnUVJYa2tKTTI5N3NRSGdvbmRnSmliempneWpybWtzUG1LZ2xxRnRa?=
 =?utf-8?B?cmR2cHlmTGx3NFE1eWh5cnovci9xT0NPMm5TV0ZBbk04V2s0RUF0RWxNd1RQ?=
 =?utf-8?B?UG1UcnpkSXJmenY2ZWpGRTFrcFhGNW9FMVpqN0lpZUxTbUxhaERFMC9veFdZ?=
 =?utf-8?B?Q3YzOE1Ec2ltVWsvbEt1eGs2SmtXMUVqaUlFTllwUUlpNWZQSHBZVFQxL1Ur?=
 =?utf-8?B?Qk5nN1BXRXJySG52YkUwbk9DMUFEOVdMUzd4UWpHMEgrNW85clZTeHhGV1FM?=
 =?utf-8?B?MXJkZEc2cmc0QlBnV0hCVGdvL1FaV2VNazJIWDI5alpjaXNuT3NLYTlsakZN?=
 =?utf-8?B?d1JWUWMya2h3N3luSFZ0TkkydE9aMXJ2TEY2YnEySm96dW96ckhlYnhjQmZt?=
 =?utf-8?B?bmJzWUFGc1BWN3NVVjB3aWdOU2hKNkpwdlZEdm9qRXVZdFZmeU9vOGUvNnlK?=
 =?utf-8?B?Ukh1eXhpMXFhTXV0K21yQ1Q3N1lEVG1oSjZjQUhCb2xzb0JtY3lJRHRFcmY1?=
 =?utf-8?B?SzQzWnAvenBJRnNGclNncDlGYUZZVHVUUENab1FRdHVIUVFlaEFDaDBoT0h3?=
 =?utf-8?B?QnFOZ1Y3ZFNoZXZ5MkVSNHZQcWpxMU5ubTFXZUc0OENWZjFmQ28zMU5PZ0tE?=
 =?utf-8?B?cDEvV1ZYdk1USFZTK3VrRCtJRUtESVg0cmVrUzhFOXN0ZTQ5WVk5Wkc3TEtU?=
 =?utf-8?B?TUd0eGo5K1lpOUE2bFEwbUpFcysyYlNoSEFadFh0S01yS0hCM2JBc2NXTUg0?=
 =?utf-8?B?SVRjUWV4ekpFVTdiK0I4K3Q3TytYUjRML3Y0ZVlxSmpJd0JZRndJTUZrQjZO?=
 =?utf-8?B?ZjFaVlZCUHVJbGdRVlhFNERwYlRmOEJ4R2s0UUpyZXBndFNac1BQMFlLSjl2?=
 =?utf-8?B?enZpUGdTZVk5UkNvekswa3hHdmtXSkg5ZUg4WjlXRFdITzdSRENublRMYkpI?=
 =?utf-8?B?TjV0UkJIc3RtOGdYWUZyaFdMMmttUWJuSWl3SE41Sklsc2lpODBxQ1pqL291?=
 =?utf-8?B?QW94N1V2Q1p3SmZzMDgvTU8wdUt6VU45Wko0bk9ONm1QTUNUTVc5MnhwOXdO?=
 =?utf-8?B?dlkrSy9jT3IrSlg5M2VEZlNHa2hscTkxelVSMnNFcHBYWnkrTWk0T2ZPajlL?=
 =?utf-8?B?T29vQTdxVjNSZzV0cEtWRWZobUdlQmRxeXRGTEx0NEFtR3E4TGpIZnc5cGFX?=
 =?utf-8?B?MHNKaWV0cTRpMWlWVGwzQjVaeVFDQ2tPZ0tkbklGazZuWEovd3lhZXJhb0JX?=
 =?utf-8?B?U012QkFIK1VIb0tHc04vdC9OblZFTzVFMmxxaURPRC81STNUTTlSd1ovWGtK?=
 =?utf-8?B?T0VaYkNUYVVHSnIzMjhBZlc3U21mTGFtdDU1R0VHZlY5L1RoNnVsTXV2TE93?=
 =?utf-8?B?eXVvTG5yY3JRbnNBUTQvdnoyWlFTSEUzNVJVVGduTkVCYVozYThQOE8ycFJ0?=
 =?utf-8?B?OFEvNnFESDBZQVB1ZDZxU25WU2htcHhadGxKdlVTNFlJOFVIa3hZWGNZMWYw?=
 =?utf-8?B?OG50d1l0Z2RyeHVZY2JIWCtnYUVsU09IamhGQlAraW1XdEhrQUpOaEN3bGR0?=
 =?utf-8?B?alBiUkZrcjI5a01SSVo1YUIzN2wwbzFsQ0lrc0NKVUpHNzdWMGVwVVV0c0NQ?=
 =?utf-8?B?Rk12a0djcitVMFNKZE5xMm1CV1FZTVVEdmVqMGhOdVlJUVVVc1Z1QTJwdTdB?=
 =?utf-8?Q?gt5bd5/VH9TTMmEA=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LtHbZfgzqvRFS7EtuazlipzbmU1h6fp/NQxMfztB86Dkzs7Ft/jzVG1LGHsYIJbHSwprYFqkx1qEOho1ihx1CgD52HoOXfUzJcKI2EROoaxtnaIKvE7vu9/ljQDmsaxVuYxfUIWPNqDtlnG/9ck6ZSBQkpaRGdKbejNvR+yDqUjj2m1JMUoJ/RJoNI7ZVx0TLQyI/C7C1Y9sTzbCRjpcGfUKx1jTba3eJE+WLsnx/qJ/pcgaAefqYhI+Jr5D1FkxQ4zixMYSO5Zi8TaSsJ6LoIJ0BxdlHtE966xyEynUn3Lu00CtO05ea+2bUEMK73uAP9mWUDTmTCSqSdFrQSlcng==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227aee77-f718-4308-27f5-08dea7c7a05d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 21:21:36.3532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lls6efdge4W8oBFAl3q2Bka1o1+xyamMZfXdaT1pCfHqcBDQ+9pD8LAxwzxgtrgupBC1KPz5K7QGpwlHlQfx6c9Da2UEN18VBJsVHaEaSJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6904
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xuB6MxbYUzOsaFjJ9jLbY32wxeKXaTvMG00igYbmg_I_1777670498
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: 668804AFD08
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.94 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[onsemi.com,reject];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283299-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[onsemi.com:s=mimecast20250127];
	DKIM_TRACE(0.00)[onsemi.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.744];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	MISSING_XM_UA(0.00)[];
	REDIRECTOR_URL(0.00)[mimecastprotect.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[]
X-Spam: Yes

VGhhbmtzLiBJIGRpZCB2ZXJpZnkgd2l0aCBkdF9iaW5kaW5nX2NoZWNrLiBXaWxsIHVwZGF0ZSBh
bmQgcmUtcnVuDQoNClNpbmNlcmVseQ0KU2VsdmENCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyAoQXJtKSA8cm9iaEBrZXJuZWwub3JnPg0KPiBTZW50
OiBGcmlkYXksIE1heSAxLCAyMDI2IDE6MzYgUE0NCj4gVG86IFNlbHZhbWFuaSBSYWphZ29wYWwg
PFNlbHZhbWFuaS5SYWphZ29wYWxAb25zZW1pLmNvbT4NCj4gQ2M6IGVkdW1hemV0QGdvb2dsZS5j
b207IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBQ
aWVyZ2lvcmdpbyBCZXJ1dG8gPFBpZXIuQmVydXRvQG9uc2VtaS5jb20+OyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOw0KPiBrdWJhQGtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGFuZHJl
dytuZXRkZXZAbHVubi5jaDsga3J6aytkdEBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNv
bTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5l
dC1uZXh0IDEvNV0gZHQtYmluZGluZ3M6IG5ldDogYWRkIG9uc2VtaSdzIFRTMjUwMC9OQ04yNjAx
MA0KPiAxMEJBU0UtVDFTIE1BQ1BIWQ0KPiANCj4gDQo+IFRoaXMgTWVzc2FnZSBJcyBGcm9tIGFu
IEV4dGVybmFsIFNlbmRlcg0KPiBUaGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBv
cmdhbml6YXRpb24uDQo+IA0KPiANCj4gT24gRnJpLCAwMSBNYXkgMjAyNiAxOToxNToxNyArMDAw
MCwgU2VsdmFtYW5pIFJhamFnb3BhbCB3cm90ZToNCj4gPiBBZGQgWUFNTCBkZXZpY2UgdHJlZSBi
aW5kaW5nIGZvciB0aGUgb25zZW1pIE5DTjI2MDEwIGFuZCBUUzI1MDANCj4gPiBJRUVFIDgwMi4z
Y2cgY29tcGxpYW50IEV0aGVybmV0IHRyYW5zY2VpdmVyIGRldmljZXMuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2Vt
aS5jb20+DQo+ID4gLS0tDQo+ID4gLi4uL2JpbmRpbmdzL25ldC9vbm5uLG5jbjI2MHh4LnlhbWwg
fCA3MSArKysrKysrKysrKysrKysrKysrDQo+ID4gMSBmaWxlIGNoYW5nZWQsIDcxIGluc2VydGlv
bnMoKykNCj4gPiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL25ldC9vbm5uLG5jbjI2MHh4LnlhbWwNCj4gPg0KPiANCj4gTXkgYm90IGZvdW5kIGVy
cm9ycyBydW5uaW5nICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIG9uIHlvdXIgcGF0Y2g6DQo+IA0K
PiB5YW1sbGludCB3YXJuaW5ncy9lcnJvcnM6DQo+IA0KPiBkdHNjaGVtYS9kdGMgd2FybmluZ3Mv
ZXJyb3JzOg0KPiAvYnVpbGRzL3JvYmhlcnJpbmcvZHQtcmV2aWV3LQ0KPiBjaS9saW51eC9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L29ubm4sbmNuMjYweHguZXhhbXBsZS5k
dGI6IGV0aGVybmV0QDANCj4gKG9ubm4sbmNuMjYweHgpOiAncGluY3RybC0wJyBpcyBhIGRlcGVu
ZGVuY3kgb2YgJ3BpbmN0cmwtbmFtZXMnDQo+IGZyb20gc2NoZW1hICRpZDogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL3NjaGVtYXMvcGluY3RybC9waW5jdHJsLWNvbnN1bWVyLnlhbWwNCj4gPGh0dHBz
Oi8vdXJsLnVzYi5tLm1pbWVjYXN0cHJvdGVjdC5jb20vcy9WWm1hQ3pxZzFSaE1LTlhBTWlnaUxV
OU0tDQo+IDFXP2RvbWFpbj1kZXZpY2V0cmVlLm9yZz4NCj4gDQo+IGRvYyByZWZlcmVuY2UgZXJy
b3JzIChtYWtlIHJlZmNoZWNrZG9jcyk6DQo+IA0KPiBTZWUNCj4gaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2RldmljZXRyZWUvcGF0Y2gvQ1k4UFIwMk1COTI0OUQwODNCNjM3
NDc3QzI1DQo+IDRGOUIwNTgzMzIyQENZOFBSMDJNQjkyNDkubmFtcHJkMDIucHJvZC5vdXRsb29r
LmNvbQ0KPiA8aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2RldmljZXRyZWUv
cGF0Y2gvQ1k4UFIwMk1COTI0OUQwODNCNjM3NDc3QzI1NEY5QjA1ODMzMjJAQ1k4UFIwMk1COTI0
OS5uYW1wcmQwMi5wcm9kLm91dGxvb2suY29tDQo+IHBhdGNod29yay5rZXJuZWwub3JnPg0KPiAN
Cj4gVGhlIGJhc2UgZm9yIHRoZSBzZXJpZXMgaXMgZ2VuZXJhbGx5IHRoZSBsYXRlc3QgcmMxLiBB
IGRpZmZlcmVudCBkZXBlbmRlbmN5DQo+IHNob3VsZCBiZSBub3RlZCBpbiAqdGhpcyogcGF0Y2gu
DQo+IA0KPiBJZiB5b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycgYW5kIGRp
ZG4ndCBzZWUgdGhlIGFib3ZlDQo+IGVycm9yKHMpLCB0aGVuIG1ha2Ugc3VyZSAneWFtbGxpbnQn
IGlzIGluc3RhbGxlZCBhbmQgZHQtc2NoZW1hIGlzIHVwIHRvDQo+IGRhdGU6DQo+IA0KPiBwaXAz
IGluc3RhbGwgZHRzY2hlbWEgLS11cGdyYWRlDQo+IA0KPiBQbGVhc2UgY2hlY2sgYW5kIHJlLXN1
Ym1pdCBhZnRlciBydW5uaW5nIHRoZSBhYm92ZSBjb21tYW5kIHlvdXJzZWxmLiBOb3RlDQo+IHRo
YXQgRFRfU0NIRU1BX0ZJTEVTIGNhbiBiZSBzZXQgdG8geW91ciBzY2hlbWEgZmlsZSB0byBzcGVl
ZCB1cCBjaGVja2luZw0KPiB5b3VyIHNjaGVtYS4gSG93ZXZlciwgaXQgbXVzdCBiZSB1bnNldCB0
byB0ZXN0IGFsbCBleGFtcGxlcyB3aXRoIHlvdXIgc2NoZW1hLg0KDQo=


