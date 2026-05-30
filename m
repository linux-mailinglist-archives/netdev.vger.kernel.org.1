Return-Path: <netdev+bounces-293291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIndC/8pGmrQ1wgAu9opvQ
	(envelope-from <netdev+bounces-293291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 02:06:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB8960A08B
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 02:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A455306D863
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 00:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314BA13635E;
	Sat, 30 May 2026 00:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="THmvj8z+"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7272A17555
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780099309; cv=none; b=DxviKydk2xWgaWKKQ2ycB0lpCCl+UIJ5UBaWKqzd9l6ImZ+OycY7sFAExYLYFngSXRhoUqrNxvil3NAatFlu65jnHjRF7l95+CfD+I7mOqQBAWo3ePUUdvsZKf4gnzVhpDMi5ndA5Tp7clTbMonrAiT6HALcT40WWASxLCZuHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780099309; c=relaxed/simple;
	bh=YZlbk5eauFU/C5WKLRSWAkk6QBTIfs2Tc8HKExu/76E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=oOE+6z1PC/GR55I6jxZBzme2s/Bk+jAp2H6At+NWeWlL0yPg7QUqhafJ8jVzNdAJ74PFJ90icxjETmmni5uKtakh1Vqn3jen19v1427vUENryt6VvA+hrqwAp+L12TAAeQNiGGWg5KWS7ixUIqr7/yGxcmJHjgBhH5Wx8A2jZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=THmvj8z+; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780099306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZlbk5eauFU/C5WKLRSWAkk6QBTIfs2Tc8HKExu/76E=;
	b=THmvj8z+JDHtfBdgNf1WhPXc66mFrIdIkFOw4JcTew7DHu16GoHMZklmP+9ZS0BTWvA7VI
	ryg8L+eW9vDxNJg0doggjMV6THy5YnHt4OW12HHYXOLx0gngP8kkrq/gL1iwUzJP0eECDK
	PVme3sxL/pEldpCz02rXzenZLDABE/03cG/xm/0+ollNC0dgQnQNTdYHNBiDoSVBDdA+rL
	Cym/f9TCSPUcHI8Kg+sCPdTjWP/fzTt74BBa4wtFzolkdwX1NpuM/hD7+qNtl7o2dNBzUm
	JXg0si8PSVjhdar4Ew22sx6hIbb1PgiAg2rQLpkIMhFb0zJJlxe940fNLbAv8A==
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-51-nV9vGJBoPIedrzgD6vfL-A-2; Fri,
 29 May 2026 17:01:44 -0700
X-MC-Unique: nV9vGJBoPIedrzgD6vfL-A-2
X-Mimecast-MFC-AGG-ID: nV9vGJBoPIedrzgD6vfL-A_1780099303
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by PH8PR02MB11584.namprd02.prod.outlook.com (2603:10b6:510:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Sat, 30 May
 2026 00:01:41 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Sat, 30 May 2026
 00:01:41 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 02/14] net: ethernet: oa_tc6: Move oa_tc6.c to
 its own directory
Thread-Topic: [PATCH net-next v3 02/14] net: ethernet: oa_tc6: Move oa_tc6.c
 to its own directory
Thread-Index: Adzvl+YGdZ19tjFJTzO7UJa3KzUQNQAIVc+AAAOIXXA=
Date: Sat, 30 May 2026 00:01:41 +0000
Message-ID: <CY8PR02MB9249276B0B0CB11E4F1C4FA283172@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249E50ADFCA24B9902C743E83162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <9e2647de-58d0-4b04-9339-c6eb898c800e@lunn.ch>
In-Reply-To: <9e2647de-58d0-4b04-9339-c6eb898c800e@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|PH8PR02MB11584:EE_
x-ms-office365-filtering-correlation-id: 2308505c-2c16-4569-1c2e-08debddea0d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|6133799003|4143699003|56012099006|11063799006|18002099003|22082099003
x-microsoft-antispam-message-info: w+Zk9YaNi938EqdWfpVP34xKC32+VzdB4qfVt07WLM+enkoNtmYGZG1FjknKAgE0xwClVwSDpOM9TO9nEhUWQQIrKERz5x5++2EMMp/0/IxXSKZ2x+lSMQi2IuwahKdW6KqVpYerWL7/VRly080mk8HMhvEDPNBhPwyw/S9Kc3QLAqbBHG029swXy4ieGRwnwAFqhGOiDPZ7CkRSUAtOBXfovhTj13ntRpRphTon/rkuTWiwv/NmZkJj2W5zdKa14wbnmzv9Ds6joMEt9M251chD+AAFKHyjq+rg4cYBRHi8xOx5rQsaJwzq4tR5Mt+/FxxecI1lVLmhEU+DsGUegv9uZXCXwiSZsZRB17chHCFisA0WFpU96XaVTzUV2Q3CLb/U9Y1btG/KsSRjqdU/uYOCVL8iDktBPOdBZ3CglfoML/eskAYI79s4l4wV/yRjVFdNKBBtnW/rjWwBd8dwsuLy7AjFJd4SHBE85IqbxQgUqL7EjKZLGxANZ8kmAnhrwOHLcws5yvuNqRf6eDirzdyJffGfox85PpgUJHtRkjKWZ6u6kga/xZ4J5MOXFglwC46AHFTMbMUmLjozMsUpBkm0i+IZlks5DfSsANj0yj/mgjonQNFQNqV3Us1n3lLfza6k5s3WQOrPRhjyMloUgLSdyup8le4eGjJ8ICosZM9DefC4x8OApvDKKc6a+xamRxFOnpXC6JayMbah9cmLuEotuMowy3n1MREf3eJUUjKh4TTlGoBtyCMh6DnCOM5d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ny9NdXJDZU9zeEpYUmt2QjNGbDZSek1TNkFRZVdKUnlGT0p5WWdtWVU1NW1z?=
 =?utf-8?B?VXBEQmR3SnFwd3FqMTU3VVBYUXJoTXhySFE0a2tQaFhMdE5LT3QzbmtQWThY?=
 =?utf-8?B?TXhrYVl0Sy93TXRPdWZBMnlFZVhBY0hSUXZ1UGVoYnl1QlBveDlTcHo3RFZR?=
 =?utf-8?B?Y2txMzFEMFkyaTNmUUtaeWpIQk5LenhvZnRaSzV1QTU2OXdEd1Y0R2ErSkZG?=
 =?utf-8?B?bC9ncjhWbjhyWUNtRnkzK2dHemdlTjVGTFhHOGR5b1V1R2RsdGJmNDhVZ09V?=
 =?utf-8?B?eEtNemhhSUg2VjQzbUJJYnpOUDJCYmZvajhJUEZBcE50ckhiN1JGb2h2dnJw?=
 =?utf-8?B?aWluYklQTk95ZFhocy9sMG5HWGVqZnFaTEFKQUoyMFlvRFlWMmlrOUJ0MFNp?=
 =?utf-8?B?WVB0dUJ4d2J6Z2dWZ1pNL0s0ZlZ4VzIyblRKQllrNTdRbG83aHFweVpndHJx?=
 =?utf-8?B?YkhGNmRMY3BPcDQ3VGNrWFRyU3QzZ1N0YjlBOGFhRTFrWkpKdDJ0UGdSbndL?=
 =?utf-8?B?RkpCZ2I4RkhjQVJYTWZUUUsxc2FaaHRCU2hLZkJuMDh1MEVQWHdvRVNOYjNX?=
 =?utf-8?B?ZXFpMmhRUVQ5dnZkTjJCdWcxbmNaTXBZaFdCQU9hTkkzVngwdmZIemd6VmRr?=
 =?utf-8?B?STEvTUZNUytYdTZoS056Z0JUaXhoZ09Nd0JsQ3JqMTZaemRZd0Y4SmZFUDJ5?=
 =?utf-8?B?MDlUeEhrTnJRWEFFMlhUd1hxVndEVDBSUFFmMnZselAxRjVoUitoVkVIdlRD?=
 =?utf-8?B?aTllMnpBSnR4UnVudXdRa210Um56alZzdUpGT2xUSjlvTDkyZ2sxZVNsSFJB?=
 =?utf-8?B?UVJxS1pyZ3d2UHZ4cE5PU1hUYmxrZk9RREREZ1Z1K1plWHdORWRtMUJSM2lq?=
 =?utf-8?B?TzZLSXgzQjJkRmdPcmdLVEZENkpCNUg1UHlaVldmVkxNQjlsOU94T3lEYmtR?=
 =?utf-8?B?U201Y1FjbUNQUEQ5aW40NmtUS2VYb3RDYnVISXpaU3gwUXo2emlkdXFiUmFM?=
 =?utf-8?B?TEFCMW9NNFd1WlRVRjNscHI3MU1TeWF5M2FGTUwvL0F6eGI4ZzZqeXJFVXQ5?=
 =?utf-8?B?M3NkWFRmeHpXaEVKM1FObXBXMDNlZERudi8rWVN5OVpzZG9Pb2Vvbi9xN3Bm?=
 =?utf-8?B?azZUZ2ZlREhZeVkzVmR4WWtUS1Rma2lRWFNvd3BzUkh1T1NzclZDdVJydzhO?=
 =?utf-8?B?WDVDdGdBTUpOcCtiU0ZRaVBhRnlQTXF4bVMxR3FJQTRsbnUxRUtzeklqTjlD?=
 =?utf-8?B?ZnAyR3NjbzMwR0FnZUtzbmkwaGtic2xTckFvY2p2UURRT01mMU4reXlGZVRk?=
 =?utf-8?B?a3MzR1czWkR6ZnI1VG5mK3lCV0xmSXJTQzdlblByL0FGL3ZvL1QwVEppNGdY?=
 =?utf-8?B?VXlRL21UaTlKRjlSR1MzT2s3em5IaTVMaWpjRFRZbm5mTnJNdXNBb1VIckJs?=
 =?utf-8?B?REFOeVpRMUhyUmhOaUFBY0JsNEhPdEs0a1JGVnVRQ045ajUvK0xkRnlTZ2d1?=
 =?utf-8?B?bmlzUTM4OHRMcXR3RytnWFpSZDg5SjdkREIvVWVKZXMzb2JSc3YrdS81aU90?=
 =?utf-8?B?YTdsV0wzK2JUSFpIUW1saS9rRjV6ODI4WWxFcFFpTnJva3BPdmRBeFYwU3Iy?=
 =?utf-8?B?dmxGYVV1MkM4b2FRTzJGVUNKVE1NdjllSDVJT2xJRUcxdER2aDFndndIdW04?=
 =?utf-8?B?VVhxRXNybHl3U0dtZ1RmYnl4NzVNSlJyTHZKMVpzcE1rR29OR1FKU1BoeVpI?=
 =?utf-8?B?QVpYUE5xUXc4b2gramN1dEpwUTUwbDY5QWllMFFSVnA3d1JPQ3h3eWhyc3FV?=
 =?utf-8?B?b21ndzlkS0VwMjNyMTdlOGlUUXNGK0VOVlFNeEJWdDJwSXlydmtPWDB5d1Jr?=
 =?utf-8?B?dEpFU1psOHdwTVQ0bGlka3BCR1d4WG4veTIyeVJLWWRUOFplU0FGQXorcnRi?=
 =?utf-8?B?bVg1c01OSklKMG54d2ZXdnVCWTZpeUNGMHNveDhxMXc4REFTR0Z6UGhVcXhR?=
 =?utf-8?B?K0xHTk1JaEg1TFBGRy9uWkc2V0FDWXNGSElsZVI0RmRpTmJEWEt0eDZNYWNs?=
 =?utf-8?B?UVBHUjN4dFBVa0hCb0RXcFo3NUpuTTltdlkxdnJJc054OTViOXFjeVVCa3hD?=
 =?utf-8?B?Vlg5bVQ3Wm9lL0JnMGE1S3hLbXE1Y3hVK1JuOHJ5eFRFTTlocWdXTzZOUC8v?=
 =?utf-8?B?M1hFY2ZNUFBERTFaVWhZZ0w5ZnhiMzRrVy95UEtscGpiTHhzNmNHYjBhTXBt?=
 =?utf-8?B?cDVoZ1FvSUxUS2Z4SEJxd09XaEJQb2ZwUS9qRHRScnFPcTZaeTNqaXJDK2cw?=
 =?utf-8?B?cTdlRU11QUtsMVh2SUlXNnA4REpJL0VjRkw4TEZoOTFmQy90WXFhNTdiQWlM?=
 =?utf-8?Q?M5Uqk+orHq3m85w4=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EH9UPJd1TAUSj2lTY/fB5iLzgXbAUywE5jlHy4IzNTJCO5+YabK3BPpFSFo7TL66ENSxO3Pn+NcddaSCNPceRLO/+ULd+UrFk94yoSazqno/WjfJyVYIhLQVBmCKGzT77d5/P8/krHlnTGL16RA8Bm6ffaunLEpiDu+riy7AZDfz+KiTDCKuZzjWmxzi96LxkNFbLQh2ykR+tJXRLLQ6Sgsq+bXfqYnrTabhsFolvv1zA0qAxNMkWQgVJFrROEMh6PCIsSMRXT6+hxt6eP99wJyO7SDa/Cu/usJzZWQrivB1XSBF7NPQ2cCDw7Y6Cm8N3higiQrFB/+SskjmlD9RDQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2308505c-2c16-4569-1c2e-08debddea0d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2026 00:01:41.1304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtBn0FSl09VfFX+IjWgRDC2YEziA3EGUozWENuP5t0ddA58sQpHpKOupDlBhvFa6Qls94b2002u3d6Kvtp/fHYHJcfTgOKWQBCVUf43E5G0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR02MB11584
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bx0p-ISxTcVet9R9NWQ98IyDP7I6SvVkKDe5OyIHfl8_1780099303
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293291-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: AEB8960A08B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHYzIDAyLzE0XSBuZXQ6IGV0aGVybmV0OiBv
YV90YzY6IE1vdmUgb2FfdGM2LmMgdG8gaXRzIG93bg0KPiBkaXJlY3RvcnkNCj4gPiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9vYV90YzYvS2NvbmZpZw0KPiA+IEBAIC0wLDAgKzEsMTYgQEAN
Cj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ID4gKyMNCj4g
PiArIyBvbnNlbWkgbmV0d29yayBkZXZpY2UgY29uZmlndXJhdGlvbg0KPiANCj4gVGhpcyBpcyBn
ZW5lcmljLCBub3Qgb25zZW1pIHNwZWNpZmljLg0KDQoNCk9mIGNvdXJzZS4gU29ycnkgYWJvdXQg
dGhlIG1pc3MuIA0KDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9v
YV90YzYvTWFrZWZpbGUgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9vYV90YzYvTWFrZWZpbGUNCj4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZWY3OWYyMDM5
MDE2DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L29h
X3RjNi9NYWtlZmlsZQ0KPiA+IEBAIC0wLDAgKzEsNyBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gPiArIw0KPiA+ICsjIE1ha2VmaWxlIGZvciB0aGUg
b25zZW1pIG5ldHdvcmsgZGV2aWNlIGRyaXZlcnMuDQo+IA0KPiBTYW1lIGhlcmUuDQo+IA0KPiAN
Cj4gQW5kcmV3DQo+IA0KPiAtLS0NCj4gcHctYm90OiBjcg0KDQo=


