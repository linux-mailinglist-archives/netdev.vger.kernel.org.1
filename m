Return-Path: <netdev+bounces-293972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K5eBFRAHmraiAkAu9opvQ
	(envelope-from <netdev+bounces-293972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:30:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A36B6273BE
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 945A1301549E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7090333C1B7;
	Tue,  2 Jun 2026 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="PHWV8gIo"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD0363C62
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367419; cv=none; b=aL/Gph4a1yZlSaVHiEPMnv/GhA+y2L2BVW1pST7fs58XoF+UaIJElndu0b9Kis34OfU/IvoaoWhpOPauooWR88jGe+ff6h8Y68ajcvbYOh7NYcEw+X84EqPD2uFFKZVnmwMnBGRR/QyHbsOsAkFTgAsxhdvKRimzcn+O3Ej60n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367419; c=relaxed/simple;
	bh=IReGQKfSmU6Ldf+n3p86LFjuJqSw4XgALw6apZMYJrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Qlx3A5Ldy+caupmK3Riw2258xgaGdjynkoR/KhVzeUVfEXt4O0KRbRTZKltmHqViWrHFoZHgzxG5Yy3h73FSFC72K8J7fI2IYh5sUa7C/s12gm9EQbkT/O0q0PczNvGR/EX+e63NHCqoXiYaJls44tjqRgP+6RBEhxC3cexhaFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=PHWV8gIo; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780367413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IReGQKfSmU6Ldf+n3p86LFjuJqSw4XgALw6apZMYJrw=;
	b=PHWV8gIo/I7YS9cHBbZtJePl5qY3XCA3t7bYVpZQyv5ZIfiYobBKHkgH5cbzctnIhOJBGC
	AKxfpVyHb61EyP8Yy47CeGrtKu12yO2LIoynu1IyROIbvABvp33zZoXbeNdWdCipjfVAjk
	8T+z9ZPieoiY/gnUjjnd6uzQ8MR9YDjKXHmSwwOE4mWRHD1Xwc0uWoTwqp2VLCX0l2vGTx
	ymMg3xosOncO1v3btCRpVDOLMFBx36g209p6Ktofq/ipH0KUTXLq7+79PLnRUjpLxKgGlN
	xYe7owWLhaz9FZcIqQr6T8444uZBJzZFhnxVf/ZYhAV+KNJTnI1AJan6o66lfw==
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-56-SSBFc__aOwqABCPUWFa3ow-1; Mon,
 01 Jun 2026 19:30:09 -0700
X-MC-Unique: SSBFc__aOwqABCPUWFa3ow-1
X-Mimecast-MFC-AGG-ID: SSBFc__aOwqABCPUWFa3ow_1780367406
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by MN2PR02MB6880.namprd02.prod.outlook.com (2603:10b6:208:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 02:30:04 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 02:30:02 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 12/14] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Topic: [PATCH net-next v3 12/14] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Index: Adzvmc0U2pnkhYraSem3MympdkFZgwBdqRoAAEloMPA=
Date: Tue, 2 Jun 2026 02:30:02 +0000
Message-ID: <CY8PR02MB92498165068F7C2FAF9635C883122@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB92499D69207F6CFA01C196BB83162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <8331c347-4d40-43ac-aa73-a22398ac76a6@lunn.ch>
In-Reply-To: <8331c347-4d40-43ac-aa73-a22398ac76a6@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|MN2PR02MB6880:EE_
x-ms-office365-filtering-correlation-id: 2be3fa30-1947-4b8b-8ea5-08dec04ed990
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799006|4143699003|56012099006|38070700021
x-microsoft-antispam-message-info: bx7dDXgpF4RgQpqg+ySeN+7XT8hInal90igYMsDgjYo4Inrpn5RhFKRHSPQ7jySiqfd2aC7XA8TJAhvdGNbAEoyrj0SNURUmnkCQ373sJrQet5fww2j2Jv1iX61sDh0x52DmHSosJ6WbOu+5m0iWsrmZ5UL3uqS3HOZTrJlXsdAfQ6XQI0SIFQOVdVhi9SnFnBFmRjYVemVZltkoRQ6HImPQS0csBIdtqdcRAkLld01Zm18qgr1yWcGC49ixh+nQhYV4rbS6aPuFITjN8E/ImRpyiPmmeujYqVJ+GIIEr/za9uT26OWPa7cBpeAXeyyJRDVjXtZvvAWB7nXIQaffniX+uHsAodu7mpZTL2NsOsgIE/bIy/Ar2495jdxJJxB8dB2vlvVYUOVGhxDhg3VHmjzBR8OnaOt/AjiZpmptiRhlwznbzUhF4QyjYRS25smOsr+6mYKmtOO6ViUhFTReEuzl6BTrChgUTNexxRNTG4hbVZu4yKDjz7lkwNpPKJph3Jg+Z/e4jDna/NYi+vC6Oqm8LKyEx5fOag2C/obf1bIhkJGXBEWqSrH2g+XGQVVpTaMVMGciCAGtPdy/zVD69i33d0NXFfg+1saLebuMpceKw4FKFn4L50hRBjk7XVHwVq7cgbizUxq9VVzwpd+exlvcAhQIghpZrYgvoDz0xVwdZKHLwSVL1OHTlsPDPFaWwipSrY5BAJZOhlmLwXmZ4nQug3xEpeF43cUyX1NxRhH7iFprQF1MleooouBGbQt0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2NGWTdhb3E0bkM3Sk9KZEl4YkF6VmZES2c5Q2o3NDlkNE1Mb2RTMDVuL21u?=
 =?utf-8?B?ZE4zN2hRYTlINHJUbHYwVkIzVURLTGd5LzAxa1lkYit3c3VmQTdDNDBNNkRz?=
 =?utf-8?B?OUphanNBRk9rckVnNkN0Vk5zeHgrdVVQVkllMng4Z3ZhelYzYUdjdHhUYkpn?=
 =?utf-8?B?TGF4SUpkSzhrcUhDanV3ZXpvMW9kK2hBZDA2ZlNKU2lYWU1SZ2ZXN1pWS0Ru?=
 =?utf-8?B?TWVYVGxJcVlpVFVWWHdNODNoenlTeWZ2QUlXeFJrZDdveWpQTU5MQ1h6dWdD?=
 =?utf-8?B?U0h0YWtMb0dzOWFZYStEdzQwazdOcURqeFNSc2FHRmxvTG1PUHZsYTJ4WjVa?=
 =?utf-8?B?ZnFTeG01OGlFRWt3ZWFyNlQ5UExUbnZDQWFTbXFybWNIekJlckUzZlJzTGN4?=
 =?utf-8?B?Q2Z3OWNaWEdKUTdXM296SkoyK2JBWC9hdHE2TVlUTVM4WDVlWmhVY1hLeWJB?=
 =?utf-8?B?bmNidFBkRUxSWVdlVzM1SGpmMzFlNjlSQUtKczdBNXp1ZFBXQWxHcDBtZ2d2?=
 =?utf-8?B?UHY4a0lDaFRBRWVzRm9sU3FxbkwrTGJCb3o4WWk0UjdjUmtrc3V2MkhYem1I?=
 =?utf-8?B?NExqUWE0eXRXcG1zWU91S0lGNVJNZ2lhNm1BOHQvaW9mZlBFbGU1aml2QVd4?=
 =?utf-8?B?OCtYYm5seXpPVmlPd1NHV09vcTBtdldHT0JKeTBXL1N4L3cwK3AyYzJnRjZi?=
 =?utf-8?B?eTRHREFIWldvU3dPcDh2SnpCay84c0FCUWN3WjFkaCtBanRjVmFTSmNCZW43?=
 =?utf-8?B?dEdlOHNUS01vWndoQlZuT25PLzF1TmVNR3MxUTdBNlg0WmVleGZpTGxoaU0y?=
 =?utf-8?B?ekpUcDI1Uy9XVEx4K3lOTnM3d05rZmVHb3dtL3dSajZtWGFxMFFBOXc1bHJn?=
 =?utf-8?B?cXNZR1FCdEtpSURiUnNHMEJmUzk1TXowWGU1ZVNkWmJDWThWdTRMOS9tOG1Y?=
 =?utf-8?B?VG96RFNNU3RrczV4U3RnOFU0MThDaGpHeXlMVDNTMWpQeDFQcHQwU0VQMUFz?=
 =?utf-8?B?Y3lKK2NOdDJRS2JWK3FFb1B3MnJFaFNlc01qZW1yYi9oUkY3OEdOa3l3ZUJu?=
 =?utf-8?B?RkhWVy9NSkRWc1N5enBRVGwrZUcwaVVWcWo4eVovRkNnSVhFUGFQakdkdmNS?=
 =?utf-8?B?TXEwRWUrTkFTQnYra0V3bG12YjdXOUxUMlQwSVZwaWIzT1BPYWczNmhtcFlF?=
 =?utf-8?B?Y05zUWM1ck9LUWEzTEcvTUV4aEIwT3F2MFYzRWIwUEJKdHRBT3Iyak1TYlJF?=
 =?utf-8?B?OGdVY3hMNnB0eDBBSHUvZkdKbzRJL0x6ODZoS1U0eWZDa09Qc2N2VE5RWVBj?=
 =?utf-8?B?bnZXS29ncEptU0NGTUg5Z3BCck1TbEpLejNzQ3BlYnEwUkJjODB1bFBaTDVl?=
 =?utf-8?B?WVg1OGd5T2hQb2tTYlduUnlvMURpd1hyWXV4eTZoUW5uaDRPU0ZUOFgyL2Vw?=
 =?utf-8?B?dE9MN2tzcSs0K2lWQ1plNHEvSU1kM3lUaGQxdVYzVTBjaFlMMStoNkdtZXVy?=
 =?utf-8?B?bW9aMEFRQ05PTnBXR2RjdFNxcFRkSW5hNTZXanJHbXNKMXIrZnJZbEdML2di?=
 =?utf-8?B?WmkxVmdqejM3SHdQUjRrVWExa0c0emsyN3plQ09qVWFYenU4elNWSU1YclFi?=
 =?utf-8?B?R2psYjZ6bTFnVVR5bnZQalFCTXArQUdpai9YUmNmL0pxcXIwNGJFQkhQTEMy?=
 =?utf-8?B?WUlQZFl3KzYrMlVMMkRieSs3UnRaSmZvZk1JWkUyUzJVVHl5UGwrWkJFejdx?=
 =?utf-8?B?K0lwL2htdDRETmJWalZKOG0rYkRuSTlCa1gxVlRLZmI1bHNDNXBoQ2UwUWRO?=
 =?utf-8?B?VzNwdjJuOXNwQ3ZMV2NUNWlNSXo2dTVVeHR4ZEoxMy84dytjNUdEK3BMbmRB?=
 =?utf-8?B?ZDZKQXF0ekRFTGlnRzdOamMzV3dJNGtxVG53Z240UmUxYUdZSGJNWG9xUU5i?=
 =?utf-8?B?aDYyOWxLb3BkSjd2QkN6TzBJRTdwMEF0VEZWbFZKSFFoc1lXdHhiV2VmeCsy?=
 =?utf-8?B?QjIwU3lNUEN6bzRjU1cwcEVpTUkyR05rckh1aDIrc040L0ZqeExHWldaYTVw?=
 =?utf-8?B?eWxlQTVSS1RjUkI2SmR4Z00rRE4zbTdXUWZnbnpVRHZwYlBYSld0dmI1SGhN?=
 =?utf-8?B?emRzUncwOHd6T3E1bzRDSk9NM2I0dEsxTk1VWkZMWFdPSjZqZHNKNjVaUTVr?=
 =?utf-8?B?dWRxU1BhRnBBd29TdzFKQUlmd05TaDFxODRHWDFKRy9pYTFmbDBrd0lmOGRE?=
 =?utf-8?B?czVJWHhWRU90OW9mR3B2WGVTYVkyR0Vjd0tsM0NTclN4cDV2elRYL0o4eE0r?=
 =?utf-8?B?eGJUNkI2azRMWHB4UVQ1L2xIbk1sc2lHbHd0cjZVN256MGUwdld0SFVIeUlP?=
 =?utf-8?Q?HLRHzIkZFUv7ciQ8=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QyscfIke1XkOfyLJAeRBwL2Q5+VT0nYW1J7/Nv7Z0jYYqs0rwaxf3JwlmzGMTJAJe2RAe4FDfh9gVqH0ZAVUvZWlmahy/KykUxk/jpXwIkNuKKuvU+/tqRdctaqBC4W8P8BEN0pGyXDmv3LoMpsWGeTsho0nJjyv388F7Cs2am3nDCeW7cM8Xn4wnwO7kv6fjbxqc6bIHgJ19IAZqo7dDRceEfRJESGIULY/8R6sTSSA8zAKGF1/Z3/OAhcx7u56K1bfoTRI84Aj6jgr3Nl55NtvLNEJJ+f9fIZN1GLyS3VeOE/zEg/0DRLeDAAtxgsIDZjwiIRxGtnb05/6eV+VRw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be3fa30-1947-4b8b-8ea5-08dec04ed990
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 02:30:02.2789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzTuSHCvgF+kTP5jebFQkURnw/iQOH+oEPKJ/UVtFd9RSNCMdzgloGEVt1zt4w/SARLD02piJ5TDQig2XOhMRCAWdjv5jawkIgSuiB5+nkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6880
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DBp17ldVqS08owOinDGeJ_lwgxlZ7cWjXkYLDFfm8Rc_1780367406
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293972-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 8A36B6273BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiANCj4gPiArI2RlZmluZSBTMjUwMF9NTVNfTUlJIChTMjUwMF9PQV9UQzZfTUFDUEhZX01NUzAg
PDwgMTYpDQo+ID4gKyNkZWZpbmUgUzI1MDBfTU1TX01BQyAoUzI1MDBfT0FfVEM2X01BQ19NTVMx
IDw8IDE2KQ0KPiA+ICsjZGVmaW5lIFMyNTAwX01NU19QQ1MgKE9BX1RDNl9QSFlfQzQ1X1BDU19N
TVMyIDw8IDE2KQ0KPiA+ICsjZGVmaW5lIFMyNTAwX01NU19QTURQTUEgKE9BX1RDNl9QSFlfQzQ1
X1BNQV9QTURfTU1TMyA8PCAxNikNCj4gPiArI2RlZmluZSBTMjUwMF9NTVNfVlMxIChTMjUwMF9P
QV9UQzZfVlMxX01NUzEyIDw8IDE2KQ0KPiA+ICsjZGVmaW5lIFMyNTAwX01NU19WUzIgKE9BX1RD
Nl9QSFlfQzQ1X1ZTX1BMQ0FfTU1TNCA8PCAxNikNCj4gDQo+IFRoaXMga2luZCBvZiBzdWdnZXN0
cyB3ZSBzaG91bGQgcmV0aGluayB0aGUgQVBJIGZvciByZWFkaW5nL3dyaXRpbmcNCj4gcmVnaXN0
ZXJzLiBJdCBzaG91bGQgYmUgcG9zc2libGUgdG8gcGFzcyBNTVMgYW5kIHJlZ2lzdGVyIGFzIHNl
cGVyYXRlDQo+IHZhbHVlcywgYW5kIGxldCB0aGUgY29yZSBjb21iaW5lIHRoZW0uDQoNCg0KSSBh
Z3JlZS4gSW4gZmFjdCwgb25zZW1pJ3Mgb3JpZ2luYWwgaW1wbGVtZW50YXRpb24gaGFkIE1NUyBh
bmQgYWRkcmVzcyBhcyBzZXBhcmF0ZSBwYXJhbWV0ZXIuIA0KSXQgaXMgZ29pbmcgdG8gdG91Y2gg
YWxsIHRoZSBmaWxlcy4gTGV0IG1lIGtub3cgd2hldGhlciB5b3Ugd2FudCB0byBkbywgSWYgc28s
IHdoZW4uDQoNCg0KPiANCj4gDQo+ID4gKyAvKiBDb252ZXJ0IHRoZSBPSUQgaW4gaG9zdCBieXRl
IG9yZGVyICovDQo+ID4gKyBmb3IgKGkgPSAyOyBpID49IDA7IC0taSkgew0KPiA+ICsgYWRkcltp
XSA9IDA7DQo+ID4gKyBmb3IgKGogPSAwOyBqIDwgODsgKytqKSB7DQo+ID4gKyBhZGRyW2ldIHw9
ICh2YWwgJiAxKSA8PCAoNyAtIGopOw0KPiA+ICsgdmFsID4+PSAxOw0KPiA+ICsgfQ0KPiA+ICsg
fQ0KPiANCj4gVGhhdCBzZWVtcyBwcmV0dHkgY29tcGxleC4gV2hhdCBleGFjdGx5IGlzIGl0IGRv
aW5nPw0KDQpDb3VsZCBoYXZlIGJlZW4gd2VsbCBjb21tZW50ZWQuIEFjY29yZGluZyB0byBkYXRl
c2hlZXQsIHBoeS1pZC1yZWdbMTY6MzFdIG1hcHBlZCB0byBPVUlbMjoxN10gYW5kIA0KcGh5LWlk
LXJlZ1s4OjE1XSBtYXBwZWQgdG8gT1VJWzE4OjIzXS4gSSB3aWxsIGFkZCB0aGlzIHRvIHRoZSBj
b21tZW50Lg0KDQo+IA0KPiBBbmRyZXcNCg0K


