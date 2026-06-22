Return-Path: <netdev+bounces-301144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xnWKJhxQOWrVqQcAu9opvQ
	(envelope-from <netdev+bounces-301144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:09:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BDB6B09B1
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:09:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=jF558DJT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301144-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301144-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E0973005679
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCA832861F;
	Mon, 22 Jun 2026 15:04:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D63264EF
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 15:04:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140650; cv=none; b=GU/5JDxERaXHMt4Z42dy/KDrBfJ5ph1SHOgrpFIuIf+83+fehkKKPqckm2OnWqzJwoMm62lx/EiFuZeLTJCIS8ftMC21u7p/wR0knQagrIVdxUWezqu1Le/WSxKRgWP2w1YI9NwUYViAqon1A+IMUFOt+C0okXHV615WqrXpsuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140650; c=relaxed/simple;
	bh=+djZrNrJOngpdaP+EVeozDWXRgZlJg6AxlfudT9a4Jo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MIfYFWVAKqWOD8eQjKqszmRWe0rShP0qeVe3VgeAOR8+Tg8xP7/+xLX8L2brqaAQXzrTBZiiNshYBzHqe5ES5dIOePf8D/Lt/2QAGLhYwXQ5u03ToAnsCD114MTnZrmOVckH5TfLlH3eVnLE+rG/b+b4zTVVRz/Edwu76W+QSvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=jF558DJT; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782140647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+djZrNrJOngpdaP+EVeozDWXRgZlJg6AxlfudT9a4Jo=;
	b=jF558DJT9Ksx67xM/ZBhTg8aQSUiCZSj9Q3mTWrMBdS1Dohv6AeimCgXAJNANAWGNveekE
	KvQCmslGupfuQe9LJMBO9Uxls7Iio9pDSKS+hk6Z9Zk9bI15pQ6REn9bfFCFhcaWLPCF+N
	Ct4Qu+YNpCosrs2yTLWrK/n8tVr5EV470HwSPJr2bmVZHSJnGeooLJw6BF0CqKf87hdjVJ
	59pSqV7ZkjNCVPz32vbbZRs/FvI4WF34IiTUOl2MKnQts5KoLbcN1zQ6xhEr6lvmjuXT9L
	M1tZE+Gu7L5odcam+BB9XyvLIBtVmNePiTmNBTQ7Pm93w9dxF194YfV0b+ijEw==
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013031.outbound.protection.outlook.com
 [40.93.196.31]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-28-DFCMm7Q6PziUVOaB5jdRIA-1; Mon, 22 Jun 2026 08:03:51 -0700
X-MC-Unique: DFCMm7Q6PziUVOaB5jdRIA-1
X-Mimecast-MFC-AGG-ID: DFCMm7Q6PziUVOaB5jdRIA_1782140627
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by PH0PR02MB8858.namprd02.prod.outlook.com (2603:10b6:510:10e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 15:03:43 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 15:03:43 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Eric Dumazet <edumazet@google.com>
CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>
Subject: RE: [PATCH 1/2] Protect skb pointer used by two different kernel
 instances
Thread-Topic: [PATCH 1/2] Protect skb pointer used by two different kernel
 instances
Thread-Index: AQHdAgBOEWaJAuWPO0+l+Rd6t26PgLZKQQ4AgABrbbA=
Date: Mon, 22 Jun 2026 15:03:43 +0000
Message-ID: <CYYPR02MB98281E5F6C87DF65C29B6E6B83EF2@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260621-fix-race-condition-and-crash-v1-0-87e290d9357f@onsemi.com>
 <20260621-fix-race-condition-and-crash-v1-1-87e290d9357f@onsemi.com>
 <CANn89iLLrOZ4Ep=dBgs0sC0tWsrZHy8DnCPLw_Em+7v2UtE9tA@mail.gmail.com>
In-Reply-To: <CANn89iLLrOZ4Ep=dBgs0sC0tWsrZHy8DnCPLw_Em+7v2UtE9tA@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|PH0PR02MB8858:EE_
x-ms-office365-filtering-correlation-id: d920ee82-431e-4bdc-efb7-08ded06f7393
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|6133799003|4143699003|11063799006|38070700021|18002099003|22082099003
x-microsoft-antispam-message-info: KybCXBqOvqjkL4f+liYESXPpjyarpohgP79UDCL8stBea6hszra8EBp2rh5CXY2pyAIL1mRXB4tDUkJ2UHeQvHMYbAolFh+Rn9hth80tww42/dLto5QTd5AJPzlDk8PjJTd4QDEloIGYhwMM5nh4MrjRL1V1LvLQlNrEiAaB15YkzyqkW0kSzkSEN52YmfYNz1HcoTn0WWvz6n+Q4WbMam/acpUyubwHTXW5X9rw7ur2J06VF6vIGOzlKAqqBot3FN2ytiCkmFmQ2RDPxR8KhdrdX0rYwqHDE3mlACrj6ZYUWt3d2Nlf6+zmZVsVb6m5WeeGpuH3vvkS3lpoPDyxOJJgF+Jq8O0v336GcIrdtL7ySVRnmc8lt/c3k1Rvr8cCjw0jBdiwR/7Ci7LEue2lN/1EEB0PSNsn+MjEDx52YWcptb/+LG2OY2s09Bfh9anzQS2FqOt/Vj0p3UvjhyNqnyiUnIYimYaRySiNAo1zKqeUSu5hYSfr1uhefZdoyZOJ5sl4MXJ4lHe4r+W87CWpOXvvOebpbqT6rZUQspbTdU1LgWqi6Tt1dq8icXxgUlvoSeZlCAs0cEuwKPUg94MmnUAIyhVr6G6npI7FevzX8JZIPbUoTEcT0JNb0BdhnVWGNcdIPlvyCnDdcP0A/49CwVlesLl/B+u8gaNYxHXwHiA3E/xvGsF8Wnyrpv4v/0T+Op+urHsnjsYajHSYLaaYa9TU4u6m97zRV1TWNQVUj6A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(6133799003)(4143699003)(11063799006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXl5SEh2WENQb3ZRVUlLOGxVTllpcVVzdGFiZ1hZY0tUaXBJQk55OWZWOXBj?=
 =?utf-8?B?L0J0ZGNYZForMGlxMGpxTSswb2VWWi9XLzhzZWxXaEFZVmROTnp1b0Z5MDJk?=
 =?utf-8?B?bDNnUm9SMng5cmFjNzV3V010RmIwRDlFaGZ4R2pUQ1NXSTdzMDR5d1gyKzM3?=
 =?utf-8?B?RnYwTEZieVpKWGJodG5jenZCZm11b21aOGQ2WnNPUWQxWFRCUmRONHA5RTJO?=
 =?utf-8?B?MWY2WDRpZS82eVVraklRWXlRL3ZPUW82bDFHcnJ3TzNyRHoyRHZhaU9VbndC?=
 =?utf-8?B?eEllT0lMQTF6bFJhTzRYR01OZk0yNm0wb3RIT3c4cHJ2L09Tc0ZWSXFaMnBt?=
 =?utf-8?B?OVNTRmZlWnRYQ3ZhZkFySmh2WmVzOTRlUWg3QWZXZjRTbXNTUEQvRWN2Y0dF?=
 =?utf-8?B?dkJtQ0FOWENsbURNcnJzUTF0MkF5RnJqeEppWWFtcEc2b0tvZkYzYnY4Q1pF?=
 =?utf-8?B?YUlqMDlMQkM2VTBIR0hyQnlxQnhiWTZqU0pacVFKN1YrWFdkSzJYektoTE5G?=
 =?utf-8?B?UmpyVXdPNEZ2ckVDWDk3VlN6TUxnZEVFS3U5NFlnWjdnQVoxM1Uwdkd3Q3Vh?=
 =?utf-8?B?RDYyWlFzQjZvaVg3clpZcU1GREJ4WXR1R2xSQkE4cHVMYmhJaEJKdjVWY1hq?=
 =?utf-8?B?NCtyc21kajAyaGFuSEhmNFhZbnNzREtFZ2NUUU01UzJXMkR3aEdGSTN3YVlG?=
 =?utf-8?B?S0FIN2VyZFRyMmRZTXZzMWlYempwNlRjaDFoelI4SEV4TmNGSzVNamo4ZXNa?=
 =?utf-8?B?c0pLU3lBOEJjaUt3Q3JaVjdyOWQxc2dPYXYzV2x5ZTZSWUZMYmF3a1FaeXkr?=
 =?utf-8?B?eENmQTNieEkxQTFsS1JhVGRGRWFXdjFxN0tEWVJaeWdCS1N5OCs4NjZWeXdX?=
 =?utf-8?B?djJkZ2ZXb2lMTTN2UHdnZ05Ja1NRcVBXMlBTdzNJNktQOUlwWjJ3Z3FWT3Bn?=
 =?utf-8?B?Y2hZSnRTNnp1YVIyazdHY09EdmQ0UWdzRDNIbGJ4T3hSaktXTndkUjhUT0tp?=
 =?utf-8?B?K0xZUWdXd3d4OTl0a2U4dzhJejhYTGJlOFhnYTh6bnlKQXRWQXhZZ3MvaVhh?=
 =?utf-8?B?VmQ2NnVKTnEvbk5NLzROVzJHcUg0TXJMaVVYSFBpRUR2Tzk4YlAweVF6L2lh?=
 =?utf-8?B?c0QwcjlWRkZMMkd6aU1YVTZ1YWJlMEFaR0RQZFJQbDJCNm5aOGM5Rk5zanVi?=
 =?utf-8?B?UnlLdHFZY3NNaHJlbWJvdTdBUFA3VysrdVgvU1ZMaml4YjJSeXE5WStBKzNu?=
 =?utf-8?B?MklZZVdZS0tYYmhUQlJTd2IzenM2ZG96K3RHZ0RxUHhNK3BXWTVhMmx6Tkto?=
 =?utf-8?B?aWk2a2wvUEJ3RXhhRWNDbTI1ak5uRXBjcFMzd1U4WmZDUDdmdE4rRHM5dlVp?=
 =?utf-8?B?OUJGS3VoQm5HVUJqZG13SlVJc3BUakdELzhUakNnZ0tPYlBPNXlQbk11TjEy?=
 =?utf-8?B?L0tNV0V0VTRyNER0TEJLM2thd3psZ0ZaRkZCakk1cDhuVUJyZ2dZU0dYUzk3?=
 =?utf-8?B?cUdVMStHaDZYcng0YVRkK1R3dXZLWFhTVFpZVFhzTDhUb0FUS2xWYU5wTzVy?=
 =?utf-8?B?RnAwQTR6MXVWZEh3Z2h0MFFmcCtEL1VPYW8zeWpZTEU5N1VCM1g0aDV6YlZI?=
 =?utf-8?B?OU9MOXBRUWhRWUdIRkI0c2I4MTVuV3NYbTFLK3FrWUV1SWRHY1dkR2wwckVL?=
 =?utf-8?B?SVRzc2h5SzR3OFhBZHpEenFSdXAya3NrS1p2S3NtZjVwMi9VNHVDYU1RQXNw?=
 =?utf-8?B?QVMrdnMvUzV2cTFLQnV1WERHemNEaVoyeW14cUxOcmJMMHRkSFZqU1cyWVZS?=
 =?utf-8?B?NXcySmVQb0d5bHo5Z0NMY25qUDdhTkNEUXhHbkVPeXdRTENRL1VSbEhqQi9t?=
 =?utf-8?B?WmppMmN0N0Fid1lWQXFzWkFhMWhCOGhFYm8yQk5QRFRrS3ladDJUb2FDZzAv?=
 =?utf-8?B?ZFJLVENNZ3NsSmtpcEhCazVSSkhFdEFpR0NtRXdMRXVZVGwxR3NGUUx1NUJT?=
 =?utf-8?B?bFVES0dKZGpvS2FrRXJ4c0o0YmE2TGoxRUx0VnFEblhYWktYM1RlVWFMRFQ3?=
 =?utf-8?B?WWJVdHl5V1VPTGEySEZ6eDUzNXQvTllabFp1dUJraWp2QWY5bExIVEN1a1ZQ?=
 =?utf-8?B?ZGdHYW8xZk9WeDQ3NkRpZFlya3U4aFRsdXJISmRUMTQzRHBxd09NMTFmVCt0?=
 =?utf-8?B?ZWQya1A4UlE1MUdJRUZLRzFaUTU1L0hHak5JS0dCRnA3eCtTSndzMSt4aFlS?=
 =?utf-8?B?dUY1TlF2TjdlOGJnWnNvQ3YzUG03cFM4VEhaMlU4UWszOVJYeFNtSGtnS2xq?=
 =?utf-8?B?MG9KRnlLWGlCTzNhNWVwQStuUTE1NFkyOTZjcnBPbU9VNmxhUzUxUm42TFZq?=
 =?utf-8?Q?58wgEcZMYKEM2Lzg=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aOv6GTbeQK9aWndAiKYUHuGZjPVLOShIg4Hgkzkd06jkFNezkbQs2DUlH6JSopEY4A+BE0wGfkvhyUjdgFZHA8JgLwF2N/sdyRNKCpMxfiTluckG/R1fqEO4Hx6oFkOuUMmNl8wN7Xhy38ZW7zGE7BDFp0T4JRdLH7jiRQ8sp66Sveu7aOh9HbfPgg238fLr9duh+8DZYkDov+3m9t5IbH3nvAMJac1CQ9E+rhxpBQgieTFmOrdL9jFrOogsyWByy3JqS9Il9EAfMV1SQleocIh3SgPqndjtwe5fENMNgC1GnvMp4tLRcIZc6NjoYZXcnZYgBnjs/635kU4eBhJXRg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d920ee82-431e-4bdc-efb7-08ded06f7393
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 15:03:43.1766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wsj0f9m8i6zweMK1dy8SPIfI/W0Kl4uDOQukb+81+T6Cst5PFbco9C5gVbxWAZgDwua7dLDsoguxrDABbGMJ3gll/4oKogE+iLdAQxoIjNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8858
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Prj5PZm4G2rAFxYlVLZiNBDkatik_Jem_fYAfyHpf4M_1782140627
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301144-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:Pier.Beruto@onsemi.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CYYPR02MB9828.namprd02.prod.outlook.com:mid,onsemi.com:dkim,onsemi.com:email,onsemi.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09BDB6B09B1

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBEdW1hemV0IDxl
ZHVtYXpldEBnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gUHJvdGVjdCBz
a2IgcG9pbnRlciB1c2VkIGJ5IHR3byBkaWZmZXJlbnQga2VybmVsIGluc3RhbmNlcw0KPiANCj4g
DQo+ID4NCj4gPiBGaXhlczogYjU0MmQxM2ZhYjBmICgibmV0OiBldGhlcm5ldDogb2FfdGM2OiBJ
bnRlcnJ1cHQgaXMgYWN0aXZlIGxvdywgbGV2ZWwgdHJpZ2dlcmVkLiIpDQo+ID4gU2lnbmVkLW9m
Zi1ieTogU2VsdmFtYW5pIFJhamFnb3BhbCA8U2VsdmFtYW5pLlJhamFnb3BhbEBvbnNlbWkuY29t
Pg0KPiA+IC0tLQ0KPiANCj4gT0sgYnV0IHBsZWFzZSB1c2UgIm5ldDogZXRoZXJuZXQ6IG9hX3Rj
NjoiIHByZWZpeCBpbiB0aGUgcGF0Y2ggdGl0bGUuDQoNCg0KWWVzLiBBbm90aGVyIG1pc3MuIFNv
cnJ5IGFib3V0IHRoYXQuDQo=


