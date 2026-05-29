Return-Path: <netdev+bounces-293208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGblM3rjGWpmzggAu9opvQ
	(envelope-from <netdev+bounces-293208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:05:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3A607AD1
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A749316F973
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A915246AEFC;
	Fri, 29 May 2026 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="abCYGQec"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1433D472780
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080111; cv=none; b=SQCRfJFdfXXSpDHz55lqKXEwgzCYFR3OI/qKL/KsVBFR2dsuFDCuzr6rWb4jScz1DSqI2oRGeED+FB3PoKtbX+HEfGMiTH0h8gJ/idWPrY8voD44ePaSIMvtFvVRHAh2zPqBv7fUuMkSkxotwweuLT6vuE4/2HgDNvk+k8sQJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080111; c=relaxed/simple;
	bh=+mzOR3OjTeBToNKqpNe5js+UG2SYrRxx5gb6HP7Re2w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KSNd+wLHeF0P9MZsu10sXIcgCWxx9XbPEik8amw8SkQgze83P/5l7Rfvk9fousxsYG6aIXWt40Okk4ES0FUub0or0GDDhjV06Psp32sktsMA2RjMYUmvELjlcNj5BQb6h/2lcFYPug3qP8G/ZdGSDfFjItI82PBT39lDwCTNWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=abCYGQec; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780080107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+mzOR3OjTeBToNKqpNe5js+UG2SYrRxx5gb6HP7Re2w=;
	b=abCYGQecCuSxxB2IXr/CPEBxklvjJ6VZae9ZCXxm0RP7G7mgEYBHwK90NEgJ0EioP8KG8i
	nyMiG9lHPBojstTQcNtmgK0HoDFWsaSnBfbCeH1MJF4dvcqRMbfposWsagboYmcAIWM4oN
	tf6JR9vgR7gllDeBfXtSLgUQNfQcBb5FKxuHRTwjPvUMQiMKpU3QgY6h4OpqqiRZ0N9EOx
	epkbVY+n7uNx4wry4oYcyhnoRM43fewHId4SCaEFJt05rm3z0VMh1m+Wqw0qpuOTV8qwdd
	qgmF3B2Qc53Xfw/alb8H3C5cqceivI0PCQi7kmEOgvf5Bnbj97F4+D1zIs3xMQ==
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-16-pB3tR0ZBPDG3OBUJ5ptDJQ-1; Fri,
 29 May 2026 11:41:41 -0700
X-MC-Unique: pB3tR0ZBPDG3OBUJ5ptDJQ-1
X-Mimecast-MFC-AGG-ID: pB3tR0ZBPDG3OBUJ5ptDJQ_1780080097
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by PH0PR02MB7399.namprd02.prod.outlook.com (2603:10b6:510:a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 18:41:35 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 18:41:35 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 13/14] dt-bindings: net: add onsemi's S2500
Thread-Topic: [PATCH net-next v3 13/14] dt-bindings: net: add onsemi's S2500
Thread-Index: AdzvmfEIy4ETAEJuRtKKpddsqy3CTg==
Date: Fri, 29 May 2026 18:41:35 +0000
Message-ID: <CY8PR02MB92494D02A1209BC9BC72EAC883162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|PH0PR02MB7399:EE_
x-ms-office365-filtering-correlation-id: 89dc4c29-f41e-4add-6bd5-08debdb1e963
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020|3023799007|18002099003|56012099006|11063799006
x-microsoft-antispam-message-info: +fm3U9v0ql5h3Kg5i1/GpUgC9+DlOkCT0w49KUPMFV6iDCi2XElTFV2W/SoBTeH+nN8NtoXbSoYiLBEVYPj9D3lXPpR/NEFbHZ5yLFZyKDG5+pTOxr6h4ZhzWqD4lt79DvyQF/9KDwpsK7dIo6yQd21cH8QKn2LJmmgO9N4M2khQ3cjw4hGMB9vEdL5My4RC5XIri9MAdzo1WtmfhE8svZ2O6PikQAxT+158di5S1NmpWwuPk2iiAxuiqlVHdTGzTDdiRnKBPOKjzVFwAzZvQu8nVhvjX5wHEZtdo6EjxUCd4cTzsM0uI3VYSwkgqVO/3KM40uBIzuefSBSXlhrkYvPH9VxKmoSGeRMFj2KFORCST+/zi5ko1LUWCozMwcmhXrtGwU5F1QUwA2IVCAQVDnQmPTIVLO11Fj3dbruOS2RVZVW/d6jH93Qg4HqDrHu5Wwrii1KqEArpGhWN+zwBh3TCy7ZT8+2Lo9a9enRHdfoSKzp4imZ292DLey15nRXHJ2F3gF5gGEgtlsK3oMr+0ijmexBXhAJgdTsny5d89JYQwOsiRruPx41L6LOlfOAznzl1huUPRD9dIuQfTPVR9F/BOERJdaWOt/h8QZiiDE+S2YQi2L4TGtgBddQI8L7mD69VJPJhJeMuEkLNrsvalRIBOCbGLiratKKZD5AIFMPrY44wZZ9CdJO6aGV1QGQwyIAF/RsXUf7Ue6R6fgwpwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020)(3023799007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0lqYVJqR24rd092dzdFVjZOTlp5dVduSzMrd3pTcUt5eWYwTEZObzFKZGhy?=
 =?utf-8?B?UE9ldGJ6Z3d4WkJJQUJ5Q3cxVHBxUlNtY2NiRjFiZGh2bTNFZXF0NDgzbkVu?=
 =?utf-8?B?OHVSZTVrWExQdUQ4Z3UxVDBlQjV1UWdBaDhZcllBYWU4TmQ2OEZwRmlEN3M2?=
 =?utf-8?B?TitQNU55QzlOZGxncTJyK25vVEVKRDhrSEZtd252dlZQREl5WmlFWld6VFli?=
 =?utf-8?B?bnNGWEQ4c0tLcUEwRFI4L1FrV1JjcS9SYXl0MXJNd1VUOW41R25PYldSbVhw?=
 =?utf-8?B?dlpUWDNUZ1Q1K2hFeGZNOVB1UjgreVFRY2p3LzNGME9tTFJPeFZ1ZzRxM0Vm?=
 =?utf-8?B?Zk5QV1p4N2ZkaUF4NVIyR2dSREZUWUN4NlJySDVRM3U4RlVuTUV2UDJFbjF4?=
 =?utf-8?B?WUZhSkJmTkM5bWJ1eU9jamNmSGtxUWc0cmtZbUNwY095VXFWQVppL1NCZUl6?=
 =?utf-8?B?MDVleFRyVmNWbUNLZVZGZmlrL280aTg2SkFRZzNGRGlyOWlXc0RBeXRpOCtD?=
 =?utf-8?B?S0xJcWV3b2Q2bnpEM2RoSTRwaGpnbU9OdzhhV1VqZk5KR2VUMndmQVRpdW8r?=
 =?utf-8?B?RDA4RGV2MkpMQVBZc2p6V1hKcFJuV3lsdnBPTGtqcnJRNyt5UlVsL1JSTWxs?=
 =?utf-8?B?c29kR1NMeU9MYmh4Skx0QUw1MnV1dGU4WlZTZ0JOanpZcGJTazF4dndHU0xR?=
 =?utf-8?B?ZmNUeU04SjdRU3BaWDNVNlVaQnc2SXFFd2ROUmlaM0tncWVBUXRMSUZHWHRi?=
 =?utf-8?B?U1hPUDNlRWJpU1NXNDhFTFFQdnVsdHZVS04zRzVsTnNZWm44QzI3cGpyaFpo?=
 =?utf-8?B?MjUzUEdaQmV2dFZBaGlKcGdTUlNzcHMvTWhVOXl3eE9xU09PRHhhcVN4UWI0?=
 =?utf-8?B?LzBnVEdIQXVQQ2puMTZMamJFanNUYkpFMXVXSzYvTW11RnIxeUpzOVJKYldY?=
 =?utf-8?B?c01Yd3RnZ25KK1JyMWVySE9KQnk2SU1tWTBsckM4Y3RYMmtram9HRjlHc0wz?=
 =?utf-8?B?c0paVmVnSjBRU0ZXaHZlWTE2cHFUSFdYL0k1MGFXQndFQldRUmMvZ2paWXFy?=
 =?utf-8?B?dGVxWmRUYldiVmplZG90dGwzTWdtcmxjeGI3eDNPVjg1N1NncEdpQkVhVjU1?=
 =?utf-8?B?aGk2dnBld05mSWZud21rWllOK3pKMDZyS0xIOWhxbndZV25hekN6c20xbHNE?=
 =?utf-8?B?bWFVelV3TjlCb09SSDZWRXpxbXJyV0NodTF1UVQ1Z0FXWFZEQ25QbG85bkk4?=
 =?utf-8?B?bWxHblhxdjF3akozQVlLREk3MzE5MkFzYVBVS3lLYXVYZkZLbTI5UC9TNHNV?=
 =?utf-8?B?TENoakk0NjkxZ0hCeEYvelhwY201WkdDL1N1VUg3dzYyNWw4TXJoWUFOcEV5?=
 =?utf-8?B?VW85S1AwSzZRajQ5cG5vUDJTaDlzd2dOM3orSUZOWjdlZkpSYjcxeDVOVmdt?=
 =?utf-8?B?bXFrRWxCWVRBL0hGeVdycklUZ3l4Wmh6YUZtdTJTYkN5OU1TdVBtMUM1MnNz?=
 =?utf-8?B?T3BHMDhaaHVDRGlNb0xOUjRHVFI1RTRWRFpzaURsK2RhY3NRS3I0c25LQ05H?=
 =?utf-8?B?K3FZK1FQTkVobkRuYWRNbmVqbTFkc25KekdBMjh0dFNRK1JCclV1TDcwcU9M?=
 =?utf-8?B?dUpneEdCMVVRbVBNWlptMHpGbXpZM2daQTBGQ1F3SmF6UkpEVVBxTnlJK0Y1?=
 =?utf-8?B?YjBzdTlydEc5cVorNTZwbmFpWVRubHhEUnUwZTFrK1VuWEpBYmkrZkZ1WXBE?=
 =?utf-8?B?bUJTRStiNEZ4RCtURWZiODFpbjdNazhBQmFkL1hpVUkyQlFtRnhyYkRKbS94?=
 =?utf-8?B?dDB3NzRNVWUzVndNaThSbUdCQnd3cWRpSUhQWVFJdllrSW53Ym5Oek1nTkZM?=
 =?utf-8?B?Wk9PU2FtYno3dmhvYXpEWmxhMnp2emViS1JvU3V4Vkt1dmt3UDdFMVRBN3Ex?=
 =?utf-8?B?STFEem5vUno0a2FGOFFFejU3L2VCbnAydmpXVjZVdFp4bWRzdFpuVk5rMFRH?=
 =?utf-8?B?T3oxMmtFU3ZnUStVSktzaHNtZnBId1Zqa3M5VzFyUStaZ0ZXckVFdFptRm5l?=
 =?utf-8?B?R3g2c1dpYS9oTzJSOVR2NUd4dlBQR1NzUjViNnhDRmZKckhoLzB4d0o4a3VY?=
 =?utf-8?B?NWYxc0tMQWlHeUpDa1FGNmlkbjhkeW1NeG4xRDdmVUdCMXJXVncwMjBCNE1G?=
 =?utf-8?B?M0FPcWJCRldLR1dXdkJXZ2JVTzREcnMxMjlQZnFtZkR6WFpiVExaUFJNZDIr?=
 =?utf-8?B?U0J5QVFMSm1MU0QyR1pCSEVuUTBLYXZNV2hlQytITEpBY0dmUTJ4R1VEWDQw?=
 =?utf-8?B?SnJPVHFEa1VkRFgya1c1emZDT04wb3Y3L0llQjhZVWpHSHRTUmlEeklZd1FD?=
 =?utf-8?Q?y8avtp9LB2xPfqfo=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZGXCOxrJSCASosgVsNKPgX+8y8i7qNLECxIRvHW4e7tpKTVXyY26jNQQKfYNoQlIdHpLAn4aaU2ie3aICm9aXTsD0yOq6uffxIaSkyqNVSwnkBgkBa6ViDmY09daL4ShVWZKwp/aPgqbKbKSJyG+Ta3JyJEQGJIUloOdwHc7CV2gv4yvTVk5VIDLdAwvOm9zC2Qz6kg707rngRH0owcJgP1GXMQtzqEGM5UFiwI6/krQaJKlqieAsc2Uum7dN8U4KGtx3uw3UQLdLxtLvImhDDlQXo+yHZpLDTjngcuXsgl7MH/UuDM7TijPZmm78xCScO+E801SlOAZby1nNnHl2A==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dc4c29-f41e-4add-6bd5-08debdb1e963
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:41:35.5286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qt0ilXoErP+lNjw1Jm05nNwpsgkwqLInA094wHq8f/jH4s9AClV7ViPy/54H/tcn0sTLA59hXhP/nf8djNBz3Y3ZrAnQ0Vb544+sz9Qk+zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7399
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 020D_LqKAkYI4_rmYSBC0AjPeffVsijVpGkGfZyFsxQ_1780080097
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293208-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,onsemi.com:email,onsemi.com:dkim,devicetree.org:url,CY8PR02MB9249.namprd02.prod.outlook.com:mid,0.0.0.0:email]
X-Rspamd-Queue-Id: 6BD3A607AD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

QWRkIFlBTUwgZGV2aWNlIHRyZWUgYmluZGluZyBmb3IgdGhlIG9uc2VtaSBTMjUwMCBJRUVFIDgw
Mi4zY2cNCmNvbXBsaWFudCBFdGhlcm5ldCB0cmFuc2NlaXZlciBkZXZpY2UuDQoNClNpZ25lZC1v
ZmYtYnk6IFNlbHZhbWFuaSBSYWphZ29wYWwgPFNlbHZhbWFuaS5SYWphZ29wYWxAb25zZW1pLmNv
bT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9vbm5uLHMyNTAwLnlhbWwgICB8
IDYyICsrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygr
KQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L29ubm4sczI1MDAueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC9vbm5uLHMyNTAwLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L29ubm4sczI1MDAueWFtbA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmlu
ZGV4IDAwMDAwMDAwMDAwMC4uOGIyMGQxZjc2MDI3DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L29ubm4sczI1MDAueWFtbA0KQEAgLTAs
MCArMSw2MiBAQA0KKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1Ig
QlNELTItQ2xhdXNlKQ0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDovL2RldmljZXRyZWUu
b3JnL3NjaGVtYXMvbmV0L29ubm4sczI1MDAueWFtbCMNCiskc2NoZW1hOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCisNCit0aXRsZTogb25zZW1pIFMyNTAw
IDEwQkFTRS1UMVMgTUFDUEhZIEV0aGVybmV0IENvbnRyb2xsZXJzDQorDQorbWFpbnRhaW5lcnM6
DQorICAtIFBpZXJnaW9yZ2lvIEJlcnV0byA8cGllci5iZXJ1dG9Ab25zZW1pLmNvbT4NCisgIC0g
U2VsdmEgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5jb20+DQorDQorZGVz
Y3JpcHRpb246DQorICBUaGUgUzI1MDAgY29tYmluZXMgYSBNZWRpYSBBY2Nlc3MgQ29udHJvbGxl
ciAoTUFDKSBhbmQgYW4NCisgIEV0aGVybmV0IFBIWSB0byBlbmFibGUgMTBCQVNF4oCRVDFTIG5l
dHdvcmtzLiBUaGUgRXRoZXJuZXQgTWVkaWEgQWNjZXNzDQorICBDb250cm9sbGVyIChNQUMpIG1v
ZHVsZSBpbXBsZW1lbnRzIGEgMTAgTWJwcyBoYWxmIGR1cGxleCBFdGhlcm5ldCBNQUMsDQorICBj
b21wYXRpYmxlIHdpdGggdGhlIElFRUUgODAyLjMgc3RhbmRhcmQgYW5kIGEgMTBCQVNFLVQxUyBw
aHlzaWNhbCBsYXllcg0KKyAgdHJhbnNjZWl2ZXIgaW50ZWdyYXRlZCBpbnRvIHRoZSBTMjUwMC4g
VGhlIGNvbW11bmljYXRpb24gYmV0d2Vlbg0KKyAgdGhlIGhvc3QgYW5kIHRoZSBNQUMtUEhZIGlz
IHNwZWNpZmllZCBpbiB0aGUgT1BFTiBBbGxpYW5jZSAxMEJBU0UtVDF4DQorICBNQUNQSFkgU2Vy
aWFsIEludGVyZmFjZSAoVEM2KS4NCisNCithbGxPZjoNCisgIC0gJHJlZjogL3NjaGVtYXMvbmV0
L2V0aGVybmV0LWNvbnRyb2xsZXIueWFtbCMNCisgIC0gJHJlZjogL3NjaGVtYXMvc3BpL3NwaS1w
ZXJpcGhlcmFsLXByb3BzLnlhbWwjDQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQor
ICAgIGNvbnN0OiBvbm5uLHMyNTAwDQorDQorICByZWc6DQorICAgIG1heEl0ZW1zOiAxDQorDQor
ICBpbnRlcnJ1cHRzOg0KKyAgICBkZXNjcmlwdGlvbjoNCisgICAgICBJbnRlcnJ1cHQgZnJvbSBN
QUMtUEhZIGFzc2VydGVkIGluIHRoZSBldmVudCBvZiBSZWNlaXZlIENodW5rcw0KKyAgICAgIEF2
YWlsYWJsZSwgVHJhbnNtaXQgQ2h1bmsgQ3JlZGl0cyBBdmFpbGFibGUgYW5kIEV4dGVuZGVkIFN0
YXR1cw0KKyAgICAgIEV2ZW50Lg0KKyAgICBtYXhJdGVtczogMQ0KKw0KK3JlcXVpcmVkOg0KKyAg
LSBjb21wYXRpYmxlDQorICAtIHJlZw0KKyAgLSBpbnRlcnJ1cHRzDQorDQordW5ldmFsdWF0ZWRQ
cm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgICNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCisgICAgc3BpIHsNCisgICAg
ICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCisgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCisNCisg
ICAgICBldGhlcm5ldEAwIHsNCisgICAgICAgIGNvbXBhdGlibGUgPSAib25ubixzMjUwMCI7DQor
ICAgICAgICByZWcgPSA8MD47DQorICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0K
KyAgICAgICAgcGluY3RybC0wID0gPCZldGgwX3BpbnM+Ow0KKyAgICAgICAgaW50ZXJydXB0LXBh
cmVudCA9IDwmZ3Bpbz47DQorICAgICAgICBpbnRlcnJ1cHRzID0gPDI1IElSUV9UWVBFX0xFVkVM
X0xPVz47DQorICAgICAgfTsNCisgICAgfTsNCi0tIA0KMi40My4wDQo=


