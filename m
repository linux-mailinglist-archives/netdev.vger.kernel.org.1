Return-Path: <netdev+bounces-303460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G8xWAo2URGoIxQoAu9opvQ
	(envelope-from <netdev+bounces-303460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 06:16:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 401E06E9A69
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 06:16:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=YRzMRB8Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303460-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303460-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48212300AC34
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 04:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BB3391838;
	Wed,  1 Jul 2026 04:16:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9CD391E52
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 04:16:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879369; cv=none; b=FrQVfyUus8D51LA+ZPwJzCZNV9BfliGiN0/v1DAumaZ413eVTOq85MEB/iFNRnXNy4RW1RuhyJdYtZO7yueKhPmWoV33fR1MtGqgUn6f5g/5yVYrNfwipNc8cZAGOMDPImwcEoYX2K3YsZBxj3LZQJ5YQ933o/J4S3XkIvLrfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879369; c=relaxed/simple;
	bh=y1o+w0fqHxx91NkbuBWuB/PIjHxlfXnJFcqJ0QMwiAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=qVbNe7j6zmWveSeot87C9kkz/nPzmZfu6E02/7UbPY8RoEIZAWsxA4ckyKytRylPh9A+OUyYYUdPhnePWKWsgFhpwIbkCt1YfZ88dtPFVu9VkjzgMzSnSfXEW1N04IOhWs/oKfyk8ssV8Lz6yNNwla3cVfDWpz/mNKfz8IKte1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=YRzMRB8Z; arc=none smtp.client-ip=170.10.153.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782879363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1o+w0fqHxx91NkbuBWuB/PIjHxlfXnJFcqJ0QMwiAc=;
	b=YRzMRB8ZaPR7JnvaKM6712O3TFF3dllIIMdgMjoPGDGiLs9591wF70b6XecOukh8u5faTA
	f3rA4fEBLfxkXN+nWp5SeJPeVvk4LqkhTKccUNahFdmAsDvhRHjwYDbh2P2eINAnvZ2Sxb
	GmHyRksYgl6y767DFQyMOlXH4C9orCsdereB2iEDwgG3OvGs/fbzOmNlxXDghf4LHs9tjn
	tl0DeF+KcY29PeFPD+kGV0XsWT43FhS9NlxPZ9wcKtfHP+R2+RLpubg4otyEkN8y2oZYED
	NZp+8VQ6+0sKQYa9VN4P8zWR4rkBLLO4qP75+iYXoWBRJC1ZIxhNwGSRVRXlrA==
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-60-bNu1lAQiN6uSqDwRJdgbMQ-1; Tue,
 30 Jun 2026 21:15:59 -0700
X-MC-Unique: bNu1lAQiN6uSqDwRJdgbMQ-1
X-Mimecast-MFC-AGG-ID: bNu1lAQiN6uSqDwRJdgbMQ_1782879356
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by LV4PR02MB11027.namprd02.prod.outlook.com (2603:10b6:408:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 04:15:53 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0159.012; Wed, 1 Jul 2026
 04:15:47 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Selvamani Rajagopal via B4 Relay
	<devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>
Subject: RE: [PATCH net v2 1/2] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Topic: [PATCH net v2 1/2] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Index: AQHdBYF66FssyrlyDECu/NblP7SpALZWYb2AgAAeN2CAATmygIAAWGWg
Date: Wed, 1 Jul 2026 04:15:47 +0000
Message-ID: <CYYPR02MB9828449D5C097154BD04B85083F62@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
	<20260626-fix-race-condition-and-crash-v2-1-b6c5c10e604f@onsemi.com>
	<20260629191553.0a305168@kernel.org>
	<CYYPR02MB9828DBA5FD39F4DB45FC890A83F72@CYYPR02MB9828.namprd02.prod.outlook.com>
 <20260630154647.468076db@kernel.org>
In-Reply-To: <20260630154647.468076db@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|LV4PR02MB11027:EE_
x-ms-office365-filtering-correlation-id: eadb32b9-1910-44d7-399b-08ded7276d9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|38070700021|11063799006|4143699003|56012099006|22082099003|18002099003
x-microsoft-antispam-message-info: 7w6VURUNzRQvhQAcGeNeSxwtsr6yEfx1AkRcLD9/D4+0uRBl8bxnLscgT7cc5RpYHc1XfgzKc5skgjBOb0EN3G8j/ozELIlAzZ6danaVI/VfRN0Xmr7oBNvlqf3j4S9zpPS89AkSiBxsmhuRvwqSTq0FvL/6cEctaVc7pHct5HqGoSsG4B0qltRfr5bjCBLodcw6IzvhtBxymwXHTdBjyFR3cEwXohZMhyrGS9e9vkCUNsLPz5PdJoqg0URLfGu+s2SLMmsN+O7wcKedNVU2pHEuE6BcnCygHfV70JIVnsd+x40yX6ZRKw3H82955jLEF4x9BFxh3YxjMfoIc+/aY1McJksinXaWUJtUuYJuCG2J6LP27n5w2oeVJHTfLtNQbmXhjdoGXU32dsv3cQ7nv3ucsnjknJfWq+GQCOWakxhw3QqQBhfsy+2sK37TUF0cv9pR2pmlFLNfLPSFDf9eA2ZAsc2Wpejoi4eGQhzRdbHvPiJ6w48fWHasUY7pGQmHXfUrC7tcU8v5pNo5IxUW+HNhd3RC54Z/j+aBTGlisYBEM3RnqQoN3yXK4cgZ5Duy1YbPR/RIgXdJ00IY2sDMjVOQGis/oq1czuyn3CYykKMl6xlq2LRYvjeKMe2Gg9A1IqjT9ZZO/+397id8nEXiGCPuZ1R/SaGABVimwomFyl6H9blAq5zQvFsGwK3e52qKBWTwH7txbYNux46aLGTaV7iNDgMwU83R9KWD3IszkmQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFZVUXZSbU51dS9mUmtTNmtIUzJPemFLY3FlUGFYTGlnNkZMRVYwZWFRcTdR?=
 =?utf-8?B?a05RLzE3dlNzbjFKbnJLZzNMektrT01VNmN3ZmNHckRsc0Y4c0Zab3FDeHJN?=
 =?utf-8?B?akZ6TnIwaDlyK0xyci94WjJNMFZOTC9pZU9UL2dDVm1zVUZjdllSUFQ0MG4x?=
 =?utf-8?B?Sy8vamE0VjlDN0l6WU5kUnM0M0ZMUi83M0hOcjFKNjJvOERHQW9DeHFPZmpD?=
 =?utf-8?B?MXRlYVdaWkhORHBpWktqMUozbWIvZXNmeHA2bHRsYUZPRFhxNk5YMDMyeE9T?=
 =?utf-8?B?TzVQTXBPVlpjY3dIbzdHeDNFREwvbkxsWkNVL0cwTDl3cTBmZjV6SmRjZ1Fh?=
 =?utf-8?B?Mk5EYlhJcU5BWHp3RGV6cCtCRmV2WEE2UDR3eHRwNDBnVStuSFJ1VHh6MlZ4?=
 =?utf-8?B?NDAvU2o4cVdPV09XQkZTWEtjNzBUQVhCUk12V3VPWE44ejFqNFo0MVdaemlE?=
 =?utf-8?B?SnNPYVhKcWw0NllLOTBaMWY1WjZNMnNTbnZ3NUNPUy9OMmJLSTJydlRETmVT?=
 =?utf-8?B?Vzg1UGZaaWxSbC9IYkhKczF3c2EzMXZrRUNDUjFMa1laVFFWNG1wWDV1eHkv?=
 =?utf-8?B?QnJROVlQUytKVldFdnNZazk4QWl3a3hOK2ZBQTJjY2xtdDR5bEdadVhOQTQv?=
 =?utf-8?B?bEJoeE1MKzRFaG9UOHVWbU15azJMMGtEVmNlODFMNWN6VDlyTmk4Wm8vcS9x?=
 =?utf-8?B?TFpYYmpwNHMvNFdSSUQvWVYvMmd4ZHBWbmdFb3doTUNJdVM2UncvbXI5VmRK?=
 =?utf-8?B?b0YzYVFTeTJCM2FWYWEyWDlROEVYV0pCZnlHd1A1Q0lNLzNiYktCVCtxeUd0?=
 =?utf-8?B?Ry9mUHl1ZURXdGFJakUxYWRKQ0JEc1BaQTFMNzVrRnBWNyswWG50U0orOHVl?=
 =?utf-8?B?azhSMUUrL3hRcWdkQnJjTnN6SDU0aGVUVE9YTUZEamlubzJ0T2NCblhVMDV0?=
 =?utf-8?B?WGp5N3FrVk9jenlsSTBYa1BTd3crNDlScTdpYktGaXpKckVCUlF1VHNXNnVL?=
 =?utf-8?B?VjRERlVyT1dKMnQwNTNvcEtuQ0VjWE9NWUZLWk50S2txYnpvSGlzNUxZeWxN?=
 =?utf-8?B?NGRXLzlUYTEzYUdJVXpqeTl1R2ZSNUFmQ3kzSFFkMXg1RDhsNjJVb1VZTlgy?=
 =?utf-8?B?cXRRYTVhNFNRVTduQi9NNzZlNE5adnBWZUJYaFptaEdxWEpOYjBWMTlkM0RW?=
 =?utf-8?B?cTJXZ2FkYVd3c0Z5VjVNSGRhOStTa2dGVnplWWwxQWJaaVFZMDI2VmR5ZkhB?=
 =?utf-8?B?V3o1WVFKM3RVSEROS3FoTDNYcWZxcHBHUnlOUERtenNSRi93ZEJSYUdlaUpk?=
 =?utf-8?B?TVh0S09lYUJaT1hiei9meVNuOTc0ak5QWnczWUpUcmN3ODhvaGNaRmpuMGFs?=
 =?utf-8?B?Y2xLQXhMNUt4bkc0aVU2RVNMQ1JKOXlTaDZJNDM4SlhLTHRiWXgveGtuVjkx?=
 =?utf-8?B?eW5QL3lod3pjMzdRd1BsYU02ZWFaWHVqZENlZ284N20yU1oyOUNoWk5iNUM2?=
 =?utf-8?B?T0dKU05OMGorYW5yb2J2UXlEYVhiRENJM1ZodGxSMWhFbGRZeDNoektBM0RV?=
 =?utf-8?B?MCtIWkZDVmFyZitlUXQvZXhOemxuSmdMNmxBQldjSXliSjQrcXZJVDBCZ1cv?=
 =?utf-8?B?RVZ6WUVIdnBvbm93Vkx3RS9JOWVLSkExS2FhV2QrYWRGR3JvNFVTcUUvVlJC?=
 =?utf-8?B?Rndqd0haYm5LU1ZYS092MG00KzJ2WUVjVkRBcW5zSCtzS3ozdnEvZFo4WmNr?=
 =?utf-8?B?VWgyWjJWdVFwandvOGRzUEUxRjZYTGF3c1BYM2J1RnZFeDJyRkwzaFpNVmQ5?=
 =?utf-8?B?N3JYTGpKclIzTG51elhLL285eC9xKzZKekNTZEpwRmZFNDl6VFVFbWNzZlUr?=
 =?utf-8?B?ZXZ4UHlmc1BycHpldjJNS2xESFlCRDdUVk0wZGV0N0s2SkxjbzFnU1g4TW4z?=
 =?utf-8?B?ZkJ3L3pmeU5QcnlEaVpONXE4NHlqaURKR005RSt3ZnVZN0ZSRitZYlllNG9M?=
 =?utf-8?B?cCtKYjZFazB1NzJaSGFQUjJtV0hUUnd6eU11RjZGdEM5SWl2SFZtZVZxTktq?=
 =?utf-8?B?elFRZE12RHkvRzVOa2tRRjNBZW9pYzVsMzM1a3gzSVQrMnhRN3drVE11eTVJ?=
 =?utf-8?B?MGd1dWVKQWl1ZWI0SGVWWC9FNmo5amRGNUhsOUY3Zm1hNDhjSThCR3BzN1NO?=
 =?utf-8?B?NWhnZzh5Mm9Lak5WbUdTc050T0d4TVVBRzF4NFdIdHU4a2ZmN24va0xDMGpu?=
 =?utf-8?B?VXFURW9qeTZ2azl6V3RWR1UxejJrNC9hVUhxV0d0eEZLbWZmQk5VVmRGQ1A4?=
 =?utf-8?B?QmFlRzVoREU1R1ppRFJNRVdxaVU4ZXdnUWpjUytMNXRsaTBaYnFGZz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oUXtEwpJoe048X6D4qqorAIuIUvqbdBwt4XJiIn3+Oimi1nQB6gQs5dQnYXjaEc6KpZOhlzQUosI6fswBRbXBQjkWxC2fILERI65aTXux/2P/TGwzjwIqbIG4XOJLpQok/lUMC8ozxXa0VXNeCrIiFcLdY7e76N0y3iZAT4J811E1cyBDF4WBIdEUs+htBQkypBR+llEbCJH41br0Z/Q0sRGDgeDchVtDrhTTsDPSWNyM5zxPT+u6QCWKLSmDw3KFZcmG2+RNSou8VMf2Xr4ugxdV40UtA19BOp0F3j4Q1zYMhByhktjNozK+wLxQDgn+AyS5UgDRVQntV4QmxTSAQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadb32b9-1910-44d7-399b-08ded7276d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 04:15:47.5429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqd40kM4OUWvkyFNFyENUE8hEXNMCHBnKU8M+MvKlfAXcEcu8/5IfLhVhxLa7gw1MetlSzimfSEpRVDaVXkSZOhnsTk6MR8uIu2P4psds9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR02MB11027
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q3Fw3Q2oSdjvYO-6j0xwIrQ9JpA6QPPeY2FnogAt-7o_1782879356
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303460-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:devnull+Selvamani.Rajagopal.onsemi.com@kernel.org,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:Pier.Beruto@onsemi.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:devnull@kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,Selvamani.Rajagopal.onsemi.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 401E06E9A69

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDMwLCAyMDI2IDM6NDcgUE0NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCBuZXQgdjIgMS8yXSBuZXQ6IGV0aGVybmV0OiBvYV90YzY6IFBy
b3RlY3Qgc2tiIHBvaW50ZXIgdXNlZCBieSB0d28NCj4gZGlmZmVyZW50IGtlcm5lbCBpbnN0YW5j
ZXMNCj4gDQo+ID4gSSBiZWxpZXZlIHhtaXQgcGF0aCBhbmQgSVJRIHRocmVhZCB3b3VsZCBydW4g
aW4gZGlmZmVyZW50IGtlcm5lbA0KPiA+IGluc3RhbmNlcy4gSW1hZ2luZSBvYV90YzZfdHJ5X3Nw
aV90cmFuc2ZlciBjYWxsIGZhaWxzIGluIHRocmVhZGVkDQo+ID4gSVJRLiBJdCB3b3VsZCBzZXQg
ZGlzYWJsZV9pcnEuIElmIHhtaXQgZnVuY3Rpb24gZGlkbid0IHNlZSB0aGF0IHdoZW4NCj4gPiBp
dCBjaGVja2VkLCBidXQgaXQgaXMgc2V0IGJlZm9yZSBwbGFjaW5nIHNrYiBidWZmZXIgaW4gdGhl
DQo+ID4gd2FpdGluZ190eF9za2IgcG9pbnRlciAoZHVlIHRvIHNrYl9saW5lYXJpemUgZm9yIGV4
YW1wbGUpLCB0aGUgc2tiDQo+ID4gd291bGQgYmUgc3R1Y2sgaW4gd2FpdGluZ190eF9za2IuDQo+
IA0KPiBQZXJoYXBzLCBidXQgd291bGRuJ3QgdGhhdCBjYXVzZSBhIHN0YWxsIG5vdCBhIGxlYWs/
DQoNCkkgc2hvdWxkIGhhdmUgbWVudGlvbmVkIGRpc2FibGVfdHJhZmZpYyBmbGFnIGluc3RlYWQg
b2YgZGlzYWJsZV9pcnEsIHRob3VnaA0KSXJxIHdvdWxkIGJlIGRpc2FibGVkIHdoZW4gdGhpcyBm
bGFnIGlzIHNldC4NCg0KT25jZSBpdCBpcyBzZXQsIHRoZXJlIHdvbid0IGJlIGFueW1vcmUgdHJh
ZmZpYywgdW5sZXNzIGRyaXZlciBpcyB1bmxvYWRlZCBhbmQNCnJlbG9hZGVkLiBBdCB0aGlzIHN0
YXRlLCB0eCBxdWV1ZSB3b3VsZCBiZSBibG9ja2VkICBUaGUgc2tiIHBvaW50ZXINCndvdWxkIGJl
IGhlbGQgaW4gd2FpdGluZ190eF9za2IgZm9yIGV2ZXIuIChza2IgbG9zdCBhcyBmYXIgYXMga2Vy
bmVsIGlzIGNvbmNlcm5lZCkNCg0KPiBQbGVhc2UgZG8geW91ciBkaWdnaW5nIGFuZCBzdWJtaXQg
aGlnaCBxdWFsaXR5IHBhdGNoZXMgd2hpY2ggZG9uJ3QNCg0KV2hpbGUgSSBhcHByZWNpYXRlIHlv
dSBzcGVuZGluZyB0aW1lIHRvIHJldmlldyB0aGlzLCBJIGRvIGJlbGlldmUgdGhlIGNoYW5nZXMg
aW4gdGhlIHBhdGNoIA0KaXMgdGhlIHJpZ2h0IGFwcHJvYWNoLiBOb3Qgc3VyZSB3aGF0IEkgYW0g
bWlzc2luZyBoZXJlLg0K


